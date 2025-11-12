Date: Wed, 12 Nov 2025 10:39:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aRRV1KZNNGewOfId@...1296...>
References: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
 <20251112092743.23173-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xpljlw4xE34dBLwT"
Content-Disposition: inline
In-Reply-To: <20251112092743.23173-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] clean up environment variable
 handling in verify_user_pass_script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--xpljlw4xE34dBLwT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 12, 2025 at 10:27:37AM +0100, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
>=20
> The username environment variable is already set by the
> set_verify_user_pass_env function before the verify_user_pass_script
> function is called, so this call is not doing anything but might erroneou=
sly
> made people think that this needs to be cleaned up.
>=20
> Also ensure that the password is clean from the env even in an error case.

Resend by mistake, has long been merged.  Sorry for the noise.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xpljlw4xE34dBLwT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJpFFXUAAoJEB2Cnv7KVigS5qAL/2fHkCVCAc+8Q1ilVLpJYdTm
U/ddjgDC25sqU/fbzKaUfcyB+u+q9webEt40iYlJ+dNhq/2R07dyGJAJKdRRUntT
DdDulGY0vGTL2HVCFxWKv7sGWAhrgLb0RUU1PUvnwmSfnpXp/LGO4RinuyRpCHTh
7LssIxk5hhv/D0CCz1KWrhqUXcs3Bk+27i8NHQBCpZWPCkz9o0pxBsnEtNpO6Z3B
JOZE4HuYJjZStaR5/B3tX/AvAdZzF0APrTh+GLAMqH3zbzfgOdLijOzp+JRxGUyB
GLXrZ7Q/cxEuTqSnrybfLvPSI87OhUM64gFxgTRKJXl5mDt0BRRHPs23FxbPT4Ml
4jeykGwX/b+zA6EvIsIrrMG1Xa2hfYqUGcTiywJ2Xtmn5BQxMW2S+kCiB9jTcUSX
+CzRFLqLCrIkvCffgbOSPhjlTnMVZSufqs1sXPE+CAAN696c0rVlQ8o7a9f3kHGb
leQqUPt4KM6VtBJr5EAtKPaczM032xw8c302duUQmA==
=WULX
-----END PGP SIGNATURE-----

--xpljlw4xE34dBLwT--

