From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Aug 2025 15:16:58 +0000
In-Reply-To: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
References: <gerrit.1754040821000.Ib2f30fe69cb676e347e4d59cd2db68db7568ba5b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <e270767806b1a023ca67ebd020c5cb001b6a89f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5ww1Ny67Iw4="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5ww1Ny67Iw4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
26?usp=3Demail )

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
Gerrit-MessageType: merged

--5ww1Ny67Iw4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1126?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Log setting DNS via NRPT<br><br>Unlike other =
ways of setting DNS, we don&#39;t log anything<br>when we use NRPT. Since d=
co-win/--dns is the recommended<br>configuration and it uses NRPT to set DN=
S, let&#39;s log it.<br><br>Change-Id: Ib2f30fe69cb676e347e4d59cd2db68db756=
8ba5b<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250803144950.21034-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg32480.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 5 insertions(=
+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 2952a8a..22f4cec 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -460,6 +460,11 @@</span><b=
r><span>     make_domain_list(&quot;dns search domains&quot;, search_domain=
s, false,</span><br><span>                      nrpt.search_domains, sizeof=
(nrpt.search_domains));</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39; =
(if_index =3D %d) using service&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        (add ? &quot;Setting&quot; : &quot;Deleting&quot=
;), nrpt.resolve_domains[0] !=3D 0 ? &quot;, resolve domains&quot; : &quot;=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        nrpt=
.search_domains[0] !=3D 0 ? &quot;, search domains&quot; : &quot;&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        nrpt.iface.nam=
e, nrpt.iface.index);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, siz=
eof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1126?usp=3Demail">change 1126</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1126?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--5ww1Ny67Iw4=--

