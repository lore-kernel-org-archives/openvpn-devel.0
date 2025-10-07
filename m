From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 07:37:07 +0000
In-Reply-To: <gerrit.1759230199000.Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef@...2715...>
References: <gerrit.1759230199000.Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db7571203d2850529daa51260447210e1ee7ff34-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MikZy3g7CSc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dhcp: Fix conversion
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MikZy3g7CSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1241?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dhcp: Fix conversion warnings
......................................................................

dhcp: Fix conversion warnings

- Use correct type for pointer difference
- Make sure that small sizeof sum is treated as int

Change-Id: Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1241
Message-Id: <20251006210127.28679-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243110/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dhcp.c
1 file changed, 2 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1241/4

diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 38e8d40..850a4b6 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -72,11 +72,6 @@
     return -1;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static in_addr_t
 do_extract(struct dhcp *dhcp, int optlen)
 {
@@ -115,7 +110,7 @@
                         const int owlen =3D len + 2; /* len of data to ove=
rwrite */
                         uint8_t *src =3D dest + owlen;
                         uint8_t *end =3D p + optlen;
-                        const int movlen =3D end - src;
+                        const intptr_t movlen =3D end - src;
                         if (movlen > 0)
                         {
                             memmove(dest, src, movlen);       /* overwrite=
 router option */
@@ -155,7 +150,7 @@
     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);
     const int optlen =3D
         BLEN(ipbuf)
-        - (sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + =
sizeof(struct dhcp));
+        - (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphd=
r) + sizeof(struct dhcp));

     if (optlen >=3D 0 && df->ip.protocol =3D=3D OPENVPN_IPPROTO_UDP
         && df->udp.source =3D=3D htons(BOOTPS_PORT) && df->udp.dest =3D=3D=
 htons(BOOTPC_PORT)
@@ -190,7 +185,3 @@
     }
     return 0;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1241?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef
Gerrit-Change-Number: 1241
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MikZy3g7CSc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1241?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dhcp: Fix conversion warnings<br><b=
r>- Use correct type for pointer difference<br>- Make sure that small sizeo=
f sum is treated as int<br><br>Change-Id: Ie0c0fbf4f7f8b379d46b6755c4eff209=
acc20fef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ac=
ked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1241<br>Message-Id: &lt;20251006210127.28679-1-gert=
@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5=
9243110/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/dhcp.c<br>1 file changed, 2 insertions(+), 11 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/41/1241/4</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dhcp.c b/src/openvpn/d=
hcp.c</span><br><span>index 38e8d40..850a4b6 100644</span><br><span>--- a/s=
rc/openvpn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c</span><br><span>=
@@ -72,11 +72,6 @@</span><br><span>     return -1;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static in_addr_t</s=
pan><br><span> do_extract(struct dhcp *dhcp, int optlen)</span><br><span> {=
</span><br><span>@@ -115,7 +110,7 @@</span><br><span>                      =
   const int owlen =3D len + 2; /* len of data to overwrite */</span><br><s=
pan>                         uint8_t *src =3D dest + owlen;</span><br><span=
>                         uint8_t *end =3D p + optlen;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        const int movlen =
=3D end - src;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   const intptr_t movlen =3D end - src;</span><br><span>   =
                      if (movlen &gt; 0)</span><br><span>                  =
       {</span><br><span>                             memmove(dest, src, mo=
vlen);       /* overwrite router option */</span><br><span>@@ -155,7 +150,7=
 @@</span><br><span>     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(=
ipbuf);</span><br><span>     const int optlen =3D</span><br><span>         =
BLEN(ipbuf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        - =
(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(stru=
ct dhcp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -=
 (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeo=
f(struct dhcp));</span><br><span> </span><br><span>     if (optlen &gt;=3D =
0 &amp;&amp; df-&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_UDP</span><br><span>=
         &amp;&amp; df-&gt;udp.source =3D=3D htons(BOOTPS_PORT) &amp;&amp; =
df-&gt;udp.dest =3D=3D htons(BOOTPC_PORT)</span><br><span>@@ -190,7 +185,3 =
@@</span><br><span>     }</span><br><span>     return 0;</span><br><span> }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1241?usp=3Demail">change 1241</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1241?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0c0fbf4f7f8b379d46b6755c4e=
ff209acc20fef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1241 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MikZy3g7CSc=--

