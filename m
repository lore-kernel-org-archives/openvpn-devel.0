From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 19:23:31 +0000
In-Reply-To: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
References: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6486b940b781d610f391bfb3996cca9f08e8511c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u/2wi86J9sg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u/2wi86J9sg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/877?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/877/2

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
Gerrit-MessageType: newpatchset

--u/2wi86J9sg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/877?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix doxygen warnings in crypto_epoch.h<br><br>In=
troduced by commit 92adbc88b1b37095cebde2a1c5b6ae242f382678.<br><br>Change-=
Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@=
...1227...&gt;<br>Message-Id: &lt;20250129182818.3041-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg30731.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M src/openvpn/crypto_epoch.h<br>1 file changed, 2 insertions(+), 1 delet=
ion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/77/877/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/c=
rypto_epoch.h</span><br><span>index b2f3d86..9290482 100644</span><br><span=
>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++ b/src/openvpn/crypto_=
epoch.h</span><br><span>@@ -71,7 +71,7 @@</span><br><span>  * Generate a da=
ta channel key pair from the epoch key</span><br><span>  * @param key      =
     Destination for the generated data key</span><br><span>  * @param epoc=
h_key     Epoch key to be used</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @parm kt             Cipher information to generate the data ch=
annel key for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram kt            Cipher information to generate the data channel key for</=
span><br><span>  */</span><br><span> void</span><br><span> epoch_data_key_d=
erive(struct key_parameters *key,</span><br><span>@@ -100,6 +100,7 @@</span=
><br><span>  * - recv key matches the epoch index provided</span><br><span>=
  * - send key epoch is equal or higher than recv_key epoch</span><br><span=
>  *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param co   =
     crypto_options to update</span><br><span>  * @param new_epoch the new =
epoch to use for the receive key</span><br><span>  */</span><br><span> void=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/877?usp=3Demail">change 877</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/877?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--u/2wi86J9sg=--

