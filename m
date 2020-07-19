Date: Sun, 19 Jul 2020 20:51:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200719185141.GK1431@...1296...>
References: <20200717112953.6699-1-arne@...1227...>
 <152c54e4-beae-7ea4-a91e-60fbd269c1e7@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Afymnw9XWF8T0g7v"
Content-Disposition: inline
In-Reply-To: <152c54e4-beae-7ea4-a91e-60fbd269c1e7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Convert cc_check_return to switch/case
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--Afymnw9XWF8T0g7v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 17, 2020 at 02:06:02PM +0200, David Sommerseth wrote:
> On 17/07/2020 13:29, Arne Schwabe wrote:
> > The return false/return true is the result of
> > running uncrustify.
[..]
> > +        case CC_RET_SKIPPED: return true;
> > +
> > +        default: ASSERT(0);
>=20
> Code style police ....=20

Not needed :-) - that code escaped, and the change-to-switch-case has
long been merged in proper form.

(For the record, this was discovered and discussed on IRC like "5 minutes
after the mail was sent").

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Afymnw9XWF8T0g7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfFJY8AAoJEB2Cnv7KVigS0PkMAJ6/Ixj4NNiatLNyYdHOKl35
IwOxmbNpgz40gmtqvcnyC+LhDzxgAUGlhpXPg00OeMFQ035x0N3N31vWBYnt4SvR
rKBZHLAAHOCtbll1SZHVCAj0XwgOYa5UWu7YgshgAJzsansgr0QcjPtrUVbAaCJD
wFrpnELOFKr7La1k8326lAYqyMK7Vh+rPod/JfTsgy+mI9HfhBYAy1aOmqjv3EUi
4Bwr4NCH1bv9SnQ4Yw9cJxx7dEqwZHRDYP1tlcwV83Zq0E3UQaXOQ7hVfbQ4zx2V
jGFnoCsXor7KmvzjO9WRnhD8spHf10+zKqa7mU7PWebAnYfkXw3tewlB3q3cgQZk
ejNJznZXmLPtJWw1so4NXPZxTfPeHg716hKWILsNjer3Pibyw36/sv4FxB+nEp8d
mTmmSdFfvhcwzlp6W34WhDKu3zd750+uSgkz4IXVjTtlq8H5vJcCPygBaj2vOZhO
XI7hKNdJLVbpAt8szA9o21doIDkymIEl4xwrv/oQZQ==
=9fl5
-----END PGP SIGNATURE-----

--Afymnw9XWF8T0g7v--

