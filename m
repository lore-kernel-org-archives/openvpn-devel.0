From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:06:04 +0000
In-Reply-To: <gerrit.1763880426000.Iabad046c930dd0f38ec50d1c43d8b3288816df7d@...2715...>
References: <gerrit.1763880426000.Iabad046c930dd0f38ec50d1c43d8b3288816df7d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <589050f7ffecb9c5c0c0a2bae7e87d65792b0c85-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IMl/264dVuQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: return
 correct size when domains are truncated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IMl/264dVuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
91?usp=3Demail )

Change subject: iservice: return correct size when domains are truncated
......................................................................

iservice: return correct size when domains are truncated

In case not all domains can be converted in the available buffer, return
the size of the already converted domains size plus the second terminating
zero for the MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Iabad046c930dd0f38ec50d1c43d8b3288816df7d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1391
Message-Id: <20251126104315.4776-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
680.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ed3c928..4a3e689 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2214,7 +2214,7 @@
                 {
                     /* Domain doesn't fit, bad luck if it's the first one =
*/
                     *pos =3D '\0';
-                    *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;
+                    *size =3D converted_size =3D=3D 0 ? 0 : converted_size=
 + one_glyph;
                     return ERROR_MORE_DATA;
                 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabad046c930dd0f38ec50d1c43d8b3288816df7d
Gerrit-Change-Number: 1391
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IMl/264dVuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1391?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: return correct size when domains are t=
runcated<br><br>In case not all domains can be converted in the available b=
uffer, return<br>the size of the already converted domains size plus the se=
cond terminating<br>zero for the MULTI_SZ.<br><br>Reported-by: Marc Heuse &=
lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Change-Id: Iab=
ad046c930dd0f38ec50d1c43d8b3288816df7d<br>Signed-off-by: Heiko Hund &lt;hei=
ko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1391<br>Message-Id: &lt;2025=
1126104315.4776-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg34680.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>=
1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index ed3c928..4a3e689 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2214,7 +2214,7 @@</span><br><span>                 {=
</span><br><span>                     /* Domain doesn&#39;t fit, bad luck i=
f it&#39;s the first one */</span><br><span>                     *pos =3D &=
#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    *size =3D con=
verted_size =3D=3D 0 ? 0 : converted_size + one_glyph;</span><br><span>    =
                 return ERROR_MORE_DATA;</span><br><span>                 }=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail">change 1391</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabad046c930dd0f38ec50d1c43d=
8b3288816df7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1391 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--IMl/264dVuQ=--

