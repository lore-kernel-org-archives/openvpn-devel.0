Date: Sun, 18 Apr 2021 13:29:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210418112903.GY976@...1296...>
References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
 <20210328120241.27605-2-arne@...1227...>
 <20210418101127.GX976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CKSdpYAPRWpli0Dm"
Content-Disposition: inline
In-Reply-To: <20210418101127.GX976@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Fix condition to generate
 session keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--CKSdpYAPRWpli0Dm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 18, 2021 at 12:11:27PM +0200, Gert Doering wrote:
> For release/2.5, this should be fine.

Confirming :-)

The patch 1/2 v2 (1666) needs some amount of force to go into 2.5 due
to context changes, and one extra is_cas_pending().  2/2 v2 (1667) goes
right in, and succeeds

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2g 2d 2e 2f 2z1 2z2 3 4 4a=
 4b 5 5a 5b 5c 5d 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 7y 8 8=
a 9 9a.

and also the "reconnect from same port" thing works with this patch on 2.5.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CKSdpYAPRWpli0Dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgfBf+AAoJEB2Cnv7KVigSeg0MAKLUiSdU05yJvhL3KRahB32a
zusnKp2eKqFLx3VKRHuzR+v77rOk3sXjcCVGZueo9441ZHlYywsPKRoX62/8rap3
WJJQspcGH9t8/9Tl37zIUYaGqL4+x2MKwgIReF06Jp/b2PmQfUtmR0WypaeO31bx
b1JpeJnLQKnZ6Jv2g7PT8L2MfOfyJ063Bl4o9EwHRnGGmG4IWKYL9+qXqC1J19eC
AbjU5xCUHLjWJgxzNma9gN8bF8QprPbqDELfJ3bqKLwgrdx5PBlnsaFhv85oBmY/
VRNZJI6ScRSTpWdzUKgIsFWvOC3XPAJQl2vhND1wziPGm+rs9D+xKQGNKgOjH990
B9Lu/Tk48LWv2O5vupCTQOKjWr+TwbNfpCxMzdTA61uOoQZzbAO+f9hnf6mVjy8g
DgKQQoijZPzXBTYBstUkQr70isBD7UHknHE2DPDHmR+bmBO/U6/xzK6BKx20Supr
JFLfjGaSOUMYXr/OGpnfqU2sk7xxXJauEijf9rkzEQ==
=I0SK
-----END PGP SIGNATURE-----

--CKSdpYAPRWpli0Dm--

