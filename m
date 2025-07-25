From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 19:52:14 +0000
In-Reply-To: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
References: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <16f396f45f306b7a243a9bf6bb097bf8122f9900-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqryPCaF3KQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: add flag to print
 addresses in a consistent format during float
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JqryPCaF3KQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: add flag to print addresses in a consistent format during f=
loat
......................................................................

add flag to print addresses in a consistent format during float

Introduce the MAPF_SHOW_FAMILY flag to prepend the address family to the
address when printing an mroute_addr object, similar to
print_sockaddr_ex(). This ensures that when logging a float operation,
both the old and new addresses are printed in the same format:
$proto:[$family]$address:$port.

Note: when using this flag with an IPv4-mapped IPv6 address, the output
will appear as: [AF_INET6]a.b.c.d

Change-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250725194147.17517-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
345.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/multi.c
3 files changed, 11 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1092/3

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a617b33..e3b1e9b 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -415,6 +415,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET]");
+                }
                 buf_printf(&out, "%s", print_in_addr_t(ntohl(maddr.v4.addr=
),
                                                        (flags & MAPF_IA_EM=
PTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
                 if (maddr.type & MR_WITH_NETBITS)
@@ -442,6 +446,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET6, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET6]");
+                }
                 if (IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv=
6.addr,
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c359fd2..4f9fc03 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -150,6 +150,7 @@
 #define MAPF_SUBNET            (1<<0)
 #define MAPF_IA_EMPTY_IF_UNDEF (1<<1)
 #define MAPF_SHOW_ARP          (1<<2)
+#define MAPF_SHOW_FAMILY       (1<<3)
 const char *mroute_addr_print_ex(const struct mroute_addr *ma,
                                  const unsigned int flags,
                                  struct gc_arena *gc);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ec260a2..a62c57a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3275,8 +3275,8 @@
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->context.c2.tls_multi->peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
-        mroute_addr_print(&mi->real, &gc),
-        print_link_socket_actual(&m->top.c2.from, &gc));
+        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
+        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));

     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395
Gerrit-Change-Number: 1092
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JqryPCaF3KQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by ralf_lici.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1092?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">add flag to print addresses in a consistent format d=
uring float<br><br>Introduce the MAPF_SHOW_FAMILY flag to prepend the addre=
ss family to the<br>address when printing an mroute_addr object, similar to=
<br>print_sockaddr_ex(). This ensures that when logging a float operation,<=
br>both the old and new addresses are printed in the same format:<br>$proto=
:[$family]$address:$port.<br><br>Note: when using this flag with an IPv4-ma=
pped IPv6 address, the output<br>will appear as: [AF_INET6]a.b.c.d<br><br>C=
hange-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395<br>Signed-off-by: Ralf =
Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20250725194147.17517-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32345.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/multi.c<br>3 fil=
es changed, 11 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/92/1092/3</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index a617b33..e3b=
1e9b 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ =
b/src/openvpn/mroute.c</span><br><span>@@ -415,6 +415,10 @@</span><br><span=
>                 {</span><br><span>                     buf_printf(&amp;ou=
t, &quot;%s:&quot;, proto2ascii(maddr.proto, AF_INET, false));</span><br><s=
pan>                 }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (flags &amp; MAPF_SHOW_FAMILY)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    buf_printf(&amp;out, =
&quot;[AF_INET]&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                }</span><br><span>                 buf_printf(&amp;out,=
 &quot;%s&quot;, print_in_addr_t(ntohl(maddr.v4.addr),</span><br><span>    =
                                                    (flags &amp; MAPF_IA_EM=
PTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));</span><br><span>              =
   if (maddr.type &amp; MR_WITH_NETBITS)</span><br><span>@@ -442,6 +446,10 =
@@</span><br><span>                 {</span><br><span>                     =
buf_printf(&amp;out, &quot;%s:&quot;, proto2ascii(maddr.proto, AF_INET6, fa=
lse));</span><br><span>                 }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                if (flags &amp; MAPF_SHOW_FAMILY)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    buf_p=
rintf(&amp;out, &quot;[AF_INET6]&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span>                 if =
(IN6_IS_ADDR_V4MAPPED( &amp;maddr.v6.addr ) )</span><br><span>             =
    {</span><br><span>                     buf_printf(&amp;out, &quot;%s&qu=
ot;, print_in_addr_t(maddr.v4mappedv6.addr,</span><br><span>diff --git a/sr=
c/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index c359fd2..4f=
9fc03 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>+++=
 b/src/openvpn/mroute.h</span><br><span>@@ -150,6 +150,7 @@</span><br><span=
> #define MAPF_SUBNET            (1&lt;&lt;0)</span><br><span> #define MAPF=
_IA_EMPTY_IF_UNDEF (1&lt;&lt;1)</span><br><span> #define MAPF_SHOW_ARP     =
     (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine MAPF_SHOW_FAMILY       (1&lt;&lt;3)</span><br><span> const char *mrou=
te_addr_print_ex(const struct mroute_addr *ma,</span><br><span>            =
                      const unsigned int flags,</span><br><span>           =
                       struct gc_arena *gc);</span><br><span>diff --git a/s=
rc/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index ec260a2..a62=
c57a 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b=
/src/openvpn/multi.c</span><br><span>@@ -3275,8 +3275,8 @@</span><br><span>=
     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from=
 %s to %s&quot;,</span><br><span>         mi-&gt;context.c2.tls_multi-&gt;p=
eer_id,</span><br><span>         tls_common_name(mi-&gt;context.c2.tls_mult=
i, false),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mro=
ute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        print_link_socket_actual(&amp;m-&gt;top.c2.fro=
m, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  mroute_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mroute_addr_print_=
ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span> </span><br><spa=
n>     /* remove old address from hash table before changing address */</sp=
an><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1092?usp=3Demail">change 1092</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1092?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43cd3d564d8c6ad4e41de5a3813=
0d90cb6778395 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1092 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JqryPCaF3KQ=--

