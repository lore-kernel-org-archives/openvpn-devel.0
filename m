From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 11:56:43 +0000
In-Reply-To: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
References: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <41ad8a0bb07211693e88bfe4c959a7be4d51186b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sbipzt2oNIo="; charset=UTF-8
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

--Sbipzt2oNIo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail

to look at the new patch set (#6).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1496/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Gerrit-Change-Number: 1496
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Sbipzt2oNIo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #6</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">openvpnserv: Improve sanity check fo=
r addr_len in HandleWINSConfigMessage<br><br>Handle the case where the int =
is negative<br>explicitly. Zero is probably a safer value<br>to assume in t=
his case.<br><br>Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/ope=
nvpnserv/interactive.c<br>1 file changed, 5 insertions(+), 10 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/96/1496/6</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b=
/src/openvpnserv/interactive.c</span><br><span>index 227431a..09c709e 10064=
4</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b=
/src/openvpnserv/interactive.c</span><br><span>@@ -1247,11 +1247,6 @@</span=
><br><span>     return err;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Check for a vali=
d search list in a certain key of the registry</span><br><span>  *</span><b=
r><span>@@ -2944,7 +2939,11 @@</span><br><span>     int addr_len =3D msg-&g=
t;addr_len;</span><br><span> </span><br><span>     /* sanity check */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (addr_len &gt; _coun=
tof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (addr_len &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ad=
dr_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((unsigned in=
t)addr_len &gt; _countof(msg-&gt;addr))</span><br><span>     {</span><br><s=
pan>         addr_len =3D _countof(msg-&gt;addr);</span><br><span>     }</s=
pan><br><span>@@ -3005,10 +3004,6 @@</span><br><span>     return err;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static DWORD</span><br><span> Handl=
eEnableDHCPMessage(const enable_dhcp_message_t *dhcp)</span><br><span> {</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1496?usp=3Demail">change 1496</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1496?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f1=
2375041ec429c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1496 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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

--Sbipzt2oNIo=--

