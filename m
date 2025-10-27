From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 22:37:36 +0000
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <de4f7f8124443515474c85b45fc97b4a42eff52f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y/miYUwUnK0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y/miYUwUnK0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail

to review the following change.


Change subject: Fix logic when pushed cipher triggers tun reopen and ignore=
 more options
......................................................................

Fix logic when pushed cipher triggers tun reopen and ignore more options

The logic was inverted. Only when link-mtu is used, pushing a cipher can
change the MTU and not the other way round. (found by zeropath)

Also ignore a few more options that should not trigger a reopen of tun
in push message.

Reported-By: contact@...2949...
Found-By: Zeropath
Change-Id: I76eb584024610a6054a069340adbac988abf686c
---
M src/openvpn/push.c
1 file changed, 14 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1321/1

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..d7063e6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1025,15 +1025,25 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76eb584024610a6054a069340adbac988abf686c
Gerrit-Change-Number: 1321
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Y/miYUwUnK0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix logic when pushed cipher triggers tun r=
eopen and ignore more options<br><br>The logic was inverted. Only when link=
-mtu is used, pushing a cipher can<br>change the MTU and not the other way =
round. (found by zeropath)<br><br>Also ignore a few more options that shoul=
d not trigger a reopen of tun<br>in push message.<br><br>Reported-By: conta=
ct@...2949...<br>Found-By: Zeropath<br>Change-Id: I76eb584024610a6054a06934=
0adbac988abf686c<br>---<br>M src/openvpn/push.c<br>1 file changed, 14 inser=
tions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/21/1321/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/push.c b/src/openvpn/push.c</span><br><span>index 2c717c7..d7063e6 10=
0644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/ope=
nvpn/push.c</span><br><span>@@ -1025,15 +1025,25 @@</span><br><span>     ch=
ar line[OPTION_PARM_SIZE];</span><br><span>     while (buf_parse(buf, &#39;=
,&#39;, line, sizeof(line)))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* peer-id and auth-token might cha=
nge on restart and this should not trigger reopening tun</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* peer-id and auth-token migh=
t change on restart and this should not</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * trigger reopening tun</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * Also other options that only a=
ffect the control channel should</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * not trigger a reopen of the tun device</span><br><s=
pan>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (strprefix(line, &quot;peer-id &quot;) || strprefix(line, &quot;auth-=
token &quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    || strprefix(line, &quot;auth-token-user &quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (strprefix(line, &quot;peer-id=
 &quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 || strprefix(line, &quot;auth-token &quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            || strprefix(line, &quot;auth-token-us=
er&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  || strprefix(line, &quot;protocol-flags &quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            || strprefix(line, &quot;key-deri=
vation &quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       || strprefix(line, &quot;explicit-exit-notify &quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            || strprefix(line, &qu=
ot;ping &quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        || strprefix(line, &quot;ping-restart &quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || strprefix(line, &quot;ping=
-timer &quot;))</span><br><span>         {</span><br><span>             con=
tinue;</span><br><span>         }</span><br><span>         /* tun reopen on=
ly needed if cipher change can change tun MTU */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (strprefix(line, &quot;cipher &quot;)=
 &amp;&amp; !opt-&gt;ce.tun_mtu_defined)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (strprefix(line, &quot;cipher &quot;) &amp;=
&amp; opt-&gt;ce.tun_mtu_defined)</span><br><span>         {</span><br><spa=
n>             continue;</span><br><span>         }</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1321?usp=3Demail">change 1321</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
321?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76eb584024610a6054a069340ad=
bac988abf686c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Y/miYUwUnK0=--

