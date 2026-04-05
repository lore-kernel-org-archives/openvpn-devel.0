From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 22:03:33 +0000
References: <gerrit.1775426608000.I64da2328591ef2b9ee7502e574c878651cdf356a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e2e05ba7fb4b15d2b89bcd4158269406c5561133-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Q4R1A1SVL0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9Q4R1A1SVL0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1621?usp=3Demail

to review the following change.


Change subject: test_packet_id: Add a check after malloc to ensure value is=
 valid
......................................................................

test_packet_id: Add a check after malloc to ensure value is valid

cppcheck complains about a potential null pointer dereference
in reliable_get_num_output_sequenced_available. That is mostly
theoretical, but still add a check.

Change-Id: I64da2328591ef2b9ee7502e574c878651cdf356a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_packet_id.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1621/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64da2328591ef2b9ee7502e574c878651cdf356a
Gerrit-Change-Number: 1621
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9Q4R1A1SVL0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1621?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_packet_id: Add a check after malloc to=
 ensure value is valid<br><br>cppcheck complains about a potential null poi=
nter dereference<br>in reliable_get_num_output_sequenced_available. That is=
 mostly<br>theoretical, but still add a check.<br><br>Change-Id: I64da23285=
91ef2b9ee7502e574c878651cdf356a<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_packet_id.c<br>=
1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1621/1</pre>=
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

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64da2328591ef2b9ee7502e574c=
878651cdf356a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1621 </div>
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

--9Q4R1A1SVL0=--

