From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 11:20:15 +0000
References: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bc77c7cb8aa638c7f6fa6f3917788264831f65fc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6VJCiv6KKq0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6VJCiv6KKq0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail

to review the following change.


Change subject: manage: Avoid several conversion warnings by using the corr=
ect types
......................................................................

manage: Avoid several conversion warnings by using the correct types

Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
1 file changed, 10 insertions(+), 26 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1438/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Gerrit-Change-Number: 1438
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6VJCiv6KKq0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1438?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">manage: Avoid several conversion warnings b=
y using the correct types<br><br>Change-Id: I0c5ef13d6fa6c1dd15da934a33e904=
c2fdacb731<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
---<br>M src/openvpn/manage.c<br>1 file changed, 10 insertions(+), 26 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/38/1438/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/=
src/openvpn/manage.c</span><br><span>index 6efa100..2191e55 100644</span><b=
r><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage=
.c</span><br><span>@@ -206,11 +206,6 @@</span><br><span>     return man-&gt=
;settings.up.defined &amp;&amp; !man-&gt;connection.password_verified;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 static void</span><br><span> man_check_password(struct management *man, co=
nst char *line)</span><br><span> {</span><br><span>@@ -220,7 +215,8 @@</spa=
n><br><span>          * the attacker choice, it should not give any indicat=
ion of the real</span><br><span>          * password length, use + 1 to inc=
lude the NUL byte that terminates the</span><br><span>          * string*/<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t compare=
_len =3D min_uint(strlen(line) + 1, sizeof(man-&gt;settings.up.password));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t compa=
re_len =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   min_size(strlen(line) + 1, sizeof(man-&gt;settings.up.password));</span>=
<br><span>         if (memcmp_constant_time(line, man-&gt;settings.up.passw=
ord, compare_len) =3D=3D 0)</span><br><span>         {</span><br><span>    =
         man-&gt;connection.password_verified =3D true;</span><br><span>@@ =
-241,10 +237,6 @@</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static void</span><br><span> man_update_io_state(struct manageme=
nt *man)</span><br><span> {</span><br><span>@@ -2315,19 +2307,14 @@</span><=
br><span> </span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static ssize_t</span><br><span> man_read(struct management *man)</span><b=
r><span> {</span><br><span>     /*</span><br><span>      * read command lin=
e from socket</span><br><span>      */</span><br><span>     unsigned char b=
uf[256];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t l=
en =3D 0;</span><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><b=
r><span>     int fd;</span><br><span>@@ -2348,7 +2335,7 @@</span><br><span>=
     {</span><br><span>         bool processed_command =3D false;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSER=
T(len &lt;=3D (int)sizeof(buf));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        ASSERT(len &lt;=3D (ssize_t)sizeof(buf));</span><br><s=
pan>         command_line_add(man-&gt;connection.in, buf, (size_t)len);</sp=
an><br><span> </span><br><span>         /*</span><br><span>@@ -2414,11 +240=
1,11 @@</span><br><span>     return len;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><br><sp=
an> man_write(struct management *man)</span><br><span> {</span><br><span>  =
   const int size_hint =3D 1024;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int sent =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ssize_t sent =3D 0;</span><br><span>     const struct buffer=
 *buf;</span><br><span> </span><br><span>     buffer_list_aggregate(man-&gt=
;connection.out, size_hint);</span><br><span>@@ -2435,7 +2422,9 @@</span><b=
r><span>         }</span><br><span>         else</span><br><span> #endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan>             sent =3D send(man-&gt;connection.sd_cli, (const void *)BPT=
R(buf), len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span>         if (sent &gt;=3D 0)</span><br><s=
pan>         {</span><br><span>             buffer_list_advance(man-&gt;con=
nection.out, sent);</span><br><span>@@ -2457,10 +2446,6 @@</span><br><span>=
     return sent;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void<=
/span><br><span> man_connection_clear(struct man_connection *mc)</span><br>=
<span> {</span><br><span>@@ -3222,8 +3207,7 @@</span><br><span> </span><br>=
<span>                 if (net_events &amp; FD_WRITE)</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    status =3D man_write(man);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    ssize_t status =3D man_wri=
te(man);</span><br><span>                     if (status &lt; 0 &amp;&amp; =
WSAGetLastError() =3D=3D WSAEWOULDBLOCK)</span><br><span>                  =
   {</span><br><span>                         net_event_win32_clear_selecte=
d_events(&amp;man-&gt;connection.ne32, FD_WRITE);</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1438?usp=3Demail">change 1438</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/143=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0c5ef13d6fa6c1dd15da934a33e=
904c2fdacb731 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1438 </div>
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

--6VJCiv6KKq0=--

