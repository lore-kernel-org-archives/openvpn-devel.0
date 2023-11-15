From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 10:23:05 +0000
In-Reply-To: <gerrit.1699712500000.I226a73d47a2b1b29f7ec175ce23a806593abc2ac@...2715...>
References: <gerrit.1699712500000.I226a73d47a2b1b29f7ec175ce23a806593abc2ac@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <58b3e1584bdb329e21ec3b15743dc47fe897e564-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tv6OyPZXkLk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not check
 key_state buffers that are in S_UNDEF state
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

--tv6OyPZXkLk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail )


Change subject: Do not check key_state buffers that are in S_UNDEF state
......................................................................

Do not check key_state buffers that are in S_UNDEF state

When a key_state is in S_UNDEF the send_reliable is not initialised. So
checking it might access invalid memory or null pointers.

Change-Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac
[a@...2181...: add check for !send_reliable and message]
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 16 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/426/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cee4afe..b4cd8f5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3189,6 +3189,22 @@
     for (int i =3D 0; i < KS_SIZE; i++)
     {
         struct key_state *ks =3D &session->key[i];
+        if (ks->state =3D=3D S_UNDEF)
+        {
+            continue;
+        }
+
+        /* we don't expect send_reliable to be NULL when state is
+         * not S_UNDEF, but people have reported crashes nonetheless,
+         * therefore we better catch this event, report and exit.
+         */
+        if (!ks->send_reliable)
+        {
+            msg(M_FATAL, "ERROR: session->key[%d]->send_reliable is NULL "
+                "while key state is %s. Exiting.",
+                i, state_name(ks->state));
+        }
+
         for (int j =3D 0; j < ks->send_reliable->size; j++)
         {
             if (ks->send_reliable->array[i].buf.data =3D=3D dataptr)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac
Gerrit-Change-Number: 426
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--tv6OyPZXkLk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
426?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Do not check key_state buffers that are in=
 S_UNDEF state<br><br>When a key_state is in S_UNDEF the send_reliable is n=
ot initialised. So<br>checking it might access invalid memory or null point=
ers.<br><br>Change-Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac<br>[a@...1665...=
181...: add check for !send_reliable and message]<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file chang=
ed, 16 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/26/426/2</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
ssl.c b/src/openvpn/ssl.c</span><br><span>index cee4afe..b4cd8f5 100644</sp=
an><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.=
c</span><br><span>@@ -3189,6 +3189,22 @@</span><br><span>     for (int i =
=3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</span><br><span>        =
 struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (ks-&gt;state =3D=3D S_UNDEF)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* we don&#39;t expect send_reliable to be NULL when=
 state is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 not S_UNDEF, but people have reported crashes nonetheless,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * therefore we better catc=
h this event, report and exit.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!ks-&gt;send_reliable)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_FATAL, &quot;ERROR: session-&gt;key[%d]-&gt;send_=
reliable is NULL &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                &quot;while key state is %s. Exiting.&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                i, state_name(=
ks-&gt;state));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>         for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</s=
pan><br><span>         {</span><br><span>             if (ks-&gt;send_relia=
ble-&gt;array[i].buf.data =3D=3D dataptr)</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/426?usp=
=3Demail">change 426</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I226a73d47a2b1b29f7ec175ce23=
a806593abc2ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 426 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tv6OyPZXkLk=--

