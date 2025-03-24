From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 13:43:40 +0000
In-Reply-To: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
References: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5c2710e400608c963958fbf6aab1ca93205bae21-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AZa/J4bAV+I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use USER_PASS_LEN
 instead of TLS_USERNAME_LEN for override-username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AZa/J4bAV+I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail

to look at the new patch set (#3).


Change subject: Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-=
username
......................................................................

Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-username

Currently override-username is artificially restricted to the length of
TLS common-name (64) for the corner case of using username-as-common-name,
which we explicitly do not recommend to use.

Do away with that limitation and only error out on longer usernames when
username-as-common-name is actually in effect.

Change-Id: I1c2c050dd160746a0f8d9c234abe1e258bc8e48d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
4 files changed, 42 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/913/3

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a673ec1..a2d3fd1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2705,6 +2705,12 @@
     if (!multi->locked_original_username
         && strcmp(multi->locked_username, options->override_username) !=3D=
 0)
     {
+        /* Check if the username length is acceptable */
+        if (!ssl_verify_username_length(session, options->override_usernam=
e))
+        {
+            return false;
+        }
+
         multi->locked_original_username =3D multi->locked_username;
         multi->locked_username =3D strdup(options->override_username);

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab56609..f89fc7d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7875,10 +7875,10 @@
     else if (streq(p[0], "override-username") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        if (strlen(p[1]) > TLS_USERNAME_LEN)
+        if (strlen(p[1]) > USER_PASS_LEN)
         {
             msg(msglevel, "override-username exceeds the maximum length of=
 %d "
-                "characters", TLS_USERNAME_LEN);
+                "characters", USER_PASS_LEN);

             /* disable the connection since ignoring the request to
              * set another username might cause serious problems */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 5f8f1d3..d2cc3d1 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1568,6 +1568,24 @@
     }
 }

+bool
+ssl_verify_username_length(struct tls_session *session, const char *userna=
me)
+{
+    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
+        && strlen(username) > TLS_USERNAME_LEN)
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Auth Error: --username-as-common name specified and "
+            "username is longer than the maximum permitted Common Name "
+            "length of %d characters", TLS_USERNAME_LEN);
+        return false;
+    }
+    else
+    {
+        return true;
+    }
+}
+
 /**
  * Main username/password verification entry point
  *
@@ -1689,15 +1707,12 @@
     }

     /* check sizing of username if it will become our common name */
-    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-        && strlen(up->username)>TLS_USERNAME_LEN)
+    if (!ssl_verify_username_length(session, up->username))
     {
-        msg(D_TLS_ERRORS,
-            "TLS Auth Error: --username-as-common name specified and usern=
ame is longer than the maximum permitted Common Name length of %d character=
s",
-            TLS_USERNAME_LEN);
         plugin_status =3D OPENVPN_PLUGIN_FUNC_ERROR;
         script_status =3D OPENVPN_PLUGIN_FUNC_ERROR;
     }
+
     /* auth succeeded? */
     bool plugin_ok =3D plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS
                      || plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index eba3832..7a4d44a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -192,6 +192,20 @@
                       struct tls_session *session);


