From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 12:14:18 +0000
References: <gerrit.1725970450000.I7852c06d331326c1dbab7b642254c0c00d4cebb8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b144f992445ac7d9b4c974868e348d2483eb1af8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0hb/QPc9yL8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0hb/QPc9yL8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail

to review the following change.


Change subject: socket: Change return types of link_socket_write* to ssize_t
......................................................................

socket: Change return types of link_socket_write* to ssize_t

This is the actual return value of send/sendto/sendmsg.
We will leave it to the single caller of link_socket_write()
to decide how to map that to the int buffer world. For now
just cast it explicitly.

Change-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
M src/openvpn/socket.c
M src/openvpn/socket.h
3 files changed, 13 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/740/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 40b7cc4..84c23b3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1790,7 +1790,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--0hb/QPc9yL8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">socket: Change return types of link_socket_write* to ssize_t<=
br><br>This is the actual return value of send/sendto/sendmsg.<br>We will l=
eave it to the single caller of link_socket_write()<br>to decide how to map=
 that to the int buffer world. For now<br>just cast it explicitly.<br><br>C=
hange-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/forward.c<br>=
M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>3 files changed, 13 ins=
ertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/40/740/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c=
 b/src/openvpn/forward.c</span><br><span>index 40b7cc4..84c23b3 100644</spa=
n><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/f=
orward.c</span><br><span>@@ -1790,7 +1790,7 @@</span><br><span>            =
     socks_preprocess_outgoing_link(c, &amp;to_addr, &amp;size_delta);</spa=
n><br><span> </span><br><span>                 /* Send packet */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                size =3D link_so=
cket_write(c-&gt;c2.link_socket, &amp;c-&gt;c2.to_link, to_addr);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                size =3D (int=
)link_socket_write(c-&gt;c2.link_socket, &amp;c-&gt;c2.to_link, to_addr);</=
span><br><span> </span><br><span>                 /* Undo effect of prepend=
 */</span><br><span>                 link_socket_write_post_size_adjust(&am=
p;size, size_delta, &amp;c-&gt;c2.to_link);</span><br><span>diff --git a/sr=
c/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 17c5e76..6c=
790a0 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++=
 b/src/openvpn/socket.c</span><br><span>@@ -3399,7 +3399,7 @@</span><br><sp=
an>  * Socket Write Routines</span><br><span>  */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> link_socket_write_tc=
p(struct link_socket *sock,</span><br><span>                       struct b=
uffer *buf,</span><br><span>                       struct link_socket_actua=
l *to)</span><br><span>@@ -3418,7 +3418,7 @@</span><br><span> </span><br><s=
pan> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-size_t</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssize_t</span><br><span> link_socket_write_udp_posix_sendmsg(stru=
ct link_socket *sock,</span><br><span>                                     =
struct buffer *buf,</span><br><span>                                     st=
ruct link_socket_actual *to)</span><br><span>diff --git a/src/openvpn/socke=
t.h b/src/openvpn/socket.h</span><br><span>index 47083ad..bbdabfb 100644</s=
pan><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/=
socket.h</span><br><span>@@ -1099,9 +1099,9 @@</span><br><span>  * Socket W=
rite routines</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int link_socket_write_tcp(struct link_socke=
t *sock,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
             struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                          struct link_socket_actual *to);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_write_=
tcp(struct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                              struct buffer *buf,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                              struc=
t link_socket_actual *to);</span><br><span> </span><br><span> #ifdef _WIN32=
</span><br><span> </span><br><span>@@ -1135,12 +1135,12 @@</span><br><span>=
 </span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-size_t link_socket_write_udp_posix=
_sendmsg(struct link_socket *sock,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                           struct buffer *buf,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                      struct link_socket_actual *to);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posix_sendm=
sg(struct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                            struct buffer *buf,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                      struct link_socket_actual *to);</span><br><span> </sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline ssize_t</span><br><span> link_socket_write_udp_posix(struct link_so=
cket *sock,</span><br><span>                             struct buffer *buf=
,</span><br><span>                             struct link_socket_actual *t=
o)</span><br><span>@@ -1158,7 +1158,7 @@</span><br><span>                  =
 (socklen_t) af_addr_size(to-&gt;dest.addr.sa.sa_family));</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline ssize_t</span><br><span> link_socket_write_tcp_posix(struct l=
ink_socket *sock,</span><br><span>                             struct buffe=
r *buf,</span><br><span>                             struct link_socket_act=
ual *to)</span><br><span>@@ -1168,7 +1168,7 @@</span><br><span> </span><br>=
<span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline size_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline ssize_t</span><br><span> link_s=
ocket_write_udp(struct link_socket *sock,</span><br><span>                 =
      struct buffer *buf,</span><br><span>                       struct lin=
k_socket_actual *to)</span><br><span>@@ -1181,7 +1181,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> /* write a TCP or UDP packet to link =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline ssize_t=
</span><br><span> link_socket_write(struct link_socket *sock,</span><br><sp=
an>                   struct buffer *buf,</span><br><span>                 =
  struct link_socket_actual *to)</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail">=
change 740</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/740?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7852c06d331326c1dbab7b64225=
4c0c00d4cebb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 740 </div>
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


--0hb/QPc9yL8=--

