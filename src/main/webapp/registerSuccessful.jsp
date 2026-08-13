<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import = "com.tap.model.user" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="2;url=login.jsp">

    <title>Registration Successful</title>

    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Outfit',sans-serif;
        }

        body{

            min-height:100vh;

            display:flex;

            justify-content:center;

            align-items:center;

            background:#0b0c10;

            overflow:hidden;

            position:relative;

        }

        body::before{

            content:"";

            position:absolute;

            width:650px;
            height:650px;

            top:-220px;
            left:-220px;

            background:radial-gradient(circle,
            rgba(255,90,54,.18),
            transparent 70%);

            animation:move1 12s infinite alternate;

        }

        body::after{

            content:"";

            position:absolute;

            width:550px;
            height:550px;

            right:-180px;
            bottom:-180px;

            background:radial-gradient(circle,
            rgba(236,72,153,.18),
            transparent 70%);

            animation:move2 12s infinite alternate;

        }

        @keyframes move1{

            from{
                transform:translate(0,0);
            }

            to{
                transform:translate(120px,80px);
            }

        }

        @keyframes move2{

            from{
                transform:translate(0,0);
            }

            to{
                transform:translate(-120px,-80px);
            }

        }

        .container{

            position:relative;

            z-index:5;

            width:100%;

            display:flex;

            justify-content:center;

            align-items:center;

            padding:30px;

        }

        .card{

            width:500px;

            background:rgba(26,31,44,.90);

            border:1px solid rgba(255,255,255,.08);

            backdrop-filter:blur(18px);

            border-radius:24px;

            padding:45px;

            text-align:center;

            box-shadow:
            0 20px 50px rgba(0,0,0,.45),
            0 0 25px rgba(255,90,54,.12);

        }

        .success-icon{

            width:120px;

            height:120px;

            margin:auto;

            margin-bottom:30px;

            border-radius:50%;

            display:flex;

            justify-content:center;

            align-items:center;

            font-size:55px;

            color:white;

            background:linear-gradient(135deg,#10b981,#34d399);

            box-shadow:0 0 35px rgba(16,185,129,.45);

            animation:pop .8s ease;

        }

        @keyframes pop{

            0%{

                transform:scale(.4);

                opacity:0;

            }

            100%{

                transform:scale(1);

                opacity:1;

            }

        }

        h1{

            color:white;

            font-size:34px;

            margin-bottom:15px;

        }

        h3,p{

            color:#b9c0ca;

            font-size:17px;

            line-height:30px;

            margin-bottom:35px;

        }

        .btn{

            display:inline-block;

            text-decoration:none;

            color:white;

            font-size:17px;

            font-weight:700;

            padding:15px 45px;

            border-radius:50px;

            background:linear-gradient(135deg,#ff5a36,#ec4899);

            transition:.35s;

            box-shadow:0 10px 25px rgba(255,90,54,.30);

        }

        .btn:hover{

            transform:translateY(-4px);

            box-shadow:0 15px 35px rgba(255,90,54,.45);

        }

        .logo{

            color:#ff5a36;

            font-size:22px;

            font-weight:800;

            margin-bottom:25px;

        }

        @media(max-width:600px){

            .card{

                width:100%;

                padding:35px;

            }

            h1{

                font-size:28px;

            }

        }

    </style>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="index.css">
</head>

<body>

    <!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
    <div class="top-back-bar" style="position: absolute; top: 20px; left: 20px; z-index: 100;">
        <a href="login.jsp" class="btn-back-nav" id="backToLoginBtn">
            <i class="fa-solid fa-arrow-left"></i> <span>Login</span>
        </a>
    </div>

<div class="container">

    <div class="card">

        <div class="logo">

            🍔 TappyFood

        </div>

        <div class="success-icon">

            ✓

        </div>

        <h1>

            Registration Successful!
  

        </h1>
        
		
        <p>

            Congratulations! Your account has been created successfully.

            You can now log in and start exploring delicious meals from your favourite restaurants.

        </p>

        <a href="login.jsp" class="btn">

            Continue to Login

        </a>

    </div>

</div>

</body>

</html>