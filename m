From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 09:34:29 +0000
In-Reply-To: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
References: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5beeb503aac8dccde4b1c1b172fcf19663a6e0d3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s+WLFhHwccM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s+WLFhHwccM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
3?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250402134546.3504-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
323.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
4 files changed, 42 insertions(+), 7 deletions(-)




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
index 6605a42..96119c4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7880,10 +7880,10 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--s+WLFhHwccM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/913?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Use USER_PASS_LEN instead of TLS_USERNAME_LEN =
for override-username<br><br>Currently override-username is artificially re=
stricted to the length of<br>TLS common-name (64) for the corner case of us=
ing username-as-common-name,<br>which we explicitly do not recommend to use=
.<br><br>Do away with that limitation and only error out on longer username=
s when<br>username-as-common-name is actually in effect.<br><br>Change-Id: =
I1c2c050dd160746a0f8d9c234abe1e258bc8e48d<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Message-Id: &lt;20250402134546.3504-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31323.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/m=
ulti.c<br>M src/openvpn/options.c<br>M src/openvpn/ssl_verify.c<br>M src/op=
envpn/ssl_verify.h<br>4 files changed, 42 insertions(+), 7 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex a673ec1..a2d3fd1 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -2705,6 +2705,12 @=
@</span><br><span>     if (!multi-&gt;locked_original_username</span><br><s=
pan>         &amp;&amp; strcmp(multi-&gt;locked_username, options-&gt;overr=
ide_username) !=3D 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* Check if the username length is accepta=
ble */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
ssl_verify_username_length(session, options-&gt;override_username))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         multi-&gt;locke=
d_original_username =3D multi-&gt;locked_username;</span><br><span>        =
 multi-&gt;locked_username =3D strdup(options-&gt;override_username);</span=
><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/openv=
pn/options.c</span><br><span>index 6605a42..96119c4 100644</span><br><span>=
--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</sp=
an><br><span>@@ -7880,10 +7880,10 @@</span><br><span>     else if (streq(p[=
0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span>=
<br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strlen(p=
[1]) &gt; TLS_USERNAME_LEN)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (strlen(p[1]) &gt; USER_PASS_LEN)</span><br><span>      =
   {</span><br><span>             msg(msglevel, &quot;override-username exc=
eeds the maximum length of %d &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                &quot;characters&quot;, TLS_USERNAME_LEN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot=
;characters&quot;, USER_PASS_LEN);</span><br><span> </span><br><span>      =
       /* disable the connection since ignoring the request to</span><br><s=
pan>              * set another username might cause serious problems */</s=
pan><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verif=
y.c</span><br><span>index 5f8f1d3..d2cc3d1 100644</span><br><span>--- a/src=
/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span>=
<br><span>@@ -1568,6 +1568,24 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_userna=
me_length(struct tls_session *session, const char *username)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_US=
ERNAME_AS_COMMON_NAME)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; strlen(username) &gt; TLS_USERNAME_LEN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;TLS Auth Error: --usern=
ame-as-common name specified and &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;username is longer than the maximum p=
ermitted Common Name &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;length of %d characters&quot;, TLS_USERNAME_LEN);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * Main username/password verification entry po=
int</span><br><span>  *</span><br><span>@@ -1689,15 +1707,12 @@</span><br><=
span>     }</span><br><span> </span><br><span>     /* check sizing of usern=
ame if it will become our common name */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNA=
ME_AS_COMMON_NAME)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     &amp;&amp; strlen(up-&gt;username)&gt;TLS_USERNAME_LEN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!ssl_verify_username_lengt=
h(session, up-&gt;username))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            &quot;TLS Auth Error: --use=
rname-as-common name specified and username is longer than the maximum perm=
itted Common Name length of %d characters&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            TLS_USERNAME_LEN);</span><br><span> =
        plugin_status =3D OPENVPN_PLUGIN_FUNC_ERROR;</span><br><span>      =
   script_status =3D OPENVPN_PLUGIN_FUNC_ERROR;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*=
 auth succeeded? */</span><br><span>     bool plugin_ok =3D plugin_status =
=3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS</span><br><span>                      ||=
 plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;</span><br><span>diff --=
git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br><span>i=
ndex eba3832..7a4d44a 100644</span><br><span>--- a/src/openvpn/ssl_verify.h=
</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -192,6 +=
192,20 @@</span><br><span>                       struct tls_session *sessio=
n);</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Checks if the username length is valid to use.  This checks when</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * username-as-common-n=
ame is active if the username is shorter than</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * the maximum TLS common name length (64).</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * It will also display an error message =
if the name is too long</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ses=
sion       current TLS session</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param username      username to check</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return              true if name is u=
nder limit or username-as-common-name</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                      is not active</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool ssl_verify_username_length(struct tls_session *ses=
sion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  const char *username);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Runs the --client-crresponse script if one is defi=
ned.</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/913?usp=3Demail">change 913</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/913?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c2c050dd160746a0f8d9c234ab=
e1e258bc8e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 913 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--s+WLFhHwccM=--

