From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 18:44:51 +0000
References: <gerrit.1771008284000.Idf5ce8f82e7727505cce67560e0b7423b8e41a40@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1ac7b7f5eeb53d8c3aea42de6dc96b4fd51e66fc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kE/42zwUu6k="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kE/42zwUu6k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1523?usp=3Demail

to review the following change.


Change subject: socket: Avoid sign-compare issue by comparing before assign=
ment
......................................................................

socket: Avoid sign-compare issue by comparing before assignment

The assignment implicitly converts the values, but
we can just do the comparison before the assignment.

Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
1 file changed, 2 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1523/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 698e724..13322f5 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2523,11 +2523,6 @@
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
@@ -2552,11 +2547,10 @@

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
@@ -2629,10 +2623,6 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40
Gerrit-Change-Number: 1523
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--kE/42zwUu6k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1523?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: Avoid sign-compare issue by compari=
ng before assignment<br><br>The assignment implicitly converts the values, =
but<br>we can just do the comparison before the assignment.<br><br>Change-I=
d: Idf5ce8f82e7727505cce67560e0b7423b8e41a40<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file c=
hanged, 2 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1523/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index=
 698e724..13322f5 100644</span><br><span>--- a/src/openvpn/socket.c</span><=
br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2523,11 +2523,6 @@<=
/span><br><span>     return WSAGetLastError();</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> =
socket_recv_queue(struct link_socket *sock, int maxsize)</span><br><span> {=
</span><br><span>@@ -2552,11 +2547,10 @@</span><br><span> </span><br><span>=
         /* Win32 docs say it&#39;s okay to allocate the wsabuf on the stac=
k */</span><br><span>         wsabuf[0].buf =3D BSTR(&amp;sock-&gt;reads.bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* make =
sure maxsize is sane */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ASSERT(maxsize &lt;=3D BLEN(&amp;sock-&gt;reads.buf));</span><b=
r><span>         wsabuf[0].len =3D maxsize ? maxsize : BLEN(&amp;sock-&gt;r=
eads.buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* check for buffer overflow */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ASSERT(wsabuf[0].len &lt;=3D BLEN(&amp;soc=
k-&gt;reads.buf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         /* the overlapped read will signal this event on I/O=
 completion */</span><br><span>         ASSERT(ResetEvent(sock-&gt;reads.ov=
erlapped.hEvent));</span><br><span>         sock-&gt;reads.flags =3D 0;</sp=
an><br><span>@@ -2629,10 +2623,6 @@</span><br><span>     return sock-&gt;re=
ads.iostate;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><sp=
an> socket_send_queue(struct link_socket *sock, struct buffer *buf, const s=
truct link_socket_actual *to)</span><br><span> {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
523?usp=3Demail">change 1523</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1523=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idf5ce8f82e7727505cce67560e0=
b7423b8e41a40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1523 </div>
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

--kE/42zwUu6k=--

