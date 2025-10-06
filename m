From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 19:45:13 +0000
In-Reply-To: <gerrit.1759763846000.I8919c9efdf85424a124a0d54593cd1dbf3bc2341@...2715...>
References: <gerrit.1759763846000.I8919c9efdf85424a124a0d54593cd1dbf3bc2341@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b2c849b317cf364e44cea869dd562fe523ad08b1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Duq9E7DpbMk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mtu: Trivial
 -Wconversion fix
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

--Duq9E7DpbMk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
50?usp=3Demail )

Change subject: mtu: Trivial -Wconversion fix
......................................................................

mtu: Trivial -Wconversion fix

Just use the correct type.

Change-Id: I8919c9efdf85424a124a0d54593cd1dbf3bc2341
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1250
Message-Id: <20251006170504.7235-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59242982/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtu.c
1 file changed, 1 insertion(+), 11 deletions(-)




diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 66f81a6..9e152df 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -280,15 +280,9 @@
     struct timeval tv;
 };

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 const char *
 format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
 {
-    int res;
     struct probehdr rcvbuf;
     struct iovec iov;
     struct msghdr msg;
@@ -313,7 +307,7 @@
         msg.msg_control =3D cbuf;
         msg.msg_controllen =3D 256; /* size of cbuf */

-        res =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
+        ssize_t res =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
         if (res < 0)
         {
             goto exit;
@@ -394,10 +388,6 @@
     return BSTR(&out);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1250?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8919c9efdf85424a124a0d54593cd1dbf3bc2341
Gerrit-Change-Number: 1250
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Duq9E7DpbMk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1250?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mtu: Trivial -Wconversion fix<br><br>Just use th=
e correct type.<br><br>Change-Id: I8919c9efdf85424a124a0d54593cd1dbf3bc2341=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.=
net/c/openvpn/+/1250<br>Message-Id: &lt;20251006170504.7235-1-gert@...1725...=
..&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59242982/<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/mtu.c<br>1 file changed, 1 insertion(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>index=
 66f81a6..9e152df 100644</span><br><span>--- a/src/openvpn/mtu.c</span><br>=
<span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -280,15 +280,9 @@</span><b=
r><span>     struct timeval tv;</span><br><span> };</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> const char *</span><br><span> format_=
extended_socket_error(int fd, int *mtu, struct gc_arena *gc)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int res;</spa=
n><br><span>     struct probehdr rcvbuf;</span><br><span>     struct iovec =
iov;</span><br><span>     struct msghdr msg;</span><br><span>@@ -313,7 +307=
,7 @@</span><br><span>         msg.msg_control =3D cbuf;</span><br><span>  =
       msg.msg_controllen =3D 256; /* size of cbuf */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        res =3D recvmsg(f=
d, &amp;msg, MSG_ERRQUEUE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ssize_t res =3D recvmsg(fd, &amp;msg, MSG_ERRQUEUE);</span>=
<br><span>         if (res &lt; 0)</span><br><span>         {</span><br><sp=
an>             goto exit;</span><br><span>@@ -394,10 +388,6 @@</span><br><=
span>     return BSTR(&amp;out);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> void</span><br><span> set_sock_extended_error_passing(int sd, sa_family_=
t proto_af)</span><br><span> {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1250?usp=3Demail">c=
hange 1250</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1250?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8919c9efdf85424a124a0d54593=
cd1dbf3bc2341 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1250 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Duq9E7DpbMk=--

