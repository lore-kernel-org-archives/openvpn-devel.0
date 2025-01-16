From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 16 Jan 2025 17:11:40 +0000
References: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2ad97b27f1fcdee2b4cd87d14bf41e7aa1dd2a53-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HGtfKR7TDC0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: IPv6 MADDR LOG: Wrap
 IPv6 addresses in square brackets and include po...
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

--HGtfKR7TDC0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail

to review the following change.


Change subject: IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and =
include port when specified
......................................................................

IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and include port whe=
n specified

- Updated the mroute_addr_print_ex() function to always wrap IPv6 addresses=
 in square brackets for proper formatting.
- Added port printing for IPv6 addresses when specified, e.g., [2001:db8::1=
]:8080.

Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/mroute.c
1 file changed, 5 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/870/1

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index f4539dc..91419ed 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -430,17 +430,14 @@
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv=
6.addr,
                                                            IA_NET_ORDER, g=
c));
-                    /* we only print port numbers for v4mapped v6 as of
-                     * today, because "v6addr:port" is too ambiguous
-                     */
-                    if (maddr.type & MR_WITH_PORT)
-                    {
-                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
-                    }
                 }
                 else
                 {
-                    buf_printf(&out, "%s", print_in6_addr(maddr.v6.addr, 0=
, gc));
+                    buf_printf(&out, "[%s]", print_in6_addr(maddr.v6.addr,=
 0, gc));
+                }
+                if (maddr.type & MR_WITH_PORT)
+                {
+                    buf_printf(&out, ":%d", ntohs(maddr.v6.port));
                 }
                 if (maddr.type & MR_WITH_NETBITS)
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb
Gerrit-Change-Number: 870
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HGtfKR7TDC0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and in=
clude port when specified<br><br>- Updated the mroute_addr_print_ex() funct=
ion to always wrap IPv6 addresses in square brackets for proper formatting.=
<br>- Added port printing for IPv6 addresses when specified, e.g., [2001:db=
8::1]:8080.<br><br>Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb<br>=
Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn=
/mroute.c<br>1 file changed, 5 insertions(+), 8 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/870/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>ind=
ex f4539dc..91419ed 100644</span><br><span>--- a/src/openvpn/mroute.c</span=
><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -430,17 +430,14 @@=
</span><br><span>                 {</span><br><span>                     bu=
f_printf(&amp;out, &quot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.addr,</=
span><br><span>                                                            =
IA_NET_ORDER, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  /* we only print port numbers for v4mapped v6 as of</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                     * toda=
y, because &quot;v6addr:port&quot; is too ambiguous</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    if (maddr.type &amp; =
MR_WITH_PORT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v6.port))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
}</span><br><span>                 }</span><br><span>                 else<=
/span><br><span>                 {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    buf_printf(&amp;out, &quot;%s&quot;, print=
_in6_addr(maddr.v6.addr, 0, gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    buf_printf(&amp;out, &quot;[%s]&quot;, pr=
int_in6_addr(maddr.v6.addr, 0, gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (maddr.type &amp; MR_WITH_PORT)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    buf_printf(=
&amp;out, &quot;:%d&quot;, ntohs(maddr.v6.port));</span><br><span>         =
        }</span><br><span>                 if (maddr.type &amp; MR_WITH_NET=
BITS)</span><br><span>                 {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=
=3Demail">change 870</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia58cff107d14e29e51df0a988e8=
337cbb70ebfbb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 870 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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


--HGtfKR7TDC0=--

