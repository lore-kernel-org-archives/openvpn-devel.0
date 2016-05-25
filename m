MIME-Version: 1.0
In-Reply-To: <5745D00F.1030309@...2080...>
References: <1464130427-25002-1-git-send-email-selva.nair@...277...>
	<57457A80.4030506@...2080...>
	<CAKuzo_jawxTrgwQtzOhb7vqHJ3LEvULjPNphTRugYmyWMZenSQ@...278...>
	<5745D00F.1030309@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 May 2016 13:11:17 -0400
Message-ID: <CAKuzo_ip-1n7hGzEfQgnOCFHs75WOMJHGOyP8ATm=d-fAf6vLA@...278...>
Content-Type: multipart/alternative; boundary=001a114ac8f82afc3b0533adc485
Subject: Re: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114ac8f82afc3b0533adc485
Content-Type: text/plain; charset=UTF-8

Hi David,

On Wed, May 25, 2016 at 12:17 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 25/05/16 17:27, Selva Nair wrote:
> >
> > Well, if a major rewrite of console input is planned, consider
> > replacing getpass() as well. It has arbitrary password length
> > limitations on some platforms. At the same time I'm not sure I
> > understand the need for this overhaul.
>
> Currently the interface is basically stdio/stdout.  But with a more
> modular API for querying user, you can enable more fancy ways of
> querying the user.  In the systemd team, they're talking about moving
> away from systemd-tty-ask-password's API to a DBus oriented API (but it
> is dragging, as they can't do that without kdbus in place for querying
> users at boot time).  The idea is that OpenVPN should be completely
> agnostic to if the user input is from a tty console or a fancy graphical
> GUI.  The OS/distribution just needs to support a method through this API.
>

Thanks for the explanation. Could be useful if it works well... Centralized
input facilities could have unwanted side effects -- for example, systemd
sometimes blasts messages to all logged in users when a password is
required which is kind of silly (probably there is a way to suppress it, I
haven't investigated).


>
> > Your patch has
> >
> > +#if SYSTEMD_VERSION > 216
> > +    if( echo )
> > +    {
> > +argv_printf_cat(&argv, "--echo");
> > +    }
> > +#endif
> >
> > How would such a compile time check be any useful -- the version will
> > have to be checked at run-time, isn't it?
> >
> > So, should I withdraw the patch or try to fix it by hacking up a
> > run-time version check?
>
> There exists no way to query at runtime which version systemd is running
> (or at least it didn't when I started poking at that).  And it was
> considered that if you have version newer than 216 you would never
> downgrade systemd, so a compile time check would generally be good
> enough.  This works at least very well in the RHEL/Fedora build
> environments where all builds happens in chroots managed by mock, where
> the buildroots have the same package versions installed as the
> distribution the build is targeted at.


Yeah, it looks good as most people install from distributions or build on
the target machine. No need to support folks like me who sometimes copy
binaries from one system to another at our own peril :)

I'll withdraw the patch.

Thanks,

Selva

--001a114ac8f82afc3b0533adc485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi David,</div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Wed, May 25, 2016 at 12:17 PM, David <span class=3D"" id=3D":2u1.1" tabi=
ndex=3D"-1">Sommerseth</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:openv=
pn@...2080..." target=3D"_blank"><span class=3D"" id=3D":2u1.2" tabindex=3D=
"-1">openvpn</span>@sf.lists.<span class=3D"" id=3D":2u1.3" tabindex=3D"-1"=
>topphemmelig</span>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><span class=3D"">On 25/05/16 17:27, Selva Nair wrote:<br>
&gt;<br>
&gt; Well, if a major rewrite of console input is planned, consider<br>
&gt; replacing getpass() as well. It has arbitrary password length<br>
&gt; limitations on some platforms. At the same time I&#39;m not sure I<br>
&gt; understand the need for this overhaul.<br>
<br>
</span>Currently the interface is basically stdio/stdout.=C2=A0 But with a =
more<br>
modular API for querying user, you can enable more fancy ways of<br>
querying the user.=C2=A0 In the systemd team, they&#39;re talking about mov=
ing<br>
away from systemd-tty-ask-password&#39;s API to a DBus oriented API (but it=
<br>
is dragging, as they can&#39;t do that without kdbus in place for querying<=
br>
users at boot time).=C2=A0 The idea is that OpenVPN should be completely<br>
agnostic to if the user input is from a tty console or a fancy graphical<br>
GUI.=C2=A0 The OS/distribution just needs to support a method through this =
API.<br></blockquote><div><br></div><div>Thanks for the explanation. Could =
be useful if it works well... Centralized input facilities could have unwan=
ted side effects -- for example,=C2=A0<span class=3D"" id=3D":2u1.4" tabind=
ex=3D"-1">systemd</span> sometimes blasts messages to all logged in users w=
hen a password is required which is kind of silly (probably there is a way =
to suppress it, I haven&#39;t investigated).</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D""><br>
&gt; Your patch has<br>
&gt;<br>
&gt; +#if SYSTEMD_VERSION &gt; 216<br>
&gt; +=C2=A0 =C2=A0 if( echo )<br>
&gt; +=C2=A0 =C2=A0 {<br>
</span>&gt; +argv_printf_cat(&amp;argv, &quot;--echo&quot;);<br>
<span class=3D"">&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt;<br>
&gt; How would such a compile time check be any useful -- the version will<=
br>
&gt; have to be checked at run-time, isn&#39;t it?<br>
&gt;<br>
&gt; So, should I withdraw the patch or try to fix it by hacking up a<br>
&gt; run-time version check?<br>
<br>
</span>There exists no way to query at runtime which version systemd is run=
ning<br>
(or at least it didn&#39;t when I started poking at that).=C2=A0 And it was=
<br>
considered that if you have version newer than 216 you would never<br>
downgrade systemd, so a compile time check would generally be good<br>
enough.=C2=A0 This works at least very well in the RHEL/Fedora build<br>
environments where all builds happens in chroots managed by mock, where<br>
the buildroots have the same package versions installed as the<br>
distribution the build is targeted at.</blockquote></div><div class=3D"gmai=
l_extra"><br></div>Yeah, it looks good=C2=A0as most people install from dis=
tributions or build on the target machine. No need to support folks like me=
 who sometimes copy binaries from one system to another at our own peril :)=
<br><br></div><div class=3D"gmail_extra">I&#39;ll withdraw the patch.</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Thanks,</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span cla=
ss=3D"" id=3D":2u1.6" tabindex=3D"-1">Selva</span></div></div>

--001a114ac8f82afc3b0533adc485--

