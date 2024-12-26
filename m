Date: Thu, 26 Dec 2024 14:00:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z21Tb9c5lm2P0dEt@...1296...>
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
 <b16cab79-188f-41a3-af32-f944a387400f@...68...>
 <Z2wxD-t_CZ2uR5K9@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u2pt7bNHOnF1kKyS"
Content-Disposition: inline
In-Reply-To: <Z2wxD-t_CZ2uR5K9@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] port-share: Normalize
 IPv4-mapped IPv6 addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--u2pt7bNHOnF1kKyS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 25, 2024 at 05:21:35PM +0100, Gert Doering wrote:
> I'm fine with the idea, but I do not like the implementation with=20
> "yet another localized sockaddr manipulation function" - we already
> have similar code in socket.c/setenv_sockaddr(), so maybe we need
> to make this a more general thing.

I now see that it's not *that* easy, as transform_mapped_v4_sockaddr()
is also used by part 2/3 of the series... so maybe we'll just take 1/3
as it is, and see if we can overhaul the whole handling of v4-mapped
addresses in a more coordinated way later.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--u2pt7bNHOnF1kKyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnbVNvAAoJEB2Cnv7KVigSm9cL/3icg7PLI/FddVOxP31RQWYx
fciKfhaiDpZZbeAQH3KA5dpIoqQK7/L4wN090tdPGsOLIX4pgcLOf5m9BVQ0tYqA
wp/w/gOFQcA5sJGTRd4pCOvDL7EvJKoGj2niUUFP52TIc1Knu6ckIRAZjaE9RAmm
nfSJX/eCgm92o/7CF67MglDN7i6h9hI0IIwxXc0XzIPouZpP5fWsf8zahIFC6+Mn
b0sXn/GJqbeDHt1okpagwq9SXF82WmCRQJXrq/EGpP0z0kyPC7SHQA6D7Fcy+zDx
Tf8Lj+hIj7H2+YBozBfyh8VKQ+6vbafp2rhbbYtwBYYKPbkQITOcOrt2d2CYaqxM
amWr0YKfCfzAlFAhUOX+IkCYcijU1OSZMS3jkRZquwm5UFBO01JuNUr5IdTE8tad
/TlYtbHlseeIGFhax8etSX7spH9UTwIYC+auKB5xriiUSB1bqqHNyjxbZUWrF4H7
CbgixCn3kzXZASUgY5/p5BMhL2AZBi/InU8Ea+QeNQ==
=kyuJ
-----END PGP SIGNATURE-----

--u2pt7bNHOnF1kKyS--

