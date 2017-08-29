Date: Tue, 29 Aug 2017 21:03:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170829190353.GX70062@...1296...>
References: <201708291322.v7TDMcY3029206@...2300...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uwJuRjKj6RbLtb4h"
Content-Disposition: inline
In-Reply-To: <201708291322.v7TDMcY3029206@...2300...>
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Casper.Dik@...2299...
Cc: openvpn-devel@lists.sourceforge.net

--uwJuRjKj6RbLtb4h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Casper,

On Tue, Aug 29, 2017 at 03:22:38PM +0200, Casper.Dik@...2299... wrote:
> I recently run into the same problem as Jens Neuhalfen has reported
> more than a year ago in this mailing list.
>=20
> As I was somewhat confused why the shipped Solaris openssl version failed=
,=20
> I looked into that issue as I also wanted to run a recent=20
> openvpn on Solaris 11.x.

Oh.  That's the bit I missed - I tried reproducing it with various
openssl versions, but my OpenSolaris test VM is so old that the *shipped*
version didn't have GCM support yet...

> After I figured out where we went wrong, I filed:
>=20
> 26336744 Solaris specific cleanup code breaks gcm_aes for, e.g., openvpn
>=20
> which has now been fixed in oracle solaris-userland on git hub
>=20
> https://github.com/oracle/solaris-userland/tree/master/components/openssl

Cool, thanks a lot!

> It cannot say exactly when it will be in Solaris 11.3 SRU (patch) release.
>=20
> Current workaround is disabling AES-GCM for openvpn but that should not b=
e=20
> needed in the future.

Is there a way to reliably detect this issue from a test program (or by
looking at system versions, like "uname")?  It might be worth adding a=20
configure test so users won't run into it ("AES-GCM disabled due to=20
bug 26336744 in Solaris OpenSSL").

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uwJuRjKj6RbLtb4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZpbqYAAoJEB2Cnv7KVigSqkwL/RiYYFK9TZSZfKZXvBlh3Cyu
jNhptsK6lgqXZf3Bo2Wz1KbFdAzpde1HBklDU4Cwo+AdlpDmoK3u85/Nf2BaoSos
UfnP8wwT0tJVH2W3CpEzbgcUm0JQhhoo2a4i1quF6h+/toKDuYDuI3kuQGy7dInB
bouCVpoEs8xwE0wFt8vr4cxZwvuMWUxQF47JtRGfQHKS0gWn6owz2DArK8s6Xpt/
c6p9ahAztQJTOpJPsyPeYVH+BuPj2YATFhbm5Hv2lF8LF6spjJ4ab6nUaP5hKpCB
4vu0wsL7QTZMD+Z+PbOnzMLu4z617XsGF1dFpH72B5TREsz5LNf1GftBkcvITzxY
ruBwvmMORLlZcORpfNNnqTh/j4eFS1CDH/h7t79FkYk/9n9jwkExw0FmrU8OL08C
eFNyrtBsR1U+/A6msqV2Gj/irvyuaXeyKFvIK8W/Hi8dfszFCkQCyC2g4Bn9QRXz
bogd1Rq38K0FtLlhnIH5WUw6nDPqkAjZQzXtqnlv/A==
=/29j
-----END PGP SIGNATURE-----

--uwJuRjKj6RbLtb4h--

