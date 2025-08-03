From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Aug 2025 15:16:56 +0000
In-Reply-To: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
References: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <e270767806b1a023ca67ebd020c5cb001b6a89f7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f7N9Ui4rbFo="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f7N9Ui4rbFo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Log setting DNS via NRPT
......................................................................

Log setting DNS via NRPT

Unlike other ways of setting DNS, we don't log anything
when we use NRPT. Since dco-win/--dns is the recommended
configuration and it uses NRPT to set DNS, let's log it.

Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250803144950.21034-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
480.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 5 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1126/2

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 2952a8a..22f4cec 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -460,6 +460,11 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--f7N9Ui4rbFo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1126=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Log setting DNS via NRPT<br><br>Unlike other ways of=
 setting DNS, we don&#39;t log anything<br>when we use NRPT. Since dco-win/=
--dns is the recommended<br>configuration and it uses NRPT to set DNS, let&=
#39;s log it.<br><br>Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b<b=
r>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250803144950.21034-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg32480.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 5 insertions(+), 0 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/26/1126/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.=
c</span><br><span>index 2952a8a..22f4cec 100644</span><br><span>--- a/src/o=
penvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -46=
0,6 +460,11 @@</span><br><span>     make_domain_list(&quot;dns search domai=
ns&quot;, search_domains, false,</span><br><span>                      nrpt=
.search_domains, sizeof(nrpt.search_domains));</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s NRPT D=
NS%s%s on &#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        (add ? &quot;Setting&quot=
; : &quot;Deleting&quot;), nrpt.resolve_domains[0] !=3D 0 ? &quot;, resolve=
 domains&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        nrpt.search_domains[0] !=3D 0 ? &quot;, search domains&q=
uot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        nrpt.iface.name, nrpt.iface.index);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     send_msg_iservice(o-&gt;msg_=
channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><sp=
an> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail">change 1=
126</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1126?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2f30fe69cb676e347e4d59cd2d=
b68db7568ba5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1126 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--f7N9Ui4rbFo=--

