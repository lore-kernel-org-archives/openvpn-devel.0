MIME-Version: 1.0
In-Reply-To: <59B26C92.1040105@...1147...>
References: <59B26C92.1040105@...1147...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 8 Sep 2017 15:47:14 +0500
Message-ID: <CAFHpkQE3cS9aw2qJVkASBpTLmoyvbRK1pDyFZYaT0K+7GyGMMQ@...278...>
Content-Type: multipart/alternative; boundary="001a1144a0fcd27e870558ab4c57"
Subject: Re: [Openvpn-devel] how to roll your own OpenVPN Windows installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144a0fcd27e870558ab4c57
Content-Type: text/plain; charset="UTF-8"

2017-09-08 15:10 GMT+05:00 Jan Just Keijser <janjust@...1147...>:

> hi dev list,
>
> someone asked me this question: how can one roll their own Windows OpenVPN
> installer, including a signed TAP driver?  There's no need to rebuild
> OpenVPN or the TAP driver, but they do need to include other things, such
> as certificates, config files etc.
> Is there a way to repackage the existing TAP driver?  are there
> instructions for that?
>

it depends on what he wants (and why).
just being curious, why does he want to roll own installer ?



as for rolling installer, easiest way is to use
https://github.com/openvpn/openvpn-build and add some modification (for
example, custom openvpn configs)


if he wants also to sign tap drivers, he needs EV codesign cert (for
windows 10)


>
> TIA,
>
> JJK
>
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

--001a1144a0fcd27e870558ab4c57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-09-08 15:10 GMT+05:00 Jan Just Keijser <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">hi dev list,<br>
<br>
someone asked me this question: how can one roll their own Windows OpenVPN =
installer, including a signed TAP driver?=C2=A0 There&#39;s no need to rebu=
ild OpenVPN or the TAP driver, but they do need to include other things, su=
ch as certificates, config files etc.<br>
Is there a way to repackage the existing TAP driver?=C2=A0 are there instru=
ctions for that?<br></blockquote><div><br></div><div>it depends on what he =
wants (and why).<br></div><div>just being curious, why does he want to roll=
 own installer ?<br><br><br><br></div><div>as for rolling installer, easies=
t way is to use <a href=3D"https://github.com/openvpn/openvpn-build">https:=
//github.com/openvpn/openvpn-build</a> and add some modification (for examp=
le, custom openvpn configs)<br><br><br></div><div>if he wants also to sign =
tap drivers, he needs EV codesign cert (for windows 10)<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
TIA,<br>
<br>
JJK<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a1144a0fcd27e870558ab4c57--

