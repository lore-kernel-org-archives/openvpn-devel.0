From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 15:54:31 +0000
In-Reply-To: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
References: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04e404c20f25da19e28b19424f91f99d54b3094e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nztPeyw4eCc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: change return
 type of calc_control_channel_frame_overhead to size_t
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

--nztPeyw4eCc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
97?usp=3Demail )

Change subject: ssl: change return type of calc_control_channel_frame_overh=
ead to size_t
......................................................................

ssl: change return type of calc_control_channel_frame_overhead to size_t

This avoids dealing with conversion warnings inside
the function. Since we only add values that are
supposed to be positive this should be safe.

Note that we now cast the return value to int at
the caller side. There we actually substract it and
want to catch the case where the result gets negative.
Since all the involved values are quite small compared
to INT_MAX I decided to just cast it without further
checks.

Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297
Message-Id: <20251111172437.7634-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
326.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 3 insertions(+), 12 deletions(-)




diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e21ac78..d7f55dd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -179,21 +179,16 @@
     frame->tun_mtu =3D max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * calculate the maximum overhead that control channel frames have
  * This includes header, op code and everything apart from the
  * payload itself. This method is a bit pessimistic and might give higher
  * overhead than we actually have */
-static int
+static size_t
 calc_control_channel_frame_overhead(const struct tls_session *session)
 {
     const struct key_state *ks =3D &session->key[KS_PRIMARY];
-    int overhead =3D 0;
+    size_t overhead =3D 0;

     /* opcode */
     overhead +=3D 1;
@@ -226,10 +221,6 @@
     return overhead;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 init_ssl_lib(void)
 {
@@ -2650,7 +2641,7 @@
     int max_pkt_len =3D min_int(TLS_CHANNEL_BUF_SIZE, session->opt->frame.=
tun_mtu);

     /* Subtract overhead */
-    max_pkt_len -=3D calc_control_channel_frame_overhead(session);
+    max_pkt_len -=3D (int)calc_control_channel_frame_overhead(session);

     /* calculate total available length for outgoing tls ciphertext */
     int maxlen =3D max_pkt_len * rel_avail;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Gerrit-Change-Number: 1297
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nztPeyw4eCc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1297?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl: change return type of calc_control_channel_=
frame_overhead to size_t<br><br>This avoids dealing with conversion warning=
s inside<br>the function. Since we only add values that are<br>supposed to =
be positive this should be safe.<br><br>Note that we now cast the return va=
lue to int at<br>the caller side. There we actually substract it and<br>wan=
t to catch the case where the result gets negative.<br>Since all the involv=
ed values are quite small compared<br>to INT_MAX I decided to just cast it =
without further<br>checks.<br><br>Change-Id: I71e9d4a61d37483685723c16e98f5=
9755694cadf<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1297<br>Message-Id: &lt;20251111172437.7=
634-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg34326.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 3 insert=
ions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 e21ac78..d7f55dd 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -179,21 +179,16 @@</span><=
br><span>     frame-&gt;tun_mtu =3D max_int(frame-&gt;tun_mtu, TLS_CHANNEL_=
MTU_MIN);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic=
 ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /**</span><br><span>  * calculate the maximum overhead that =
control channel frames have</span><br><span>  * This includes header, op co=
de and everything apart from the</span><br><span>  * payload itself. This m=
ethod is a bit pessimistic and might give higher</span><br><span>  * overhe=
ad than we actually have */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic size_t</span><br><span> calc_control_channel_frame_overhead(const struc=
t tls_session *session)</span><br><span> {</span><br><span>     const struc=
t key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int overhead =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t overhead =3D 0;</span><br><s=
pan> </span><br><span>     /* opcode */</span><br><span>     overhead +=3D =
1;</span><br><span>@@ -226,10 +221,6 @@</span><br><span>     return overhea=
d;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> ini=
t_ssl_lib(void)</span><br><span> {</span><br><span>@@ -2650,7 +2641,7 @@</s=
pan><br><span>     int max_pkt_len =3D min_int(TLS_CHANNEL_BUF_SIZE, sessio=
n-&gt;opt-&gt;frame.tun_mtu);</span><br><span> </span><br><span>     /* Sub=
tract overhead */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
max_pkt_len -=3D calc_control_channel_frame_overhead(session);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    max_pkt_len -=3D (int)calc_c=
ontrol_channel_frame_overhead(session);</span><br><span> </span><br><span> =
    /* calculate total available length for outgoing tls ciphertext */</spa=
n><br><span>     int maxlen =3D max_pkt_len * rel_avail;</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1297?usp=3Demail">change 1297</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1297?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I71e9d4a61d37483685723c16e98=
f59755694cadf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1297 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--nztPeyw4eCc=--

