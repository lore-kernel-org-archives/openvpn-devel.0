From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Dec 2025 15:37:06 +0000
In-Reply-To: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <836f554273a5d7dc538f74ecfd9396aff9b01a2b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Dy3KJJFG34="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/Dy3KJJFG34=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Clarify some code in epoch with better comments
......................................................................

Clarify some code in epoch with better comments

Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 8 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1190/2

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8049b3a..d6b8841 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -97,6 +97,12 @@
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
+             * iterate the epoch */
             if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &=
iv_buffer))
             {
                 msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 72c6821..3842615 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -298,7 +298,7 @@

     /** last epoch_key used for generation of the current send data keys.
      * As invariant, the epoch of epoch_key_send is always kept >=3D the e=
poch of
-     * epoch_key_recv */
+     * key_ctx_bi.decrypt.epoch  */
     struct epoch_key epoch_key_send;

     /** epoch_key used for the highest receive epoch keys */
@@ -309,7 +309,7 @@

     /** The limit for AEAD cipher, this is the sum of packets + blocks
      * that are allowed to be used. Will switch to a new epoch if this
-     * limit is reached*/
+     * limit is reached. */
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--/Dy3KJJFG34=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Clarify some code in epoch w=
ith better comments<br><br>Change-Id: I34e6b680618a52003d8408852d415c8aeac0=
1feb<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src=
/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 files changed, 8 insertion=
s(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/90/1190/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/crypto.c b/src/openvpn/crypto.c</span><br><span>index 8049b3a..d6b8841 10=
0644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/o=
penvpn/crypto.c</span><br><span>@@ -97,6 +97,12 @@</span><br><span>        =
 /* IV starts with packet id to make the IV unique for packet */</span><br>=
<span>         if (use_epoch_data_format)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Note this d=
oes not check aead_usage_limit but can overstep it by</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * a few extra blocks in one =
extra write. This is not affecting the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * security margin as these extra blocks are=
 on a completely</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * different order of magnitude than the security margin.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             * The next iter=
ation/call to epoch_check_send_iterate will</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * iterate the epoch */</span><br><span=
>             if (!packet_id_write_epoch(&amp;opt-&gt;packet_id.send, ctx-&=
gt;epoch, &amp;iv_buffer))</span><br><span>             {</span><br><span> =
                msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet ID roll ove=
r&quot;);</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/c=
rypto.h</span><br><span>index 72c6821..3842615 100644</span><br><span>--- a=
/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br>=
<span>@@ -298,7 +298,7 @@</span><br><span> </span><br><span>     /** last e=
poch_key used for generation of the current send data keys.</span><br><span=
>      * As invariant, the epoch of epoch_key_send is always kept &gt;=3D t=
he epoch of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * epo=
ch_key_recv */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* key_ctx_bi.decrypt.epoch  */</span><br><span>     struct epoch_key epoch_=
key_send;</span><br><span> </span><br><span>     /** epoch_key used for the=
 highest receive epoch keys */</span><br><span>@@ -309,7 +309,7 @@</span><b=
r><span> </span><br><span>     /** The limit for AEAD cipher, this is the s=
um of packets + blocks</span><br><span>      * that are allowed to be used.=
 Will switch to a new epoch if this</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * limit is reached*/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * limit is reached. */</span><br><span>     uint64=
_t aead_usage_limit;</span><br><span> </span><br><span>     /** Keeps the f=
uture epoch data keys for decryption. The current one</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1190?usp=3Demail">change 1190</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1190?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34e6b680618a52003d8408852d4=
15c8aeac01feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1190 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--/Dy3KJJFG34=--

