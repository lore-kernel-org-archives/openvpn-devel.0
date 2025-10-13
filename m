From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 16:33:10 +0000
In-Reply-To: <gerrit.1760359115000.Ia836e3c05a868a7e8419c2bb2f547d968260783c@...2715...>
References: <gerrit.1760359115000.Ia836e3c05a868a7e8419c2bb2f547d968260783c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <346bb6396f3a1c297acbe5c7a6e43a5cb8d9ec0f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EJqz5mj6FAg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: Change some
 APIs to use DWORD instead of size_t
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

--EJqz5mj6FAg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1269?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: win32: Change some APIs to use DWORD instead of size_t
......................................................................

win32: Change some APIs to use DWORD instead of size_t

This is what the Win32 APIs use. Since we put static
integers into this (e.g. sizeof()) this doesn't
result in new conversion warnings at the caller sites.

Change-Id: Ia836e3c05a868a7e8419c2bb2f547d968260783c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1269
Message-Id: <20251013162221.2156-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59246222/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
M src/openvpn/win32.c
M src/openvpn/win32.h
M tests/unit_tests/openvpn/test_user_pass.c
4 files changed, 20 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1269/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ae9aaac..7d988da 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2840,7 +2840,7 @@

 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR o=
n error */
 static int
-do_route_service(const bool add, const route_message_t *rt, const size_t s=
ize, HANDLE pipe)
+do_route_service(const bool add, const route_message_t *rt, const DWORD si=
ze, HANDLE pipe)
 {
     int ret =3D RTA_ERROR;
     ack_message_t ack;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eac2352..3c11ec3 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1418,13 +1418,8 @@
     return (const char *)out.data;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
-send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_message_=
t *ack,
+send_msg_iservice(HANDLE pipe, const void *data, DWORD size, ack_message_t=
 *ack,
                   const char *context)
 {
     struct gc_arena gc =3D gc_new();
@@ -1527,7 +1522,8 @@

     while (expire >=3D now)
     {
-        DWORD status =3D WaitForSingleObject(win32_signal.in.read, (expire=
 - now) * 1000);
+        DWORD wait_ms =3D (DWORD)((expire - now) * 1000);
+        DWORD status =3D WaitForSingleObject(win32_signal.in.read, wait_ms=
);
         if ((status =3D=3D WAIT_OBJECT_0 && win32_signal_get(&win32_signal=
)) || status =3D=3D WAIT_TIMEOUT)
         {
             return;
@@ -1539,7 +1535,7 @@
         {
             if (expire > now)
             {
-                Sleep((expire - now) * 1000);
+                Sleep((DWORD)((expire - now) * 1000));
             }
             return;
         }
@@ -1602,7 +1598,7 @@
 }

 bool
-protect_buffer_win32(char *buf, size_t len)
+protect_buffer_win32(char *buf, DWORD len)
 {
     bool ret;
     if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
@@ -1620,7 +1616,7 @@
 }

 bool
-unprotect_buffer_win32(char *buf, size_t len)
+unprotect_buffer_win32(char *buf, DWORD len)
 {
     bool ret;
     if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
@@ -1637,8 +1633,4 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index ff3145a..07a58d8 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -301,12 +301,14 @@
  */
 const char *win32_version_string(struct gc_arena *gc);

-/*
- * Send the |size| bytes in buffer |data| to the interactive service |pipe|
- * and read the result in |ack|. Returns false on communication error.
- * The string in |context| is used to prefix error messages.
+/**
+ * Send the \p size bytes in buffer \p data to the interactive service \p =
pipe
+ * and read the result in \p ack.
+ * The string in \p context is used to prefix error messages.
+ *
+ * @return true on success, false on communication error
  */
-bool send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_mes=
sage_t *ack,
+bool send_msg_iservice(HANDLE pipe, const void *data, DWORD size, ack_mess=
age_t *ack,
                        const char *context);

 /*
@@ -350,7 +352,7 @@
  * - len   number of bytes to encrypt -- must be a multiple of
  *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16
  */
-bool protect_buffer_win32(char *buf, size_t len);
+bool protect_buffer_win32(char *buf, DWORD len);

 /**
  * Decrypt a previously encrypted region of memory using CryptUnProtectMem=
ory()
@@ -360,7 +362,7 @@
  * - len   number of bytes to encrypt -- must be a multiple of
  *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16
  */
-bool unprotect_buffer_win32(char *buf, size_t len);
+bool unprotect_buffer_win32(char *buf, DWORD len);

 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index f5dddd6..abe223c 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -79,17 +79,19 @@
     return 0;
 }

+#ifdef _WIN32
 bool
-protect_buffer_win32(char *buf, size_t len)
+protect_buffer_win32(char *buf, DWORD len)
 {
     return true;
 }

 bool
-unprotect_buffer_win32(char *buf, size_t len)
+unprotect_buffer_win32(char *buf, DWORD len)
 {
     return true;
 }
+#endif

 /* tooling */
 static void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1269?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia836e3c05a868a7e8419c2bb2f547d968260783c
Gerrit-Change-Number: 1269
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EJqz5mj6FAg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1269?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">win32: Change some APIs to use DWOR=
D instead of size_t<br><br>This is what the Win32 APIs use. Since we put st=
atic<br>integers into this (e.g. sizeof()) this doesn&#39;t<br>result in ne=
w conversion warnings at the caller sites.<br><br>Change-Id: Ia836e3c05a868=
a7e8419c2bb2f547d968260783c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1269<br>Message-Id: &lt;20251013=
162221.2156-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn=
/mailman/message/59246222/<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/win32.c<br>M src/op=
envpn/win32.h<br>M tests/unit_tests/openvpn/test_user_pass.c<br>4 files cha=
nged, 20 insertions(+), 24 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1269/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index ae=
9aaac..7d988da 100644</span><br><span>--- a/src/openvpn/route.c</span><br><=
span>+++ b/src/openvpn/route.c</span><br><span>@@ -2840,7 +2840,7 @@</span>=
<br><span> </span><br><span> /* Returns RTA_SUCCESS on success, RTA_EEXIST =
if route exists, RTA_ERROR on error */</span><br><span> static int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-do_route_service(const bool ad=
d, const route_message_t *rt, const size_t size, HANDLE pipe)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+do_route_service(const bool add, =
const route_message_t *rt, const DWORD size, HANDLE pipe)</span><br><span> =
{</span><br><span>     int ret =3D RTA_ERROR;</span><br><span>     ack_mess=
age_t ack;</span><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/w=
in32.c</span><br><span>index eac2352..3c11ec3 100644</span><br><span>--- a/=
src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><sp=
an>@@ -1418,13 +1418,8 @@</span><br><span>     return (const char *)out.dat=
a;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_msg_=
iservice(HANDLE pipe, const void *data, size_t size, ack_message_t *ack,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+send_msg_iservice(HAND=
LE pipe, const void *data, DWORD size, ack_message_t *ack,</span><br><span>=
                   const char *context)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>@@ -1527,7 +1522,8 @@=
</span><br><span> </span><br><span>     while (expire &gt;=3D now)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 DWORD status =3D WaitForSingleObject(win32_signal.in.read, (expire - now) =
* 1000);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWO=
RD wait_ms =3D (DWORD)((expire - now) * 1000);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        DWORD status =3D WaitForSingleObject(win=
32_signal.in.read, wait_ms);</span><br><span>         if ((status =3D=3D WA=
IT_OBJECT_0 &amp;&amp; win32_signal_get(&amp;win32_signal)) || status =3D=
=3D WAIT_TIMEOUT)</span><br><span>         {</span><br><span>             r=
eturn;</span><br><span>@@ -1539,7 +1535,7 @@</span><br><span>         {</sp=
an><br><span>             if (expire &gt; now)</span><br><span>            =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                Sle=
ep((expire - now) * 1000);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                Sleep((DWORD)((expire - now) * 1000));</span><br><sp=
an>             }</span><br><span>             return;</span><br><span>    =
     }</span><br><span>@@ -1602,7 +1598,7 @@</span><br><span> }</span><br><=
span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-protect_buffer_win32(char *buf, size_t len)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+protect_buffer_win32(char *buf, DWORD len)</=
span><br><span> {</span><br><span>     bool ret;</span><br><span>     if (l=
en % CRYPTPROTECTMEMORY_BLOCK_SIZE)</span><br><span>@@ -1620,7 +1616,7 @@</=
span><br><span> }</span><br><span> </span><br><span> bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-unprotect_buffer_win32(char *buf, size_=
t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unprotect_buf=
fer_win32(char *buf, DWORD len)</span><br><span> {</span><br><span>     boo=
l ret;</span><br><span>     if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)</span>=
<br><span>@@ -1637,8 +1633,4 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #endif /* ifdef _WIN32 */</span><br><spa=
n>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><br><span>in=
dex ff3145a..07a58d8 100644</span><br><span>--- a/src/openvpn/win32.h</span=
><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -301,12 +301,14 @@<=
/span><br><span>  */</span><br><span> const char *win32_version_string(stru=
ct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Se=
nd the |size| bytes in buffer |data| to the interactive service |pipe|</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * and read the result in =
|ack|. Returns false on communication error.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * The string in |context| is used to prefix error m=
essages.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Send the \p size bytes i=
n buffer \p data to the interactive service \p pipe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and read the result in \p ack.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * The string in \p context=
 is used to prefix error messages.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return true on success, false on communication error</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_msg_iservic=
e(HANDLE pipe, const void *data, size_t size, ack_message_t *ack,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool send_msg_iservice(HANDLE=
 pipe, const void *data, DWORD size, ack_message_t *ack,</span><br><span>  =
                      const char *context);</span><br><span> </span><br><sp=
an> /*</span><br><span>@@ -350,7 +352,7 @@</span><br><span>  * - len   numb=
er of bytes to encrypt -- must be a multiple of</span><br><span>  *        =
 CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool protect_buffer_win32(char *buf, s=
ize_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool pro=
tect_buffer_win32(char *buf, DWORD len);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Decrypt a previously encrypted region of memory us=
ing CryptUnProtectMemory()</span><br><span>@@ -360,7 +362,7 @@</span><br><s=
pan>  * - len   number of bytes to encrypt -- must be a multiple of</span><=
br><span>  *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool unprotect_buf=
fer_win32(char *buf, size_t len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool unprotect_buffer_win32(char *buf, DWORD len);</span><br>=
<span> </span><br><span> #endif /* ifndef OPENVPN_WIN32_H */</span><br><spa=
n> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span>=
<br><span>index f5dddd6..abe223c 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_user_pass.c</span><br><span>@@ -79,17 +79,19 @@</span><br><span>     =
return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-protect_buffer_win32(char *buf, si=
ze_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protect_bu=
ffer_win32(char *buf, DWORD len)</span><br><span> {</span><br><span>     re=
turn true;</span><br><span> }</span><br><span> </span><br><span> bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-unprotect_buffer_win32(char=
 *buf, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
nprotect_buffer_win32(char *buf, DWORD len)</span><br><span> {</span><br><s=
pan>     return true;</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* tooling *=
/</span><br><span> static void</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1269?usp=3Demail">c=
hange 1269</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1269?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia836e3c05a868a7e8419c2bb2f5=
47d968260783c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1269 </div>
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

--EJqz5mj6FAg=--

