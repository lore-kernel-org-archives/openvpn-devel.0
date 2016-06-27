MIME-Version: 1.0
In-Reply-To: <8m6og.o9e73d.2tj49u-qmf@...2147...>
References: <CAFHpkQEi0Nw1=urbawcLhn_3TVTbcNDuvKdwdwtf-M4fBdoUXQ@...278...>
	<20160623172955.GH79504@...1296...>
	<8m6og.o9e73d.2tj49u-qmf@...2147...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 28 Jun 2016 00:19:22 +0500
Message-ID: <CAFHpkQFQu3J9tj7b5=y0FLba1LTk7wYLpfPDRRjZ13o3qnG=Fg@...278...>
Content-Type: multipart/alternative; boundary=001a11468c36d7171a0536476518
Subject: Re: [Openvpn-devel] windows installer: choosing x86/x64 and
	NDIS5/NDIS6
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

--001a11468c36d7171a0536476518
Content-Type: text/plain; charset=UTF-8

we have just packed our own installer using

...
!include WinVer.nsh
...
!define TAP_WINDOWS_INSTALLER_5 "C:\tap\tap-windows-9.9.2_3.exe"
!define TAP_WINDOWS_INSTALLER_6 "C:\tap\tap-windows-9.21.2.exe"

...

${If} ${AtLeastWin7}
    File /oname=tap-windows.exe "${TAP_WINDOWS_INSTALLER_6}"
${Else}
    File /oname=tap-windows.exe "${TAP_WINDOWS_INSTALLER_5}"
${EndIf}

.......

however, I need some time to reproduce the same with openvpn-build.
I'll make PR soon

2016-06-26 23:52 GMT+05:00 <samuli@...515...>:

> I think a dual NDIS5/6 installer is a good idea. Feel free to PR :).
>
> Samuli
>
> Il gio giu 23 20:29:55 2016 GMT+0300, Gert Doering scrive:
> > Hi,
> >
> > On Thu, Jun 23, 2016 at 06:07:51PM +0500, ???????? ?????????????? wrote:
> > > we used to enroll our own installer, and we bundled both x86 and x64
> into
> > > single installer
> > >
> > > it was easy, several blocks
> > >
> > > ${If} ${RunningX64}
> > > ....
> > > ${Else}
> > > ...
> > > ${EndIf}
> > >
> > >
> > > we are going to pack NDIS5/NDIS6 the same way. in order to choose
> proper
> > > installer automatically, not to put that decision to user.
> > >
> > > if there's an interest, I can make some PR on that.
> >
> > Interest!  (Though Samuli is the one maintaining the installers...)
> >
> > gert
> >
> > --
> > USENET is *not* the non-clickable part of WWW!
> >                                                            //
> www.muc.de/~gert/
> > Gert Doering - Munich, Germany
> gert@...1296...
> > fax: +49-89-35655025
> gert@...1297...
> >
>

--001a11468c36d7171a0536476518
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">we have just packed our own installer using<div><br></div>=
<div>...</div><div>!include WinVer.nsh<br></div><div>...</div><div><div>!de=
fine TAP_WINDOWS_INSTALLER_5 &quot;C:\tap\tap-windows-9.9.2_3.exe&quot;</di=
v><div>!define TAP_WINDOWS_INSTALLER_6 &quot;C:\tap\tap-windows-9.21.2.exe&=
quot;</div></div><div><br></div><div>...</div><div><br></div><div><div>${If=
} ${AtLeastWin7}</div><div>=C2=A0 =C2=A0 File /oname=3Dtap-windows.exe &quo=
t;${TAP_WINDOWS_INSTALLER_6}&quot;</div><div>${Else}</div><div>=C2=A0 =C2=
=A0 File /oname=3Dtap-windows.exe &quot;${TAP_WINDOWS_INSTALLER_5}&quot;</d=
iv><div>${EndIf}</div></div><div><br></div><div>.......</div><div><br></div=
><div>however, I need some time to reproduce the same with openvpn-build.</=
div><div>I&#39;ll make PR soon</div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">2016-06-26 23:52 GMT+05:00  <span dir=3D"ltr">&lt;=
<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&=
gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">I think a dual NDIS5/6 instal=
ler is a good idea. Feel free to PR :).<br>
<br>
Samuli<br>
<br>
Il gio giu 23 20:29:55 2016 GMT+0300, Gert Doering scrive:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; Hi,<br>
&gt;<br>
&gt; On Thu, Jun 23, 2016 at 06:07:51PM +0500, ???????? ?????????????? wrot=
e:<br>
&gt; &gt; we used to enroll our own installer, and we bundled both x86 and =
x64 into<br>
&gt; &gt; single installer<br>
&gt; &gt;<br>
&gt; &gt; it was easy, several blocks<br>
&gt; &gt;<br>
&gt; &gt; ${If} ${RunningX64}<br>
&gt; &gt; ....<br>
&gt; &gt; ${Else}<br>
&gt; &gt; ...<br>
&gt; &gt; ${EndIf}<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; we are going to pack NDIS5/NDIS6 the same way. in order to choose=
 proper<br>
&gt; &gt; installer automatically, not to put that decision to user.<br>
&gt; &gt;<br>
&gt; &gt; if there&#39;s an interest, I can make some PR on that.<br>
&gt;<br>
&gt; Interest!=C2=A0 (Though Samuli is the one maintaining the installers..=
.)<br>
&gt;<br>
&gt; gert<br>
&gt;<br>
&gt; --<br>
&gt; USENET is *not* the non-clickable part of WWW!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //<a hre=
f=3D"http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc=
.de/~gert/</a><br>
&gt; Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"mailto:gert@...1296...">gert@...1296...</a><br>
&gt; fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@=
...1297...</a><br>
&gt;</div></div></blockquote></div><br></div>

--001a11468c36d7171a0536476518--

