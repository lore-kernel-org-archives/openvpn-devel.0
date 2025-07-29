Date: Tue, 29 Jul 2025 13:07:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aIireKdz0MHz2Iio@...1296...>
References: <20250729093857.37832-1-kprovost@...2661...>
 <E5429ADC-B338-4BC3-BA6B-F1D23B103D32@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qHkzUcXWYdPpBMSd"
Content-Disposition: inline
In-Reply-To: <E5429ADC-B338-4BC3-BA6B-F1D23B103D32@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] dco-freebsd: pass address scope to
 the kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qHkzUcXWYdPpBMSd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 29, 2025 at 12:55:29PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> This requires kernel side support: [https://reviews.freebsd.org/D51596](h=
ttps://reviews.freebsd.org/D51596)

I did not yet test it, but I assume that including scope-id in the
message to an older kernel will not break anything for non-LLA peers?

(For LLA%scope peers, it will not work today, and won't work without
kernel-side support - this much is clear ;-) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qHkzUcXWYdPpBMSd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoiKt4AAoJEB2Cnv7KVigSKyYL+wUKrg+JtvMDhrmUaah43sRE
5iVBwYxNF0EY0nhG6JIDtsUL6llFdU0NCfefSXVWez0hgICQ1dUNkeNFFS3cjhRL
wlD5eCbqd3LSnUOjRHs3WtTE5aQDrd6aS7XlhaK3at4Ws55JdKEtpgr0wvkr7ZkW
0ESVXyO3I7XNNkYrKPqoVTjupdDODuGkGIkKK/15OlBxJWGJ2toWwdP05XxNATe2
Rs1Pdx7TFhKuAiijlQvgcsOu0rPAAruhpft7ky/xvlmzBRTlDohKWr3EdlC0+tur
5qm7j6sPbiAwc7Qc1IixEWQtUPLHZiqMAG/drLMVvzqFOzwFVVnOD1LpLXnq2mFc
4PIEesQhnFsNh9wpO+aGjutu+bH6Uz/ZaKgP0b8nZxyq6hN+k+5xZ3yXkRviF8yM
kKRKs+FBcx0nIWzNc5NtAn1WrNp3jLNcSbUPoqyPcUlpNNBjpovYJSJeLFFeD/Jw
6xL4mz9yBYhfZA3wWBPf8JM6i5G7uKxQYOKh5qohig==
=Z+hs
-----END PGP SIGNATURE-----

--qHkzUcXWYdPpBMSd--

