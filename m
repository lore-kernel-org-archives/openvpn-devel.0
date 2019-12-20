MIME-Version: 1.0
References: <CAGyAFMXxKQaroPRMFNFU7pATm7=t7RiQQ5aspUEWiK9FQ=iDuQ@...278...>
 <20191220193805.34-1-simon@...2293...>
In-Reply-To: <20191220193805.34-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 22:15:16 +0200
Message-ID: <CAGyAFMUbGKALvQi9icq0Ls=_k-Y_YVrUDdTymWwQLGWANFjx_g@...278...>
Content-Type: multipart/alternative; boundary="000000000000bdec35059a28564d"
Subject: Re: [Openvpn-devel] [PATCH v3 4/7] wintun: register ring buffers
 when iterating adapters
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

--000000000000bdec35059a28564d
Content-Type: text/plain; charset="UTF-8"

Compiled, tested.

Acked-by: Lev Stipakov <lstipakov@...277...>

PS

When you send v2 etc, could you add changelog to git mail after "---" line.

See https://patchwork.openvpn.net/patch/388/ as an example:

    Signed-off-by: Antonio Quartulli <antonio@...515...>
    ---

    Changes from v2:
    - patchset rebased on top of pre-ipv6-only patchset
    - change commit subject/message
    - move ifconfig-ipv6-pool check change into 4/8

    src/openvpn/helper.c | 8 ++++++--
    1 file changed, 6 insertions(+), 2 deletions(-)

    diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c


pe 20. jouluk. 2019 klo 21.39 Simon Rozman (simon@...2293...) kirjoitti:

