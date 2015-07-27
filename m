Date: Mon, 27 Jul 2015 21:22:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150727192224.GP382@...1296...>
References: <1436534548-21507-2-git-send-email-openvpn.list@...1114...>
	<201507271902.t6RJ2kfa012872@...1295...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mgTJv4Szexpher0x"
Content-Disposition: inline
In-Reply-To: <201507271902.t6RJ2kfa012872@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Provide compile time
	OpenVPN version information to plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--mgTJv4Szexpher0x
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 27, 2015 at 09:02:46PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.

Actually, not... this breaks out of tree builds...

gcc -DHAVE_CONFIG_H -I. -I../../../openvpn/src/openvpn -I../..  -I../../../=
openvpn/include -I../../../openvpn/src/compat         -g -O2 -MT error.o -M=
D -MP -MF .deps/error.Tpo -c -o error.o ../../../openvpn/src/openvpn/error.c
In file included from ../../../openvpn/src/openvpn/options.h:39:0,
                 from ../../../openvpn/src/openvpn/ssl.h:43,
                 from ../../../openvpn/src/openvpn/ps.h:32,
                 from ../../../openvpn/src/openvpn/error.c:43:
../../../openvpn/src/openvpn/plugin.h:38:28: fatal error: openvpn-plugin.h:=
 No such file or directory
 #include "openvpn-plugin.h"
                            ^
compilation terminated.


openvpn-plugin.h is nicely built from openvpn-plugin.h.in, but it is=20
built in the *build* tree, and the -I statements above do not look
there - it would need an "-I../../include" to work...

config.h is built in the root directory of the build tree, so "-I../.."
catches that.  Since we have nothing else in ../../include/, nothing
adds it to the compile statement (and I'm not overly eager to see it there,
already quite a bit of stuff on the command line).

So... patches, or revert time?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mgTJv4Szexpher0x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbaE8KkuBuNlUUl1AQJp+AP/bHIxEqHubnZG05MAGyVzEFp+s8sjAtr9
LJfNTLEFJBs4d9BZFljIq1Q8TOf3lBaeHbrKvZk0PFTgZCRNw8P3g3F2MwYvGPrX
/mx89kurFvs89EL1ZtpZemUJhjdqFU+EVyElBSscSDhb0aWv2Rwd+YoDvU+9TDiJ
IxADtK5lReQ=
=1RBV
-----END PGP SIGNATURE-----

--mgTJv4Szexpher0x--

