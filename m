From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 17 Jun 2025 07:28:27 +0000
References: <gerrit.1750145305000.I0e17d9aea32eab7f44ed95037f077ae6dec52053@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <768b8519ee05f44e620493989ef300eca0c8a675-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cpkxtDM5c6Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Preserve socket
 protocol during float processing
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

--cpkxtDM5c6Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail

to review the following change.


Change subject: Preserve socket protocol during float processing
......................................................................

Preserve socket protocol during float processing

During a float operation, we remove the old `mroute` object
corresponding to the current multi instance from the hash table and
insert a new one. With the introduction of the multi-socket feature, the
`mroute` structure gained a `proto` field, which must also be set in the
new instance, otherwise, hash table lookups will fail.

This commit ensures that the `proto` field is propagated from the
original to the new `mroute` object during float processing.

Change-Id: I0e17d9aea32eab7f44ed95037f077ae6dec52053
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/multi.c
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1063/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 169af43..a760e07 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3217,6 +3217,12 @@
     struct hash *hash =3D m->hash;
     struct gc_arena gc =3D gc_new();

+    if (mi->real.type & MR_WITH_PROTO)
+    {
+        real.type |=3D MR_WITH_PROTO;
+        real.proto =3D sock->info.proto;
+    }
+
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true=
))
     {
         goto done;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e17d9aea32eab7f44ed95037f077ae6dec52053
Gerrit-Change-Number: 1063
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--cpkxtDM5c6Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Preserve socket protocol during float processing<br><br>Duri=
ng a float operation, we remove the old `mroute` object<br>corresponding to=
 the current multi instance from the hash table and<br>insert a new one. Wi=
th the introduction of the multi-socket feature, the<br>`mroute` structure =
gained a `proto` field, which must also be set in the<br>new instance, othe=
rwise, hash table lookups will fail.<br><br>This commit ensures that the `p=
roto` field is propagated from the<br>original to the new `mroute` object d=
uring float processing.<br><br>Change-Id: I0e17d9aea32eab7f44ed95037f077ae6=
dec52053<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M sr=
c/openvpn/multi.c<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1063/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><s=
pan>index 169af43..a760e07 100644</span><br><span>--- a/src/openvpn/multi.c=
</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3217,6 +3217=
,12 @@</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;real.type &amp; MR_WI=
TH_PROTO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        real.type |=3D M=
R_WITH_PROTO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  real.proto =3D sock-&gt;info.proto;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     if (!mroute_extract_openvpn_sockaddr(&amp;real, &=
amp;m-&gt;top.c2.from.dest, true))</span><br><span>     {</span><br><span> =
        goto done;</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail">change 1063</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1063?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e17d9aea32eab7f44ed95037f0=
77ae6dec52053 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1063 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--cpkxtDM5c6Q=--

