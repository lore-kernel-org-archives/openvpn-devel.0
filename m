MIME-Version: 1.0
In-Reply-To: <20151214234504.9c3a73e36096e05d8df2a1cb@...515...>
References: <20151214172340.9332784c61ebaccf5b94a6ae@...515...>
	<20151214234504.9c3a73e36096e05d8df2a1cb@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 14 Dec 2015 19:11:52 -0500
Message-ID: <CAKuzo_hkPeFij2V9sYtaBMwTwCfRbSG1n0PAo7oLhiEsGZg5uw@...278...>
Content-Type: multipart/alternative; boundary=047d7b8738a4297b920526e4a425
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 14th Dec 2015) community meeting
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

--047d7b8738a4297b920526e4a425
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 14, 2015 at 4:45 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

Discussed OpenVPN 2.3.9 release. Here is the release plan:
>
 [..]

> In addition:
>
>
> - - the initial windows installers will not have the openvpn-gui changes
> - - mattock will provide test installers with the changes and send a link
> to the list
> - - if the test installers work fine for people, new official installers
> will released
>

Probably this is a good place to post this reminder, mainly for Samuli:

The next windows installer needs to remove the "disconnect_on_suspend =3D 1"
registry entry for the GUI (remove or re-write to =3D 0). Otherwise  GUI
users will experience weired disconnections after suspend/resume.

This is because of the way openvpn.exe now handles suspend/resume and the
way GUI treats delayed response from the app.

I thought I had submitted a patch for this to openvpn-build, but can't find
it... Anyway, its a one liner.

Thanks,

Selva

--047d7b8738a4297b920526e4a425
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, Dec 14, 2015 at 4:45 PM, <s=
pan>Samuli</span> <span>Sepp=C3=A4nen</span> <span dir=3D"ltr">&lt;<a href=
=3D"mailto:samuli@...515..." target=3D"_blank"><span>samuli</span>@<span>op=
envpn</span>.net</a>&gt;</span> wrote:<br><br><blockquote style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" c=
lass=3D"gmail_quote">Discussed OpenVPN 2.3.9 release. Here is the release p=
lan:<br></blockquote><div>=C2=A0[..] <br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div style=3D"overflow:hidden">In addition:<br><br>
<br>
- - the initial windows installers will not have the openvpn-gui changes<br>
- - mattock will provide test installers with the changes and send a link t=
o the list<br>
- - if the test installers work fine for people, new official installers wi=
ll released<br>
</div></blockquote></div><br>Probably this is a good place to post this rem=
inder, mainly for <span>Samuli</span>:<br><br></div><div class=3D"gmail_ext=
ra">The next windows installer needs to remove the &quot;disconnect_on_susp=
end =3D 1&quot; registry entry for the GUI (remove or re-write to =3D 0). O=
therwise=C2=A0 GUI users will experience weired disconnections after suspen=
d/resume. <br><br>This is because of the way openvpn.exe now handles suspen=
d/resume and the way GUI treats delayed response from the app.<br><br></div=
><div class=3D"gmail_extra">I thought I had submitted a patch for this to <=
span>openvpn</span>-build, but can&#39;t find it... Anyway, its a one liner=
.<br><br></div><div class=3D"gmail_extra">Thanks,<br><br></div><div class=
=3D"gmail_extra"><span>Selva</span><br></div></div>

--047d7b8738a4297b920526e4a425--

