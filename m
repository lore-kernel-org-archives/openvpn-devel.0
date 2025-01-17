From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Jan 2025 11:29:14 +0000
In-Reply-To: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
References: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3b51c36035fe16c2a1ff980743b1a340ee8679f3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hCVCEZmGR0E="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hCVCEZmGR0E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/87=
0?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250117110422.921-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
480.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mroute.c
1 file changed, 8 insertions(+), 7 deletions(-)




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
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--hCVCEZmGR0E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/870?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">IPv6 MADDR LOG: Wrap IPv6 addresses in square =
brackets and print port when the port is specified<br><br>  Updated the mro=
ute_addr_print_ex() function to wrap IPv6 addresses in square<br>  brackets=
 and printing the port when the port is specified, e.g., [2001:db8::1]:8080=
 .<br>  When the port is not specified the IPv6 address formatting remain t=
he same, e.g., 2001:db8::1 .<br><br>Change-Id: Ia58cff107d14e29e51df0a988e8=
337cbb70ebfbb<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202501171104=
22.921-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg30480.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/mroute.c<br>1 file changed, 8 =
insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span=
>index f4539dc..80e18b7 100644</span><br><span>--- a/src/openvpn/mroute.c</=
span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -430,18 +430,1=
9 @@</span><br><span>                 {</span><br><span>                   =
  buf_printf(&amp;out, &quot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.add=
r,</span><br><span>                                                        =
    IA_NET_ORDER, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    /* we only print port numbers for v4mapped v6 as of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     * =
today, because &quot;v6addr:port&quot; is too ambiguous</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                     */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    if (maddr.type &amp=
; MR_WITH_PORT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v6.port=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                el=
se if (maddr.type &amp; MR_WITH_PORT)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    buf_printf(&amp;out, &quot;[%s]&quot;, =
print_in6_addr(maddr.v6.addr, 0, gc));</span><br><span>                 }</=
span><br><span>                 else</span><br><span>                 {</sp=
an><br><span>                     buf_printf(&amp;out, &quot;%s&quot;, prin=
t_in6_addr(maddr.v6.addr, 0, gc));</span><br><span>                 }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (maddr=
.type &amp; MR_WITH_PORT)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v=
6.port));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span>                 if (maddr.type &amp; MR_WITH_NETBI=
TS)</span><br><span>                 {</span><br><span>                    =
 buf_printf(&amp;out, &quot;/%d&quot;, maddr.netbits);</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/870?usp=3Demail">change 870</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia58cff107d14e29e51df0a988e8=
337cbb70ebfbb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 870 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--hCVCEZmGR0E=--

