Date: Wed, 18 Jan 2017 22:21:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170118212120.GX78624@...1296...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mm7SuNQsQ9gs8/y1"
Content-Disposition: inline
In-Reply-To: <1484772172-19758-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl,
 --wrap support in linker
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--Mm7SuNQsQ9gs8/y1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 18, 2017 at 03:42:52PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Also make tests that require --wrap option to be
>   conditional on this support
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

I said so in the PR already, but for the sake of the list - I think this
is a reasonable approach: disable the --wrap tests if we can't run them,
but keep the rest of the cmocka stuff active (way better than my initial
"if it's not GNU ld, just disable cmocka").

I'm ready and willing to ACK and merge this, but would like to hear
some voices from folks that understand autoconf better - is there anything
wrong with this approach?  Any suggestions how to do it better?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Mm7SuNQsQ9gs8/y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYf9xQAAoJEB2Cnv7KVigSR5oL/3g3/aXvQG/r1qz4ghKExRt1
J47G4Vej6dxxybEqw/Tbydbfg/pZiv6+Ev+6xFT5eS6Rpl6RYcVepXMiBkqPZTip
G4vRM9YpzXRPq8v1+6Buev86GYPnZ+3JrhYvmRvymssh3W4w5c6QaHuGT5dIqu4b
Yi6WlNPo3TD6n/I9fgNZ85J2DDxKMjKabWL7H/TM5cWhD6isWruoJVHKklzXxCtX
GNoozC8cPxJhNcEBzZIwBPbLGcmZDjv9mJTLSqy+VTcVjn6TW1AKp0HuU7FJBj7i
05glPdXjHDP0ZJ+ck/HQynTt8Qxa1IBXGxH5kM9SVvmRf4Xg82AQ6m/PSIECAoZ/
KD6LVB8peCawEDlcj0JQCnRYANPa9q2A1Lk3wH5u71hY8tUVXiU0jaqGiyi7Fcgn
llQ3PA2fz3E8T0lCHrqfUlzsb4MXMs32NQURtNtpTnx3MHfjVVgm8XEzE/J+Ps7l
H9i3atlKmfjoAdeB/AyeOPbPUKSRqit9t6S0KySjfg==
=1bo5
-----END PGP SIGNATURE-----

--Mm7SuNQsQ9gs8/y1--

