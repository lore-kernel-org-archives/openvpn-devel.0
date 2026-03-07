From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 7 Mar 2026 09:11:06 +0000
In-Reply-To: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
References: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4f64808f8ece5a3fa78e6aaa6381a7655e6d6d76-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l456nFIWtFM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various
 sign-compare warnings due to write return value
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

--l456nFIWtFM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
13?usp=3Demail )

Change subject: Fix various sign-compare warnings due to write return value
......................................................................

Fix various sign-compare warnings due to write return value

write takes size_t as count (unsigned int on
Windows) and returns ssize_t (int on Windows).
But we often want to compare the return value
to the count.

Generally we can just rely on the fact that
sizeof(ssize_t) =3D=3D sizeof(size_t) and use that
for all values. (Until we want to introduce
-Wsign-conversion that is...)

Change-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1513
Message-Id: <20260306163337.2756-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
963.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ps.c
M src/openvpn/status.c
M src/plugins/auth-pam/auth-pam.c
3 files changed, 4 insertions(+), 30 deletions(-)




diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index c589248..c3f54ed 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -327,11 +327,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Record IP/port of client in filesystem, so that server receiving
  * the proxy can determine true client origin.
@@ -357,7 +352,8 @@
         int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUS=
R | S_IWUSR | S_IRGRP);
         if (fd !=3D -1)
         {
-            if (write(fd, f, strlen(f)) !=3D strlen(f))
+            ssize_t write_len =3D strlen(f);
+            if (write(fd, f, write_len) !=3D write_len)
             {
                 msg(M_WARN, "PORT SHARE: writing to journal file (%s) fail=
ed", jfn);
             }
@@ -373,10 +369,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Cleanup function, on proxy process exit.
  */
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 4d42863..c7d375b 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -206,11 +206,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512

 void
@@ -240,7 +235,7 @@
         if (so->fd >=3D 0 && !so->errors)
         {
             strcat(buf, "\n");
-            size_t len =3D strlen(buf);
+            ssize_t len =3D strlen(buf);
             if (len > 0)
             {
                 if (write(so->fd, buf, (unsigned int)len) !=3D len)
@@ -258,10 +253,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 status_read(struct status_output *so, struct buffer *buf)
 {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index 0f3346f..3b7bcc2 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -184,15 +184,10 @@
     return -1;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static ssize_t
 send_string(int fd, const char *string)
 {
-    const size_t len =3D strlen(string) + 1;
+    const ssize_t len =3D strlen(string) + 1;
     const ssize_t size =3D write(fd, string, len);
     if (size =3D=3D len)
     {
@@ -204,10 +199,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef DO_DAEMONIZE

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603
Gerrit-Change-Number: 1513
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l456nFIWtFM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1513?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix various sign-compare warnings due to write r=
eturn value<br><br>write takes size_t as count (unsigned int on<br>Windows)=
 and returns ssize_t (int on Windows).<br>But we often want to compare the =
return value<br>to the count.<br><br>Generally we can just rely on the fact=
 that<br>sizeof(ssize_t) =3D=3D sizeof(size_t) and use that<br>for all valu=
es. (Until we want to introduce<br>-Wsign-conversion that is...)<br><br>Cha=
nge-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1513<br>Me=
ssage-Id: &lt;20260306163337.2756-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35963.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ps.=
c<br>M src/openvpn/status.c<br>M src/plugins/auth-pam/auth-pam.c<br>3 files=
 changed, 4 insertions(+), 30 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index c=
589248..c3f54ed 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><sp=
an>+++ b/src/openvpn/ps.c</span><br><span>@@ -327,11 +327,6 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /*</span><br><span>  * Record IP/port of client in filesy=
stem, so that server receiving</span><br><span>  * the proxy can determine =
true client origin.</span><br><span>@@ -357,7 +352,8 @@</span><br><span>   =
      int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR |=
 S_IWUSR | S_IRGRP);</span><br><span>         if (fd !=3D -1)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (write(fd, f, strlen(f)) !=3D strlen(f))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            ssize_t write_len =3D strlen(f);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (write(=
fd, f, write_len) !=3D write_len)</span><br><span>             {</span><br>=
<span>                 msg(M_WARN, &quot;PORT SHARE: writing to journal fil=
e (%s) failed&quot;, jfn);</span><br><span>             }</span><br><span>@=
@ -373,10 +369,6 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /*</span><br><span>  * Cleanup function, on proxy process exit=
.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/status.c b/=
src/openvpn/status.c</span><br><span>index 4d42863..c7d375b 100644</span><b=
r><span>--- a/src/openvpn/status.c</span><br><span>+++ b/src/openvpn/status=
.c</span><br><span>@@ -206,11 +206,6 @@</span><br><span>     return ret;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #define STATUS_PRINTF_MAXLEN 512</span><br><span> </span><br><span> vo=
id</span><br><span>@@ -240,7 +235,7 @@</span><br><span>         if (so-&gt;=
fd &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br><span>         {</span><b=
r><span>             strcat(buf, &quot;\n&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            size_t len =3D strlen(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ssize_t len =3D=
 strlen(buf);</span><br><span>             if (len &gt; 0)</span><br><span>=
             {</span><br><span>                 if (write(so-&gt;fd, buf, (=
unsigned int)len) !=3D len)</span><br><span>@@ -258,10 +253,6 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><s=
pan> status_read(struct status_output *so, struct buffer *buf)</span><br><s=
pan> {</span><br><span>diff --git a/src/plugins/auth-pam/auth-pam.c b/src/p=
lugins/auth-pam/auth-pam.c</span><br><span>index 0f3346f..3b7bcc2 100644</s=
pan><br><span>--- a/src/plugins/auth-pam/auth-pam.c</span><br><span>+++ b/s=
rc/plugins/auth-pam/auth-pam.c</span><br><span>@@ -184,15 +184,10 @@</span>=
<br><span>     return -1;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static ssize_t</span><br><span> send_str=
ing(int fd, const char *string)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const size_t len =3D strlen(string) + 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t len=
 =3D strlen(string) + 1;</span><br><span>     const ssize_t size =3D write(=
fd, string, len);</span><br><span>     if (size =3D=3D len)</span><br><span=
>     {</span><br><span>@@ -204,10 +199,6 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> #ifdef DO_DAEMONIZE</span><br><span=
> </span><br><span> /*</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail">change 15=
13</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3eb4581980f532cb2960b37a6fa=
43a7baee4b603 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1513 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--l456nFIWtFM=--

