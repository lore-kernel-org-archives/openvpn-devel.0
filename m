From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 8 Jan 2026 15:52:09 +0000
In-Reply-To: <gerrit.1767875377000.Ibc964c13724316ca96276ba6b7d34dbbfcf52064@...2715...>
References: <gerrit.1767875377000.Ibc964c13724316ca96276ba6b7d34dbbfcf52064@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bf29b6ca3dede91eec8466c822c569ac3a0652af-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AYmziNP4s7M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 test_tls_crypt with cmocka 2.0
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

--AYmziNP4s7M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1460?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix building test_tls_crypt with cmocka 2.0
......................................................................

Fix building test_tls_crypt with cmocka 2.0

This was missed in commit
6db186e0b1d9783ea96e8a945a47fd23b45e4778 since we
only built with cmocka 2.0 on macOS and that doesn't
build test_tls_crypt.

Now that we build with cmocka 2.0 also on Debian Sid
we noticed the additional issues.

Change-Id: Ibc964c13724316ca96276ba6b7d34dbbfcf52064
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1460
Message-Id: <20260108154248.21706-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_tls_crypt.c
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1460/2

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 4a80a4c..730841e 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -110,8 +110,8 @@
 __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
 {
     const char *pem =3D BSTR(buf);
-    check_expected(filename);
-    check_expected(pem);
+    check_expected_ptr(filename);
+    check_expected_ptr(pem);

     return mock_type(bool);
 }
@@ -119,7 +119,7 @@
 struct buffer
 __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
-    check_expected(filename);
+    check_expected_ptr(filename);

     const char *pem_str =3D mock_ptr_type(const char *);
     struct buffer ret =3D alloc_buf_gc(strlen(pem_str) + 1, gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1460?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc964c13724316ca96276ba6b7d34dbbfcf52064
Gerrit-Change-Number: 1460
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AYmziNP4s7M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1460?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Fix building test_tls_crypt with cm=
ocka 2.0<br><br>This was missed in commit<br>6db186e0b1d9783ea96e8a945a47fd=
23b45e4778 since we<br>only built with cmocka 2.0 on macOS and that doesn&#=
39;t<br>build test_tls_crypt.<br><br>Now that we build with cmocka 2.0 also=
 on Debian Sid<br>we noticed the additional issues.<br><br>Change-Id: Ibc96=
4c13724316ca96276ba6b7d34dbbfcf52064<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1460<br>Message-Id: &lt=
;20260108154248.21706-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_tls_crypt=
.c<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1460/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/un=
it_tests/openvpn/test_tls_crypt.c</span><br><span>index 4a80a4c..730841e 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@=
@ -110,8 +110,8 @@</span><br><span> __wrap_buffer_write_file(const char *fi=
lename, const struct buffer *buf)</span><br><span> {</span><br><span>     c=
onst char *pem =3D BSTR(buf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    check_expected(filename);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    check_expected(pem);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_expected_ptr(filename);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(pem);</span><br><=
span> </span><br><span>     return mock_type(bool);</span><br><span> }</spa=
n><br><span>@@ -119,7 +119,7 @@</span><br><span> struct buffer</span><br><s=
pan> __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   check_expected(filename);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_expected_ptr(filename);</span><br><span> </span><br><spa=
n>     const char *pem_str =3D mock_ptr_type(const char *);</span><br><span=
>     struct buffer ret =3D alloc_buf_gc(strlen(pem_str) + 1, gc);</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1460?usp=3Demail">change 1460</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1460?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc964c13724316ca96276ba6b7d=
34dbbfcf52064 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1460 </div>
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

--AYmziNP4s7M=--

