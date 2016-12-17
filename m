MIME-Version: 1.0
In-Reply-To: <20161215165048.GA23728@...1029...>
References: <20161215160841.GA21203@...1029...>
	<20161215162019.GP35892@...2215...>
	<20161215165048.GA23728@...1029...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 17 Dec 2016 20:20:36 +0700
Message-ID: <CAFHpkQGajrNjoZH8exuwW0M1pMCfgr8BDHvepAUrKHjf4wGkkQ@...278...>
Content-Type: multipart/alternative; boundary=001a11417a9a5ab06d0543da8d94
Subject: Re: [Openvpn-devel] ngx_stream_ssl_preread_module does not seem to
 extract the server_name when connecting with openconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: nginx@...2214..., openvpn devel <openvpn-devel@lists.sourceforge.net>

--001a11417a9a5ab06d0543da8d94
Content-Type: text/plain; charset=UTF-8

2016-12-15 23:50 GMT+07:00 Thomas Glanzmann <thomas@...1029...>:

> Hello Roman,
>
> > You can try logging $ssl_preread_server_name in access_log.
>
> thank you. It seems that nginx is not able to extract the server_name
> from openconnect correctly:
>
> 2a01:598:8181:37ef:95e1:682:4c98:449e - [15/Dec/2016:17:45:57 +0100] ""
>
> When I connect with a browser:
>
> 2a01:598:8181:37ef:95e1:682:4c98:449e - [15/Dec/2016:17:46:20 +0100] "
> vpn.gmvl.de"
>
> This seems to be one problem. And another problem seems that backend
> communication between nginx and ocserv using the proxy protocol.
>
> Here is tcpdump of the openconnect ssl handshake with nginx:
>
> https://thomas.glanzmann.de/tmp/openconnect_sni.pcap



do you mean port sharing between OpenVPN and Cisco AnyConnect ?


>
>
> I'm using the command line 'openconnect vpn.gmvl.de'.
>
> Cheers,
>         Thomas
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11417a9a5ab06d0543da8d94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-15 23:50 GMT+07:00 Thomas Glanzmann <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:thomas@...1029..." target=3D"_blank">thomas@...1029...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hello Roman,<br>
<br>
&gt; You can try logging $ssl_preread_server_name in access_log.<br>
<br>
thank you. It seems that nginx is not able to extract the server_name<br>
from openconnect correctly:<br>
<br>
2a01:598:8181:37ef:95e1:682:<wbr>4c98:449e - [15/Dec/2016:17:45:57 +0100] &=
quot;&quot;<br>
<br>
When I connect with a browser:<br>
<br>
2a01:598:8181:37ef:95e1:682:<wbr>4c98:449e - [15/Dec/2016:17:46:20 +0100] &=
quot;<a href=3D"http://vpn.gmvl.de" rel=3D"noreferrer" target=3D"_blank">vp=
n.gmvl.de</a>&quot;<br>
<br>
This seems to be one problem. And another problem seems that backend<br>
communication between nginx and ocserv using the proxy protocol.<br>
<br>
Here is tcpdump of the openconnect ssl handshake with nginx:<br>
<br>
<a href=3D"https://thomas.glanzmann.de/tmp/openconnect_sni.pcap" rel=3D"nor=
eferrer" target=3D"_blank">https://thomas.glanzmann.de/<wbr>tmp/openconnect=
_sni.pcap</a></blockquote><div><br><br></div><div>do you mean port sharing =
between OpenVPN and Cisco AnyConnect ?<br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br>
<br>
I&#39;m using the command line &#39;openconnect <a href=3D"http://vpn.gmvl.=
de" rel=3D"noreferrer" target=3D"_blank">vpn.gmvl.de</a>&#39;.<br>
<br>
Cheers,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Thomas<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a11417a9a5ab06d0543da8d94--

