MIME-Version: 1.0
In-Reply-To: <1532486093-24793-1-git-send-email-selva.nair@...277...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
From: Joe Bell <joeaintexas@...277...>
Date: Wed, 25 Jul 2018 16:31:05 -0500
Message-ID: <CAC+mqbndu79SZhVuL0aX3Jfar4WgPc_JkUdCv1=8s-Lj7vCqrw@...278...>
Content-Type: multipart/alternative; boundary="000000000000a3b8490571d9982d"
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000a3b8490571d9982d
Content-Type: text/plain; charset="UTF-8"

I don't know if it is appropriate to reply to this post in this manner, but
Selva's static challenge response in the PAM plugin would be a great
addition; I've applied this and the base64 patch and can successfully use
the implementation with Tunnelblick (which is supporting static-challenge
as of 3.7.7beta03, as well as the current version of the Windows OpenVPN
client (I'm using Google Authenticator for the OTP).

If there is anything I can do to provide a list of testcases, write-up on
its configuration and usage, etc., in aide of getting the patch merged and
released, please let me know.

Many thanks,
Joe


On Tue, Jul 24, 2018 at 9:34 PM, <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> If static challenge is in use, the password passed to the plugin by openvpn
> is of the form "SCRV1:base64-pass:base64-response". Parse this string to
> separate it into password and response and use them to respond to queries
> in the pam conversation function.
>
> On the plugin parameters line the substitution keyword for the static
> challenge response is "OTP". For example, for pam config named "test" that
> prompts for "user", "password" and "pin", use
>
> plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
>
> ---
> v2: Depends on the base64 export patch
> v3: match password string with "SCRV1:" instead of "SCRV1"
> (pointed out by Joe Bell <joeaintexas@...277...>)
>
>  src/plugins/auth-pam/README.auth-pam | 15 +++++---
>  src/plugins/auth-pam/auth-pam.c      | 75 ++++++++++++++++++++++++++++++
> +++++-
>  2 files changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/src/plugins/auth-pam/README.auth-pam
> b/src/plugins/auth-pam/README.auth-pam
> index e123690..9081565 100644
> --- a/src/plugins/auth-pam/README.auth-pam
> +++ b/src/plugins/auth-pam/README.auth-pam
> @@ -36,19 +36,20 @@ pairs to answer PAM module queries.
>
>  For example:
>
> -  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
> +  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD pin
> OTP"
>
>  tells auth-pam to (a) use the "login" PAM module, (b) answer a
> -"login" query with the username given by the OpenVPN client, and
> -(c) answer a "password" query with the password given by the
> -OpenVPN client.  This provides flexibility in dealing with the different
> +"login" query with the username given by the OpenVPN client,
> +(c) answer a "password" query with the password, and (d) answer a
> +"pin" query with the OTP given by the OpenVPN client.
> +This provides flexibility in dealing with different
>  types of query strings which different PAM modules might generate.
>  For example, suppose you were using a PAM module called
>  "test" which queried for "name" rather than "login":
>
>    plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"
>
> -While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which
> substitute
> +While "USERNAME" "COMMONNAME" "PASSWORD" and "OTP" are special strings
> which substitute
>  to client-supplied values, it is also possible to name literal values
>  to use as PAM module query responses.  For example, suppose that the
>  login module queried for a third parameter, "domain" which
> @@ -61,6 +62,10 @@ the operation of this plugin:
>
>    client-cert-not-required
>    username-as-common-name
> +  static-challenge
> +
> +Use of --static challenege is required to pass a pin (represented by
> "OTP" in
> +parameter substituion) or a second password.
>
>  Run OpenVPN with --verb 7 or higher to get debugging output from
>  this plugin, including the list of queries presented by the
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-
> pam.c
> index 26b0eeb..e22ce5f 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -6,6 +6,7 @@
>   *             packet compression.
>   *
>   *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
> + *  Copyright (C) 2016-2018 Selva Nair <selva.nair@...277...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> @@ -64,6 +65,7 @@
>
>  /* Pointers to functions exported from openvpn */
>  static plugin_secure_memzero_t plugin_secure_memzero = NULL;
> +static plugin_base64_decode_t plugin_base64_decode = NULL;
>
>  /*
>   * Plugin state, used by foreground
> @@ -87,6 +89,7 @@ struct auth_pam_context
>   *  "USERNAME" -- substitute client-supplied username
>   *  "PASSWORD" -- substitute client-specified password
>   *  "COMMONNAME" -- substitute client certificate common name
> + *  "OTP" -- substitute static challenge response if available
>   */
>
>  #define N_NAME_VALUE 16
> @@ -111,6 +114,7 @@ struct user_pass {
>      char username[128];
>      char password[128];
>      char common_name[128];
> +    char response[128];
>
>      const struct name_value_list *name_value_list;
>  };
> @@ -276,6 +280,66 @@ name_value_match(const char *query, const char *match)
>      return strncasecmp(match, query, strlen(match)) == 0;
>  }
>
> +/*
> + * Split and decode up->password in the form SCRV1:base64_pass:base64_
> response
> + * into pass and response and save in up->password and up->response.
> + * If the password is not in the expected format, input is not changed.
> + */
> +static void
> +split_scrv1_password(struct user_pass *up)
> +{
> +    const int skip = strlen("SCRV1:");
> +    if (strncmp(up->password, "SCRV1:", skip) != 0)
> +    {
> +        return;
> +    }
> +
> +    char *tmp = strdup(up->password);
> +    if (!tmp)
> +    {
> +        fprintf(stderr, "AUTH-PAM: out of memory parsing static challenge
> password\n");
> +        goto out;
> +    }
> +
> +    char *pass = tmp + skip;
> +    char *resp = strchr(pass, ':');
> +    if (!resp) /* string not in SCRV1:xx:yy format */
> +    {
> +        goto out;
> +    }
> +    *resp++ = '\0';
> +
> +    int n = plugin_base64_decode(pass, up->password,
> sizeof(up->password)-1);
> +    if (n > 0)
> +    {
> +        up->password[n] = '\0';
> +        n = plugin_base64_decode(resp, up->response,
> sizeof(up->response)-1);
> +        if (n > 0)
> +        {
> +            up->response[n] = '\0';
> +            if (DEBUG(up->verb))
> +            {
> +                fprintf(stderr, "AUTH-PAM: BACKGROUND: parsed static
> challenge password\n");
> +            }
> +            goto out;
> +        }
> +    }
> +
> +    /* decode error: reinstate original value of up->password and return
> */
> +    plugin_secure_memzero(up->password, sizeof(up->password));
> +    plugin_secure_memzero(up->response, sizeof(up->response));
> +    strcpy(up->password, tmp); /* tmp is guaranteed to fit in
> up->password */
> +
> +    fprintf(stderr, "AUTH-PAM: base64 decode error while parsing static
> challenge password\n");
> +
> +out:
> +    if (tmp)
> +    {
> +        plugin_secure_memzero(tmp, strlen(tmp));
> +        free(tmp);
> +    }
> +}
> +
>  OPENVPN_EXPORT int
>  openvpn_plugin_open_v3(const int v3structver,
>                         struct openvpn_plugin_args_open_in const *args,
> @@ -316,6 +380,7 @@ openvpn_plugin_open_v3(const int v3structver,
>
>      /* Save global pointers to functions exported from openvpn */
>      plugin_secure_memzero = args->callbacks->plugin_secure_memzero;
> +    plugin_base64_decode = args->callbacks->plugin_base64_decode;
>
>      /*
>       * Make sure we have two string arguments: the first is the .so name,
> @@ -599,6 +664,10 @@ my_conv(int n, const struct pam_message **msg_array,
>                      {
>                          aresp[i].resp = searchandreplace(match_value,
> "COMMONNAME", up->common_name);
>                      }
> +                    else if (strstr(match_value, "OTP"))
> +                    {
> +                        aresp[i].resp = searchandreplace(match_value,
> "OTP", up->response);
> +                    }
>                      else
>                      {
>                          aresp[i].resp = strdup(match_value);
> @@ -787,6 +856,9 @@ pam_server(int fd, const char *service, int verb,
> const struct name_value_list *
>  #endif
>                  }
>
> +                /* If password is of the form SCRV1:base64:base64 split
> it up */
> +                split_scrv1_password(&up);
> +
>                  if (pam_auth(service, &up)) /* Succeeded */
>                  {
>                      if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
> @@ -818,10 +890,11 @@ pam_server(int fd, const char *service, int verb,
> const struct name_value_list *
>                          command);
>                  goto done;
>          }
> +        plugin_secure_memzero(up.response, sizeof(up.response));
>      }
>  done:
> -
>      plugin_secure_memzero(up.password, sizeof(up.password));
> +    plugin_secure_memzero(up.response, sizeof(up.response));
>  #ifdef USE_PAM_DLOPEN
>      dlclose_pam();
>  #endif
> --
> 2.1.4
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000a3b8490571d9982d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t know if it is appropriate to reply to this pos=
t in this manner, but Selva&#39;s static challenge response in the PAM plug=
in would be a great addition; I&#39;ve applied this and the base64 patch an=
d can successfully use the implementation with Tunnelblick (which is suppor=
ting static-challenge as of 3.7.7beta03, as well as the current version of =
the Windows OpenVPN client (I&#39;m using Google Authenticator for the OTP)=
.<div><br></div><div>If there is anything I can do to provide a list of tes=
tcases, write-up on its configuration and usage, etc., in aide of getting t=
he patch merged and released, please let me know.</div><div><br></div><div>=
Many thanks,</div><div>Joe</div><div><br></div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Jul 24, 2018 at 9:34 PM,  <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">=
selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...220...=
..277...</a>&gt;<br>
<br>
If static challenge is in use, the password passed to the plugin by openvpn=
<br>
is of the form &quot;SCRV1:base64-pass:base64-<wbr>response&quot;. Parse th=
is string to<br>
separate it into password and response and use them to respond to queries<b=
r>
in the pam conversation function.<br>
<br>
On the plugin parameters line the substitution keyword for the static<br>
challenge response is &quot;OTP&quot;. For example, for pam config named &q=
uot;test&quot; that<br>
prompts for &quot;user&quot;, &quot;password&quot; and &quot;pin&quot;, use=
<br>
<br>
plugin openvpn-auth-pam.so &quot;test user USERNAME password PASSWORD pin O=
TP&quot;<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
<br>
---<br>
v2: Depends on the base64 export patch<br>
v3: match password string with &quot;SCRV1:&quot; instead of &quot;SCRV1&qu=
ot;<br>
(pointed out by Joe Bell &lt;<a href=3D"mailto:joeaintexas@...277...">joeai=
ntexas@...277...</a>&gt;)<br>
<br>
=C2=A0src/plugins/auth-pam/README.<wbr>auth-pam | 15 +++++---<br>
=C2=A0src/plugins/auth-pam/auth-pam.<wbr>c=C2=A0 =C2=A0 =C2=A0 | 75 +++++++=
+++++++++++++++++++++++<wbr>+++++-<br>
=C2=A02 files changed, 84 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/src/plugins/auth-pam/README.<wbr>auth-pam b/src/plugins/auth-p=
am/README.<wbr>auth-pam<br>
index e123690..9081565 100644<br>
--- a/src/plugins/auth-pam/README.<wbr>auth-pam<br>
+++ b/src/plugins/auth-pam/README.<wbr>auth-pam<br>
@@ -36,19 +36,20 @@ pairs to answer PAM module queries.<br>
<br>
=C2=A0For example:<br>
<br>
-=C2=A0 plugin openvpn-auth-pam.so &quot;login login USERNAME password PASS=
WORD&quot;<br>
+=C2=A0 plugin openvpn-auth-pam.so &quot;login login USERNAME password PASS=
WORD pin OTP&quot;<br>
<br>
=C2=A0tells auth-pam to (a) use the &quot;login&quot; PAM module, (b) answe=
r a<br>
-&quot;login&quot; query with the username given by the OpenVPN client, and=
<br>
-(c) answer a &quot;password&quot; query with the password given by the<br>
-OpenVPN client.=C2=A0 This provides flexibility in dealing with the differ=
ent<br>
+&quot;login&quot; query with the username given by the OpenVPN client,<br>
+(c) answer a &quot;password&quot; query with the password, and (d) answer =
a<br>
+&quot;pin&quot; query with the OTP given by the OpenVPN client.<br>
+This provides flexibility in dealing with different<br>
=C2=A0types of query strings which different PAM modules might generate.<br>
=C2=A0For example, suppose you were using a PAM module called<br>
=C2=A0&quot;test&quot; which queried for &quot;name&quot; rather than &quot=
;login&quot;:<br>
<br>
=C2=A0 =C2=A0plugin openvpn-auth-pam.so &quot;test name USERNAME password P=
ASSWORD&quot;<br>
<br>
-While &quot;USERNAME&quot; &quot;COMMONNAME&quot; and &quot;PASSWORD&quot;=
 are special strings which substitute<br>
+While &quot;USERNAME&quot; &quot;COMMONNAME&quot; &quot;PASSWORD&quot; and=
 &quot;OTP&quot; are special strings which substitute<br>
=C2=A0to client-supplied values, it is also possible to name literal values=
<br>
=C2=A0to use as PAM module query responses.=C2=A0 For example, suppose that=
 the<br>
=C2=A0login module queried for a third parameter, &quot;domain&quot; which<=
br>
@@ -61,6 +62,10 @@ the operation of this plugin:<br>
<br>
=C2=A0 =C2=A0client-cert-not-required<br>
=C2=A0 =C2=A0username-as-common-name<br>
+=C2=A0 static-challenge<br>
+<br>
+Use of --static challenege is required to pass a pin (represented by &quot=
;OTP&quot; in<br>
+parameter substituion) or a second password.<br>
<br>
=C2=A0Run OpenVPN with --verb 7 or higher to get debugging output from<br>
=C2=A0this plugin, including the list of queries presented by the<br>
diff --git a/src/plugins/auth-pam/auth-<wbr>pam.c b/src/plugins/auth-pam/au=
th-<wbr>pam.c<br>
index 26b0eeb..e22ce5f 100644<br>
--- a/src/plugins/auth-pam/auth-<wbr>pam.c<br>
+++ b/src/plugins/auth-pam/auth-<wbr>pam.c<br>
@@ -6,6 +6,7 @@<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet compression.=
<br>
=C2=A0 *<br>
=C2=A0 *=C2=A0 Copyright (C) 2002-2018 OpenVPN Inc &lt;<a href=3D"mailto:sa=
les@...515...">sales@...515...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2016-2018 Selva Nair &lt;<a href=3D"mailto:selva.na=
ir@...277...">selva.nair@...277...</a>&gt;<br>
=C2=A0 *<br>
=C2=A0 *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
=C2=A0 *=C2=A0 it under the terms of the GNU General Public License version=
 2<br>
@@ -64,6 +65,7 @@<br>
<br>
=C2=A0/* Pointers to functions exported from openvpn */<br>
=C2=A0static plugin_secure_memzero_t plugin_secure_memzero =3D NULL;<br>
+static plugin_base64_decode_t plugin_base64_decode =3D NULL;<br>
<br>
=C2=A0/*<br>
=C2=A0 * Plugin state, used by foreground<br>
@@ -87,6 +89,7 @@ struct auth_pam_context<br>
=C2=A0 *=C2=A0 &quot;USERNAME&quot; -- substitute client-supplied username<=
br>
=C2=A0 *=C2=A0 &quot;PASSWORD&quot; -- substitute client-specified password=
<br>
=C2=A0 *=C2=A0 &quot;COMMONNAME&quot; -- substitute client certificate comm=
on name<br>
+ *=C2=A0 &quot;OTP&quot; -- substitute static challenge response if availa=
ble<br>
=C2=A0 */<br>
<br>
=C2=A0#define N_NAME_VALUE 16<br>
@@ -111,6 +114,7 @@ struct user_pass {<br>
=C2=A0 =C2=A0 =C2=A0char username[128];<br>
=C2=A0 =C2=A0 =C2=A0char password[128];<br>
=C2=A0 =C2=A0 =C2=A0char common_name[128];<br>
+=C2=A0 =C2=A0 char response[128];<br>
<br>
=C2=A0 =C2=A0 =C2=A0const struct name_value_list *name_value_list;<br>
=C2=A0};<br>
@@ -276,6 +280,66 @@ name_value_match(const char *query, const char *match)=
<br>
=C2=A0 =C2=A0 =C2=A0return strncasecmp(match, query, strlen(match)) =3D=3D =
0;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Split and decode up-&gt;password in the form SCRV1:base64_pass:base64_<=
wbr>response<br>
+ * into pass and response and save in up-&gt;password and up-&gt;response.=
<br>
+ * If the password is not in the expected format, input is not changed.<br>
+ */<br>
+static void<br>
+split_scrv1_password(struct user_pass *up)<br>
+{<br>
+=C2=A0 =C2=A0 const int skip =3D strlen(&quot;SCRV1:&quot;);<br>
+=C2=A0 =C2=A0 if (strncmp(up-&gt;password, &quot;SCRV1:&quot;, skip) !=3D =
0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 char *tmp =3D strdup(up-&gt;password);<br>
+=C2=A0 =C2=A0 if (!tmp)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;AUTH-PAM: out of memory =
parsing static challenge password\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 char *pass =3D tmp + skip;<br>
+=C2=A0 =C2=A0 char *resp =3D strchr(pass, &#39;:&#39;);<br>
+=C2=A0 =C2=A0 if (!resp) /* string not in SCRV1:xx:yy format */<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *resp++ =3D &#39;\0&#39;;<br>
+<br>
+=C2=A0 =C2=A0 int n =3D plugin_base64_decode(pass, up-&gt;password, sizeof=
(up-&gt;password)-1);<br>
+=C2=A0 =C2=A0 if (n &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 up-&gt;password[n] =3D &#39;\0&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D plugin_base64_decode(resp, up-&gt;respon=
se, sizeof(up-&gt;response)-1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up-&gt;response[n] =3D &#39;\0&#=
39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (DEBUG(up-&gt;verb))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;AUTH-PAM: BACKGROUND: parsed static challenge password\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* decode error: reinstate original value of up-&gt;password=
 and return */<br>
+=C2=A0 =C2=A0 plugin_secure_memzero(up-&gt;<wbr>password, sizeof(up-&gt;pa=
ssword));<br>
+=C2=A0 =C2=A0 plugin_secure_memzero(up-&gt;<wbr>response, sizeof(up-&gt;re=
sponse));<br>
+=C2=A0 =C2=A0 strcpy(up-&gt;password, tmp); /* tmp is guaranteed to fit in=
 up-&gt;password */<br>
+<br>
+=C2=A0 =C2=A0 fprintf(stderr, &quot;AUTH-PAM: base64 decode error while pa=
rsing static challenge password\n&quot;);<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 if (tmp)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 plugin_secure_memzero(tmp, strlen(tmp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(tmp);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0OPENVPN_EXPORT int<br>
=C2=A0openvpn_plugin_open_v3(const int v3structver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct openvpn_plugin_args_open_in const *args,<br>
@@ -316,6 +380,7 @@ openvpn_plugin_open_v3(const int v3structver,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Save global pointers to functions exported from open=
vpn */<br>
=C2=A0 =C2=A0 =C2=A0plugin_secure_memzero =3D args-&gt;callbacks-&gt;plugin=
_<wbr>secure_memzero;<br>
+=C2=A0 =C2=A0 plugin_base64_decode =3D args-&gt;callbacks-&gt;plugin_<wbr>=
base64_decode;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Make sure we have two string arguments: the first is=
 the .so name,<br>
@@ -599,6 +664,10 @@ my_conv(int n, const struct pam_message **msg_array,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0aresp[i].resp =3D searchandreplace(match_value, &quot;COMM=
ONNAME&quot;, up-&gt;common_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
 if (strstr(match_value, &quot;OTP&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aresp[i].resp =3D searchandreplace(match_value, &quot;OTP&quot;,=
 up-&gt;response);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0aresp[i].resp =3D strdup(match_value);<br>
@@ -787,6 +856,9 @@ pam_server(int fd, const char *service, int verb, const=
 struct name_value_list *<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If password is =
of the form SCRV1:base64:base64 split it up */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 split_scrv1_passwo=
rd(&amp;up);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pam_auth(=
service, &amp;up)) /* Succeeded */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) =3D=3D -1)<br>
@@ -818,10 +890,11 @@ pam_server(int fd, const char *service, int verb, con=
st struct name_value_list *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0command);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 plugin_secure_memzero(up.<wbr>response, sizeof=
(up.response));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0done:<br>
-<br>
=C2=A0 =C2=A0 =C2=A0plugin_secure_memzero(up.<wbr>password, sizeof(up.passw=
ord));<br>
+=C2=A0 =C2=A0 plugin_secure_memzero(up.<wbr>response, sizeof(up.response))=
;<br>
=C2=A0#ifdef USE_PAM_DLOPEN<br>
=C2=A0 =C2=A0 =C2=A0dlclose_pam();<br>
=C2=A0#endif<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.1.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div>

--000000000000a3b8490571d9982d--

