MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10806D643C@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
 <CAKuzo_gmn-B6=4Vho9OwUENzqT0C5ibNZghOY-9B1cpTGRE42Q@...278...>
 <99D61A626FDA8A4B90A270669121BE10806D643C@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 9 Aug 2017 16:22:43 -0400
Message-ID: <CAKuzo_g+n5cTz3K6aHLKTvVzF5NheJdo2sJJCS_UOG1wpy6z+Q@...278...>
Content-Type: multipart/alternative; boundary="001a113d2950daecd1055657d8f0"
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d2950daecd1055657d8f0
Content-Type: text/plain; charset="UTF-8"

Hi,


>  But that would open the OpenVPN Interactive Service to any user and
> application. This is why we would like your opinion first.
>
> Yes the service will then launch openvpn with arbitrary configs as any
> user, but that is what you want isn't it?
>
>
>
> True, I want that indeed. I was just trying to find the official way of
> doing it only to learn it's against OpenVPN team's principles. :(
>

The official way is to add the user to the designated group which by
default is expected to be named "OpenVPN Administrators". Recursive group
membership will work, so you could create a group named, say, "eduVPN
Users" or just use "Users" and add that to "OpenVPN Administrators" group
at install time (and remove it on uninstall). Personally I would avoid
tweaking permissions of a folder inside "Program Files\OpenVPN\config\"

Selva

--001a113d2950daecd1055657d8f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div lang=3D"SL" link=3D"blue" vlink=
=3D"purple"><div class=3D"m_-8356383149772598265m_-4640609107708078336m_434=
8739888793403891m_-812610513514368962WordSection1"><br><span><blockquote st=
yle=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0cm 0cm 0cm 6.0p=
t;margin-left:4.8pt;margin-right:0cm"><div><div><p class=3D"MsoNormal"><spa=
n lang=3D"EN-GB">=C2=A0But that would open the OpenVPN Interactive Service =
to any user and application. This is why we would like your opinion first.<=
/span><u></u><u></u></p></div></div></blockquote></span><div><span><p class=
=3D"MsoNormal">Yes the service will then launch openvpn with arbitrary conf=
igs as any user, but that is what you want isn&#39;t it?<span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#=
1f497d"><u></u><u></u></span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#=
1f497d"><u></u>=C2=A0<u></u></span></p></span><p class=3D"MsoNormal"><span =
lang=3D"EN-GB" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1f497d">True, I want that indeed. I was just tr=
ying to find the official way of doing it only to learn it&#39;s against Op=
enVPN team&#39;s principles. :(</span></p></div></div></div></blockquote><d=
iv><br></div><div>The official way is to add the user to the designated gro=
up which by default is expected to be named &quot;<span class=3D"" id=3D":a=
fi.1" tabindex=3D"-1">OpenVPN</span> Administrators&quot;. Recursive group =
membership will work, so you could create a group named, say, &quot;<span c=
lass=3D"" id=3D":afi.2" tabindex=3D"-1">eduVPN</span> Users&quot; or just u=
se &quot;Users&quot; and add that to &quot;<span class=3D"" id=3D":afi.3" t=
abindex=3D"-1">OpenVPN</span> Administrators&quot; group at install time (a=
nd remove it on <span class=3D"" id=3D":afi.4" tabindex=3D"-1">uninstall</s=
pan>). Personally I would avoid tweaking permissions of a folder inside &qu=
ot;Program Files\OpenVPN\config\&quot;</div><div><br></div><div><span class=
=3D"" id=3D":afi.5" tabindex=3D"-1">Selva</span>=C2=A0</div></div></div></d=
iv></div>

--001a113d2950daecd1055657d8f0--

