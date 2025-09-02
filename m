From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 16:26:30 +0000
In-Reply-To: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
References: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <eabbf35dc26e0ea50cc621cf23a9ce02f43fdcfc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k3iUQQtoRMQ="; charset=UTF-8
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

--k3iUQQtoRMQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail

to look at the new patch set (#2).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1166/2

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a3907fe..e70b74d 100644
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
+    if (!c->c1.tuntap || c->c1.tuntap->dco.ifindex =3D=3D 0)
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
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-MessageType: newpatchset

--k3iUQQtoRMQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">dco_linux: validate tun interface before fetching stats<br><br>If dc=
o_get_peer_stats() is called with an uninitialized c-&gt;c1.tuntap it<br>re=
sults in a segfault. This issue happens when a client who has not<br>connec=
ted to any server:<br>  - has --management and exits,<br>  - has --manageme=
nt and a management interface client issues either<br>    `bytecount` or `s=
tatus` or<br>  - if SIGUSR2 is sent to it.<br><br>Add a check to ensure the=
 tun interface was set up before attempting to<br>retrieve peer statistics.=
<br><br>Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac<br>Signed-off-=
by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<b=
r>1 file changed, 7 insertions(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/66/1166/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>ind=
ex a3907fe..e70b74d 100644</span><br><span>--- a/src/openvpn/dco_linux.c</s=
pan><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1139,6 +113=
9,8 @@</span><br><span> static int</span><br><span> dco_get_peer(dco_contex=
t_t *dco, int peer_id, const bool raise_sigusr1_on_err)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(dco);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /=
* peer_id =3D=3D -1 means &quot;dump all peers&quot;, but this is allowed i=
n MP mode only.</span><br><span>      * If it happens in P2P mode it means =
that the DCO peer was deleted and we</span><br><span>      * can simply bai=
l out</span><br><span>@@ -1182,6 +1184,11 @@</span><br><span> int</span><br=
><span> dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_e=
rr)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!c-&gt;c1.tuntap || c-&gt;c1.tuntap-&gt;dco.ifindex =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     return dco_get_peer(&amp;c-&g=
t;c1.tuntap-&gt;dco, c-&gt;c2.tls_multi-&gt;dco_peer_id, raise_sigusr1_on_e=
rr);</span><br><span> }</span><br><span> </span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=
=3Demail">change 1166</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40c11864745cc1619cb9cbf490b=
168f90feb5eac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1166 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--k3iUQQtoRMQ=--

