From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 17 Jan 2025 10:57:03 +0000
In-Reply-To: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
References: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <52a4eb376d6ff84ac8ae40d19f3095b278d1ea3e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wcW90KQJ2KU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: IPv6 MADDR LOG: Wrap
 IPv6 addresses in square brackets and print port...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wcW90KQJ2KU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail

to look at the new patch set (#2).


Change subject: IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and =
print port when the port is specified
......................................................................

IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and print port when =
the port is specified

  Updated the mroute_addr_print_ex() function to wrap IPv6 addresses in squ=
are
  brackets and printing the port when the port is specified, e.g., [2001:db=
8::1]:8080 .
  When the port is not specified the IPv6 address formatting remain the sam=
e, e.g., 2001:db8::1 .

Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/mroute.c
1 file changed, 8 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/870/2

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index f4539dc..80e18b7 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -430,18 +430,19 @@
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
+                }
+                else if (maddr.type & MR_WITH_PORT)
+                {
+                    buf_printf(&out, "[%s]", print_in6_addr(maddr.v6.addr,=
 0, gc));
                 }
                 else
                 {
                     buf_printf(&out, "%s", print_in6_addr(maddr.v6.addr, 0=
, gc));
                 }
+                if (maddr.type & MR_WITH_PORT)
+                {
+                    buf_printf(&out, ":%d", ntohs(maddr.v6.port));
+                }
                 if (maddr.type & MR_WITH_NETBITS)
                 {
                     buf_printf(&out, "/%d", maddr.netbits);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb
Gerrit-Change-Number: 870
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--wcW90KQJ2KU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and print port whe=
n the port is specified<br><br>  Updated the mroute_addr_print_ex() functio=
n to wrap IPv6 addresses in square<br>  brackets and printing the port when=
 the port is specified, e.g., [2001:db8::1]:8080 .<br>  When the port is no=
t specified the IPv6 address formatting remain the same, e.g., 2001:db8::1 =
.<br><br>Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb<br>Signed-off=
-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/mroute.c<=
br>1 file changed, 8 insertions(+), 7 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/70/870/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index f4539d=
c..80e18b7 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><spa=
n>+++ b/src/openvpn/mroute.c</span><br><span>@@ -430,18 +430,19 @@</span><b=
r><span>                 {</span><br><span>                     buf_printf(=
&amp;out, &quot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.addr,</span><br>=
<span>                                                            IA_NET_OR=
DER, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         /* we only print port numbers for v4mapped v6 as of</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                     * today, becaus=
e &quot;v6addr:port&quot; is too ambiguous</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    if (maddr.type &amp; MR_WITH_POR=
T)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v6.port));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                else if (maddr.=
type &amp; MR_WITH_PORT)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    buf_printf(&amp;out, &quot;[%s]&quot;, print_in6_add=
r(maddr.v6.addr, 0, gc));</span><br><span>                 }</span><br><spa=
n>                 else</span><br><span>                 {</span><br><span>=
                     buf_printf(&amp;out, &quot;%s&quot;, print_in6_addr(ma=
ddr.v6.addr, 0, gc));</span><br><span>                 }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (maddr.type &amp; M=
R_WITH_PORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v6.port));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span=
><br><span>                 if (maddr.type &amp; MR_WITH_NETBITS)</span><br=
><span>                 {</span><br><span>                     buf_printf(&=
amp;out, &quot;/%d&quot;, maddr.netbits);</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--wcW90KQJ2KU=--

