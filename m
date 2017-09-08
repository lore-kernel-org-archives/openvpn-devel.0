Date: Fri, 8 Sep 2017 09:05:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170908070529.GR70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
 <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
 <8aaacc62-7c5f-14d0-e1a4-a38b89c90625@...277...>
 <f5e56e77-e810-78d0-47b0-474f660f78b5@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zkS4nBu7xsy2hAaK"
Content-Disposition: inline
In-Reply-To: <f5e56e77-e810-78d0-47b0-474f660f78b5@...277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--zkS4nBu7xsy2hAaK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 08, 2017 at 01:41:15AM +0100, fragmentux wrote:
> WRT systemd and 3rd party 'servers'
>=20
> I am curious to know of any other "Server service" who decide ..
> to *rely* on ..
> a *forced* 'systemd (almost) unconditional restart by default'

Some software provides their own wrapper scripts to ensure restarts
(like squid, for example) because not all systems have facilities to
do that.  So being able to use systemd to ensure the daemon stays up
relieves the developers from cooking their own scripts.

mgetty+sendfax' faxrunqd, for example, is started from /etc/inittab on
systems that do not have systemd - for exactly the same reason: if=20
something happens, faxrunqd gets automatically restarted.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zkS4nBu7xsy2hAaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZskE5AAoJEB2Cnv7KVigSWL0MAJqoiAqGym5KcxjYShykCQHi
KyQsf6i/y+LP5BdgCeh1scxAUshKhySSxfQfijXEzFcEGjm9eTqcTAqzck0itVja
F96cOzz87y/5KkBfxm0PwJJZMbBSyxCSnm0qiScZSOtGzSR8ucIBUSukKYSt3qad
7JCu5uPSe9znKcQhp3r7QmlT67ufiiJjZpRonAjFOgG9hBsbjV1rSZQKgzb09MA+
fU3u0149gLYw0RHX5XJ4CspzeUOfis6nHakXFdvC7skXd4GUrAQ8cuWRjxlVi4+L
xG9/NHWjyrxQ/WbF65q3r3dskFPfz0bFc6Ju3/ZiPj9Nho8UsCJw8IioDghXobzA
/HnVccV88Wk8EERcddcY2ihHpv3hIN39EmHQPAfOm+GtJUdXEALz6rSZ4WIS3a3S
uRDyfA2cXwFZRB4MctDfo3YTCfFCnJvIbFAFVDYjQCm/jfrCfZiEvZe6muFcfDeY
0JiBSizffwp7e/FiVmBj6YgU+xOZfvL2tWnhHPUbOQ==
=sCOA
-----END PGP SIGNATURE-----

--zkS4nBu7xsy2hAaK--

