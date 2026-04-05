From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:38 +0000
References: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3ff0d12457275f34d3655800a22c9f0d9ddedc76-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7RqzlB9d31U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Clarify operator
 precedence in a & b ? c : d
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

--7RqzlB9d31U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail

to review the following change.


Change subject: Clarify operator precedence in a & b ? c : d
......................................................................

Clarify operator precedence in a & b ? c : d

As suggested by cppcheck.

Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/error.h
M src/openvpn/options.c
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
4 files changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1619/1

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 62389af..03d880f 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -399,7 +399,7 @@
 static inline msglvl_t
 nonfatal(const msglvl_t err)
 {
-    return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
+    return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;
 }

 static inline int
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 186b2d2..e4905c9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7043,12 +7043,12 @@
         if (options->routes->flags & RG_REROUTE_GW)
         {
             setenv_int(es, "route_redirect_gateway_ipv4",
-                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+                       (options->routes->flags & RG_BLOCK_LOCAL) ? 2 : 1);
         }
         if (options->routes_ipv6 && (options->routes_ipv6->flags & RG_RERO=
UTE_GW))
         {
             setenv_int(es, "route_redirect_gateway_ipv6",
-                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+                       (options->routes->flags & RG_BLOCK_LOCAL) ? 2 : 1);
         }
 #ifdef _WIN32
         /* we need this here to handle pushed --redirect-gateway */
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index f60e2f2..7fc8c14 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -276,7 +276,7 @@

         const WCHAR *mesg[] =3D { msg[0], msg[1] };
         ReportEvent(hEventSource,
-                    flags & MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTL=
OG_INFORMATION_TYPE,
+                    (flags & MSG_FLAGS_ERROR) ? EVENTLOG_ERROR_TYPE : EVEN=
TLOG_INFORMATION_TYPE,
                     0,
                     EVT_TEXT_2,
                     NULL,
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a2f9f09..ace25b9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3410,7 +3410,7 @@
     ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
     ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;
     ea[0].Trustee.ptstrName =3D (LPWSTR)svc_user->User.Sid;
-    ea[1].grfAccessPermissions =3D READ_CONTROL | SYNCHRONIZE | PROCESS_VM=
_READ | SYNCHRONIZE
+    ea[1].grfAccessPermissions =3D READ_CONTROL | PROCESS_VM_READ | SYNCHR=
ONIZE
                                  | PROCESS_TERMINATE | PROCESS_QUERY_INFOR=
MATION;
     ea[1].grfAccessMode =3D SET_ACCESS;
     ea[1].grfInheritance =3D NO_INHERITANCE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Gerrit-Change-Number: 1619
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7RqzlB9d31U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Clarify operator precedence in a &amp; b ? =
c : d<br><br>As suggested by cppcheck.<br><br>Change-Id: Ia153e0de888c0ee21=
199b192f3471ce4c08cb5c7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>---<br>M src/openvpn/error.h<br>M src/openvpn/options.c<br>M s=
rc/openvpnserv/common.c<br>M src/openvpnserv/interactive.c<br>4 files chang=
ed, 5 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/19/1619/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/error.h b/src/openvpn/error.h</span><br><span>index 62389=
af..03d880f 100644</span><br><span>--- a/src/openvpn/error.h</span><br><spa=
n>+++ b/src/openvpn/error.h</span><br><span>@@ -399,7 +399,7 @@</span><br><=
span> static inline msglvl_t</span><br><span> nonfatal(const msglvl_t err)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return err &amp; M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return (err &amp; M_FATAL) =
? (err ^ M_FATAL) | M_NONFATAL : err;</span><br><span> }</span><br><span> <=
/span><br><span> static inline int</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index 186b2d2..e4905c9 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -7043,12 +7043,12 @@</span><br><span>=
         if (options-&gt;routes-&gt;flags &amp; RG_REROUTE_GW)</span><br><s=
pan>         {</span><br><span>             setenv_int(es, &quot;route_redi=
rect_gateway_ipv4&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                       options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL=
 ? 2 : 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              (options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL) ? 2 : 1);=
</span><br><span>         }</span><br><span>         if (options-&gt;routes=
_ipv6 &amp;&amp; (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW))</=
span><br><span>         {</span><br><span>             setenv_int(es, &quot=
;route_redirect_gateway_ipv6&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                       options-&gt;routes-&gt;flags &amp; RG_=
BLOCK_LOCAL ? 2 : 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                       (options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL=
) ? 2 : 1);</span><br><span>         }</span><br><span> #ifdef _WIN32</span=
><br><span>         /* we need this here to handle pushed --redirect-gatewa=
y */</span><br><span>diff --git a/src/openvpnserv/common.c b/src/openvpnser=
v/common.c</span><br><span>index f60e2f2..7fc8c14 100644</span><br><span>--=
- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openvpnserv/common.c=
</span><br><span>@@ -276,7 +276,7 @@</span><br><span> </span><br><span>    =
     const WCHAR *mesg[] =3D { msg[0], msg[1] };</span><br><span>         R=
eportEvent(hEventSource,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    flags &amp; MSG_FLAGS_ERROR ? EVENTLOG_ERROR_TYPE : =
EVENTLOG_INFORMATION_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    (flags &amp; MSG_FLAGS_ERROR) ? EVENTLOG_ERROR_T=
YPE : EVENTLOG_INFORMATION_TYPE,</span><br><span>                     0,</s=
pan><br><span>                     EVT_TEXT_2,</span><br><span>            =
         NULL,</span><br><span>diff --git a/src/openvpnserv/interactive.c b=
/src/openvpnserv/interactive.c</span><br><span>index a2f9f09..ace25b9 10064=
4</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b=
/src/openvpnserv/interactive.c</span><br><span>@@ -3410,7 +3410,7 @@</span>=
<br><span>     ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;</span><br><spa=
n>     ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;</span><br><span>  =
   ea[0].Trustee.ptstrName =3D (LPWSTR)svc_user-&gt;User.Sid;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ea[1].grfAccessPermissions =3D =
READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ | SYNCHRONIZE</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ea[1].grfAccessPermissions =3D R=
EAD_CONTROL | PROCESS_VM_READ | SYNCHRONIZE</span><br><span>               =
                   | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;</span><=
br><span>     ea[1].grfAccessMode =3D SET_ACCESS;</span><br><span>     ea[1=
].grfInheritance =3D NO_INHERITANCE;</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Dem=
ail">change 1619</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia153e0de888c0ee21199b192f34=
71ce4c08cb5c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1619 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7RqzlB9d31U=--

