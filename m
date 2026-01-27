From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 11:31:11 +0000
References: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a14c7750da71f3738f18ac44f0cb8b8becacf3ac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wEf3x+61X+Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Improve
 sanity check for addr_len in HandleWINSConfigMes...
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

--wEf3x+61X+Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail

to review the following change.


Change subject: openvpnserv: Improve sanity check for addr_len in HandleWIN=
SConfigMessage
......................................................................

openvpnserv: Improve sanity check for addr_len in HandleWINSConfigMessage

Handle the case where the int is negative
explicitly. Zero is probably a safer value
to assume in this case.

Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 5 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1496/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 227431a..09c709e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1247,11 +1247,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Check for a valid search list in a certain key of the registry
  *
@@ -2944,7 +2939,11 @@
     int addr_len =3D msg->addr_len;

     /* sanity check */
-    if (addr_len > _countof(msg->addr))
+    if (addr_len < 0)
+    {
+        addr_len =3D 0;
+    }
+    if ((unsigned int)addr_len > _countof(msg->addr))
     {
         addr_len =3D _countof(msg->addr);
     }
@@ -3005,10 +3004,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static DWORD
 HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Gerrit-Change-Number: 1496
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--wEf3x+61X+Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Improve sanity check for addr_=
len in HandleWINSConfigMessage<br><br>Handle the case where the int is nega=
tive<br>explicitly. Zero is probably a safer value<br>to assume in this cas=
e.<br><br>Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpnser=
v/interactive.c<br>1 file changed, 5 insertions(+), 10 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/96/1496/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/op=
envpnserv/interactive.c</span><br><span>index 227431a..09c709e 100644</span=
><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/op=
envpnserv/interactive.c</span><br><span>@@ -1247,11 +1247,6 @@</span><br><s=
pan>     return err;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> /**</span><br><span>  * Check for a valid searc=
h list in a certain key of the registry</span><br><span>  *</span><br><span=
>@@ -2944,7 +2939,11 @@</span><br><span>     int addr_len =3D msg-&gt;addr_=
len;</span><br><span> </span><br><span>     /* sanity check */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (addr_len &gt; _countof(msg=
-&gt;addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
addr_len &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        addr_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((unsigned int)addr_=
len &gt; _countof(msg-&gt;addr))</span><br><span>     {</span><br><span>   =
      addr_len =3D _countof(msg-&gt;addr);</span><br><span>     }</span><br=
><span>@@ -3005,10 +3004,6 @@</span><br><span>     return err;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static DWORD</span><br><span> HandleEnab=
leDHCPMessage(const enable_dhcp_message_t *dhcp)</span><br><span> {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1496?usp=3Demail">change 1496</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1496?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f1=
2375041ec429c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1496 </div>
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

--wEf3x+61X+Y=--

