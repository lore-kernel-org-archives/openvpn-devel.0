From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 1 Aug 2025 09:33:43 +0000
References: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7280c018eeedd18b6c5fc10c23177dcd5e09cf1b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YDXGsIwPHb8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Log setting DNS via
 NRPT
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

--YDXGsIwPHb8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail

to review the following change.


Change subject: Log setting DNS via NRPT
......................................................................

Log setting DNS via NRPT

Unlike other ways of setting DNS, we don't log anything
when we use NRPT. Since dco-win/--dns is the recommended
configuration and it uses NRPT to set DNS, let's log it.

Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dns.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1126/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ea3d91b..e079cd0 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -461,6 +461,11 @@
     make_domain_list("dns search domains", search_domains, false,
                      nrpt.search_domains, sizeof(nrpt.search_domains));

+    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index =3D %d) using service",
+        (add ? "Setting" : "Deleting"), nrpt.resolve_domains[0] !=3D 0 ? "=
, resolve domains" : "",
+        nrpt.search_domains[0] !=3D 0 ? ", search domains" : "",
+        nrpt.iface.name, nrpt.iface.index);
+
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b
Gerrit-Change-Number: 1126
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--YDXGsIwPHb8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Log setting DNS via NRPT<br><br>Unlike other ways of setting=
 DNS, we don&#39;t log anything<br>when we use NRPT. Since dco-win/--dns is=
 the recommended<br>configuration and it uses NRPT to set DNS, let&#39;s lo=
g it.<br><br>Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b<br>Signed=
-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dns.c<b=
r>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/26/1126/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index ea3d91b..=
e079cd0 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ =
b/src/openvpn/dns.c</span><br><span>@@ -461,6 +461,11 @@</span><br><span>  =
   make_domain_list(&quot;dns search domains&quot;, search_domains, false,<=
/span><br><span>                      nrpt.search_domains, sizeof(nrpt.sear=
ch_domains));</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39; (if_index =
=3D %d) using service&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        (add ? &quot;Setting&quot; : &quot;Deleting&quot;), nrpt.r=
esolve_domains[0] !=3D 0 ? &quot;, resolve domains&quot; : &quot;&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        nrpt.search_do=
mains[0] !=3D 0 ? &quot;, search domains&quot; : &quot;&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        nrpt.iface.name, nrpt.if=
ace.index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt),=
 &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> </span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1126?usp=3Demail">change 1126</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1126?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2f30fe69cb676e347e4d59cd2d=
b68db7568ba5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1126 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
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


--YDXGsIwPHb8=--

