From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Feb 2025 07:06:27 +0000
References: <gerrit.1739948782000.I1a9738ad73c79661a8beb4d9881eba0b4d3aea53@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c2ae93f0fdee12efd26a9c9dd0cfb345e7cf47c3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y4tjS8Z26Wo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: add more (void) to
 windows specific function prototypes and declarations
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

--y4tjS8Z26Wo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/899?usp=3Demail

to review the following change.


Change subject: add more (void) to windows specific function prototypes and=
 declarations
......................................................................

add more (void) to windows specific function prototypes and declarations

Change-Id: I1a9738ad73c79661a8beb4d9881eba0b4d3aea53
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/win32.c
M src/openvpnserv/common.c
M src/openvpnserv/service.c
M src/openvpnserv/service.h
4 files changed, 6 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/899/1

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 86556a8..edac71e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -103,7 +103,7 @@
  * Set OpenSSL environment variables to a safe directory
  */
 static void
-set_openssl_env_vars();
+set_openssl_env_vars(void);
=20
 void
 init_win32(void)
@@ -1518,7 +1518,7 @@
 }

 static void
-set_openssl_env_vars()
+set_openssl_env_vars(void)
 {
     const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\System32";

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index a88a724..74bec6e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -181,7 +181,7 @@


 LPCTSTR
-GetLastErrorText()
+GetLastErrorText(void)
 {
     DWORD error;
     static TCHAR buf[256];
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 054fc5f..84fd11a 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -54,7 +54,7 @@
 }

 static int
-CmdInstallServices()
+CmdInstallServices(void)
 {
     SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
@@ -146,7 +146,7 @@


 static int
-CmdRemoveServices()
+CmdRemoveServices(void)
 {
     SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index da20433..c5f587b 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -86,7 +86,7 @@

 BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *st=
atus);

-LPCTSTR GetLastErrorText();
+LPCTSTR GetLastErrorText(void);

 DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/899?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a9738ad73c79661a8beb4d9881eba0b4d3aea53
Gerrit-Change-Number: 899
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--y4tjS8Z26Wo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/899?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">add more (void) to windows specific function prototypes and d=
eclarations<br><br>Change-Id: I1a9738ad73c79661a8beb4d9881eba0b4d3aea53<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
/win32.c<br>M src/openvpnserv/common.c<br>M src/openvpnserv/service.c<br>M =
src/openvpnserv/service.h<br>4 files changed, 6 insertions(+), 6 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/9=
9/899/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</spa=
n><br><span>index 86556a8..edac71e 100644</span><br><span>--- a/src/openvpn=
/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -103,=
7 +103,7 @@</span><br><span>  * Set OpenSSL environment variables to a safe=
 directory</span><br><span>  */</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-set_openssl_env_vars();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+set_openssl_env_vars(void);</spa=
n><br><span> </span><br><span> void</span><br><span> init_win32(void)</span=
><br><span>@@ -1518,7 +1518,7 @@</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-set_openssl_env_vars()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+set_openssl_env_vars(void)</span><br><span> {</span><br><span>     con=
st WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System32&quot;;</span><b=
r><span> </span><br><span>diff --git a/src/openvpnserv/common.c b/src/openv=
pnserv/common.c</span><br><span>index a88a724..74bec6e 100644</span><br><sp=
an>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openvpnserv/com=
mon.c</span><br><span>@@ -181,7 +181,7 @@</span><br><span> </span><br><span=
> </span><br><span> LPCTSTR</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-GetLastErrorText()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+GetLastErrorText(void)</span><br><span> {</span><br><span>     DWORD e=
rror;</span><br><span>     static TCHAR buf[256];</span><br><span>diff --gi=
t a/src/openvpnserv/service.c b/src/openvpnserv/service.c</span><br><span>i=
ndex 054fc5f..84fd11a 100644</span><br><span>--- a/src/openvpnserv/service.=
c</span><br><span>+++ b/src/openvpnserv/service.c</span><br><span>@@ -54,7 =
+54,7 @@</span><br><span> }</span><br><span> </span><br><span> static int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-CmdInstallServices()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+CmdInstallServices(voi=
d)</span><br><span> {</span><br><span>     SC_HANDLE service;</span><br><sp=
an>     SC_HANDLE svc_ctl_mgr;</span><br><span>@@ -146,7 +146,7 @@</span><b=
r><span> </span><br><span> </span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-CmdRemoveServices()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CmdRemoveServices(void)</span><br><span> =
{</span><br><span>     SC_HANDLE service;</span><br><span>     SC_HANDLE sv=
c_ctl_mgr;</span><br><span>diff --git a/src/openvpnserv/service.h b/src/ope=
nvpnserv/service.h</span><br><span>index da20433..c5f587b 100644</span><br>=
<span>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/openvpnserv=
/service.h</span><br><span>@@ -86,7 +86,7 @@</span><br><span> </span><br><s=
pan> BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS=
 *status);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-LPCTSTR GetLastErrorText();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+LPCTSTR GetLastErrorText(void);</span><br><span> </span><br>=
<span> DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);</span><br><s=
pan> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/899?usp=3Demail">change 899</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/899?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a9738ad73c79661a8beb4d9881=
eba0b4d3aea53 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 899 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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


--y4tjS8Z26Wo=--

