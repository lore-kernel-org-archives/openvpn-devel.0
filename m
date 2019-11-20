MIME-Version: 1.0
References: <20191119190951.87-1-lstipakov@...277...>
In-Reply-To: <20191119190951.87-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 20 Nov 2019 17:09:09 +0200
Message-ID: <CAGyAFMVe8DR4jfW9i_L_f23cN8J7vMaefCXOe3W-OM743BHJNg@...278...>
Content-Type: multipart/alternative; boundary="000000000000d5151a0597c8909b"
Subject: Re: [Openvpn-devel] [PATCH 8/7] wintun: fix ringbuffer registration
 call
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

--000000000000d5151a0597c8909b
Content-Type: text/plain; charset="UTF-8"

Please disregard this patch - I made it as a fix to
"wintun: ring buffers based I/O", which was resent as v5.

ti 19. marrask. 2019 klo 21.10 Lev Stipakov (lstipakov@...277...) kirjoitti:

> From: Lev Stipakov <lev@...515...>
>
> As MS documentation says:
>
>  > If lpOverlapped is NULL, lpBytesReturned cannot be NULL
>
> While on Windows 10 passing NULL works by accident,
> on Windows 7 it crashes.
>
> Reported-by: kitsune1
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/ring_buffer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c
> index 482e3336..d384f497 100644
> --- a/src/openvpn/ring_buffer.c
> +++ b/src/openvpn/ring_buffer.c
> @@ -35,6 +35,7 @@ register_ring_buffers(HANDLE device,
>  {
>      struct tun_register_rings rr;
>      BOOL res;
> +    DWORD bytes_returned;
>
>      ZeroMemory(&rr, sizeof(rr));
>
> @@ -46,7 +47,8 @@ register_ring_buffers(HANDLE device,
>      rr.receive.ring_size = sizeof(receive_ring->data);
>      rr.receive.tail_moved = receive_tail_moved;
>
> -    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr,
> sizeof(rr), NULL, 0, NULL, NULL);
> +    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr,
> sizeof(rr),
> +        NULL, 0, &bytes_returned, NULL);
>
>      return res == TRUE;
>  }
> --
> 2.17.1
>
>

-- 
-Lev

--000000000000d5151a0597c8909b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please disregard this patch - I made it as a fix to<div>&q=
uot;wintun: ring buffers based I/O&quot;, which was resent as v5.</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ti 1=
9. marrask. 2019 klo 21.10 Lev Stipakov (<a href=3D"mailto:lstipakov@...1482...=
...">lstipakov@...277...</a>) kirjoitti:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...1387...=
5..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
As MS documentation says:<br>
<br>
=C2=A0&gt; If lpOverlapped is NULL, lpBytesReturned cannot be NULL<br>
<br>
While on Windows 10 passing NULL works by accident,<br>
on Windows 7 it crashes.<br>
<br>
Reported-by: kitsune1<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ring_buffer.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c<br>
index 482e3336..d384f497 100644<br>
--- a/src/openvpn/ring_buffer.c<br>
+++ b/src/openvpn/ring_buffer.c<br>
@@ -35,6 +35,7 @@ register_ring_buffers(HANDLE device,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct tun_register_rings rr;<br>
=C2=A0 =C2=A0 =C2=A0BOOL res;<br>
+=C2=A0 =C2=A0 DWORD bytes_returned;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ZeroMemory(&amp;rr, sizeof(rr));<br>
<br>
@@ -46,7 +47,8 @@ register_ring_buffers(HANDLE device,<br>
=C2=A0 =C2=A0 =C2=A0rr.receive.ring_size =3D sizeof(receive_ring-&gt;data);=
<br>
=C2=A0 =C2=A0 =C2=A0rr.receive.tail_moved =3D receive_tail_moved;<br>
<br>
-=C2=A0 =C2=A0 res =3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &a=
mp;rr, sizeof(rr), NULL, 0, NULL, NULL);<br>
+=C2=A0 =C2=A0 res =3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &a=
mp;rr, sizeof(rr),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, 0, &amp;bytes_returned, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return res =3D=3D TRUE;<br>
=C2=A0}<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000d5151a0597c8909b--

