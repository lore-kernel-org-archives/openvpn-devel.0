MIME-Version: 1.0
In-Reply-To: <20160607082014.GQ53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<20160607075659.GM53051@...1296...>
	<448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
	<20160607082014.GQ53051@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 13:27:52 +0500
Message-ID: <CAFHpkQH4_D7Gi-ivDADk=uyqBFm7wh0t-YShiJbBadanWOkKxQ@...278...>
Content-Type: multipart/alternative; boundary=e89a8f83a4891e113f0534abf772
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--e89a8f83a4891e113f0534abf772
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as for Travis-CI builds, there's such possibility already

1) register at github.com
2) add your own repo to travis-ci.org
3) voila, you can attack Pentagon from travis-ci cloud

the way of "add some attacking code to openvpn codebase" seems to be much
more complicated

2016-06-07 13:20 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Tue, Jun 07, 2016 at 11:08:47AM +0300, Samuli Sepp=C3=A4nen wrote:
> > > we can't open this to the world, as the t_client tests need sudo
> > > privileges, so anyone who can push a patch to a testing tree can run
> > > arbitrary commands on the buildslaves ("just build whatever you want
> > > into something called 'openvpn' and run that with sudo from t_client")
> -
> > > so, (semi-)trusted developers only.
> >
> > This is not entirely true, because the build steps are hardcoded.
>
> Trivial :-) - just add a patch that will
>
>   cp evilscript.sh src/openvpn/openvpn
>
> at the end of the build phase.
>
> Then, run "make check", and t_client.sh will happily execute
>
>   sudo src/openvpn/openvpn $options
>
> which now runs "evilscript.sh" with full root access...
>
>
> > However, I would definitely not open this to the world, because there is
> > plenty of room for misuse, and Buildbot might have security issues which
> > could be exploited.
>
> Ideed :-)
>
> [..]
> > It seems that a summary of how Vagrant operates is in order here.
> >
> > Vagrant uses pre-built images as a starting point. These images do not
> > (and should not) be built by OpenVPN developers. The only things _we_
> > have to maintain are the Vagrant files, which are basically recipies for
> > configuring the base boxes into an OpenVPN test VMs.
> >
> > So, when a developer wants to run the integration tests this is what
> > happens:
> >
> > - Vagrant fetches the pre-built VM images from a remote source
> > - The image is launched into Virtualbox (or other virtualization system)
> > - Vagrant runs the initialization scripts in the Vagrantfile
> > - The system is ready to use and stored for future use
>
> So what VM images are available today, especially regarding *BSD, Solaris,
> MacOS?  Who would be maintaining them, like, adding OS updates, installing
> the tools needed to build OpenVPN (on a fresh Solaris system, you can't
> build *anything*, for example)...
>
> Fire up a linux VM is totally trivial :-)
>
> [..]
> > Summary: very little maintenance is required for Vagrant. It is not like
> > buildbot, where we actually have to build the VMs from scratch.
>
> This sounds great but I have a hard time actually believing it...
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> -------------------------------------------------------------------------=
-----
> What NetFlow Analyzer can do for you? Monitors network bandwidth and
> traffic
> patterns at an interface-level. Reveals which users, apps, and protocols
> are
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> J-Flow, sFlow and other flows. Make informed decisions using capacity
> planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--e89a8f83a4891e113f0534abf772
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>as for Travis-CI builds, there&#39;s s=
uch possibility already<br><br></div>1) register at <a href=3D"http://githu=
b.com">github.com</a><br></div>2) add your own repo to <a href=3D"http://tr=
avis-ci.org">travis-ci.org</a><br></div>3) voila, you can attack Pentagon f=
rom travis-ci cloud<br><br></div>the way of &quot;add some attacking code t=
o openvpn codebase&quot; seems to be much more complicated<br></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-07 13:20 GMT+05:=
00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." ta=
rget=3D"_blank">gert@...1296...</a>&gt;</span>:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">Hi,<br>
<span class=3D""><br>
On Tue, Jun 07, 2016 at 11:08:47AM +0300, Samuli Sepp=C3=A4nen wrote:<br>
&gt; &gt; we can&#39;t open this to the world, as the t_client tests need s=
udo<br>
&gt; &gt; privileges, so anyone who can push a patch to a testing tree can =
run<br>
&gt; &gt; arbitrary commands on the buildslaves (&quot;just build whatever =
you want<br>
&gt; &gt; into something called &#39;openvpn&#39; and run that with sudo fr=
om t_client&quot;) -<br>
&gt; &gt; so, (semi-)trusted developers only.<br>
&gt;<br>
&gt; This is not entirely true, because the build steps are hardcoded.<br>
<br>
</span>Trivial :-) - just add a patch that will<br>
<br>
=C2=A0 cp evilscript.sh src/openvpn/openvpn<br>
<br>
at the end of the build phase.<br>
<br>
Then, run &quot;make check&quot;, and t_client.sh will happily execute<br>
<br>
=C2=A0 sudo src/openvpn/openvpn $options<br>
<br>
which now runs &quot;evilscript.sh&quot; with full root access...<br>
<span class=3D""><br>
<br>
&gt; However, I would definitely not open this to the world, because there =
is<br>
&gt; plenty of room for misuse, and Buildbot might have security issues whi=
ch<br>
&gt; could be exploited.<br>
<br>
</span>Ideed :-)<br>
<br>
[..]<br>
<span class=3D"">&gt; It seems that a summary of how Vagrant operates is in=
 order here.<br>
&gt;<br>
&gt; Vagrant uses pre-built images as a starting point. These images do not=
<br>
&gt; (and should not) be built by OpenVPN developers. The only things _we_<=
br>
&gt; have to maintain are the Vagrant files, which are basically recipies f=
or<br>
&gt; configuring the base boxes into an OpenVPN test VMs.<br>
&gt;<br>
&gt; So, when a developer wants to run the integration tests this is what<b=
r>
&gt; happens:<br>
&gt;<br>
&gt; - Vagrant fetches the pre-built VM images from a remote source<br>
&gt; - The image is launched into Virtualbox (or other virtualization syste=
m)<br>
&gt; - Vagrant runs the initialization scripts in the Vagrantfile<br>
&gt; - The system is ready to use and stored for future use<br>
<br>
</span>So what VM images are available today, especially regarding *BSD, So=
laris,<br>
MacOS?=C2=A0 Who would be maintaining them, like, adding OS updates, instal=
ling<br>
the tools needed to build OpenVPN (on a fresh Solaris system, you can&#39;t=
<br>
build *anything*, for example)...<br>
<br>
Fire up a linux VM is totally trivial :-)<br>
<br>
[..]<br>
<span class=3D"">&gt; Summary: very little maintenance is required for Vagr=
ant. It is not like<br>
&gt; buildbot, where we actually have to build the VMs from scratch.<br>
<br>
</span>This sounds great but I have a hard time actually believing it...<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</div></div><br>-----------------------------------------------------------=
-------------------<br>
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffi=
c<br>
patterns at an interface-level. Reveals which users, apps, and protocols ar=
e<br>
consuming the most bandwidth. Provides multi-vendor support for NetFlow,<br>
J-Flow, sFlow and other flows. Make informed decisions using capacity<br>
planning reports. <a href=3D"https://ad.doubleclick.net/ddm/clk/305295220;1=
32659582;e" rel=3D"noreferrer" target=3D"_blank">https://ad.doubleclick.net=
/ddm/clk/305295220;132659582;e</a><br>_____________________________________=
__________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--e89a8f83a4891e113f0534abf772--

