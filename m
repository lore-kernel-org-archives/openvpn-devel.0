Date: Sun, 24 Sep 2017 17:40:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170924154058.GF70062@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
 <20170922205944.GA70062@...1296...>
 <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7jzg8fevGm/yfsZp"
Content-Disposition: inline
In-Reply-To: <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--7jzg8fevGm/yfsZp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 23, 2017 at 10:52:16AM +0200, Simon Matter wrote:
> > Feature-ACK (I think this is a useful idea, for the same reasons we have
> > LZO and OpenSSL versions :-) ), but that will not work if we use
> > compat-lz4.h, so "code NAK".
>=20
> IIRC at the time of writing this, the embedded lz4 was too old and didn't
> have the LZ4_versionString() function. So the code won't work with the
> patch. If the embedded code has LZ4_versionString() now, it should be ok.

Well, it will still lead to compile blowup if you try to include a
non-existing "lz4.h" - no matter if the embedded version has=20
LZ4_versionString() or not...

But indeed, we should upgrade bundled LZ4.  We have a script for that,
we just never used it.  For whatever reason.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7jzg8fevGm/yfsZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZx9IJAAoJEB2Cnv7KVigSfD0MAIbg/4rQtQP5Q7oFvHhpUE9u
jEmNaXW0NTeVUpkEdNiS08hz09MNJewFLJuKUS+i0UUYuERC3M5xk9PxHcdZ9eMW
OD8Xm12YbiBdZLS8GBKZ3qvnlHqPfI0zHxe6xcz9C6j4/udtQc2lFB2GYbQyZHt8
MN7eYSnz6qDEWNaOCijO4J1Oq7PkTTUgwrOvQx4u9ZhwBKF0OoDS1I6ogQKc4GKn
EyYDhdoXcHFix5Qt/SSm1jWOiUHUX6R1vg+5Hl+iFsrOe6EUub9aVHzcRNYfAvCK
EEQZ3c2BllOj7u0p4cK4HaA1e54JuINVlIYUeER4wGYcpWJB0iJt+m7WNyLaEFyI
atyyLFISx6oiVLSoxV/HfIzY8wuvGAMALJtUhgQiPCJk6PKLvvM/313A0HPofRm5
kZKsFGa1vKC15iqHJICbVJjc3RVKvckhHBKbUGz2OsswEJfqvbzq8gy6tBbksKAh
Y/izLzUszzTrGH0qzxnPNcHHC3piypq8P6b2oZhMzw==
=lf2u
-----END PGP SIGNATURE-----

--7jzg8fevGm/yfsZp--

