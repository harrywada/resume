Harry Wada's résumé
---

This is a groff-based facsimile of a common résumé template I've seen on
various sites, commonly known as Amsterdam.

Although this repository hosts my own version, I've made it relatively easy to
fit to others' use as well. That should not be understood to mean, however,
that it is resistant to purposeful misuse. If you try, it's not hard to break
the template with nonsensical input.


Dependencies
---

Besides groff itself, the only dependencies are those necessary to convert the
TTF files into ones usable by groff. Beyond standard POSIX utilities, these
consist of `ttf2pt1` and `afmtodit`, which should be available in most package
managers.

It should be noted that, since it doesn't require fonts, the plaintext résumé
can still be generated without any of these additional programs.


Customization
---

Standard customization is done in the `resume.groff` file, which shouldn't be
too hard to follow.

I'm from the U.S., so by default letter size paper is used. This can be
changed to any papersize recognized by groff within the `Makefile` (although
obviously changing it to something like d6 will lead to disastrous results).
Something to the effect of `sed -i /^PAPER/s/letter/a4/g Makefile` is all
that's necessary to use, in this case, A4 size paper, for example.

If you want further customization you'll have to modify `resume.tmac`, but at
that point all bets are off. While I've left some comments, there's some
gnarly stuff in there that I'm not really sure if even I understand. All I can
say is good luck.


Generation
---

Creating the résumé is as simple as an invocation to `make`, or equivalently
`make resume.pdf`. A plaintext version (with ANSI escape codes) can be made
using `make resume.txt`.


Licenses
---

Everything but the fonts is licensed according to the WTFPL, which is
available in `COPYING`. The fonts are licensed under the Open Font License,
available in `COPYING-OFL`.
