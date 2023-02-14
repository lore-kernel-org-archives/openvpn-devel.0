Date: Tue, 14 Feb 2023 19:48:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+vXhBceBu0v7SLb@...1296...>
References: <20230206112218.51430-1-frank@...2641...>
 <20230207132026.41580-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nQja6xyto0dQ+DsD"
Content-Disposition: inline
In-Reply-To: <20230207132026.41580-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v3] configure: enable DCO by default on
 FreeBSD/Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--nQja6xyto0dQ+DsD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2023 at 02:20:26PM +0100, Frank Lichtenheld wrote:
> Automatically disabled when
> - iproute2 is enabled
>   (Don't want to force people specifying --disable-dco explicitely)
> - libnv is missing on FreeBSD
>   (FreeBSD version too old anyway)
>=20
> Will still error out if libnl-genl is missing on Linux to
> make people aware of the new dependency.

Indeed it does, and all GH Ubuntu instances are now dark red...

https://github.com/cron2/openvpn/actions/runs/4177012136/jobs/7234044968

Can I have a v4 that updates the GH requirements so we can merge this
without all red...?

The change should be trivial...

      - name: Install dependencies
        run: sudo apt update && sudo apt install -y mingw-w64 libtool autom=
ake autoconf man2html unzip cmake ninja-build build-essential wget

... but having it in this same patch would mean "no single commit is
broken, if avoidable"

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nQja6xyto0dQ+DsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj69eEAAoJEB2Cnv7KVigSNbkMAJ9aeBybkg86YIwp8x+eOXCv
t63dwObLzcSUTi6ih8Xgpu3FxZ/aqpZ/IvnJYLkA1zEWFToMM8YjcNJ7BGp9BN/t
Q/DN7hVRNKee8AFI+Vv/OBvTcJSETN7r2Qw2g8g09Uwpe7w581lgGj2tBvipsbkq
cBfgOHSxkL1NmpE/G7uE97R1eKrl5BS5coBrYy17Z9rc2EJ6K4EgHLxiBMyG54et
UIw//GA1PZpdwCtqWAxRZbmteikDy7AViiqXKEM+ca3hUMVYguarN3lprJ6phIyG
DAYvHC/PpixZTZV/6AFn8L/BSW3BA2jXWiKeQlUUnD2k/8dnFVuTDBfuuGNlfzvr
3d/uc1iE/DZrw3aNiLFOaJbxOdhVYbBjnrki/S8E/f92tQBwG8HT4CjEWhjne4dD
0eusfmjnEX3Qkah+p0cV9gHNNsFRvQfuWD9a1ZRrLmLEd7rxVHyTkHRLPU6sCA4e
5MOivKytlqVUmjMLeNkpgoXvoke8yWytErSeUPibLA==
=uQto
-----END PGP SIGNATURE-----

--nQja6xyto0dQ+DsD--

