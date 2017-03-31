MIME-Version: 1.0
In-Reply-To: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 31 Mar 2017 13:56:07 +0500
Message-ID: <CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12cad0f765e0054c02faaf
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
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

--94eb2c12cad0f765e0054c02faaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> We still bundle EasyRSA 2 with our Windows installers and it is
> prominently advertised on our widely linked to HOWTO:
>
> <https://openvpn.net/index.php/open-source/documentation/howto.html>
>
> As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>
> However, the default values for EasyRSA 2 such as MD5 hashing algorithm
> and 1024-bit keysize seem totally inadequate for today's standards:
>
> <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/vars#L53
> >
> <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-
> rsa/2.0/openssl-1.0.0.cnf#L57>
>
> I think we should upgrade these to something more recent. What would
> more modern reasonable defaults be?
>


someday we decided to use DSA (instead of default RSA)
it worked ... until we started to use OpenVPN Connect for iOS.
next, we had to change back to RSA


the conclusion would be "test all available platforms and take a decision",
probably even set up special test server and ask people on openvpn-users
mailing list


>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--94eb2c12cad0f765e0054c02faaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
We still bundle EasyRSA 2 with our Windows installers and it is<br>
prominently advertised on our widely linked to HOWTO:<br>
<br>
&lt;<a href=3D"https://openvpn.net/index.php/open-source/documentation/howt=
o.html" rel=3D"noreferrer" target=3D"_blank">https://openvpn.net/index.<wbr=
>php/open-source/documentation/<wbr>howto.html</a>&gt;<br>
<br>
As such, EasyRSA 2 is used by many/most OpenVPN server admins.<br>
<br>
However, the default values for EasyRSA 2 such as MD5 hashing algorithm<br>
and 1024-bit keysize seem totally inadequate for today&#39;s standards:<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa=
/2.0/vars#L53" rel=3D"noreferrer" target=3D"_blank">https://github.com/Open=
VPN/<wbr>easy-rsa-old/blob/master/easy-<wbr>rsa/2.0/vars#L53</a>&gt;<br>
&lt;<a href=3D"https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa=
/2.0/openssl-1.0.0.cnf#L57" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/OpenVPN/<wbr>easy-rsa-old/blob/master/easy-<wbr>rsa/2.0/openssl-1.=
0.0.cnf#L57</a>&gt;<br>
<br>
I think we should upgrade these to something more recent. What would<br>
more modern reasonable defaults be?<br></blockquote><div><br><br></div><div=
>someday we decided to use DSA (instead of default RSA)<br></div><div>it wo=
rked ... until we started to use OpenVPN Connect for iOS.<br></div><div>nex=
t, we had to change back to RSA<br><br><br></div><div>the conclusion would =
be &quot;test all available platforms and take a decision&quot;, probably e=
ven set up special test server and ask people on openvpn-users mailing list=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--94eb2c12cad0f765e0054c02faaf--

