Date: Mon, 23 May 2016 18:04:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160523160426.GL53051@...1296...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...>
	<5742C2E1.2060407@...515...>
	<53A330A9-AA2C-4545-A854-0EF7A9B79A1C@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9zg3lic507r8Z8j"
Content-Disposition: inline
In-Reply-To: <53A330A9-AA2C-4545-A854-0EF7A9B79A1C@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net

--B9zg3lic507r8Z8j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 23, 2016 at 05:43:58PM +0200, Jens Neuhalfen wrote:
> > I'd prefer to keep the actual buildslave infrastructure private, with a=
ccess granted to only a select few. We already get email notifications to a=
 public list for each build failure.
>=20
> Is there some kind of instruction to ?reproduce? the build infrastructure=
? Some kind of document or - even better - something executable (Vagrant/Do=
cker/Salt/Puppet/..)?

https://community.openvpn.net/openvpn/wiki/SettingUpBuildslave

is what we currently have, but it only describes the slaves (talking to
Samuli's build master) - not sure if the master is documented anywhere.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--B9zg3lic507r8Z8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0MqCqkuBuNlUUl1AQKrXwP+K669J2REFuxU7Fma9udPqEvojgsCCzYR
6yN3hXTabXZawP7xFdu+W9wscyAoLo/rXxsCAleMRDfvrFy6vRVy8Hxic/pO4n8D
7Y4FkB0iEdQOozXvLQlEOzOlP7RADItFl0lmdioK17NazNw0+LTk89dYriXkOHWo
Gl76MXx6hW8=
=PxxE
-----END PGP SIGNATURE-----

--B9zg3lic507r8Z8j--

