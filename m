MIME-Version: 1.0
In-Reply-To: <7fe7abd3-272c-689b-1698-1c53b86100f4@...277...>
References: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
	<8dff9a3b-003b-4a48-3ff6-21f0663ba712@...277...>
	<13724284-0709-d43e-a1ab-f6abea65362f@...277...>
	<0b890451-25c5-5a34-37f5-84b2fe2a3319@...515...>
	<102609f5-719f-0ce5-05fa-ceaafefa680e@...277...>
	<7fe7abd3-272c-689b-1698-1c53b86100f4@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Nov 2016 13:16:45 -0500
Message-ID: <CAKuzo_hKv7XHmV5Ej22uAE5asEMUdCtiO0-rnuEeSdiUTGnuOw@...278...>
Content-Type: multipart/alternative; boundary=001a11408cb6ca87ca0541d3a9f5
Subject: Re: [Openvpn-devel] Combined 32/64-bit OpenVPN 2.4_beta1 installer
 available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408cb6ca87ca0541d3a9f5
Content-Type: text/plain; charset=UTF-8

Hi,


On Mon, Nov 21, 2016 at 12:34 PM, debbie10t <debbie10t@...277...> wrote:

> UNINSTALLING From C:\#Tools\Openvpn

...

Registry remains:
>
> Windows Registry Editor Version 5.00
>
> [HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN]
> "config_dir"="C:\\#Tools\\OpenVPN\\config"
> "config_ext"="ovpn"
> "exe_path"="C:\\#Tools\\OpenVPN\\bin\\openvpn.exe"
> "log_dir"="C:\\#Tools\\OpenVPN\\log"
> "priority"="NORMAL_PRIORITY_CLASS"
> "log_append"="0"
> @="C:\\#Tools\\OpenVPN"


Uninstall should remove the Registry key HKLM\SoftWare\OpenVPN but in this
case its not removed which is strange..

[HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN]
>
> "config_dir"="C:\\#Tools\\OpenVPN\\config"
>
> "config_ext"="ovpn"
>
> "exe_path"="C:\\#Tools\\OpenVPN\\bin\\openvpn.exe"
>
> "log_dir"="C:\\#Tools\\OpenVPN\\log"
>
> "priority"="NORMAL_PRIORITY_CLASS"
>
> "log_append"="0"
>
> @="C:\\Program Files\\OpenVPN"
>

If the registry key is not removed and then recreated, the above is
expected to happen as the installer always overwrites the default value
("C:\\Program Files\\OpenVPN" here) but uses WriteRegStringIfUndef for all
others. I think we should use WriteRegStr instead.

In fact it would be better if the installer always removes the
HKLM\Software\OpenVPN key and all values under it and then recreates it. We
anyway stop and remove the service in the beginning (even if service
installation is not selected) so no need to keep the original values in
this key.

Selva

--001a11408cb6ca87ca0541d3a9f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><br></=
div><div class=3D"gmail_quote">On Mon, Nov 21, 2016 at 12:34 PM, debbie10t =
<span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=3D"_bla=
nk">debbie10t@...277...</a>&gt;</span> wrote:</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">UNINSTA=
LLING From C:\#Tools\Openvpn</blockquote><div><div>...</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Registry remains:<br><br>Windows Registry Editor Version 5=
.00<br><br>[HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN]<br>&quot;config_dir&quot;=
=3D&quot;C:\\#Tools\\OpenVPN\\config&quot;<br>&quot;config_ext&quot;=3D&quo=
t;ovpn&quot;<br>&quot;exe_path&quot;=3D&quot;C:\\#Tools\\OpenVPN\\bin\\open=
vpn.exe&quot;<br>&quot;log_dir&quot;=3D&quot;C:\\#Tools\\OpenVPN\\log&quot;=
<br>&quot;priority&quot;=3D&quot;NORMAL_PRIORITY_CLASS&quot;<br>&quot;log_a=
ppend&quot;=3D&quot;0&quot;<br>@=3D&quot;C:\\#Tools\\OpenVPN&quot;</blockqu=
ote><div>=C2=A0</div></div><div>Uninstall should remove the Registry key HK=
LM\SoftWare\OpenVPN but in this case its not removed which is strange..</di=
v><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex"><div id=3D"gmail-:1jx" cl=
ass=3D"gmail-a3s gmail-aXjCH gmail-m15887f7244c6089e">[HKEY_LOCAL_MACHINE\S=
OFTWARE\<wbr>OpenVPN]<br>
<br>
&quot;config_dir&quot;=3D&quot;C:\\#Tools\\<wbr>OpenVPN\\config&quot;<br>
<br>
&quot;config_ext&quot;=3D&quot;ovpn&quot;<br>
<br>
&quot;exe_path&quot;=3D&quot;C:\\#Tools\\<wbr>OpenVPN\\bin\\openvpn.exe&quo=
t;<br>
<br>
&quot;log_dir&quot;=3D&quot;C:\\#Tools\\<wbr>OpenVPN\\log&quot;<br>
<br>
&quot;priority&quot;=3D&quot;NORMAL_PRIORITY_<wbr>CLASS&quot;<br>
<br>
&quot;log_append&quot;=3D&quot;0&quot;<br>
<br>
@=3D&quot;C:\\Program Files\\OpenVPN&quot;</div></blockquote></div><br>If t=
he registry key is not removed and then recreated, the above is expected to=
 happen as the installer always overwrites the default value (&quot;C:\\Pro=
gram Files\\OpenVPN&quot; here) but uses=C2=A0WriteRegStringIfUndef for all=
 others. I think we should use WriteRegStr instead.</div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">In fact it would be better if=
 the installer always removes the HKLM\Software\OpenVPN key and all values =
under it and then recreates it. We anyway stop and remove the service in th=
e beginning (even if service installation is not selected) so no need to ke=
ep the original values in this key.</div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">Selva</div></div>

--001a11408cb6ca87ca0541d3a9f5--

