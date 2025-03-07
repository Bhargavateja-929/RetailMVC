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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
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
    top: 80px;
    right: 20px;
    width: 500px;
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

/* Product List */
.product-list-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 20px;
}

/* Product & General Card Styling */
.product-card, .card {
    width: 260px;
    min-height: 380px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    text-align: center;
    background: linear-gradient(135deg, #ffffff, #f8f9fa);
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    padding: 15px;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.product-card:hover, .card:hover {
    transform: translateY(-8px);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

/* Image Styling */
.product-card img, .card img {
    width: 100%;
    height: 180px;
    object-fit: contain;
    border-radius: 8px;
    background-color: #f8f9fa;
}

/* Card Body */
.product-card-body {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

/* Title & Price Styling */
.product-card-title, .card h3 {
    font-size: 1.4rem;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.product-card-price {
    font-size: 1.1rem;
    font-weight: 500;
    color: #ff6600;
}

/* Button Styling */
.btn {
    font-weight: bold;
    border-radius: 8px;
    padding: 10px;
    transition: background 0.3s;
}

.btn:hover {
    background: #007bff;
    color: white;
}

/* Responsive Design */
@media (max-width: 768px) {
    .product-list-container {
        flex-direction: column;
        align-items: center;
    }
}

/* Custom Button Styles */
.pay-now-btn, .btn-danger {
    color: white;
    padding: 12px 20px;
    font-size: 18px;
    font-weight: bold;
    border-radius: 8px;
    transition: all 0.3s ease-in-out;
    width: 100%;
    max-width: 300px;
}

.pay-now-btn {
    background-color: #28a745;
}

.pay-now-btn:hover {
    background-color: #218838;
    transform: scale(1.05);
}

.btn-danger {
    background-color: #dc3545;
}

.btn-danger:hover {
    background-color: #c82333;
    transform: scale(1.05);
}

/* Centering Containers */
.pay-now-container, .clear-cart-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 20vh;
    text-align: center;
}

/* Cart Styles */
.cart-container {
    width: 60%;
    margin: 30px auto;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.cart-header {
    font-size: 1.8rem;
    font-weight: bold;
    padding-bottom: 10px;
    border-bottom: 2px solid #ddd;
    text-align: center;
}

/* Cart Item */
.cart-item {
    display: flex;
    align-items: center;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
}

.cart-item-img {
    width: 80px;
    height: 80px;
    object-fit: contain;
    margin-right: 20px;
}

/* Cart Details */
.cart-item-details {
    flex-grow: 1;
}

.cart-item-name {
    font-size: 1.2rem;
    font-weight: bold;
}

.cart-item-price {
    color: #b12704;
    font-size: 1.1rem;
}

.cart-item-quantity {
    font-size: 1rem;
    color: #555;
}

/* Cart Summary */
.cart-summary {
    margin-top: 20px;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 8px;
    text-align: center;
    font-size: 1.2rem;
    font-weight: bold;
}

/* Alert Messages */
.alert-container {
    width: 50%;
    margin: 20px auto;
    text-align: center;
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

		
		<!-- Alerts -->
            <div id="alert-container"></div>
            
        <!-- Main Content -->
        <div class="content-area">
            

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
			    <h3 class="cart-header">Shopping Cart</h3>
			
			    <div id="cart-items">
			        <c:forEach var="item" items="${cartItems}">
			            <div class="cart-item">
			                <img src="${item.imageUrl}" alt="${item.productName}" class="cart-item-img">
			                <div class="cart-item-details">
			                    <h5 class="cart-item-name">${item.productName}</h5>
			                    <p class="cart-item-price">₹${item.price}</p>
			                    <p class="cart-item-quantity">Quantity: ${item.quantity}</p>
			                    <button class="btn btn-danger btn-sm" onclick="removeItem(${item.id})">Remove</button>
			                </div>
			            </div>
			        </c:forEach>
			    </div>
			
			    <!-- Order Summary -->
			    <div class="cart-summary">
			        <p><strong>Total Price:</strong> ₹<span id="total-price">${totalPrice}</span></p>
			        <button onclick="clearCart()" class="btn btn-danger btn-lg btn-block">Clear Cart</button>
			      
			    </div>
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
                
                <div class="container">
                    <div class="row">
                       <div class="col-12 pay-now-container">
                           <button type="submit" class="btn pay-now-btn">Pay Now</button>
                       </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>

    <script>
 // Function to show Bootstrap Alerts
    function showBootstrapAlert(message, type) {
            const alertHtml = `
                <div class="alert alert-${type} alert-dismissible fade show text-center" role="alert">
                    <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i> 
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            `;

            // Append the alert to the alert container
            $("#alert-container").html(alertHtml);

            // Auto close the alert after 3 seconds
            setTimeout(() => {
                $(".alert").alert('close');
            }, 2000);
        }
    
    
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
                
                let cartItems = []; // Initialize cart items array
                
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

                    // Push order details into cartItems array
                    cartItems.push({
                        productName: order.productName,
                        price: order.price,
                        quantity: order.quantity
                    });
                });

                // Call updateCartUI with the cartItems
                updateCartUI(cartItems);
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
            data: JSON.stringify({ productName: productName, price: price, quantity: 1 }),
            success: function (updatedCart) {
                showBootstrapAlert(`${productName} added to cart!`, "success");
                updateCartUI(updatedCart);
            },
            error: function (xhr, status, error) {
                showBootstrapAlert("Error adding item to cart.", "danger");
            }
        });
    }


    function clearCart() {
        $.ajax({
            url: "cart",
            type: "DELETE",
            success: function(response) {
                showBootstrapAlert("Cart cleared successfully!", "warning");
                showCart(); // Refresh cart after clearing
            },
            error: function(error){
               
                showBootstrapAlert("Error clearing cart", "danger");
            }
        });
    }

    
    $(document).ready(function () {
        $(".pay-now-btn").click(function () {
            let cartItemsCount = $("#cart-items li").length; // Correct way to count items in the cart

            if (cartItemsCount === 0) {
                showBootstrapAlert("Your cart is empty! 🛒 Go and buy some products.", "warning");
            } else {
                showBootstrapAlert("Order placed successfully! 🎉 Thank you for shopping.", "success");
            }
        });
    }); 

</script>
    

</body>
</html>