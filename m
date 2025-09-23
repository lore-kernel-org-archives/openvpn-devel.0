From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 14:25:32 +0000
References: <gerrit.1758637530000.Ic395b6d1dce510bb4b499c5beba61f033a2a860b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e25956b684c63998ff8345f2798fa7d08078d61a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sZKxG62k/Oo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: Fix bug in
 error handling when talking to script
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

--sZKxG62k/Oo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1208?usp=3Demail

to review the following change.


Change subject: dns: Fix bug in error handling when talking to script
......................................................................

dns: Fix bug in error handling when talking to script

Comparing the result of read/write to a size_t value
is dangerous C. Since ssize_t and size_t have the same
size ssize_t is promoted to size_t, so -1 becomes
size_t max value and is not smaller than the expected
length.

Make sure to compare ssize_t to ssize_t to avoid any
suprises.

Change-Id: Ic395b6d1dce510bb4b499c5beba61f033a2a860b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dns.c
1 file changed, 5 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1208/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index efb888a..2a9e60b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -642,11 +642,10 @@

         while (1)
         {
-            ssize_t rlen, wlen;
             char path[PATH_MAX];

             /* Block here until parent sends a path */
-            rlen =3D read(dns_pipe_fd[0], &path, sizeof(path));
+            ssize_t rlen =3D read(dns_pipe_fd[0], &path, sizeof(path));
             if (rlen < 1)
             {
                 if (rlen =3D=3D -1 && errno =3D=3D EINTR)
@@ -665,8 +664,8 @@
             /* Unblock parent process */
             while (1)
             {
-                wlen =3D write(ack_pipe_fd[1], &res, sizeof(res));
-                if ((wlen =3D=3D -1 && errno !=3D EINTR) || wlen < sizeof(=
res))
+                ssize_t wlen =3D write(ack_pipe_fd[1], &res, sizeof(res));
+                if ((wlen =3D=3D -1 && errno !=3D EINTR) || wlen < (ssize_=
t)sizeof(res))
                 {
                     /* Not much we can do about errors but exit */
                     close(dns_pipe_fd[0]);
@@ -727,7 +726,7 @@
         env_set_write_file(dvf, es);

         int wfd =3D updown_runner->fds[1];
-        size_t dvf_size =3D strlen(dvf) + 1;
+        ssize_t dvf_size =3D strlen(dvf) + 1;
         while (1)
         {
             ssize_t len =3D write(wfd, dvf, dvf_size);
@@ -746,7 +745,7 @@
         while (1)
         {
             ssize_t len =3D read(rfd, &status, sizeof(status));
-            if (len < sizeof(status))
+            if (len < (ssize_t)sizeof(status))
             {
                 if (len =3D=3D -1 && errno =3D=3D EINTR)
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1208?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic395b6d1dce510bb4b499c5beba61f033a2a860b
Gerrit-Change-Number: 1208
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--sZKxG62k/Oo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1208?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: Fix bug in error handling when talking to script<br><br=
>Comparing the result of read/write to a size_t value<br>is dangerous C. Si=
nce ssize_t and size_t have the same<br>size ssize_t is promoted to size_t,=
 so -1 becomes<br>size_t max value and is not smaller than the expected<br>=
length.<br><br>Make sure to compare ssize_t to ssize_t to avoid any<br>supr=
ises.<br><br>Change-Id: Ic395b6d1dce510bb4b499c5beba61f033a2a860b<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn=
/dns.c<br>1 file changed, 5 insertions(+), 6 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1208/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index efb88=
8a..2a9e60b 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>=
+++ b/src/openvpn/dns.c</span><br><span>@@ -642,11 +642,10 @@</span><br><sp=
an> </span><br><span>         while (1)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ssize_t rlen, wlen=
;</span><br><span>             char path[PATH_MAX];</span><br><span> </span=
><br><span>             /* Block here until parent sends a path */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            rlen =3D read(dns_=
pipe_fd[0], &amp;path, sizeof(path));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ssize_t rlen =3D read(dns_pipe_fd[0], &amp;pa=
th, sizeof(path));</span><br><span>             if (rlen &lt; 1)</span><br>=
<span>             {</span><br><span>                 if (rlen =3D=3D -1 &a=
mp;&amp; errno =3D=3D EINTR)</span><br><span>@@ -665,8 +664,8 @@</span><br>=
<span>             /* Unblock parent process */</span><br><span>           =
  while (1)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                wlen =3D write(ack_pipe_fd[1], &amp;re=
s, sizeof(res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if ((wlen =3D=3D -1 &amp;&amp; errno !=3D EINTR) || wlen &lt; si=
zeof(res))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       ssize_t wlen =3D write(ack_pipe_fd[1], &amp;res, sizeof(res));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if ((wlen=
 =3D=3D -1 &amp;&amp; errno !=3D EINTR) || wlen &lt; (ssize_t)sizeof(res))<=
/span><br><span>                 {</span><br><span>                     /* =
Not much we can do about errors but exit */</span><br><span>               =
      close(dns_pipe_fd[0]);</span><br><span>@@ -727,7 +726,7 @@</span><br>=
<span>         env_set_write_file(dvf, es);</span><br><span> </span><br><sp=
an>         int wfd =3D updown_runner-&gt;fds[1];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        size_t dvf_size =3D strlen(dvf) + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssize_t dvf_si=
ze =3D strlen(dvf) + 1;</span><br><span>         while (1)</span><br><span>=
         {</span><br><span>             ssize_t len =3D write(wfd, dvf, dvf=
_size);</span><br><span>@@ -746,7 +745,7 @@</span><br><span>         while =
(1)</span><br><span>         {</span><br><span>             ssize_t len =3D=
 read(rfd, &amp;status, sizeof(status));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (len &lt; sizeof(status))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (len &lt; (ssize_t)s=
izeof(status))</span><br><span>             {</span><br><span>             =
    if (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span>      =
           {</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1208?usp=3Demail">change 1208</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1208?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic395b6d1dce510bb4b499c5beba=
61f033a2a860b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1208 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--sZKxG62k/Oo=--

