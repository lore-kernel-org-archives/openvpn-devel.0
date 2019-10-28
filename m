Date: Mon, 28 Oct 2019 21:48:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191028204825.GI40538@...1296...>
References: <20190724152934.9884-1-arne@...1227...>
 <201908161931.x7GJVqP9044592@...2054...>
 <CAKxU2N8dmzKb4ui85BYeoGgCyOtXNT2bOcgsC5HCCGsTNjUMYQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7ohyzAr2DuZRs7WU"
Content-Disposition: inline
In-Reply-To: <CAKxU2N8dmzKb4ui85BYeoGgCyOtXNT2bOcgsC5HCCGsTNjUMYQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: openssl: Fix compilation
 without deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--7ohyzAr2DuZRs7WU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 16, 2019 at 12:42:46PM -0700, Rosen Penev wrote:
> On Fri, Aug 16, 2019 at 12:31 PM Gert Doering <gert@...1296...> wrote:
> >
> > Your patch has been applied to the master branch.
> >
> > Is this also suitable for release/2.4?  "You folks tell me, I do the
> > cherry-picking" (if it applies) :-)
> 2.4 is what I did my testing on, so yes.

So - took me a bit, but here we go.  I backported this and the
mbedtls explosive patch to release/2.4, for long-term compatibility
reasons.

commit 416532f8e4125adb7862b2dce5c2d47d85b260df (HEAD -> release/2.4, matto=
ck/re
lease/2.4)
Author: Antonio Quartulli <a@...2181...>
Date:   Fri Aug 16 22:49:45 2019 +0200

    mbedtls: fix segfault by calling mbedtls_cipher_free() in cipher_ctx_fr=
ee()

commit 66b93b5e708b48778a5954fdcfe708b76b947a06
Author: Rosen Penev <rosenp@...277...>
Date:   Wed Jul 24 17:29:34 2019 +0200

    openssl: Fix compilation without deprecated OpenSSL 1.1 APIs


I've sent the combo to the buildslaves, and no explosions were seen -
and besides them, I tested mbedtls 2.17.0, OpenSSL 1.1.1 and OpenSSL 1.0.2o
locally (no explosions either).

Good to go... :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7ohyzAr2DuZRs7WU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdt1QZAAoJEB2Cnv7KVigSX8IL/1hN+0di/hiwVHxvuOvMwEUD
A9Gv+lLM3jdH0N0nNoRW4yYI7qPrEix5tBb+3AAbFrq2m5Hnx9sFavkgEropUEL3
XbPGzXXiTwGLfVraQjwfyWsfj0UM/GluAFmcWnL5CP3WgBZjVpDZiTdINPXoqhtE
s+KowNm4uCwDVh6AbmrFfIs47RfZ4dvLyKcF2S4vEYfhd39R4zn76VY+nlrxDxyL
crUwRhbzJUk0kX5Gh3QuHVBdMTfJCjZNl7varPczCgvisEXc7wlCEc7F73oWF76B
IQKY1B5tsuGQQAr6Kkzi3xvko0JJWDeOVh7qFpIm+a4+UX8V4gz741ytNuDbpe6Z
yhMCqqwTpU3i5Hqs15hscxEa4TKsVhUjLdpviAwVms5fA9t+9w9mQx0h67Dyb4Wc
HqW56HJVrzmz0Bqyb0E5rwnKP9mJBQHyAg/3rWg43YImcUB8GZV1MuwUBlDvuyz4
hIVWGcZ6SLoQT/Rsy+zcbHllodw/DYD7SxbkuQbv8w==
=yMyB
-----END PGP SIGNATURE-----

--7ohyzAr2DuZRs7WU--

