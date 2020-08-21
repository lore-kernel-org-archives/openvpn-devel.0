MIME-Version: 1.0
References: <20200819070746.197-1-lstipakov@...277...>
In-Reply-To: <20200819070746.197-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 21 Aug 2020 17:13:29 -0400
Message-ID: <CAKuzo_hm24jvC6C=fLO_Rzx0xu5rb_5LdDEwCoi5MSQPdGtqaw@...278...>
Content-Type: multipart/alternative; boundary="0000000000009a462b05ad6a1bc0"
Subject: Re: [Openvpn-devel] [PATCH] tun.c: enable using wintun driver under
 SYSTEM
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

--0000000000009a462b05ad6a1bc0
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Aug 19, 2020 at 3:08 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Commit 6d19775a468 has removed SYSTEM elevation hack,
> but introduced regression - inability to use wintun without interactive
> service.
>
> Proceed with ring buffers registration even if iservice is unavailable and
> display
> relevant error message.
>
> Trac #1318
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/tun.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 30454454..62557364 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6158,12 +6158,32 @@ wintun_register_ring_buffer(struct tuntap *tt,
> const char *device_guid)
>      }
>      else
>      {
> -        msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and
> therefore "
> -                     "should be used with interactive service. If you
> want to "
> -                     "use openvpn from command line, you need to do
> SYSTEM "
> -                     "elevation yourself (for example with psexec).");
> -    }
> +        if (!register_ring_buffers(tt->hand,
> +                                   tt->wintun_send_ring,
> +                                   tt->wintun_receive_ring,
> +                                   tt->rw_handle.read,
> +                                   tt->rw_handle.write))
> +        {
> +            switch (GetLastError())
> +            {
> +                case ERROR_ACCESS_DENIED:
> +                    msg(M_FATAL, "ERROR:  Wintun requires SYSTEM
> privileges and therefore "
> +                                 "should be used with interactive
> service. If you want to "
> +                                 "use openvpn from command line, you need
> to do SYSTEM "
> +                                 "elevation yourself (for example with
> psexec).");
> +                    break;
> +
> +                case ERROR_ALREADY_INITIALIZED:
> +                    msg(M_NONFATAL, "Adapter %s is already in use",
> device_guid);
> +                    break;
>
> +                default:
> +                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring
> buffers");
> +            }
> +            ret = false;
> +        }
> +
> +    }
>      return ret;
>  }
>

Looks good and running as SYSTEM works now as expected. Tested on 64 bit
Windows 10.

Acked-by: selva.nair@...277...

--0000000000009a462b05ad6a1bc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Aug 19, 2020 at 3:08 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov=
 &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&g=
t;<br>
<br>
Commit 6d19775a468 has removed SYSTEM elevation hack,<br>
but introduced regression - inability to use wintun without interactive ser=
vice.<br>
<br>
Proceed with ring buffers registration even if iservice is unavailable and =
display<br>
relevant error message.<br>
<br>
Trac #1318<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 30 +++++++++++++++++++++++++-----<br>
=C2=A01 file changed, 25 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 30454454..62557364 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6158,12 +6158,32 @@ wintun_register_ring_buffer(struct tuntap *tt, cons=
t char *device_guid)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;ERROR:=C2=A0 Wintun require=
s SYSTEM privileges and therefore &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;should be used with interactive service. If you want to &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;use openvpn from command line, you need to do SYSTEM &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;elevation yourself (for example with psexec).&quot;);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!register_ring_buffers(tt-&gt;hand,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;wintun_send_ring=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;wintun_receive_r=
ing,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.read,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.write)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (GetLastError())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case ERROR_ACCESS_=
DENIED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_FATAL, &quot;ERROR:=C2=A0 Wintun requires SYSTEM privileges and therefore=
 &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;should be used with inte=
ractive service. If you want to &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;use openvpn from command=
 line, you need to do SYSTEM &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;elevation yourself (for =
example with psexec).&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case ERROR_ALREADY=
_INITIALIZED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_NONFATAL, &quot;Adapter %s is already in use&quot;, device_guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_NONFATAL | M_ERRNO, &quot;Failed to register ring buffers&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br></blockquote><div><br></div><div>Looks good and running as SYSTE=
M works now as expected. Tested on 64 bit Windows 10.</div><div><br></div><=
div>Acked-by: <a href=3D"mailto:selva.nair@...277...">selva.nair@...277...<=
/a>=C2=A0</div></div></div>

--0000000000009a462b05ad6a1bc0--

