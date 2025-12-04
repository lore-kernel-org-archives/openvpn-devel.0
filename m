From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 13:23:57 +0000
In-Reply-To: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <48b6d634ed33d7c86edf88b069a9ff65f6276302-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XfSQt/JvD5s="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XfSQt/JvD5s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by ordex


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1190/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Gerrit-Change-Number: 1190
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XfSQt/JvD5s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by ordex</p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Clar=
ify some code in epoch with better comments<br><br>Change-Id: I34e6b680618a=
52003d8408852d415c8aeac01feb<br>Signed-off-by: Arne Schwabe &lt;arne@...2068...=
7...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit =
URL: https://gerrit.openvpn.net/c/openvpn/+/1190<br>Message-Id: &lt;2025120=
3125741.29239-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg34829.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openv=
pn/crypto.h<br>2 files changed, 11 insertions(+), 2 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/90/1190/3</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto=
.c</span><br><span>index 8049b3a..e43bc6c 100644</span><br><span>--- a/src/=
openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span=
>@@ -97,6 +97,13 @@</span><br><span>         /* IV starts with packet id to=
 make the IV unique for packet */</span><br><span>         if (use_epoch_da=
ta_format)</span><br><span>         {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* Note this does not check aead_usage_limit =
but can overstep it by</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             * a few extra blocks in one extra write. This is not affect=
ing the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * security margin as these extra blocks are on a completely</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * different order of =
magnitude than the security margin.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * The next iteration/call to epoch_check_send_=
iterate will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * iterate the epoch</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             */</span><br><span>             if (!packet_id_write_epo=
ch(&amp;opt-&gt;packet_id.send, ctx-&gt;epoch, &amp;iv_buffer))</span><br><=
span>             {</span><br><span>                 msg(D_CRYPT_ERRORS, &q=
uot;ENCRYPT ERROR: packet ID roll over&quot;);</span><br><span>diff --git a=
/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 72c6821.=
.9424fd7 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>=
+++ b/src/openvpn/crypto.h</span><br><span>@@ -298,7 +298,8 @@</span><br><s=
pan> </span><br><span>     /** last epoch_key used for generation of the cu=
rrent send data keys.</span><br><span>      * As invariant, the epoch of ep=
och_key_send is always kept &gt;=3D the epoch of</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * epoch_key_recv */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * key_ctx_bi.decrypt.epoch</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>     =
struct epoch_key epoch_key_send;</span><br><span> </span><br><span>     /**=
 epoch_key used for the highest receive epoch keys */</span><br><span>@@ -3=
09,7 +310,8 @@</span><br><span> </span><br><span>     /** The limit for AEA=
D cipher, this is the sum of packets + blocks</span><br><span>      * that =
are allowed to be used. Will switch to a new epoch if this</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * limit is reached*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * limit is reached.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>   =
  uint64_t aead_usage_limit;</span><br><span> </span><br><span>     /** Kee=
ps the future epoch data keys for decryption. The current one</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1190?usp=3Demail">change 1190</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1190?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--XfSQt/JvD5s=--

