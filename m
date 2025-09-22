From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Sep 2025 08:50:23 +0000
In-Reply-To: <gerrit.1758524470000.I5fea6ca1ccadb434b5c4f4b49881524a079a9d15@...2715...>
References: <gerrit.1758524470000.I5fea6ca1ccadb434b5c4f4b49881524a079a9d15@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <7fff78e211639c082bd45c52f67c5d258513c7db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l5L7jypRQxw="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l5L7jypRQxw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
03?usp=3Demail )

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
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1203
Message-Id: <20250922080305.18477-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59236810/
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_networking.c
1 file changed, 1 insertion(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--l5L7jypRQxw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1203?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix t_net.sh / networking_testdriver after &#=
39;broadcast&#39; change<br><br>Commit 0df0edc49c re-introduced explicit se=
tting of broadcast addresses<br>for Linux IPv4 interfaces.  t_net.sh verifi=
es that the built-in netlink<br>code (sitnl) achieves the same result as &q=
uot;equivalent&quot; iproute2 statements<br>- and we missed adjusting of th=
ese iproute2 statements (printed by<br>networking_testdriver).  Done.<br><b=
r>Change-Id: I5fea6ca1ccadb434b5c4f4b49881524a079a9d15<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;anton=
io@...2726...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/120=
3<br>Message-Id: &lt;20250922080305.18477-1-gert@...1296...&gt;<br>URL: htt=
ps://sourceforge.net/p/openvpn/mailman/message/59236810/<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/t=
est_networking.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tes=
ts/openvpn/test_networking.c</span><br><span>index f2da83e..6a2d09f 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_networking.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_networking.c</span><br><span>@@ -=
61,7 +61,7 @@</span><br><span> </span><br><span>     addr =3D ntohl(addr);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
printf(&quot;CMD: ip addr add %s/%d dev %s\n&quot;, addr_str, prefixlen, if=
ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&qu=
ot;CMD: ip addr add %s/%d dev %s broadcast +\n&quot;, addr_str, prefixlen, =
iface);</span><br><span> </span><br><span>     return net_addr_v4_add(NULL,=
 iface, &amp;addr, prefixlen);</span><br><span> }</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1203?usp=3Demail">change 1203</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1203?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5fea6ca1ccadb434b5c4f4b4988=
1524a079a9d15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1203 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--l5L7jypRQxw=--

