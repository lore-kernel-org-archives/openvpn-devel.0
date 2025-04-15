From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 08:25:02 +0000
In-Reply-To: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
References: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <237116a4c15b805840b81cc011c659b6b5e0339a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XqHzhlACm0I="; charset=UTF-8
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

--XqHzhlACm0I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail

to look at the new patch set (#3).


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
5 files changed, 25 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/906/3

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 39b39aa..4a11e6c 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -130,6 +130,14 @@
     {
         goto out;
     }
+
+    error =3D GetRegString(key, L"ovpn_service_user", s->ovpn_service_user,
+                         sizeof(s->ovpn_service_user), OVPN_SERVICE_USER);
+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
     /* set process priority */
     if (!_wcsicmp(priority, L"IDLE_PRIORITY_CLASS"))
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c6963b3..871dc6a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2491,7 +2491,7 @@
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
index 7112f26..cbe213b 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -66,6 +66,7 @@
     WCHAR ext_string[16];
     WCHAR log_dir[MAX_PATH];
     WCHAR ovpn_admin_group[MAX_NAME];
+    WCHAR ovpn_service_user[MAX_NAME];
     DWORD priority;
     BOOL append;
 } settings_t;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 23d78af..98c96c8 100644
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
index 61a0ad6..5cd6d16 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -29,11 +29,16 @@

 /* Authorized groups who can use any options and config locations */
 #define SYSTEM_ADMIN_GROUP L"Administrators"
-#define OVPN_ADMIN_GROUP L"OpenVPN Administrators"
-/* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin=
_group */
+#define OVPN_ADMIN_GROUP L"OpenVPN Administrators" /* may be set in HKLM\S=
oftware\OpenVPN\ovpn_admin_group */
+#define OVPN_SERVICE_USER L"OpenVPNService" /* may be set in HKLM\Software=
\OpenVPN\ovpn_service_user */

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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--XqHzhlACm0I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">win: allow OpenVPN service account to use any command-line options<br><br=
>Since 2.7, OpenVPN service (used to start persistent connections)<br>runs =
under limited virtual service account NT SERVICE\OpenVPNService.<br><br>Sin=
ce it should be able to use all command-line options<br>and cannot be made =
member of &quot;OpenVPN Administrators&quot; group,<br>it has to be handled=
 separately.<br><br>Change-Id: I44d308301dfb7c22600d8632a553288f52b3068f<br=
