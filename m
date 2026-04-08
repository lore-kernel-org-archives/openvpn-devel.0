From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 12:39:56 +0000
In-Reply-To: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
References: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <605980521e035331a4d70b2cc87d0adfd90226b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a9cTF/b8Duo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Clarify operator
 precedence in a & b ? c : d
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a9cTF/b8Duo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
19?usp=3Demail )

Change subject: Clarify operator precedence in a & b ? c : d
......................................................................

Clarify operator precedence in a & b ? c : d

As suggested by cppcheck.

Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1619
Message-Id: <20260407205235.31126-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
545.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/error.h
M src/openvpn/options.c
M src/openvpnserv/common.c
3 files changed, 4 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1198994..3b742d7 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -397,7 +397,7 @@
 static inline msglvl_t
 nonfatal(const msglvl_t err)
 {
-    return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
+    return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;
 }

 static inline int
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 713dcf4..b8d0f5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7044,12 +7044,12 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Gerrit-Change-Number: 1619
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a9cTF/b8Duo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1619?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Clarify operator precedence in a &amp; b ? c : d=
<br><br>As suggested by cppcheck.<br><br>Change-Id: Ia153e0de888c0ee21199b1=
92f3471ce4c08cb5c7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1619<br>Message-Id: &lt;20260407205235.31=
126-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg36545.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/error.h<br>M src/openvpn/options.=
c<br>M src/openvpnserv/common.c<br>3 files changed, 4 insertions(+), 4 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/error.h b/src/openvpn/error.h</span><br><span>i=
ndex 1198994..3b742d7 100644</span><br><span>--- a/src/openvpn/error.h</spa=
n><br><span>+++ b/src/openvpn/error.h</span><br><span>@@ -397,7 +397,7 @@</=
span><br><span> static inline msglvl_t</span><br><span> nonfatal(const msgl=
vl_t err)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return err &amp; M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (err &amp;=
 M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;</span><br><span> }</span><b=
r><span> </span><br><span> static inline int</span><br><span>diff --git a/s=
rc/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 713dcf4.=
.b8d0f5a 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span=
>+++ b/src/openvpn/options.c</span><br><span>@@ -7044,12 +7044,12 @@</span>=
<br><span>         if (options-&gt;routes-&gt;flags &amp; RG_REROUTE_GW)</s=
pan><br><span>         {</span><br><span>             setenv_int(es, &quot;=
route_redirect_gateway_ipv4&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                       options-&gt;routes-&gt;flags &amp; RG_B=
LOCK_LOCAL ? 2 : 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       (options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL)=
 ? 2 : 1);</span><br><span>         }</span><br><span>         if (options-=
&gt;routes_ipv6 &amp;&amp; (options-&gt;routes_ipv6-&gt;flags &amp; RG_RERO=
UTE_GW))</span><br><span>         {</span><br><span>             setenv_int=
(es, &quot;route_redirect_gateway_ipv6&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                       options-&gt;routes-&gt;flags=
 &amp; RG_BLOCK_LOCAL ? 2 : 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       (options-&gt;routes-&gt;flags &amp; RG_B=
LOCK_LOCAL) ? 2 : 1);</span><br><span>         }</span><br><span> #ifdef _W=
IN32</span><br><span>         /* we need this here to handle pushed --redir=
ect-gateway */</span><br><span>diff --git a/src/openvpnserv/common.c b/src/=
openvpnserv/common.c</span><br><span>index f60e2f2..7fc8c14 100644</span><b=
r><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openvpnser=
v/common.c</span><br><span>@@ -276,7 +276,7 @@</span><br><span> </span><br>=
<span>         const WCHAR *mesg[] =3D { msg[0], msg[1] };</span><br><span>=
         ReportEvent(hEventSource,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    flags &amp; MSG_FLAGS_ERROR ? EVENTLOG_ERR=
OR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    (flags &amp; MSG_FLAGS_ERROR) ? EVENTL=
OG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><br><span>                =
     0,</span><br><span>                     EVT_TEXT_2,</span><br><span>  =
                   NULL,</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail">change =
1619</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia153e0de888c0ee21199b192f34=
71ce4c08cb5c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1619 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--a9cTF/b8Duo=--

