From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 4 Jan 2025 22:52:09 +0000
References: <gerrit.1736031115000.Ie60a0a427ca810e28ab9049a8599510423f79bc1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f8d8a7b91c509f42f3bb207c40c0d54808edaae4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dPT02GnWBHw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: fixup! Add methods
 to read/write packet ids for epoch data
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

--dPT02GnWBHw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/849?usp=3Demail

to review the following change.


Change subject: fixup! Add methods to read/write packet ids for epoch data
......................................................................

fixup! Add methods to read/write packet ids for epoch data

Change-Id: Ie60a0a427ca810e28ab9049a8599510423f79bc1
---
M tests/unit_tests/openvpn/test_packet_id.c
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/849/1

diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index a24580b..312a6b3d 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -238,7 +238,8 @@
     uint8_t expected_header_48[8] =3D { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9=
, 0xd2, 0xe9};
     assert_memory_equal(BPTR(&buf_48), expected_header_48, 8);

-    /* test writing/checking the 48 bit overflow */
+    /* test writing/checking the 48 bit per epoch packet counter
+     * overflow */
     data->pis.id =3D 0xfffffffffffe;
     struct buffer buf_of =3D alloc_buf_gc(128, &data->gc);
     assert_true(packet_id_write_epoch(&data->pis, 0xf00f, &buf_of));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/849?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie60a0a427ca810e28ab9049a8599510423f79bc1
Gerrit-Change-Number: 849
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--dPT02GnWBHw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/849?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">fixup! Add methods to read/write packet ids for epoch data<br=
><br>Change-Id: Ie60a0a427ca810e28ab9049a8599510423f79bc1<br>---<br>M tests=
/unit_tests/openvpn/test_packet_id.c<br>1 file changed, 2 insertions(+), 1 =
deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/49/849/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_packet_=
id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>index a245=
80b..312a6b3d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pa=
cket_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id.c</=
span><br><span>@@ -238,7 +238,8 @@</span><br><span>     uint8_t expected_he=
ader_48[8] =3D { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9, 0xd2, 0xe9};</span><br=
><span>     assert_memory_equal(BPTR(&amp;buf_48), expected_header_48, 8);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* test writing/checking the 48 bit overflow */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* test writing/checking the 48 bit per epo=
ch packet counter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * overflow */</span><br><span>     data-&gt;pis.id =3D 0xfffffffffffe;</=
span><br><span>     struct buffer buf_of =3D alloc_buf_gc(128, &amp;data-&g=
t;gc);</span><br><span>     assert_true(packet_id_write_epoch(&amp;data-&gt=
;pis, 0xf00f, &amp;buf_of));</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/849?usp=3Demail">chan=
ge 849</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/849?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie60a0a427ca810e28ab9049a859=
9510423f79bc1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 849 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--dPT02GnWBHw=--

