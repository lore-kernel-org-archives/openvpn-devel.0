MIME-Version: 1.0
In-Reply-To: <56261F0D.9020208@...515...>
References: <56211F0D.2010806@...515...> <2892922.l0hsuaC9oU@...2001...>
	<5625EA0A.3000908@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Oct 2015 22:12:06 -0400
Message-ID: <CAKuzo_jSiw75PaTed_5DWMbM=X313b75EH6vh9erXS2Q-3fK8Q@...278...>
Content-Type: multipart/alternative; boundary=001a11c3879ae6afb2052293e808
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c3879ae6afb2052293e808
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 7:01 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

>
> > On Tuesday 20 October 2015 10:15:22 Samuli Sepp=C3=A4nen wrote:
> >>>> Are you saying that the interactive service also doubles as a Windows
> >>>> system service? If so, can it be  configured to autostart selected
> >>>> openvpn connections on boot and restart them if they crash/stop?
> >>>
> >>> No, and I do not think that the service should take care of that.
> That's
> >>> rather things that can be handled by the GUI.
> >>
> >> What about persistent connections, especially on Windows servers?
> >
> > The interactive service patch doesn't remove the currently available
> service.
> > So, you still can fire up any connections the way it was before. I
> personally
> > do not care about the original service though, it may very well be that
> it
> > lacks decent functionality.
>
> The original openvpnserv.exe is truly crappy. It will not quit if all
> connections have died. It will not restart a connection should it crash.
> A single non-functional OpenVPN connection prevents it from launching
> the others (afaik). It will not work on Windows 10 in any reasonable
> fashion and works badly on anything post-Windows 7. It also does not
> handle resuming from suspend/hibernate properly.
>
> My NSSM-based replacement thingie aims to address all these
> shortcomings. I believe the interactive service and NSSM are complementar=
y.
>

I totally agree. Both are necessary.

The interactive service (based on a quick scan through the code) looks to
be very useful on a desktop with a single user, allowing the GUI and openvpn
to run with user privileges. I hope the "windows team" would soon start
working on making the GUI to work with this new service :)

But a sever admin would not want it in the system as it can allow any user
with some VPN server account to change the routes etc using the
service..(please correct me if I'm mistaken).

That means for "non-interactive" servers and non-desktop clients, one would
still need an improved version of the old service or  NSSM.

Selva

--001a11c3879ae6afb2052293e808
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 20, 2015 at 7:01 AM, <span tabindex=3D"-1" id=3D":8jo.17" s=
tyle=3D"" class=3D"">Samuli</span> <span tabindex=3D"-1" id=3D":8jo.18" sty=
le=3D"" class=3D"">Sepp=C3=A4nen</span> <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:samuli@...515..." target=3D"_blank"><span tabindex=3D"-1" id=3D":8jo.1=
9" style=3D"" class=3D"">samuli</span>@<span tabindex=3D"-1" id=3D":8jo.20"=
 style=3D"" class=3D"">openvpn</span>.net</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D""><br>
&gt; On Tuesday 20 October 2015 10:15:22 Samuli Sepp=C3=A4nen wrote:<br>
&gt;&gt;&gt;&gt; Are you saying that the interactive service also doubles a=
s a Windows<br>
&gt;&gt;&gt;&gt; system service? If so, can it be=C2=A0 configured to autos=
tart selected<br>
&gt;&gt;&gt;&gt; openvpn connections on boot and restart them if they crash=
/stop?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; No, and I do not think that the service should take care of th=
at. That&#39;s<br>
&gt;&gt;&gt; rather things that can be handled by the GUI.<br>
&gt;&gt;<br>
&gt;&gt; What about persistent connections, especially on Windows servers?<=
br>
&gt;<br>
&gt; The interactive service patch doesn&#39;t remove the currently availab=
le service.<br>
&gt; So, you still can fire up any connections the way it was before. I per=
sonally<br>
&gt; do not care about the original service though, it may very well be tha=
t it<br>
&gt; lacks decent functionality.<br>
<br>
</span>The original openvpnserv.exe is truly crappy. It will not quit if al=
l<br>
connections have died. It will not restart a connection should it crash.<br>
A single non-functional OpenVPN connection prevents it from launching<br>
the others (afaik). It will not work on Windows 10 in any reasonable<br>
fashion and works badly on anything post-Windows 7. It also does not<br>
handle resuming from suspend/hibernate properly.<br>
<br>
My NSSM-based replacement thingie aims to address all these<br>
shortcomings. I believe the interactive service and NSSM are complementary.=
<br></blockquote><div><br></div><div>I totally agree. Both are necessary.<b=
r><br>The interactive service (based on a quick scan through the code) look=
s to be very useful on a desktop with a single user, allowing the GUI and <=
span tabindex=3D"-1" id=3D":8jo.21" style=3D"" class=3D"">openvpn</span> to=
 run with user privileges. I hope the &quot;windows team&quot; would soon s=
tart working on making the GUI to work with this new service :)<br><br>But =
a sever admin would not want it in the system as it can allow any user with=
 some <span tabindex=3D"-1" id=3D":8jo.22" style=3D"" class=3D"">VPN</span>=
 server account to change the routes etc using the service..(please correct=
 me if I&#39;m mistaken).<br><br></div><div>That means for &quot;non-intera=
ctive&quot; servers and non-desktop clients, one would still need an improv=
ed version of the old service or=C2=A0 <span tabindex=3D"-1" id=3D":8jo.23"=
 style=3D"" class=3D"">NSSM</span>. <br></div></div><br></div><div class=3D=
"gmail_extra"><span tabindex=3D"-1" id=3D":8jo.24" style=3D"" class=3D"">Se=
lva</span><br></div></div>

--001a11c3879ae6afb2052293e808--

