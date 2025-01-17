From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Jan 2025 11:29:12 +0000
In-Reply-To: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
References: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3b51c36035fe16c2a1ff980743b1a340ee8679f3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uPeo/f/p2OY="; charset=UTF-8
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
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uPeo/f/p2OY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/870/3

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
Gerrit-MessageType: newpatchset

--uPeo/f/p2OY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/870?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">IPv6 MADDR LOG: Wrap IPv6 addresses in square bracke=
ts and print port when the port is specified<br><br>  Updated the mroute_ad=
dr_print_ex() function to wrap IPv6 addresses in square<br>  brackets and p=
rinting the port when the port is specified, e.g., [2001:db8::1]:8080 .<br>=
  When the port is not specified the IPv6 address formatting remain the sam=
e, e.g., 2001:db8::1 .<br><br>Change-Id: Ia58cff107d14e29e51df0a988e8337cbb=
70ebfbb<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250117110422.921=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg30480.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/mroute.c<br>1 file changed, 8 insert=
ions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/70/870/3</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mroute.c b/sr=
c/openvpn/mroute.c</span><br><span>index f4539dc..80e18b7 100644</span><br>=
<span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c=
</span><br><span>@@ -430,18 +430,19 @@</span><br><span>                 {</=
span><br><span>                     buf_printf(&amp;out, &quot;%s&quot;, pr=
int_in_addr_t(maddr.v4mappedv6.addr,</span><br><span>                      =
                                      IA_NET_ORDER, gc));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    /* we only print po=
rt numbers for v4mapped v6 as of</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                     * today, because &quot;v6addr:port&quot; is=
 too ambiguous</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
              */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               if (maddr.type &amp; MR_WITH_PORT)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        buf_printf(&amp;out, &q=
uot;:%d&quot;, ntohs(maddr.v6.port));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                else if (maddr.type &amp; MR_WITH_PORT)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    buf_p=
rintf(&amp;out, &quot;[%s]&quot;, print_in6_addr(maddr.v6.addr, 0, gc));</s=
pan><br><span>                 }</span><br><span>                 else</spa=
n><br><span>                 {</span><br><span>                     buf_pri=
ntf(&amp;out, &quot;%s&quot;, print_in6_addr(maddr.v6.addr, 0, gc));</span>=
<br><span>                 }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (maddr.type &amp; MR_WITH_PORT)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    buf_printf(&amp;o=
ut, &quot;:%d&quot;, ntohs(maddr.v6.port));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span>                 =
if (maddr.type &amp; MR_WITH_NETBITS)</span><br><span>                 {</s=
pan><br><span>                     buf_printf(&amp;out, &quot;/%d&quot;, ma=
ddr.netbits);</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/870?usp=3Demail">change 870</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/870?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uPeo/f/p2OY=--

