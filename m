Date: Thu, 14 Dec 2017 12:46:29 +0200
From: Borodin Oleg <borodin@...2368...>
Message-ID: <20171214124629.48e2c415@...2368...>
In-Reply-To: <c1077ee2-cedf-2507-339a-55c560b18959@...515...>
References: <20171212134648.286e2416@...2368...>
 <fee81d29-13f8-a3a1-ef95-5ec1fdf2e479@...515...>
 <20171214111203.3a954204@...2368...>
 <f28bdb55-24cf-ed8f-9dc9-39205f282406@...515...>
 <20171214115311.43a7c9eb@...2368...>
 <c1077ee2-cedf-2507-339a-55c560b18959@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn web frontend, vpnsw
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Dec 2017 12:26:22 +0200
Samuli Sepp=C3=A4nen <samuli@...515...> wrote:

> Il 14/12/2017 11:53, Borodin Oleg ha scritto:
> > On Thu, 14 Dec 2017 11:36:46 +0200
> > Samuli Sepp=C3=A4nen <samuli@...515...> wrote:
> >=20=20=20
> >> Il 14/12/2017 11:12, Borodin Oleg ha scritto:=20=20
> >>> On Thu, 14 Dec 2017 10:41:37 +0200
> >>> Samuli Sepp=C3=A4nen <samuli@...515...> wrote:
> >>>=20=20=20=20=20
> >>>> Il 12/12/2017 13:46, Borodin Oleg ha scritto:=20=20=20=20
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> I wrote a small web interface for managing openvpn services and obt=
aining detail network information.=20
> >>>>> http://wiki.unix7.org/vpnsw
> >>>>>
> >>>>> I wrote it to replace a legacy corporate vpn-crutch.=20
> >>>>> It is already quite working, we manage more 400 tunnels/1200 workpl=
aces.
> >>>>>
> >>>>> I have a question: how interesting this product is for continue dev=
eloping?=20
> >>>>> As opensource, of course.
> >>>>>
> >>>>> [Sorry, I sent this also to openvpn-users@]=20=20=20=20=20=20
> >>>>
> >>>> Hi,
> >>>>
> >>>> What is the use-case for vpnsw? Is this meant for managing client
> >>>> connections on an OpenVPN server?
> >>>>=20=20=20=20
> >>>
> >>> Hi, Samuli!
> >>>
> >>> We use it to disable/enable and monitor user/workstation/branch offic=
e groups.
> >>> One VPN service on VPN concentrator related to 5-30 VPN "users", tota=
l to one
> >>> VPNc ~ 100-300, total to company workstation uses VPN direct or indir=
ect ~
> >>> 1400. Disconnection use for routine maintenance (synchronization/exch=
ange of
> >>> application/corporate databases "into night" =3D) or urgently needed,=
 and yet
> >>> etc).
> >>>
> >>> I can of course write a control of each user but so far there was no =
such
> >>> purpose. I also can write to show tail of any service log in runtime.=
=20
> >>> That's why I'm asking if there is an interest in development.=20=20=
=20=20
> >>
> >> I'm sure there are others that could make use of vpnsw. I see that it =
is
> >> already on GitHub:
> >>
> >> <https://github.com/onborodin/vpnsw>
> >>
> >> If you add a description (like what you have on your site) then people
> >> might find it when doing searches. I also noticed that there are no
> >> commit messages - is that intentional?=20=20
> >=20
> > No-no, of course =3D) I was developing one, with own svn, quickly, not =
even thinking
> > about publishing, and only today did export/transfer to git repos.
> >=20=20=20
> >> I can also mention vpnsw this Trac page:
> >>
> >> <https://community.openvpn.net/openvpn/wiki/RelatedProjects>
> >>
> >> That should give vpnsw some additional visibility.=20=20
> >=20
> > I agree. This is a good idea.
> >=20
> >=20=20=20
>=20
> Hi,
>=20
> I fixed a bunch of formatting errors on the RelatedProjects page and
> added your projects there:
>=20
> <https://community.openvpn.net/openvpn/wiki/RelatedProjects>

Thanks! =3D)

> I suggest adding links from vpnsw and minica pages to GitHub so that
> people know where they should send their contributions.

Yes, I agree, it's reasonable. I'm will to plan.

> Any particular reason why you chose the "Creative Commons
> Attribution-NoDerivs 3.0 Unported" license for you work? That is fairly
> uncommon license for software projets.
>=20

Yes, I know. At the time of summer 2017, I did not think much about wide pu=
blishing
=3D). I think to change the license.=20
Thank you for noticing this.

--=20
With best regards,

Oleg Borodin
+7-952-058-72-64
borodin@...2368...
onborodin@...277...

