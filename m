From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 8 Jan 2026 12:29:39 +0000
References: <gerrit.1767875377000.Ibc964c13724316ca96276ba6b7d34dbbfcf52064@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <970cb20104185eed6a00c248c6fd923439fb2043-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oEVl+JLzg40="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oEVl+JLzg40=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1460?usp=3Demail

to review the following change.


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
---
M tests/unit_tests/openvpn/test_tls_crypt.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1460/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc964c13724316ca96276ba6b7d34dbbfcf52064
Gerrit-Change-Number: 1460
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--oEVl+JLzg40=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1460?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix building test_tls_crypt with cmocka 2.0=
<br><br>This was missed in commit<br>6db186e0b1d9783ea96e8a945a47fd23b45e47=
78 since we<br>only built with cmocka 2.0 on macOS and that doesn&#39;t<br>=
build test_tls_crypt.<br><br>Now that we build with cmocka 2.0 also on Debi=
an Sid<br>we noticed the additional issues.<br><br>Change-Id: Ibc964c137243=
16ca96276ba6b7d34dbbfcf52064<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>1 f=
ile changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1460/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/=
openvpn/test_tls_crypt.c</span><br><span>index 4a80a4c..730841e 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -110,8 =
+110,8 @@</span><br><span> __wrap_buffer_write_file(const char *filename, c=
onst struct buffer *buf)</span><br><span> {</span><br><span>     const char=
 *pem =3D BSTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   check_expected(filename);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    check_expected(pem);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    check_expected_ptr(filename);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    check_expected_ptr(pem);</span><br><span> </s=
pan><br><span>     return mock_type(bool);</span><br><span> }</span><br><sp=
an>@@ -119,7 +119,7 @@</span><br><span> struct buffer</span><br><span> __wr=
ap_buffer_read_from_file(const char *filename, struct gc_arena *gc)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_=
expected(filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    check_expected_ptr(filename);</span><br><span> </span><br><span>     co=
nst char *pem_str =3D mock_ptr_type(const char *);</span><br><span>     str=
uct buffer ret =3D alloc_buf_gc(strlen(pem_str) + 1, gc);</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1460?usp=3Demail">change 1460</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1460?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc964c13724316ca96276ba6b7d=
34dbbfcf52064 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1460 </div>
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

--oEVl+JLzg40=--

