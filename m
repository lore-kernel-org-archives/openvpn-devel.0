References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a766bfda-08dd-0984-c310-e9fc502326b0@...515...>
Date: Wed, 8 Mar 2017 21:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
Subject: Re: [Openvpn-devel] could be gitlab-ci an alternative to buildbot
 cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 05/03/2017 16:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> Hello,
>=20
> there was some buzz related to improvement of testing system, like
> patchwork.
> we tried gitlab-ci on our internal project, it looks very promising.
>=20
> since openvpn is already hosted on gitlab.com <http://gitlab.com>,
> there's a possibility of
>=20
> 1) users can add their own gitlab-ci agents to the repo
> 2) it might be even windows agents
> 3) build results are publicly available (not easy to get from buildbot)

Buildbot is behind VPN because of security reasons. We can easily grant
more access to its WebUI if we need to. So far there has not been a
pressing need to do that.

Afaik it would be possible to run a Windows buildslaves. The problem is
that OpenVPN Windows building tends to suck. Hence we have the custom
hacked together cross-compile "buildslave" that makes use of openvpn-build.

> it looks like a big step, and it is hard to predict its result. but, I
> think we can try and have a look at it.
> thoughts?

Personally I'm not too keen to migrate away from Buildbot unless there
are very significant benefits. Not having to configure any
agents/buildslaves would be such a benefit imho.

That said, I will have a look at gitlab-ci to see what it can do.

>=20
> Cheers,
> Ilya Shipitsin
>=20
> p.s. for our internal projects gitlab agents are always available, I did
> not try yet how it works when some agents are unavalaible
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

