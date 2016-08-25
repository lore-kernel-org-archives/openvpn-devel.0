MIME-Version: 1.0
In-Reply-To: <1472146337-9430-1-git-send-email-davids@...515...>
References: <1472146337-9430-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Aug 2016 14:40:15 -0400
Message-ID: <CAKuzo_hQEBDVC_RUGBGrKv2YoBTD0E2jHqiihfK22-Q7qdA6kA@...278...>
Content-Type: multipart/alternative; boundary=001a114eafecc72662053ae9bb17
Subject: Re: [Openvpn-devel] [PATCH] Document the --auth-token option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114eafecc72662053ae9bb17
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for documenting this.

On Thu, Aug 25, 2016 at 1:32 PM, David Sommerseth <davids@...515...>
wrote:

>  .\"*********************************************************
>  .TP
> +.B \-\-auth\-token token
> +This is not an option to be used directly in any configuration files,
> +but rather push this option from a
> +.B \-\-client\-connect
> +script or a
> +.B \-\-plugin
> +which hooks into the OPENVPN_PLUGIN_CLIENT_CONNECT or
> +OPENVPN_PLUGIN_CLIENT_CONNECT_V2 calls.  This option provides
> +a possibility to replace the clients password with a temporary
> +authentication token.
> +
> +Whenever the connection is renegotiated and the
> +\-\-auth\-user\-pass\-verify
>

To be consistent, that would be ".B  \-\-auth\-user\-pass\-verify"

+script or
> +\-\-plugin
>

same here and a couple of instances below.


> +making use of the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook is
> +triggered, it will then pass over this token as the password
> +instead of the password the user provided.
>

Based on some quick checks it seems the token is passed as password not
just during reneg or after a SIGUSR1 but even after a SIGHUP. It would be
useful to clarify if/when the token gets cleared so that username/password
prompt will happen again at client-side. It also helps a script/plugin
developer to know when to reset the token and expect the usual password.

+
> +The purpose of this is to enable two factor authentication
> +methods, such as HOTP or TOTP, to be used without needing to
> +retrieve a new OTP code each time the connection is renegotiated.
> +Another use case is to cache authentication data on the client
> +without needing to have the users password cached in memory
> +during the life time of the session.
> +
> +To make use of this feature, the
> +\-\-client\-connect
>

.B ...


> +script or
> +\-\-plugin
>

.B ...


> +needs to put
> +
> +.nf
> +.ft 3
> +.in +4
> +push "auth-token UNIQUE_TOKEN_VALUE"
> +.in -4
> +.ft
> +.fi
> +
> +into the file/buffer for dynamic configuration data.  This
> +will then make the OpenVPN server to push this value to the
> +client, which replaces the local password with the
> +UNIQUE_TOKEN_VALUE.
> +.\"*********************************************************
> +.TP
>  .B \-\-tls\-verify cmd
>  Run command
>  .B cmd


Selva

--001a114eafecc72662053ae9bb17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Thanks for documenting this.</div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Aug 25, =
2016 at 1:32 PM, David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:d=
avids@...515..." target=3D"_blank">davids@...515...</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid=
;padding-left:1ex"><div>=C2=A0.\&quot;**************************<wbr>******=
************************<wbr>*<br>
=C2=A0.TP<br>
+.B \-\-auth\-token token<br>
+This is not an option to be used directly in any configuration files,<br>
+but rather push this option from a<br>
+.B \-\-client\-connect<br>
+script or a<br>
+.B \-\-plugin<br>
+which hooks into the OPENVPN_PLUGIN_CLIENT_CONNECT or<br>
+OPENVPN_PLUGIN_CLIENT_CONNECT<wbr>_V2 calls.=C2=A0 This option provides<br>
+a possibility to replace the clients password with a temporary<br>
+authentication token.<br>
+<br>
+Whenever the connection is renegotiated and the<br>
+\-\-auth\-user\-pass\-verify<br></div></blockquote><div><br></div><div>To =
be consistent, that would be &quot;.B =C2=A0\-\-auth\-user\-pass\-verify&qu=
ot;</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);b=
order-left-style:solid;padding-left:1ex"><div>
+script or<br>
+\-\-plugin<br></div></blockquote><div><br></div><div>same here and a coupl=
e of instances below.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-colo=
r:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>
+making use of the OPENVPN_PLUGIN_AUTH_USER_PASS_<wbr>VERIFY hook is<br>
+triggered, it will then pass over this token as the password<br>
+instead of the password the user provided.</div></blockquote></div><br>Bas=
ed on some quick checks it seems the token is passed as password not just d=
uring reneg or after a SIGUSR1 but even after a SIGHUP. It would be useful =
to clarify if/when the token gets cleared so that username/password prompt =
will happen again at client-side. It also helps a script/plugin developer t=
o know when to reset the token and expect the usual password.</div><div cla=
ss=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
+<br>+The purpose of this is to enable two factor authentication<br>+method=
s, such as HOTP or TOTP, to be used without needing to<br>+retrieve a new O=
TP code each time the connection is renegotiated.<br>+Another use case is t=
o cache authentication data on the client<br>+without needing to have the u=
sers password cached in memory<br>+during the life time of the session.<br>=
+<br>+To make use of this feature, the<br>+\-\-client\-connect<br></blockqu=
ote><div><br></div><div>.B ...</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">+scri=
pt or<br>+\-\-plugin<br></blockquote><div><br></div><div>.B ...</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">+needs to put<br>+<br>+.nf<br>+.ft 3<br>+.in +=
4<br>+push &quot;auth-token UNIQUE_TOKEN_VALUE&quot;<br>+.in -4<br>+.ft<br>=
+.fi<br>+<br>+into the file/buffer for dynamic configuration data.=C2=A0 Th=
is<br>+will then make the OpenVPN server to push this value to the<br>+clie=
nt, which replaces the local password with the<br>+UNIQUE_TOKEN_VALUE.<br>+=
.\&quot;*********************************************************<br>+.TP<b=
r>=C2=A0.B \-\-tls\-verify cmd<br>=C2=A0Run command<br>=C2=A0.B cmd</blockq=
uote></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Selva</div></div>

--001a114eafecc72662053ae9bb17--

