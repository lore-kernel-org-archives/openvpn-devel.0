From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 17 Nov 2025 08:20:40 +0000
In-Reply-To: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
References: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <175dcdc1d609df3b6212ecd864559ede1ab48610-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="52+ec1SRJXw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_pkt: Avoid
 conversion warnings
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

--52+ec1SRJXw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
60?usp=3Demail )

Change subject: ssl_pkt: Avoid conversion warnings
......................................................................

ssl_pkt: Avoid conversion warnings

I considered changing opcode to be uint8_t directly, but
most code treats it as int now, so that would be a much
bigger change. Similar for key_id.

Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1360
Message-Id: <20251117074921.26531-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
501.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_pkt.c
1 file changed, 4 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index d7f7ac3..f216e88 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -160,17 +160,14 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 write_control_auth(struct tls_session *session, struct key_state *ks, stru=
ct buffer *buf,
                    struct link_socket_actual **to_link_addr, int opcode, i=
nt max_ack,
                    bool prepend_ack)
 {
-    uint8_t header =3D ks->key_id | (opcode << P_OPCODE_SHIFT);
+    ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
+    ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
+    uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));

     /* Workaround for Softether servers. Softether has a bug that it only
      * allows 4 ACks in packets and drops packets if more ACKs are contain=
ed
@@ -474,7 +471,7 @@
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
-    uint32_t session_id_time =3D ntohl(now / ((handwindow + 1) / 2) + offs=
et);
+    uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow + 1) =
/ 2) + offset));

     hmac_ctx_reset(hmac);
     /* We do not care about endian here since it does not need to be
@@ -501,10 +498,6 @@
     return result.sid;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                               const struct openvpn_sockaddr *from,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Gerrit-Change-Number: 1360
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--52+ec1SRJXw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1360?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_pkt: Avoid conversion warnings<br><br>I cons=
idered changing opcode to be uint8_t directly, but<br>most code treats it a=
s int now, so that would be a much<br>bigger change. Similar for key_id.<br=
><br>Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/13=
60<br>Message-Id: &lt;20251117074921.26531-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34501.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/ssl_pkt.c<br>1 file changed, 4 insertions(+), 11 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><sp=
an>index d7f7ac3..f216e88 100644</span><br><span>--- a/src/openvpn/ssl_pkt.=
c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -160,17 +1=
60,14 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> void</span><br><span> write_control_au=
th(struct tls_session *session, struct key_state *ks, struct buffer *buf,</=
span><br><span>                    struct link_socket_actual **to_link_addr=
, int opcode, int max_ack,</span><br><span>                    bool prepend=
_ack)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    uint8_t header =3D ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ks-&gt;k=
ey_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode &gt;=3D 0 &a=
mp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcod=
e &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </span><br><span>     /* Work=
around for Softether servers. Softether has a bug that it only</span><br><s=
pan>      * allows 4 ACks in packets and drops packets if more ACKs are con=
tained</span><br><span>@@ -474,7 +471,7 @@</span><br><span>     /* Get the =
valid time quantisation for our hmac,</span><br><span>      * we divide tim=
e by handwindow/2 and allow the previous</span><br><span>      * and future=
 session time if specified by offset */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uint32_t session_id_time =3D ntohl(now / ((handwindow=
 + 1) / 2) + offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow + 1)=
 / 2) + offset));</span><br><span> </span><br><span>     hmac_ctx_reset(hma=
c);</span><br><span>     /* We do not care about endian here since it does =
not need to be</span><br><span>@@ -501,10 +498,6 @@</span><br><span>     re=
turn result.sid;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><b=
r><span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,=
</span><br><span>                               const struct openvpn_sockad=
dr *from,</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail">change 1360</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73a=
b7edbb5f19d7f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1360 </div>
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

--52+ec1SRJXw=--

