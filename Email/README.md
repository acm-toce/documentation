# ACM TOCE email templates

`templates.xml` is the full export of the journal's [Manuscript
Central](https://mc.manuscriptcentral.com/toce) (ScholarOne) email templates — 254 of them, covering
every automated and editor-sent message in the peer review process.

Edit them here, in version control, rather than one at a time in the ScholarOne web UI. That way
changes are reviewable, revertible, and visible in the repository history.

## Round trip

1. **Export first.** In Manuscript Central, go to the email templates link on the admin dashboard and
   export. Keep that file as your rollback artifact before you import anything.
2. Edit `templates.xml` here and commit.
3. Import it back into Manuscript Central.
4. **Re-export and diff** against what you imported, to confirm ScholarOne round-tripped it intact.
5. Send yourself a test message from any template you changed, and check that every `##MERGE_FIELD##`
   actually resolved.

## Format constraints — these matter

The file is a ScholarOne export and it is picky:

- **UTF-8 with a BOM**, and **CRLF line endings throughout**. Do not let an editor normalize either.
- **No XML entities, and no bare `&` anywhere** in the file. The current file contains zero; keep it
  that way, since an unescaped ampersand will fail the import.
- **Bodies are plain text.** Markdown does not render — `**bold**` arrives as literal asterisks.
  Put URLs bare on their own line, which is the convention the existing templates already use.
- `email_id` is the unique key, not `email_name`. Names are duplicated across ScholarOne's workflow
  folders (Standard / Revision / Invited), and a few are actively misleading — `email_id="314156"` is
  named `*Paper Submitted Corresponding Author` but is really the production final-files email.

## Reciprocal Reviews links

42 templates carry links into the journal's [Reciprocal
Reviews](https://reciprocal.reviews) venue, which is how review labor is compensated. There are three
link shapes, and `##DOCUMENT_ID##` is ScholarOne's manuscript-ID merge field:

| Purpose | Link |
|---|---|
| Author pays for a submission | `.../submissions/new?manuscript=##DOCUMENT_ID##` |
| Reviewer or AE acknowledges an assignment | `.../submissions?filter=##DOCUMENT_ID##` |
| Reviewer or AE requests compensation | `...?compensate=##DOCUMENT_ID##` |
| Volunteer for a role | `...#roles` |

Regenerate these from the venue's settings page with ScholarOne selected as the reviewing platform,
rather than editing the venue id by hand.

**No template states a token amount.** Costs and per-role compensation live on the venue page, which
is the authoritative source; the templates link to it. Keep it that way, so a repricing never
requires touching this file.

Wording also avoids anything that goes stale: the November 2026 launch is phrased as a standing fact
about which submissions are covered ("submissions entering the review cycle from the 1 November 2026
deadline onward"), and calls to action are conditional, so the templates read correctly both before
and long after the launch.

## Related documentation

- [Author guidelines](https://dl.acm.org/journal/toce/author-guidelines#reciprocal-reviews) — what
  authors are told about tokens, mirrored in `wiki/Author-Guide.html`
- [Associate Editor guidelines](https://github.com/acm-toce/documentation/wiki/Associate-Editor-Guidelines#how-does-reciprocal-reviews-fit-in)
- [Reviewer guidelines](https://github.com/acm-toce/documentation/wiki/Reviewer-Guidelines#how-am-i-compensated-for-reviewing)
