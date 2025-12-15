From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:55:13 +0000
In-Reply-To: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
References: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48cc315fc252b92ae18811cf4da0a67887cac78d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eXrO/qQweHM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Avoid
 several conversion warnings by using the correct types
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

--eXrO/qQweHM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: manage: Avoid several conversion warnings by using the corr=
ect types
......................................................................

manage: Avoid several conversion warnings by using the correct types

Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1438
Message-Id: <20251215152355.20654-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
077.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 10 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1438/2

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6efa100..2191e55 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -206,11 +206,6 @@
     return man->settings.up.defined && !man->connection.password_verified;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 man_check_password(struct management *man, const char *line)
 {
@@ -220,7 +215,8 @@
          * the attacker choice, it should not give any indication of the r=
eal
          * password length, use + 1 to include the NUL byte that terminate=
s the
          * string*/
-        size_t compare_len =3D min_uint(strlen(line) + 1, sizeof(man->sett=
ings.up.password));
+        size_t compare_len =3D
+            min_size(strlen(line) + 1, sizeof(man->settings.up.password));
         if (memcmp_constant_time(line, man->settings.up.password, compare_=
len) =3D=3D 0)
         {
             man->connection.password_verified =3D true;
@@ -241,10 +237,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_update_io_state(struct management *man)
 {
@@ -2315,19 +2307,14 @@

 #endif /* ifdef TARGET_ANDROID */

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-static int
+static ssize_t
 man_read(struct management *man)
 {
     /*
      * read command line from socket
      */
     unsigned char buf[256];
-    int len =3D 0;
+    ssize_t len =3D 0;

 #ifdef TARGET_ANDROID
     int fd;
@@ -2348,7 +2335,7 @@
     {
         bool processed_command =3D false;

-        ASSERT(len <=3D (int)sizeof(buf));
+        ASSERT(len <=3D (ssize_t)sizeof(buf));
         command_line_add(man->connection.in, buf, (size_t)len);

         /*
@@ -2414,11 +2401,11 @@
     return len;
 }

-static int
+static ssize_t
 man_write(struct management *man)
 {
     const int size_hint =3D 1024;
-    int sent =3D 0;
+    ssize_t sent =3D 0;
     const struct buffer *buf;

     buffer_list_aggregate(man->connection.out, size_hint);
@@ -2435,7 +2422,9 @@
         }
         else
 #endif
+        {
             sent =3D send(man->connection.sd_cli, (const void *)BPTR(buf),=
 len, MSG_NOSIGNAL);
+        }
         if (sent >=3D 0)
         {
             buffer_list_advance(man->connection.out, sent);
@@ -2457,10 +2446,6 @@
     return sent;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_connection_clear(struct man_connection *mc)
 {
@@ -3222,8 +3207,7 @@

                 if (net_events & FD_WRITE)
                 {
-                    int status;
-                    status =3D man_write(man);
+                    ssize_t status =3D man_write(man);
                     if (status < 0 && WSAGetLastError() =3D=3D WSAEWOULDBL=
OCK)
                     {
                         net_event_win32_clear_selected_events(&man->connec=
tion.ne32, FD_WRITE);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Gerrit-Change-Number: 1438
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eXrO/qQweHM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">manage: Avoid several conversion wa=
rnings by using the correct types<br><br>Change-Id: I0c5ef13d6fa6c1dd15da93=
4a33e904c2fdacb731<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1438<br>Message-Id: &lt;20251215152355.20=
654-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg35077.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 10 in=
sertions(+), 26 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/38/1438/2</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 6efa100..21=
91e55 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++=
 b/src/openvpn/manage.c</span><br><span>@@ -206,11 +206,6 @@</span><br><spa=
n>     return man-&gt;settings.up.defined &amp;&amp; !man-&gt;connection.pa=
ssword_verified;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static void</span><br><span> man_check_password(struc=
t management *man, const char *line)</span><br><span> {</span><br><span>@@ =
-220,7 +215,8 @@</span><br><span>          * the attacker choice, it should=
 not give any indication of the real</span><br><span>          * password l=
ength, use + 1 to include the NUL byte that terminates the</span><br><span>=
          * string*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       size_t compare_len =3D min_uint(strlen(line) + 1, sizeof(man-&gt;set=
tings.up.password));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        size_t compare_len =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            min_size(strlen(line) + 1, sizeof(man-&gt;settings.=
up.password));</span><br><span>         if (memcmp_constant_time(line, man-=
&gt;settings.up.password, compare_len) =3D=3D 0)</span><br><span>         {=
</span><br><span>             man-&gt;connection.password_verified =3D true=
;</span><br><span>@@ -241,10 +237,6 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> man_update_io_=
state(struct management *man)</span><br><span> {</span><br><span>@@ -2315,1=
9 +2307,14 @@</span><br><span> </span><br><span> #endif /* ifdef TARGET_AND=
ROID */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static ssize_t</span><br><span> man_read(struct mana=
gement *man)</span><br><span> {</span><br><span>     /*</span><br><span>   =
   * read command line from socket</span><br><span>      */</span><br><span=
>     unsigned char buf[256];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ssize_t len =3D 0;</span><br><span> </span><br><span> #ifdef TAR=
GET_ANDROID</span><br><span>     int fd;</span><br><span>@@ -2348,7 +2335,7=
 @@</span><br><span>     {</span><br><span>         bool processed_command =
=3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        ASSERT(len &lt;=3D (int)sizeof(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(len &lt;=3D (ssize_t)sizeo=
f(buf));</span><br><span>         command_line_add(man-&gt;connection.in, b=
uf, (size_t)len);</span><br><span> </span><br><span>         /*</span><br><=
span>@@ -2414,11 +2401,11 @@</span><br><span>     return len;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
ssize_t</span><br><span> man_write(struct management *man)</span><br><span>=
 {</span><br><span>     const int size_hint =3D 1024;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int sent =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ssize_t sent =3D 0;</span><br><span> =
    const struct buffer *buf;</span><br><span> </span><br><span>     buffer=
_list_aggregate(man-&gt;connection.out, size_hint);</span><br><span>@@ -243=
5,7 +2422,9 @@</span><br><span>         }</span><br><span>         else</sp=
an><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span>             sent =3D send(man-&gt;connection.sd=
_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span>         if (sent =
&gt;=3D 0)</span><br><span>         {</span><br><span>             buffer_l=
ist_advance(man-&gt;connection.out, sent);</span><br><span>@@ -2457,10 +244=
6,6 @@</span><br><span>     return sent;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static void</span><br><span> man_connection_clear(struct man_con=
nection *mc)</span><br><span> {</span><br><span>@@ -3222,8 +3207,7 @@</span=
><br><span> </span><br><span>                 if (net_events &amp; FD_WRITE=
)</span><br><span>                 {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    int status;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    status =3D man_write(man);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ssi=
ze_t status =3D man_write(man);</span><br><span>                     if (st=
atus &lt; 0 &amp;&amp; WSAGetLastError() =3D=3D WSAEWOULDBLOCK)</span><br><=
span>                     {</span><br><span>                         net_ev=
ent_win32_clear_selected_events(&amp;man-&gt;connection.ne32, FD_WRITE);</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1438?usp=3Demail">change 1438</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1438?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0c5ef13d6fa6c1dd15da934a33e=
904c2fdacb731 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1438 </div>
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

--eXrO/qQweHM=--

