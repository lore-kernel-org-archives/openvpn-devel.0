Date: Sat, 9 Apr 2022 16:33:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YlGZNdcwYdVt4FSQ@...1296...>
References: <CAAYFXLmLN3mJ1hqJrhhhqBeXwWaFHOMCMUx91BujJpnm0KM-Kg@...278...>
 <YlFBo/UOAxeNlBPf@...1296...>
 <CAAYFXL=AiKBkn86y-e7tQZyDvcD9WyM614MAWa7ML_a505w_cg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GQgjdCg7hYb4hIaI"
Content-Disposition: inline
In-Reply-To: <CAAYFXL=AiKBkn86y-e7tQZyDvcD9WyM614MAWa7ML_a505w_cg@...278...>
Subject: Re: [Openvpn-devel] Tips for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GQgjdCg7hYb4hIaI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 09, 2022 at 01:37:02PM +0000, Pete Nelson wrote:
> It sounds like a framework that runs some basic client and server tests,
> say based on docker, may be a welcome contribution.

There are a few more basic tests (t_lpback.sh, t_cltsrv.sh) to do
"basic client/server TLS test" and "basic crypto" - but there certainly
is room for tests that "just work and excercise code" without having to
setup extra VMs.

(My stuff - t_client.sh - uses only basic shell because it needs to run
these tests on all the supported OSes except Windows)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GQgjdCg7hYb4hIaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiUZk1AAoJEB2Cnv7KVigSeQYMAKVR/Rz2x8H+wXGlsUJA0XUG
3DTZ1i/vv4/K9oERgCEcGRGkVU7IXSxkE94ZTTlnJp0cBEPUaeCVGtMuixSNI5eM
GNVYTQf0tc8whPKf26TdQZXhJk7lPqdi8GfCxRQV4GM13sNNBcjFp8JkcL11kaPT
Xkh6TfqTdd4M8aPA+NRpuldce8BnQKprsrmRAdDWu1C52v5HkL9jEQ+FsH5cW+Au
+r1vF0yrWmLArDlPfwK3RatPfcMpwvWysAIQNWTOG5s1bSmdQl+8hV2lVOVyCGHK
Ryg7YnMAg0OsqlKiNNwaScwkPIIGFO6Gy8NPamHesVqq7AObopIHYEH2b2t+KEZw
YXABkrLF1+WmZ+E/mY5Bbk9Ikb3jHlg2ScFyI97wXJeuTQ/Jt+eEjjgse+pt2eOZ
lMZTNSa0/FJ6zMvADcgDLB2gsXn7pZIJnPxAnqIhioy1A6Jj3rs0s25uqK+qzRBW
95irtM1PWaC+A2OZrKvXNaaMwhB+PbPdL/GF1npAPQ==
=YlqF
-----END PGP SIGNATURE-----

--GQgjdCg7hYb4hIaI--

