MIME-Version: 1.0
In-Reply-To: <CAFHpkQHhqSkyEOhONC+_VC-=vJtRf_8bJhQFtbqwSEKW=OSOAQ@...278...>
References: <CAKuzo_jBysn9U0BfWPb0m_D2J9Sg3UFLnUUbjiow0wcv0ZiUeg@...278...>
 <CAFHpkQHhqSkyEOhONC+_VC-=vJtRf_8bJhQFtbqwSEKW=OSOAQ@...278...>
From: Selva <selva.nair@...277...>
Date: Sun, 19 Nov 2017 00:43:17 -0500
Message-ID: <CAKuzo_g3rQRFqCQQvME2oyb-2vxr4-o2o65oKFxnPshOs46cbw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c046b9e923528055e4f7310"
Subject: Re: [Openvpn-devel] input validation for username, password etc.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c046b9e923528055e4f7310
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 12:06 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
>
> 2017-11-18 8:25 GMT+05:00 Selva <selva.nair@...277...>:
>
>> Hi,
>>
>> I want to add some form of validation for user input in the GUI so that
>> the user can be alerted when username, password etc. contains characters
>> that may not work.
>>
>> So far the only characters that appear to be problematic are new line
>> ('\n') and embedded '\0'.  As the management interface uses a line based
>> protocol with '\n' as the delimiter, it can't be a part of input strings
>> and breaks quoting.
>>
>> Is there any other character that should be disallowed?
>>
>
> there's something to investigate about "
>
> https://github.com/OpenVPN/openvpn-gui/blob/master/TODO#L3
>

I was also confused by that line in TODO about '"' in password. It seems to
be an
outdated entry and the GUI does correctly handle '"' in passwords. Unless
openvpn
core itself has a problem with embedded quotes..

Selva

--94eb2c046b9e923528055e4f7310
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Nov 19, 2017 at 12:06 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chip=
itsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote"><span class=3D"">2017-11-18 8:25 =
GMT+05:00 Selva <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...1663...=
." target=3D"_blank">selva.nair@...277...</a>&gt;</span>:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div=
>I want to add some form of validation for user input in the GUI so that th=
e user can be alerted when <span id=3D"m_3169954206975427059gmail-m_5308574=
593088888245:1me.1">username</span>, password etc. contains characters that=
 may not work.</div><div><br></div><div>So far the only characters that app=
ear to be problematic are new line (&#39;\n&#39;) and embedded &#39;\0&#39;=
.=C2=A0 As the management interface uses a line based protocol with &#39;\n=
&#39; as the delimiter, it can&#39;t be a part of input strings and breaks =
quoting.</div><div><br></div><div>Is there any other character that should =
be disallowed?</div></div></blockquote><div><br></div></span><div>there&#39=
;s something to investigate about &quot;<br><br><a href=3D"https://github.c=
om/OpenVPN/openvpn-gui/blob/master/TODO#L3" target=3D"_blank">https://githu=
b.com/OpenVPN/<wbr>openvpn-gui/blob/master/TODO#<wbr>L3</a></div></div></di=
v></div></blockquote><div><br></div><div>I was also confused by that line i=
n TODO about &#39;&quot;&#39; in password. It seems to be an</div><div>outd=
ated entry and the GUI does correctly handle &#39;&quot;&#39; in passwords.=
 Unless openvpn</div><div>core itself has a problem with embedded quotes..<=
/div><div><br></div><div>Selva</div></div></div></div>

--94eb2c046b9e923528055e4f7310--

