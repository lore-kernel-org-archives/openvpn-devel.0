From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 14:26:33 +0000
References: <gerrit.1762179991000.Ie153b3d5bf19200f225cd09131de8583645110be@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c245792164e142c9f24250c93e5b0d905d312a20-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6/WE3IXSqJA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_networking: use
 appropriate assert helpers
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

--6/WE3IXSqJA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail

to review the following change.


Change subject: test_networking: use appropriate assert helpers
......................................................................

test_networking: use appropriate assert helpers

Inall unit tests we rely on CMocka's provided assert
helpers.
However, test_networking.c was still on the default
assert() call, which we try to avoid in favour of more
appropriate helpers.

Substitute them all with assert_*() from CMocka.

Change-Id: Ie153b3d5bf19200f225cd09131de8583645110be
Reported-by: Marc Heuse <marc@...2953...>
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M tests/unit_tests/openvpn/test_networking.c
1 file changed, 7 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1342/1

diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/=
openvpn/test_networking.c
index 6a2d09f..1c9cac1 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -2,7 +2,8 @@
 #include "syshead.h"
 #include "networking.h"

-#include <assert.h>
+#include <setjmp.h>
+#include <cmocka.h>

 static char *iface =3D "ovpn-dummy0";

@@ -27,7 +28,7 @@
     int ret =3D net_iface_type(NULL, name, ret_type);
     if (ret =3D=3D 0)
     {
-        assert(strcmp(type, ret_type) =3D=3D 0);
+        assert_string_equal(type, ret_type);
     }

     return ret;
@@ -265,10 +266,10 @@

         /* following tests are standalone and do not print any CMD=3D */
         case 8:
-            assert(net__iface_new("dummy0815", "dummy") =3D=3D 0);
-            assert(net__iface_type("dummy0815", "dummy") =3D=3D 0);
-            assert(net__iface_del("dummy0815") =3D=3D 0);
-            assert(net__iface_type("dummy0815", NULL) =3D=3D -ENODEV);
+            assert_int_equal(net__iface_new("dummy0815", "dummy"), 0);
+            assert_int_equal(net__iface_type("dummy0815", "dummy"), 0);
+            assert_int_equal(net__iface_del("dummy0815"), 0);
+            assert_int_equal(net__iface_type("dummy0815", NULL), -ENODEV);
             return 0;

         default:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie153b3d5bf19200f225cd09131de8583645110be
Gerrit-Change-Number: 1342
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--6/WE3IXSqJA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_networking: use appropriate assert hel=
pers<br><br>Inall unit tests we rely on CMocka&#39;s provided assert<br>hel=
pers.<br>However, test_networking.c was still on the default<br>assert() ca=
ll, which we try to avoid in favour of more<br>appropriate helpers.<br><br>=
Substitute them all with assert_*() from CMocka.<br><br>Change-Id: Ie153b3d=
5bf19200f225cd09131de8583645110be<br>Reported-by: Marc Heuse &lt;marc@...2924...=
53...&gt;<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br=
>---<br>M tests/unit_tests/openvpn/test_networking.c<br>1 file changed, 7 i=
nsertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/42/1342/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/te=
sts/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_ne=
tworking.c</span><br><span>index 6a2d09f..1c9cac1 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/test_networking.c</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_networking.c</span><br><span>@@ -2,7 +2,8 @@</span>=
<br><span> #include &quot;syshead.h&quot;</span><br><span> #include &quot;n=
etworking.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;assert.h&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span> </span=
><br><span> static char *iface =3D &quot;ovpn-dummy0&quot;;</span><br><span=
> </span><br><span>@@ -27,7 +28,7 @@</span><br><span>     int ret =3D net_i=
face_type(NULL, name, ret_type);</span><br><span>     if (ret =3D=3D 0)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      assert(strcmp(type, ret_type) =3D=3D 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_string_equal(type, ret_type);</sp=
an><br><span>     }</span><br><span> </span><br><span>     return ret;</spa=
n><br><span>@@ -265,10 +266,10 @@</span><br><span> </span><br><span>       =
  /* following tests are standalone and do not print any CMD=3D */</span><b=
r><span>         case 8:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            assert(net__iface_new(&quot;dummy0815&quot;, &quot;dummy&quo=
t;) =3D=3D 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     assert(net__iface_type(&quot;dummy0815&quot;, &quot;dummy&quot;) =3D=
=3D 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            as=
sert(net__iface_del(&quot;dummy0815&quot;) =3D=3D 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            assert(net__iface_type(&quot;du=
mmy0815&quot;, NULL) =3D=3D -ENODEV);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            assert_int_equal(net__iface_new(&quot;dummy08=
15&quot;, &quot;dummy&quot;), 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            assert_int_equal(net__iface_type(&quot;dummy0815&=
quot;, &quot;dummy&quot;), 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            assert_int_equal(net__iface_del(&quot;dummy0815&quot=
;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
assert_int_equal(net__iface_type(&quot;dummy0815&quot;, NULL), -ENODEV);</s=
pan><br><span>             return 0;</span><br><span> </span><br><span>    =
     default:</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail">change 1342</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie153b3d5bf19200f225cd09131d=
e8583645110be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1342 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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

</body></html>=

--6/WE3IXSqJA=--

