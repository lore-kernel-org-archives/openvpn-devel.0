Date: Tue, 7 Jun 2016 10:20:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607082014.GQ53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<20160607075659.GM53051@...1296...>
	<448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MN5vtCM05guKRJd9"
Content-Disposition: inline
In-Reply-To: <448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MN5vtCM05guKRJd9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 11:08:47AM +0300, Samuli Sepp=E4nen wrote:
> > we can't open this to the world, as the t_client tests need sudo
> > privileges, so anyone who can push a patch to a testing tree can run
> > arbitrary commands on the buildslaves ("just build whatever you want
> > into something called 'openvpn' and run that with sudo from t_client") -
> > so, (semi-)trusted developers only.
>=20
> This is not entirely true, because the build steps are hardcoded.=20

Trivial :-) - just add a patch that will=20

  cp evilscript.sh src/openvpn/openvpn

at the end of the build phase.

Then, run "make check", and t_client.sh will happily execute

  sudo src/openvpn/openvpn $options

which now runs "evilscript.sh" with full root access...
=20

> However, I would definitely not open this to the world, because there is=
=20
> plenty of room for misuse, and Buildbot might have security issues which=
=20
> could be exploited.

Ideed :-)

[..]
> It seems that a summary of how Vagrant operates is in order here.
>=20
> Vagrant uses pre-built images as a starting point. These images do not=20
> (and should not) be built by OpenVPN developers. The only things _we_=20
> have to maintain are the Vagrant files, which are basically recipies for=
=20
> configuring the base boxes into an OpenVPN test VMs.
>=20
> So, when a developer wants to run the integration tests this is what=20
> happens:
>=20
> - Vagrant fetches the pre-built VM images from a remote source
> - The image is launched into Virtualbox (or other virtualization system)
> - Vagrant runs the initialization scripts in the Vagrantfile
> - The system is ready to use and stored for future use

So what VM images are available today, especially regarding *BSD, Solaris,
MacOS?  Who would be maintaining them, like, adding OS updates, installing
the tools needed to build OpenVPN (on a fresh Solaris system, you can't
build *anything*, for example)...

Fire up a linux VM is totally trivial :-)

[..]
> Summary: very little maintenance is required for Vagrant. It is not like=
=20
> buildbot, where we actually have to build the VMs from scratch.

This sounds great but I have a hard time actually believing it...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MN5vtCM05guKRJd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1aDvakuBuNlUUl1AQIdVAP/YBGSTlDAUaKbOn4kJxS/DFZPE4LvpOP4
DzQcV1ENtavjcvZED9vE9jtQVxO1LBNrkOBiWTDXy8qjLtJwwTkn4AmjBfrV2nhq
JXtEK3Iv6Ueq6T0durZAvsaKTaDlQOmBQHYHSDu84yvG1j525QjfB89yTcpDTyVT
F3g4iYF14MA=
=ZfP/
-----END PGP SIGNATURE-----

--MN5vtCM05guKRJd9--