>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpns=
erv/common.c<br>M src/openvpnserv/interactive.c<br>M src/openvpnserv/servic=
e.h<br>M src/openvpnserv/validate.c<br>M src/openvpnserv/validate.h<br>5 fi=
les changed, 25 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/06/906/3</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><span>index 39b3=
9aa..4a11e6c 100644</span><br><span>--- a/src/openvpnserv/common.c</span><b=
r><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -130,6 +130,14 @@=
</span><br><span>     {</span><br><span>         goto out;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    error =3D GetRegString(key, =
L&quot;ovpn_service_user&quot;, s-&gt;ovpn_service_user,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                         sizeof(s-&gt;=
ovpn_service_user), OVPN_SERVICE_USER);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     /* set process priority */</span><br><span>     i=
f (!_wcsicmp(priority, L&quot;IDLE_PRIORITY_CLASS&quot;))</span><br><span> =
    {</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/open=
vpnserv/interactive.c</span><br><span>index c6963b3..871dc6a 100644</span><=
br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/open=
vpnserv/interactive.c</span><br><span>@@ -2491,7 +2491,7 @@</span><br><span=
>      * OR user is authorized to run any config.</span><br><span>      */<=
/span><br><span>     if (!ValidateOptions(pipe, sud.directory, sud.options,=
 errmsg, _countof(errmsg))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &amp;&amp; !IsAuthorizedUser(ovpn_user-&gt;User.Sid, imp_token=
, settings.ovpn_admin_group))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &amp;&amp; !IsAuthorizedUser(ovpn_user-&gt;User.Sid, imp_=
token, settings.ovpn_admin_group, settings.ovpn_service_user))</span><br><s=
pan>     {</span><br><span>         ReturnError(pipe, ERROR_STARTUP_DATA, e=
rrmsg, 1, &amp;exit_event);</span><br><span>         goto out;</span><br><s=
pan>diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h</spa=
n><br><span>index 7112f26..cbe213b 100644</span><br><span>--- a/src/openvpn=
serv/service.h</span><br><span>+++ b/src/openvpnserv/service.h</span><br><s=
pan>@@ -66,6 +66,7 @@</span><br><span>     WCHAR ext_string[16];</span><br>=
<span>     WCHAR log_dir[MAX_PATH];</span><br><span>     WCHAR ovpn_admin_g=
roup[MAX_NAME];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
WCHAR ovpn_service_user[MAX_NAME];</span><br><span>     DWORD priority;</sp=
an><br><span>     BOOL append;</span><br><span> } settings_t;</span><br><sp=
an>diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c</sp=
an><br><span>index 23d78af..98c96c8 100644</span><br><span>--- a/src/openvp=
nserv/validate.c</span><br><span>+++ b/src/openvpnserv/validate.c</span><br=
><span>@@ -140,12 +140,8 @@</span><br><span>     return b;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check whether use=
r is a member of Administrators group or</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * the group specified in ovpn_admin_group</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span> BOOL</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-IsAuthorizedUser(PSID sid, cons=
t HANDLE token, const WCHAR *ovpn_admin_group)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+IsAuthorizedUser(PSID sid, const HANDLE token, c=
onst WCHAR *ovpn_admin_group, const WCHAR *ovpn_service_user)</span><br><sp=
an> {</span><br><span>     const WCHAR *admin_group[2];</span><br><span>   =
  WCHAR username[MAX_NAME];</span><br><span>@@ -164,6 +160,12 @@</span><br>=
<span>         domain[0] =3D &#39;\0&#39;;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* is t=
his service account? */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if ((wcscmp(username, ovpn_service_user) =3D=3D 0) &amp;&amp; (wcsc=
mp(domain, TEXT(&quot;NT SERVICE&quot;)) =3D=3D 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return TRUE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if (GetBuiltinAdminGroupName(sysadmin_group, _=
countof(sysadmin_group)))</span><br><span>     {</span><br><span>         a=
dmin_group[0] =3D sysadmin_group;</span><br><span>diff --git a/src/openvpns=
erv/validate.h b/src/openvpnserv/validate.h</span><br><span>index 61a0ad6..=
5cd6d16 100644</span><br><span>--- a/src/openvpnserv/validate.h</span><br><=
span>+++ b/src/openvpnserv/validate.h</span><br><span>@@ -29,11 +29,16 @@</=
span><br><span> </span><br><span> /* Authorized groups who can use any opti=
ons and config locations */</span><br><span> #define SYSTEM_ADMIN_GROUP L&q=
uot;Administrators&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define OVPN_ADMIN_GROUP L&quot;OpenVPN Administrators&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* The last one may be reset in r=
egistry: HKLM\Software\OpenVPN\ovpn_admin_group */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define OVPN_ADMIN_GROUP L&quot;OpenVPN Admi=
nistrators&quot; /* may be set in HKLM\Software\OpenVPN\ovpn_admin_group */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_SERVIC=
E_USER L&quot;OpenVPNService&quot; /* may be set in HKLM\Software\OpenVPN\o=
vpn_service_user */</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Check whether user is a member of Administrators group or</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * the group specified in ovpn_ad=
min_group or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Open=
VPN Virtual Service Account user</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> BOOL</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR=
 *ovpn_admin_group);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_gro=
up, const WCHAR *ovpn_service_user);</span><br><span> </span><br><span> BOO=
L</span><br><span> CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[=
], const settings_t *s);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail">change 9=
06</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d308301dfb7c22600d8632a55=
3288f52b3068f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 906 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--XqHzhlACm0I=--

