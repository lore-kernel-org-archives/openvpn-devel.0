From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:40 +0000
References: <gerrit.1753360288000.I89820c76e2e099f7acb817c71c8aeb83736ac556@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <996aee3a51ca24d5d9bc1aff0d4fc6104f0c0c57-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="92eO4JJhcPE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto: Make sure
 crypto flags are treated as unsigned
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

--92eO4JJhcPE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1103?usp=3Demail

to review the following change.


Change subject: crypto: Make sure crypto flags are treated as unsigned
......................................................................

crypto: Make sure crypto flags are treated as unsigned

crypto_options.flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Change-Id: I89820c76e2e099f7acb817c71c8aeb83736ac556
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.h
1 file changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1103/1

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 68ad901..345e7ce 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -341,39 +341,39 @@
      *   keeping state between successive
      *   OpenVPN process startups. */

-#define CO_PACKET_ID_LONG_FORM  (1<<0)
+#define CO_PACKET_ID_LONG_FORM  (1u<<0)
     /**< Bit-flag indicating whether to use
     *   OpenVPN's long packet ID format. */
-#define CO_IGNORE_PACKET_ID     (1<<1)
+#define CO_IGNORE_PACKET_ID     (1u<<1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
      *   This flag is used during processing
      *   of the first packet received from a
      *   client. */
-#define CO_MUTE_REPLAY_WARNINGS (1<<2)
+#define CO_MUTE_REPLAY_WARNINGS (1u<<2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
-#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1<<3)
+#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1u<<3)
     /**< Bit-flag indicating that data channel key derivation
      * is done using TLS keying material export [RFC5705]
      */
-#define CO_RESEND_WKC (1<<4)
+#define CO_RESEND_WKC (1u<<4)
     /**< Bit-flag indicating that the client is expected to
      * resend the wrapped client key with the 2nd packet (packet-id 1)
      * like with the HARD_RESET_CLIENT_V3 packet */
-#define CO_FORCE_TLSCRYPTV2_COOKIE  (1<<5)
+#define CO_FORCE_TLSCRYPTV2_COOKIE  (1u<<5)
     /**< Bit-flag indicating that we do not allow clients that do
      * not support resending the wrapped client key (WKc) with the
      * third packet of the three-way handshake */
-#define CO_USE_CC_EXIT_NOTIFY       (1<<6)
+#define CO_USE_CC_EXIT_NOTIFY       (1u<<6)
     /**< Bit-flag indicating that explicit exit notifies should be
      * sent via the control channel instead of using an OCC message
      */
-#define CO_USE_DYNAMIC_TLS_CRYPT   (1<<7)
+#define CO_USE_DYNAMIC_TLS_CRYPT   (1u<<7)
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_EPOCH_DATA_KEY_FORMAT  (1<<8)
+#define CO_EPOCH_DATA_KEY_FORMAT  (1u<<8)
     /**< Bit-flag indicating the epoch the data format. This format
      * has the AEAD tag at the end of the packet and is using a longer
      * 64-bit packet id that is split into a 16 bit epoch and 48 bit

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1103?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89820c76e2e099f7acb817c71c8aeb83736ac556
Gerrit-Change-Number: 1103
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--92eO4JJhcPE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1103?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">crypto: Make sure crypto flags are treated as unsigned<br><b=
r>crypto_options.flags is already unsigned, make sure the<br>flags are as w=
ell to avoid spurious conversion warnings.<br><br>Change-Id: I89820c76e2e09=
9f7acb817c71c8aeb83736ac556<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M src/openvpn/crypto.h<br>1 file changed, 9 inserti=
ons(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/03/1103/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.h b/sr=
c/openvpn/crypto.h</span><br><span>index 68ad901..345e7ce 100644</span><br>=
<span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h=
</span><br><span>@@ -341,39 +341,39 @@</span><br><span>      *   keeping st=
ate between successive</span><br><span>      *   OpenVPN process startups. =
*/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define CO_PACKET_ID_LONG_FORM  (1&lt;&lt;0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CO_PACKET_ID_LONG_FORM  (1u&lt;&lt;0)</span=
><br><span>     /**&lt; Bit-flag indicating whether to use</span><br><span>=
     *   OpenVPN&#39;s long packet ID format. */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define CO_IGNORE_PACKET_ID     (1&lt;&lt;1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_IGNORE_PACKE=
T_ID     (1u&lt;&lt;1)</span><br><span>     /**&lt; Bit-flag indicating whe=
ther to ignore</span><br><span>      *   the packet ID of a received packet=
.</span><br><span>      *   This flag is used during processing</span><br><=
span>      *   of the first packet received from a</span><br><span>      * =
  client. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define C=
O_MUTE_REPLAY_WARNINGS (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define CO_MUTE_REPLAY_WARNINGS (1u&lt;&lt;2)</span><br><sp=
an>     /**&lt; Bit-flag indicating not to display</span><br><span>      * =
  replay warnings. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1&lt;&lt;3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (=
1u&lt;&lt;3)</span><br><span>     /**&lt; Bit-flag indicating that data cha=
nnel key derivation</span><br><span>      * is done using TLS keying materi=
al export [RFC5705]</span><br><span>      */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define CO_RESEND_WKC (1&lt;&lt;4)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define CO_RESEND_WKC (1u&lt;&lt;4)</=
span><br><span>     /**&lt; Bit-flag indicating that the client is expected=
 to</span><br><span>      * resend the wrapped client key with the 2nd pack=
et (packet-id 1)</span><br><span>      * like with the HARD_RESET_CLIENT_V3=
 packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_=
FORCE_TLSCRYPTV2_COOKIE  (1&lt;&lt;5)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define CO_FORCE_TLSCRYPTV2_COOKIE  (1u&lt;&lt;5)</span><=
br><span>     /**&lt; Bit-flag indicating that we do not allow clients that=
 do</span><br><span>      * not support resending the wrapped client key (W=
Kc) with the</span><br><span>      * third packet of the three-way handshak=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_USE_CC=
_EXIT_NOTIFY       (1&lt;&lt;6)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CO_USE_CC_EXIT_NOTIFY       (1u&lt;&lt;6)</span><br><sp=
an>     /**&lt; Bit-flag indicating that explicit exit notifies should be</=
span><br><span>      * sent via the control channel instead of using an OCC=
 message</span><br><span>      */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define CO_USE_DYNAMIC_TLS_CRYPT   (1&lt;&lt;7)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CO_USE_DYNAMIC_TLS_CRYPT   =
(1u&lt;&lt;7)</span><br><span>     /**&lt; Bit-flag indicating that renegot=
iations are using tls-crypt</span><br><span>      *   with a TLS-EKM derive=
d key.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define CO_EPOCH_DATA_KEY_FORMAT  (1&lt;&lt;8)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CO_EPOCH_DATA_KEY_FORMAT  (1u&=
lt;&lt;8)</span><br><span>     /**&lt; Bit-flag indicating the epoch the da=
ta format. This format</span><br><span>      * has the AEAD tag at the end =
of the packet and is using a longer</span><br><span>      * 64-bit packet i=
d that is split into a 16 bit epoch and 48 bit</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/110=
3?usp=3Demail">change 1103</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1103?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89820c76e2e099f7acb817c71c8=
aeb83736ac556 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1103 </div>
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


--92eO4JJhcPE=--

