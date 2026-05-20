(function () {
    var STRONG = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^()_\-+=.,])[A-Za-z\d@$!%*?&#^()_\-+=.,]{8,}$/;

    function toggleVisibility(btn) {
        var wrap = btn.closest('.password-wrap');
        if (!wrap) return;
        var input = wrap.querySelector('input');
        if (!input) return;
        var show = input.type === 'password';
        input.type = show ? 'text' : 'password';
        btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
        btn.setAttribute('aria-pressed', show ? 'true' : 'false');
        btn.textContent = show ? '\u{1F441}' : '\u{1F648}';
    }

    function validateStrong(input) {
        if (!input || !input.hasAttribute('data-strong')) return true;
        return STRONG.test(input.value);
    }

    document.querySelectorAll('.password-toggle').forEach(function (btn) {
        btn.addEventListener('click', function () { toggleVisibility(btn); });
    });

    document.querySelectorAll('form[data-validate-password]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            var pw = form.querySelector('[data-strong]');
            var confirm = form.querySelector('[data-confirm]');
            if (pw && !validateStrong(pw)) {
                e.preventDefault();
                alert('Password must be at least 8 characters and include uppercase, lowercase, a number, and a special character (e.g. Admin@123).');
                pw.focus();
                return;
            }
            if (confirm && pw && confirm.value !== pw.value) {
                e.preventDefault();
                alert('Passwords do not match.');
                confirm.focus();
            }
        });
    });
})();
