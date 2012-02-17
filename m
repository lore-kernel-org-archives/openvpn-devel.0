Date: Fri, 17 Feb 2012 22:58:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120217215816.GW7024@...1296...>
References: <1329512690-18831-1-git-send-email-debrabander@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Content-Disposition: inline
In-Reply-To: <1329512690-18831-1-git-send-email-debrabander@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Bogus check for negative values on an
	unsigned number.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank de Brabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--JQ29orswtRjjfiJM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2012 at 10:04:50PM +0100, Frank de Brabander wrote:
> This causes compiler warnings when using Clang instead of default GCC.

I'm not particularily interested in source code fixes "just to silence
a compiler warning" - but Clang is right, of course, that this variable
cannot ever be negative, and thus it should be cleaned up :-)

I'm not ACKing this patch anyway, because I think the issue is bigger - I
want to look at the IPv4 code paths and see whether the IPv4 "netbits"
structure element can ever be negative - and if yes, figure out whether
this should be possible for IPv6, and if not, convert the IPv4 netbits
to "unsigned int" as well, and get rid of the if() statement there as
well.

Thanks for reporting this.  I'll look into it.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz7NeKkuBuNlUUl1AQLB8wP9EHIoGoNpkaULFRpAqGELRp3ZDqxCGnWA
QvmvAdq9R4yk9Nwon7Xm5BTbeYJMTL+VcgeVQMe8v8SRZ/Uu0r6/X/pvFovAkZvG
KCvBuxlOj4+0qQIHWNL1+wrm/R3WAMF+vnkrzAmxPyidADaFqYnYXHe1HQcGD0RX
qrrlUQwrkD4=
=f1sA
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--

