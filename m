From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 15 Mar 2024 13:43:16 +0000
References: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <beb91351d80ec3d8186b9f8cd29775cb059b2896-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bLT02uGPoHQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Disable DCO if proxy
 is set via management
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

--bLT02uGPoHQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail

to review the following change.


Change subject: Disable DCO if proxy is set via management
......................................................................

Disable DCO if proxy is set via management

Commit

    45a1cb2a ("Disable DCO if proxy is set via management")

attempted to disable DCO when proxy is set via management interface. Howeve=
r,
at least on Windows this doesn't work, since:

 - setting tuntap_options->disable_dco to true is not enough to disable DCO
 - at this point it is a bit too late, since we've already done DCO-specific
adjustments

Since proxy could be set via management only if --management-query-proxy is=
 specified,
the better way would be to add a check to dco_check_startup_option().

Github: fixes OpenVPN/openvpn#522

Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/init.c
2 files changed, 6 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/543/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 14430d3..540b5a8 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -387,6 +387,12 @@
         return false;
     }

+    if (o->management_flags & MF_QUERY_PROXY)
+    {
+        msg(msglevel, "Note: --management-query-proxy disables data channe=
l offload.");
+        return false;
+    }
+
     /* now that all options have been confirmed to be supported, check
      * if DCO is truly available on the system
      */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b3931..6a3040f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -221,12 +221,6 @@
     }
     else if (p[2] && p[3])
     {
-        if (dco_enabled(&c->options))
-        {
-            msg(M_INFO, "Proxy set via management, disabling Data Channel =
Offload.");
-            c->options.tuntap_options.disable_dco =3D true;
-        }
-
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8
Gerrit-Change-Number: 543
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--bLT02uGPoHQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Disable DCO if proxy is set via management<br><br>Commit<br><=
br>    45a1cb2a (&quot;Disable DCO if proxy is set via management&quot;)<br=
><br>attempted to disable DCO when proxy is set via management interface. H=
owever,<br>at least on Windows this doesn&#39;t work, since:<br><br> - sett=
ing tuntap_options-&gt;disable_dco to true is not enough to disable DCO<br>=
 - at this point it is a bit too late, since we&#39;ve already done DCO-spe=
cific<br>adjustments<br><br>Since proxy could be set via management only if=
 --management-query-proxy is specified,<br>the better way would be to add a=
 check to dco_check_startup_option().<br><br>Github: fixes OpenVPN/openvpn#=
522<br><br>Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco.c<br>=
M src/openvpn/init.c<br>2 files changed, 6 insertions(+), 6 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/543=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><sp=
an>index 14430d3..540b5a8 100644</span><br><span>--- a/src/openvpn/dco.c</s=
pan><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -387,6 +387,12 @@<=
/span><br><span>         return false;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;m=
anagement_flags &amp; MF_QUERY_PROXY)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(msglevel, &quot;Note: --management-query-proxy disables dat=
a channel offload.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     /* now that all options have been confirmed to be supporte=
d, check</span><br><span>      * if DCO is truly available on the system</s=
pan><br><span>      */</span><br><span>diff --git a/src/openvpn/init.c b/sr=
c/openvpn/init.c</span><br><span>index 52b3931..6a3040f 100644</span><br><s=
pan>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span=
><br><span>@@ -221,12 +221,6 @@</span><br><span>     }</span><br><span>    =
 else if (p[2] &amp;&amp; p[3])</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;c-&gt;options=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;P=
roxy set via management, disabling Data Channel Offload.&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;options.tuntap=
_options.disable_dco =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         if (streq(p[1], &quot;HTTP&quot;))</span><br><span> =
        {</span><br><span>             struct http_proxy_options *ho;</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/543?usp=3Demail">change 543</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/543?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d6a9fefa317d7d4a195e78661=
8328445bdbca8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 543 </div>
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


--bLT02uGPoHQ=--

