MIME-Version: 1.0
In-Reply-To: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 25 Apr 2017 13:58:58 +0500
Message-ID: <CAFHpkQHAHDVZOU1ftoirMns7TKSVbFWnhvwbjcyqR1euVt65hA@...278...>
Content-Type: multipart/alternative; boundary=001a1141819e2fb7d7054df9efdd
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
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

--001a1141819e2fb7d7054df9efdd
Content-Type: text/plain; charset=UTF-8

2017-04-25 5:18 GMT+05:00 debbie10t <debbie10t@...277...>:

> Hi,
>
> generally, Openvpn on Windows is dependent on the "Windows DHCP Client
> service" .. if that Service is not started, is it possible for Openvpn
>

windows services depend on dhcp

https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L415

so, services won't start.
not sure how can we use it here

ideas ?


> to report a *specific* log message that: _DHCP_ has failed to assign an
> IP address to TAP Adapter ?
>
> thanks
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

--001a1141819e2fb7d7054df9efdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-25 5:18 GMT+05:00 debbie10t <span dir=3D"ltr">&lt;<a target=3D"=
_blank" href=3D"mailto:debbie10t@...277...">debbie10t@...277...</a>&gt;</sp=
an>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi,<br>
<br>
generally, Openvpn on Windows is dependent on the &quot;Windows DHCP Client=
<br>
service&quot; .. if that Service is not started, is it possible for Openvpn=
<br></blockquote><div><br></div><div>windows services depend on dhcp<br><br=
><a href=3D"https://github.com/OpenVPN/openvpn-build/blob/master/windows-ns=
is/openvpn.nsi#L415">https://github.com/OpenVPN/openvpn-build/blob/master/w=
indows-nsis/openvpn.nsi#L415</a><br><br></div><div>so, services won&#39;t s=
tart.<br></div><div>not sure how can we use it here<br><br></div><div>ideas=
 ?<br></div><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quo=
te">
to report a *specific* log message that: _DHCP_ has failed to assign an<br>
IP address to TAP Adapter ?<br>
<br>
thanks<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a target=3D"_blank" rel=3D"noreferrer" =
href=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourceforge.n=
et/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>lists/l=
istinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a1141819e2fb7d7054df9efdd--

