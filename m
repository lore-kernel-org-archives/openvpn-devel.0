From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 18:53:54 +0000
References: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6ba107a223071d18cba451f8c3cdf23c5861accf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZVnZNRAJ708="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZVnZNRAJ708=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail

to review the following change.


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
---
M src/openvpn/misc.c
1 file changed, 17 insertions(+), 19 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1599/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc
Gerrit-Change-Number: 1599
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ZVnZNRAJ708=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Inlined credentials: read missing password =
from management interface<br><br>When commit 39619b7fab added support for i=
nlining username only,<br>fallback for password was from console. This is n=
ot ideal when<br>graphical UI is in use as there is no console. Instead, qu=
ery the<br>management interface when possible.<br><br>This patch just exten=
ds a similar fix when username is read from<br>a file and password is missi=
ng. As before, any username read<br>from file or inlined is not peserved as=
 we currently have no way<br>of locking the username in the management inte=
rface prompt.<br><br>Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc<b=
r>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/op=
envpn/misc.c<br>1 file changed, 17 insertions(+), 19 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/99/1599/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<=
/span><br><span>index c00a3ce..979293f 100644</span><br><span>--- a/src/ope=
nvpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -30=
5,24 +305,6 @@</span><br><span>                 {</span><br><span>         =
            strncpy(up-&gt;password, password_buf, USER_PASS_LEN);</span><b=
r><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                /* The auth-file does not have the password: get both =
username</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
    * and password from the management interface if possible.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 * Otherwise set to=
 read password from console.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                 */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(ENABLE_MANAGEMENT)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                else if (management &amp;&amp; (flags &amp; G=
ET_USER_PASS_MANAGEMENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                         &amp;&amp; management_query_user_pass_enabled(m=
anagement))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      msg(D_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   &quot;No password found in %s authfile &#39;%s&#39;. Que=
rying the management interface&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        prefix, auth_file);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    if (!auth_user_pa=
ss_mgmt(up, prefix, flags, auth_challenge))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        fclose(fp);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>    =
             else</span><br><span>                 {</span><br><span>      =
               password_from_stdin =3D 1;</span><br><span>@@ -348,7 +330,23=
 @@</span><br><span>         if (username_from_stdin || password_from_stdin=
 || response_from_stdin)</span><br><span>         {</span><br><span> #ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (auth_challenge &amp;&amp; (flags &amp; GET_USER_PASS_DYNAMIC_C=
HALLENGE) &amp;&amp; response_from_stdin)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* If management-query-passwords is true,=
 we could be here because</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             * of no password present in auth-file or inline. In that=
 case</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             *=
 query via the management interface instead of stdin/console.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (management &amp;&amp;=
 (flags &amp; GET_USER_PASS_MANAGEMENT)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                &amp;&amp; management_query_user_pass_e=
nabled(management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &amp;&amp; !(flags &amp; GET_USER_PASS_USERNAME_ONLY))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;No &#39;%s&#39; password found in authfile or inline. Querying the manage=
ment interface&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    prefix);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (!auth_user_pass_mgmt(up, prefix, flags, auth=
_challenge))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else if (auth_challenge &amp;&amp; (flags &amp; GET_USER_PASS_DYNA=
MIC_CHALLENGE) &amp;&amp; response_from_stdin)</span><br><span>            =
 {</span><br><span>                 struct auth_challenge_info *ac =3D pars=
e_auth_challenge(auth_challenge, &amp;gc);</span><br><span>                =
 if (ac)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail">change 1599</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1599?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieeb2f980330d485739dbf3d722f=
107c1dbf704fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1599 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ZVnZNRAJ708=--

