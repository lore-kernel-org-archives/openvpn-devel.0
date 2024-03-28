From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 28 Mar 2024 08:56:28 +0000
References: <gerrit.1711616186000.Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1c308cef2c0a2ecefac6a7d4ee097fd31d35bb86-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="grEED6hqlIc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--grEED6hqlIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/550?usp=3Demail

to review the following change.


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

Change-Id: Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4
---
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/ssl.c
3 files changed, 5 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/550/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--grEED6hqlIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/550?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">misc.c: remove unused code<br><br>Commit<br><br>  3a4fb1 &quo=
t;Ensure --auth-nocache is handled during renegotiation&quot;<br><br>has ch=
anged the behavior of set_auth_token(), but left unused parameter<br><br>  =
struct user_pass *up<br><br>Remove this parameter and amend comments accord=
ingly. Also remove<br>unused function definition from misc.h.<br><br>Signed=
-off-by: Lev Stipakov &lt;lev@...515...&gt;<br><br>Change-Id: Ic440f2c8d46d=
fcb5ff41ba2f33bf28bb7286eec4<br>---<br>M src/openvpn/misc.c<br>M src/openvp=
n/misc.h<br>M src/openvpn/ssl.c<br>3 files changed, 5 insertions(+), 17 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/50/550/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c=
</span><br><span>index 3ff0857..598fbae 100644</span><br><span>--- a/src/op=
envpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -4=
91,19 +491,15 @@</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_auth_token(struct=
 user_pass *up, struct user_pass *tk, const char *token)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+set_auth_token(struct user_pass *tk, c=
onst char *token)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>     if (strlen(token))</span><br><span>   =
  {</span><br><span>         strncpynt(tk-&gt;password, token, USER_PASS_LE=
N);</span><br><span>         tk-&gt;token_defined =3D true;</span><br><span=
> </span><br><span>         /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * --auth-token has no username, so it needs the username<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * either alre=
ady set or copied from up, or later set by</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * --auth-token-user</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * If already set, tk is fully defined.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * If usern=
ame already set, tk is fully defined.</span><br><span>          */</span><b=
r><span>         if (strlen(tk-&gt;username))</span><br><span>         {</s=
pan><br><span>diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</span><b=
r><span>index cb3bf68..963f3e6 100644</span><br><span>--- a/src/openvpn/mis=
c.h</span><br><span>+++ b/src/openvpn/misc.h</span><br><span>@@ -152,26 +15=
2,18 @@</span><br><span>     return get_user_pass_cr(up, auth_file, prefix,=
 flags, NULL);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void fail_user_pass(const char *prefix,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    const=
 unsigned int flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   const char *reason);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> void purge_user_pass(struct user_pass *=
up, const bool force);</span><br><span> </span><br><span> /**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Sets the auth-token to token. If=
 a username is available from</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * either up or already present in tk that will be used as default<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * username for the to=
ken. The method will also purge up if</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Sets the auth-token to token. The method will also pur=
ge up if</span><br><span>  * the auth-nocache option is active.</span><br><=
span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param up =
       (non Auth-token) Username/password</span><br><span>  * @param tk    =
    auth-token userpass to set</span><br><span>  * @param token     token t=
o use as password for the auth-token</span><br><span>  *</span><br><span>  =
* @note    all parameters to this function must not be null.</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void set_auth_t=
oken(struct user_pass *up, struct user_pass *tk,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    const char *token);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void set_auth_token(struct u=
ser_pass *tk, const char *token);</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Sets the auth-token username by base64 decoding the passe=
d</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span>=
<br><span>index 7895a37..7c49451 100644</span><br><span>--- a/src/openvpn/s=
sl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -340,7 +340=
,7 @@</span><br><span> void</span><br><span> ssl_set_auth_token(const char =
*token)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    set_auth_token(&amp;auth_user_pass, &amp;auth_token, token);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_auth_token(&amp;a=
uth_token, token);</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/550?usp=3Demail">change 550</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/550?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic440f2c8d46dfcb5ff41ba2f33b=
f28bb7286eec4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--grEED6hqlIc=--

