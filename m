From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 14:09:11 +0000
In-Reply-To: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
References: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <fdfcee1082bbbd856896d2dcf7fbd7543f3e03c0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vk30QhZikGQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Inlined credentials:
 read missing password from management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vk30QhZikGQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
99?usp=3Demail )

Change subject: Inlined credentials: read missing password from management =
interface
......................................................................

Inlined credentials: read missing password from management interface

When commit 39619b7fab added support for inlining username only,
fallback for password was from console. This is not ideal when
graphical UI is in use as there is no console. Instead, query the
management interface when possible.

This patch just extends a similar fix when username is read from
a file and password is missing. As before, any username read
from file or inlined is not peserved as we currently have no way
of locking the username in the management interface prompt.

Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1599
Message-Id: <20260414055900.17132-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
608.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/misc.c
1 file changed, 17 insertions(+), 19 deletions(-)




diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index c00a3ce..979293f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -305,24 +305,6 @@
                 {
                     strncpy(up->password, password_buf, USER_PASS_LEN);
                 }
-                /* The auth-file does not have the password: get both user=
name
-                 * and password from the management interface if possible.
-                 * Otherwise set to read password from console.
-                 */
-#if defined(ENABLE_MANAGEMENT)
-                else if (management && (flags & GET_USER_PASS_MANAGEMENT)
-                         && management_query_user_pass_enabled(management))
-                {
-                    msg(D_LOW,
-                        "No password found in %s authfile '%s'. Querying t=
he management interface",
-                        prefix, auth_file);
-                    if (!auth_user_pass_mgmt(up, prefix, flags, auth_chall=
enge))
-                    {
-                        fclose(fp);
-                        return false;
-                    }
-                }
-#endif
                 else
                 {
                     password_from_stdin =3D 1;
@@ -348,7 +330,23 @@
         if (username_from_stdin || password_from_stdin || response_from_st=
din)
         {
 #ifdef ENABLE_MANAGEMENT
-            if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE=
) && response_from_stdin)
+            /* If management-query-passwords is true, we could be here bec=
ause
+             * of no password present in auth-file or inline. In that case
+             * query via the management interface instead of stdin/console.
+             */
+            if (management && (flags & GET_USER_PASS_MANAGEMENT)
+                && management_query_user_pass_enabled(management)
+                && !(flags & GET_USER_PASS_USERNAME_ONLY))
+            {
+                msg(D_LOW,
+                    "No '%s' password found in authfile or inline. Queryin=
g the management interface",
+                    prefix);
+                if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge=
))
+                {
+                    return false;
+                }
+            }
+            else if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHAL=
LENGE) && response_from_stdin)
             {
                 struct auth_challenge_info *ac =3D parse_auth_challenge(au=
th_challenge, &gc);
                 if (ac)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc
Gerrit-Change-Number: 1599
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vk30QhZikGQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1599?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Inlined credentials: read missing password from =
management interface<br><br>When commit 39619b7fab added support for inlini=
ng username only,<br>fallback for password was from console. This is not id=
eal when<br>graphical UI is in use as there is no console. Instead, query t=
he<br>management interface when possible.<br><br>This patch just extends a =
similar fix when username is read from<br>a file and password is missing. A=
s before, any username read<br>from file or inlined is not peserved as we c=
urrently have no way<br>of locking the username in the management interface=
 prompt.<br><br>Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc<br>Sig=
ned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwa=
be &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1599<br>Message-Id: &lt;20260414055900.17132-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg36608.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/misc.c<br>1 file changed, 17 insertions(+), 19 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>ind=
ex c00a3ce..979293f 100644</span><br><span>--- a/src/openvpn/misc.c</span><=
br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -305,24 +305,6 @@</spa=
n><br><span>                 {</span><br><span>                     strncpy=
(up-&gt;password, password_buf, USER_PASS_LEN);</span><br><span>           =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  /* The auth-file does not have the password: get both username</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                 * and password =
from the management interface if possible.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 * Otherwise set to read password from=
 console.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(EN=
ABLE_MANAGEMENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           else if (management &amp;&amp; (flags &amp; GET_USER_PASS_MANAGE=
MENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         &amp;&amp; management_query_user_pass_enabled(management))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    msg(D_LOW,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
&quot;No password found in %s authfile &#39;%s&#39;. Querying the managemen=
t interface&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     prefix, auth_file);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    if (!auth_user_pass_mgmt(up, prefix,=
 flags, auth_challenge))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        fclose(fp);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        return false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span>                 else</=
span><br><span>                 {</span><br><span>                     pass=
word_from_stdin =3D 1;</span><br><span>@@ -348,7 +330,23 @@</span><br><span=
>         if (username_from_stdin || password_from_stdin || response_from_s=
tdin)</span><br><span>         {</span><br><span> #ifdef ENABLE_MANAGEMENT<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (auth_c=
hallenge &amp;&amp; (flags &amp; GET_USER_PASS_DYNAMIC_CHALLENGE) &amp;&amp=
; response_from_stdin)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            /* If management-query-passwords is true, we could be here b=
ecause</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
* of no password present in auth-file or inline. In that case</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * query via the mana=
gement interface instead of stdin/console.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (management &amp;&amp; (flags &amp; GET_U=
SER_PASS_MANAGEMENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &amp;&amp; management_query_user_pass_enabled(management)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp=
;&amp; !(flags &amp; GET_USER_PASS_USERNAME_ONLY))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msg(D_LOW,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;No &#39;%s&#39;=
 password found in authfile or inline. Querying the management interface&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if =
(auth_challenge &amp;&amp; (flags &amp; GET_USER_PASS_DYNAMIC_CHALLENGE) &a=
mp;&amp; response_from_stdin)</span><br><span>             {</span><br><spa=
n>                 struct auth_challenge_info *ac =3D parse_auth_challenge(=
auth_challenge, &amp;gc);</span><br><span>                 if (ac)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1599?usp=3Demail">change 1599</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1599?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieeb2f980330d485739dbf3d722f=
107c1dbf704fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1599 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Vk30QhZikGQ=--

