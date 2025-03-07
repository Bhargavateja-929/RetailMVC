<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100%;
            margin-top: 130px;
            background-image: url('https://www.shutterstock.com/shutterstock/videos/3471347073/thumb/1.jpg?ip=x480');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: #fff;
            font-family: 'Arial', sans-serif;
            animation: fadeIn 1.5s ease-out;
        }

        .container {
            background-color: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            max-width: 700px;
            margin: auto;
            transform: translateY(50px);
            color: #fff;
            animation: slideUp 1s ease-out;
        }

        h2 {
            text-align: center;
            font-size: 2.5rem;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.6);
        }

        .form-label {
            font-size: 1.1rem;
        }

        .btn-custom {
            width: 100%;
            padding: 15px;
            font-size: 18px;
            margin-top: 15px;
        }

        .alert {
            font-size: 1rem;
            margin-top: 20px;
            display: none; /* Initially hidden */
        }

        .btn-custom i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>

        <!-- Display error message if login fails -->
        <c:if test="${not empty error}">
            <div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error:</strong> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Login Form -->
        <form id="loginForm">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-custom">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $("#loginForm").on("submit", function(event) {
            event.preventDefault(); // Prevent default form submission

            var formData = $(this).serialize();

            $.ajax({
                url: "login",
                type: "POST",
                data: formData,
                dataType: "json", 
                success: function(response) {
                    if (response.status === "success") {
                        window.location.href = response.redirectUrl;  // Redirect to dashboard
                    } else {
                        $("#errorAlert").html(
                            '<strong>Error:</strong> ' + response.message +
                            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>'
                        ).css("display", "block").addClass("show");

                        setTimeout(function() { $("#errorAlert").fadeOut(); }, 5000);
                    }
                },
                error: function() {
                    $("#errorAlert").html(
                        '<strong>Error:</strong> An error occurred. Please try again.' +
                        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>'
                    ).css("display", "block").addClass("show");

                    setTimeout(function() { $("#errorAlert").fadeOut(); }, 5000);
                }
            });
        });
    });
</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>