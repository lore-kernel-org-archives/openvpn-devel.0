MIME-Version: 1.0
References: <20220218124149.149-1-lstipakov@...277...>
 <CAGyAFMVOCdv0JiQfsLqm5kDqdwCAsX=zxT06UTMQvet7tP4nhA@...278...>
 <CAKuzo_jHvf6zgTyOHvy01+LZoUXK9eOTOEky9CTon=xTBfTcLA@...278...>
In-Reply-To: <CAKuzo_jHvf6zgTyOHvy01+LZoUXK9eOTOEky9CTon=xTBfTcLA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Feb 2022 11:30:28 +0200
Message-ID: <CAGyAFMWA+7oY4aSDJS_kW11okMnyUAJrkpC45XcNGk0C0St6Vw@...278...>
Content-Type: multipart/alternative; boundary="0000000000009d35be05d89800d6"
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000009d35be05d89800d6
Content-Type: text/plain; charset="UTF-8"

Hi,


> While this would be a cleaner fix, it also requires extensive changes and
> it is not always easy to decide where to use M_ERRNO and where to use
> M_WINERR. E.g., without looking into the internals of platform.c one
> doesn't know whether platform_open() uses _wopen() or CreateFile().
>

True.


> A possible option is to continue the use of M_ERRNO on WIndows as is
> (except for socket errors), continue to use GetLastError() in x_msg(), but
> if/when the latter if it returns zero, try errno and strerrror(). Not ideal
> but less changes and easier and transparent to the user of msg(). That
> said, I haven't checked whether GetLastError() returns zero or a valid and
> correct error code for C runtime errors -- without which this approach wont
> work.
>

I did some tests, ::GetLastError appears to return zero or correct error
code:

    sqrt(-1);
    int err = errno; // -33 EDOM
    DWORD lasterr = GetLastError(); // 0

    _open("c:\\Temp\\notfound", _O_RDONLY);
    err = errno; // 2 ENOENT
    lasterr = GetLastError(); // 2 ERROR_FILE_NOT_FOUND

    _open("c:\\Temp\\directory", _O_RDONLY);
    err = errno; // 13 EACCES
    lasterr = GetLastError(); // 5 ERROR_ACCESS_DENIED

    malloc(10000000000);
    err = errno; // 12 ENOMEM
    lasterr = GetLastError(); // 8 ERROR_NOT_ENOUGH_MEMORY

So let's go with this approach.


> BTW, there are a couple of uses of strerror() in check_status() (error.c)
> missed by the original patch.
>

Thanks, I will address it in this "proper" fix.

-- 
-Lev

--0000000000009d35be05d89800d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_quote"><div>While this would be a cleaner fix, it also requires=
 extensive changes and it is not always easy to decide where to use M_ERRNO=
 and where to use M_WINERR. E.g., without looking into the internals of pla=
tform.c=C2=A0one doesn&#39;t know whether platform_open() uses _wopen() or =
CreateFile().</div></div></div></blockquote><div><br></div><div>True.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div>A possible option is to continue t=
he use of M_ERRNO on WIndows as is (except for socket errors), continue to =
use GetLastError() in x_msg(), but if/when the latter if it returns zero, t=
ry errno and strerrror(). Not ideal but less changes and easier and transpa=
rent to the user of msg(). That said, I haven&#39;t=C2=A0checked whether Ge=
tLastError() returns zero or a valid and correct error code for C runtime e=
rrors -- without which this approach wont work.</div></div></div></blockquo=
te><div><br></div><div>I did some tests, ::GetLastError appears to return=
=C2=A0zero or correct error code:</div><div><br></div><div>=C2=A0 =C2=A0 sq=
rt(-1);<br>=C2=A0 =C2=A0 int err =3D errno; // -33 EDOM<br>=C2=A0 =C2=A0 DW=
ORD lasterr =3D GetLastError(); // 0<br><br>=C2=A0 =C2=A0 _open(&quot;c:\\T=
emp\\notfound&quot;, _O_RDONLY);<br>=C2=A0 =C2=A0 err =3D errno; // 2 ENOEN=
T<br>=C2=A0 =C2=A0 lasterr =3D GetLastError(); // 2 ERROR_FILE_NOT_FOUND<br=
><br>=C2=A0 =C2=A0 _open(&quot;c:\\Temp\\directory&quot;, _O_RDONLY);<br>=
=C2=A0 =C2=A0 err =3D errno; // 13 EACCES<br>=C2=A0 =C2=A0 lasterr =3D GetL=
astError(); // 5 ERROR_ACCESS_DENIED<br><br>=C2=A0 =C2=A0 malloc(1000000000=
0);<br>=C2=A0 =C2=A0 err =3D errno; // 12 ENOMEM<br>=C2=A0 =C2=A0 lasterr =
=3D GetLastError(); // 8 ERROR_NOT_ENOUGH_MEMORY</div><div><br></div><div>S=
o let&#39;s go with this approach.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote=
"><div>BTW, there are a couple of uses of strerror() in check_status() (err=
or.c) missed by the original patch.</div></div></div></blockquote><div><br>=
</div><div>Thanks, I will address it in this &quot;proper&quot; fix.</div><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev<=
/div></div>

--0000000000009d35be05d89800d6--

