From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 12:27:43 +0000
References: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <efcefeae049fc452931e2d920dea3170be0d0856-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j6UYCkV3jLk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix doxygen
 warnings in crypto_epoch.h
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

--j6UYCkV3jLk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail

to review the following change.


Change subject: Fix doxygen warnings in crypto_epoch.h
......................................................................

Fix doxygen warnings in crypto_epoch.h

Introduced by commit 92adbc88b1b37095cebde2a1c5b6ae242f382678.

Change-Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_epoch.h
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/877/1

diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index b2f3d86..9290482 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -71,7 +71,7 @@
  * Generate a data channel key pair from the epoch key
  * @param key           Destination for the generated data key
  * @param epoch_key     Epoch key to be used
- * @parm kt             Cipher information to generate the data channel ke=
y for
+ * @param kt            Cipher information to generate the data channel ke=
y for
  */
 void
 epoch_data_key_derive(struct key_parameters *key,
@@ -100,6 +100,7 @@
  * - recv key matches the epoch index provided
  * - send key epoch is equal or higher than recv_key epoch
  *
+ * @param co        crypto_options to update
  * @param new_epoch the new epoch to use for the receive key
  */
 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5
Gerrit-Change-Number: 877
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--j6UYCkV3jLk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix doxygen warnings in crypto_epoch.h<br><br>Introduced by c=
ommit 92adbc88b1b37095cebde2a1c5b6ae242f382678.<br><br>Change-Id: I0133085a=
c68f7b0db574b88276f6d5e1d3ad62d5<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>---<br>M src/openvpn/crypto_epoch.h<br>1 file changed=
, 2 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/77/877/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cryp=
to_epoch.h b/src/openvpn/crypto_epoch.h</span><br><span>index b2f3d86..9290=
482 100644</span><br><span>--- a/src/openvpn/crypto_epoch.h</span><br><span=
>+++ b/src/openvpn/crypto_epoch.h</span><br><span>@@ -71,7 +71,7 @@</span><=
br><span>  * Generate a data channel key pair from the epoch key</span><br>=
<span>  * @param key           Destination for the generated data key</span=
><br><span>  * @param epoch_key     Epoch key to be used</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @parm kt             Cipher informati=
on to generate the data channel key for</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param kt            Cipher information to generate =
the data channel key for</span><br><span>  */</span><br><span> void</span><=
br><span> epoch_data_key_derive(struct key_parameters *key,</span><br><span=
>@@ -100,6 +100,7 @@</span><br><span>  * - recv key matches the epoch index=
 provided</span><br><span>  * - send key epoch is equal or higher than recv=
_key epoch</span><br><span>  *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param co        crypto_options to update</span><br><span>  *=
 @param new_epoch the new epoch to use for the receive key</span><br><span>=
  */</span><br><span> void</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail">change=
 877</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0133085ac68f7b0db574b88276f=
6d5e1d3ad62d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 877 </div>
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


--j6UYCkV3jLk=--

