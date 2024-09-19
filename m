From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Sep 2024 06:15:40 +0000
In-Reply-To: <gerrit.1725970450000.I7852c06d331326c1dbab7b642254c0c00d4cebb8@...2715...>
References: <gerrit.1725970450000.I7852c06d331326c1dbab7b642254c0c00d4cebb8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <20a2c28a488f0fe3db894d7fc411e2cad2b72727-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8IQdn9Jeg7s="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Change
 return types of link_socket_write* to ssize_t
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

--8IQdn9Jeg7s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socket: Change return types of link_socket_write* to ssize_t
......................................................................

socket: Change return types of link_socket_write* to ssize_t

This is the actual return value of send/sendto/sendmsg.
We will leave it to the single caller of link_socket_write()
to decide how to map that to the int buffer world. For now
just cast it explicitly.

Change-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240918204844.2820-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
323.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/socket.c
M src/openvpn/socket.h
3 files changed, 13 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/740/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 374ba47..8c02407 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1792,7 +1792,7 @@
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);

                 /* Send packet */
-                size =3D link_socket_write(c->c2.link_socket, &c->c2.to_li=
nk, to_addr);
+                size =3D (int)link_socket_write(c->c2.link_socket, &c->c2.=
to_link, to_addr);

                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->=
c2.to_link);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 17c5e76..6c790a0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3399,7 +3399,7 @@
  * Socket Write Routines
  */

-int
+ssize_t
 link_socket_write_tcp(struct link_socket *sock,
                       struct buffer *buf,
                       struct link_socket_actual *to)
@@ -3418,7 +3418,7 @@

 #if ENABLE_IP_PKTINFO

-size_t
+ssize_t
 link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
                                     struct buffer *buf,
                                     struct link_socket_actual *to)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 47083ad..bbdabfb 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1099,9 +1099,9 @@
  * Socket Write routines
  */

-int link_socket_write_tcp(struct link_socket *sock,
-                          struct buffer *buf,
-                          struct link_socket_actual *to);
+ssize_t link_socket_write_tcp(struct link_socket *sock,
+                              struct buffer *buf,
+                              struct link_socket_actual *to);

 #ifdef _WIN32

@@ -1135,12 +1135,12 @@

 #else  /* ifdef _WIN32 */

-size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
-                                           struct buffer *buf,
-                                           struct link_socket_actual *to);
+ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
+                                            struct buffer *buf,
+                                            struct link_socket_actual *to);


-static inline size_t
+static inline ssize_t
 link_socket_write_udp_posix(struct link_socket *sock,
                             struct buffer *buf,
                             struct link_socket_actual *to)
@@ -1158,7 +1158,7 @@
                   (socklen_t) af_addr_size(to->dest.addr.sa.sa_family));
 }

-static inline size_t
+static inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock,
                             struct buffer *buf,
                             struct link_socket_actual *to)
@@ -1168,7 +1168,7 @@

 #endif /* ifdef _WIN32 */

-static inline size_t
+static inline ssize_t
 link_socket_write_udp(struct link_socket *sock,
                       struct buffer *buf,
                       struct link_socket_actual *to)
@@ -1181,7 +1181,7 @@
 }

 /* write a TCP or UDP packet to link */
-static inline int
+static inline ssize_t
 link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8
Gerrit-Change-Number: 740
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--8IQdn9Jeg7s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/740?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">socket: Change return types of link_socket_write* to=
 ssize_t<br><br>This is the actual return value of send/sendto/sendmsg.<br>=
