From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 11 Nov 2023 14:21:43 +0000
References: <gerrit.1699712500000.I226a73d47a2b1b29f7ec175ce23a806593abc2ac@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <57300481a334c57d0e58724244054e36d01a30a2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ONgxSD8WOB0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not check
 key_state buffers that are in S_UNDEF state
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

--ONgxSD8WOB0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail

to review the following change.


Change subject: Do not check key_state buffers that are in S_UNDEF state
......................................................................

Do not check key_state buffers that are in S_UNDEF state

When a key_state is in S_UNDEF the send_reliable is not initialised. So
checking it might access invalid memory or null pointers.

Change-Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac
---
M src/openvpn/ssl.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/426/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cee4afe..24f2bab 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3189,6 +3189,11 @@
     for (int i =3D 0; i < KS_SIZE; i++)
     {
         struct key_state *ks =3D &session->key[i];
+        if (ks->state =3D=3D S_UNDEF)
+        {
+            continue;
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ONgxSD8WOB0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not check key_state buffers that are in S_UNDEF state<br><=
br>When a key_state is in S_UNDEF the send_reliable is not initialised. So<=
br>checking it might access invalid memory or null pointers.<br><br>Change-=
Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac<br>---<br>M src/openvpn/ssl.c=
<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/26/426/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index cee4afe..24f=
2bab 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/s=
rc/openvpn/ssl.c</span><br><span>@@ -3189,6 +3189,11 @@</span><br><span>   =
  for (int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</span><br><=
span>         struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;state =3D=3D=
 S_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         fo=
r (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span>=
         {</span><br><span>             if (ks-&gt;send_reliable-&gt;array[=
i].buf.data =3D=3D dataptr)</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail">chang=
e 426</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/426?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I226a73d47a2b1b29f7ec175ce23=
a806593abc2ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 426 </div>
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


--ONgxSD8WOB0=--

