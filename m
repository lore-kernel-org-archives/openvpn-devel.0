MIME-Version: 1.0
References: <20210716121848.67888-1-arne@...1227...>
 <20210728124103.565145-1-arne@...1227...>
In-Reply-To: <20210728124103.565145-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 8 Aug 2021 19:50:14 -0400
Message-ID: <CAKuzo_hC7HybcSk7tzf=zT87oobAUmZ82gnJbifi2jZtsDaQ5Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000b4349a05c914f62e"
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce webauth auth pending
 method and deprecate openurl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b4349a05c914f62e
Content-Type: text/plain; charset="UTF-8"

Hi,

-proxy_url
> -========
> -This is a variant of openurl that allows opening a url via an
> +webauth with proxy
> +==================
> +This is a variant of webauth that allows opening a url via an
>  HTTP proxy. It could be used to avoid issues with OpenVPN connection's
>  persist-tun that may cause the web server to be unreachable.
>  The client should announce proxy_url in its IV_SSO and parse the
>  PROXY_URL message. The format of {EXTRA} in this case is
>

"PROXY_URL message"  above should be replaced by "proxy flag and related
flags in the message" (Gert has already pointed this out.)
But we keep the requirement that compliant clients should announce "proxy"
in IV_SSO, right? As the flag is called "proxy", I suggest we change that
IV_SSO value to "proxy" as well.

With "flags", WEBAUTH  is extensible and we have to decide which features
require an explicit announce from the client. As not every client may be
ready to support proxy, looks reasonable to require it in IV_SSO.

We may soon require a section titled IV_SSO and list all legal values in
there.

-
> PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_base64>:url
> +
> WEB_AUTH:proxy=<proxy>;<proxy_port>;<proxyuser_base64>;<proxy_password_base64>,flags:url
>

This may be an opportunity to change proxyuser_base64 to proxy_user_base64
as well. That would match proxy_password_base64 and proxy_port.


>
>  The proxy should be a literal IPv4 address or IPv6 address enclosed in []
> to avoid
>  ambiguity in parsing. A literal IP address is preferred as DNS might not
> be
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index abbfd9c2a..28b845af1 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -573,7 +573,7 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t
> OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
>   * auth_pending_file is
>   * line 1: timeout in seconds
>   * line 2: Pending auth method the client needs to support (e.g. openurl)
> - * line 3: EXTRA (e.g. OPEN_URL:http://www.example.com)
> + * line 3: EXTRA (e.g. WEBAUTH::http://www.example.com)
>   *
>   * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and
>   * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
> --


Looks good otherwise.

Selva

--000000000000b4349a05c914f62e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-proxy_url<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
-This is a variant of openurl that allows opening a url via an<br>
+webauth with proxy<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+This is a variant of webauth that allows opening a url via an<br>
=C2=A0HTTP proxy. It could be used to avoid issues with OpenVPN connection&=
#39;s<br>
=C2=A0persist-tun that may cause the web server to be unreachable.<br>
=C2=A0The client should announce proxy_url in its IV_SSO and parse the<br>
=C2=A0PROXY_URL message. The format of {EXTRA} in this case is<br></blockqu=
ote><div><br></div><div>&quot;PROXY_URL message&quot;=C2=A0 above should be=
 replaced by &quot;proxy flag and related flags in the message&quot; (Gert =
has already pointed this out.)</div><div>But we keep the requirement that c=
ompliant clients should announce &quot;proxy&quot; in IV_SSO, right? As the=
 flag is called &quot;proxy&quot;, I suggest we change that IV_SSO value to=
 &quot;proxy&quot; as well.</div><div><br></div><div>With &quot;flags&quot;=
, WEBAUTH=C2=A0 is extensible and we have to decide which features require =
an explicit announce from the client. As not every client may be ready to s=
upport proxy, looks reasonable to require it in IV_SSO.</div><div><br></div=
><div>We may soon require a section titled IV_SSO and list all legal values=
 in there.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
-=C2=A0 =C2=A0 PROXY_URL:&lt;proxy&gt;:&lt;proxy_port&gt;:&lt;proxyuser_bas=
e64&gt;:&lt;proxy_password_base64&gt;:url<br>
+=C2=A0 =C2=A0 WEB_AUTH:proxy=3D&lt;proxy&gt;;&lt;proxy_port&gt;;&lt;proxyu=
ser_base64&gt;;&lt;proxy_password_base64&gt;,flags:url<br></blockquote><div=
><br></div><div>This may be an opportunity to change proxyuser_base64 to pr=
oxy_user_base64 as well. That would match proxy_password_base64 and proxy_p=
ort.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
=C2=A0The proxy should be a literal IPv4 address or IPv6 address enclosed i=
n [] to avoid<br>
=C2=A0ambiguity in parsing. A literal IP address is preferred as DNS might =
not be<br>
diff --git a/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferr=
er" target=3D"_blank">openvpn-plugin.h.in</a> b/include/<a href=3D"http://o=
penvpn-plugin.h.in" rel=3D"noreferrer" target=3D"_blank">openvpn-plugin.h.i=
n</a><br>
index abbfd9c2a..28b845af1 100644<br>
--- a/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a><br>
+++ b/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a><br>
@@ -573,7 +573,7 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUG=
IN_FUNC(openvpn_plugin_op<br>
=C2=A0 * auth_pending_file is<br>
=C2=A0 * line 1: timeout in seconds<br>
=C2=A0 * line 2: Pending auth method the client needs to support (e.g. open=
url)<br>
- * line 3: EXTRA (e.g. OPEN_URL:<a href=3D"http://www.example.com" rel=3D"=
noreferrer" target=3D"_blank">http://www.example.com</a>)<br>
+ * line 3: EXTRA (e.g. WEBAUTH::<a href=3D"http://www.example.com" rel=3D"=
noreferrer" target=3D"_blank">http://www.example.com</a>)<br>
=C2=A0 *<br>
=C2=A0 * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and<br>
=C2=A0 * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tri=
es to<br>
--</blockquote><div><br></div><div>Looks good otherwise.</div><div><br></di=
v><div>Selva</div></div></div>

--000000000000b4349a05c914f62e--

