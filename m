From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 14:55:10 +0000
References: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7531966e7a66daf7a04f83659936bc243d39f7dc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XMapXAdYExY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: validate
 tun interface before fetching stats
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

--XMapXAdYExY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail

to review the following change.


Change subject: dco_linux: validate tun interface before fetching stats
......................................................................

dco_linux: validate tun interface before fetching stats

If dco_get_peer_stats() is called with an uninitialized c->c1.tuntap it
results in a segfault. This issue happens when a client who has not
connected to any server:
  - has --management and exits,
  - has --management and a management interface client issues either
    `bytecount` or `status` or
  - if SIGUSR2 is sent to it.

Add a check to ensure the tun interface was set up before attempting to
retrieve peer statistics.

Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 7 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1166/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a3907fe..6e629c1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1139,6 +1139,8 @@
 static int
 dco_get_peer(dco_context_t *dco, int peer_id, const bool raise_sigusr1_on_=
err)
 {
+    ASSERT(dco);
+
     /* peer_id =3D=3D -1 means "dump all peers", but this is allowed in MP=
 mode only.
      * If it happens in P2P mode it means that the DCO peer was deleted an=
d we
      * can simply bail out
@@ -1182,6 +1184,11 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
+    if (!tuntap_defined(c->c1.tuntap))
+    {
+        return -1;
+    }
+
     return dco_get_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id, =
raise_sigusr1_on_err);
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac
Gerrit-Change-Number: 1166
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XMapXAdYExY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: validate tun interface before fetching stats<br><=
br>If dco_get_peer_stats() is called with an uninitialized c-&gt;c1.tuntap =
it<br>results in a segfault. This issue happens when a client who has not<b=
r>connected to any server:<br>  - has --management and exits,<br>  - has --=
management and a management interface client issues either<br>    `bytecoun=
t` or `status` or<br>  - if SIGUSR2 is sent to it.<br><br>Add a check to en=
sure the tun interface was set up before attempting to<br>retrieve peer sta=
tistics.<br><br>Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac<br>Sig=
ned-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_l=
inux.c<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1166/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span=
>index a3907fe..6e629c1 100644</span><br><span>--- a/src/openvpn/dco_linux.=
c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1139,6 =
+1139,8 @@</span><br><span> static int</span><br><span> dco_get_peer(dco_co=
ntext_t *dco, int peer_id, const bool raise_sigusr1_on_err)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(dco);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   /* peer_id =3D=3D -1 means &quot;dump all peers&quot;, but this is allow=
ed in MP mode only.</span><br><span>      * If it happens in P2P mode it me=
ans that the DCO peer was deleted and we</span><br><span>      * can simply=
 bail out</span><br><span>@@ -1182,6 +1184,11 @@</span><br><span> int</span=
><br><span> dco_get_peer_stats(struct context *c, const bool raise_sigusr1_=
on_err)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!tuntap_defined(c-&gt;c1.tuntap))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     return dco_get_peer(&amp;c-&gt;c1.tuntap-&gt;dco, c-&=
gt;c2.tls_multi-&gt;dco_peer_id, raise_sigusr1_on_err);</span><br><span> }<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail">change 1166</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1166?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40c11864745cc1619cb9cbf490b=
168f90feb5eac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1166 </div>
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


--XMapXAdYExY=--

