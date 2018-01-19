MIME-Version: 1.0
In-Reply-To: <CAKuzo_i_J7+yFwv60gd3MinAOu7SdoUmvVMKsHZG-3Fep5EFmw@...278...>
References: <CAFHpkQGe-aeaV2we=M_xB41W36dwAa8rRRzmt6rteVvAHuXFKA@...278...>
 <CAKuzo_i_J7+yFwv60gd3MinAOu7SdoUmvVMKsHZG-3Fep5EFmw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 19 Jan 2018 09:34:03 +0500
Message-ID: <CAFHpkQFu5rRhNDfGDC5NCcRrMOH+-bZd-mi7wLkM6uNas+dSXQ@...278...>
Content-Type: multipart/alternative; boundary="f403045ea3441a5a1d056319977b"
Subject: Re: [Openvpn-devel] consider exe_path optional ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f403045ea3441a5a1d056319977b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-01-18 22:11 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Thu, Jan 18, 2018 at 3:49 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>> Hello,
>>
>> changes https://github.com/OpenVPN/openvpn-gui/pull/197 actually make
>> openvpn-gui less dependent on registry
>>
>>
>> we sometimes see similar issue with interactive service:
>>
>> openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=
=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error querying
>> registry value: HKLM\SOFTWARE\OpenVPN\exe_path
>>
>> (I've no idea why "exe_path" was deleted)
>>
>> @selvanair , what do you think if we'll try to guess exe_path by picking
>> directory from where openvpnserv was started ? (it is a good guess to
>> assume openvpn.exe is in the same directory)
>>
>
> Patch 86 (https://patchwork.openvpn.net/patch/86/) does this. The only
> registry key that will be required would be HKLM\Software\OpenVPN whose
> default value should point to the installation directory.
>
> One of the security features of the service is that it starts only
> "authorized" openvpn.exe executables -- so we need to have at least the
> installed location set by the admin. Then we can safely guess the rest of
> the parameters if not explicitly set. Eliminating all registry dependence
> wouldn't be safe for the service.
>

I do not think that speciying a path is somewhat related to security (for
example, I can put a malware named "openvpn.exe" in that path).


However, patch is very good, why is it still not applied ?


>
> That wouldn't fix issues faced by users who delete registry keys or use
> non-standard installation methods. Generally those are power users who can
> fix things on their own. If not, just ask them to re-install openvpn.
>

as those users say, they do not delete anything. it happens after "install
windows updates" + "reboot"
(there was an earlier case with running ccleaner, which wipes registry in
random way)


>
> Selva
>

--f403045ea3441a5a1d056319977b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-18 22:11 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote"><span class=3D"">On Thu, Jan 18,=
 2018 at 3:49 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." =
target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div><div=
><div><div>Hello,<br><br></div>changes <a href=3D"https://github.com/OpenVP=
N/openvpn-gui/pull/197" target=3D"_blank">https://github.com/OpenVPN/ope<wb=
r>nvpn-gui/pull/197</a> actually make openvpn-gui less dependent on registr=
y<br><br><br></div>we sometimes see similar issue with interactive service:=
<br><br>openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=B5=D1=82=D1=
=81=D1=8F =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error querying regist=
ry value: HKLM\SOFTWARE\OpenVPN\exe_path<br><br></div>(I&#39;ve no idea why=
 &quot;exe_path&quot; was deleted)<br><br></div>@selvanair , what do you th=
ink if we&#39;ll try to guess exe_path by picking directory from where open=
vpnserv was started ? (it is a good guess to assume openvpn.exe is in the s=
ame directory)<br></div></div></div></blockquote><div><br></div></span><div=
>Patch 86 (<a href=3D"https://patchwork.openvpn.net/patch/86/" target=3D"_b=
lank">https://patchwork.openvpn.<wbr>net/patch/86/</a>) does this. The only=
 registry key that will be required would be HKLM\Software\OpenVPN whose de=
fault value should point to the installation directory.=C2=A0</div><div><br=
></div><div>One of the security features of the service is that it starts o=
nly &quot;authorized&quot; openvpn.exe executables -- so we need to have at=
 least the installed location set by the admin. Then we can safely guess th=
e rest of the parameters if not explicitly set. Eliminating all registry de=
pendence wouldn&#39;t be safe for the service.=C2=A0</div></div></div></div=
></blockquote><div><br></div><div>I do not think that speciying a path is s=
omewhat related to security (for example, I can put a malware named &quot;o=
penvpn.exe&quot; in that path).</div><div><br></div><div><br></div><div>How=
ever, patch is very good, why is it still not applied ?<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><br></div><div>That wouldn&#39;t f=
ix issues faced by users who delete registry keys or use non-standard insta=
llation methods. Generally those are power users who can fix things on thei=
r own. If not, just ask them to re-install openvpn.</div></div></div></div>=
</blockquote><div><br></div><div>as those users say, they do not delete any=
thing. it happens after &quot;install windows updates&quot; + &quot;reboot&=
quot;</div><div>(there was an earlier case with running ccleaner, which wip=
es registry in random way)<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>Sel=
va</div></font></span></div></div></div>
</blockquote></div><br></div></div>

--f403045ea3441a5a1d056319977b--

