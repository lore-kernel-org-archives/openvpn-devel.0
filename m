MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-5-simon@...2293...>
In-Reply-To: <20191219223917.1614-5-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 11:23:24 +0200
Message-ID: <CAGyAFMXWyKbYTPLDDd3vedDDuFY+GqNu1V=RqGvY_JhevVJBzQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000067f091059a1f3bb6"
Subject: Re: [Openvpn-devel] [PATCH 5/7] wintun: add support for --dev-node
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

--00000000000067f091059a1f3bb6
Content-Type: text/plain; charset="UTF-8"

Built, tested - works as expected. Probably the first time I ran two VPN
tunnels with OpenVPN-GUI.

The code has an assumption, however, that "windows-driver" power over
"dev-node" -
if --dev-node is "OpenVPNWinTun" (for example) and "windows-driver" is not
specified, we bail out.

I would add something like "if you want to use this device, add
--windows-driver wintun" (and similar for tap)
to the error message - I think it is good to tell user how to proceed in
case of error(s).

Acked-by: Lev Stipakov <lstipakov@...277...>



pe 20. jouluk. 2019 klo 0.40 Simon Rozman (simon@...2293...) kirjoitti:

> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 9dc9b3a2..8508b9c0 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6194,7 +6194,6 @@ static void
>  tun_open_device(struct tuntap *tt, const char *dev_node, const char
> **device_guid)
>  {
>      struct gc_arena gc = gc_new();
> -    char tuntap_device_path[256];
>      const struct tap_reg* tap_reg = get_tap_reg(&gc);
>      const struct panel_reg* panel_reg = get_panel_reg(&gc);
>      const struct device_instance_id_interface*
> device_instance_id_interface = get_device_instance_id_interface(&gc);
> @@ -6207,31 +6206,34 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>       */
>      if (dev_node)
>      {
> +        bool is_picked_device_wintun = false;
> +
>          /* Get the device GUID for the device specified with --dev-node.
> */
> -        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
> +        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), &is_picked_device_wintun, tap_reg, panel_reg, &gc);
>
>          if (!*device_guid)
>          {
> -            msg(M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
> +            msg(M_FATAL, "Adapter '%s' not found", dev_node);
>          }
>
> -        /* Open Windows TAP-Windows adapter */
> -        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path),
> "%s%s%s",
> -                         USERMODEDEVICEDIR,
> -                         *device_guid,
> -                         TAP_WIN_SUFFIX);
> -
> -        tt->hand = CreateFile(tuntap_device_path,
> -                              GENERIC_READ | GENERIC_WRITE,
> -                              0,                /* was: FILE_SHARE_READ */
> -                              0,
> -                              OPEN_EXISTING,
> -                              FILE_ATTRIBUTE_SYSTEM |
> FILE_FLAG_OVERLAPPED,
> -                              0);
> +        if (tt->wintun)
> +        {
> +            if (!is_picked_device_wintun)
> +            {
> +                msg(M_FATAL, "Adapter '%s' is TAP-Windows, Wintun
> expected", dev_node);
> +            }
> +        }
> +        else
> +        {
> +            if (is_picked_device_wintun)
> +            {
> +                msg(M_FATAL, "Adapter '%s' is Wintun, TAP-Windows
> expected", dev_node);
> +            }
> +        }
>
> -        if (tt->hand == INVALID_HANDLE_VALUE)
> +        if (!tun_try_open_device(tt, *device_guid,
> device_instance_id_interface))
>          {
> -            msg(M_ERR, "CreateFile failed on TAP device: %s",
> tuntap_device_path);
> +            msg(M_FATAL, "Failed to open %s adapter: %s", tt->wintun ?
> "Wintun" : "TAP-Windows", dev_node);
>          }
>      }
>      else
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

--00000000000067f091059a1f3bb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Built, tested - works as expected. Probably the first time=
 I ran two VPN tunnels with OpenVPN-GUI.<div><br></div><div>The code has an=
 assumption, however, that &quot;windows-driver&quot; power over &quot;dev-=
node&quot; -=C2=A0</div><div>if --dev-node is &quot;OpenVPNWinTun&quot; (fo=
r example) and &quot;windows-driver&quot; is not specified, we bail out.</d=
iv><div><br></div><div>I would add something like &quot;if you want to use =
this device, add --windows-driver wintun&quot; (and similar for tap)=C2=A0<=
/div><div>to the error message - I think it is good to tell user how to pro=
ceed in case of error(s).</div><div><br></div><div>Acked-by: Lev Stipakov &=
lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1664...=
7...</a>&gt;<br></div><div><br></div><div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">pe 20. jouluk. 2019 klo=
 0.40 Simon Rozman (<a href=3D"mailto:simon@...2293..." target=3D"_blank">s=
imon@...2293...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Signed-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...493...=
2293..." target=3D"_blank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 38 ++++++++++++++++++++------------------<br>
=C2=A01 file changed, 20 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 9dc9b3a2..8508b9c0 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6194,7 +6194,6 @@ static void<br>
=C2=A0tun_open_device(struct tuntap *tt, const char *dev_node, const char *=
*device_guid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 char tuntap_device_path[256];<br>
=C2=A0 =C2=A0 =C2=A0const struct tap_reg* tap_reg =3D get_tap_reg(&amp;gc);=
<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg* panel_reg =3D get_panel_reg(&am=
p;gc);<br>
=C2=A0 =C2=A0 =C2=A0const struct device_instance_id_interface* device_insta=
nce_id_interface =3D get_device_instance_id_interface(&amp;gc);<br>
@@ -6207,31 +6206,34 @@ tun_open_device(struct tuntap *tt, const char *dev_=
node, const char **device_gui<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_picked_device_wintun =3D false;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device GUID for the device spe=
cified with --dev-node. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), &amp;is_picked_device_wintun, tap_reg, p=
anel_reg, &amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;TAP-Windows a=
dapter &#39;%s&#39; not found&quot;, dev_node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Adapter &#39;=
%s&#39; not found&quot;, dev_node);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open Windows TAP-Windows adapter */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(tuntap_device_path, sizeof(tu=
ntap_device_path), &quot;%s%s%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0USERMODEDEVICEDIR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*device_guid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TAP_WIN_SUFFIX);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(tuntap_device_path,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENERIC_READ | GENERIC_WRITE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* was: FILE_SHARE_READ */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPEN_EXISTING,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPE=
D,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_picked_device_wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot=
;Adapter &#39;%s&#39; is TAP-Windows, Wintun expected&quot;, dev_node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_picked_device_wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot=
;Adapter &#39;%s&#39; is Wintun, TAP-Windows expected&quot;, dev_node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;hand =3D=3D INVALID_HANDLE_VALUE)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tun_try_open_device(tt, *device_guid, dev=
ice_instance_id_interface))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;CreateFile fail=
ed on TAP device: %s&quot;, tuntap_device_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Failed to ope=
n %s adapter: %s&quot;, tt-&gt;wintun ? &quot;Wintun&quot; : &quot;TAP-Wind=
ows&quot;, dev_node);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
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
>-Lev</div>

--00000000000067f091059a1f3bb6--

