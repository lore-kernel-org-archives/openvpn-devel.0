From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 12 Mar 2025 11:54:45 +0000
References: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9128b360c98a50df91605a7af5b6cd0365d7f63d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d14SRrWASOE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win: allow OpenVPN
 service account to use any command-line options
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

--d14SRrWASOE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail

to review the following change.


Change subject: win: allow OpenVPN service account to use any command-line =
options
......................................................................

win: allow OpenVPN service account to use any command-line options

Since 2.7, OpenVPN service (used to start persistent connections)
runs under limited virtual service account NT SERVICE\OpenVPNService.

Since it should be able to use all command-line options
and cannot be made member of "OpenVPN Administrators" group,
it has to be handled separately.

Change-Id: I44d308301dfb7c22600d8632a553288f52b3068f
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.h
M src/openvpnserv/validate.c
M src/openvpnserv/validate.h
5 files changed, 26 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/906/1

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 74bec6e..658e5cd 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -130,6 +130,14 @@
     {
         goto out;
     }
+
+    error =3D GetRegString(key, TEXT("ovpn_service_user"), s->ovpn_service=
_user,
+                         sizeof(s->ovpn_service_user), OVPN_SERVICE_USER);
+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
     /* set process priority */
     if (!_wcsicmp(priority, TEXT("IDLE_PRIORITY_CLASS")))
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d5a749a..2364c38 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2497,7 +2497,7 @@
      * OR user is authorized to run any config.
      */
     if (!ValidateOptions(pipe, sud.directory, sud.options, errmsg, _counto=
f(errmsg))
-        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn=
_admin_group))
+        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn=
_admin_group, settings.ovpn_service_user))
     {
         ReturnError(pipe, ERROR_STARTUP_DATA, errmsg, 1, &exit_event);
         goto out;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index c5f587b..c8c1005 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -71,6 +71,7 @@
     TCHAR ext_string[16];
     TCHAR log_dir[MAX_PATH];
     TCHAR ovpn_admin_group[MAX_NAME];
+    TCHAR ovpn_service_user[MAX_NAME];
     DWORD priority;
     BOOL append;
 } settings_t;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9563fa5..5b0b368 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -140,12 +140,8 @@
     return b;
 }

-/*
- * Check whether user is a member of Administrators group or
- * the group specified in ovpn_admin_group
- */
 BOOL
-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_gro=
up)
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_gro=
up, const WCHAR *ovpn_service_user)
 {
     const WCHAR *admin_group[2];
     WCHAR username[MAX_NAME];
@@ -164,6 +160,12 @@
         domain[0] =3D '\0';
     }

+    /* is this service account? */
+    if ((wcscmp(username, ovpn_service_user) =3D=3D 0) && (wcscmp(domain, =
TEXT("NT SERVICE")) =3D=3D 0))
+    {
+        return TRUE;
+    }
+
     if (GetBuiltinAdminGroupName(sysadmin_group, _countof(sysadmin_group)))
     {
         admin_group[0] =3D sysadmin_group;
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index a9f1b9d..a68e564 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -29,11 +29,17 @@

 /* Authorized groups who can use any options and config locations */
 #define SYSTEM_ADMIN_GROUP TEXT("Administrators")
-#define OVPN_ADMIN_GROUP TEXT("OpenVPN Administrators")
-/* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin=
_group */

+#define OVPN_ADMIN_GROUP TEXT("OpenVPN Administrators") /* may be set in H=
KLM\Software\OpenVPN\ovpn_admin_group */
+#define OVPN_SERVICE_USER TEXT("OpenVPNService") /* may be set in HKLM\Sof=
tware\OpenVPN\ovpn_service_user */
+
+/*
+ * Check whether user is a member of Administrators group or
+ * the group specified in ovpn_admin_group or
+ * OpenVPN Virtual Service Account user
+ */
 BOOL
-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_gro=
up);
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_gro=
up, const WCHAR *ovpn_service_user);

 BOOL
 CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_=
