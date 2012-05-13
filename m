Date: Sun, 13 May 2012 11:01:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513090153.GG1359@...1296...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gZyN7ilQ5rV5bB+g"
Content-Disposition: inline
In-Reply-To: <363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Crist <ecrist@...1286...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--gZyN7ilQ5rV5bB+g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 12, 2012 at 05:22:52PM -0400, Eric Crist wrote:
> My two cents on this is as follows:
>=20
> As a package maintainer, I think this is going to prove to be a lot of=20
> work.  It means there are more packages to maintain, over the one I=20
> need to now.=20=20

Yeah.  From a sysadmin perspective, super-modular projects like Xorg or
teTeX really make my life miserable - and I do not see particular gain
in moving things that are part of "the openvpn package" into separate=20
projects.

(Windows TAP is fine, as it's really a project on its own, useful for
openvpn, but not that closely tied to it)

> HOWEVER, from the OpenVPN development process, I think it's best
> to split things out, as Alon suggests, with one caveat.  Let's wait
> for 3.0.  That's already going to be a massive change to our source
> tree and overall build process, and I think it would be the right
> time to push that out.

Even then.  Modular source doesn't mean everything gets fragmented in
500 teeny little packages where package maintainers or sysadmins have
to figure out which 395 of those they need, and which ones can be
skipped.

Try to build Xorg or teTeX yourself, from packages, and learn from it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gZyN7ilQ5rV5bB+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT694gakuBuNlUUl1AQL+sgP/R2tmBBhiELrpLfOj3EyZrujKCmHumaPz
UhynWz5npM2ksyrueI7jWuFsuDLm9HbOh9tneYmhMyxfcyddFQxHUtB9PtZw2ZhO
0p8HXEp698+qrTl5HqlxYAuCYii+Rt5pBMRpTGTU9sC/3pUZlU28OClxithaou8c
JfEQ8Ovmr/A=
=yweC
-----END PGP SIGNATURE-----

--gZyN7ilQ5rV5bB+g--

