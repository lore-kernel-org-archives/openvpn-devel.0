From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 19:45:58 +0000
In-Reply-To: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
References: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <61d0dc259333f9304a5191fe644998f93dc06199-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="En7caoh15mg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--En7caoh15mg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
92?usp=3Demail )

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

Gerrit-MessageType: merged
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

--En7caoh15mg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1292?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi: Fix wrong usage of mroute_extract_openvpn=
_sockaddr<br><br>maddr.proto needs to be set before the call since that<br>=
will change the behavior.<br><br>Found by GCC &quot;&#39;maddr.proto&#39; i=
s used uninitialized&quot;<br><br>Change-Id: I76babf08b041162ddedf7a9b7c279=
9847f15cbdc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Gianmarco De G=
regori &lt;gianmarco@...2726...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1292<br>Message-Id: &lt;20251021193147.26778-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg33830.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/multi.c<br>1 file changed, 1 insertion(+), 1 deletio=
n(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex e907524..fa9c654 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3965,9 +3965,9 @@=
</span><br><span>     saddr.addr.in4.sin_family =3D AF_INET;</span><br><spa=
n>     saddr.addr.in4.sin_addr.s_addr =3D htonl(addr);</span><br><span>    =
 saddr.addr.in4.sin_port =3D htons(port);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    maddr.proto =3D proto;</span><br><span>     if (m=
route_extract_openvpn_sockaddr(&amp;maddr, &amp;saddr, true))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        madd=
r.proto =3D proto;</span><br><span>         hash_iterator_init(m-&gt;iter, =
&amp;hi);</span><br><span>         while ((he =3D hash_iterator_next(&amp;h=
i)))</span><br><span>         {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail">=
change 1292</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--En7caoh15mg=--

