MIME-Version: 1.0
References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
	<c441396b-e30e-c602-d6a0-aaafb82d8e7a@...1856...>
In-Reply-To: <c441396b-e30e-c602-d6a0-aaafb82d8e7a@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 05 Mar 2017 14:42:49 +0000
Message-ID: <CAFHpkQHi_0LCYofSA1XDRmH2=Y-eJLWPo2j2gfdZvhOeGS=qEA@...278...>
Content-Type: multipart/alternative; boundary=001a1147ded89eef230549fccb10
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--001a1147ded89eef230549fccb10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=92=D1=81, 5 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2017 =D0=B3. =D0=B2 19:37, S=
teffan Karger <steffan@...1856...>:

> Hi,
>
> On 05-03-17 15:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > there was some buzz related to improvement of testing system, like
> > patchwork.
> > we tried gitlab-ci on our internal project, it looks very promising.
> >
> > since openvpn is already hosted on gitlab.com <http://gitlab.com>,
> > there's a possibility of
> >
> > 1) users can add their own gitlab-ci agents to the repo
> > 2) it might be even windows agents
> > 3) build results are publicly available (not easy to get from buildbot)
> >
> > it looks like a big step, and it is hard to predict its result. but, I
> > think we can try and have a look at it.
> > thoughts?
>
> Does this mean that gitlab (as in, the company) controls the build
> slaves?  Or should we host our own gitlab-ci-master to control the slaves?



I thought about gitlab from the point of view to reduce maintaining efforts
of "on premise"
servers. It depends on how much effort we are going to spend on running our
own gitlab-ci-master.

as for test agents, I assume those are dedicated servers, with no other
applications. risk of root access
is not high

>
>
> I currently don't contribute any slaves to the buildbot setup, but I for
> one would never want to give gitlab root on my machines.  Quite some
> OpenVPN functionality requires root, which makes it more tricky to test.
>
> -Steffan
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1147ded89eef230549fccb10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div>=D0=92=D1=81, 5 =D0=BC=D0=B0=D1=80=
=D1=82=D0=B0 2017 =D0=B3. =D0=B2 19:37, Steffan Karger &lt;<a href=3D"mailt=
o:steffan@...1856...">steffan@...1856...</a>&gt;:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Hi,<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
On 05-03-17 15:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br class=3D"gmail_msg">
&gt; there was some buzz related to improvement of testing system, like<br =
class=3D"gmail_msg">
&gt; patchwork.<br class=3D"gmail_msg">
&gt; we tried gitlab-ci on our internal project, it looks very promising.<b=
r class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; since openvpn is already hosted on <a href=3D"http://gitlab.com" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">gitlab.com</a> &lt;<a=
 href=3D"http://gitlab.com" rel=3D"noreferrer" class=3D"gmail_msg" target=
=3D"_blank">http://gitlab.com</a>&gt;,<br class=3D"gmail_msg">
&gt; there&#39;s a possibility of<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; 1) users can add their own gitlab-ci agents to the repo<br class=3D"gm=
ail_msg">
&gt; 2) it might be even windows agents<br class=3D"gmail_msg">
&gt; 3) build results are publicly available (not easy to get from buildbot=
)<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; it looks like a big step, and it is hard to predict its result. but, I=
<br class=3D"gmail_msg">
&gt; think we can try and have a look at it.<br class=3D"gmail_msg">
&gt; thoughts?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Does this mean that gitlab (as in, the company) controls the build<br class=
=3D"gmail_msg">
slaves?=C2=A0 Or should we host our own gitlab-ci-master to control the sla=
ves?</blockquote><div><br></div><div><br></div><div>I thought about gitlab =
from the point of view to reduce maintaining efforts of &quot;on premise&qu=
ot;</div><div>servers. It depends on how much effort we are going to spend =
on running our own gitlab-ci-master.</div><div><br></div><div>as for test a=
gents, I assume those are dedicated servers, with no other applications. ri=
sk of root access</div><div>is not high</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><br class=3D"gmail_msg">
<br class=3D"gmail_msg">
I currently don&#39;t contribute any slaves to the buildbot setup, but I fo=
r<br class=3D"gmail_msg">
one would never want to give gitlab root on my machines.=C2=A0 Quite some<b=
r class=3D"gmail_msg">
OpenVPN functionality requires root, which makes it more tricky to test.<br=
 class=3D"gmail_msg">
<br class=3D"gmail_msg">
-Steffan<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
---------------------------------------------------------------------------=
---<br class=3D"gmail_msg">
Check out the vibrant tech community on one of the world&#39;s most<br clas=
s=3D"gmail_msg">
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">http://sdm.link/slash=
dot</a><br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
Openvpn-devel mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" class=3D"gmail_msg" =
target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br class=3D"gmail=
_msg">
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.sourcef=
orge.net/lists/listinfo/openvpn-devel</a><br class=3D"gmail_msg">
</blockquote></div></div>

--001a1147ded89eef230549fccb10--

