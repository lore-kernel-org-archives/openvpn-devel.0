From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 19:23:32 +0000
In-Reply-To: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
References: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6486b940b781d610f391bfb3996cca9f08e8511c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vG0Xqpv3z+4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vG0Xqpv3z+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/87=
7?usp=3Demail )

Change subject: Fix doxygen warnings in crypto_epoch.h
......................................................................

Fix doxygen warnings in crypto_epoch.h

Introduced by commit 92adbc88b1b37095cebde2a1c5b6ae242f382678.

Change-Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250129182818.3041-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
731.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_epoch.h
1 file changed, 2 insertions(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vG0Xqpv3z+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/877?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix doxygen warnings in crypto_epoch.h<br><br>=
Introduced by commit 92adbc88b1b37095cebde2a1c5b6ae242f382678.<br><br>Chang=
e-Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvp=
n@...1227...&gt;<br>Message-Id: &lt;20250129182818.3041-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg30731.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/crypto_epoch.h<br>1 file changed, 2 insertions(+), 1 del=
etion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h</sp=
an><br><span>index b2f3d86..9290482 100644</span><br><span>--- a/src/openvp=
n/crypto_epoch.h</span><br><span>+++ b/src/openvpn/crypto_epoch.h</span><br=
><span>@@ -71,7 +71,7 @@</span><br><span>  * Generate a data channel key pa=
ir from the epoch key</span><br><span>  * @param key           Destination =
for the generated data key</span><br><span>  * @param epoch_key     Epoch k=
ey to be used</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @parm=
 kt             Cipher information to generate the data channel key for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param kt           =
 Cipher information to generate the data channel key for</span><br><span>  =
*/</span><br><span> void</span><br><span> epoch_data_key_derive(struct key_=
parameters *key,</span><br><span>@@ -100,6 +100,7 @@</span><br><span>  * - =
recv key matches the epoch index provided</span><br><span>  * - send key ep=
och is equal or higher than recv_key epoch</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param co        crypto_optio=
ns to update</span><br><span>  * @param new_epoch the new epoch to use for =
the receive key</span><br><span>  */</span><br><span> void</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/877?usp=3Demail">change 877</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/877?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0133085ac68f7b0db574b88276f=
6d5e1d3ad62d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 877 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vG0Xqpv3z+4=--

