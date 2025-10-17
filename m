From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 20:48:30 +0000
In-Reply-To: <gerrit.1760698129000.I348abec1e2f32301a0368d5f541e67bddf358bbc@...2715...>
References: <gerrit.1760698129000.I348abec1e2f32301a0368d5f541e67bddf358bbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <42d5385adda62b6314a2dcdb60cc73f88f576b6a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ePWZD+f2bx8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ePWZD+f2bx8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1282?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: push_util: Make send_push_update static
......................................................................

push_util: Make send_push_update static

Not necessary to make it non-static just for UTs.

Change-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1282
Message-Id: <20251017203830.23807-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59248152/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_push_update_msg.c
5 files changed, 17 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1282/2

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
index 19a029a..09565b8 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -140,23 +140,6 @@
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
index 0e86ad3..0eddcae 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -239,7 +239,21 @@
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
index 7fadb69..516e94c 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc
Gerrit-Change-Number: 1282
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ePWZD+f2bx8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1282?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">push_util: Make send_push_update st=
atic<br><br>Not necessary to make it non-static just for UTs.<br><br>Change=
-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1282<br>Messa=
ge-Id: &lt;20251017203830.23807-1-gert@...1296...&gt;<br>URL: https://sourc=
eforge.net/p/openvpn/mailman/message/59248152/<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/push=
.h<br>M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/Makefile.am<b=
r>M tests/unit_tests/openvpn/test_push_update_msg.c<br>5 files changed, 17 =
insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/82/1282/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists.txt b/CMakeLists.txt</span><br><span>index b773dcb..23fb4a5 1006=
44</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.tx=
t</span><br><span>@@ -889,7 +889,6 @@</span><br><span>     target_sources(t=
est_push_update_msg PRIVATE</span><br><span>         tests/unit_tests/openv=
pn/mock_msg.c</span><br><span>         tests/unit_tests/openvpn/mock_get_ra=
ndom.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src/ope=
nvpn/push_util.c</span><br><span>         src/openvpn/options_util.c</span>=
<br><span>         src/openvpn/otime.c</span><br><span>         src/openvpn=
/list.c</span><br><span>diff --git a/src/openvpn/push.h b/src/openvpn/push.=
h</span><br><span>index 19a029a..09565b8 100644</span><br><span>--- a/src/o=
penvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -=
140,23 +140,6 @@</span><br><span> void receive_auth_pending(struct context =
*c, const struct buffer *buffer);</span><br><span> </span><br><span> #ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @brief A function =
to send a PUSH_UPDATE control message from server to client(s).</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param m the multi_context, contains all the clie=
nts connected to this server.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param target the target to which to send the message. It should=
 be:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * `NULL` if `typ=
e =3D=3D UPT_BROADCAST`,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,</span><br><span style=
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
il.c b/src/openvpn/push_util.c</span><br><span>index 0e86ad3..0eddcae 10064=
4</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/o=
penvpn/push_util.c</span><br><span>@@ -239,7 +239,21 @@</span><br><span>   =
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
ests/openvpn/test_push_update_msg.c</span><br><span>index 7fadb69..516e94c =
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I348abec1e2f32301a0368d5f541=
e67bddf358bbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1282 </div>
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

--ePWZD+f2bx8=--

