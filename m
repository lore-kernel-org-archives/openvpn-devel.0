From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 17 Jul 2023 14:17:10 +0000
In-Reply-To: <gerrit.1679478040000.I4c089e486728a43bfe42596787c00355838311da@...2715...>
References: <gerrit.1679478040000.I4c089e486728a43bfe42596787c00355838311da@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., a@...2181...
Message-ID: <eaefe4dffa1843c767f12973b875d6daddd000f8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I1DiRsz20O8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Fix
 '--inactive <time> 0' behavior for DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>

--I1DiRsz20O8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has submitted this change. ( http://gerrit.openvpn.net/c/openv=
pn/+/201?usp=3Demail )

Change subject: Fix '--inactive <time> 0' behavior for DCO
......................................................................

Fix '--inactive <time> 0' behavior for DCO

Make sure we exit if <bytes> is 0 (not set) and no traffic
was produced.

According to man page and non-DCO --inactive implementation,
we exit if amount of bytes produced is less than <bytes> specified.
DCO implementation will do off-by-ones, but we consider it as okay
since we don't want to complicate code to handle both bytes=3D0 and >0
cases.

Change-Id: I4c089e486728a43bfe42596787c00355838311da
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230322113408.2057-1-lstipakov@...277...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20230322113408.2057-1-=
lstipakov@...277...
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 6c64b46b15476351ca19f9a8f3cb8185aa2c7e07)
---
M src/openvpn/forward.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 28a96f9..b3e0ba5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -481,7 +481,7 @@
         int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;

-        if (new_bytes >=3D c->options.inactivity_minimum_bytes)
+        if (new_bytes > c->options.inactivity_minimum_bytes)
         {
             c->c2.inactivity_bytes =3D tot_bytes;
             event_timeout_reset(&c->c2.inactivity_interval);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/201?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I4c089e486728a43bfe42596787c00355838311da
Gerrit-Change-Number: 201
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--I1DiRsz20O8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld <strong>submitted</strong> this change.</p><p><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/201?usp=3Demail">View Change</a></p><di=
v style=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">Fix &#39;--inactive &lt;time&gt; 0&#39;=
 behavior for DCO<br><br>Make sure we exit if &lt;bytes&gt; is 0 (not set) =
and no traffic<br>was produced.<br><br>According to man page and non-DCO --=
inactive implementation,<br>we exit if amount of bytes produced is less tha=
n &lt;bytes&gt; specified.<br>DCO implementation will do off-by-ones, but w=
e consider it as okay<br>since we don&#39;t want to complicate code to hand=
le both bytes=3D0 and &gt;0<br>cases.<br><br>Change-Id: I4c089e486728a43bfe=
42596787c00355838311da<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20230=
322113408.2057-1-lstipakov@...277...&gt;<br>URL: https://www.mail-archive.c=
om/search?l=3Dmid&amp;q=3D20230322113408.2057-1-lstipakov@...277...<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry picked from comm=
it 6c64b46b15476351ca19f9a8f3cb8185aa2c7e07)<br>---<br>M src/openvpn/forwar=
d.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 28a96f9..b3e0ba5 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -481,7 +48=
1,7 @@</span><br><span>         int64_t tot_bytes =3D c-&gt;c2.tun_read_byt=
es + c-&gt;c2.tun_write_bytes;</span><br><span>         int64_t new_bytes =
=3D tot_bytes - c-&gt;c2.inactivity_bytes;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (new_bytes &gt;=3D c-&gt;=
options.inactivity_minimum_bytes)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (new_bytes &gt; c-&gt;options.inactivity_minimum_b=
ytes)</span><br><span>         {</span><br><span>             c-&gt;c2.inac=
tivity_bytes =3D tot_bytes;</span><br><span>             event_timeout_rese=
t(&amp;c-&gt;c2.inactivity_interval);</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/201?usp=3Dem=
ail">change 201</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/201?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4c089e486728a43bfe42596787c=
00355838311da </div>
<div style=3D"display:none"> Gerrit-Change-Number: 201 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--I1DiRsz20O8=--

