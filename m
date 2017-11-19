MIME-Version: 1.0
In-Reply-To: <CAKuzo_jBysn9U0BfWPb0m_D2J9Sg3UFLnUUbjiow0wcv0ZiUeg@...278...>
References: <CAKuzo_jBysn9U0BfWPb0m_D2J9Sg3UFLnUUbjiow0wcv0ZiUeg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 19 Nov 2017 10:06:20 +0500
Message-ID: <CAFHpkQHhqSkyEOhONC+_VC-=vJtRf_8bJhQFtbqwSEKW=OSOAQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05a3b03898cb055e4eee31"
Subject: Re: [Openvpn-devel] input validation for username, password etc.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05a3b03898cb055e4eee31
Content-Type: text/plain; charset="UTF-8"

2017-11-18 8:25 GMT+05:00 Selva <selva.nair@...277...>:

> Hi,
>
> I want to add some form of validation for user input in the GUI so that
> the user can be alerted when username, password etc. contains characters
> that may not work.
>
> So far the only characters that appear to be problematic are new line
> ('\n') and embedded '\0'.  As the management interface uses a line based
> protocol with '\n' as the delimiter, it can't be a part of input strings
> and breaks quoting.
>
> Is there any other character that should be disallowed?
>

there's something to investigate about "

https://github.com/OpenVPN/openvpn-gui/blob/master/TODO#L3


>
> Thanks,
>
> Selva
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

--94eb2c05a3b03898cb055e4eee31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-11-18 8:25 GMT+05:00 Selva <span dir=3D"ltr">&lt;<a href=3D"mailto=
:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi=
,<div><br></div><div>I want to add some form of validation for user input i=
n the GUI so that the user can be alerted when <span id=3D"gmail-m_53085745=
93088888245:1me.1">username</span>, password etc. contains characters that =
may not work.</div><div><br></div><div>So far the only characters that appe=
ar to be problematic are new line (&#39;\n&#39;) and embedded &#39;\0&#39;.=
=C2=A0 As the management interface uses a line based protocol with &#39;\n&=
#39; as the delimiter, it can&#39;t be a part of input strings and breaks q=
uoting.</div><div><br></div><div>Is there any other character that should b=
e disallowed?</div></div></blockquote><div><br></div><div>there&#39;s somet=
hing to investigate about &quot;<br><br><a href=3D"https://github.com/OpenV=
PN/openvpn-gui/blob/master/TODO#L3">https://github.com/OpenVPN/openvpn-gui/=
blob/master/TODO#L3</a><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>Thanks,</div>=
<div><br></div><div><span id=3D"gmail-m_5308574593088888245:1me.2">Selva</s=
pan></div></div>
<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
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

--94eb2c05a3b03898cb055e4eee31--

