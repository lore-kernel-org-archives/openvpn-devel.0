From: David Sommerseth <davids@...515...>
Date: Fri, 11 Nov 2016 12:42:21 +0100
Message-Id: <1478864541-773-1-git-send-email-davids@...515...>
In-Reply-To: <20161109201932.80991-1-gert@...1296...>
References: <20161109201932.80991-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Repair topology subnet on
	OpenBSD
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
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.

Checked these changes against the FreeBSD 11 fixes.  The changes puts
the OpenBSD section well aligned with FreeBSD in do_ifconfig(), and it
all makes sense from a code-review perspective.

When also knowing the FreeBSD fix have been tested and verified successful
by externals, I do not see any reasons this should be any worse for OpenBSD.
I do not have an OpenBSD box to run tests on, so I place confidence in the
testing Gert have done (which usually very well executed).


Your patch has been applied to the following branches

commit 7f444dee52321c0f0294e99695150a7f69522715  (master)
commit ceac73b04fe9b70ed798afc07ddb9737c97b7a5d  (release/2.3)
Author: Gert Doering
Date:   Wed Nov 9 21:19:32 2016 +0100

     Repair topology subnet on OpenBSD

     Trac: #710
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20161109201932.80991-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12983.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJa6TAAoJEIbPlEyWcf3ypU4P/0jRDeEnPBBPdCucYreiYdX2
aXGfDsz+bzX3Gmp5rD00MZjETLJKl3E6ZPnFN8D0nUeE2p9L/cyPK+eESZ+gE41c
oelConatOMAKALZYzBgjoP8zQGvlurDZg7BycXNy6vfJ2G2gWJLkyq6piCcOnif6
wFo7FxicrceHB0emLM8lEQdTdTc1grRpSB8BQSYEZvY4SwzmooD6RLnwrBiiBs2K
j/ccEANehxDFZ7cPACmRF+gXr7TXoFbAzxiep/jFIAXo7caHgD3JbdAzdRxgOLeO
cc8c7NjgtKN5wgBbB6Cgr/jSJwBqweBE0MDS0cRRMPARSpOqlRx2OhZtcmFsv7hE
K9/esBtpW0JsNo8QKAuPAbfU2TJPjyk9x0u6bNqHlqQtcXbRz91fqa+DgEHeCCoo
BRIgNW3+OUdfte9NgvsTetaK7LViio44M3PFEmwYBtBz/6oazYO0lpDKJRyineNP
+lACVieA2YgXKoghsRNRcWJxd2jqyZUTdQvrh86euaGz38RupDPqpFDf5W0fR2as
BT3F4Q2T+0WLT4fK1ZZZAK0dD+IHcQwmUanWOFMVStl3Z4vuZc7kUiANU2/m1Ria
qgnxzP8LG7m52ebtsTd1OzE7HEAejpp3CXEN0dlddLbfVJbyYsdK2pW9vogdSIpZ
xawe0ScDiu0hSBintf6I
=gnP6
-----END PGP SIGNATURE-----

