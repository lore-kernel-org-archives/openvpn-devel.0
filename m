From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 18:18:42 +0000
In-Reply-To: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
References: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <15ceb86bdcf5982daecc5a6610d75433c94258cb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BEn6XyzazWo="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BEn6XyzazWo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/906?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250415155131.12458-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
435.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.h
M src/openvpnserv/validate.c
M src/openvpnserv/validate.h
5 files changed, 25 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/906/5

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
index 3cefcc7..f06d386 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3410,7 +3410,7 @@
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
index 23d78af..9f176c0 100644
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
L"NT SERVICE") =3D=3D 0))
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
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--BEn6XyzazWo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/906?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">win: allow OpenVPN service account to use any comman=
d-line options<br><br>Since 2.7, OpenVPN service (used to start persistent =
connections)<br>runs under limited virtual service account NT SERVICE\OpenV=
PNService.<br><br>Since it should be able to use all command-line options<b=
r>and cannot be made member of &quot;OpenVPN Administrators&quot; group,<br=
>it has to be handled separately.<br><br>Change-Id: I44d308301dfb7c22600d86=
32a553288f52b3068f<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202504151=
55131.12458-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg31435.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/common.c<br>M src/ope=
nvpnserv/interactive.c<br>M src/openvpnserv/service.h<br>M src/openvpnserv/=
validate.c<br>M src/openvpnserv/validate.h<br>5 files changed, 25 insertion=
s(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/06/906/5</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/common.c b/s=
rc/openvpnserv/common.c</span><br><span>index 39b39aa..4a11e6c 100644</span=
><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openvpn=
serv/common.c</span><br><span>@@ -130,6 +130,14 @@</span><br><span>     {</=
span><br><span>         goto out;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    error =3D GetRegString(key, L&quot;ovpn_service_user&=
quot;, s-&gt;ovpn_service_user,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         sizeof(s-&gt;ovpn_service_user), OVPN_=
SERVICE_USER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (error !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 /* set process priority */</span><br><span>     if (!_wcsicmp(priority, L&=
quot;IDLE_PRIORITY_CLASS&quot;))</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</sp=
an><br><span>index 3cefcc7..f06d386 100644</span><br><span>--- a/src/openvp=
nserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</sp=
an><br><span>@@ -3410,7 +3410,7 @@</span><br><span>      * OR user is autho=
rized to run any config.</span><br><span>      */</span><br><span>     if (=
!ValidateOptions(pipe, sud.directory, sud.options, errmsg, _countof(errmsg)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !=
IsAuthorizedUser(ovpn_user-&gt;User.Sid, imp_token, settings.ovpn_admin_gro=
up))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; !IsAuthorizedUser(ovpn_user-&gt;User.Sid, imp_token, settings.ovpn_admi=
n_group, settings.ovpn_service_user))</span><br><span>     {</span><br><spa=
n>         ReturnError(pipe, ERROR_STARTUP_DATA, errmsg, 1, &amp;exit_event=
);</span><br><span>         goto out;</span><br><span>diff --git a/src/open=
vpnserv/service.h b/src/openvpnserv/service.h</span><br><span>index 7112f26=
..cbe213b 100644</span><br><span>--- a/src/openvpnserv/service.h</span><br>=
<span>+++ b/src/openvpnserv/service.h</span><br><span>@@ -66,6 +66,7 @@</sp=
an><br><span>     WCHAR ext_string[16];</span><br><span>     WCHAR log_dir[=
MAX_PATH];</span><br><span>     WCHAR ovpn_admin_group[MAX_NAME];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR ovpn_service_user[M=
AX_NAME];</span><br><span>     DWORD priority;</span><br><span>     BOOL ap=
pend;</span><br><span> } settings_t;</span><br><span>diff --git a/src/openv=
pnserv/validate.c b/src/openvpnserv/validate.c</span><br><span>index 23d78a=
f..9f176c0 100644</span><br><span>--- a/src/openvpnserv/validate.c</span><b=
r><span>+++ b/src/openvpnserv/validate.c</span><br><span>@@ -140,12 +140,8 =
@@</span><br><span>     return b;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Check whether user is a member of Admini=
strators group or</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * t=
he group specified in ovpn_admin_group</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span> BOOL</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-IsAuthorizedUser(PSID sid, const HANDLE token, const W=
CHAR *ovpn_admin_group)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_=
group, const WCHAR *ovpn_service_user)</span><br><span> {</span><br><span> =
    const WCHAR *admin_group[2];</span><br><span>     WCHAR username[MAX_NA=
ME];</span><br><span>@@ -164,6 +160,12 @@</span><br><span>         domain[0=
] =3D &#39;\0&#39;;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* is this service account? */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((wcscmp(use=
rname, ovpn_service_user) =3D=3D 0) &amp;&amp; (wcscmp(domain, L&quot;NT SE=
RVICE&quot;) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     i=
f (GetBuiltinAdminGroupName(sysadmin_group, _countof(sysadmin_group)))</spa=
n><br><span>     {</span><br><span>         admin_group[0] =3D sysadmin_gro=
up;</span><br><span>diff --git a/src/openvpnserv/validate.h b/src/openvpnse=
rv/validate.h</span><br><span>index 61a0ad6..5cd6d16 100644</span><br><span=
>--- a/src/openvpnserv/validate.h</span><br><span>+++ b/src/openvpnserv/val=
idate.h</span><br><span>@@ -29,11 +29,16 @@</span><br><span> </span><br><sp=
an> /* Authorized groups who can use any options and config locations */</s=
pan><br><span> #define SYSTEM_ADMIN_GROUP L&quot;Administrators&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_ADMIN_GROUP L&=
quot;OpenVPN Administrators&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* The last one may be reset in registry: HKLM\Software\OpenVPN=
\ovpn_admin_group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OVPN_ADMIN_GROUP L&quot;OpenVPN Administrators&quot; /* may be set=
 in HKLM\Software\OpenVPN\ovpn_admin_group */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OVPN_SERVICE_USER L&quot;OpenVPNService&q=
uot; /* may be set in HKLM\Software\OpenVPN\ovpn_service_user */</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether user is a me=
mber of Administrators group or</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * the group specified in ovpn_admin_group or</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN Virtual Service Account us=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an> BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsAuthorizedU=
ser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+IsAuthorizedUser(PSID sid, co=
nst HANDLE token, const WCHAR *ovpn_admin_group, const WCHAR *ovpn_service_=
user);</span><br><span> </span><br><span> BOOL</span><br><span> CheckOption=
(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/906?usp=3Demail">change 906</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/906?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d308301dfb7c22600d8632a55=
3288f52b3068f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 906 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--BEn6XyzazWo=--

