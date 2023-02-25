Date: Sat, 25 Feb 2023 22:40:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y/qARRbFXTdppO9F@...1296...>
References: <20230214200804.600405-1-selva.nair@...277...>
 <202302251629.31PGTIw9077391@...2054...>
 <CAKuzo_icBdV5R2x0s8V+ZGpL0vRdF5JG_FfLMpe4=3U_q0nRHA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1TZB57w+wacIIHnG"
Content-Disposition: inline
In-Reply-To: <CAKuzo_icBdV5R2x0s8V+ZGpL0vRdF5JG_FfLMpe4=3U_q0nRHA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add a unit test for
 functions in cryptoapi.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--1TZB57w+wacIIHnG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 25, 2023 at 12:23:42PM -0500, Selva Nair wrote:
> > OTOH, there might be a bit of polishing needed - the other tests
> > print out what they are doing ("Running 7 test(s)"), while the
> > cryptoapi unit test "just succeeds".  Is there something missing
> > wrt cmocka initalization?
[..]
> That one is for OpenSSL 1.1.1 while this test is built only for OpenSSL3,
> so nothing to run. Do we need to continue testing Windows builds of 2.6 f=
or
> OpenSSL 1.1?

Ah.  Indeed, I saw the #ifdef in the code, but then looked in the wrong
test result.

Thanks for enlightening me (again).

Arne, indeed, this sounds as if we shouldn't run these test units on
mingw + 1.1.1 builds.  Just confusing people, like, me.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1TZB57w+wacIIHnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj+oBFAAoJEB2Cnv7KVigS6WYL/jGqskbrgLZLCw7MP56kuVbP
/ZcyBn89jx64kydla2q8m2oC24wJ8X9O/TeCmIW76f/uBKpOl8lYb8WdArECA5bn
zttlv/XUdVEHH38FM76+mTJQElMTCZvPX0b6mHF5m5n0M6UlbicMsJ91uZlKkpgc
q+wpp2CBHpaQhl/CdwGg0h8pjh06JSKddlpkpAAmL+Vgq1UYsEthzcBkDgeWhUZ4
cvvGP5AZPvE+IInyStA5ZpyrTauC8+0xekamJGFOrCOcUqxaVgGYFBSbkZNJSlTK
cDWocj4nHQrO0AAtW7ECi1RDCoNnB4MuwCO2HJWqmwFPsusk9YtCyy7gPgoT0c1j
P4XZFMh53Ow8hPakOQpdHSvCPx+Nq2engNfid4ue2Yqx1bqiRD8HkQH6eqEdnhHH
bzsI2M55kmq9W+k1ZV8xXmMVCwY+hCssxJfInr1fW6OYmWs0UwCX7t/TUIvAkAJJ
f5ZQMc4HQJ4FzMKNALeTlCAWlTwi/Q3S2XD15qcPLg==
=Gw94
-----END PGP SIGNATURE-----

--1TZB57w+wacIIHnG--

