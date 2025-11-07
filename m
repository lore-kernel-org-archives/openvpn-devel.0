From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 16:18:51 +0000
References: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <28fd5ef796cb80de230827e6ba41da6e2ffe374f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T74QLebAgzM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T74QLebAgzM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail

to review the following change.


Change subject: ssl_pkt: Avoid conversion warnings
......................................................................

ssl_pkt: Avoid conversion warnings

I considered changing opcode to be uint8_t directly, but
most code treats it as int now, so that would be a much
bigger change. Similar for key_id.

Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_pkt.c
1 file changed, 4 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1360/1

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index d7f7ac3..77803ec 100644
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
+    ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D 1 << P_OPCODE_SHIFT);
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Gerrit-Change-Number: 1360
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--T74QLebAgzM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_pkt: Avoid conversion warnings<br><br>I=
 considered changing opcode to be uint8_t directly, but<br>most code treats=
 it as int now, so that would be a much<br>bigger change. Similar for key_i=
d.<br><br>Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ss=
l_pkt.c<br>1 file changed, 4 insertions(+), 11 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60=
/1360/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c<=
/span><br><span>index d7f7ac3..77803ec 100644</span><br><span>--- a/src/ope=
nvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>=
@@ -160,17 +160,14 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> wri=
te_control_auth(struct tls_session *session, struct key_state *ks, struct b=
uffer *buf,</span><br><span>                    struct link_socket_actual *=
*to_link_addr, int opcode, int max_ack,</span><br><span>                   =
 bool prepend_ack)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t header =3D ks-&gt;key_id | (opcode &lt;&lt; P_O=
PCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D 1 &lt;&lt; P_=
OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (uint8_=
t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </sp=
an><br><span>     /* Workaround for Softether servers. Softether has a bug =
that it only</span><br><span>      * allows 4 ACks in packets and drops pac=
kets if more ACKs are contained</span><br><span>@@ -474,7 +471,7 @@</span><=
br><span>     /* Get the valid time quantisation for our hmac,</span><br><s=
pan>      * we divide time by handwindow/2 and allow the previous</span><br=
><span>      * and future session time if specified by offset */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t session_id_time =3D=
 ntohl(now / ((handwindow + 1) / 2) + offset);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t session_id_time =3D ntohl((uint32_t=
)(now / ((handwindow + 1) / 2) + offset));</span><br><span> </span><br><spa=
n>     hmac_ctx_reset(hmac);</span><br><span>     /* We do not care about e=
ndian here since it does not need to be</span><br><span>@@ -501,10 +498,6 @=
@</span><br><span>     return result.sid;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> bool</span><br><span> check_session_hmac_and_pkt_id(struct tls_=
pre_decrypt_state *state,</span><br><span>                               co=
nst struct openvpn_sockaddr *from,</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demai=
l">change 1360</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73a=
b7edbb5f19d7f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1360 </div>
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

--T74QLebAgzM=--

