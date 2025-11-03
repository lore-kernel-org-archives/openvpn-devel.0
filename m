From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 15:33:30 +0000
In-Reply-To: <gerrit.1762179991000.Ie153b3d5bf19200f225cd09131de8583645110be@...2715...>
References: <gerrit.1762179991000.Ie153b3d5bf19200f225cd09131de8583645110be@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <71892ff514226dc76f186085f67537f33bdeac87-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ul1koRRDtWQ="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ul1koRRDtWQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
42?usp=3Demail )

Change subject: test_networking: use appropriate assert helpers
......................................................................

test_networking: use appropriate assert helpers

In all unit tests we rely on CMocka's provided assert helpers.

However, test_networking.c was still on the default assert() call,
which we try to avoid in favour of more appropriate helpers.

Substitute them all with assert_*() from CMocka.

Change-Id: Ie153b3d5bf19200f225cd09131de8583645110be
Reported-by: Marc Heuse <marc@...2953...>
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1342
Message-Id: <20251103145842.22969-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
155.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_networking.c
1 file changed, 7 insertions(+), 6 deletions(-)




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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie153b3d5bf19200f225cd09131de8583645110be
Gerrit-Change-Number: 1342
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ul1koRRDtWQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1342?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_networking: use appropriate assert helpers<=
br><br>In all unit tests we rely on CMocka&#39;s provided assert helpers.<b=
r><br>However, test_networking.c was still on the default assert() call,<br=
>which we try to avoid in favour of more appropriate helpers.<br><br>Substi=
tute them all with assert_*() from CMocka.<br><br>Change-Id: Ie153b3d5bf192=
00f225cd09131de8583645110be<br>Reported-by: Marc Heuse &lt;marc@...2953...&=
gt;<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1342<br>Message-Id: &lt;20251103145842.22969-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg34155.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_networking.c<br>1 file=
 changed, 7 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tes=
ts/openvpn/test_networking.c</span><br><span>index 6a2d09f..1c9cac1 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_networking.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_networking.c</span><br><span>@@ -=
2,7 +2,8 @@</span><br><span> #include &quot;syshead.h&quot;</span><br><span=
> #include &quot;networking.h&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;assert.h&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span=
><br><span> </span><br><span> static char *iface =3D &quot;ovpn-dummy0&quot=
;;</span><br><span> </span><br><span>@@ -27,7 +28,7 @@</span><br><span>    =
 int ret =3D net_iface_type(NULL, name, ret_type);</span><br><span>     if =
(ret =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        assert(strcmp(type, ret_type) =3D=3D 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equal(ty=
pe, ret_type);</span><br><span>     }</span><br><span> </span><br><span>   =
  return ret;</span><br><span>@@ -265,10 +266,10 @@</span><br><span> </span=
><br><span>         /* following tests are standalone and do not print any =
CMD=3D */</span><br><span>         case 8:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            assert(net__iface_new(&quot;dummy0815&quot=
;, &quot;dummy&quot;) =3D=3D 0);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            assert(net__iface_type(&quot;dummy0815&quot;, &quot;=
dummy&quot;) =3D=3D 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            assert(net__iface_del(&quot;dummy0815&quot;) =3D=3D 0);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert(net__ifa=
ce_type(&quot;dummy0815&quot;, NULL) =3D=3D -ENODEV);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(net__iface_n=
ew(&quot;dummy0815&quot;, &quot;dummy&quot;), 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            assert_int_equal(net__iface_type(=
&quot;dummy0815&quot;, &quot;dummy&quot;), 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            assert_int_equal(net__iface_del(&quo=
t;dummy0815&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            assert_int_equal(net__iface_type(&quot;dummy0815&quot;, NUL=
L), -ENODEV);</span><br><span>             return 0;</span><br><span> </spa=
n><br><span>         default:</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail">ch=
ange 1342</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1342?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie153b3d5bf19200f225cd09131d=
e8583645110be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1342 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ul1koRRDtWQ=--

