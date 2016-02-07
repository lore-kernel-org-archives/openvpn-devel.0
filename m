MIME-Version: 1.0
In-Reply-To: <CAKuzo_gw4_YPN2UWr9Hf92QjfEqLH0YR3eFusYccM=j5PiQnyg@...278...>
References: <CAKuzo_gC70Sozt1BZyf6NhMgPi-NpDWR5G-_fcXx0GKk1_JVmg@...278...>
	<CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
	<20160207192752.GZ24952@...1296...>
	<CAFHpkQEpOn0OBHVjJjQJPazHw8a+OPncDKt5jJVSi6cKpzkeJQ@...278...>
	<CAKuzo_gw4_YPN2UWr9Hf92QjfEqLH0YR3eFusYccM=j5PiQnyg@...278...>
Date: Mon, 8 Feb 2016 01:32:14 +0500
Message-ID: <CAFHpkQFtGYmV9cjU1SpmXtAJayiNQOdB4FsOofkHxmeyZnAqCQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3efdecd113e052b33fa03
Subject: Re: [Openvpn-devel] GUI repo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c3efdecd113e052b33fa03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as far as I understand it is up to user whether to install openvpn as a
service or not.
if openvpn is not installed as a service, highest priv is required, right?

2016-02-08 1:29 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Sun, Feb 7, 2016 at 3:12 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>> there's still "Start OpenVPN directly"
>>
>> https://github.com/OpenVPN/openvpn-gui/b, lob/master/openvpn.c#L724
>> <https://github.com/OpenVPN/openvpn-gui/blob/master/openvpn.c#L724>
>>
>> in such case admin rights are still required for routes manipulation.
>>
>
> Once interactive service is available in the distribution, such usage
> would require the user to explicitly start the GUI with admin rights.
>
>
>> maybe we should release two installers (or make a checkbox in installer?)
>>
>> 1) regular mode (with highest priv manifest)
>> 2) paranoya mode (without highest priv)
>>
>
> For 2.4 just one installer with privilege request in the manifest would be
> enough. No need to force UAC prompt for privilege escalation when not
> required.
>
> Selva
>
>
>

--001a11c3efdecd113e052b33fa03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>as far as I understand it is up to user whether to in=
stall openvpn as a service or not.<br></div>if openvpn is not installed as =
a service, highest priv is required, right?<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">2016-02-08 1:29 GMT+05:00 Selva Nair <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blan=
k">selva.nair@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"g=
mail_extra"><div class=3D"gmail_quote"><span class=3D"">On Sun, Feb 7, 2016=
 at 3:12 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=
=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br></span><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div><div><span class=3D"">there&#39;s still &quot;<sp=
an>Start OpenVPN directly&quot;</span><br><br></span><a href=3D"https://git=
hub.com/OpenVPN/openvpn-gui/blob/master/openvpn.c#L724" target=3D"_blank">h=
ttps://github.com/OpenVPN/openvpn-gui/b, lob/master/openvpn.c#L724</a><br><=
br></div><span class=3D"">in such case admin rights are still required for =
routes manipulation.<br></span></div></blockquote><div><br></div><div>Once =
interactive service is available in the distribution, such usage would requ=
ire the user to explicitly start the GUI with admin rights. <br></div><span=
 class=3D""><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>maybe =
we should release two installers (or make a checkbox in installer?)<br><br>=
</div><div>1) regular mode (with highest priv manifest)<br></div><div>2) pa=
ranoya mode (without highest priv)<br></div></blockquote><div><br></div></s=
pan><div>For 2.4 just one installer with privilege request in the manifest =
would be enough. No need to force UAC prompt for privilege escalation when =
not required.<span class=3D"HOEnZb"><font color=3D"#888888"><br><br></font>=
</span></div><span class=3D"HOEnZb"><font color=3D"#888888"><div>Selva<br><=
/div><div><br></div></font></span></div><br></div></div>
</blockquote></div><br></div>

--001a11c3efdecd113e052b33fa03--

