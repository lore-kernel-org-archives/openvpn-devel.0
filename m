Date: Mon, 9 Mar 2020 14:51:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200309135133.GA1431@...1296...>
References: <20200217144339.3273-1-arne@...1227...>
 <20200221100754.7125-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QWIFStbFpmlD00Pf"
Content-Disposition: inline
In-Reply-To: <20200221100754.7125-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 5/5] Normalise ncp-ciphers option and
 restrict it to 127 bytes
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

--QWIFStbFpmlD00Pf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 21, 2020 at 11:07:54AM +0100, Arne Schwabe wrote:
> Patch V5: Fix tests with OpenSSL 1.0.2 and libraries missing Chacha

Could you test this with mbedTLS 2.19, please?  Maybe it's a local thing,
but the test crashes here, with

[ RUN      ] test_check_ncp_ciphers_list
Unsupported cipher in --ncp-ciphers: ChaCha20-Poly1305
[  ERROR   ] --- Test failed with exception: Segmentation fault(11)
[  FAILED  ] test_check_ncp_ciphers_list


It passes for OpenSSL 1.0.2 on FreeBSD, CentOS 7.7 and OpenSSL 1.1.1 on
Linux.


Also, for v6, please fix that missing space :-)

Length of --ncp-ciphers is over thelimit of 127 chars
                                 ^^^

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QWIFStbFpmlD00Pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeZknkAAoJEB2Cnv7KVigSMo8L/2co5IWZE8c81IF4UESOl+pz
wF5ZX4xpLVtoZDkcEVn+CccKKqxdYb0hEtwv7LhCLneKEtNV7/ZoF9mMqAoGK+wn
ms3o+rEB/JIwO6q7Yr1vIaG9zSVl45wpxs8PkSK/7DFOmVlPlua9Zoc4VV+i+1lt
oPeNyli6MG9GjPipB5PNqCvSUj6aIvKv24WCUb/L5Q0bacGHo73ktWBDRfOBfSL/
U68gENoj1p/WVy8HFHljrg2cfMI3p6TXY+P2aiTYsQC/wI4v1EvThmB61xIYE5nU
YtPNB0WqDzzqGwQV2n2BzUjtXOPSAOt9HbmrJm7DNLAblDN/O33MncTSN0DgiXHc
+pDPoOBpdRG9yJvNxw/Vy+C95lQ51XAnMnDY4q/3lvJQO9LV1zor3kOyAZUzc59B
AmPULIQouRiGlso70BHFQ8DMZi5pPopK/0zo2jlYI8uzS9OlvQMfgLIo476uS6kh
4ZJTqJQZOHi1WIHbZsGVU5/JESR/vfJ5QIzC1NaFHA==
=nrzV
-----END PGP SIGNATURE-----

--QWIFStbFpmlD00Pf--

