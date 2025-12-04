From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 13:24:01 +0000
In-Reply-To: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <48b6d634ed33d7c86edf88b069a9ff65f6276302-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0PupD1xreoQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Clarify some code in
 epoch with better comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0PupD1xreoQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
90?usp=3Demail )

Change subject: Clarify some code in epoch with better comments
......................................................................

Clarify some code in epoch with better comments

Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1190
Message-Id: <20251203125741.29239-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
829.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 11 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8049b3a..e43bc6c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -97,6 +97,13 @@
         /* IV starts with packet id to make the IV unique for packet */
         if (use_epoch_data_format)
         {
+            /* Note this does not check aead_usage_limit but can overstep =
it by
+             * a few extra blocks in one extra write. This is not affectin=
g the
+             * security margin as these extra blocks are on a completely
+             * different order of magnitude than the security margin.
+             * The next iteration/call to epoch_check_send_iterate will
+             * iterate the epoch
+             */
             if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &=
iv_buffer))
             {
                 msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 72c6821..9424fd7 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -298,7 +298,8 @@

     /** last epoch_key used for generation of the current send data keys.
      * As invariant, the epoch of epoch_key_send is always kept >=3D the e=
poch of
-     * epoch_key_recv */
+     * key_ctx_bi.decrypt.epoch
+     */
     struct epoch_key epoch_key_send;

     /** epoch_key used for the highest receive epoch keys */
@@ -309,7 +310,8 @@

     /** The limit for AEAD cipher, this is the sum of packets + blocks
      * that are allowed to be used. Will switch to a new epoch if this
-     * limit is reached*/
+     * limit is reached.
+     */
     uint64_t aead_usage_limit;

     /** Keeps the future epoch data keys for decryption. The current one

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Gerrit-Change-Number: 1190
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0PupD1xreoQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1190?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Clarify some code in epoch with better comments<=
br><br>Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb<br>Signed-off-b=
y: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1190<br>Message-Id: &lt;20251203125741.29239-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34829.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 files changed, 11 insertion=
s(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index 8049b3a..e43bc6c 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -97,6 +97,13 @=
@</span><br><span>         /* IV starts with packet id to make the IV uniqu=
e for packet */</span><br><span>         if (use_epoch_data_format)</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* Note this does not check aead_usage_limit but can overstep i=
t by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
a few extra blocks in one extra write. This is not affecting the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             * security margin=
 as these extra blocks are on a completely</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             * different order of magnitude than the=
 security margin.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * The next iteration/call to epoch_check_send_iterate will</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+             * iterate th=
e epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 */</span><br><span>             if (!packet_id_write_epoch(&amp;opt-&gt;pa=
cket_id.send, ctx-&gt;epoch, &amp;iv_buffer))</span><br><span>             =
{</span><br><span>                 msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR:=
 packet ID roll over&quot;);</span><br><span>diff --git a/src/openvpn/crypt=
o.h b/src/openvpn/crypto.h</span><br><span>index 72c6821..9424fd7 100644</s=
pan><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/=
crypto.h</span><br><span>@@ -298,7 +298,8 @@</span><br><span> </span><br><s=
pan>     /** last epoch_key used for generation of the current send data ke=
ys.</span><br><span>      * As invariant, the epoch of epoch_key_send is al=
ways kept &gt;=3D the epoch of</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * epoch_key_recv */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * key_ctx_bi.decrypt.epoch</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span>     struct epoch_key epo=
ch_key_send;</span><br><span> </span><br><span>     /** epoch_key used for =
the highest receive epoch keys */</span><br><span>@@ -309,7 +310,8 @@</span=
><br><span> </span><br><span>     /** The limit for AEAD cipher, this is th=
e sum of packets + blocks</span><br><span>      * that are allowed to be us=
ed. Will switch to a new epoch if this</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * limit is reached*/</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * limit is reached.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span>     uint64_t aead_usag=
e_limit;</span><br><span> </span><br><span>     /** Keeps the future epoch =
data keys for decryption. The current one</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=
=3Demail">change 1190</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34e6b680618a52003d8408852d4=
15c8aeac01feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1190 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--0PupD1xreoQ=--

