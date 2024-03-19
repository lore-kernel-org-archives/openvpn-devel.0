From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 19 Mar 2024 19:35:39 +0000
In-Reply-To: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
References: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5ba181293b502c60d3c010ffa3d1ca274794799c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="baBwfdYHRo8="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--baBwfdYHRo8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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

Since proxy can be set via management only if --management-query-proxy is
specified, the better way is to add a check to dco_check_startup_option().

Github: fixes OpenVPN/openvpn#522

Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240318181744.20625-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
415.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/init.c
2 files changed, 6 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/543/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index d7c9d48..78243b1 100644
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
index 6209fa8..f2ce926 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--baBwfdYHRo8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Disable DCO if proxy is set via management<br=
><br>Commit<br><br>    45a1cb2a (&quot;Disable DCO if proxy is set via mana=
gement&quot;)<br><br>attempted to disable DCO when proxy is set via managem=
ent interface. However,<br>at least on Windows this doesn&#39;t work, since=
:<br><br> - setting tuntap_options-&gt;disable_dco to true is not enough to=
 disable DCO<br> - at this point it is a bit too late, since we&#39;ve alre=
ady done DCO-specific<br>   adjustments<br><br>Since proxy can be set via m=
anagement only if --management-query-proxy is<br>specified, the better way =
is to add a check to dco_check_startup_option().<br><br>Github: fixes OpenV=
PN/openvpn#522<br><br>Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8<=
br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240318181744.20625-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg28415.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/init.c<br>2 fil=
es changed, 6 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/43/543/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/dco.c b/src/openvpn/dco.c</span><br><span>index d7c9d48..78243b1 100=
644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openv=
pn/dco.c</span><br><span>@@ -387,6 +387,12 @@</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (o-&gt;management_flags &amp; MF_QUER=
Y_PROXY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &qu=
ot;Note: --management-query-proxy disables data channel offload.&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* now that =
all options have been confirmed to be supported, check</span><br><span>    =
  * if DCO is truly available on the system</span><br><span>      */</span>=
<br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><s=
pan>index 6209fa8..f2ce926 100644</span><br><span>--- a/src/openvpn/init.c<=
/span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -221,12 +221,6 =
@@</span><br><span>     }</span><br><span>     else if (p[2] &amp;&amp; p[3=
])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_INFO, &quot;Proxy set via management, disa=
bling Data Channel Offload.&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            c-&gt;options.tuntap_options.disable_dco =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (st=
req(p[1], &quot;HTTP&quot;))</span><br><span>         {</span><br><span>   =
          struct http_proxy_options *ho;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=
=3Demail">change 543</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d6a9fefa317d7d4a195e78661=
8328445bdbca8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 543 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--baBwfdYHRo8=--

