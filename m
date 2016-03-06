Date: Sun, 6 Mar 2016 14:44:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160306134402.GW24952@...1296...>
References: <20160225125008.GD24952@...1296...>
	<1456457091-3872-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pagWpRLPtWkQX8eB"
Content-Disposition: inline
In-Reply-To: <1456457091-3872-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Refactor and move the
 block-outside-dns code to a new file (block_dns.[ch])
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--pagWpRLPtWkQX8eB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 25, 2016 at 10:24:50PM -0500, Selva Nair wrote:
> - Move the core of win_wfp_block_dns() to a new function
> - Remove globals and make it independent of the rest of the code

Trying to compile this on mingw 32bit, block_dns.c blows up for me
unless I add two more header files to get definitions for ADDRESS_FAMILY
and SOCKADDR_INET (which are referenced by iphlpapi.c)

--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -29,6 +29,8 @@
 #include <fwpmu.h>
 #include <initguid.h>
 #include <fwpmtypes.h>
+#include <winsock2.h>
+#include <ws2ipdef.h>
 #include <iphlpapi.h>
 #include "block_dns.h"

... with these changes, both openvpn.exe and openvpnserv.exe compile=20
and link nicely.

MS documentation says one should include <winsock2.h>, but that is not
sufficient for me.

So, question 1: is this a mingw issue, or just a 32bit windows requirement
and you only tested on 64bit?

question 2: shall I just add these two header files and take note in
the ACK-and-merge e-mail, or do you want to re-send a v3?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pagWpRLPtWkQX8eB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtw0IakuBuNlUUl1AQJasAQAjmVOMnGLal2kl3quARr/8aYq9WTOTIDl
efIsT87nhqYj0BASc7WNvQcJOcKrz9PE0cjgQ9jGhXOae5YwMaRepdgxta125FgY
jRdEfutnFTQcAukuQd9MYafqU5S/UdvcufuWu6EPMkkkWR0FcW2kocFQCFLpO1DQ
zLkTCEh0ef8=
=wpAr
-----END PGP SIGNATURE-----

--pagWpRLPtWkQX8eB--

