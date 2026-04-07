From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 7 Apr 2026 20:06:24 +0000
In-Reply-To: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
References: <gerrit.1775421558000.Ia153e0de888c0ee21199b192f3471ce4c08cb5c7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <e17beeb7db492e5acb4e1a3f233d37bfa12b80ca-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZuPiQtncVzE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZuPiQtncVzE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail

to look at the new patch set (#2).


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
3 files changed, 4 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1619/2

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia153e0de888c0ee21199b192f3471ce4c08cb5c7
Gerrit-Change-Number: 1619
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ZuPiQtncVzE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1619?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Clarify operator precedence in a &amp; b ? c : d=
<br><br>As suggested by cppcheck.<br><br>Change-Id: Ia153e0de888c0ee21199b1=
92f3471ce4c08cb5c7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M src/openvpn/error.h<br>M src/openvpn/options.c<br>M src/op=
envpnserv/common.c<br>3 files changed, 4 insertions(+), 4 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/19/1619/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/error.h b/src/openvpn/e=
rror.h</span><br><span>index 62389af..03d880f 100644</span><br><span>--- a/=
src/openvpn/error.h</span><br><span>+++ b/src/openvpn/error.h</span><br><sp=
an>@@ -399,7 +399,7 @@</span><br><span> static inline msglvl_t</span><br><s=
pan> nonfatal(const msglvl_t err)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return err &amp; M_FATAL ? (err ^ M_FAT=
AL) | M_NONFATAL : err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (err &amp; M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;</s=
pan><br><span> }</span><br><span> </span><br><span> static inline int</span=
><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span=
><br><span>index 186b2d2..e4905c9 100644</span><br><span>--- a/src/openvpn/=
options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7=
043,12 +7043,12 @@</span><br><span>         if (options-&gt;routes-&gt;flag=
s &amp; RG_REROUTE_GW)</span><br><span>         {</span><br><span>         =
    setenv_int(es, &quot;route_redirect_gateway_ipv4&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                       options-&gt;ro=
utes-&gt;flags &amp; RG_BLOCK_LOCAL ? 2 : 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                       (options-&gt;routes-&gt;fl=
ags &amp; RG_BLOCK_LOCAL) ? 2 : 1);</span><br><span>         }</span><br><s=
pan>         if (options-&gt;routes_ipv6 &amp;&amp; (options-&gt;routes_ipv=
6-&gt;flags &amp; RG_REROUTE_GW))</span><br><span>         {</span><br><spa=
n>             setenv_int(es, &quot;route_redirect_gateway_ipv6&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                       opt=
ions-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL ? 2 : 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       (options-&gt;ro=
utes-&gt;flags &amp; RG_BLOCK_LOCAL) ? 2 : 1);</span><br><span>         }</=
span><br><span> #ifdef _WIN32</span><br><span>         /* we need this here=
 to handle pushed --redirect-gateway */</span><br><span>diff --git a/src/op=
envpnserv/common.c b/src/openvpnserv/common.c</span><br><span>index f60e2f2=
..7fc8c14 100644</span><br><span>--- a/src/openvpnserv/common.c</span><br><=
span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -276,7 +276,7 @@</sp=
an><br><span> </span><br><span>         const WCHAR *mesg[] =3D { msg[0], m=
sg[1] };</span><br><span>         ReportEvent(hEventSource,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    flags &amp; MSG_F=
LAGS_ERROR ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    (flags &amp; =
MSG_FLAGS_ERROR) ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,</span><=
br><span>                     0,</span><br><span>                     EVT_T=
EXT_2,</span><br><span>                     NULL,</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1619?usp=3Demail">change 1619</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/161=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia153e0de888c0ee21199b192f34=
71ce4c08cb5c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1619 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--ZuPiQtncVzE=--

