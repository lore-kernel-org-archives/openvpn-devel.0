From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 07:22:22 +0000
In-Reply-To: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8c2b25ed699a13aefeb4bd510c1be4a6915334cc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="60PKkDYb0Ww="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix logic when
 pushed cipher triggers tun reopen and ignore more options
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

--60PKkDYb0Ww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix logic when pushed cipher triggers tun reopen and ignore=
 more options
......................................................................

Fix logic when pushed cipher triggers tun reopen and ignore more options

The logic was inverted. Only when link-mtu is used, pushing a cipher can
change the MTU and not the other way round. (found by zeropath)

Also ignore a few more options that should not trigger a reopen of tun
in push message.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I76eb584024610a6054a069340adbac988abf686c
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1321
Message-Id: <20251029065316.10182-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
989.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push.c
1 file changed, 14 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1321/2

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6f146fc..7852d36 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1029,15 +1029,25 @@
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        /* peer-id and auth-token might change on restart and this should =
not trigger reopening tun
+        /* peer-id and auth-token might change on restart and this should =
not
+         * trigger reopening tun
+         * Also other options that only affect the control channel should
+         * not trigger a reopen of the tun device
          */
-        if (strprefix(line, "peer-id ") || strprefix(line, "auth-token ")
-            || strprefix(line, "auth-token-user "))
+        if (strprefix(line, "peer-id ")
+            || strprefix(line, "auth-token ")
+            || strprefix(line, "auth-token-user")
+            || strprefix(line, "protocol-flags ")
+            || strprefix(line, "key-derivation ")
+            || strprefix(line, "explicit-exit-notify ")
+            || strprefix(line, "ping ")
+            || strprefix(line, "ping-restart ")
+            || strprefix(line, "ping-timer "))
         {
             continue;
         }
         /* tun reopen only needed if cipher change can change tun MTU */
-        if (strprefix(line, "cipher ") && !opt->ce.tun_mtu_defined)
+        if (strprefix(line, "cipher ") && opt->ce.tun_mtu_defined)
         {
             continue;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76eb584024610a6054a069340adbac988abf686c
Gerrit-Change-Number: 1321
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--60PKkDYb0Ww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Fix logic when pushed cipher trigge=
rs tun reopen and ignore more options<br><br>The logic was inverted. Only w=
hen link-mtu is used, pushing a cipher can<br>change the MTU and not the ot=
her way round. (found by zeropath)<br><br>Also ignore a few more options th=
at should not trigger a reopen of tun<br>in push message.<br><br>Reported-b=
y: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://=
zeropath.com/)<br><br>Change-Id: I76eb584024610a6054a069340adbac988abf686c<=
br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1321<br>Message-Id: &lt;20251029065316.10182-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg33989.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/push.c<br>1 file changed, 14 insertions(+), 4 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/21/1321/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push.c b/s=
rc/openvpn/push.c</span><br><span>index 6f146fc..7852d36 100644</span><br><=
span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</spa=
n><br><span>@@ -1029,15 +1029,25 @@</span><br><span>     char line[OPTION_P=
ARM_SIZE];</span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, si=
zeof(line)))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* peer-id and auth-token might change on restart and=
 this should not trigger reopening tun</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* peer-id and auth-token might change on restar=
t and this should not</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * trigger reopening tun</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * Also other options that only affect the control c=
hannel should</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * not trigger a reopen of the tun device</span><br><span>          */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strprefix(li=
ne, &quot;peer-id &quot;) || strprefix(line, &quot;auth-token &quot;)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            || strprefix(li=
ne, &quot;auth-token-user &quot;))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (strprefix(line, &quot;peer-id &quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            || strprefix(line,=
 &quot;auth-token &quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            || strprefix(line, &quot;auth-token-user&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            || strprefix(line=
, &quot;protocol-flags &quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            || strprefix(line, &quot;key-derivation &quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strprefix=
(line, &quot;explicit-exit-notify &quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            || strprefix(line, &quot;ping &quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strprefi=
x(line, &quot;ping-restart &quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            || strprefix(line, &quot;ping-timer &quot;))</sp=
an><br><span>         {</span><br><span>             continue;</span><br><s=
pan>         }</span><br><span>         /* tun reopen only needed if cipher=
 change can change tun MTU */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (strprefix(line, &quot;cipher &quot;) &amp;&amp; !opt-&g=
t;ce.tun_mtu_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (strprefix(line, &quot;cipher &quot;) &amp;&amp; opt-&gt;ce.tu=
n_mtu_defined)</span><br><span>         {</span><br><span>             cont=
inue;</span><br><span>         }</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail"=
>change 1321</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76eb584024610a6054a069340ad=
bac988abf686c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--60PKkDYb0Ww=--

