From: David Sommerseth <davids@...515...>
Date: Tue,  9 May 2017 22:16:39 +0200
Message-Id: <20170509201639.31433-1-davids@...515...>
In-Reply-To: <1494355368-20238-1-git-send-email-steffan.karger@...1435...>
References: <1494355368-20238-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Document tls-crypt security
	considerations in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Fixed a few typos during commit time, as pointed out by Selva.  The
changes are:

 -direction.  Assuming both initial negotation and renogatiations are at most
 +direction.  Assuming both initial negotiation and renegotiations are at most

 -2^16 (65536) packets (too be conservative), and (re)negotiations happen each
 +2^16 (65536) packets (to be conservative), and (re)negotiations happen each


Your patch has been applied to the following branches

commit 5806f66eb927a6a698c0f067f563d7bc2203a376  (master)
commit 9444506e45df86e6c8fbabfbf4a97c538cd971f4  (release/2.4)
Author: Steffan Karger
Date:   Tue May 9 20:42:48 2017 +0200

     Document tls-crypt security considerations in man page

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1494355368-20238-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14610.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEiOhAAoJEIbPlEyWcf3yy3kP/0SpNIeLUVRcGg/oHClYoM5y
UvSU4oJ2KCLssliNC66RwoFg+q2A0+oAl1p6z2AIXt4VBgkRxm5VZsd9lMZX0JAs
i6hV7EGoF1Fl0/9PYp6zNyNHspe2qQT3x1NNEHYHK91w3aUwXMlarJEfV2lmFoy9
cRbsBzQSK4o71on9EsFnNxLDFJrr2gBqM80AYu1JsT3DeWIHRyC+QFWX8qqmC4YX
80TSqWFkH90BA+qJypdaEizw0nTJWZjkFmRIN/Qa/0hXwtlUJToAbI9uL4W+oo5h
ZLD8WFCeM6PtTGX411uN/uU1Ky/cME61/CNJyd7/qIMDKQcU2+a0kxC5XsPRlaXD
d/WR06ruWFU34pLqwU6VJnwsKL841NQCASuYMDddzpULbYmuyLgLrkbQZ69Wgv+z
t91LpQAjoMQ6wkXpXq6175smypjvIUVfktUP9g/UnPDVPIdJmdMIDkf4I9zVYOtP
cW2DTOlnaBH7hEdwZCZmVSts/uu3b1eXowDlFTppO2914+g6tTs4aBzzYnkYdCcL
XpA3+zPNuXhgspRQ/q47e8EsMraSrV8zIRu27B1CowjwnFrBe9Z6oOzI9SH23Nzg
lkvvY1drp5EZm+Ewoomi5kLeUOb4SgDT+0ud2vsl3lFNUV5D9NQXQruVpScu+8sF
UgFuGmnlmWm+S8lkSxrP
=erjH
-----END PGP SIGNATURE-----

