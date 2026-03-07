From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 7 Mar 2026 09:11:03 +0000
In-Reply-To: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
References: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4f64808f8ece5a3fa78e6aaa6381a7655e6d6d76-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eDqr4UWiAZE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eDqr4UWiAZE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1513/4

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
=20
 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603
Gerrit-Change-Number: 1513
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eDqr4UWiAZE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Fix various sign-compare warnings d=
ue to write return value<br><br>write takes size_t as count (unsigned int o=
n<br>Windows) and returns ssize_t (int on Windows).<br>But we often want to=
 compare the return value<br>to the count.<br><br>Generally we can just rel=
y on the fact that<br>sizeof(ssize_t) =3D=3D sizeof(size_t) and use that<br=
>for all values. (Until we want to introduce<br>-Wsign-conversion that is..=
.)<br><br>Change-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn=
/+/1513<br>Message-Id: &lt;20260306163337.2756-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35963=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/ps.c<br>M src/openvpn/status.c<br>M src/plugins/auth-pam/auth-pam=
.c<br>3 files changed, 4 insertions(+), 30 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/151=
3/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><spa=
n>index c589248..c3f54ed 100644</span><br><span>--- a/src/openvpn/ps.c</spa=
n><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -327,11 +327,6 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * Record IP/port of client =
in filesystem, so that server receiving</span><br><span>  * the proxy can d=
etermine true client origin.</span><br><span>@@ -357,7 +352,8 @@</span><br>=
<span>         int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, =
S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span>         if (fd !=3D -1)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (write(fd, f, strlen(f)) !=3D strlen(f))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ssize_t write_len =3D strl=
en(f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (write(fd, f, write_len) !=3D write_len)</span><br><span>             {</=
span><br><span>                 msg(M_WARN, &quot;PORT SHARE: writing to jo=
urnal file (%s) failed&quot;, jfn);</span><br><span>             }</span><b=
r><span>@@ -373,10 +369,6 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /*</span><br><span>  * Cleanup function, on proxy pro=
cess exit.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/st=
atus.c b/src/openvpn/status.c</span><br><span>index 4d42863..c7d375b 100644=
</span><br><span>--- a/src/openvpn/status.c</span><br><span>+++ b/src/openv=
pn/status.c</span><br><span>@@ -206,11 +206,6 @@</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #define STATUS_PRINTF_MAXLEN 512</span><br><span> </span><br>=
<span> void</span><br><span>@@ -240,7 +235,7 @@</span><br><span>         if=
 (so-&gt;fd &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br><span>         {=
</span><br><span>             strcat(buf, &quot;\n&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            size_t len =3D strlen(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ssize_=
t len =3D strlen(buf);</span><br><span>             if (len &gt; 0)</span><=
br><span>             {</span><br><span>                 if (write(so-&gt;f=
d, buf, (unsigned int)len) !=3D len)</span><br><span>@@ -258,10 +253,6 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</sp=
an><br><span> status_read(struct status_output *so, struct buffer *buf)</sp=
an><br><span> {</span><br><span>diff --git a/src/plugins/auth-pam/auth-pam.=
c b/src/plugins/auth-pam/auth-pam.c</span><br><span>index 0f3346f..3b7bcc2 =
100644</span><br><span>--- a/src/plugins/auth-pam/auth-pam.c</span><br><spa=
n>+++ b/src/plugins/auth-pam/auth-pam.c</span><br><span>@@ -184,15 +184,10 =
@@</span><br><span>     return -1;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> static ssize_t</span><br><span> s=
end_string(int fd, const char *string)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const size_t len =3D strlen(string)=
 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ssiz=
e_t len =3D strlen(string) + 1;</span><br><span>     const ssize_t size =3D=
 write(fd, string, len);</span><br><span>     if (size =3D=3D len)</span><b=
r><span>     {</span><br><span>@@ -204,10 +199,6 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> #ifdef DO_DAEMONIZE</span><br>=
<span> </span><br><span> /*</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail">chan=
ge 1513</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1513?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--eDqr4UWiAZE=--

