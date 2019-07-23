MIME-Version: 1.0
References: <1563369608-10240-1-git-send-email-lstipakov@...277...>
 <1563450113-11225-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1563450113-11225-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Jul 2019 22:22:34 -0400
Message-ID: <CAKuzo_jTwnNZ_5QtFo8YqUyWWhEJWBCYgnO_xAqEaNkumGPgrw@...278...>
Content-Type: multipart/alternative; boundary="0000000000008b638a058e4fdee2"
Subject: Re: [Openvpn-devel] [PATCH v5] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000008b638a058e4fdee2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jul 18, 2019 at 7:42 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> This patch enables interactive service to open tun device.
> This is mostly needed by Wintun, which could be opened
> only by privileged process.
>
> When interactive service is used, instead of calling
> CreateFile() directly by openvpn process we pass tun device path
> into service process. There we open device, duplicate handle
> and pass it back to openvpn process.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v5:
>   - futher strengthen security by passing only device guid from client
> process
>

"further"


>   to service, validating guid and contructing device path on service side
>

"constructing"


>
>  v4:
>   - strengthen security by adding basic validation to device path
>   - reorder fields in msg_open_tun_device_result for backward compatibility
>
>  v3:
>   - ensure that device path passed by client is null-terminated
>   - support for multiple openvpn processes
>   - return proper error code when device handle is invalid
>
>  v2:
>   - introduce send_msg_iservice_ex() instead of changing
>   signature of existing send_msg_iservice()
>   - use wchar_t strings in interactive service code
>
>  include/openvpn-msg.h         | 12 +++++++
>  src/openvpn/tun.c             | 83
> ++++++++++++++++++++++++++++++++++---------
>  src/openvpn/win32.c           |  9 ++++-
>  src/openvpn/win32.h           | 30 +++++++++++++---
>  src/openvpnserv/interactive.c | 83
> +++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 193 insertions(+), 24 deletions(-)



diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 4814bbc..8ccddc0 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -309,14 +309,36 @@ int win32_version_info(void);
>   */
>  const char *win32_version_string(struct gc_arena *gc, bool add_name);
>
> -/*
> - * Send the |size| bytes in buffer |data| to the interactive service
> |pipe|
> - * and read the result in |ack|. Returns false on communication error.
> - * The string in |context| is used to prefix error messages.
> +
> +/**
> + * Send data to interactive service and receive response of type
> ack_message_t.
> + *
> + * @param  pipe      The handle of communication pipe
> + * @param  data      The data to send
> + * @param  size      The size of data to send
> + * @param  response  The pointer to ack_message_t structure to where
> response is written
>

That would be "@param ack"


> + * @param  context   The string used to prefix error messages
> + *
> + * @returns True on success, false on failure.
>   */
>  bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
>                         ack_message_t *ack, const char *context);
>
>