+/**
+ * Checks if the username length is valid to use.  This checks when
+ * username-as-common-name is active if the username is shorter than
+ * the maximum TLS common name length (64).
+ *
+ * It will also display an error message if the name is too long
+ *
+ * @param session       current TLS session
+ * @param username      username to check
+ * @return              true if name is under limit or username-as-common-=
name
+ *                      is not active
+ */
+bool ssl_verify_username_length(struct tls_session *session,
+                                const char *username);

 /**
  * Runs the --client-crresponse script if one is defined.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c2c050dd160746a0f8d9c234abe1e258bc8e48d
Gerrit-Change-Number: 913
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--AZa/J4bAV+I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-username<b=
r><br>Currently override-username is artificially restricted to the length =
of<br>TLS common-name (64) for the corner case of using username-as-common-=
name,<br>which we explicitly do not recommend to use.<br><br>Do away with t=
hat limitation and only error out on longer usernames when<br>username-as-c=
ommon-name is actually in effect.<br><br>Change-Id: I1c2c050dd160746a0f8d9c=
234abe1e258bc8e48d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<b=
r>---<br>M src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/=
ssl_verify.c<br>M src/openvpn/ssl_verify.h<br>4 files changed, 42 insertion=
s(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/13/913/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/op=
envpn/multi.c</span><br><span>index a673ec1..a2d3fd1 100644</span><br><span=
>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span>=
<br><span>@@ -2705,6 +2705,12 @@</span><br><span>     if (!multi-&gt;locked=
_original_username</span><br><span>         &amp;&amp; strcmp(multi-&gt;loc=
ked_username, options-&gt;override_username) !=3D 0)</span><br><span>     {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Check if=
 the username length is acceptable */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!ssl_verify_username_length(session, options-=
&gt;override_username))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>         multi-&gt;locked_original_username =3D multi-&gt;locked_use=
rname;</span><br><span>         multi-&gt;locked_username =3D strdup(option=
s-&gt;override_username);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/options.c b/src/openvpn/options.c</span><br><span>index ab56609..=
f89fc7d 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>=
+++ b/src/openvpn/options.c</span><br><span>@@ -7875,10 +7875,10 @@</span><=
br><span>     else if (streq(p[0], &quot;override-username&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (strlen(p[1]) &gt; TLS_USERNAME_LEN)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(p[1]) &gt; USER_P=
ASS_LEN)</span><br><span>         {</span><br><span>             msg(msglev=
el, &quot;override-username exceeds the maximum length of %d &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;charact=
ers&quot;, TLS_USERNAME_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;characters&quot;, USER_PASS_LEN);</span><br=
><span> </span><br><span>             /* disable the connection since ignor=
ing the request to</span><br><span>              * set another username mig=
ht cause serious problems */</span><br><span>diff --git a/src/openvpn/ssl_v=
erify.c b/src/openvpn/ssl_verify.c</span><br><span>index 5f8f1d3..d2cc3d1 1=
00644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/=
src/openvpn/ssl_verify.c</span><br><span>@@ -1568,6 +1568,24 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ssl_verify_username_length(struct tls_session *session, const=
 char *username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((session-&gt;=
opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; strlen(username) &gt; =
TLS_USERNAME_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TL=
S_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;TLS Auth Error: --username-as-common name specified and &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;userna=
me is longer than the maximum permitted Common Name &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;length of %d chara=
cters&quot;, TLS_USERNAME_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Main username/=
password verification entry point</span><br><span>  *</span><br><span>@@ -1=
689,15 +1707,12 @@</span><br><span>     }</span><br><span> </span><br><span=
>     /* check sizing of username if it will become our common name */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((session-&gt;opt-&=
gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        &amp;&amp; strlen(up-&gt;username)&gt;TL=
S_USERNAME_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!ssl_verify_username_length(session, up-&gt;username))</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_T=
LS_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 &quot;TLS Auth Error: --username-as-common name specified and username is =
longer than the maximum permitted Common Name length of %d characters&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            TLS_USER=
NAME_LEN);</span><br><span>         plugin_status =3D OPENVPN_PLUGIN_FUNC_E=
RROR;</span><br><span>         script_status =3D OPENVPN_PLUGIN_FUNC_ERROR;=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     /* auth succeeded? */</span><br><span>     bool p=
lugin_ok =3D plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS</span><br><sp=
an>                      || plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERR=
ED;</span><br><span>diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl=
_verify.h</span><br><span>index eba3832..7a4d44a 100644</span><br><span>---=
 a/src/openvpn/ssl_verify.h</span><br><span>+++ b/src/openvpn/ssl_verify.h<=
/span><br><span>@@ -192,6 +192,20 @@</span><br><span>                      =
 struct tls_session *session);</span><br><span> </span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Checks if the username length is valid to=
 use.  This checks when</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * username-as-common-name is active if the username is shorter than</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the maximum TLS com=
mon name length (64).</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It will also=
 display an error message if the name is too long</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param session       current TLS session</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param username      username to ch=
eck</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return      =
        true if name is under limit or username-as-common-name</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *                      is not a=
ctive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_username_lengt=
h(struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                const char *username);</span><br=
><span> </span><br><span> /**</span><br><span>  * Runs the --client-crrespo=
nse script if one is defined.</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail">cha=
nge 913</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c2c050dd160746a0f8d9c234ab=
e1e258bc8e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 913 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--AZa/J4bAV+I=--

