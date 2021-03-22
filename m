Date: Mon, 22 Mar 2021 10:55:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210322095538.GK976@...1296...>
References: <20210321144627.1621-1-simon@...2293...>
 <20210321165045.GY976@...1296...>
 <487884f67f874d438ca181de91399c52@...2293...>
 <20210322085411.GG976@...1296...>
 <CAGyAFMWGbuN-0x=V9DpGzL4w+fWhz6d=4ce0x5+cg3DN8HOzKw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3h01JhJKIjUa6KUh"
Content-Disposition: inline
In-Reply-To: <CAGyAFMWGbuN-0x=V9DpGzL4w+fWhz6d=4ce0x5+cg3DN8HOzKw@...278...>
Subject: [Openvpn-devel] Visual Studio building for master/2.6 and LZ4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3h01JhJKIjUa6KUh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(I have changed the Subject: line to make clear that this is a bigger
topic now)

On Mon, Mar 22, 2021 at 11:51:46AM +0200, Lev Stipakov wrote:
> For 2.6, I think we should drop openvpn-build for Windows (VS)
> building and switch to vcpkg for dependencies (openssl, lz4 etc) and
> cmake as a project file (also supported by VS).

I have no opinion there whatsoever...  please send patches & trac=20
documentation :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3h01JhJKIjUa6KUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgWGmZAAoJEB2Cnv7KVigSCZ8MAJv05dJHwT7cZF7D4UfYCGKB
8Kj6kN8a02BsNyAU3cY+lbIfReOr47FNmZQhbWPxwI8Qzf5k2MGo0cIZ/atZE9yX
w/c4RzuHC6MMP4jxuB2Fd2/bpkrV9UPjyOxdckOUeOz2RtKfBLJqCx2SMzd6Pemv
z0Ajjy+xxZRdejKz071VCMOV+G7GwNUhhBH/bIH+syKVkjPe/Hg6SiSHc0il0wWY
2sKOMD2acKxq1z2lJlqtuCwFlJqpvL+xIIrDQN7OnudLGn5Sds4flXgkfX/p5dPS
iP1UC2ZTuiHO5rO6F9K9c+DXMhIKDZmh6akGqYPxc2qaQu726CFLd9IW5Z8owNKl
Ct1L3QTVH7M+LSuTr91aD+LK3fqBbitblSBcWu5/t2NEDzaF8TFml3M9A1ZMHPim
Z1ksnzClyWRv76LzWsej61Nmgq7+gb4rg29vvWeNeREuU3WJWdqV8HifPXXVtuKj
n96aXqwFsjMC+X9V8k8eEa6KeiSdfxTt1UyAH4jCRg==
=f+s8
-----END PGP SIGNATURE-----

--3h01JhJKIjUa6KUh--