>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 623c3ff..782c04d 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -58,7 +58,6 @@ static settings_t settings;
>  static HANDLE rdns_semaphore = NULL;
>  #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
>
> -
>  openvpn_service_t interactive_service = {
>      interactive,
>      TEXT(PACKAGE_NAME "ServiceInteractive"),
> @@ -1198,8 +1197,67 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t
> *dhcp)
>      return err;
>  }
>
> +static DWORD
> +HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun,
> HANDLE ovpn_proc, HANDLE *remote_handle)
> +{
> +    DWORD err = ERROR_SUCCESS;
> +    HANDLE local_handle;
> +    LPWSTR wguid = NULL;
> +    WCHAR device_path[256] = {0};
> +    const WCHAR prefix[] = L"\\\\.\\Global\\";
> +    const WCHAR tap_suffix[] = L".tap";
> +
> +    *remote_handle = INVALID_HANDLE_VALUE;
> +
> +    wguid = utf8to16(open_tun->device_guid);
> +    if (!wguid)
> +    {
> +        err = ERROR_OUTOFMEMORY;
> +        goto out;
> +    }
> +
> +    /* validate device guid */
> +    const size_t guid_len = wcslen(wguid);
> +    for (int i = 0; i < guid_len; ++i)
> +    {
> +        const WCHAR ch = wguid[i];
> +
> +        if (!(iswalnum(ch)) && (ch != L'-') && (ch != L'{') && (ch !=
> L'}'))
> +        {
> +            err = ERROR_MESSAGE_DATA;
> +            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Invalid device guild
> (%s)"), wguid);
> +            goto out;
> +        }
> +    }
>

I think the check could be made tighter than alpha numerics (only hex
digits need be allowed) and simpler like:

if (guid_len != 38 || wcspn(wguid, L"0123456789ABCDEFabcdef-{}") !=
guid_len)
{
    <handle the error and goto out>
}

I would have preferred to do a GUID parsing to validate it, but may be this
is good enough?

+
> +    openvpn_swprintf(device_path, sizeof(device_path), L"%s%s%s", prefix,
> wguid, tap_suffix);
> +
> +    /* open tun device */
> +
>

...

Thanks,

Selva

--0000000000008b638a058e4fdee2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div><br></div><div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 18, 2019=
 at 7:42 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=
=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:l=
ev@...515..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
This patch enables interactive service to open tun device.<br>
This is mostly needed by Wintun, which could be opened<br>
only by privileged process.<br>
<br>
When interactive service is used, instead of calling<br>
CreateFile() directly by openvpn process we pass tun device path<br>
into service process. There we open device, duplicate handle<br>
and pass it back to openvpn process.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v5:<br>
=C2=A0 - futher strengthen security by passing only device guid from client=
 process<br></blockquote><div><br></div><div>&quot;further&quot;</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 to service, validating guid and contructing device path on service s=
ide <br></blockquote><div><br></div><div>&quot;constructing&quot;</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0v4:<br>
=C2=A0 - strengthen security by adding basic validation to device path<br>
=C2=A0 - reorder fields in msg_open_tun_device_result for backward compatib=
ility<br>
<br>
=C2=A0v3:<br>
=C2=A0 - ensure that device path passed by client is null-terminated<br>
=C2=A0 - support for multiple openvpn processes<br>
=C2=A0 - return proper error code when device handle is invalid<br>
<br>
=C2=A0v2:<br>
=C2=A0 - introduce send_msg_iservice_ex() instead of changing<br>
=C2=A0 signature of existing send_msg_iservice()<br>
=C2=A0 - use wchar_t strings in interactive service code<br>
<br>
=C2=A0include/openvpn-msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++++++<b=
r>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 83=
 ++++++++++++++++++++++++++++++++++---------<br>
=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9=
 ++++-<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++=
+++++++++---<br>
=C2=A0src/openvpnserv/interactive.c | 83 ++++++++++++++++++++++++++++++++++=
+++++++--<br>
=C2=A05 files changed, 193 insertions(+), 24 deletions(-)</blockquote><div>=
=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
index 4814bbc..8ccddc0 100644<br>
--- a/src/openvpn/win32.h<br>
+++ b/src/openvpn/win32.h<br>
@@ -309,14 +309,36 @@ int win32_version_info(void);<br>
=C2=A0 */<br>
=C2=A0const char *win32_version_string(struct gc_arena *gc, bool add_name);=
<br>
<br>
-/*<br>
- * Send the |size| bytes in buffer |data| to the interactive service |pipe=
|<br>
- * and read the result in |ack|. Returns false on communication error.<br>
- * The string in |context| is used to prefix error messages.<br>
+<br>
+/**<br>
+ * Send data to interactive service and receive response of type ack_messa=
ge_t.<br>
+ *<br>
+ * @param=C2=A0 pipe=C2=A0 =C2=A0 =C2=A0 The handle of communication pipe<=
br>
+ * @param=C2=A0 data=C2=A0 =C2=A0 =C2=A0 The data to send<br>
+ * @param=C2=A0 size=C2=A0 =C2=A0 =C2=A0 The size of data to send<br>
+ * @param=C2=A0 response=C2=A0 The pointer to ack_message_t structure to w=
here response is written<br></blockquote><div><br></div><div>That would be =
&quot;@param ack&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+ * @param=C2=A0 context=C2=A0 =C2=A0The string used to prefix error messag=
es<br>
+ *<br>
+ * @returns True on success, false on failure.<br>
=C2=A0 */<br>
=C2=A0bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ack_message_t *ack, const char *context);<br>
<br></blockquote><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 623c3ff..782c04d 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -58,7 +58,6 @@ static settings_t settings;<br>
=C2=A0static HANDLE rdns_semaphore =3D NULL;<br>
=C2=A0#define RDNS_TIMEOUT 600=C2=A0 /* seconds to wait for the semaphore *=
/<br>
<br>
-<br>
=C2=A0openvpn_service_t interactive_service =3D {<br>
=C2=A0 =C2=A0 =C2=A0interactive,<br>
=C2=A0 =C2=A0 =C2=A0TEXT(PACKAGE_NAME &quot;ServiceInteractive&quot;),<br>
@@ -1198,8 +1197,67 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t =
*dhcp)<br>
=C2=A0 =C2=A0 =C2=A0return err;<br>
=C2=A0}<br>
<br>
+static DWORD<br>
+HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun, HAND=
LE ovpn_proc, HANDLE *remote_handle)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD err =3D ERROR_SUCCESS;<br>
+=C2=A0 =C2=A0 HANDLE local_handle;<br>
+=C2=A0 =C2=A0 LPWSTR wguid =3D NULL;<br>
+=C2=A0 =C2=A0 WCHAR device_path[256] =3D {0};<br>
+=C2=A0 =C2=A0 const WCHAR prefix[] =3D L&quot;\\\\.\\Global\\&quot;;<br>
+=C2=A0 =C2=A0 const WCHAR tap_suffix[] =3D L&quot;.tap&quot;;<br>
+<br>
+=C2=A0 =C2=A0 *remote_handle =3D INVALID_HANDLE_VALUE;<br>
+<br>
+=C2=A0 =C2=A0 wguid =3D utf8to16(open_tun-&gt;device_guid);<br>
+=C2=A0 =C2=A0 if (!wguid)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ERROR_OUTOFMEMORY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* validate device guid */<br>
+=C2=A0 =C2=A0 const size_t guid_len =3D wcslen(wguid);<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; guid_len; ++i)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const WCHAR ch =3D wguid[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(iswalnum(ch)) &amp;&amp; (ch !=3D L&#39;=
-&#39;) &amp;&amp; (ch !=3D L&#39;{&#39;) &amp;&amp; (ch !=3D L&#39;}&#39;)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ERROR_MESSAGE_DATA;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(MSG_FLAGS_ERROR, T=
EXT(&quot;Invalid device guild (%s)&quot;), wguid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>I think the check coul=
d be made tighter than alpha numerics (only hex digits need be allowed) and=
 simpler like:</div><div><br></div><div>if (guid_len !=3D 38 || wcspn(wguid=
, L&quot;0123456789ABCDEFabcdef-{}&quot;) !=3D guid_len)</div><div>{</div><=
div>=C2=A0 =C2=A0 &lt;handle the error and goto out&gt;</div><div>}=C2=A0</=
div><div><br></div><div>I would have preferred to do a GUID parsing to vali=
date it, but may be this is good enough?</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 openvpn_swprintf(device_path, sizeof(device_path), L&quot;%s=
%s%s&quot;, prefix, wguid, tap_suffix);<br>
+<br>
+=C2=A0 =C2=A0 /* open tun device */<br>
+=C2=A0 =C2=A0<br></blockquote><div><br></div><div>...</div><div><br></div>=
<div>Thanks,</div><div><br></div><div>Selva</div></div></div></div>

--0000000000008b638a058e4fdee2--

