From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 10:48:56 +0000
References: <gerrit.1760698129000.I348abec1e2f32301a0368d5f541e67bddf358bbc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <814ad5fda8806a96a74b55bcdd851be1b3b04469-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vy7yc6soK50="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push_util: Make
 send_push_update static
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

--Vy7yc6soK50=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1282?usp=3Demail

to review the following change.


Change subject: push_util: Make send_push_update static
......................................................................

push_util: Make send_push_update static

Not necessary to make it non-static just for UTs.

Change-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_push_update_msg.c
5 files changed, 17 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1282/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b773dcb..23fb4a5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -889,7 +889,6 @@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg.c
         tests/unit_tests/openvpn/mock_get_random.c
-        src/openvpn/push_util.c
         src/openvpn/options_util.c
         src/openvpn/otime.c
         src/openvpn/list.c
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6b3275e..fa72732 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -139,23 +139,6 @@
 void receive_auth_pending(struct context *c, const struct buffer *buffer);

 #ifdef ENABLE_MANAGEMENT
-/**
- * @brief A function to send a PUSH_UPDATE control message from server to =
client(s).
- *
- * @param m the multi_context, contains all the clients connected to this =
server.
- * @param target the target to which to send the message. It should be:
- * `NULL` if `type =3D=3D UPT_BROADCAST`,
- * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,
- * a `char *` if `type =3D=3D UPT_BY_CN`,
- * an `unsigned long *` if `type =3D=3D UPT_BY_CID`.
- * @param msg a string containing the options to send.
- * @param type the way to address the message (broadcast, by cid, by cn, b=
y address).
- * @param push_bundle_size the maximum size of a bundle of pushed option. =
Just use PUSH_BUNDLE_SIZE macro.
- * @return the number of clients to which the message was sent.
- */
-int
-send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size);
-
 bool management_callback_send_push_update_broadcast(void *arg, const char =
*options);

 bool management_callback_send_push_update_by_cid(void *arg, unsigned long =
cid, const char *options);
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 25c6ebe..06b4c8b 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -204,7 +204,21 @@
     return true;
 }

