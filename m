MIME-Version: 1.0
References: <CAGyAFMWNV0RnyzK7d5SQ_qCWYTHwvY46LRhigVEGNEqeg-zXYA@...278...>
 <20191220161117.1434-2-simon@...2293...>
In-Reply-To: <20191220161117.1434-2-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 20:23:42 +0200
Message-ID: <CAGyAFMX58B0AO0JPaaFoOSwTQ5363PpRHnOjTxF=euawSw51aQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000b79190059a26c765"
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] tun.c: upgrade get_device_guid()
 to return the Windows driver type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b79190059a26c765
Content-Type: text/plain; charset="UTF-8"

Compared with v1, difference is updated function comment.

Compiled with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 20. jouluk. 2019 klo 18.14 Simon Rozman (simon@...2293...) kirjoitti:

> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 0d6f40fe..f90f201d 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4104,12 +4104,13 @@ get_unspecified_device_guid(const int
> device_number,
>
>  /*
>   * Lookup a --dev-node adapter name in the registry
> - * returning the GUID and optional actual_name.
> + * returning the GUID and optional actual_name and device type
>   */
>  static const char *
>  get_device_guid(const char *name,
>                  char *actual_name,
>                  int actual_name_size,
> +                bool *wintun,
>                  const struct tap_reg *tap_reg,
>                  const struct panel_reg *panel_reg,
>                  struct gc_arena *gc)
> @@ -4145,6 +4146,10 @@ get_device_guid(const char *name,
>          {
>              buf_printf(&actual, "%s", name);
>          }
> +        if (wintun)
> +        {
> +            *wintun = tr->wintun;
> +        }
>          return BSTR(&ret);
>      }
>
> @@ -4154,6 +4159,10 @@ get_device_guid(const char *name,
>          if (tr)
>          {
>              buf_printf(&actual, "%s", name);
> +            if (wintun)
> +            {
> +                *wintun = tr->wintun;
> +            }
>              buf_printf(&ret, "%s", tr->guid);
>              return BSTR(&ret);
>          }
> @@ -4838,7 +4847,7 @@ tap_allow_nonadmin_access(const char *dev_node)
>      if (dev_node)
>      {
>          /* Get the device GUID for the device specified with --dev-node.
> */
> -        device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), tap_reg, panel_reg, &gc);
> +        device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
>
>          if (!device_guid)
>          {
> @@ -5412,7 +5421,7 @@ netsh_get_id(const char *dev_node, struct gc_arena
> *gc)
>
>      if (dev_node)
>      {
> -        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual),
> tap_reg, panel_reg, gc);
> +        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual),
> NULL, tap_reg, panel_reg, gc);
>      }
>      else
>      {
> @@ -6132,7 +6141,7 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>      if (dev_node)
>      {
>          /* Get the device GUID for the device specified with --dev-node.
> */
> -        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), tap_reg, panel_reg, &gc);
> +        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
>
>          if (!*device_guid)
>          {
> --
> 2.24.1.windows.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000b79190059a26c765
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Compared with v1, difference is updated function comm=
ent.<br></div><div><br></div><div>Compiled with MSVC.</div><div><br></div><=
div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstip=
akov@...277...</a>&gt;</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">pe 20. jouluk. 2019 klo 18.14 Simon Rozman (<=
a href=3D"mailto:simon@...2293...">simon@...2293...</a>) kirjoitti:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Simon Ro=
zman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2311...=
3...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 17 +++++++++++++----<br>
=C2=A01 file changed, 13 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 0d6f40fe..f90f201d 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4104,12 +4104,13 @@ get_unspecified_device_guid(const int device_number=
,<br>
<br>
=C2=A0/*<br>
=C2=A0 * Lookup a --dev-node adapter name in the registry<br>
- * returning the GUID and optional actual_name.<br>
+ * returning the GUID and optional actual_name and device type<br>
=C2=A0 */<br>
=C2=A0static const char *<br>
=C2=A0get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *actual_=
name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int actual_na=
me_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *wintun,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
tap_reg *tap_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
panel_reg *panel_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_are=
na *gc)<br>
@@ -4145,6 +4146,10 @@ get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;actual, &qu=
ot;%s&quot;, name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *wintun =3D tr-&gt;wintun;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BSTR(&amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -4154,6 +4159,10 @@ get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;actual, &qu=
ot;%s&quot;, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *wintun =3D tr-&gt=
;wintun;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;ret, &quot;=
%s&quot;, tr-&gt;guid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BSTR(&amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -4838,7 +4847,7 @@ tap_allow_nonadmin_access(const char *dev_node)<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device GUID for the device spe=
cified with --dev-node. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid =3D get_device_guid(dev_node, actu=
al_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid =3D get_device_guid(dev_node, actu=
al_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -5412,7 +5421,7 @@ netsh_get_id(const char *dev_node, struct gc_arena *g=
c)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_device_guid(dev_node, BPTR(&amp;a=
ctual), BCAP(&amp;actual), tap_reg, panel_reg, gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_device_guid(dev_node, BPTR(&amp;a=
ctual), BCAP(&amp;actual), NULL, tap_reg, panel_reg, gc);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -6132,7 +6141,7 @@ tun_open_device(struct tuntap *tt, const char *dev_no=
de, const char **device_gui<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device GUID for the device spe=
cified with --dev-node. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-- <br>
2.24.1.windows.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000b79190059a26c765--

