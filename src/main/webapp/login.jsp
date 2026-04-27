<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Orphanage Management — Login</title>
    <meta name="description" content="Sign in to the Orphanage Management System." />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* ---- Reset & Base ---- */
        *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
        html { font-size:16px; scroll-behavior:smooth; -webkit-font-smoothing:antialiased; }
        body {
            font-family:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:2rem;
            background:
                radial-gradient(ellipse at 20% 50%, rgba(139,92,246,.14) 0%, transparent 50%),
                radial-gradient(ellipse at 80% 20%, rgba(249,115,22,.10) 0%, transparent 50%),
                radial-gradient(ellipse at 50% 100%, rgba(59,130,246,.08) 0%, transparent 50%),
                linear-gradient(135deg, #f5f3ff 0%, #f9fafb 50%, #fff7ed 100%);
            position:relative;
            overflow:hidden;
        }
        /* ---- Animated blobs ---- */
        body::before, body::after {
            content:''; position:absolute; border-radius:50%; filter:blur(80px); opacity:.5; pointer-events:none;
        }
        body::before {
            width:500px; height:500px; background:rgba(139,92,246,.12); top:-150px; right:-100px;
            animation:blobFloat 8s ease-in-out infinite;
        }
        body::after {
            width:400px; height:400px; background:rgba(249,115,22,.10); bottom:-100px; left:-100px;
            animation:blobFloat 10s ease-in-out infinite reverse;
        }
        @keyframes blobFloat {
            0%,100% { transform:translateY(0) rotate(0deg); }
            50%     { transform:translateY(-20px) rotate(3deg); }
        }
        @keyframes fadeUp {
            from { opacity:0; transform:translateY(24px); }
            to   { opacity:1; transform:translateY(0); }
        }
        /* ---- Container ---- */
        .auth-wrap {
            position:relative; z-index:1; width:100%; max-width:420px;
        }
        /* ---- Header ---- */
        .auth-brand { text-align:center; margin-bottom:1.75rem; }
        .auth-brand .icon-box {
            width:68px; height:68px;
            background:linear-gradient(135deg,#8b5cf6,#6d28d9);
            border-radius:16px;
            display:inline-flex; align-items:center; justify-content:center;
            margin-bottom:.75rem;
            box-shadow:0 8px 24px rgba(124,58,237,.3);
            animation:fadeUp .6s cubic-bezier(.4,0,.2,1) forwards;
        }
        .auth-brand .icon-box span { font-size:1.85rem; filter:drop-shadow(0 2px 4px rgba(0,0,0,.1)); }
        .auth-brand h1 {
            font-size:1.45rem; font-weight:700; color:#111827; letter-spacing:-.02em;
            animation:fadeUp .6s cubic-bezier(.4,0,.2,1) .1s forwards; opacity:0;
        }
        .auth-brand p {
            color:#6b7280; font-size:.88rem; margin-top:.2rem;
            animation:fadeUp .6s cubic-bezier(.4,0,.2,1) .15s forwards; opacity:0;
        }
        /* ---- Card ---- */
        .auth-card {
            background:rgba(255,255,255,.88);
            backdrop-filter:blur(20px); -webkit-backdrop-filter:blur(20px);
            border:1px solid rgba(255,255,255,.6);
            border-radius:24px;
            padding:2.25rem 2rem 2.5rem;
            box-shadow:0 20px 60px rgba(0,0,0,.06), 0 1px 3px rgba(0,0,0,.04), 0 0 40px rgba(139,92,246,.12);
            animation:fadeUp .6s cubic-bezier(.4,0,.2,1) .2s forwards; opacity:0;
        }
        .auth-card h2 {
            font-size:1.3rem; font-weight:700; color:#111827; margin-bottom:1.5rem;
            text-align:center; letter-spacing:-.01em;
        }
        /* ---- Alerts ---- */
        .msg-box {
            display:flex; align-items:center; gap:.6rem;
            padding:.7rem 1rem; border-radius:8px; font-size:.84rem; font-weight:500;
            margin-bottom:1.25rem; line-height:1.4;
        }
        .msg-box.success { background:#d1fae5; color:#065f46; border:1px solid #a7f3d0; }
        .msg-box.error   { background:#fee2e2; color:#ef4444; border:1px solid #fecaca; }
        .msg-box .msg-icon { font-size:1rem; flex-shrink:0; line-height:1; }
        /* ---- Form Groups ---- */
        .fg { margin-bottom:1.05rem; }
        .fg label {
            display:block; font-size:.76rem; font-weight:600; color:#4b5563;
            margin-bottom:.35rem; letter-spacing:.04em; text-transform:uppercase;
        }
        .input-box {
            position:relative; display:flex; align-items:center;
        }
        .input-box .ico {
            position:absolute; left:.85rem; font-size:.95rem; opacity:.45; pointer-events:none; z-index:2; line-height:1;
        }
        .input-box input {
            width:100%; padding:.82rem 1rem .82rem 2.6rem;
            font-family:inherit; font-size:.92rem; color:#1f2937;
            background:rgba(255,255,255,.7); border:1.5px solid #e5e7eb;
            border-radius:12px; outline:none;
            transition:border .2s, box-shadow .2s, background .2s;
        }
        .input-box input:focus {
            background:#fff; border-color:#a78bfa;
            box-shadow:0 0 0 4px rgba(139,92,246,.1);
        }
        .input-box input::placeholder { color:#9ca3af; }
        /* Toggle password */
        .pw-toggle {
            position:absolute; right:.6rem; background:none; border:none; cursor:pointer;
            font-size:1rem; opacity:.4; transition:opacity .2s; padding:.3rem; z-index:2;
            display:flex; align-items:center; line-height:1;
            box-shadow:none!important;
        }
        .pw-toggle:hover { opacity:.7; transform:none; box-shadow:none!important; background:none; }
        /* ---- Button ---- */
        .btn-submit {
            width:100%; padding:.92rem; margin-top:.6rem;
            font-family:inherit; font-size:1rem; font-weight:600;
            color:#fff; border:none; border-radius:12px; cursor:pointer;
            background:linear-gradient(135deg,#7c3aed,#6d28d9);
            box-shadow:0 4px 16px rgba(124,58,237,.35);
            display:inline-flex; align-items:center; justify-content:center; gap:.5rem;
            letter-spacing:.02em; position:relative; overflow:hidden;
            transition:transform .2s, box-shadow .2s;
        }
        .btn-submit::after {
            content:''; position:absolute; inset:0;
            background:linear-gradient(135deg,rgba(255,255,255,.12),transparent);
            opacity:0; transition:opacity .3s;
        }
        .btn-submit:hover { transform:translateY(-1px); box-shadow:0 6px 24px rgba(124,58,237,.45); }
        .btn-submit:hover::after { opacity:1; }
        .btn-submit:active { transform:translateY(0); }
        .btn-submit .arrow { transition:transform .2s; font-size:1.1rem; }
        .btn-submit:hover .arrow { transform:translateX(3px); }
        /* ---- Footer link ---- */
        .auth-footer {
            text-align:center; margin-top:1.25rem; font-size:.875rem; color:#6b7280;
        }
        .auth-footer a {
            color:#7c3aed; font-weight:600; text-decoration:none; transition:color .2s;
        }
        .auth-footer a:hover { color:#6d28d9; text-decoration:underline; }
        /* ---- Responsive ---- */
        @media(max-width:480px){
            body{padding:1rem;}
            .auth-card{padding:1.75rem 1.25rem 2rem; border-radius:18px;}
            .auth-brand h1{font-size:1.25rem;}
        }
    </style>
</head>
<body>

<div class="auth-wrap">
    <div class="auth-brand">
        <div class="icon-box"><span>&#x1F3E0;</span></div>
        <h1>Orphanage Management System</h1>
        <p>Welcome back! Please sign in to continue.</p>
    </div>

    <div class="auth-card">
        <h2>Sign In</h2>

        <%-- Success: after registration --%>
        <c:if test="${param.msg == 'registered'}">
            <div class="msg-box success">
                <span class="msg-icon">&#x2705;</span>
                Account created successfully! Please sign in.
            </div>
        </c:if>
        <c:if test="${param.msg == 'logged_out'}">
            <div class="msg-box success">
                <span class="msg-icon">&#x1F44B;</span>
                You have been logged out successfully.
            </div>
        </c:if>

        <%-- Errors --%>
        <c:if test="${not empty error}">
            <div class="msg-box error">
                <span class="msg-icon">&#x26A0;</span>
                <c:out value="${error}" />
            </div>
        </c:if>

        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" autocomplete="on">
            <div class="fg">
                <label for="email">Email Address</label>
                <div class="input-box">
                    <input type="email" id="email" name="email"
                           placeholder="you@example.com"
                           value="<c:out value='${param.email}' default='' />"
                           autocomplete="email" required
                           style="padding-left:1rem;" />
                </div>
            </div>

            <div class="fg">
                <label for="password">Password</label>
                <div class="input-box">
                    <input type="password" id="password" name="password"
                           placeholder="Enter your password"
                           autocomplete="current-password" required
                           style="padding-left:1rem;" />
                    <button type="button" class="pw-toggle" onclick="togglePw('password',this)" aria-label="Show password">
                        <span>&#x1F441;</span>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn-submit" id="loginBtn">
                <span>Sign In</span>
                <span class="arrow">&#x2192;</span>
            </button>

            <p class="auth-footer">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Create one</a>
            </p>
        </form>
    </div>
</div>

<script>
function togglePw(id,btn){
    var f=document.getElementById(id);
    if(f.type==='password'){f.type='text';btn.querySelector('span').innerHTML='&#x1F441;&#x200D;&#x1F5E8;';}
    else{f.type='password';btn.querySelector('span').innerHTML='&#x1F441;';}
}
</script>
</body>
</html>