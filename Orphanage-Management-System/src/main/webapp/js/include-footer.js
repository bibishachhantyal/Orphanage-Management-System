(function () {
    var mount = document.getElementById('footer-mount');
    if (!mount) return;
    fetch('footer.html')
        .then(function (r) { return r.text(); })
        .then(function (html) { mount.outerHTML = html; })
        .catch(function () { /* static preview without server */ });
})();
