From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:55:16 +0000
In-Reply-To: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
References: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48cc315fc252b92ae18811cf4da0a67887cac78d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bat4dxBdhxw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bat4dxBdhxw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
38?usp=3Demail )

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
=20
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Gerrit-Change-Number: 1438
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bat4dxBdhxw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1438?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">manage: Avoid several conversion warnings by usi=
ng the correct types<br><br>Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fda=
cb731<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1438<br>Message-Id: &lt;20251215152355.20654-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg35077.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 10 insertions(+), =
26 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 6efa100..2191e55 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -206,11 +206,6=
 @@</span><br><span>     return man-&gt;settings.up.defined &amp;&amp; !man=
-&gt;connection.password_verified;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> man_ch=
eck_password(struct management *man, const char *line)</span><br><span> {</=
span><br><span>@@ -220,7 +215,8 @@</span><br><span>          * the attacker=
 choice, it should not give any indication of the real</span><br><span>    =
      * password length, use + 1 to include the NUL byte that terminates th=
e</span><br><span>          * string*/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        size_t compare_len =3D min_uint(strlen(line) + 1, =
sizeof(man-&gt;settings.up.password));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t compare_len =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            min_size(strlen(line) + 1, sizeof=
(man-&gt;settings.up.password));</span><br><span>         if (memcmp_consta=
nt_time(line, man-&gt;settings.up.password, compare_len) =3D=3D 0)</span><b=
r><span>         {</span><br><span>             man-&gt;connection.password=
_verified =3D true;</span><br><span>@@ -241,10 +237,6 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><sp=
an> man_update_io_state(struct management *man)</span><br><span> {</span><b=
r><span>@@ -2315,19 +2307,14 @@</span><br><span> </span><br><span> #endif /=
* ifdef TARGET_ANDROID */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><br><span> man_=
read(struct management *man)</span><br><span> {</span><br><span>     /*</sp=
an><br><span>      * read command line from socket</span><br><span>      */=
</span><br><span>     unsigned char buf[256];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int len =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ssize_t len =3D 0;</span><br><span> </span><br><=
span> #ifdef TARGET_ANDROID</span><br><span>     int fd;</span><br><span>@@=
 -2348,7 +2335,7 @@</span><br><span>     {</span><br><span>         bool pr=
ocessed_command =3D false;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ASSERT(len &lt;=3D (int)sizeof(buf));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(len &lt;=3D=
 (ssize_t)sizeof(buf));</span><br><span>         command_line_add(man-&gt;c=
onnection.in, buf, (size_t)len);</span><br><span> </span><br><span>        =
 /*</span><br><span>@@ -2414,11 +2401,11 @@</span><br><span>     return len=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static ssize_t</span><br><span> man_write(struct management *man)</=
span><br><span> {</span><br><span>     const int size_hint =3D 1024;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int sent =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t sent =3D 0;</spa=
n><br><span>     const struct buffer *buf;</span><br><span> </span><br><spa=
n>     buffer_list_aggregate(man-&gt;connection.out, size_hint);</span><br>=
<span>@@ -2435,7 +2422,9 @@</span><br><span>         }</span><br><span>    =
     else</span><br><span> #endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span>             sent =3D send(man-&gt;=
connection.sd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
    if (sent &gt;=3D 0)</span><br><span>         {</span><br><span>        =
     buffer_list_advance(man-&gt;connection.out, sent);</span><br><span>@@ =
-2457,10 +2446,6 @@</span><br><span>     return sent;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> static void</span><br><span> man_connection_clear(s=
truct man_connection *mc)</span><br><span> {</span><br><span>@@ -3222,8 +32=
07,7 @@</span><br><span> </span><br><span>                 if (net_events &=
amp; FD_WRITE)</span><br><span>                 {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    int status;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    status =3D man_wr=
ite(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          ssize_t status =3D man_write(man);</span><br><span>              =
       if (status &lt; 0 &amp;&amp; WSAGetLastError() =3D=3D WSAEWOULDBLOCK=
)</span><br><span>                     {</span><br><span>                  =
       net_event_win32_clear_selected_events(&amp;man-&gt;connection.ne32, =
FD_WRITE);</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail">change 1438</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--Bat4dxBdhxw=--

