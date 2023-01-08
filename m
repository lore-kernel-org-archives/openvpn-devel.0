Date: Sun, 8 Jan 2023 20:27:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7sZHFdSFS8mY3mi@...1296...>
References: <20230101215109.1521549-6-selva.nair@...277...>
 <20230102194322.1560285-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PKoiK1FMk6B8Nt1A"
Content-Disposition: inline
In-Reply-To: <20230102194322.1560285-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Improve signal handling using
 POSIX sigaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--PKoiK1FMk6B8Nt1A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 02, 2023 at 02:43:22PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Currently we use the old signal API which follows system-V or
> BSD semantics depending on the platform and/or feature-set macros.
> Further, signal has many weaknesses which makes proper masking
> (blocking) of signals during update not possible.

Just for the record - as discussed before, this is considered too
intrusive ("needs more testing") for 2.6.0, and can go in early in
the 2.7 phase.

Even if it gets an ACK before 2.6.0 release, I'll still postpone it,
because having a git master almost identical to release/2.6 makes
testing "last minute 2.6 stuff" much easier for me.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PKoiK1FMk6B8Nt1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjuxkcAAoJEB2Cnv7KVigSUo4L+wfGm/h9pQnp/qcjLU3lvC2r
zmrk54hVCDucl9e8MMFfhy9+EG1Nj74PZAC4BvYLabTJd8zx8KhwnFFhyNvo9XNF
04NZnPBvASMZJtUuZ55zYgGGlYMXxB4JluREzWjIsrUExqSpDJAmKPr9Qvw2h9y+
KuETcZ3RTRCWRXH+Y+yilnY35rTEuqkt9OdMHFgbB4MqdJYZ7cJpgw7SXpuj3Q2f
mPwq0kaWTiD7/92aJ/ocZVoTe+6qOodG8cYq/vJyix+bfySPA1yb/C8RYUrIOSuI
+vYzZvbVfmKN7mxv0/HAL6elewX8iLIVJUfouBawoZRpeClpLKp8hw19WqnzKNg+
nD4sstRmWlDZXgGYo0Ps39mEkFToQAsbwUnL5LwChFvNSzRGB0vG0pWx9pIfNu+s
0FVR+tZT6piZRuYJU6ZY9loLvBGRxGUIWhP7IBofOIAgT9YMVvIbIEBFC7NVeGsD
+eI8g4k2+4d2C7ADIgLIPUx+llMS23avLTruKUfPNA==
=u5ev
-----END PGP SIGNATURE-----

--PKoiK1FMk6B8Nt1A--

