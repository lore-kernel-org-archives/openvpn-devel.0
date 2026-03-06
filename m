From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 16:18:45 +0000
In-Reply-To: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
References: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <67a1397329ca17f4130ce558c8fe55833ae37ac0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BkBDbHKXSu4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BkBDbHKXSu4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
96?usp=3Demail )

Change subject: openvpnserv: Improve sanity check for addr_len in HandleWIN=
SConfigMessage
......................................................................

openvpnserv: Improve sanity check for addr_len in HandleWINSConfigMessage

Handle the case where the int is negative
explicitly. Zero is probably a safer value
to assume in this case.

Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1496
Message-Id: <20260305084610.1038-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
923.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 5 insertions(+), 10 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Gerrit-Change-Number: 1496
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BkBDbHKXSu4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1496?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnserv: Improve sanity check for addr_len i=
n HandleWINSConfigMessage<br><br>Handle the case where the int is negative<=
br>explicitly. Zero is probably a safer value<br>to assume in this case.<br=
><br>Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/14=
96<br>Message-Id: &lt;20260305084610.1038-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35923.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpnserv/interactive.c<br>1 file changed, 5 insertions(+), 10 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 227431a..09c709e 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1247,11 +1247,6 @@</span><br><span>     return err;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /**</span><br><span>  * Check for a valid search list in a certain k=
ey of the registry</span><br><span>  *</span><br><span>@@ -2944,7 +2939,11 =
@@</span><br><span>     int addr_len =3D msg-&gt;addr_len;</span><br><span>=
 </span><br><span>     /* sanity check */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (addr_len &gt; _countof(msg-&gt;addr))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (addr_len &lt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        addr_len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if ((unsigned int)addr_len &gt; _countof(msg=
-&gt;addr))</span><br><span>     {</span><br><span>         addr_len =3D _c=
ountof(msg-&gt;addr);</span><br><span>     }</span><br><span>@@ -3005,10 +3=
004,6 @@</span><br><span>     return err;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static DWORD</span><br><span> HandleEnableDHCPMessage(const ena=
ble_dhcp_message_t *dhcp)</span><br><span> {</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1496?=
usp=3Demail">change 1496</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1496?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03f4c640a2adbea9bbb6f6334f1=
2375041ec429c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1496 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--BkBDbHKXSu4=--

