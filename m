MIME-Version: 1.0
References: <174525418131.12969.12586033348804732953@...2888...>
In-Reply-To: <174525418131.12969.12586033348804732953@...2888...>
From: Marc Leeman <marc.leeman@...277...>
Date: Tue, 22 Apr 2025 11:04:55 +0200
Message-ID: <CAH+fs=98uWrLRqsRPDs9ED-o=Ym_2oQaSrYn47Mwtte3pBuPsQ@...278...>
Content-Type: multipart/mixed; boundary="00000000000033571306335a4849"
Subject: [Openvpn-devel] Fwd: Bug#1103800: openvpn3-client: please make the
 build reproducible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00000000000033571306335a4849
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A new build will be uploaded to Debian shortly; I can carry the patch
in the packaging, but It should be considered upstream.


---------- Forwarded message ---------
From: Chris Lamb <lamby@...334...>
Date: Mon, 21 Apr 2025 at 18:57
Subject: Bug#1103800: openvpn3-client: please make the build reproducible
To: <submit@...40...>


Source: openvpn3-client
Version: 24+dfsg-1
Severity: wishlist
Tags: patch
User: reproducible-builds@...2887...
Usertags: timestamps buildpath
X-Debbugs-Cc: reproducible-bugs@...2887...

Hi,

Whilst working on the Reproducible Builds effort [0], we noticed that
openvpn3-client could not be built reproducibly.

This is because it embedded both the build path and the current date.
Here's the date bit:

      =E2=94=9C=E2=94=80=E2=94=80 ./usr/share/bash-completion/completions/o=
penvpn2
      =E2=94=82 @@ -1,12 +1,12 @@
      =E2=94=82  #
      =E2=94=82 -#  Copyright (C) 2017 - 2025  OpenVPN Inc <sales@...515...>
      =E2=94=82 +#  Copyright (C) 2017 - 2026  OpenVPN Inc <sales@...515...>

The absolute build path was embedded via a utility that was called via
its full path by meson, which then emitted its own path via printing
argv[0] ... which was saved to a file that was shipped in the .deb.

Patch attached that fixes both issues.

 [0] https://reproducible-builds.org/


Regards,

