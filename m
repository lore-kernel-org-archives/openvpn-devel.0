MIME-Version: 1.0
In-Reply-To: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
References: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 29 Dec 2016 00:23:32 -0500
Message-ID: <CAKuzo_ijVNp8jszViyEf0sePM2i6-OHhS6gcAV=g6h5KbTruBA@...278...>
Content-Type: multipart/alternative; boundary=001a114dbeee82effc0544c54aa1
Subject: Re: [Openvpn-devel] couple of questions on trac#665
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114dbeee82effc0544c54aa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 28, 2016 at 11:56 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
> I seem to see several times issues like described in #665
>

I have seen this in the past but, iirc, without the FlushipNetTable error,
though not 100% sure of that.

However,


>
> what seems to be strange is couple of things:
>
> 1) "OR" clause. why not "AND" ?  https://github.com/OpenVPN/
> openvpn/blob/master/src/openvpn/tun.c#L6012-L6013
>

OR is correct as either case (error in WriteFile or error in ReadFile) is a
failure.


>
>
> 2) error message seems to be irrelevant  https://github.com/OpenVPN/
> openvpn/blob/master/src/openvpn/tun.c#L6034
>

I think this results from failure to set the IP using DHCP and always
thought it to be some misbehavior in the tap driver. But the failure to
flush may be related...

Have you found a way to reproduce it consistently?

Selva

--001a114dbeee82effc0544c54aa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br></div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On=
 Wed, Dec 28, 2016 at 11:56 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div><div><div><br></div>I seem to see seve=
ral times issues like described in #665<br></div></div></blockquote><div><b=
r></div><div>I have seen this in the past but, iirc, without the FlushipNet=
Table error, though not 100% sure of that.<br><br></div><div>However, <br>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div><div></div><br></div>wh=
at seems to be strange is couple of things:<br><div><div><div><div><div><di=
v><br>1) &quot;OR&quot; clause. why not &quot;AND&quot; ?=C2=A0 <a href=3D"=
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6012-L601=
3" target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn/blob/master/sr=
c/<wbr>openvpn/tun.c#L6012-L6013</a></div></div></div></div></div></div></b=
lockquote><div><br></div><div>OR is correct as either case (error in WriteF=
ile or error in ReadFile) is a failure.<br>=C2=A0<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div><div><div><div><div><div><br><br></div><div>2) error me=
ssage seems to be irrelevant=C2=A0 <a href=3D"https://github.com/OpenVPN/op=
envpn/blob/master/src/openvpn/tun.c#L6034" target=3D"_blank">https://github=
.com/OpenVPN/<wbr>openvpn/blob/master/src/<wbr>openvpn/tun.c#L6034</a></div=
></div></div></div></div></div></blockquote></div><br></div><div class=3D"g=
mail_extra">I think this results from failure to set the IP using DHCP and =
always thought it to be some misbehavior in the tap driver. But the failure=
 to flush may be related...<br><br></div><div class=3D"gmail_extra">Have yo=
u found a way to reproduce it consistently?<br><br></div><div class=3D"gmai=
l_extra">Selva<br></div><div class=3D"gmail_extra"><br></div></div>

--001a114dbeee82effc0544c54aa1--

