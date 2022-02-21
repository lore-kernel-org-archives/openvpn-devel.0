MIME-Version: 1.0
References: <20220218124149.149-1-lstipakov@...277...>
 <CAGyAFMVOCdv0JiQfsLqm5kDqdwCAsX=zxT06UTMQvet7tP4nhA@...278...>
In-Reply-To: <CAGyAFMVOCdv0JiQfsLqm5kDqdwCAsX=zxT06UTMQvet7tP4nhA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Feb 2022 11:49:49 -0500
Message-ID: <CAKuzo_jHvf6zgTyOHvy01+LZoUXK9eOTOEky9CTon=xTBfTcLA@...278...>
Content-Type: multipart/alternative; boundary="0000000000004cf91a05d88a06dc"
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5] error.c: use correct
 API to get error description on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000004cf91a05d88a06dc
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Feb 21, 2022 at 4:24 AM Lev Stipakov <lstipakov@...277...> wrote:

> We had a long discussion with ordex about this patch and came to the
> conclusion that error printing is currently broken on Windows and
> needs a proper fixing.
>
>
+1


> What we propose:
>
>  - M_ERRNO prints only C runtime errors on all platforms and should be
> only used with C runtime functions
>  - We add M_WINERR which uses GetLastError and FormatMessage to print
> Windows errors
>

While this would be a cleaner fix, it also requires extensive changes and
it is not always easy to decide where to use M_ERRNO and where to use
M_WINERR. E.g., without looking into the internals of platform.c one
doesn't know whether platform_open() uses _wopen() or CreateFile().

A possible option is to continue the use of M_ERRNO on WIndows as is
(except for socket errors), continue to use GetLastError() in x_msg(), but
if/when the latter if it returns zero, try errno and strerrror(). Not ideal
but less changes and easier and transparent to the user of msg(). That
said, I haven't checked whether GetLastError() returns zero or a valid and
correct error code for C runtime errors -- without which this approach wont
work.

 - We add M_SOCKERR, which is resolved into M_ERRNO on all platforms
> except Windows and on Windows it is M_WSAERR. We use WSAGetLastError
> and FormatMessage to print WSA errors. Socket functions use M_SOCKERR.
>

Sounds good.

BTW, there are a couple of uses of strerror() in check_status() (error.c)
missed by the original patch.

Selva

--0000000000004cf91a05d88a06dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 21, 2022 at 4:24 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">We had a long discu=
ssion with ordex about this patch and came to the<br>
conclusion that error printing is currently broken on Windows and<br>
needs a proper fixing.<br><br></blockquote><div><br></div><div>+1=C2=A0</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
What we propose:<br>
<br>
=C2=A0- M_ERRNO prints only C runtime errors on all platforms and should be=
<br>
only used with C runtime functions<br>
=C2=A0- We add M_WINERR which uses GetLastError and FormatMessage to print<=
br>
Windows errors<br></blockquote><div><br></div><div>While this would be a cl=
eaner fix, it also requires extensive changes and it is not always easy to =
decide where to use M_ERRNO and where to use M_WINERR. E.g., without lookin=
g into the internals of platform.c=C2=A0one doesn&#39;t know whether platfo=
rm_open() uses _wopen() or CreateFile().</div><div><br></div><div>A possibl=
e option is to continue the use of M_ERRNO on WIndows as is (except for soc=
ket errors), continue to use GetLastError() in x_msg(), but if/when the lat=
ter if it returns zero, try errno and strerrror(). Not ideal but less chang=
es and easier and transparent to the user of msg(). That said, I haven&#39;=
t=C2=A0checked whether GetLastError() returns zero or a valid and correct e=
rror code for C runtime errors -- without which this approach wont work.</d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0- We add M_SOCKERR, which is resolved into M_ERRNO on all platforms<b=
r>
except Windows and on Windows it is M_WSAERR. We use WSAGetLastError<br>
and FormatMessage to print WSA errors. Socket functions use M_SOCKERR.<br><=
/blockquote><div><br></div><div>Sounds good.</div><div><br></div><div>BTW, =
there are a couple of uses of strerror() in check_status() (error.c) missed=
 by the original patch.</div><div><br></div><div>Selva</div></div></div>

--0000000000004cf91a05d88a06dc--

