From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 29 Mar 2024 11:55:00 +0000
In-Reply-To: <gerrit.1711616186000.Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4@...2715...>
References: <gerrit.1711616186000.Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <c2ccbb27df7c9abdcbc3249b5f52fe26c5548000-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aDkKJBBoJ+0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc.c: remove
 unused code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aDkKJBBoJ+0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/550?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: misc.c: remove unused code
......................................................................

misc.c: remove unused code

Commit

  3a4fb1 "Ensure --auth-nocache is handled during renegotiation"

has changed the behavior of set_auth_token(), but left unused parameter

  struct user_pass *up

Remove this parameter and amend comments accordingly. Also remove
unused function definition from misc.h.

Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>

Change-Id: Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4
Message-Id: <20240329103739.28254-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
503.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/ssl.c
3 files changed, 5 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/550/2

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 3ff0857..598fbae 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -491,19 +491,15 @@
 }

 void
-set_auth_token(struct user_pass *up, struct user_pass *tk, const char *tok=
en)
+set_auth_token(struct user_pass *tk, const char *token)
 {
-
     if (strlen(token))
     {
         strncpynt(tk->password, token, USER_PASS_LEN);
         tk->token_defined =3D true;

         /*
-         * --auth-token has no username, so it needs the username
-         * either already set or copied from up, or later set by
-         * --auth-token-user
-         * If already set, tk is fully defined.
+         * If username already set, tk is fully defined.
          */
         if (strlen(tk->username))
         {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index cb3bf68..963f3e6 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -152,26 +152,18 @@
     return get_user_pass_cr(up, auth_file, prefix, flags, NULL);
 }

-void fail_user_pass(const char *prefix,
-                    const unsigned int flags,
-                    const char *reason);
-
 void purge_user_pass(struct user_pass *up, const bool force);

 /**
- * Sets the auth-token to token. If a username is available from
- * either up or already present in tk that will be used as default
- * username for the token. The method will also purge up if
+ * Sets the auth-token to token. The method will also purge up if
  * the auth-nocache option is active.
  *
- * @param up        (non Auth-token) Username/password
  * @param tk        auth-token userpass to set
  * @param token     token to use as password for the auth-token
  *
  * @note    all parameters to this function must not be null.
  */
-void set_auth_token(struct user_pass *up, struct user_pass *tk,
-                    const char *token);
+void set_auth_token(struct user_pass *tk, const char *token);

 /**
  * Sets the auth-token username by base64 decoding the passed
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7895a37..7c49451 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -340,7 +340,7 @@
 void
 ssl_set_auth_token(const char *token)
 {
-    set_auth_token(&auth_user_pass, &auth_token, token);
+    set_auth_token(&auth_token, token);
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/550?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4
Gerrit-Change-Number: 550
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--aDkKJBBoJ+0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/550?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">misc.c: remove unused code<br><br>Commit<br><=
br>  3a4fb1 &quot;Ensure --auth-nocache is handled during renegotiation&quo=
t;<br><br>has changed the behavior of set_auth_token(), but left unused par=
ameter<br><br>  struct user_pass *up<br><br>Remove this parameter and amend=
 comments accordingly. Also remove<br>unused function definition from misc.=
h.<br><br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br><br>Change-Id: Ic440f2c8d46dfcb=
5ff41ba2f33bf28bb7286eec4<br>Message-Id: &lt;20240329103739.28254-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg28503.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M src/openvp=
n/ssl.c<br>3 files changed, 5 insertions(+), 17 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/550/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>index 3=
ff0857..598fbae 100644</span><br><span>--- a/src/openvpn/misc.c</span><br><=
span>+++ b/src/openvpn/misc.c</span><br><span>@@ -491,19 +491,15 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-set_auth_token(struct user_pass *up, struct=
 user_pass *tk, const char *token)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+set_auth_token(struct user_pass *tk, const char *token)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     if (strlen(token))</span><br><span>     {</span><br><span>  =
       strncpynt(tk-&gt;password, token, USER_PASS_LEN);</span><br><span>  =
       tk-&gt;token_defined =3D true;</span><br><span> </span><br><span>   =
      /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * --=
auth-token has no username, so it needs the username</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * either already set or copied fro=
m up, or later set by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         * --auth-token-user</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         * If already set, tk is fully defined.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * If username already set, tk i=
s fully defined.</span><br><span>          */</span><br><span>         if (=
strlen(tk-&gt;username))</span><br><span>         {</span><br><span>diff --=
git a/src/openvpn/misc.h b/src/openvpn/misc.h</span><br><span>index cb3bf68=
..963f3e6 100644</span><br><span>--- a/src/openvpn/misc.h</span><br><span>+=
++ b/src/openvpn/misc.h</span><br><span>@@ -152,26 +152,18 @@</span><br><sp=
an>     return get_user_pass_cr(up, auth_file, prefix, flags, NULL);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void fail_user_pass(const char *prefix,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    const unsigned int flags,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    cons=
t char *reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> void purge_user_pass(struct user_pass *up, const bool force);<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Sets the auth-token to token. If a username is availabl=
e from</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * either up or=
 already present in tk that will be used as default</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * username for the token. The method will =
also purge up if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Sets the auth-token to token. The method will also purge up if</span><br><s=
pan>  * the auth-nocache option is active.</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param up        (non Auth-toke=
n) Username/password</span><br><span>  * @param tk        auth-token userpa=
ss to set</span><br><span>  * @param token     token to use as password for=
 the auth-token</span><br><span>  *</span><br><span>  * @note    all parame=
ters to this function must not be null.</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void set_auth_token(struct user_pass=
 *up, struct user_pass *tk,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    const char *token);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void set_auth_token(struct user_pass *tk, const c=
har *token);</span><br><span> </span><br><span> /**</span><br><span>  * Set=
s the auth-token username by base64 decoding the passed</span><br><span>dif=
f --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 7895a=
37..7c49451 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>=
+++ b/src/openvpn/ssl.c</span><br><span>@@ -340,7 +340,7 @@</span><br><span=
> void</span><br><span> ssl_set_auth_token(const char *token)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_auth_tok=
en(&amp;auth_user_pass, &amp;auth_token, token);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    set_auth_token(&amp;auth_token, token);</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/550?usp=3Demail">change 550</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/550?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic440f2c8d46dfcb5ff41ba2f33b=
f28bb7286eec4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--aDkKJBBoJ+0=--

