Date: Thu, 17 Sep 2020 09:01:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200917070157.GP976@...1296...>
References: <20200911115916.16117-1-gert@...1296...>
 <9d04cb8e-83a5-505a-9031-44b0d9bf9331@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <9d04cb8e-83a5-505a-9031-44b0d9bf9331@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] If IPv6 pool specification sets pool
 start to ::0 address, increment.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 17, 2020 at 08:55:07AM +0200, Antonio Quartulli wrote:
> >          }
> >=20=20
> >          pool->ipv6.base =3D ipv6_base;
> > +
> > +        /* if a pool starts at ::0, that first IPv6 address is not usa=
ble
>=20
> can we reword a bit this comment? I.e.: "if the starting address of a
> pool has the host part all zero, that first ...."
>=20
> The "starts at ::0" confused me as if we were targeting pools starting
> at [::].

Okay.  I did not want to make this comment too long, but it seems more
verbosity is needed.  I'll send a v2

> > +         * first clients (subnet anycast address).  Start with 1, then.
> > +         * NOTE: this will also fire for something like
> > +         *    ifconfig-ipv6-pool 2001:db8:0:1:1234::0/64
> > +         * as we only look at the rightmost 32 bits.  So be it...
>=20
> wouldn't this test miserably fail when the host part is smaller than 32?
> like for a 2001:db8:0:1:1234::0/124?

We look at "base", which is only the host part, but "at most 32 bits of
the host part".

(This is *your* code...!)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfYwnkAAoJEB2Cnv7KVigSC44L/imm9wDXN5J4u4cfVKlOcE+s
f7pFCUZknH0+pf5R67/KDEkGiu9opYQ0bxekHS6Wt3A+h4COANudp677pqXCuoNb
htSaMsDX3EUISIiihzFNt+Eq9NOLMoAMAE5l/eGMuWRXMdfu//w/nMNSzviufxBh
IriyWbqBpPpMPgEzAeeEEQgF7qrCsMQwrUcSDxGq8xLPfUNEpekfaehAErFt4w7/
xBVAP1zTGKy2/93Ol5ygnsWKpv9ZthqL3gozLnG4udNd/SR+c79HNuZ/HRYeHl4g
UD80a0wHT+Ta0eaHKb2KogvKOXTsSGbBanNSX6D6m2i7IFBILnSzzbgx354SNAJR
kzllbmWITbXWzDJuLV9y8IVROxNbnmNXzuVDo2vVxeV/7mYIcWCQVZSHysqeEMfg
hDEGCxXUQCwb1pYyAAGW1S+EW1j14HnFoGh39dJxi9CSii2MT0Wl6cvfnlRwZqrv
z6WJTtsT0uyG60pPqfkSwpUXxZr6PhW8D1OLmH5zUg==
=Xe/2
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

