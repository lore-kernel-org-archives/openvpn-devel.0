MIME-Version: 1.0
References: <20210716121848.67888-1-arne@...1227...>
 <20210813115542.2794-1-arne@...1227...>
In-Reply-To: <20210813115542.2794-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Aug 2021 12:48:13 -0400
Message-ID: <CAKuzo_jBQvOrZ66_tWBsJOzUCGO7RkP2Y2rmSDW1kdHR6dN-PA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d78d5005c973a6cf"
Subject: Re: [Openvpn-devel] [PATCH v3] Introduce webauth auth pending
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

--000000000000d78d5005c973a6cf
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Aug 13, 2021 at 7:56 AM Arne Schwabe <arne@...1227...> wrote:

> The experience with openurl/OPEN_URL has shown that just sending
> a URL to a client is not enough and we often need different
> behaviour of the client depending on circumstances. Replace
> OPEN_URL with a more flexible WEB_AUTH pending auth method.
>
> Patch v2: use WEB_AUTH instead WEBAUTH
> Patch v3: incooperate other comments from Selva
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt    | 45 +++++++++++++++++++++++++------------
>  include/openvpn-plugin.h.in |  2 +-
>  2 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index c20344298..1cafb8a8e 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -645,11 +645,11 @@ Before issuing a client-pending-auth to a client
> instead of a
>  client-auth/client-deny, the server should check the IV_SSO
>  environment variable for whether the method is supported. Currently
>  defined methods are crtext for challenge/response using text
> -(e.g., TOTP), openurl and proxy_url for opening a URL in the client to
> -continue authentication. A client supporting the first two methods would
> -set
> +(e.g., TOTP), openurl (deprecated) and webauth for opening a URL in
> +the client to continue authentication. A client supporting webauth and
> +crtext would set
>
> -    setenv IV_SSO openurl,crtext
> +    setenv IV_SSO webauth,crtext
>
>  The variable name IV_SSO is historic as AUTH_PENDING was first used
>  to signal single sign on support. To keep compatibility with existing
> @@ -668,33 +668,50 @@ notification as
>  where {EXTRA} is formatted as received from the server.
>  Currently defined formats for {EXTRA} are detailed below.
>
> -openurl
> -========
> +webauth and openurl
> +===================
>  For a web based extra authentication (like for
>  SSO/SAML) {EXTRA} should be
>
>      OPEN_URL:url
>
> -and client should ask the user to open the URL to continue.
> +or
> +
> +    WEB_AUTH:flags:url
> +
> +The OPEN_URL method is deprecated as it does not allow to send flags which
> +proved to be needed to signal certain behaviour to the client.
> +
> +The client should ask the user to open the URL to continue.
>
>  The space in a control message is limited, so this url should be kept
>  short to avoid issues. If a longer url is required a URL that redirects
> -to the longer URL should be sent instead.
> +to the longer URL should be sent instead. The total length is limited to
> 1024
> +bytes which includes the INFO_PRE:WEB_AUTH:flags.
> +
> +flags is a list of flags which are separated by commas. Currently defined
> +flags are:
> +
> +- proxy     (see next pargraph)
> +- hidden    start the webview in hidden mode (see openvpn3 webauth
> documentation)
> +- external  Do not use an internal webview but use an external browser.
> Some
> +            authentication providers refuse to work in an internal
> webview.
> +
>
>  A complete documentation how URLs should be handled on the client is
> available
>  in the openvpn3 repository:
>
>  https://github.com/OpenVPN/openvpn3/blob/master/doc/webauth.md
>
> -proxy_url
> -========
> -This is a variant of openurl that allows opening a url via an
> +webauth with proxy
> +==================
> +This is a variant of webauth that allows opening a url via an
>  HTTP proxy. It could be used to avoid issues with OpenVPN connection's
>  persist-tun that may cause the web server to be unreachable.
> -The client should announce proxy_url in its IV_SSO and parse the
> -PROXY_URL message. The format of {EXTRA} in this case is
> +The client should announce proxy in its IV_SSO and parse the
> +proxy flag in the WEB_AUTH message. The format of {EXTRA} in this case is
>
> -
> PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_base64>:url
> +
> WEB_AUTH:proxy=<proxy>;<proxy_port>;<proxy_user_base64>;<proxy_password_base64>,flags:url
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
>

Acked-by: <selva.nair@...277...>