-int
+/**
+ * @brief A function to send a PUSH_UPDATE control message from server to =
client(s).
+ *
+ * @param m the multi_context, contains all the clients connected to this =
server.
+ * @param target the target to which to send the message. It should be:
+ * `NULL` if `type =3D=3D UPT_BROADCAST`,
+ * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,
+ * a `char *` if `type =3D=3D UPT_BY_CN`,
+ * an `unsigned long *` if `type =3D=3D UPT_BY_CID`.
+ * @param msg a string containing the options to send.
+ * @param type the way to address the message (broadcast, by cid, by cn, b=
y address).
+ * @param push_bundle_size the maximum size of a bundle of pushed option. =
Just use PUSH_BUNDLE_SIZE macro.
+ * @return The number of clients to which the message was sent. Might retu=
rn < 0 in case of error.
+ */
+static int
 send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
 {
     if (dco_enabled(&m->top.options))
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 17aa0ce..997703a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -356,7 +356,6 @@
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/platform.c \
-	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/list.c
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 60596ed..91b60ba 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -10,6 +10,8 @@
 #include "options_util.h"
 #include "multi.h"

+#include "push_util.c"
+
 /* mocks */

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1282?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc
Gerrit-Change-Number: 1282
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Vy7yc6soK50=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1282?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push_util: Make send_push_update static<br>=
<br>Not necessary to make it non-static just for UTs.<br><br>Change-Id: I34=
8abec1e2f32301a0368d5f541e67bddf358bbc<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/push.h=
<br>M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/Makefile.am<br>=
M tests/unit_tests/openvpn/test_push_update_msg.c<br>5 files changed, 17 in=
sertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/82/1282/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CM=
akeLists.txt b/CMakeLists.txt</span><br><span>index b773dcb..23fb4a5 100644=
</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt<=
/span><br><span>@@ -889,7 +889,6 @@</span><br><span>     target_sources(tes=
t_push_update_msg PRIVATE</span><br><span>         tests/unit_tests/openvpn=
/mock_msg.c</span><br><span>         tests/unit_tests/openvpn/mock_get_rand=
om.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src/openv=
pn/push_util.c</span><br><span>         src/openvpn/options_util.c</span><b=
r><span>         src/openvpn/otime.c</span><br><span>         src/openvpn/l=
ist.c</span><br><span>diff --git a/src/openvpn/push.h b/src/openvpn/push.h<=
/span><br><span>index 6b3275e..fa72732 100644</span><br><span>--- a/src/ope=
nvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -13=
9,23 +139,6 @@</span><br><span> void receive_auth_pending(struct context *c=
, const struct buffer *buffer);</span><br><span> </span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @brief A function to=
 send a PUSH_UPDATE control message from server to client(s).</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param m the multi_context, contains all the client=
s connected to this server.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param target the target to which to send the message. It should b=
e:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * `NULL` if `type =
=3D=3D UPT_BROADCAST`,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * a `char *` if `type =3D=3D UPT_BY_CN`,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an `unsigned long *`=
 if `type =3D=3D UPT_BY_CID`.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param msg a string containing the options to send.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param type the way to address =
the message (broadcast, by cid, by cn, by address).</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param push_bundle_size the maximum size=
 of a bundle of pushed option. Just use PUSH_BUNDLE_SIZE macro.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @return the number of clients =
to which the message was sent.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-send_push_update(struct mul=
ti_context *m, const void *target, const char *msg, const push_update_type =
type, const int push_bundle_size);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> bool management_callback_send_push_update_br=
oadcast(void *arg, const char *options);</span><br><span> </span><br><span>=
 bool management_callback_send_push_update_by_cid(void *arg, unsigned long =
cid, const char *options);</span><br><span>diff --git a/src/openvpn/push_ut=
il.c b/src/openvpn/push_util.c</span><br><span>index 25c6ebe..06b4c8b 10064=
4</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/o=
penvpn/push_util.c</span><br><span>@@ -204,7 +204,21 @@</span><br><span>   =
  return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @brief A function to send a PUSH_UPDATE control message from server to c=
lient(s).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m the multi_conte=
xt, contains all the clients connected to this server.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param target the target to which to =
send the message. It should be:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * `NULL` if `type =3D=3D UPT_BROADCAST`,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * a `mroute_addr *` if `type =3D=3D UPT_=
BY_ADDR`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a `char=
 *` if `type =3D=3D UPT_BY_CN`,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * an `unsigned long *` if `type =3D=3D UPT_BY_CID`.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param msg a string contain=
ing the options to send.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param type the way to address the message (broadcast, by cid, by c=
n, by address).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param push_bundle_size the maximum size of a bundle of pushed option. Just =
use PUSH_BUNDLE_SIZE macro.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return The number of clients to which the message was sent. Mig=
ht return &lt; 0 in case of error.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic int</span><br><span> send_push_update(struct multi_context *m, const =
void *target, const char *msg, const push_update_type type, const int push_=
bundle_size)</span><br><span> {</span><br><span>     if (dco_enabled(&amp;m=
-&gt;top.options))</span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 17aa=
0ce..997703a 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=
.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><s=
pan>@@ -356,7 +356,6 @@</span><br><span> 	mock_get_random.c \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/platform.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	$(top_srcdir)/src/openvpn/push_util.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/options_util.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ot=
ime.c \</span><br><span> 	$(top_srcdir)/src/openvpn/list.c</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c</span><br><span>index 60596ed..91b60ba =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</sp=
an><br><span>@@ -10,6 +10,8 @@</span><br><span> #include &quot;options_util=
.h&quot;</span><br><span> #include &quot;multi.h&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push_ut=
il.c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* mocks */</span><br><span> </span><br><span> void</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1282?usp=3Demail">change 1282</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1282?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I348abec1e2f32301a0368d5f541=
e67bddf358bbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1282 </div>
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

--Vy7yc6soK50=--

