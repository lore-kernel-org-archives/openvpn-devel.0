MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
In-Reply-To: <1573148729-27339-4-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Nov 2019 23:29:36 -0500
Message-ID: <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000f78fd20597ab83f5"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
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

--000000000000f78fd20597ab83f5
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Nov 7, 2019 at 12:49 PM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> To open wintun device, we cannot use "\\.\Global\Wintun<luid>"
> path as before. To get device path which we supply to CreateFile,
> we have to use SetupAPI to:
>
>  - enumerate network adapters with "wintun" as component id
>  - for each adapter save its guid
>  - open device information set
>  - for each item in set
>    - open corresponding registry key to get net_cfg_instance_id
>    - get symbolic link name of device interface by instance id
>  - path will be symbolic link name of device instance matched with
> adapter's guid
>
> See
> https://github.com/OpenVPN/openvpn3/blob/master/openvpn/tun/win/tunutil.hpp
> and
>
> https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/wintun_windows.go
> for
> implementation examples.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
>

This also has been ACKed and merged,  but two questions that may need some
attention:

@@ -5541,7 +5668,8 @@ void
>  open_tun(const char *dev, const char *dev_type, const char *dev_node,
> struct tuntap *tt)
>  {
>      struct gc_arena gc = gc_new();
> -    char device_path[256];
> +    char tuntap_device_path[256];
> +    char *path = NULL;
>      const char *device_guid = NULL;
>      DWORD len;
>      bool dhcp_masq = false;
> @@ -5571,6 +5699,8 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>      {
>          const struct tap_reg *tap_reg = get_tap_reg(&gc);
>          const struct panel_reg *panel_reg = get_panel_reg(&gc);
> +        const struct device_instance_id_interface
> *device_instance_id_interface = get_device_instance_id_interface(&gc);
> +
>          char actual_buffer[256];
>
>          at_least_one_tap_win(tap_reg);
> @@ -5586,24 +5716,22 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>              }
>
>              /* Open Windows TAP-Windows adapter */
> -            openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
> +            openvpn_snprintf(tuntap_device_path,
> sizeof(tuntap_device_path), "%s%s%s",
>                               USERMODEDEVICEDIR,
>                               device_guid,
>                               TAP_WIN_SUFFIX);
>
> -            tt->hand = CreateFile(
> -                device_path,
> -                GENERIC_READ | GENERIC_WRITE,
> -                0,                /* was: FILE_SHARE_READ */
> -                0,
> -                OPEN_EXISTING,
> -                FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> -                0
> -                );
> +            tt->hand = CreateFile(tuntap_device_path,
> +                                  GENERIC_READ | GENERIC_WRITE,
> +                                  0,                /* was:
> FILE_SHARE_READ */
> +                                  0,
> +                                  OPEN_EXISTING,
> +                                  FILE_ATTRIBUTE_SYSTEM |
> FILE_FLAG_OVERLAPPED,
> +                                  0);
>
>              if (tt->hand == INVALID_HANDLE_VALUE)
>              {
> -                msg(M_ERR, "CreateFile failed on TAP device: %s",
> device_path);
> +                msg(M_ERR, "CreateFile failed on TAP device: %s",
> tuntap_device_path);
>

Doesn't this mean that  if --dev-node is specified, we'll open  tapwindows
adapter
with that name even if "--window-driver wintun" is specified? The open may
succeed
but subsequent wintun-specific processing will fail.

             }
>          }
>          else
> @@ -5613,43 +5741,78 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>              /* Try opening all TAP devices until we find one available */
>              while (true)
>              {
> +                bool is_picked_device_wintun = false;
>                  device_guid = get_unspecified_device_guid(device_number,
>                                                            actual_buffer,
>
>  sizeof(actual_buffer),
>                                                            tap_reg,
>                                                            panel_reg,
> +
> &is_picked_device_wintun,
>                                                            &gc);
>
>                  if (!device_guid)
>                  {
> -                    msg(M_FATAL, "All TAP-Windows adapters on this system
> are currently in use.");
> +                    msg(M_FATAL, "All %s adapters on this system are
> currently in use.", tt->wintun ? "wintun" : "TAP - Windows");
>

If I'm not mistaken wintun device can be opened multiple times, so we'll
never get the
"All wintun adapters on this system...." error. Instead, open will succeed
here and
something else may fail later. FILE_SHARE_READ = 0 will not save us when
the driver
does not enforce it.

Selva

--000000000000f78fd20597ab83f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Nov 7, 2019 at 12:49 PM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">l=
ev@...515...</a>&gt;<br>
<br>
To open wintun device, we cannot use &quot;\\.\Global\Wintun&lt;luid&gt;&qu=
ot;<br>
path as before. To get device path which we supply to CreateFile,<br>
we have to use SetupAPI to:<br>
<br>
=C2=A0- enumerate network adapters with &quot;wintun&quot; as component id<=
br>
=C2=A0- for each adapter save its guid<br>
=C2=A0- open device information set<br>
=C2=A0- for each item in set<br>
=C2=A0 =C2=A0- open corresponding registry key to get net_cfg_instance_id<b=
r>
=C2=A0 =C2=A0- get symbolic link name of device interface by instance id<br>
=C2=A0- path will be symbolic link name of device instance matched with ada=
pter&#39;s guid<br>
<br>
See <a href=3D"https://github.com/OpenVPN/openvpn3/blob/master/openvpn/tun/=
win/tunutil.hpp" rel=3D"noreferrer" target=3D"_blank">https://github.com/Op=
enVPN/openvpn3/blob/master/openvpn/tun/win/tunutil.hpp</a> and<br>
<a href=3D"https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun=
/wintun_windows.go" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/WireGuard/wireguard-go/blob/master/tun/wintun/wintun_windows.go</a> for<br>
implementation examples.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br></blockquote><div><br></div><div>This also=
 has been ACKed and merged,=C2=A0 but two questions that may need some atte=
ntion:<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
@@ -5541,7 +5668,8 @@ void<br>
=C2=A0open_tun(const char *dev, const char *dev_type, const char *dev_node,=
 struct tuntap *tt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 char device_path[256];<br>
+=C2=A0 =C2=A0 char tuntap_device_path[256];<br>
+=C2=A0 =C2=A0 char *path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *device_guid =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool dhcp_masq =3D false;<br>
@@ -5571,6 +5699,8 @@ open_tun(const char *dev, const char *dev_type, const=
 char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct tap_reg *tap_reg =3D get_tap=
_reg(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get=
_panel_reg(&amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct device_instance_id_interface *dev=
ice_instance_id_interface =3D get_device_instance_id_interface(&amp;gc);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char actual_buffer[256];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at_least_one_tap_win(tap_reg);<br>
@@ -5586,24 +5716,22 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open Windows TAP-Windows=
 adapter */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(device_path, si=
zeof(device_path), &quot;%s%s%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(tuntap_device_p=
ath, sizeof(tuntap_device_path), &quot;%s%s%s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 USERMODEDEVICEDIR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TAP_WIN_SUFFIX);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_path,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENERIC_READ | GEN=
ERIC_WRITE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHARE_READ */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPEN_EXISTING,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUTE_SYS=
TEM | FILE_FLAG_OVERLAPPED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(tunta=
p_device_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENERIC_READ | GENERIC_WRITE,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHARE_READ */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPEN_EXISTING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUTE_SYSTEM | FILE_=
FLAG_OVERLAPPED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;hand =3D=3D INVA=
LID_HANDLE_VALUE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;C=
reateFile failed on TAP device: %s&quot;, device_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;C=
reateFile failed on TAP device: %s&quot;, tuntap_device_path);<br></blockqu=
ote><div><br></div><div>Doesn&#39;t this mean that=C2=A0 if --dev-node is s=
pecified, we&#39;ll open=C2=A0 tapwindows adapter</div><div>with that name =
even if &quot;--window-driver wintun&quot; is specified? The open may succe=
ed</div><div>but subsequent wintun-specific processing will fail.</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
@@ -5613,43 +5741,78 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Try opening all TAP devi=
ces until we find one available */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (true)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_picked_dev=
ice_wintun =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_guid =
=3D get_unspecified_device_guid(device_number,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actual_buffer=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(actual=
_buffer),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tap_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panel_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;is_picked_devi=
ce_wintun,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_g=
uid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_FATAL, &quot;All TAP-Windows adapters on this system are currently in use=
.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_FATAL, &quot;All %s adapters on this system are currently in use.&quot;, =
tt-&gt;wintun ? &quot;wintun&quot; : &quot;TAP - Windows&quot;);<br></block=
quote><div><br></div><div>If I&#39;m not mistaken wintun device can be open=
ed multiple times, so we&#39;ll never get the<br>&quot;All wintun adapters =
on this system....&quot; error. Instead, open will succeed here and=C2=A0</=
div><div>something else may fail later. FILE_SHARE_READ =3D 0 will not save=
 us when the driver</div><div>does not enforce it.</div><div><br></div><div=
>Selva</div></div></div>

--000000000000f78fd20597ab83f5--

