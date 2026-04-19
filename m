From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 14:09:07 +0000
In-Reply-To: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
References: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <fdfcee1082bbbd856896d2dcf7fbd7543f3e03c0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nLVCKFVNQZQ="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nLVCKFVNQZQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1599/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc
Gerrit-Change-Number: 1599
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nLVCKFVNQZQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Inlined credentials: read missi=
ng password from management interface<br><br>When commit 39619b7fab added s=
upport for inlining username only,<br>fallback for password was from consol=
e. This is not ideal when<br>graphical UI is in use as there is no console.=
 Instead, query the<br>management interface when possible.<br><br>This patc=
h just extends a similar fix when username is read from<br>a file and passw=
ord is missing. As before, any username read<br>from file or inlined is not=
 peserved as we currently have no way<br>of locking the username in the man=
agement interface prompt.<br><br>Change-Id: Ieeb2f980330d485739dbf3d722f107=
c1dbf704fc<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1599<br>Message-Id: &lt;20260414055900.17132=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg36608.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/misc.c<br>1 file changed, 17 inserti=
ons(+), 19 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/99/1599/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/misc.c b/src/openvpn/misc.c</span><br><span>index c00a3ce..979293f 100=
644</span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/open=
vpn/misc.c</span><br><span>@@ -305,24 +305,6 @@</span><br><span>           =
      {</span><br><span>                     strncpy(up-&gt;password, passw=
ord_buf, USER_PASS_LEN);</span><br><span>                 }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                /* The auth-file does=
 not have the password: get both username</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 * and password from the management int=
erface if possible.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               * Otherwise set to read password from console.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_MANAGEMENT)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                else if (man=
agement &amp;&amp; (flags &amp; GET_USER_PASS_MANAGEMENT)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         &amp;&amp; man=
agement_query_user_pass_enabled(management))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    msg(D_LOW,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        &quot;No password found=
 in %s authfile &#39;%s&#39;. Querying the management interface&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        pr=
efix, auth_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    fclose(fp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  return false;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span>                 else</span><br><span>        =
         {</span><br><span>                     password_from_stdin =3D 1;<=
/span><br><span>@@ -348,7 +330,23 @@</span><br><span>         if (username_=
from_stdin || password_from_stdin || response_from_stdin)</span><br><span> =
        {</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (auth_challenge &amp;&amp; (=
flags &amp; GET_USER_PASS_DYNAMIC_CHALLENGE) &amp;&amp; response_from_stdin=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* If =
management-query-passwords is true, we could be here because</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * of no password pres=
ent in auth-file or inline. In that case</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * query via the management interface inst=
ead of stdin/console.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (management &amp;&amp; (flags &amp; GET_USER_PASS_MANAGEMENT)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp=
;&amp; management_query_user_pass_enabled(management)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; !(flags &amp; =
GET_USER_PASS_USERNAME_ONLY))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                msg(D_LOW,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    &quot;No &#39;%s&#39; password found in auth=
file or inline. Querying the management interface&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    prefix);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (!auth_use=
r_pass_mgmt(up, prefix, flags, auth_challenge))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else if (auth_challenge &amp;=
&amp; (flags &amp; GET_USER_PASS_DYNAMIC_CHALLENGE) &amp;&amp; response_fro=
m_stdin)</span><br><span>             {</span><br><span>                 st=
ruct auth_challenge_info *ac =3D parse_auth_challenge(auth_challenge, &amp;=
gc);</span><br><span>                 if (ac)</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1599=
?usp=3Demail">change 1599</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1599?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--nLVCKFVNQZQ=--

