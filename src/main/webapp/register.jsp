<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Orphanage Management — Register</title>
    <meta name="description" content="Create an account for the Orphanage Management System." />
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
            0%,100%{transform:translateY(0) rotate(0deg);}
            50%{transform:translateY(-20px) rotate(3deg);}
        }
        @keyframes fadeUp {
            from{opacity:0;transform:translateY(24px);}
            to{opacity:1;transform:translateY(0);}
        }
        /* ---- Container ---- */
        .auth-wrap { position:relative; z-index:1; width:100%; max-width:540px; }
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
        .auth-brand .icon-box svg { width:32px; height:32px; filter:drop-shadow(0 2px 4px rgba(0,0,0,.1)); }
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
        .msg-box.error { background:#fee2e2; color:#ef4444; border:1px solid #fecaca; }
        .msg-box .msg-icon { flex-shrink:0; line-height:1; display:flex; align-items:center; }
        .msg-box .msg-icon svg { width:16px; height:16px; }
        /* ---- Form Groups ---- */
        .fg { margin-bottom:1.05rem; flex:1; min-width:0; }
        .fg label {
            display:block; font-size:.76rem; font-weight:600; color:#4b5563;
            margin-bottom:.35rem; letter-spacing:.04em; text-transform:uppercase;
        }
        .fg label .req { color:#ef4444; margin-left:2px; }
        .input-box { position:relative; display:flex; align-items:center; }
        .input-box input, .input-box select {
            width:100%; padding:.82rem 1rem;
            font-family:inherit; font-size:.92rem; color:#1f2937;
            background:rgba(255,255,255,.7); border:1.5px solid #e5e7eb;
            border-radius:12px; outline:none;
            transition:border .2s, box-shadow .2s, background .2s;
        }
        .input-box input:focus, .input-box select:focus {
            background:#fff; border-color:#a78bfa;
            box-shadow:0 0 0 4px rgba(139,92,246,.1);
        }
        .input-box input::placeholder { color:#9ca3af; }
        .input-box select {
            appearance:none; -webkit-appearance:none; cursor:pointer;
            background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%236b7280' viewBox='0 0 16 16'%3E%3Cpath d='M1.5 5.5l6.5 6.5 6.5-6.5'/%3E%3C/svg%3E");
            background-repeat:no-repeat; background-position:right 1rem center;
            padding-right:2.5rem;
        }
        /* Toggle password */
        .pw-toggle {
            position:absolute; right:.6rem; background:none; border:none; cursor:pointer;
            opacity:.4; transition:opacity .2s; padding:.3rem; z-index:2;
            display:flex; align-items:center; line-height:1; box-shadow:none!important;
        }
        .pw-toggle:hover { opacity:.7; transform:none; box-shadow:none!important; background:none; }
        .pw-toggle svg { width:18px; height:18px; }
        /* ---- Row (2-col grid) ---- */
        .form-row { display:grid; grid-template-columns:1fr 1fr; gap:1rem; }
        /* ---- Hint text ---- */
        .hint { display:block; font-size:.72rem; color:#9ca3af; margin-top:.25rem; padding-left:.15rem; }
        /* ---- Divider ---- */
        .divider { height:1px; background:linear-gradient(90deg,transparent,#e5e7eb,transparent); margin:.6rem 0 1.1rem; }
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
        .btn-submit .arrow { transition:transform .2s; display:flex; align-items:center; }
        .btn-submit:hover .arrow { transform:translateX(3px); }
        .btn-submit .arrow svg { width:18px; height:18px; }
        /* ---- Footer link ---- */
        .auth-footer {
            text-align:center; margin-top:1.25rem; font-size:.875rem; color:#6b7280;
        }
        .auth-footer a {
            color:#7c3aed; font-weight:600; text-decoration:none; transition:color .2s;
        }
        .auth-footer a:hover { color:#6d28d9; text-decoration:underline; }
        /* ---- Responsive ---- */
        @media(max-width:600px){
            body{padding:1rem;}
            .auth-card{padding:1.75rem 1.25rem 2rem; border-radius:18px;}
            .auth-brand h1{font-size:1.25rem;}
            .auth-wrap{max-width:100%;}
            .form-row{grid-template-columns:1fr; gap:0;}
        }
    </style>
</head>
<body>

<div class="auth-wrap">
    <div class="auth-brand">
        <div class="icon-box"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="#fff"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955a1.126 1.126 0 011.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"/></svg></div>
        <h1>Join Our Mission</h1>
        <p>Create an account to make a difference today.</p>
    </div>

    <div class="auth-card">
        <h2>Create Account</h2>

        <c:if test="${not empty error}">
            <div class="msg-box error">
                <span class="msg-icon"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/></svg></span>
                <c:out value="${error}" />
            </div>
        </c:if>

        <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" autocomplete="on">

            <div class="form-row">
                <div class="fg">
                    <label for="fullName">Full Name <span class="req">*</span></label>
                    <div class="input-box">
                        <input type="text" id="fullName" name="fullName" placeholder="Enter your full name"
                               value="<c:out value='${param.fullName}' default='' />"
                               autocomplete="name" required />
                    </div>
                </div>
                <div class="fg">
                    <label for="regEmail">Email Address <span class="req">*</span></label>
                    <div class="input-box">
                        <input type="email" id="regEmail" name="email" placeholder="you@example.com"
                               value="<c:out value='${param.email}' default='' />"
                               autocomplete="email" required />
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="fg">
                    <label for="phone">Phone Number</label>
                    <div class="input-box">
                        <input type="tel" id="phone" name="phone"
                               placeholder="Optional"
                               value="<c:out value='${param.phone}' default='' />"
                               autocomplete="tel" />
                    </div>
                </div>
                <div class="fg">
                    <label for="role">I want to join as <span class="req">*</span></label>
                    <div class="input-box">
                        <select id="role" name="role" required>
                            <option value="DONOR" ${param.role == 'DONOR' ? 'selected' : ''}>Donor</option>
                            <option value="VOLUNTEER" ${param.role == 'VOLUNTEER' ? 'selected' : ''}>Volunteer</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="divider"></div>

            <div class="form-row">
                <div class="fg">
                    <label for="regPassword">Password <span class="req">*</span></label>
                    <div class="input-box">
                        <input type="password" id="regPassword" name="password"
                               placeholder="Create a password"
                               autocomplete="new-password" required />
                        <button type="button" class="pw-toggle" onclick="togglePw('regPassword',this)" aria-label="Show password">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                        </button>
                    </div>
                    <span class="hint">Minimum 9 characters</span>
                </div>
                <div class="fg">
                    <label for="cpassword">Confirm Password <span class="req">*</span></label>
                    <div class="input-box">
                        <span class="ico"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z"/></svg></span>
                        <input type="password" id="cpassword" name="cpassword"
                               placeholder="Re-enter password"
                               autocomplete="new-password" required />
                        <button type="button" class="pw-toggle" onclick="togglePw('cpassword',this)" aria-label="Show password">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                        </button>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn-submit" id="registerBtn">
                <span>Create Account</span>
                <span class="arrow"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"/></svg></span>
            </button>

            <p class="auth-footer">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </p>
        </form>
    </div>
</div>

<script>
function togglePw(id,btn){
    var f=document.getElementById(id);
    if(f.type==='password'){
        f.type='text';
        btn.innerHTML='<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>';
    } else {
        f.type='password';
        btn.innerHTML='<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>';
    }
}
document.getElementById('registerForm').addEventListener('submit',function(e){
    var p=document.getElementById('regPassword').value;
    var c=document.getElementById('cpassword').value;
    if(p!==c){e.preventDefault();alert('Passwords do not match!');}
});
</script>
</body>
</html>
