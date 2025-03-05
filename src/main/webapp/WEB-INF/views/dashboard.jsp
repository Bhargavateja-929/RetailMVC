<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false" %>
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
                <h2>Welcome to Retail Dashboard</h2>
                <h4>Explore products, manage your cart, and place orders!</h4>
                
                <!-- <div class="row" id="product-list">
                    Products will be dynamically inserted here
                </div> -->
            </div>

            <!-- Product List -->
            <div id="product-list" class="product-list">
                <h3>Product List</h3>
                <table class="table table-bordered">
                    <thead class="table-primary">
                        <tr>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.name}</td>
                                <td>₹${product.price}</td>
                                <td>${product.quantity}</td>
                                <td>
                                    <button onclick="addToCart('${product.name}', ${product.price})" class="btn btn-success">Add to Cart</button>
                                </td>
                            </tr>
                        </c:forEach>
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
                <strong>Total: ₹<span id="total-price">${totalPrice}</span></strong>
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
    /* $(document).ready(function () {
        loadProducts();  // Load products on page load
        loadCart();      // Load cart on page load
        loadOrders();    // Load orders on page load
    }); */

    function showProducts() {
        $(".content-area > div").hide();
        $("#product-list").show();
        
        $.ajax({
            url: "products",
            type: "GET",
            dataType: "json",
            success: function (data) {
                let tableBody = $("#product-list tbody");
                tableBody.empty();
                $.each(data, function (index, product) {
                    tableBody.append(`
                        <tr>
                            <td>${product.name}</td>
                            <td>₹${product.price}</td>
                            <td>${product.quantity}</td>
                            <td>
                                <button onclick="addToCart('${product.name}', ${product.price})" class="btn btn-success">Add to Cart</button>
                            </td>
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
            dataType: "json",
            success: function (data) {
                let cartElement = $("#cart-items");
                let totalPrice = 0;
                cartElement.empty();
                $.each(data, function (index, item) {
                    totalPrice += item.price * item.quantity;
                    cartElement.append(`
                        <li>${item.productName} - ₹${item.price} x ${item.quantity}</li>
                    `);
                });
                $("#total-price").text(totalPrice.toFixed(2));
            },
            error: function () {
                console.error("Error fetching cart items.");
            }
        });
    }

    function showOrders() {
        $(".content-area > div").hide();
        $("#orders").show();
        
        $.ajax({
            url: "orders",
            type: "GET",
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
        $.post("cart", { productName, price }, function () {
            alert(productName + " added to cart!");
            loadCart(); // Refresh cart after adding an item
        });
    }

    function clearCart() {
        $.post("cart", function () {
            alert("Cart cleared!");
            loadCart(); // Refresh cart after clearing
        });
    }
</script>
    

</body>
</html>
