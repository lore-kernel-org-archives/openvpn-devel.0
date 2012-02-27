Date: Mon, 27 Feb 2012 19:25:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120227182545.GO7024@...1296...>
References: <4F4978D2.70706@...1030...>
	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
	<4F4A31E1.2080503@...1030...>
	<CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>
	<4F4A4929.6040407@...1030...>
	<CAOazyz1wNQQgxTciUq0uQjfMyDSJqDdpy63LcUpcwXbs3pWsxQ@...278...>
	<4F4A52DB.1040907@...1030...>
	<CAOazyz2SyQjGk9w00KA93tKUyyMMY9iQ3rL=C8X0wpFKFrLZrw@...278...>
	<4F4B584A.30705@...515...> <4F4BA12E.4080707@...1030...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+dJ5Ea9E9bxtHwvD"
Content-Disposition: inline
In-Reply-To: <4F4BA12E.4080707@...1030...>
Subject: Re: [Openvpn-devel] static build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--+dJ5Ea9E9bxtHwvD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 27, 2012 at 03:28:46PM +0000, Mr Dash Four wrote:
> The Alon's version of "openvpn 2.3_alpha1" is very different from=20
> "openvpn 2.3_alpha1" downloaded from the official openvpn git repository=
=20
> using the same tag! If you do not believe me - take a look for yourself.

This is well understood.=20=20

The C sources are (basically) the same, but in Alon's tree, the build=20
system has been re-built from scratch, from "something that sort-of works"=
=20
to something new, which is more flexible, and (most important here) handles=
=20
cross-building including all the dependencies in a fully automated way.

As soon as the rest of the OpenVPN developers agree on all the details,
Alon's changes will be integrated into the "main" openvpn git.

> I don't mind Alon (or anybody else for that matter) altering the openvpn=
=20
> source code and its structure, because at the end of the day it is an=20
> open source project, but to give it a name like "openvpn 2.3_alpha1"=20
> clearly implying that this is the official "openvpn 2.3_alpha1" source=20
> without explicitly stating that there were alterations/changes made to=20
> that source code is clearly very misleading and in this respect Alon is=20
> no better than the scum out there offering "loaded" source code of=20
> well-known software products to naive idiots like myself, stupid enough=20
> to download it.

Alon's new build system was announced here on the list just a few days
ago.

> As for the main topic of this thread - static build of openvpn, the=20
> following is the last gcc command line which links and creates the final=
=20
> openvpn executable (again, using the "standard" openvpn source and not=20
> the mickey-mouse version Alon is "offering") - judge for yourself=20
> whether this produces a monolithic, statically-linked openvpn executable:

We don't care.  Really.  Alon's build system is where the journey is
going to, and we are not going to do piecemeal fixes in the existing
build system.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+dJ5Ea9E9bxtHwvD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0vKqakuBuNlUUl1AQIkNQP9GtS07JLCHdOG/n1eqe2gKHg4Qvy+DcD5
8n1uTy2OpVRHnc8YJv2XR1ECSm45N2vGd3clrcxCeqQGSzG6YIHsSkFpzvFKP7h6
TE8dAYZMhDSsvM2bRn2WgkYf15QaLl1wAenVxKa8wn5EVP4QsWVRL7+vNN9HcMOx
3PGGYJJ0wy0=
=KMLY
-----END PGP SIGNATURE-----

--+dJ5Ea9E9bxtHwvD--

