MIME-Version: 1.0
References: <20191001120652.31898-1-wardragon78@...277...>
In-Reply-To: <20191001120652.31898-1-wardragon78@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 1 Oct 2019 13:25:27 -0400
Message-ID: <CAKuzo_hp+TJ+YXCTsty+BjD-=H2TLHdSKQn7OqHO21aR3x4cwQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000084cfc30593dca4c5"
Subject: Re: [Openvpn-devel] [PATCH] Insert client connection data into PAM
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo Cerrito <wardragon78@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, paolo <paolo.cerrito@...2517...>

--00000000000084cfc30593dca4c5
Content-Type: text/plain; charset="UTF-8"

Hi,

Its useful to set PAM_RHOSTS which will allow use of
pam_access for access control etc. So feature ACK.

I would like to see a more precise commit message header like:
"Insert remote IP address into PAM environment"

On Tue, Oct 1, 2019 at 8:25 AM Paolo Cerrito <wardragon78@...277...> wrote:

> From: paolo <paolo.cerrito@...2517...>
>
> ---
>  src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c
> b/src/plugins/auth-pam/auth-pam.c
> index 88b53204..9d8dfb95 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -115,6 +115,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> +    char remote[128];
>
>      const struct name_value_list *name_value_list;
>  };
> @@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t
> handle, const int type, const cha
>          const char *username = get_env("username", envp);
>          const char *password = get_env("password", envp);
>          const char *common_name = get_env("common_name", envp) ?
> get_env("common_name", envp) : "";
> +        const char *remote = get_env("untrusted_ip", envp) ?
> get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);
>

Ensure that remote can't be NULL, like:

if (!remote)
{
    remote = "";
}

Though get_env() is unlikely to return NULL in this case,
safer not to rely on that and risk a NULL dereferencing later.


>          if (username && strlen(username) > 0 && password)
>          {
>              if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
>                  || send_string(context->foreground_fd, username) == -1
>                  || send_string(context->foreground_fd, password) == -1
> -                || send_string(context->foreground_fd, common_name) == -1)
> +                || send_string(context->foreground_fd, common_name) == -1
> +                || send_string(context->foreground_fd, remote) == -1)
>              {
>                  fprintf(stderr, "AUTH-PAM: Error sending auth info to
> background process\n");
>              }
> @@ -750,8 +753,16 @@ pam_auth(const char *service, const struct user_pass
> *up)
>      status = pam_start(service, name_value_list_provided ? NULL :
> up->username, &conv, &pamh);
>      if (status == PAM_SUCCESS)
>      {
> +        /* Set PAM_RHOST environment variable */
> +        if (*(up->remote))
> +        {
> +            status = pam_set_item(pamh, PAM_RHOST, up->remote);
> +        }
>          /* Call PAM to verify username/password */
> -        status = pam_authenticate(pamh, 0);
> +        if (status == PAM_SUCCESS)
> +        {
> +            status = pam_authenticate(pamh, 0);
> +        }
>          if (status == PAM_SUCCESS)
>          {
>              status = pam_acct_mgmt(pamh, 0);
> @@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb,
> const struct name_value_list *
>              case COMMAND_VERIFY:
>                  if (recv_string(fd, up.username, sizeof(up.username)) ==
> -1
>                      || recv_string(fd, up.password, sizeof(up.password))
> == -1
> -                    || recv_string(fd, up.common_name,
> sizeof(up.common_name)) == -1)
> +                    || recv_string(fd, up.common_name,
> sizeof(up.common_name)) == -1
> +                    || recv_string(fd, up.remote, sizeof(up.remote)) ==
> -1)
>                  {
>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: read error on
> command channel: code=%d, exiting\n",
>                              command);
> @@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb,
> const struct name_value_list *
>                              up.username, up.password);
>  #else
>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n",
> up.username);
> +                    fprintf(stderr, "AUTH-PAM: BACKGROUND: REMOTE: %s\n",
> up.remote);
>

Just for the record: we have to replace all these xprintf()'s by
plugin_log/plugin_vlog callbacks but that's beyond the scope here.

 #endif
>                  }
>

Looks good otherwise.

Selva

--00000000000084cfc30593dca4c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Its use=
ful to set PAM_<span id=3D"m_-8358678940876167294m_712506079045984063:8dn.1=
">RHOSTS</span> which will allow use of</div><div><span id=3D"m_-8358678940=
876167294m_712506079045984063:8dn.2">pam</span>_access for access control e=
tc. So feature <span id=3D"m_-8358678940876167294m_712506079045984063:8dn.3=
">ACK</span>.<br></div></div><div><br></div><div>I would like to see a more=
 precise commit message header like:</div><div>&quot;Insert remote <span id=
