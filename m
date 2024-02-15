From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 15 Feb 2024 15:59:02 +0000
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HbhnCR7Mi6c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
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

--HbhnCR7Mi6c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail

to review the following change.


Change subject: Minor fix to process_ip_header
......................................................................

Minor fix to process_ip_header

Introduced a bitmask to replace the previous check
for individual option bits with a check for all
possible combinations of options.

Fixes: Trac https://community.openvpn.net/openvpn/ticket/269
Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
2 files changed, 4 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/525/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0443ca0..04bf407 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1649,17 +1649,7 @@

     if (buf->len > 0)
     {
-        /*
-         * The --passtos and --mssfix options require
-         * us to examine the IPv4 header.
-         */
-
-        if (flags & (PIP_MSSFIX
-#if PASSTOS_CAPABILITY
-                     | PIPV4_PASSTOS
-#endif
-                     | PIPV4_CLIENT_NAT
-                     ))
+        if (flags & PIP_OPT_MASK)
         {
             struct buffer ipbuf =3D *buf;
             if (is_ipv4(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index e19115e..8da1cc1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -294,11 +294,13 @@

 #define PIPV4_PASSTOS                   (1<<0)
 #define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
-#define PIP_OUTGOING                    (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
 #define PIPV4_CLIENT_NAT                (1<<4)
 #define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
 #define PIPV6_IMCP_NOHOST_SERVER        (1<<6)
+#define PIP_OPT_MASK                    0xFFFF
+#define PIP_OUTGOING                    (1<<16)
+

 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202
Gerrit-Change-Number: 525
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HbhnCR7Mi6c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Minor fix to process_ip_header<br><br>Introduced a bitmask to=
 replace the previous check<br>for individual option bits with a check for =
all<br>possible combinations of options.<br><br>Fixes: Trac https://communi=
ty.openvpn.net/openvpn/ticket/269<br>Change-Id: I4b5e8357d872c920efdb64632e=
9bce72cebee202<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2787...=
...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>2 f=
iles changed, 4 insertions(+), 12 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/25/525/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 0443ca0..=
04bf407 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>=
+++ b/src/openvpn/forward.c</span><br><span>@@ -1649,17 +1649,7 @@</span><b=
r><span> </span><br><span>     if (buf-&gt;len &gt; 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         * The --passtos and -=
-mssfix options require</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * us to examine the IPv4 header.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (flags &amp; (PIP_MSSFIX</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if PASSTOS_CAPABILITY</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                     | PIPV4_PASSTOS</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                     | PIPV4_CLIENT_NAT</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     ))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (flags &amp; PIP_OPT_MASK)</span><br=
><span>         {</span><br><span>             struct buffer ipbuf =3D *buf=
;</span><br><span>             if (is_ipv4(TUNNEL_TYPE(c-&gt;c1.tuntap), &a=
mp;ipbuf))</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn=
/forward.h</span><br><span>index e19115e..8da1cc1 100644</span><br><span>--=
- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span=
><br><span>@@ -294,11 +294,13 @@</span><br><span> </span><br><span> #define=
 PIPV4_PASSTOS                   (1&lt;&lt;0)</span><br><span> #define PIP_=
MSSFIX                      (1&lt;&lt;1)         /* v4 and v6 */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define PIP_OUTGOING            =
        (1&lt;&lt;2)</span><br><span> #define PIPV4_EXTRACT_DHCP_ROUTER    =
   (1&lt;&lt;3)</span><br><span> #define PIPV4_CLIENT_NAT                (1=
&lt;&lt;4)</span><br><span> #define PIPV6_IMCP_NOHOST_CLIENT        (1&lt;&=
lt;5)</span><br><span> #define PIPV6_IMCP_NOHOST_SERVER        (1&lt;&lt;6)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIP_OPT_MAS=
K                    0xFFFF</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define PIP_OUTGOING                    (1&lt;&lt;16)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><spa=
n> void process_ip_header(struct context *c, unsigned int flags, struct buf=
fer *buf);</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail">chan=
ge 525</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4b5e8357d872c920efdb64632e9=
bce72cebee202 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 525 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--HbhnCR7Mi6c=--

