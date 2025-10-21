From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 16:19:09 +0000
In-Reply-To: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
References: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <652d82f13e9b848f60b8f5c151e3fb47742d0f6a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ll9RjA9GMxc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ll9RjA9GMxc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail

to look at the new patch set (#2).


Change subject: multi: Fix wrong usage of mroute_extract_openvpn_sockaddr
......................................................................

multi: Fix wrong usage of mroute_extract_openvpn_sockaddr

maddr.proto needs to be set before the call since that
will change the behavior.

Found by GCC "'maddr.proto' is used uninitialized"

Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1292/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ll9RjA9GMxc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi: Fix wrong usage of mroute_extract_openvpn=
_sockaddr<br><br>maddr.proto needs to be set before the call since that<br>=
will change the behavior.<br><br>Found by GCC &quot;&#39;maddr.proto&#39; i=
s used uninitialized&quot;<br><br>Change-Id: I76babf08b041162ddedf7a9b7c279=
9847f15cbdc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>---<br>M src/openvpn/multi.c<br>1 file changed, 1 insertion(+), 1 deletion=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/92/1292/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/o=
penvpn/multi.c</span><br><span>index e907524..fa9c654 100644</span><br><spa=
n>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span=
><br><span>@@ -3965,9 +3965,9 @@</span><br><span>     saddr.addr.in4.sin_fa=
mily =3D AF_INET;</span><br><span>     saddr.addr.in4.sin_addr.s_addr =3D h=
tonl(addr);</span><br><span>     saddr.addr.in4.sin_port =3D htons(port);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    maddr.proto =3D p=
roto;</span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;maddr, =
&amp;saddr, true))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        maddr.proto =3D proto;</span><br><span>        =
 hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span>         while ((=
he =3D hash_iterator_next(&amp;hi)))</span><br><span>         {</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1292?usp=3Demail">change 1292</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1292?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76babf08b041162ddedf7a9b7c2=
799847f15cbdc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1292 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ll9RjA9GMxc=--