We will leave it to the single caller of link_socket_write()<br>to decide h=
ow to map that to the int buffer world. For now<br>just cast it explicitly.=
<br><br>Change-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Message-Id: &lt;20240918204844.2820-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg29323.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/forward.c<br>M src/openvpn/socket.c<br>M src/openvp=
n/socket.h<br>3 files changed, 13 insertions(+), 13 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/740/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 374ba47..8c02407 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1792,7 +1=
792,7 @@</span><br><span>                 socks_preprocess_outgoing_link(c,=
 &amp;to_addr, &amp;size_delta);</span><br><span> </span><br><span>        =
         /* Send packet */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                size =3D link_socket_write(c-&gt;c2.link_socket, &amp;=
c-&gt;c2.to_link, to_addr);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                size =3D (int)link_socket_write(c-&gt;c2.link_socke=
t, &amp;c-&gt;c2.to_link, to_addr);</span><br><span> </span><br><span>     =
            /* Undo effect of prepend */</span><br><span>                 l=
ink_socket_write_post_size_adjust(&amp;size, size_delta, &amp;c-&gt;c2.to_l=
ink);</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socke=
t.c</span><br><span>index 17c5e76..6c790a0 100644</span><br><span>--- a/src=
/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><spa=
n>@@ -3399,7 +3399,7 @@</span><br><span>  * Socket Write Routines</span><br=
><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t<=
/span><br><span> link_socket_write_tcp(struct link_socket *sock,</span><br>=
<span>                       struct buffer *buf,</span><br><span>          =
             struct link_socket_actual *to)</span><br><span>@@ -3418,7 +341=
8,7 @@</span><br><span> </span><br><span> #if ENABLE_IP_PKTINFO</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-size_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> lin=
k_socket_write_udp_posix_sendmsg(struct link_socket *sock,</span><br><span>=
                                     struct buffer *buf,</span><br><span>  =
                                   struct link_socket_actual *to)</span><br=
><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><=
span>index 47083ad..bbdabfb 100644</span><br><span>--- a/src/openvpn/socket=
.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -1099,9 +1=
099,9 @@</span><br><span>  * Socket Write routines</span><br><span>  */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int lin=
k_socket_write_tcp(struct link_socket *sock,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                          struct buffer *buf,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                          st=
ruct link_socket_actual *to);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssize_t link_socket_write_tcp(struct link_socket *sock,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              struct link_socket_actual *to);</span><br><s=
pan> </span><br><span> #ifdef _WIN32</span><br><span> </span><br><span>@@ -=
1135,12 +1135,12 @@</span><br><span> </span><br><span> #else  /* ifdef _WIN=
32 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                 struct buffer *buf,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                           struct link_socke=
t_actual *to);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize=
_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
              struct buffer *buf,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                            struct link_socke=
t_actual *to);</span><br><span> </span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline size_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline ssize_t</span><br><span> link_s=
ocket_write_udp_posix(struct link_socket *sock,</span><br><span>           =
                  struct buffer *buf,</span><br><span>                     =
        struct link_socket_actual *to)</span><br><span>@@ -1158,7 +1158,7 @=
@</span><br><span>                   (socklen_t) af_addr_size(to-&gt;dest.a=
ddr.sa.sa_family));</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline size_t</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static inline ssize_t</span><br><span> =
link_socket_write_tcp_posix(struct link_socket *sock,</span><br><span>     =
                        struct buffer *buf,</span><br><span>               =
              struct link_socket_actual *to)</span><br><span>@@ -1168,7 +11=
68,7 @@</span><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inl=
ine size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line ssize_t</span><br><span> link_socket_write_udp(struct link_socket *soc=
k,</span><br><span>                       struct buffer *buf,</span><br><sp=
an>                       struct link_socket_actual *to)</span><br><span>@@=
 -1181,7 +1181,7 @@</span><br><span> }</span><br><span> </span><br><span> /=
* write a TCP or UDP packet to link */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline ssize_t</span><br><span> link_socket_write(str=
uct link_socket *sock,</span><br><span>                   struct buffer *bu=
f,</span><br><span>                   struct link_socket_actual *to)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/740?usp=3Demail">change 740</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/740?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7852c06d331326c1dbab7b64225=
4c0c00d4cebb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8IQdn9Jeg7s=--

