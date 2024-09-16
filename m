From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 14:58:17 +0000
In-Reply-To: <gerrit.1726491830000.I028634dba74a273c725b0beb16b674897b3c23fa@...2715...>
References: <gerrit.1726491830000.I028634dba74a273c725b0beb16b674897b3c23fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <06a47f0b998be2ff4066f3900252a1789c25495f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m0C68j5Wchw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Make
 read/write_tun_header static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--m0C68j5Wchw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/74=
5?usp=3Demail )

Change subject: Make read/write_tun_header static
......................................................................

Make read/write_tun_header static

These functions are not used outside tun.c

Change-Id: I028634dba74a273c725b0beb16b674897b3c23fa
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240916133436.29943-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
249.html
---
M src/openvpn/tun.c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82c5c00..8b6c34d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1792,7 +1792,7 @@
     }
 }

-int
+static int
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
@@ -1825,7 +1825,7 @@
     }
 }

-int
+static int
 read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/745?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I028634dba74a273c725b0beb16b674897b3c23fa
Gerrit-Change-Number: 745
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--m0C68j5Wchw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/745?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Make read/write_tun_header static<br><br>These=
 functions are not used outside tun.c<br><br>Change-Id: I028634dba74a273c72=
5b0beb16b674897b3c23fa<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&g=
t;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202=
40916133436.29943-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg29249.html<br>---<br>M src/openvpn/tun.c<br>1 file cha=
nged, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 82c5c00..8b6c34d 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1792,7 +1792,7 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static int</span><br><span> write_tun_header(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-=
&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>@@ -1825,7 +1825,7 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static int</span><br><span> read_tun_header(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&=
gt;type =3D=3D DEV_TYPE_TUN)</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/745?usp=3Demail">chan=
ge 745</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/745?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I028634dba74a273c725b0beb16b=
674897b3c23fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--m0C68j5Wchw=--

