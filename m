Date: Thu, 7 Sep 2017 08:12:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170907061200.GB70062@...1296...>
References: <20170907012225.21661-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cih9CcvR6VAUKoGd"
Content-Disposition: inline
In-Reply-To: <20170907012225.21661-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling
 is done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--cih9CcvR6VAUKoGd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 03:22:25AM +0200, David Sommerseth wrote:
> This change will expect the system to have LZ4 libraries and headers
> installed by default.  We still carry a bundled LZ4 library, which
> must now be explicitly enabled through providing --enable-bundled-lz4
> to ./configure.  Otherwise, as before, --disable-lz4 will completely
> remove any LZ4 support.

I'm totally missing the *reason* why you want to change this

We don't have --enable-bundled-compat flags for the rest of the things
in compat/ either, don't we?

Also, I can't see consensus that "remove the bundled lz4" is the way to=20
go - this was on the plate for the hackathon to discuss.  You and Antonio
are convinced that this is a good way forward, applying a very specific=20
Linux-distro-based mindset to it ("missing libraries are a problem of the
package builder, why should we care?") - please listen to my arguments: the=
re
are people out there that build OpenVPN from source (tarball or git), and
they are looking at library dependencies with a slightly different view.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cih9CcvR6VAUKoGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZsOMvAAoJEB2Cnv7KVigSIOsL/07ymuPgsJBv2zW9V2rdk0Xk
3hrKWa6oxFD1wX0wnOde4CrbUuveaLWc2qhXoSIEBd+BWHWuHiUbOcE02yIPNOGX
+otOnERxzSk7tUBLNNeLu2I7ThWyGhu5t5+iWDroAKqT819PfkEnInMWYv0lw12h
4MLPvK0DEJBSwF7JwMjNzD1zHCtBgRMI7Rt1MYvJTvguYKnNb285DpOjXFp+9Wn5
bufojkaEJtiyu7UHk12nPutHRRByPdYJW/cyKmQCyZMddLpgNm3NMtI2vfrPFCbF
DlBxVHef+OlQ0BAm+pSA0UCAKbxU7AqWYhX84nySoMGF4/XrlZX5iApbqI3ZnP2z
KkJ/46ZeWrxnVtslXJG+xjixgCJL1KHnwyVJBwT0c7g53tiTrpwmc33JsXRvO7aU
6W9uV9d2nR7ntHF/tnXm/Hm5ytFMAoViwNpz65vcYzqe2mHTYKGV5VXvUVnKHShI
UVqDGvpu79BS0ZKv3043eIOVBZUAt3tArd28Um25uQ==
=vanP
-----END PGP SIGNATURE-----

--cih9CcvR6VAUKoGd--

