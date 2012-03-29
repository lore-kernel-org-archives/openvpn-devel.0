Date: Thu, 29 Mar 2012 09:50:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120329075012.GK1359@...1296...>
References: <20120328171611.GH1359@...1296...>
	<1332960258-25371-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JihJHJ45XT20FTtB"
Content-Disposition: inline
In-Reply-To: <1332960258-25371-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid using ~0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--JihJHJ45XT20FTtB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 28, 2012 at 08:44:18PM +0200, Alon Bar-Lev wrote:
> To avoid casting use two constants:
> 1. IPV4_NETMASK_HOST

Fine with that one.

> 2. dwMINUS_ONE

I think this is way over board.  It should be possible to spell "-1" as
such - and it doesn't increase readability to introduce a MINUS_ONE
define here.  If at all, introduce a "NO_IF_INDEX_FOUND" #define for
the "find tap ifindex" logic - but please make it a separate patch.=20=20

These are unrelated issues and must be reviewed independently (especially
"different people understand the respective bits of the code and can give
their ACK").

> @@ -1530,7 +1530,7 @@ print_in6_addr_netbits_only( struct in6_addr networ=
k_copy, int netbits,
>        if ( bits_to_clear >=3D 8 )
>  	{ network_copy.s6_addr[byte--] =3D 0; bits_to_clear -=3D 8; }
>        else
> -	{ network_copy.s6_addr[byte--] &=3D (~0 << bits_to_clear); bits_to_clea=
r =3D 0; }
> +	{ network_copy.s6_addr[byte--] &=3D (IPV4_NETMASK_HOST << bits_to_clear=
); bits_to_clear =3D 0; }
>      }

This particular one should NOT get "IPV4_NETMASK_HOST", as it isn't IPv4.

"0xff" would be fine, or just leave it at "~0".

> -	unsigned int lowest_metric =3D ~0;
> +	unsigned int lowest_metric =3D (unsigned int)-1;

This bit is not looking good.  If "-1" is a valid value for "lowest_metric"
(to signal "not set" etc) we shouldn't cast "-1" to (unsigned int) but
use a signed int here.

This should NOT be "just patched because we're it" but better understood
and properly fixed.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JihJHJ45XT20FTtB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3QUNKkuBuNlUUl1AQLtpgP/ZDDYeSsP/X22hcSRI1v1PfjsMogtfxBN
dhx1PjHW2ih6IWKok0JwZsbjxABebIUZWEbBwZbxRLwLjbzOEoa68oj04O1krQhx
N/iPU70+duNnHEG8V+OIIxdjR8AE1jWcCTcHKAlmgY1MrpDTHvpDOV+muO5CHgmk
wQ7cxa9jT44=
=Iy5v
-----END PGP SIGNATURE-----

--JihJHJ45XT20FTtB--

