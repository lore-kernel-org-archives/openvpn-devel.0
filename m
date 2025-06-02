From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 2 Jun 2025 15:30:44 +0000
In-Reply-To: <gerrit.1748876308000.I0e13595c1057c680e1065eae84ca94b273ed9ca1@...2715...>
References: <gerrit.1748876308000.I0e13595c1057c680e1065eae84ca94b273ed9ca1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <32a7a6ba8a8a2044a1b839c948397592409cee75-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nv0O8otR3js="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not segfault on
 missing --dh in server config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nv0O8otR3js=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
37?usp=3Demail )

Change subject: Do not segfault on missing --dh in server config
......................................................................

Do not segfault on missing --dh in server config

Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250602152115.27130-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
844.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0d648ba..b9708343 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3698,7 +3698,7 @@

     if (o->tls_server)
     {
-        if (streq(o->dh_file, "none"))
+        if (o->dh_file && streq(o->dh_file, "none"))
         {
             o->dh_file =3D NULL;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1037?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1
Gerrit-Change-Number: 1037
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--nv0O8otR3js=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1037?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Do not segfault on missing --dh in server con=
fig<br><br>Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250602152115.27130-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg31844.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 1 insertion(+), 1 =
deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 0d648ba..b9708343 100644</span><br><span>--- a/src/openvpn/options=
.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3698,7 +=
3698,7 @@</span><br><span> </span><br><span>     if (o-&gt;tls_server)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (streq(o-&gt;dh_file, &quot;none&quot;))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (o-&gt;dh_file &amp;&amp; streq(o-&=
gt;dh_file, &quot;none&quot;))</span><br><span>         {</span><br><span> =
            o-&gt;dh_file =3D NULL;</span><br><span>         }</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1037?usp=3Demail">change 1037</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/10=
37?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e13595c1057c680e1065eae84c=
a94b273ed9ca1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1037 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--nv0O8otR3js=--

