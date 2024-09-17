From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 09:41:27 +0000
In-Reply-To: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
References: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <8bfb6b7d9d83916e53931b7435ff6bac5b6fb0d2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G1cK7awvck4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix
 check_addr_clash argument order
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

--G1cK7awvck4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix check_addr_clash argument order
......................................................................

Fix check_addr_clash argument order

In init_tun() make sure to pass the --local and --remote addresses in
the host order so that they can be compared to the --ifconfig addresses.

Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240917091433.24092-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
261.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/737/2

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8b6c34d..d5bad86 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -877,9 +877,10 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t local =3D ntohl(((struct sockaddr_in *=
)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("local",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     local,
                                      tt->local,
                                      tt->remote_netmask);
                 }
@@ -889,9 +890,10 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t remote =3D ntohl(((struct sockaddr_in =
*)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("remote",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     remote,
                                      tt->local,
                                      tt->remote_netmask);
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Gerrit-Change-Number: 737
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--G1cK7awvck4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by ralf_lici.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
737?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix check_addr_clash argument order<br><br>In=
 init_tun() make sure to pass the --local and --remote addresses in<br>the =
host order so that they can be compared to the --ifconfig addresses.<br><br=
>Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce<br>Signed-off-by: Ral=
f Lici &lt;ralf@...2726...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Message-Id: &lt;20240917091433.24092-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
29261.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/tun.c<br>1 file changed, 4 insertions(+), 2 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/737/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><spa=
n>index 8b6c34d..d5bad86 100644</span><br><span>--- a/src/openvpn/tun.c</sp=
an><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -877,9 +877,10 @@</=
span><br><span>             {</span><br><span>                 if (curele-&=
gt;ai_family =3D=3D AF_INET)</span><br><span>                 {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    const in_ad=
dr_t local =3D ntohl(((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_add=
r.s_addr);</span><br><span>                     check_addr_clash(&quot;loca=
l&quot;,</span><br><span>                                      tt-&gt;type,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                ((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_a=
ddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                      local,</span><br><span>                              =
        tt-&gt;local,</span><br><span>                                     =
 tt-&gt;remote_netmask);</span><br><span>                 }</span><br><span=
>@@ -889,9 +890,10 @@</span><br><span>             {</span><br><span>      =
           if (curele-&gt;ai_family =3D=3D AF_INET)</span><br><span>       =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            const in_addr_t remote =3D ntohl(((struct sockaddr_in *)curele-=
&gt;ai_addr)-&gt;sin_addr.s_addr);</span><br><span>                     che=
ck_addr_clash(&quot;remote&quot;,</span><br><span>                         =
             tt-&gt;type,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                     ((struct sockaddr_in *)curele-&gt;=
ai_addr)-&gt;sin_addr.s_addr,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                     remote,</span><br><span>    =
                                  tt-&gt;local,</span><br><span>           =
                           tt-&gt;remote_netmask);</span><br><span>        =
         }</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail">change 737</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/737?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d393=
91a81b4d8adce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 737 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--G1cK7awvck4=--

