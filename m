Date: Thu, 18 Mar 2021 15:34:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210318143410.GD976@...1296...>
References: <20210317181153.83716-1-juliusz@...2525...>
 <202103181321.12IDL2VF012379@...2054...>
 <20210318135631.GB976@...1296...>
 <afecb5ce-3cda-2791-341b-69dff985118e@...2525...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+pYwZR4KY41WqPv1"
Content-Disposition: inline
In-Reply-To: <afecb5ce-3cda-2791-341b-69dff985118e@...2525...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support for wolfSSL in
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--+pYwZR4KY41WqPv1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 18, 2021 at 03:01:16PM +0100, Juliusz Sosinowicz wrote:
> which version of autoconf exactly is causing this explosion?

The one shipped with Ubuntu 16 is "2.69-9" and automake "1.15-4"

which matches NetBSD 8.1

nbsd81$ pkg_info |grep auto
autoconf-2.69nb8    Generates automatic source code configuration scripts
automake-1.16.1     GNU Standards-compliant Makefile generator

so, we need something that works with 2.69 (which seems to be "the gold
standard of autoconf for many years").

Interesting enough, FreeBSD 11.4 has "2.69" as well, and it did not
cause any problems there (that's where I run the "autoreconf -vif" for
my local test-before-push builds).


I do not understand autoconf intricacies well enough to understand
what exactly is going on, though.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+pYwZR4KY41WqPv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgU2ThAAoJEB2Cnv7KVigSVMwL/R/90BWtpqGr7i/U0tIrkS2q
/fAlHaguTlC/zDekQEuic4BTJ1ytrvQBnhBwigpXl4okH7cLu1mslQ60LRHfQVRE
mGD0/nWo5PnwiDpDnkc/25UGPkEYk61eXYSIwo5mWBIM3Ini4QiyixDyJnOZFE6P
5myL9/2tgIiRymnVvVgjuoKwuCt5SGP7p9StwW1MofeHVSpS0Ws+RafO5ozAKaBN
Vkdm8O+jcRSrZ6wr6H1QFYYU4An1UNbJK5AMv1xdB9pM9a4D2Kl0KMNLBlgqF8DD
Y6mod/HNjEYn4CmLlVN/El8a3cQ7RaJpkAz73chf9n5mNjYQ/6m7jvH1AFeqMwJ2
jN0cg8hPgZmu+HrX4mbAK0NU2La08CrfQrBOWR5a7nhe2G34Ui6fMqvzwY8ja5CE
vYjMbpxzjAtWwuO72Lgsz8E+5/UWiT4mt79rl9Xxivn2E+9rkMCFc9snx0KvwF2c
MKAmTPZVflQQ0HVJcH44mRn7QzW+xoOtASweIBeFMQ==
=oWzN
-----END PGP SIGNATURE-----

--+pYwZR4KY41WqPv1--

