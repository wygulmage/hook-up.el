# hook-up.el
\`hook-up-make-hook' take a 'when' of :before or :after, a procedure, and optionally a list of procedures. It creates a hook named '[when]-[procedure]-hook' (e.g. 'after-load-theme-hook') and includes the optional procedures in it.

\`hook-up' takes a sequence of hook variables and a sequence of procedures, and adds the procedures to the hooks.
