From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:48 +0000
References: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2e1dd099fb0df6b28cd411711433e0a840548add-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xRLGa9I4yrA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xRLGa9I4yrA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl.c
1 file changed, 3 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1297/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 567560f..dfbbbc6 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -180,21 +180,16 @@
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
@@ -227,10 +222,6 @@
     return overhead;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 init_ssl_lib(void)
 {
@@ -2651,7 +2642,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Gerrit-Change-Number: 1297
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--xRLGa9I4yrA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: change return type of calc_control_cha=
nnel_frame_overhead to size_t<br><br>This avoids dealing with conversion wa=
rnings inside<br>the function. Since we only add values that are<br>suppose=
d to be positive this should be safe.<br><br>Note that we now cast the retu=
rn value to int at<br>the caller side. There we actually substract it and<b=
r>want to catch the case where the result gets negative.<br>Since all the i=
nvolved values are quite small compared<br>to INT_MAX I decided to just cas=
t it without further<br>checks.<br><br>Change-Id: I71e9d4a61d37483685723c16=
e98f59755694cadf<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 3 insertions(+), 12 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/97/1297/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/s=
rc/openvpn/ssl.c</span><br><span>index 567560f..dfbbbc6 100644</span><br><s=
pan>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><=
br><span>@@ -180,21 +180,16 @@</span><br><span>     frame-&gt;tun_mtu =3D m=
ax_int(frame-&gt;tun_mtu, TLS_CHANNEL_MTU_MIN);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  =
* calculate the maximum overhead that control channel frames have</span><br=
><span>  * This includes header, op code and everything apart from the</spa=
n><br><span>  * payload itself. This method is a bit pessimistic and might =
give higher</span><br><span>  * overhead than we actually have */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static size_t</span><br><span> calc_cont=
rol_channel_frame_overhead(const struct tls_session *session)</span><br><sp=
an> {</span><br><span>     const struct key_state *ks =3D &amp;session-&gt;=
key[KS_PRIMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt overhead =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t overhead =3D 0;</span><br><span> </span><br><span>     /* opcode =
*/</span><br><span>     overhead +=3D 1;</span><br><span>@@ -227,10 +222,6 =
@@</span><br><span>     return overhead;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> void</span><br><span> init_ssl_lib(void)</span><br><span> {</spa=
n><br><span>@@ -2651,7 +2642,7 @@</span><br><span>     int max_pkt_len =3D =
min_int(TLS_CHANNEL_BUF_SIZE, session-&gt;opt-&gt;frame.tun_mtu);</span><br=
><span> </span><br><span>     /* Subtract overhead */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    max_pkt_len -=3D calc_control_channel_f=
rame_overhead(session);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    max_pkt_len -=3D (int)calc_control_channel_frame_overhead(session);=
</span><br><span> </span><br><span>     /* calculate total available length=
 for outgoing tls ciphertext */</span><br><span>     int maxlen =3D max_pkt=
_len * rel_avail;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail">change 1297</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I71e9d4a61d37483685723c16e98=
f59755694cadf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1297 </div>
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

--xRLGa9I4yrA=--

