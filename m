From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 17:39:08 +0000
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <625d97ea2d056fa0d24ef17d8ab3526fed324a2a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SkVY+yGY4bI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Clarify some code
 in epoch with better comments
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

--SkVY+yGY4bI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail

to review the following change.


Change subject: Clarify some code in epoch with better comments
......................................................................

Clarify some code in epoch with better comments

Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 5 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1190/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 4c0f684..873fda5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -97,6 +97,9 @@
         /* IV starts with packet id to make the IV unique for packet */
         if (use_epoch_data_format)
         {
+            /* Note this does not check aead_usage_limit but overstepping =
it by a few
+             * extra block in by one extra write, is not affecting the sec=
urity margin,
+             * next iteration/call to epoch_check_send_iterate will iterat=
e the epoch */
             if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &=
iv_buffer))
             {
                 msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index efd7f60..0f0db13 100644
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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Gerrit-Change-Number: 1190
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--SkVY+yGY4bI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Clarify some code in epoch with better comments<br><br>Chang=
e-Id: I34e6b680618a52003d8408852d415c8aeac01feb<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openv=
pn/crypto.h<br>2 files changed, 5 insertions(+), 2 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1190/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index 4c0f684..873fda5 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -97,6 +97,9 @@=
</span><br><span>         /* IV starts with packet id to make the IV unique=
 for packet */</span><br><span>         if (use_epoch_data_format)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* Note this does not check aead_usage_limit but overstepping it=
 by a few</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * extra block in by one extra write, is not affecting the security margi=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * ne=
xt iteration/call to epoch_check_send_iterate will iterate the epoch */</sp=
an><br><span>             if (!packet_id_write_epoch(&amp;opt-&gt;packet_id=
.send, ctx-&gt;epoch, &amp;iv_buffer))</span><br><span>             {</span=
><br><span>                 msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet=
 ID roll over&quot;);</span><br><span>diff --git a/src/openvpn/crypto.h b/s=
rc/openvpn/crypto.h</span><br><span>index efd7f60..0f0db13 100644</span><br=
><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.=
h</span><br><span>@@ -298,7 +298,7 @@</span><br><span> </span><br><span>   =
  /** last epoch_key used for generation of the current send data keys.</sp=
an><br><span>      * As invariant, the epoch of epoch_key_send is always ke=
pt &gt;=3D the epoch of</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * epoch_key_recv */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * key_ctx_bi.decrypt.epoch  */</span><br><span>     struct epoc=
h_key epoch_key_send;</span><br><span> </span><br><span>     /** epoch_key =
used for the highest receive epoch keys */</span><br><span>@@ -309,7 +309,7=
 @@</span><br><span> </span><br><span>     /** The limit for AEAD cipher, t=
his is the sum of packets + blocks</span><br><span>      * that are allowed=
 to be used. Will switch to a new epoch if this</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * limit is reached*/</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * limit is reached. */</span><br><sp=
an>     uint64_t aead_usage_limit;</span><br><span> </span><br><span>     /=
** Keeps the future epoch data keys for decryption. The current one</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1190?usp=3Demail">change 1190</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1190?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34e6b680618a52003d8408852d4=
15c8aeac01feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1190 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--SkVY+yGY4bI=--

