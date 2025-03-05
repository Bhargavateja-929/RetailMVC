<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Restrict access to logged-in users
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Retail Management Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Sidebar */
        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, #2b5876, #4e4376);
            padding-top: 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        /* Main Content */
        .content-area {
            flex-grow: 1;
            padding: 20px;
            margin-left: 250px;
        }

        /* Dashboard Headings */
        h2, h4 {
            text-align: center;
        }

        /* Alerts */
        #alert-container {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 300px;
            z-index: 1050;
        }

        .alert {
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 5px;
        }

        /* Hide sections initially */
        .product-list, .cart, .orders {
            display: none;
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h3 class="text-center text-white">Retail Dashboard</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link text-white" href="dashboard">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#" onclick="showProducts()">
                        <i class="fas fa-list"></i> Product List
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#" onclick="showCart()">
                        <i class="fas fa-cart-plus"></i> View Cart
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#" onclick="showOrders()">
                        <i class="fas fa-truck"></i> Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content-area">
            <!-- Alerts -->
            <div id="alert-container"></div>

            <!-- Dashboard Home -->
            <div id="dashboard-home">
               <h2>Welcome to the Retail Dashboard</h2>
                <h4>Browse and select your products in the Product section to begin your journey!</h4>
                <h4>🛒 Happy Shopping! 😊</h4>
                
                 <div class="row" id="product-list">
                    Products will be dynamically inserted here
                </div> 
            </div>

            <!-- Product List -->
			<div id="product-list-container" class="product-list-container d-none">
			    <h3>Product List</h3>
			    <table class="table table-bordered">
			        <thead class="table-primary">
			            <tr>
			                <th>Product Name</th>
			                <th>Price</th>
			                <th>Quantity</th>
			                <th>Expiry Date</th>
			            </tr>
			        </thead>
			        <tbody>
			            <!-- Products will be dynamically loaded here -->
			        </tbody>
			    </table>
			</div>


            <!-- Cart Section -->
            <div id="cart" class="cart">
                <h3>Your Cart</h3>
                <ul id="cart-items">
				    <c:forEach var="item" items="${cartItems}">
				        <li>${item.productName} - ₹${item.price} x ${item.quantity}</li>
				    </c:forEach>
				</ul>
				<p>Total Price: ₹<span id="total-price">${totalPrice}</span></p>
                <button onclick="clearCart()" class="btn btn-danger">Clear Cart</button>
            </div>

            <!-- Orders Section -->
            <div id="orders" class="orders">
                <h3>Order Details</h3>
                <table class="table table-bordered">
                    <thead class="table-primary">
                        <tr>
                            <th>Order ID</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.id}</td>
                                <td>${order.productName}</td>
                                <td>${order.quantity}</td>
                                <td>₹${order.price * order.quantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function () {
        $.ajax({
            url: 'products',
            type: 'GET',
            contentType: "application/json",
            dataType: 'json',
            success: function (data) {
                renderProducts(data);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching products:', error);
            }
        });
    });

    function renderProducts(products) {
        const productList = $('#product-list');
        productList.empty();
        products.forEach(product => {
            const productCard = `
                <div class="col-md-3 mb-4">
                    <div class="card">
                        <img src="${product.imageUrl}" alt="${product.name}" class="card-img-top">
                        <div class="card-body">
                            <h3 class="card-title">${product.name}</h3>
                            <p><strong>Price:</strong> ${product.price.toFixed(2)}</p>
                            <button onclick="addToCart('${product.name}', ${product.price})" class="btn btn-primary">Add to Cart</button>
                        </div>
                    </div>
                </div>
            `;
            productList.append(productCard);
        });
    }

    function showProducts() {
        $(".content-area > div").hide();
        $("#product-list-container").show();
        $("#product-list-container").removeClass("d-none");

        $.ajax({
            url: "products-lists",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            success: function (data) {
                let tableBody = $("#product-list-container tbody");
                tableBody.empty();
                $.each(data, function (index, product) {
                    tableBody.append(`
                        <tr>
                            <td>${product.productName}</td>
                            <td>₹${product.price}</td>
                            <td>${product.quantity}</td>
                            <td>${product.expireDate}</td>
                        </tr>
                    `);
                });
            },
            error: function () {
                console.error("Error fetching products.");
            }
        });
    }

    function showCart() {
        $(".content-area > div").hide();
        $("#cart").show();
        
        $.ajax({
            url: "cart",
            type: "GET",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                updateCartUI(data); // Use the new function to update UI
            },
            error: function () {
                console.error("Error fetching cart items.");
            }
        });
    }

    function updateCartUI(cartItems) {
        let cartElement = $("#cart-items");
        let totalPrice = 0;
        cartElement.empty();
        
        $.each(cartItems, function (index, item) {
            totalPrice += item.price * item.quantity;
            cartElement.append(`
                <li>${item.productName} - ₹${item.price} x ${item.quantity}</li>
            `);
        });

        $("#total-price").text(totalPrice.toFixed(2));
    }
    
    function showOrders() {
        $(".content-area > div").hide();
        $("#orders").show();
        
        $.ajax({
            url: "orders",
            type: "GET",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                let orderTable = $("#orders tbody");
                orderTable.empty();
                $.each(data, function (index, order) {
                    let totalPrice = order.price * order.quantity;
                    orderTable.append(`
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.productName}</td>
                            <td>${order.quantity}</td>
                            <td>₹${totalPrice}</td>
                        </tr>
                    `);
                });
            },
            error: function () {
                console.error("Error fetching orders.");
            }
        });
    }

    function addToCart(productName, price) {
        $.ajax({
            url: "cart",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ productName: productName, price: price, quantity: 1 }), // Ensure quantity is included
            success: function (updatedCart) { // Receive updated cart from backend
                alert(productName + " added to cart!");
                updateCartUI(updatedCart); // Update UI immediately
            },
            error: function (xhr, status, error) {
                console.error("Error adding item to cart:", xhr.responseText);
            }
        });
    }



    function clearCart() {
        $.ajax({
            url: "cart",
            type: "DELETE",
            success: function(response) {
                alert("Cart cleared!");
                showCart(); // Refresh cart after clearing
            },
            error: function(error){
                console.error("Error clearing cart: ", error);
                alert("Error clearing cart");
            }
        });

    }
</script>
    

</body>
</html>
