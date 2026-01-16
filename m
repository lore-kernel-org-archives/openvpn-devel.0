From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 16 Jan 2026 14:05:47 +0000
In-Reply-To: <gerrit.1768318939000.I5eac1b31ae40eb957e2c12ca6c37b491fef32847@...2715...>
References: <gerrit.1768318939000.I5eac1b31ae40eb957e2c12ca6c37b491fef32847@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <64bb4f7a15e8fb59b24b357a35d8a2becdd8b0c1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UBfVOg9S978="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: port-share: Check
 return value of fork()
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

--UBfVOg9S978=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: port-share: Check return value of fork()
......................................................................

port-share: Check return value of fork()

While here, do some small C11 code cleanup.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#12
Change-Id: I5eac1b31ae40eb957e2c12ca6c37b491fef32847
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ps.c
1 file changed, 12 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1470/2

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index ed2d5c9f..e4c5794 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -800,12 +800,9 @@
 port_share_open(const char *host, const char *port, const int max_initial_=
buf,
                 const char *journal_dir)
 {
-    pid_t pid;
     socket_descriptor_t fd[2];
     struct openvpn_sockaddr hostaddr;
     struct port_share *ps;
-    int status;
-    struct addrinfo *ai;

     ALLOC_OBJ_CLEAR(ps, struct port_share);
     ps->foreground_fd =3D -1;
@@ -814,9 +811,9 @@
     /*
      * Get host's IP address
      */
-
-    status =3D
-        openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port, 0=
, NULL, AF_UNSPEC, &ai);
+    struct addrinfo *ai;
+    int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, ho=
st, port,
+                                     0, NULL, AF_UNSPEC, &ai);
     ASSERT(status =3D=3D 0);
     ASSERT(sizeof(hostaddr.addr) >=3D ai->ai_addrlen);
     memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
@@ -836,19 +833,22 @@
      */
     if (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) =3D=3D -1)
     {
-        msg(M_WARN, "PORT SHARE: socketpair call failed");
+        msg(M_WARN | M_ERRNO, "PORT SHARE: socketpair call failed");
         goto error;
     }

     /*
      * Fork off background proxy process.
      */
-    pid =3D fork();
+    pid_t pid =3D fork();

-    if (pid)
+    if (pid < 0)
     {
-        int status;
-
+        msg(M_WARN | M_ERRNO, "PORT SHARE: fork failed");
+        goto error;
+    }
+    else if (pid)
+    {
         /*
          * Foreground Process
          */
@@ -862,7 +862,7 @@
         set_cloexec(fd[0]);

         /* wait for background child process to initialize */
-        status =3D recv_control(fd[0]);
+        int status =3D recv_control(fd[0]);
         if (status =3D=3D RESPONSE_INIT_SUCCEEDED)
         {
             /* note that this will cause possible EAGAIN when writing to

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5eac1b31ae40eb957e2c12ca6c37b491fef32847
Gerrit-Change-Number: 1470
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--UBfVOg9S978=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">port-share: Check return value of f=
ork()<br><br>While here, do some small C11 code cleanup.<br><br>Reported-By=
: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https://z=
eropath.com)<br>Github: openvpn-private-issues#12<br>Change-Id: I5eac1b31ae=
40eb957e2c12ca6c37b491fef32847<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/ps.c<br>1 file changed, 12 inserti=
ons(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/70/1470/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/ps.c b/src/openvpn/ps.c</span><br><span>index ed2d5c9f..e4c5794 100644=
</span><br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/p=
s.c</span><br><span>@@ -800,12 +800,9 @@</span><br><span> port_share_open(c=
onst char *host, const char *port, const int max_initial_buf,</span><br><sp=
an>                 const char *journal_dir)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    pid_t pid;</span><br><span>  =
   socket_descriptor_t fd[2];</span><br><span>     struct openvpn_sockaddr =
hostaddr;</span><br><span>     struct port_share *ps;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span> </span>=
<br><span>     ALLOC_OBJ_CLEAR(ps, struct port_share);</span><br><span>    =
 ps-&gt;foreground_fd =3D -1;</span><br><span>@@ -814,9 +811,9 @@</span><br=
><span>     /*</span><br><span>      * Get host&#39;s IP address</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        openvpn_getaddrinfo(GETADDR=
_RESOLVE | GETADDR_FATAL, host, port, 0, NULL, AF_UNSPEC, &amp;ai);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status =3D ope=
nvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
    0, NULL, AF_UNSPEC, &amp;ai);</span><br><span>     ASSERT(status =3D=3D=
 0);</span><br><span>     ASSERT(sizeof(hostaddr.addr) &gt;=3D ai-&gt;ai_ad=
drlen);</span><br><span>     memcpy(&amp;hostaddr.addr.sa, ai-&gt;ai_addr, =
ai-&gt;ai_addrlen);</span><br><span>@@ -836,19 +833,22 @@</span><br><span> =
     */</span><br><span>     if (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) =3D=
=3D -1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN, &quot;PORT SHARE: socketpair call failed&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N | M_ERRNO, &quot;PORT SHARE: socketpair call failed&quot;);</span><br><sp=
an>         goto error;</span><br><span>     }</span><br><span> </span><br>=
<span>     /*</span><br><span>      * Fork off background proxy process.</s=
pan><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    pid =3D fork();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    pid_t pid =3D fork();</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (pid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (pid &lt; 0)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int status;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;PORT SHARE: fork failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (pid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span>     =
    /*</span><br><span>          * Foreground Process</span><br><span>     =
     */</span><br><span>@@ -862,7 +862,7 @@</span><br><span>         set_cl=
oexec(fd[0]);</span><br><span> </span><br><span>         /* wait for backgr=
ound child process to initialize */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        status =3D recv_control(fd[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int status =3D recv_control(fd[0]=
);</span><br><span>         if (status =3D=3D RESPONSE_INIT_SUCCEEDED)</spa=
n><br><span>         {</span><br><span>             /* note that this will =
cause possible EAGAIN when writing to</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3De=
mail">change 1470</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5eac1b31ae40eb957e2c12ca6c3=
7b491fef32847 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1470 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--UBfVOg9S978=--

