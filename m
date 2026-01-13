From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 15:42:23 +0000
References: <gerrit.1768318939000.I5eac1b31ae40eb957e2c12ca6c37b491fef32847@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e407d9b3fa533e072903b1e04068b6443e248231-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4r7deCSlhd0="; charset=UTF-8
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

--4r7deCSlhd0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail

to review the following change.


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
1 file changed, 18 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1470/1

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index ed2d5c9f..c9da426 100644
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
@@ -814,13 +811,15 @@
     /*
      * Get host's IP address
      */
-
-    status =3D
-        openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port, 0=
, NULL, AF_UNSPEC, &ai);
-    ASSERT(status =3D=3D 0);
-    ASSERT(sizeof(hostaddr.addr) >=3D ai->ai_addrlen);
-    memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
-    freeaddrinfo(ai);
+    {
+        struct addrinfo *ai;
+        int status =3D
+            openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, por=
t, 0, NULL, AF_UNSPEC, &ai);
+        ASSERT(status =3D=3D 0);
+        ASSERT(sizeof(hostaddr.addr) >=3D ai->ai_addrlen);
+        memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
+        freeaddrinfo(ai);
+    }

     if (msg_test(D_PS_PROXY_DEBUG))
     {
@@ -836,19 +835,22 @@
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
@@ -862,7 +864,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5eac1b31ae40eb957e2c12ca6c37b491fef32847
Gerrit-Change-Number: 1470
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--4r7deCSlhd0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">port-share: Check return value of fork()<br=
><br>While here, do some small C11 code cleanup.<br><br>Reported-By: Joshua=
 Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https://zeropath.=
com)<br>Github: openvpn-private-issues#12<br>Change-Id: I5eac1b31ae40eb957e=
2c12ca6c37b491fef32847<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpn/ps.c<br>1 file changed, 18 insertions(+), =
16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/70/1470/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ps.=
c b/src/openvpn/ps.c</span><br><span>index ed2d5c9f..c9da426 100644</span><=
br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/ps.c</spa=
n><br><span>@@ -800,12 +800,9 @@</span><br><span> port_share_open(const cha=
r *host, const char *port, const int max_initial_buf,</span><br><span>     =
            const char *journal_dir)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    pid_t pid;</span><br><span>     socke=
t_descriptor_t fd[2];</span><br><span>     struct openvpn_sockaddr hostaddr=
;</span><br><span>     struct port_share *ps;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span> </span><br><spa=
n>     ALLOC_OBJ_CLEAR(ps, struct port_share);</span><br><span>     ps-&gt;=
foreground_fd =3D -1;</span><br><span>@@ -814,13 +811,15 @@</span><br><span=
>     /*</span><br><span>      * Get host&#39;s IP address</span><br><span>=
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    status =3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        openvpn_getaddrinfo(GETADDR_RESOL=
VE | GETADDR_FATAL, host, port, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(status =3D=3D 0);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(sizeof(hostaddr.a=
ddr) &gt;=3D ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    memcpy(&amp;hostaddr.addr.sa, ai-&gt;ai_addr, ai-&gt;ai_addr=
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    freeaddrinfo=
(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int status =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            open=
vpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port, 0, NULL, AF_UN=
SPEC, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ASSERT(status =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ASSERT(sizeof(hostaddr.addr) &gt;=3D ai-&gt;ai_addrlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;h=
ostaddr.addr.sa, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><=
span>     if (msg_test(D_PS_PROXY_DEBUG))</span><br><span>     {</span><br>=
<span>@@ -836,19 +835,22 @@</span><br><span>      */</span><br><span>     i=
f (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) =3D=3D -1)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &=
quot;PORT SHARE: socketpair call failed&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;PORT SHARE:=
 socketpair call failed&quot;);</span><br><span>         goto error;</span>=
<br><span>     }</span><br><span> </span><br><span>     /*</span><br><span>=
      * Fork off background proxy process.</span><br><span>      */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    pid =3D fork();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t pid =3D fork();</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pid &l=
t; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int status;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
WARN | M_ERRNO, &quot;PORT SHARE: fork failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (pid)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span>         /*</span><br><span>       =
   * Foreground Process</span><br><span>          */</span><br><span>@@ -86=
2,7 +864,7 @@</span><br><span>         set_cloexec(fd[0]);</span><br><span>=
 </span><br><span>         /* wait for background child process to initiali=
ze */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D recv_control(fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        int status =3D recv_control(fd[0]);</span><br><span>         i=
f (status =3D=3D RESPONSE_INIT_SUCCEEDED)</span><br><span>         {</span>=
<br><span>             /* note that this will cause possible EAGAIN when wr=
iting to</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail">change 1470</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1470?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5eac1b31ae40eb957e2c12ca6c3=
7b491fef32847 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1470 </div>
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

--4r7deCSlhd0=--

