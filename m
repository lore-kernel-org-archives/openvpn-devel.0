MIME-Version: 1.0
References: <20220222031424.406-1-lstipakov@...277...>
 <CAKuzo_h7XVDPk=G4toRDczLBy1GjsLbK7MpKXWxr5KJmONOUUw@...278...>
In-Reply-To: <CAKuzo_h7XVDPk=G4toRDczLBy1GjsLbK7MpKXWxr5KJmONOUUw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 3 May 2022 16:01:31 +0300
Message-ID: <CAGyAFMWSHhzpTzEe+TJXD6jasv+w+vGCYygH6uXjEm1k4L0qxQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000032321805de1b1c30"
Subject: Re: [Openvpn-devel] [PATCH] Fix M_ERRNO behavior on Windows
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

--00000000000032321805de1b1c30
Content-Type: text/plain; charset="UTF-8"

Hi,

Also there are some places openvpn_errno() is used and the result checked
> against POSIX error codes:
> in forward.c around line 2102:
>
> if (.... && ENETUNREACH == error_code && ...)
>
> where error_code = openvpn_errno() which may return WSAENETUNREACH on
> Windows not ENETUNREACH-- even that depends on GetLastError() and
> WSAGetLastError() to behave identically.
>

Thanks, fixed.


> Also does code like the below in socket.c do the right thing?
> (around line 1451 in socket.c)
> status = openvpn_errno();
> if (status == WSAEWOULDBLOCK) ....
> but openvpn_errono() doesn't look for WSA errors (though it probably still
> works?).
>

Yeah we compare GetLastError result here with WSA*, but in practice that
works. Here we just call openvpn_errno(), we could add WSA* support but
this will make code less readable for the benefit of being more "pure", not
sure it is worth it.


> -                    extended_msg, strerror(my_errno), sock ? sock->sd :
>> -1, my_errno);
>> +                    extended_msg, openvpn_strerror(my_errno, &gc), sock
>> ? sock->sd : -1, my_errno);
>>
>
> Here my_errno = openvpn_errno() -- don't we need the fallback to POSIX
> errno in this case? Could this also get called when a socket error is
> expected?
>

You are right. I slightly refactored that part to reuse crt error fallback
code which we need in 3 different places.

The rest looks good to me.
>

As you proposed, I removed WSA error printing from this patch, it could
come in a follow-up.

V2 is coming.

--00000000000032321805de1b1c30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><div>Also there are some places op=
envpn_errno() is used and the result checked against=C2=A0POSIX error codes=
:</div><div><div>in forward.c around line 2102:</div><div><br></div><div>if=
 (.... &amp;&amp; ENETUNREACH =3D=3D error_code &amp;&amp; ...)</div><div><=
br></div><div>where error_code =3D openvpn_errno() which may=C2=A0return WS=
AENETUNREACH on Windows not ENETUNREACH-- even that depends on GetLastError=
() and WSAGetLastError() to behave identically.</div></div></div></div></bl=
ockquote><div><br></div><div>Thanks, fixed.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div>Also does code like the below in socket.c do the right thing=
?</div><div>(around line 1451 in socket.c)</div><div>status =3D openvpn_err=
no();=C2=A0=C2=A0</div><div>if (status =3D=3D WSAEWOULDBLOCK) ....</div><di=
v>but openvpn_errono() doesn&#39;t=C2=A0look for WSA errors (though it prob=
ably still works?).</div></div></div></blockquote><div><br></div><div>Yeah =
we compare GetLastError result here with WSA*, but in practice that works. =
Here we just call openvpn_errno(), we could add WSA* support but this will =
make code less readable for the benefit of being more &quot;pure&quot;, not=
 sure it is worth it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, strerror(my_errno), sock ? sock-&gt;sd : -1, my_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exte=
nded_msg, openvpn_strerror(my_errno, &amp;gc), sock ? sock-&gt;sd : -1, my_=
errno);<br></blockquote><div><br></div><div>Here my_errno =3D openvpn_errno=
() -- don&#39;t we need the fallback to POSIX errno in this case? Could thi=
s also get called when a socket error is expected?</div></div></div></block=
quote><div><br></div><div>You are right. I slightly refactored that part to=
 reuse crt error fallback code which we need in 3 different places.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div class=3D"gmail_quote"><div>The rest looks good to me.</div></div>=
</div></blockquote><div><br></div><div>As you proposed, I removed WSA error=
 printing from this patch, it could come in a follow-up.</div><div>=C2=A0<b=
r></div><div>V2 is coming.</div></div></div>

--00000000000032321805de1b1c30--