--
      ,''`.
     : :'  :     Chris Lamb
     `. `'`      lamby@...334... / chris-lamb.co.uk
       `-





--=20
g. Marc

GPG: 827C FD74 BA46 8152 A041 F3A0 7A6A 4F17 5995 A65B

--00000000000033571306335a4849
Content-Type: text/plain; charset="US-ASCII"; name="openvpn3-client.diff.txt"
Content-Disposition: attachment; filename="openvpn3-client.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <1965cbc3c1e556755061>
X-Attachment-Id: 1965cbc3c1e556755061

LS0tIGEvZGViaWFuL3BhdGNoZXMvMDAwM19yZXByb2R1Y2libGUtYnVpbGQucGF0Y2gJMTk2OS0x
Mi0zMSAxNjowMDowMC4wMDAwMDAwMDAgLTA4MDAKLS0tIGIvZGViaWFuL3BhdGNoZXMvMDAwM19y
ZXByb2R1Y2libGUtYnVpbGQucGF0Y2gJMjAyNS0wNC0yMSAwOTozNjo0NS45ODE2NzIzMDUgLTA3
MDAKQEAgLTAsMCArMSw1NSBAQAorRGVzY3JpcHRpb246IE1ha2UgdGhlIGJ1aWxkIHJlcHJvZHVj
aWJsZQorQXV0aG9yOiBDaHJpcyBMYW1iIDxsYW1ieUBkZWJpYW4ub3JnPgorTGFzdC1VcGRhdGU6
IDIwMjUtMDQtMjEKKworLS0tIG9wZW52cG4zLWNsaWVudC0yNCtkZnNnLm9yaWcvc3JjL3B5dGhv
bi9vcGVudnBuMy9nZW4tcHl0aG9uLWNvbnN0YW50cy5jcHAKKysrKyBvcGVudnBuMy1jbGllbnQt
MjQrZGZzZy9zcmMvcHl0aG9uL29wZW52cG4zL2dlbi1weXRob24tY29uc3RhbnRzLmNwcAorQEAg
LTI5LDYgKzI5LDggQEAKKyAjaW5jbHVkZSAibmV0Y2ZnL25ldGNmZy1jaGFuZ2V0eXBlLmhwcCIK
KyAjaW5jbHVkZSAic2Vzc2lvbm1nci9zZXNzaW9ubWdyLWV2ZW50cy5ocHAiCisgCisrI2luY2x1
ZGUgPG9wZW52cG4vY29tbW9uL3BhdGguaHBwPgorKworIAorIGVudW0gY2xhc3MgRmxhZ1R5cGUK
KyB7CitAQCAtMTE3LDcgKzExOSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
KyB7CisgCisgICAgIHN0ZDo6Y291dCA8PCAiIyIgPDwgc3RkOjplbmRsCistICAgICAgICAgICAg
ICA8PCAiIyBHZW5lcmF0ZWQgYnkgIiA8PCBhcmd2WzBdIDw8IHN0ZDo6ZW5kbAorKyAgICAgICAg
ICAgICAgPDwgIiMgR2VuZXJhdGVkIGJ5ICIgPDwgb3BlbnZwbjo6cGF0aDo6YmFzZW5hbWUoYXJn
dlswXSkgPDwgc3RkOjplbmRsCisgICAgICAgICAgICAgICA8PCAiIyBhcyBwYXJ0IG9mIHRoZSBw
cm9qZWN0IGJ1aWxkLiIgPDwgc3RkOjplbmRsCisgICAgICAgICAgICAgICA8PCAiIyIgPDwgc3Rk
OjplbmRsCisgICAgICAgICAgICAgICA8PCAiIyBUaGlzIGZpbGUgaXMgcGFydCBvZiBvcGVudnBu
My1saW51eCwgbGljZW5zZWQiIDw8IHN0ZDo6ZW5kbAorLS0tIG9wZW52cG4zLWNsaWVudC0yNCtk
ZnNnLm9yaWcvc3JjL3NoZWxsL2Jhc2gtY29tcGxldGlvbi9nZW4tb3BlbnZwbjItY29tcGxldGlv
bi5weQorKysrIG9wZW52cG4zLWNsaWVudC0yNCtkZnNnL3NyYy9zaGVsbC9iYXNoLWNvbXBsZXRp
b24vZ2VuLW9wZW52cG4yLWNvbXBsZXRpb24ucHkKK0BAIC0xNyw5ICsxNywxMiBAQAorIGltcG9y
dCBpbXBvcnRsaWIKKyBpbXBvcnQgc3lzCisgaW1wb3J0IGFyZ3BhcnNlCistZnJvbSBkYXRldGlt
ZSBpbXBvcnQgZGF0ZQorK2ltcG9ydCBvcworK2ltcG9ydCB0aW1lCisraW1wb3J0IGRhdGV0aW1l
CisgZnJvbSBqaW5qYTIgaW1wb3J0IFRlbXBsYXRlCisgCisrCisgY29tcGxldGlvbl90ZW1wbGF0
ZSA9ICIiIiMgIE9wZW5WUE4gMyBMaW51eCBjbGllbnQgLS0gTmV4dCBnZW5lcmF0aW9uIE9wZW5W
UE4gY2xpZW50CisgIworICMgIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBBR1BMLTMuMC1vbmx5
CitAQCAtMTIyLDggKzEyNSwxMyBAQCBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgorICAgICAg
ICAgZWxzZToKKyAgICAgICAgICAgICB2YWxpZF9hcmdzW29wdF0gPSAnJXMnICUgdmFsdWVzWzBd
CisgCisrICAgIGJ1aWxkX2RhdGUgPSBkYXRldGltZS5kYXRldGltZS5mcm9tdGltZXN0YW1wKAor
KyAgICAgICAgaW50KG9zLmVudmlyb24uZ2V0KCdTT1VSQ0VfREFURV9FUE9DSCcsIHRpbWUudGlt
ZSgpKSksCisrICAgICAgICB0ej1kYXRldGltZS50aW1lem9uZS51dGMsCisrICAgICkKKysKKyAg
ICAgY3RwbCA9IFRlbXBsYXRlKGNvbXBsZXRpb25fdGVtcGxhdGUpCisgICAgIHNjcmlwdCA9IGN0
cGwucmVuZGVyKHZhbGlkX2FyZ3M9dmFsaWRfYXJncywgb3B0aW9uX2xpc3Q9b3B0aW9uX2xpc3Qs
CistICAgICAgICAgICAgICAgICAgICAgICAgIHllYXI9ZGF0ZS50b2RheSgpLnllYXIpCisrICAg
ICAgICAgICAgICAgICAgICAgICAgIHllYXI9YnVpbGRfZGF0ZS55ZWFyKQorIAorICAgICBwcmlu
dChzY3JpcHQpCi0tLSBhL2RlYmlhbi9wYXRjaGVzL3NlcmllcwkyMDI1LTA0LTIxIDA5OjAwOjQ5
LjE0ODczNTU5OSAtMDcwMAotLS0gYi9kZWJpYW4vcGF0Y2hlcy9zZXJpZXMJMjAyNS0wNC0yMSAw
OToyNDowOS42ODc5NDEwODYgLTA3MDAKQEAgLTEsMiArMSwzIEBACiAwMDAxX2ltcG9ydC11bmlj
b2RlLWltcGwtZnJvbS1sbHZtLnBhdGNoCiAwMDAyX2ZpeC1vcGVudnBuLXRvLV9vcGVudnBuLnBh
dGNoCiswMDAzX3JlcHJvZHVjaWJsZS1idWlsZC5wYXRjaAo=
--00000000000033571306335a4849--

