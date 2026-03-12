From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 07:38:44 +0000
In-Reply-To: <gerrit.1771008284000.Idf5ce8f82e7727505cce67560e0b7423b8e41a40@...2715...>
References: <gerrit.1771008284000.Idf5ce8f82e7727505cce67560e0b7423b8e41a40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e3de1cd1ef8816305784948febd92196161d3d8a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rb7CAXYmrPA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Avoid
 sign-compare issue by comparing before assignment
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

--rb7CAXYmrPA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1523?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socket: Avoid sign-compare issue by comparing before assign=
ment
......................................................................

socket: Avoid sign-compare issue by comparing before assignment

The assignment implicitly converts the values, but
we can just do the comparison before the assignment.

Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1523
Message-Id: <20260306163202.2586-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
961.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 2 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1523/5

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8d2d110..5df0792 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2550,11 +2550,6 @@
     return WSAGetLastError();
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 socket_recv_queue(struct link_socket *sock, int maxsize)
 {
@@ -2579,11 +2574,10 @@

         /* Win32 docs say it's okay to allocate the wsabuf on the stack */
         wsabuf[0].buf =3D BSTR(&sock->reads.buf);
+        /* make sure maxsize is sane */
+        ASSERT(maxsize <=3D BLEN(&sock->reads.buf));
         wsabuf[0].len =3D maxsize ? maxsize : BLEN(&sock->reads.buf);

-        /* check for buffer overflow */
-        ASSERT(wsabuf[0].len <=3D BLEN(&sock->reads.buf));
-
         /* the overlapped read will signal this event on I/O completion */
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags =3D 0;
@@ -2656,10 +2650,6 @@
     return sock->reads.iostate;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 socket_send_queue(struct link_socket *sock, struct buffer *buf, const stru=
ct link_socket_actual *to)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40
Gerrit-Change-Number: 1523
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rb7CAXYmrPA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1523?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socket: Avoid sign-compare issue by=
 comparing before assignment<br><br>The assignment implicitly converts the =
values, but<br>we can just do the comparison before the assignment.<br><br>=
Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1523<br=
>Message-Id: &lt;20260306163202.2586-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35961.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/=
socket.c<br>1 file changed, 2 insertions(+), 12 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/2=
3/1523/5</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</=
span><br><span>index 8d2d110..5df0792 100644</span><br><span>--- a/src/open=
vpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ =
-2550,11 +2550,6 @@</span><br><span>     return WSAGetLastError();</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Ws=
ign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> i=
nt</span><br><span> socket_recv_queue(struct link_socket *sock, int maxsize=
)</span><br><span> {</span><br><span>@@ -2579,11 +2574,10 @@</span><br><spa=
n> </span><br><span>         /* Win32 docs say it&#39;s okay to allocate th=
e wsabuf on the stack */</span><br><span>         wsabuf[0].buf =3D BSTR(&a=
mp;sock-&gt;reads.buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* make sure maxsize is sane */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ASSERT(maxsize &lt;=3D BLEN(&amp;sock-&gt;r=
eads.buf));</span><br><span>         wsabuf[0].len =3D maxsize ? maxsize : =
BLEN(&amp;sock-&gt;reads.buf);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* check for buffer overflow */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(wsabuf[0].len &=
lt;=3D BLEN(&amp;sock-&gt;reads.buf));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>         /* the overlapped read will sign=
al this event on I/O completion */</span><br><span>         ASSERT(ResetEve=
nt(sock-&gt;reads.overlapped.hEvent));</span><br><span>         sock-&gt;re=
ads.flags =3D 0;</span><br><span>@@ -2656,10 +2650,6 @@</span><br><span>   =
  return sock-&gt;reads.iostate;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> int</span><br><span> socket_send_queue(struct link_socket *sock, struct =
buffer *buf, const struct link_socket_actual *to)</span><br><span> {</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1523?usp=3Demail">change 1523</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1523?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idf5ce8f82e7727505cce67560e0=
b7423b8e41a40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--rb7CAXYmrPA=--