> Wintun adapters may be considered available if ring buffer registration
> succeeded. Therefore, we must attempt to register ring buffers when
> iterating adapters and continue on failure.
>
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 111 +++++++++++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 46 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index c6bbbd41..aef2c7f8 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6129,11 +6129,72 @@ tuntap_dhcp_mask(const struct tuntap *tt, const
> char *device_guid)
>      gc_free(&gc);
>  }
>
> +static bool
> +tun_try_open_device(struct tuntap *tt, const char *device_guid, const
> struct device_instance_id_interface *device_instance_id_interface)
> +{
> +    const char *path = NULL;
> +    char tuntap_device_path[256];
> +
> +    if (tt->wintun)
> +    {
> +        const struct device_instance_id_interface *dev_if;
> +
> +        /* Open Wintun adapter */
> +        for (dev_if = device_instance_id_interface; dev_if != NULL;
> dev_if = dev_if->next)
> +        {
> +            if (strcmp(dev_if->net_cfg_instance_id, device_guid) == 0)
> +            {
> +                path = dev_if->device_interface_list;
> +                break;
> +            }
> +        }
> +        if (path == NULL)
> +        {
> +            return false;
> +        }
> +    }
> +    else
> +    {
> +        /* Open TAP-Windows adapter */
> +        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path),
> "%s%s%s",
> +                            USERMODEDEVICEDIR,
> +                            device_guid,
> +                            TAP_WIN_SUFFIX);
> +        path = tuntap_device_path;
> +    }
> +
> +    tt->hand = CreateFile(path,
> +                   GENERIC_READ | GENERIC_WRITE,
> +                   0,                /* was: FILE_SHARE_READ */
> +                   0,
> +                   OPEN_EXISTING,
> +                   FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> +                   0);
> +    if (tt->hand == INVALID_HANDLE_VALUE)
> +    {
> +        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s",
> tt->wintun ? "Wintun" : "TAP-Windows", path);
> +        return false;
> +    }
> +
> +    if (tt->wintun)
> +    {
> +        /* Wintun adapter may be considered "open" after ring buffers are
> successfuly registered. */
> +        if (!wintun_register_ring_buffer(tt))
> +        {
> +            msg(D_TUNTAP_INFO, "Failed to register %s adapter ring
> buffers", device_guid);
> +            CloseHandle(tt->hand);
> +            tt->hand = NULL;
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static void
>  tun_open_device(struct tuntap *tt, const char *dev_node, const char
> **device_guid)
>  {
>      struct gc_arena gc = gc_new();
> -    char *path = NULL;
>      char tuntap_device_path[256];
>      const struct tap_reg* tap_reg = get_tap_reg(&gc);
>      const struct panel_reg* panel_reg = get_panel_reg(&gc);
> @@ -6197,27 +6258,11 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>
>              if (tt->wintun)
>              {
> -                const struct device_instance_id_interface* dev_if;
> -
>                  if (!is_picked_device_wintun)
>                  {
>                      /* wintun driver specified but picked adapter is not
> wintun, proceed to next one */
>                      goto next;
>                  }
> -
> -                path = NULL;
> -                for (dev_if = device_instance_id_interface; dev_if !=
> NULL; dev_if = dev_if->next)
> -                {
> -                    if (strcmp(dev_if->net_cfg_instance_id, *device_guid)
> == 0)
> -                    {
> -                        path = (char*)dev_if->device_interface_list;
> -                        break;
> -                    }
> -                }
> -                if (path == NULL)
> -                {
> -                    goto next;
> -                }
>              }
>              else
>              {
> @@ -6226,28 +6271,9 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>                      /* tap-windows6 driver specified but picked adapter
> is wintun, proceed to next one */
>                      goto next;
>                  }
> -
> -                /* Open Windows TAP-Windows adapter */
> -                openvpn_snprintf(tuntap_device_path,
> sizeof(tuntap_device_path), "%s%s%s",
> -                                 USERMODEDEVICEDIR,
> -                                 *device_guid,
> -                                 TAP_WIN_SUFFIX);
> -                path = tuntap_device_path;
>              }
>
> -            tt->hand = CreateFile(path,
> -                                  GENERIC_READ | GENERIC_WRITE,
> -                                  0,                /* was:
> FILE_SHARE_READ */
> -                                  0,
> -                                  OPEN_EXISTING,
> -                                  FILE_ATTRIBUTE_SYSTEM |
> FILE_FLAG_OVERLAPPED,
> -                                  0);
> -
> -            if (tt->hand == INVALID_HANDLE_VALUE)
> -            {
> -                msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s",
> tt->wintun ? "wintun" : "TAP", tuntap_device_path);
> -            }
> -            else
> +            if (tun_try_open_device(tt, *device_guid,
> device_instance_id_interface))
>              {
>                  break;
>              }
> @@ -6261,7 +6287,7 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>       * GUID using the registry */
>      tt->actual_name = string_alloc(actual_buffer, NULL);
>
> -    msg(M_INFO, "%s device [%s] opened: %s", tt->wintun ? "Wintun" :
> "TAP-WIN32", tt->actual_name, path);
> +    msg(M_INFO, "%s device [%s] opened", tt->wintun ? "Wintun" :
> "TAP-WIN32", tt->actual_name);
>      tt->adapter_index = get_adapter_index(*device_guid);
>
>      gc_free(&gc);
> @@ -6372,14 +6398,7 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>
>      tun_open_device(tt, dev_node, &device_guid);
>
> -    if (tt->wintun)
> -    {
> -        if (!wintun_register_ring_buffer(tt))
> -        {
> -            msg(M_FATAL, "Failed to register ring buffers");
> -        }
> -    }
> -    else
> +    if (!tt->wintun)
>      {
>          tuntap_post_open(tt, device_guid);
>      }
> --
> 2.24.1.windows.2
>
> Argh, I had --windows-driver accidentially left on TAP-Windows6 when
> testing v2 patchset. :(
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000bdec35059a28564d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Compiled, tested.<div><br></div><div>Acked-by: Lev Stipako=
v &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;</d=
iv><div><br></div><div>PS</div><div><br></div><div>When you send v2 etc, co=
uld=C2=A0you add changelog to git mail after &quot;---&quot; line.</div><di=
v><br></div><div>See=C2=A0<a href=3D"https://patchwork.openvpn.net/patch/38=
8/">https://patchwork.openvpn.net/patch/388/</a>=C2=A0as an example:</div><=
div><br></div><div>=C2=A0 =C2=A0 Signed-off-by: Antonio Quartulli &lt;<a hr=
ef=3D"mailto:antonio@...515...">antonio@...515...</a>&gt;<br>=C2=A0 =C2=A0 =
---<br><br>=C2=A0 =C2=A0 Changes from v2:<br>=C2=A0 =C2=A0 - patchset rebas=
ed on top of pre-ipv6-only patchset<br>=C2=A0 =C2=A0 - change commit subjec=
t/message<br>=C2=A0 =C2=A0 - move ifconfig-ipv6-pool check change into 4/8<=
br><br>=C2=A0 =C2=A0 src/openvpn/helper.c | 8 ++++++--<br>=C2=A0 =C2=A0 1 f=
ile changed, 6 insertions(+), 2 deletions(-)<br><br>=C2=A0 =C2=A0 diff --gi=
t a/src/openvpn/helper.c b/src/openvpn/helper.c<br></div><div>=C2=A0</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">p=
e 20. jouluk. 2019 klo 21.39 Simon Rozman (<a href=3D"mailto:simon@...2537...=
..">simon@...2293...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Wintun adapters may be considered available if ring bu=
ffer registration<br>
succeeded. Therefore, we must attempt to register ring buffers when<br>
iterating adapters and continue on failure.<br>
<br>
Signed-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=
=3D"_blank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 111 +++++++++++++++++++++++++++------------------=
-<br>
=C2=A01 file changed, 65 insertions(+), 46 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index c6bbbd41..aef2c7f8 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6129,11 +6129,72 @@ tuntap_dhcp_mask(const struct tuntap *tt, const cha=
r *device_guid)<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
=C2=A0}<br>
<br>
+static bool<br>
+tun_try_open_device(struct tuntap *tt, const char *device_guid, const stru=
ct device_instance_id_interface *device_instance_id_interface)<br>
+{<br>
+=C2=A0 =C2=A0 const char *path =3D NULL;<br>
+=C2=A0 =C2=A0 char tuntap_device_path[256];<br>
+<br>
+=C2=A0 =C2=A0 if (tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct device_instance_id_interface *dev=
_if;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open Wintun adapter */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (dev_if =3D device_instance_id_interface; =
dev_if !=3D NULL; dev_if =3D dev_if-&gt;next)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(dev_if-&gt;net_cfg_in=
stance_id, device_guid) =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D dev_if-&g=
t;device_interface_list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (path =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open TAP-Windows adapter */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(tuntap_device_path, sizeof(tu=
ntap_device_path), &quot;%s%s%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 USERMODEDEVICEDIR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TAP_WIN_SUFFIX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D tuntap_device_path;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GENER=
IC_READ | GENERIC_WRITE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHARE_REA=
D */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPEN_=
EXISTING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_=
ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<b=
r>
+=C2=A0 =C2=A0 if (tt-&gt;hand =3D=3D INVALID_HANDLE_VALUE)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TUNTAP_INFO, &quot;CreateFile failed on =
%s device: %s&quot;, tt-&gt;wintun ? &quot;Wintun&quot; : &quot;TAP-Windows=
&quot;, path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Wintun adapter may be considered &quot;open=
&quot; after ring buffers are successfuly registered. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wintun_register_ring_buffer(tt))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TUNTAP_INFO, &quot;Failed =
to register %s adapter ring buffers&quot;, device_guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(tt-&gt;hand);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0static void<br>
=C2=A0tun_open_device(struct tuntap *tt, const char *dev_node, const char *=
*device_guid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 char *path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char tuntap_device_path[256];<br>
=C2=A0 =C2=A0 =C2=A0const struct tap_reg* tap_reg =3D get_tap_reg(&amp;gc);=
<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg* panel_reg =3D get_panel_reg(&am=
p;gc);<br>
@@ -6197,27 +6258,11 @@ tun_open_device(struct tuntap *tt, const char *dev_=
node, const char **device_gui<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;wintun)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct devic=
e_instance_id_interface* dev_if;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_picke=
d_device_wintun)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* wintun driver specified but picked adapter is not wintun, proceed to =
next one */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto next;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (dev_if =3D de=
vice_instance_id_interface; dev_if !=3D NULL; dev_if =3D dev_if-&gt;next)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
strcmp(dev_if-&gt;net_cfg_instance_id, *device_guid) =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 path =3D (char*)dev_if-&gt;device_interface_list;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (path =3D=3D NU=
LL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto=
 next;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -6226,28 +6271,9 @@ tun_open_device(struct tuntap *tt, const char *dev_n=
ode, const char **device_gui<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* tap-windows6 driver specified but picked adapter is wintun, proceed t=
o next one */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto next;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open Windows TA=
P-Windows adapter */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(t=
untap_device_path, sizeof(tuntap_device_path), &quot;%s%s%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODEDEVICEDIR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*device_guid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WIN_SUFFIX);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D tuntap_de=
vice_path;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(path,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENERIC_READ | GENERIC_WRITE,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHARE_READ */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPEN_EXISTING,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUTE_SYSTEM | FILE_=
FLAG_OVERLAPPED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;hand =3D=3D INVALID_H=
ANDLE_VALUE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TUNTAP_INFO,=
 &quot;CreateFile failed on %s device: %s&quot;, tt-&gt;wintun ? &quot;wint=
un&quot; : &quot;TAP&quot;, tuntap_device_path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tun_try_open_device(tt, *dev=
ice_guid, device_instance_id_interface))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -6261,7 +6287,7 @@ tun_open_device(struct tuntap *tt, const char *dev_no=
de, const char **device_gui<br>
=C2=A0 =C2=A0 =C2=A0 * GUID using the registry */<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;actual_name =3D string_alloc(actual_buffer, NULL=
);<br>
<br>
-=C2=A0 =C2=A0 msg(M_INFO, &quot;%s device [%s] opened: %s&quot;, tt-&gt;wi=
ntun ? &quot;Wintun&quot; : &quot;TAP-WIN32&quot;, tt-&gt;actual_name, path=
);<br>
+=C2=A0 =C2=A0 msg(M_INFO, &quot;%s device [%s] opened&quot;, tt-&gt;wintun=
 ? &quot;Wintun&quot; : &quot;TAP-WIN32&quot;, tt-&gt;actual_name);<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;adapter_index =3D get_adapter_index(*device_guid=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
@@ -6372,14 +6398,7 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun<br>
<br>
=C2=A0 =C2=A0 =C2=A0tun_open_device(tt, dev_node, &amp;device_guid);<br>
<br>
-=C2=A0 =C2=A0 if (tt-&gt;wintun)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wintun_register_ring_buffer(tt))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Failed to reg=
ister ring buffers&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tuntap_post_open(tt, device_guid);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.24.1.windows.2<br>
<br>
Argh, I had --windows-driver accidentially left on TAP-Windows6 when testin=
g v2 patchset. :(<br>
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

--000000000000bdec35059a28564d--

