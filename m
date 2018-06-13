Date: Wed, 13 Jun 2018 13:28:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180613112806.GP57262@...1296...>
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CqVFb5A8LpjztvkH"
Content-Disposition: inline
In-Reply-To: <20180613081218.1834-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] tun: always pass a valid tt pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--CqVFb5A8LpjztvkH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 04:12:17PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This patch is a small "logic restyle" which basically moves the
> check for "tt !=3D NULL" outside of the various close_tun()
> implementations and replaces it with an ASSERT.
>=20
> This way the check is done only once and the function can rely
> on the assumption that "tt" is always valid.
>=20
> This change is mainly to improve the code style inside close_tun()
> implementations by removing one level of indentation.
>=20
> No functional change is present.

Mostly-ACK-but :-)

The changes look good.  It won't apply after the gc_arena-fixed 1/3 of
this series, so we need a new one.

I've applied the patch and checked with "git diff -w", and it does what
it says on the lid...

Not sure the ASSERT(tt) is needed in solaris_error_close() - tt can
never be NULL there (because all the caller functions are working with
an active tt).  So I'd tend to leave that out, it's not doing something=20
useful.


In those close_tun() instances where you removed the

else if (tt)
{

}

part - some of them had a comment ("/* close and destroy */").  Maybe
keep the comment?

As in

     if (tt->persistent_if)        /* keep pre-existing if around */
     {
         close_tun_generic(tt);
         free(tt);
         return;
     }

     /* close and destroy */            <<<<< this one
     struct argv argv =3D argv_new();

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CqVFb5A8LpjztvkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbIP/FAAoJEB2Cnv7KVigSO4MMALImcq9hgMA7aRDDV6pwDLPg
qyy2xgn/uwTTOIe9XXesPTwbdCQR0XpAkz10z3xzNYZXtetzCI2Hh9/ZFfWq2zZi
s3xcgbsoc3xTXYysZ/wpMEQIMHFPAH4/ISbdtAxy5bci7ggQ1TCvruqnvt/fVzHo
akA9ORXI+N4emq9aNZwdrOgcgBtaOPiF2CwQHNkv1F0b18uNEKz/ZUfMWBjJ+NJf
iY3ClgRIygYF6flFWFKUqW3QZPD8Vp7muylZUA6bPwfu8REDlWA0qmFNZTfk3JUN
nRZyRVruM9gGpX+BeSU3LUhNsS4vzIup1Ojc+ezhm4S+hgQDCtuKkuhYR+9ZugWq
jwmIFQOdnXQp9lF5psG5fvXHh24FMcxVy1aldQUBzOeS64mZO3EbFhQ0gPwBFnVP
pYMjqp5gF6VxmkNmXnYMO6SYcvdQU8ySLpY1DZ8aoEtq/xpcTJHoxb3bwKpHqBAh
mGLvjh5G5dXRxGoJB+N54o59HefKI4uWzs151AX9ag==
=EYQi
-----END PGP SIGNATURE-----

--CqVFb5A8LpjztvkH--

