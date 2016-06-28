MIME-Version: 1.0
In-Reply-To: <3119257f-3040-efae-fcf0-b04de0e1d9a9@...515...>
References: <CAFHpkQEVSSivEEYUaodCHSS-oYz11=7uzTq4JmQhZ4YsA9EE4Q@...278...>
	<3119257f-3040-efae-fcf0-b04de0e1d9a9@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 28 Jun 2016 13:13:14 +0500
Message-ID: <CAFHpkQG3t=x7eq=b9o8qhSriSOpdRrUGuWuyAsu6ZRBQoTH=nw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d48cc7220c405365235a6
Subject: Re: [Openvpn-devel] openvpn/openvpn-build
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

--94eb2c0d48cc7220c405365235a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

issues are still closed

2016-06-20 16:01 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Hello,
>>
>> I see issues are closed at https://github.com/openvpn/openvpn-build
>> what is preffered way of reporting bugs ?
>>
>
> I'm open to opening the issues again. If nobody objects, that's what I'll
> do.
>
> somehow, I managed to run it on cygwin without wget installed (I
>> installed curl),
>> so I see 'curl' branch is broken, curl does not follow redirects
>>
>> do we really need both wget and curl there ?
>>
>> I'd remove curl at all, it will make scripts more readable and
>> predictible. Or, ok, remove wget.
>>
>> actually, we can fix it. and even I'll expand travis-ci matrix for
>> curl/wget, but I do not really understand why do we need both wget and
>> curl there.
>>
>> Cheers,
>> Ilya Shipitsin
>>
>>
> I don't think we need both. Curl is just more likely to be present out of
> the box. For example, on RHEL/CentOS 7 wget is not installed by default.
> However, the users have to install tons of build dependencies anyways, so=
 I
> don't see a big problem with requiring wget.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--94eb2c0d48cc7220c405365235a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">issues are still closed<br></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">2016-06-20 16:01 GMT+05:00 Samuli Sepp=C3=
=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"=
_blank">samuli@...515...</a>&gt;</span>:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Hi,<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
I see issues are closed at <a href=3D"https://github.com/openvpn/openvpn-bu=
ild" rel=3D"noreferrer" target=3D"_blank">https://github.com/openvpn/openvp=
n-build</a><br>
what is preffered way of reporting bugs ?<br>
</blockquote>
<br></span>
I&#39;m open to opening the issues again. If nobody objects, that&#39;s wha=
t I&#39;ll do.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
somehow, I managed to run it on cygwin without wget installed (I<br>
installed curl),<br>
so I see &#39;curl&#39; branch is broken, curl does not follow redirects<br>
<br>
do we really need both wget and curl there ?<br>
<br>
I&#39;d remove curl at all, it will make scripts more readable and<br>
predictible. Or, ok, remove wget.<br>
<br>
actually, we can fix it. and even I&#39;ll expand travis-ci matrix for<br>
curl/wget, but I do not really understand why do we need both wget and<br>
curl there.<br>
<br>
Cheers,<br>
Ilya Shipitsin<br>
<br>
</blockquote>
<br></span>
I don&#39;t think we need both. Curl is just more likely to be present out =
of the box. For example, on RHEL/CentOS 7 wget is not installed by default.=
 However, the users have to install tons of build dependencies anyways, so =
I don&#39;t see a big problem with requiring wget.<span class=3D"HOEnZb"><f=
ont color=3D"#888888"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div>

--94eb2c0d48cc7220c405365235a6--