--000000000000d78d5005c973a6cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Aug 13, 2021 at 7:56 AM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">The experience with openur=
l/OPEN_URL has shown that just sending<br>
a URL to a client is not enough and we often need different<br>
behaviour of the client depending on circumstances. Replace<br>
OPEN_URL with a more flexible WEB_AUTH pending auth method.<br>
<br>
Patch v2: use WEB_AUTH instead WEBAUTH<br>
Patch v3: incooperate other comments from Selva<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0doc/management-notes.txt=C2=A0 =C2=A0 | 45 +++++++++++++++++++++++++-=
-----------<br>
=C2=A0include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a> |=C2=A0 2 +-<br>
=C2=A02 files changed, 32 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/doc/management-notes.txt b/doc/management-notes.txt<br>
index c20344298..1cafb8a8e 100644<br>
--- a/doc/management-notes.txt<br>
+++ b/doc/management-notes.txt<br>
@@ -645,11 +645,11 @@ Before issuing a client-pending-auth to a client inst=
ead of a<br>
=C2=A0client-auth/client-deny, the server should check the IV_SSO<br>
=C2=A0environment variable for whether the method is supported. Currently<b=
r>
=C2=A0defined methods are crtext for challenge/response using text<br>
-(e.g., TOTP), openurl and proxy_url for opening a URL in the client to<br>
-continue authentication. A client supporting the first two methods would<b=
r>
-set<br>
+(e.g., TOTP), openurl (deprecated) and webauth for opening a URL in<br>
+the client to continue authentication. A client supporting webauth and<br>
+crtext would set<br>
<br>
-=C2=A0 =C2=A0 setenv IV_SSO openurl,crtext<br>
+=C2=A0 =C2=A0 setenv IV_SSO webauth,crtext<br>
<br>
=C2=A0The variable name IV_SSO is historic as AUTH_PENDING was first used<b=
r>
=C2=A0to signal single sign on support. To keep compatibility with existing=
<br>
@@ -668,33 +668,50 @@ notification as<br>
=C2=A0where {EXTRA} is formatted as received from the server.<br>
=C2=A0Currently defined formats for {EXTRA} are detailed below.<br>
<br>
-openurl<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
+webauth and openurl<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=C2=A0For a web based extra authentication (like for<br>
=C2=A0SSO/SAML) {EXTRA} should be<br>
<br>
=C2=A0 =C2=A0 =C2=A0OPEN_URL:url<br>
<br>
-and client should ask the user to open the URL to continue.<br>
+or<br>
+<br>
+=C2=A0 =C2=A0 WEB_AUTH:flags:url<br>
+<br>
+The OPEN_URL method is deprecated as it does not allow to send flags which=
<br>
+proved to be needed to signal certain behaviour to the client.<br>
+<br>
+The client should ask the user to open the URL to continue.<br>
<br>
=C2=A0The space in a control message is limited, so this url should be kept=
<br>
=C2=A0short to avoid issues. If a longer url is required a URL that redirec=
ts<br>
-to the longer URL should be sent instead.<br>
+to the longer URL should be sent instead. The total length is limited to 1=
024<br>
+bytes which includes the INFO_PRE:WEB_AUTH:flags.<br>
+<br>
+flags is a list of flags which are separated by commas. Currently defined<=
br>
+flags are:<br>
+<br>
+- proxy=C2=A0 =C2=A0 =C2=A0(see next pargraph)<br>
+- hidden=C2=A0 =C2=A0 start the webview in hidden mode (see openvpn3 webau=
th documentation)<br>
+- external=C2=A0 Do not use an internal webview but use an external browse=
r. Some<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 authentication providers refuse =
to work in an internal webview.<br>
+<br>
<br>
=C2=A0A complete documentation how URLs should be handled on the client is =
available<br>
=C2=A0in the openvpn3 repository:<br>
<br>
=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn3/blob/master/doc/webaut=
h.md" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openv=
pn3/blob/master/doc/webauth.md</a><br>
<br>
-proxy_url<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
-This is a variant of openurl that allows opening a url via an<br>
+webauth with proxy<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+This is a variant of webauth that allows opening a url via an<br>
=C2=A0HTTP proxy. It could be used to avoid issues with OpenVPN connection&=
#39;s<br>
=C2=A0persist-tun that may cause the web server to be unreachable.<br>
-The client should announce proxy_url in its IV_SSO and parse the<br>
-PROXY_URL message. The format of {EXTRA} in this case is<br>
+The client should announce proxy in its IV_SSO and parse the<br>
+proxy flag in the WEB_AUTH message. The format of {EXTRA} in this case is<=
br>
<br>
-=C2=A0 =C2=A0 PROXY_URL:&lt;proxy&gt;:&lt;proxy_port&gt;:&lt;proxyuser_bas=
e64&gt;:&lt;proxy_password_base64&gt;:url<br>
+=C2=A0 =C2=A0 WEB_AUTH:proxy=3D&lt;proxy&gt;;&lt;proxy_port&gt;;&lt;proxy_=
user_base64&gt;;&lt;proxy_password_base64&gt;,flags:url<br>
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
es to<br></blockquote><div><br></div><div>Acked-by: &lt;<a href=3D"mailto:s=
elva.nair@...277...">selva.nair@...277...</a>&gt;=C2=A0</div></div></div>

--000000000000d78d5005c973a6cf--

