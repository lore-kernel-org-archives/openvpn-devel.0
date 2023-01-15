Date: Sun, 15 Jan 2023 17:29:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8Qp4Zhj5K28+pit@...1296...>
References: <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
 <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
 <CAFHpkQH-XCkzoY70AMQvZSeC9LVfrabnu6nSKmthq_-cxUw=Dg@...278...>
 <df394682-d609-4c08-7fbb-38b393b9a481@...1227...>
 <CAFHpkQGpA6gs5hfevrgW1HbZhetCaGCgxuDxFUi9PowboYMsnw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JYtV7jPv27Jdp0YF"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGpA6gs5hfevrgW1HbZhetCaGCgxuDxFUi9PowboYMsnw@...278...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--JYtV7jPv27Jdp0YF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sun, Jan 15, 2023 at 10:12:03PM +0600, ???????? ?????????????? wrote:
> 1) distributing openssl dll for windows installer is illegal
> 2) distributing openssl/libressl with tunnelblick is illegal

Neither, because we do have an exception for OpenSSL.

But distributing with mbedTLS is what we have been told is problematic.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JYtV7jPv27Jdp0YF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjxCnhAAoJEB2Cnv7KVigSahYL/0Y0Im4weyaffuXr3dhrYzG2
pqwVC7VOOyZpUGXcMtQFUl8ep+xcE4gOIDQOYhuWYbyU3QzPvssUOT9ctUlIg4C4
Vfgvb4erRWNbVWdX/jqw0fdjkt2tYZXLnZnSPm6X2xYhwNpZNwFT2oTUqNkyd6pm
pl3U2WMrDyczXsUxV/e1PSC1osr5r6j5B87WSJ4I0vQFLpfOMXQ5HPUBD5cF3qcC
hHFaLCa+K1oQ47paZ64ujdKF3yMDXHLb4O00ZKlhZ75lbkEU3Wml7zaNpH++eWAQ
Ue1ezQPn7BNHFLWVns3BHVGjEzhlSnk/Iuh+a2x4vcXYkZzdnvFTaMIP8diBBgRP
b4vKJT9rzVLSmKd4DY2eJluKtax/G58eV50ZjVQFqA+R6xTNsH6i44yez/CTlHpM
/6xCFmK/mklYzrkP/JCRqTx3j3HwJraD4Wi3HNOdzEudBQe3Ty5s7xNB5w/AmuKS
ti14fw36/RO/FLCM2CYEfMcVnEgdTKUZawx2N16HAA==
=JTcj
-----END PGP SIGNATURE-----

--JYtV7jPv27Jdp0YF--