t *s);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I44d308301dfb7c22600d8632a553288f52b3068f
Gerrit-Change-Number: 906
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--d14SRrWASOE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">win: allow OpenVPN service account to use any command-line op=
tions<br><br>Since 2.7, OpenVPN service (used to start persistent connectio=
ns)<br>runs under limited virtual service account NT SERVICE\OpenVPNService=
.<br><br>Since it should be able to use all command-line options<br>and can=
not be made member of &quot;OpenVPN Administrators&quot; group,<br>it has t=
o be handled separately.<br><br>Change-Id: I44d308301dfb7c22600d8632a553288=
f52b3068f<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M =
src/openvpnserv/common.c<br>M src/openvpnserv/interactive.c<br>M src/openvp=
nserv/service.h<br>M src/openvpnserv/validate.c<br>M src/openvpnserv/valida=
te.h<br>5 files changed, 26 insertions(+), 9 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/906/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><spa=
n>index 74bec6e..658e5cd 100644</span><br><span>--- a/src/openvpnserv/commo=
n.c</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -130,=
6 +130,14 @@</span><br><span>     {</span><br><span>         goto out;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D GetReg=
String(key, TEXT(&quot;ovpn_service_user&quot;), s-&gt;ovpn_service_user,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    sizeof(s-&gt;ovpn_service_user), OVPN_SERVICE_USER);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     /* set process priority */</span=
><br><span>     if (!_wcsicmp(priority, TEXT(&quot;IDLE_PRIORITY_CLASS&quot=
;)))</span><br><span>     {</span><br><span>diff --git a/src/openvpnserv/in=
teractive.c b/src/openvpnserv/interactive.c</span><br><span>index d5a749a..=
2364c38 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><b=
r><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2497,7 +249=
7,7 @@</span><br><span>      * OR user is authorized to run any config.</sp=
an><br><span>      */</span><br><span>     if (!ValidateOptions(pipe, sud.d=
irectory, sud.options, errmsg, _countof(errmsg))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        &amp;&amp; !IsAuthorizedUser(ovpn_user-&=
gt;User.Sid, imp_token, settings.ovpn_admin_group))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !IsAuthorizedUser(ovpn=
_user-&gt;User.Sid, imp_token, settings.ovpn_admin_group, settings.ovpn_ser=
vice_user))</span><br><span>     {</span><br><span>         ReturnError(pip=
e, ERROR_STARTUP_DATA, errmsg, 1, &amp;exit_event);</span><br><span>       =
  goto out;</span><br><span>diff --git a/src/openvpnserv/service.h b/src/op=
envpnserv/service.h</span><br><span>index c5f587b..c8c1005 100644</span><br=
><span>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/openvpnser=
v/service.h</span><br><span>@@ -71,6 +71,7 @@</span><br><span>     TCHAR ex=
t_string[16];</span><br><span>     TCHAR log_dir[MAX_PATH];</span><br><span=
>     TCHAR ovpn_admin_group[MAX_NAME];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    TCHAR ovpn_service_user[MAX_NAME];</span><br><span>=
     DWORD priority;</span><br><span>     BOOL append;</span><br><span> } s=
ettings_t;</span><br><span>diff --git a/src/openvpnserv/validate.c b/src/op=
envpnserv/validate.c</span><br><span>index 9563fa5..5b0b368 100644</span><b=
r><span>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src/openvpns=
erv/validate.c</span><br><span>@@ -140,12 +140,8 @@</span><br><span>     re=
turn b;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Check whether user is a member of Administrators group or</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * the group specified in ovpn_a=
dmin_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span> BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsAutho=
rizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+IsAuthorizedUser(PSID si=
d, const HANDLE token, const WCHAR *ovpn_admin_group, const WCHAR *ovpn_ser=
vice_user)</span><br><span> {</span><br><span>     const WCHAR *admin_group=
[2];</span><br><span>     WCHAR username[MAX_NAME];</span><br><span>@@ -164=
,6 +160,12 @@</span><br><span>         domain[0] =3D &#39;\0&#39;;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* is this service account? */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if ((wcscmp(username, ovpn_service_user) =
=3D=3D 0) &amp;&amp; (wcscmp(domain, TEXT(&quot;NT SERVICE&quot;)) =3D=3D 0=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return TRUE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     if (GetBuiltinAdminGro=
upName(sysadmin_group, _countof(sysadmin_group)))</span><br><span>     {</s=
pan><br><span>         admin_group[0] =3D sysadmin_group;</span><br><span>d=
iff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h</span><=
br><span>index a9f1b9d..a68e564 100644</span><br><span>--- a/src/openvpnser=
v/validate.h</span><br><span>+++ b/src/openvpnserv/validate.h</span><br><sp=
an>@@ -29,11 +29,17 @@</span><br><span> </span><br><span> /* Authorized gro=
ups who can use any options and config locations */</span><br><span> #defin=
e SYSTEM_ADMIN_GROUP TEXT(&quot;Administrators&quot;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OVPN_ADMIN_GROUP TEXT(&quot;OpenVPN=
 Administrators&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin=
_group */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define OVPN_ADMIN_GROUP TEXT(&quot;OpenVPN Administrators&quot;) /=
* may be set in HKLM\Software\OpenVPN\ovpn_admin_group */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define OVPN_SERVICE_USER TEXT(&quot;=
OpenVPNService&quot;) /* may be set in HKLM\Software\OpenVPN\ovpn_service_u=
ser */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Check whether user is a member of Administrato=
rs group or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the g=
roup specified in ovpn_admin_group or</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * OpenVPN Virtual Service Account user</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> BOOL</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-IsAuthorizedUser(PSID sid, const =
HANDLE token, const WCHAR *ovpn_admin_group);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+IsAuthorizedUser(PSID sid, const HANDLE token, co=
nst WCHAR *ovpn_admin_group, const WCHAR *ovpn_service_user);</span><br><sp=
an> </span><br><span> BOOL</span><br><span> CheckOption(const WCHAR *workdi=
r, int narg, WCHAR *argv[], const settings_t *s);</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
906?usp=3Demail">change 906</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d308301dfb7c22600d8632a55=
3288f52b3068f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 906 </div>
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


--d14SRrWASOE=--

