MIME-Version: 1.0
In-Reply-To: <CAKuzo_ijVNp8jszViyEf0sePM2i6-OHhS6gcAV=g6h5KbTruBA@...278...>
References: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
	<CAKuzo_ijVNp8jszViyEf0sePM2i6-OHhS6gcAV=g6h5KbTruBA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 29 Dec 2016 10:30:58 +0500
Message-ID: <CAFHpkQEOFo86emyCq5LwzTsn9Tw7u2EYBNDFkNv8GrgZ_DdJmw@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4ee65d550544c5638b
Subject: Re: [Openvpn-devel] couple of questions on trac#665
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

--047d7bf10b4ee65d550544c5638b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-29 10:23 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Wed, Dec 28, 2016 at 11:56 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>>
>> I seem to see several times issues like described in #665
>>
>
> I have seen this in the past but, iirc, without the FlushipNetTable error,
> though not 100% sure of that.
>
> However,
>
>
>>
>> what seems to be strange is couple of things:
>>
>> 1) "OR" clause. why not "AND" ?  https://github.com/OpenVPN/ope
>> nvpn/blob/master/src/openvpn/tun.c#L6012-L6013
>>
>
> OR is correct as either case (error in WriteFile or error in ReadFile) is
> a failure.
>
>
>>
>>
>> 2) error message seems to be irrelevant  https://github.com/OpenVPN/ope
>> nvpn/blob/master/src/openvpn/tun.c#L6034
>>
>
> I think this results from failure to set the IP using DHCP and always
> thought it to be some misbehavior in the tap driver. But the failure to
> flush may be related...
>
> Have you found a way to reproduce it consistently?
>

not yet.

so ... should we at least improve debug here ?

I would split !read || !write into 2 separate calls with separate debug log
messages... and move FlushIpNet error closer to FlushIpNet call.

right ?


>
> Selva
>
>

--047d7bf10b4ee65d550544c5638b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-29 10:23 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_extra">Hi,<br></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra"><div class=3D"gmail_quote"><span class=3D"">On Wed, Dec 28, 2=
016 at 11:56 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." tar=
get=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div><div><div><br></div>I seem to see several times issue=
s like described in #665<br></div></div></blockquote><div><br></div></span>=
<div>I have seen this in the past but, iirc, without the FlushipNetTable er=
ror, though not 100% sure of that.<br><br></div><div>However, <br>=C2=A0<br=
></div><span class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div></div><br>=
</div>what seems to be strange is couple of things:<br><div><div><div><div>=
<div><div><br>1) &quot;OR&quot; clause. why not &quot;AND&quot; ?=C2=A0 <a =
href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6=
012-L6013" target=3D"_blank">https://github.com/OpenVPN/ope<wbr>nvpn/blob/m=
aster/src/openvpn/<wbr>tun.c#L6012-L6013</a></div></div></div></div></div><=
/div></blockquote><div><br></div></span><div>OR is correct as either case (=
error in WriteFile or error in ReadFile) is a failure.<br>=C2=A0<br></div><=
span class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div><div><div><div><div><di=
v><br><br></div><div>2) error message seems to be irrelevant=C2=A0 <a href=
=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6034"=
 target=3D"_blank">https://github.com/OpenVPN/ope<wbr>nvpn/blob/master/src/=
openvpn/<wbr>tun.c#L6034</a></div></div></div></div></div></div></blockquot=
e></span></div><br></div><div class=3D"gmail_extra">I think this results fr=
om failure to set the IP using DHCP and always thought it to be some misbeh=
avior in the tap driver. But the failure to flush may be related...<br><br>=
</div><div class=3D"gmail_extra">Have you found a way to reproduce it consi=
stently?<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></=
div></div></blockquote><div><br></div><div>not yet.<br><br></div><div>so ..=
. should we at least improve debug here ?<br><br></div><div>I would split !=
read || !write into 2 separate calls with separate debug log messages... an=
d move FlushIpNet error closer to FlushIpNet call.<br><br></div><div>right =
?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_extra"><span class=3D"HOEnZb"><font color=3D"#888888">=
<br></font></span></div><span class=3D"HOEnZb"><font color=3D"#888888"><div=
 class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_extra"><br></div>=
</font></span></div>
</blockquote></div><br></div></div>

--047d7bf10b4ee65d550544c5638b--