=3D"m_-8358678940876167294m_712506079045984063:8dn.4">IP</span> address int=
o PAM environment&quot;<br></div><div><br></div><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 2019 at 8:25 AM Paolo =
<span id=3D"m_-8358678940876167294m_712506079045984063:8dn.5">Cerrito</span=
> &lt;<a href=3D"mailto:wardragon78@...277..." target=3D"_blank">wardragon7=
8@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: paolo &lt;<a href=3D"mailto:paolo.cerrito@...2517..." targ=
et=3D"_blank">paolo.cerrito@...2517...</a>&gt;<br>
<br>
---<br>
=C2=A0src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---<br>
=C2=A01 file changed, 16 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c<br>
index 88b53204..9d8dfb95 100644<br>
--- a/src/plugins/auth-pam/auth-pam.c<br>
+++ b/src/plugins/auth-pam/auth-pam.c<br>
@@ -115,6 +115,7 @@ struct user_pass {<br>
=C2=A0 =C2=A0 =C2=A0char password[128];<br>
=C2=A0 =C2=A0 =C2=A0char common_name[128];<br>
=C2=A0 =C2=A0 =C2=A0char response[128];<br>
+=C2=A0 =C2=A0 char remote[128];<br>
<br>
=C2=A0 =C2=A0 =C2=A0const struct name_value_list *name_value_list;<br>
=C2=A0};<br>
@@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle=
, const int type, const cha<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *username =3D get_env(&quot;us=
ername&quot;, envp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *password =3D get_env(&quot;pa=
ssword&quot;, envp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *common_name =3D get_env(&quot=
;common_name&quot;, envp) ? get_env(&quot;common_name&quot;, envp) : &quot;=
&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *remote =3D get_env(&quot;untrusted=
_ip&quot;, envp) ? get_env(&quot;untrusted_ip&quot;, envp) : get_env(&quot;=
untrusted_ip6&quot;, envp);<br></blockquote><br></div><div class=3D"gmail_q=
uote">Ensure that remote can&#39;t be NULL, like:<br></div><div class=3D"gm=
ail_quote"><br></div><div class=3D"gmail_quote">if (!remote) <br></div><div=
 class=3D"gmail_quote">{</div><div class=3D"gmail_quote">=C2=A0=C2=A0=C2=A0=
 remote =3D &quot;&quot;;</div><div class=3D"gmail_quote">}</div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Though get_<span id=
=3D"m_-8358678940876167294m_712506079045984063:8dn.6">env</span>() is unlik=
ely to return NULL in this case,</div>safer not to rely on that and risk a =
NULL <span id=3D"m_-8358678940876167294m_712506079045984063:8dn.7">derefere=
ncing</span> later.<div class=3D"gmail_quote"><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (username &amp;&amp; strlen(username) =
&gt; 0 &amp;&amp; password)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (send_control(context-&g=
t;foreground_fd, COMMAND_VERIFY) =3D=3D -1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| send_strin=
g(context-&gt;foreground_fd, username) =3D=3D -1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| send_strin=
g(context-&gt;foreground_fd, password) =3D=3D -1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || send_string(con=
text-&gt;foreground_fd, common_name) =3D=3D -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || send_string(con=
text-&gt;foreground_fd, common_name) =3D=3D -1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || send_string(con=
text-&gt;foreground_fd, remote) =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stder=
r, &quot;AUTH-PAM: Error sending auth info to background process\n&quot;);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -750,8 +753,16 @@ pam_auth(const char *service, const struct user_pass *=
up)<br>
=C2=A0 =C2=A0 =C2=A0status =3D pam_start(service, name_value_list_provided =
? NULL : up-&gt;username, &amp;conv, &amp;pamh);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D PAM_SUCCESS)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set PAM_RHOST environment variable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*(up-&gt;remote))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D pam_set_item(pamh, PA=
M_RHOST, up-&gt;remote);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Call PAM to verify username/password *=
/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D pam_authenticate(pamh, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D PAM_SUCCESS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D pam_authenticate(pamh=
, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D PAM_SUCCESS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D pam_acct_mgmt(pa=
mh, 0);<br>
@@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb, const=
 struct name_value_list *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case COMMAND_VERIFY:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (recv_stri=
ng(fd, up.username, sizeof(up.username)) =3D=3D -1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|| recv_string(fd, up.password, sizeof(up.password)) =3D=3D -1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || r=
ecv_string(fd, up.common_name, sizeof(up.common_name)) =3D=3D -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || r=
ecv_string(fd, up.common_name, sizeof(up.common_name)) =3D=3D -1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || r=
ecv_string(fd, up.remote, sizeof(up.remote)) =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(stderr, &quot;AUTH-PAM: BACKGROUND: read error on command channe=
l: code=3D%d, exiting\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command);<br>
@@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb, const=
 struct name_value_list *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up.username, up.password);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(stderr, &quot;AUTH-PAM: BACKGROUND: USER: %s\n&quot;, up.usernam=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fpri=
ntf(stderr, &quot;AUTH-PAM: BACKGROUND: REMOTE: %s\n&quot;, up.remote);<br>=
</blockquote><div><br></div><div>Just for the record: we have to replace al=
l these <span id=3D"m_-8358678940876167294m_712506079045984063:8dn.8">xprin=
tf</span>()&#39;s by<br></div><div><span id=3D"m_-8358678940876167294m_7125=
06079045984063:8dn.9">plugin</span>_log/<span id=3D"m_-8358678940876167294m=
_712506079045984063:8dn.10">plugin</span>_<span id=3D"m_-835867894087616729=
4m_712506079045984063:8dn.11">vlog</span> callbacks but that&#39;s beyond t=
he scope here.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockq=
uote><div><br></div><div>Looks good otherwise.</div><div><br></div><div><sp=
an id=3D"m_-8358678940876167294m_712506079045984063:8dn.12">Selva</span></d=
iv></div></div>

--00000000000084cfc30593dca4c5--

