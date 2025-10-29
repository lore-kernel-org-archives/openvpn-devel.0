From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 07:22:25 +0000
In-Reply-To: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8c2b25ed699a13aefeb4bd510c1be4a6915334cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O5Kw7mfSplk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O5Kw7mfSplk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
21?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76eb584024610a6054a069340adbac988abf686c
Gerrit-Change-Number: 1321
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O5Kw7mfSplk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1321?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix logic when pushed cipher triggers tun reopen=
 and ignore more options<br><br>The logic was inverted. Only when link-mtu =
is used, pushing a cipher can<br>change the MTU and not the other way round=
. (found by zeropath)<br><br>Also ignore a few more options that should not=
 trigger a reopen of tun<br>in push message.<br><br>Reported-by: Joshua Rog=
ers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/=
)<br><br>Change-Id: I76eb584024610a6054a069340adbac988abf686c<br>Signed-off=
-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1321<br>Message-Id: &lt;20251029065316.10182-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg339=
89.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/push.c<br>1 file changed, 14 insertions(+), 4 deletions(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>ind=
ex 6f146fc..7852d36 100644</span><br><span>--- a/src/openvpn/push.c</span><=
br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -1029,15 +1029,25 @@</=
span><br><span>     char line[OPTION_PARM_SIZE];</span><br><span>     while=
 (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* peer-id and =
auth-token might change on restart and this should not trigger reopening tu=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* peer-id=
 and auth-token might change on restart and this should not</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * trigger reopening tun</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Also other =
options that only affect the control channel should</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * not trigger a reopen of the tu=
n device</span><br><span>          */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (strprefix(line, &quot;peer-id &quot;) || strpre=
fix(line, &quot;auth-token &quot;)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            || strprefix(line, &quot;auth-token-user &quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strprefi=
x(line, &quot;peer-id &quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            || strprefix(line, &quot;auth-token &quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            || strprefix(line=
, &quot;auth-token-user&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            || strprefix(line, &quot;protocol-flags &quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strprefix=
(line, &quot;key-derivation &quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            || strprefix(line, &quot;explicit-exit-notify &=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            |=
| strprefix(line, &quot;ping &quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            || strprefix(line, &quot;ping-restart &quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strpr=
efix(line, &quot;ping-timer &quot;))</span><br><span>         {</span><br><=
span>             continue;</span><br><span>         }</span><br><span>    =
     /* tun reopen only needed if cipher change can change tun MTU */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strprefix(line,=
 &quot;cipher &quot;) &amp;&amp; !opt-&gt;ce.tun_mtu_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (strprefix(line, &quot=
;cipher &quot;) &amp;&amp; opt-&gt;ce.tun_mtu_defined)</span><br><span>    =
     {</span><br><span>             continue;</span><br><span>         }</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1321?usp=3Demail">change 1321</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1321?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--O5Kw7mfSplk=--

