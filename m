From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Sep 2025 07:01:14 +0000
References: <gerrit.1758524470000.I5fea6ca1ccadb434b5c4f4b49881524a079a9d15@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e779cf1ad6976d8c4fe59a739e6f28456f0bb770-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JSxTGNf64bM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix t_net.sh /
 networking_testdriver after 'broadcast' change
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

--JSxTGNf64bM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demail

to review the following change.


Change subject: Fix t_net.sh / networking_testdriver after 'broadcast' chan=
ge
......................................................................

Fix t_net.sh / networking_testdriver after 'broadcast' change

Commit 0df0edc49c re-introduced explicit setting of broadcast addresses
for Linux IPv4 interfaces.  t_net.sh verifies that the built-in netlink
code (sitnl) achieves the same result as "equivalent" iproute2 statements
- and we missed adjusting of these iproute2 statements (printed by
networking_testdriver).  Done.

Change-Id: I5fea6ca1ccadb434b5c4f4b49881524a079a9d15
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_networking.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1203/1

diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/=
openvpn/test_networking.c
index f2da83e..6a2d09f 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -61,7 +61,7 @@

     addr =3D ntohl(addr);

-    printf("CMD: ip addr add %s/%d dev %s\n", addr_str, prefixlen, iface);
+    printf("CMD: ip addr add %s/%d dev %s broadcast +\n", addr_str, prefix=
len, iface);

     return net_addr_v4_add(NULL, iface, &addr, prefixlen);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5fea6ca1ccadb434b5c4f4b49881524a079a9d15
Gerrit-Change-Number: 1203
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--JSxTGNf64bM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix t_net.sh / networking_testdriver after &#39;broadcast&#3=
9; change<br><br>Commit 0df0edc49c re-introduced explicit setting of broadc=
ast addresses<br>for Linux IPv4 interfaces.  t_net.sh verifies that the bui=
lt-in netlink<br>code (sitnl) achieves the same result as &quot;equivalent&=
quot; iproute2 statements<br>- and we missed adjusting of these iproute2 st=
atements (printed by<br>networking_testdriver).  Done.<br><br>Change-Id: I5=
fea6ca1ccadb434b5c4f4b49881524a079a9d15<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_networking.c<=
br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/03/1203/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test=
_networking.c</span><br><span>index f2da83e..6a2d09f 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_networking.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_networking.c</span><br><span>@@ -61,7 +61,7 @@</=
span><br><span> </span><br><span>     addr =3D ntohl(addr);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;CM=
D: ip addr add %s/%d dev %s\n&quot;, addr_str, prefixlen, iface);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;CMD: ip addr=
 add %s/%d dev %s broadcast +\n&quot;, addr_str, prefixlen, iface);</span><=
br><span> </span><br><span>     return net_addr_v4_add(NULL, iface, &amp;ad=
dr, prefixlen);</span><br><span> }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demai=
l">change 1203</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5fea6ca1ccadb434b5c4f4b4988=
1524a079a9d15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1203 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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


--JSxTGNf64bM=--

