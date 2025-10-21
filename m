From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 19:45:55 +0000
In-Reply-To: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
References: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <61d0dc259333f9304a5191fe644998f93dc06199-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nh0aw7RPrVE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Fix wrong
 usage of mroute_extract_openvpn_sockaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, its_Giaan <gianmarco@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nh0aw7RPrVE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by its_Giaan


Change subject: multi: Fix wrong usage of mroute_extract_openvpn_sockaddr
......................................................................

multi: Fix wrong usage of mroute_extract_openvpn_sockaddr

maddr.proto needs to be set before the call since that
will change the behavior.

Found by GCC "'maddr.proto' is used uninitialized"

Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1292
Message-Id: <20251021193147.26778-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
830.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1292/3

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e907524..fa9c654 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3965,9 +3965,9 @@
     saddr.addr.in4.sin_family =3D AF_INET;
     saddr.addr.in4.sin_addr.s_addr =3D htonl(addr);
     saddr.addr.in4.sin_port =3D htons(port);
+    maddr.proto =3D proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        maddr.proto =3D proto;
         hash_iterator_init(m->iter, &hi);
         while ((he =3D hash_iterator_next(&hi)))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Gerrit-Change-Number: 1292
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nh0aw7RPrVE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2, Code-Review+2 by its_Giaan</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">multi: =
Fix wrong usage of mroute_extract_openvpn_sockaddr<br><br>maddr.proto needs=
 to be set before the call since that<br>will change the behavior.<br><br>F=
ound by GCC &quot;&#39;maddr.proto&#39; is used uninitialized&quot;<br><br>=
Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Acked-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt=
;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1292<br>Message-Id:=
 &lt;20251021193147.26778-1-gert@...1296...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg33830.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>=
1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1292/3</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>in=
dex e907524..fa9c654 100644</span><br><span>--- a/src/openvpn/multi.c</span=
><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3965,9 +3965,9 @@<=
/span><br><span>     saddr.addr.in4.sin_family =3D AF_INET;</span><br><span=
>     saddr.addr.in4.sin_addr.s_addr =3D htonl(addr);</span><br><span>     =
saddr.addr.in4.sin_port =3D htons(port);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    maddr.proto =3D proto;</span><br><span>     if (mr=
oute_extract_openvpn_sockaddr(&amp;maddr, &amp;saddr, true))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        maddr=
.proto =3D proto;</span><br><span>         hash_iterator_init(m-&gt;iter, &=
amp;hi);</span><br><span>         while ((he =3D hash_iterator_next(&amp;hi=
)))</span><br><span>         {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail">c=
hange 1292</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76babf08b041162ddedf7a9b7c2=
799847f15cbdc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1292 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Nh0aw7RPrVE=--

