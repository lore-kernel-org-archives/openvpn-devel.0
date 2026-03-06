From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 16:18:40 +0000
In-Reply-To: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
References: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <67a1397329ca17f4130ce558c8fe55833ae37ac0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Np9F5Pu0uVk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Np9F5Pu0uVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1496/7

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
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Np9F5Pu0uVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">openvpnserv: Improve sanity check f=
or addr_len in HandleWINSConfigMessage<br><br>Handle the case where the int=
 is negative<br>explicitly. Zero is probably a safer value<br>to assume in =
this case.<br><br>Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert =
Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c=
/openvpn/+/1496<br>Message-Id: &lt;20260305084610.1038-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg35923.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpnserv/interactive.c<br>1 file changed, 5 insertions(+), 10 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/96/1496/7</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/in=
teractive.c b/src/openvpnserv/interactive.c</span><br><span>index 227431a..=
09c709e 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><b=
r><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1247,11 +12=
47,6 @@</span><br><span>     return err;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * C=
heck for a valid search list in a certain key of the registry</span><br><sp=
an>  *</span><br><span>@@ -2944,7 +2939,11 @@</span><br><span>     int addr=
_len =3D msg-&gt;addr_len;</span><br><span> </span><br><span>     /* sanity=
 check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (addr=
_len &gt; _countof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (addr_len &lt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        addr_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f ((unsigned int)addr_len &gt; _countof(msg-&gt;addr))</span><br><span>    =
 {</span><br><span>         addr_len =3D _countof(msg-&gt;addr);</span><br>=
<span>     }</span><br><span>@@ -3005,10 +3004,6 @@</span><br><span>     re=
turn err;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static DWORD</span><=
br><span> HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)</span>=
<br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail">change 1496</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1496?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--Np9F5Pu0uVk=--

