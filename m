From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 12:32:06 +0000
In-Reply-To: <gerrit.1758637530000.Ic395b6d1dce510bb4b499c5beba61f033a2a860b@...2715...>
References: <gerrit.1758637530000.Ic395b6d1dce510bb4b499c5beba61f033a2a860b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2734cda492ae72832778adf241278b6251d46404-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dsGv0Y2vG4k="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dsGv0Y2vG4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1208?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by d12fk


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
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1208
Message-Id: <20250924121901.13532-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59238099/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 5 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1208/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--dsGv0Y2vG4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1208?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by d12fk</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns: Fix bug in error handling when talking to scrip=
t<br><br>Comparing the result of read/write to a size_t value<br>is dangero=
us C. Since ssize_t and size_t have the same<br>size ssize_t is promoted to=
 size_t, so -1 becomes<br>size_t max value and is not smaller than the expe=
cted<br>length.<br><br>Make sure to compare ssize_t to ssize_t to avoid any=
<br>suprises.<br><br>Change-Id: Ic395b6d1dce510bb4b499c5beba61f033a2a860b<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: He=
iko Hund &lt;heiko@...515...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/=
c/openvpn/+/1208<br>Message-Id: &lt;20250924121901.13532-1-gert@...1296...&=
gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59238099/<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
/dns.c<br>1 file changed, 5 insertions(+), 6 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1208/2</pre><pre s=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--dsGv0Y2vG4k=--

