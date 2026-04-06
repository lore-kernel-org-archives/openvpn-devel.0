From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Apr 2026 10:01:26 +0000
In-Reply-To: <gerrit.1775426608000.I64da2328591ef2b9ee7502e574c878651cdf356a@...2715...>
References: <gerrit.1775426608000.I64da2328591ef2b9ee7502e574c878651cdf356a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1578c0891c3f49e3c5b4b8ba20bd0cd0b90048d9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iY0PYTPYgvU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_packet_id: Add
 a check after malloc to ensure value is valid
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

--iY0PYTPYgvU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
21?usp=3Demail )

Change subject: test_packet_id: Add a check after malloc to ensure value is=
 valid
......................................................................

test_packet_id: Add a check after malloc to ensure value is valid

cppcheck complains about a potential null pointer dereference
in reliable_get_num_output_sequenced_available. That is mostly
theoretical, but still add a check.

Change-Id: I64da2328591ef2b9ee7502e574c878651cdf356a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1621
Message-Id: <20260406074729.29903-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
516.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_packet_id.c
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index b7538bd..5dfd319 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -164,6 +164,7 @@
 test_get_num_output_sequenced_available(void **state)
 {
     struct reliable *rel =3D malloc(sizeof(struct reliable));
+    assert_non_null(rel);
     reliable_init(rel, 100, 50, 8, false);

     rel->array[5].active =3D true;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1621?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64da2328591ef2b9ee7502e574c878651cdf356a
Gerrit-Change-Number: 1621
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iY0PYTPYgvU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1621?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_packet_id: Add a check after malloc to ensu=
re value is valid<br><br>cppcheck complains about a potential null pointer =
dereference<br>in reliable_get_num_output_sequenced_available. That is most=
ly<br>theoretical, but still add a check.<br><br>Change-Id: I64da2328591ef2=
b9ee7502e574c878651cdf356a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1621<br>Message-Id: &lt;202604060=
74729.29903-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg36516.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_packet_=
id.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_test=
s/openvpn/test_packet_id.c</span><br><span>index b7538bd..5dfd319 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_packet_id.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>@@ -164,=
6 +164,7 @@</span><br><span> test_get_num_output_sequenced_available(void *=
*state)</span><br><span> {</span><br><span>     struct reliable *rel =3D ma=
lloc(sizeof(struct reliable));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_non_null(rel);</span><br><span>     reliable_init(rel=
, 100, 50, 8, false);</span><br><span> </span><br><span>     rel-&gt;array[=
5].active =3D true;</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1621?usp=3Demail">change 1621<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1621?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64da2328591ef2b9ee7502e574c=
878651cdf356a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1621 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--iY0PYTPYgvU=--

