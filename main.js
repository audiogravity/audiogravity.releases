// Sparklines
function spark(id, seed) {
    const el = document.getElementById(id); if (!el) return;
    const pts = []; let v = .5;
    for (let i = 0; i < 60; i++) {
        v += (Math.sin(i * .4 + seed) * .3 + (Math.random() - .5) * .3) * .1;
        v = Math.max(0, Math.min(1, v));
        pts.push(`${(i / 59 * 200).toFixed(1)},${(16 - v * 14 - 1).toFixed(1)}`);
    }
    el.innerHTML = `<polyline points="${pts.join(' ')}" fill="none" stroke="#000" stroke-width="1.2"/>`;
}
spark('ds1', 1.2); spark('ds2', 2.8);

// Theme toggle
(function () {
    const root = document.documentElement;
    const KEY = 'ag-theme';
    const SUN = '<circle cx="12" cy="12" r="5"/><line x1="12" y1="1" x2="12" y2="3"/><line x1="12" y1="21" x2="12" y2="23"/><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"/><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"/><line x1="1" y1="12" x2="3" y2="12"/><line x1="21" y1="12" x2="23" y2="12"/><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"/><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"/>';
    const MOON = '<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>';

    function isDark() {
        const t = root.getAttribute('data-theme');
        if (t === 'dark') return true;
        if (t === 'light') return false;
        return window.matchMedia('(prefers-color-scheme: dark)').matches;
    }

    function applyIcon() {
        const icon = document.getElementById('themeIcon');
        if (icon) icon.innerHTML = isDark() ? SUN : MOON;
    }

    function toggle() {
        root.setAttribute('data-theme', isDark() ? 'light' : 'dark');
        localStorage.setItem(KEY, root.getAttribute('data-theme'));
        applyIcon();
    }

    const saved = localStorage.getItem(KEY);
    if (saved) root.setAttribute('data-theme', saved);

    document.addEventListener('DOMContentLoaded', function () {
        const btn = document.getElementById('themeToggle');
        if (btn) btn.addEventListener('click', toggle);
        applyIcon();
    });
})();
