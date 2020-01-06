Date: Mon, 6 Jan 2020 10:01:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200106090148.GM74723@...1296...>
References: <20200106080426.40701-1-list@...1798...>
 <BN7PR04MB5251B27BE1C62779CA7B4876FD3C0@...2532...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aSRrXo8NJAoPLte9"
Content-Disposition: inline
In-Reply-To: <BN7PR04MB5251B27BE1C62779CA7B4876FD3C0@...2532...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Christian Hesse <list@...1798...>, Christian Hesse <mail@...1798...>

--aSRrXo8NJAoPLte9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 06, 2020 at 08:48:00AM +0000, Tom Yan wrote:
> How about printenv (without grep)?

Portability.=20=20

"env |grep" is POSIX standardized so should work everywhere.

printenv is a BSD invention, which not all unix variants are required
to have.

(Besides, printenv on its own cannot do "give me all environment variables
that start with 'with_'", which is exactly what we want here... so you'd
end up with "printenv | grep", which is less portable and more characters)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aSRrXo8NJAoPLte9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeEvd6AAoJEB2Cnv7KVigSwcgL/0U3KycrFazp5FiOAUNuc9ma
p2bZRii8FmZNZaQkj3nVSu1qJ2705wigxhu0z85kwydeZMwArFuKrHzaFpeSrLwU
INwpkk+vAQszRLo3DZ0eTZw/rijYNGokvSt6i8OTUm0kFEn0Jefbp9xwdFwkt2HM
PQmXQ2bI2FD5V4/N6Jb2t4vhjm8Fz4AB2NlFUazQ/NksUlY2ZOUxJrFVsIoOriMr
Spt1y4ijjbTFzaNMrMATkVwYsSpeswYzQcqxrm4/DXTS3aJ1J0vfUJViIfwwju4N
Ev5NhLmpMutKf8QVI209+X/+0x7mm+UxgpvBNxT/KunZgrgldI+B3VGKy7NBE4qJ
TDHLvJADOUn+CUWtifZMIubTqdn5TxSTHhHDECcrOUGgQgADJyKNDAn4L1uSIv/w
l6zdnNX0BuyR2ZVu1zc3Bv2KsKNTdHAkILkCxinNl1oSX61stMF9yJaxYfmDMGCp
bXWhnU1HmZvDqpFLFqBJ9Otl1aTL13X4E+SjjBvfgQ==
=OkOR
-----END PGP SIGNATURE-----

--aSRrXo8NJAoPLte9--

