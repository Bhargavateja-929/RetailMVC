<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet"> 
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-image: url('https://www.shutterstock.com/shutterstock/videos/3471347073/thumb/1.jpg?ip=x480');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: #fff;
            font-family: 'Arial', sans-serif;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        .card-custom {
            background-color: rgba(0, 0, 0, 0.6);
            border: none;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
            margin-top: 150px;
            min-height: 500px;
            border-radius: 10px;
            animation: slideUp 1.5s ease-out;
        }

        @keyframes slideUp {
            0% { transform: translateY(100px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        .card-custom:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .btn-custom {
            width: 200px;
            margin-top: 100px;
            padding: 15px;
            font-size: 18px;
            border-radius: 25px;
            transition: all 0.3s ease;
            animation: fadeInButtons 2s ease-in-out;
        }

        .btn-custom:hover {
            transform: translateY(-5px);
            background-color: #0056b3;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-custom i {
            transition: transform 0.3s ease;
        }

        .btn-custom:hover i {
            transform: translateX(5px);
        }

        @keyframes fadeInButtons {
            0% { opacity: 0; transform: translateY(50px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: #fff;
            font-family: 'Arial', sans-serif;
            font-weight: bold;
            font-size: 4.5rem;
            margin-top: 50px;
            padding-left: 80px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.4);
            animation: fadeInSlideUp 1.5s ease-out;
        }

        @keyframes fadeInSlideUp {
            0% { opacity: 0; transform: translateY(100px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 3rem;
                text-align: center;
                padding-left: 0;
            }

            .card-custom {
                margin-top: 40px;
                padding: 20px;
            }

            .btn-custom {
                width: 100%;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container text-center mt-5">
        <div class="card card-custom p-4 mb-4">
            <div class="row">
                <!-- Left side content -->
                <div class="col-md-6 text-start">
                    <h1>Welcome to Retail Management</h1>
                </div>
                <!-- Right side buttons -->
                <div class="col-md-6 d-flex align-items-center justify-content-center">
                    <div class="d-flex flex-column">
                        <a href="register" class="btn btn-primary btn-custom mb-3">
                            <i class="fas fa-user-plus me-2"></i> Register
                        </a>
                        <a href="login" class="btn btn-secondary btn-custom">
                            <i class="fas fa-sign-in-alt me-2"></i> Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
