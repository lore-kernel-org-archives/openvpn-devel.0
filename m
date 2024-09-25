From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 16:53:32 +0000
In-Reply-To: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
References: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <474adb19308c50eeb3e8ce22d3fa7ca71c9ea512-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vFLtMxsBs4Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove null check
 after checking for checking for did_open_tun
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

--vFLtMxsBs4Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/77=
2?usp=3Demail )

Change subject: Remove null check after checking for checking for did_open_=
tun
......................................................................

Remove null check after checking for checking for did_open_tun

If we indicate that the tun device has been opened the c1.tuntap struct
is guaranteed to be defined. This extra null check is something that
Coverity flags as we access a do a null check after already accessing fields
of tuntap

Change-Id: I9966636163c7dfa208d26f1cadbf5b81937f3a34
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240925151104.13036-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
447.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 1 insertion(+), 4 deletions(-)




diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 876edad..ae911a9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2546,10 +2546,7 @@
             {
                 event_timeout_init(&c->c2.route_wakeup, c->options.route_d=
elay, now);
                 event_timeout_init(&c->c2.route_wakeup_expire, c->options.=
route_delay + c->options.route_delay_window, now);
-                if (c->c1.tuntap)
-                {
-                    tun_standby_init(c->c1.tuntap);
-                }
+                tun_standby_init(c->c1.tuntap);
             }
             else
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9966636163c7dfa208d26f1cadbf5b81937f3a34
Gerrit-Change-Number: 772
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vFLtMxsBs4Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/772?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove null check after checking for checking =
for did_open_tun<br><br>If we indicate that the tun device has been opened =
the c1.tuntap struct<br>is guaranteed to be defined. This extra null check =
is something that<br>Coverity flags as we access a do a null check after al=
ready accessing fields<br>of tuntap<br><br>Change-Id: I9966636163c7dfa208d2=
6f1cadbf5b81937f3a34<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...2068...=
7...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &=
lt;20240925151104.13036-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg29447.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>1 f=
ile changed, 1 insertion(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 876edad..ae911a9 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2546,10 +2546,7 @@</s=
pan><br><span>             {</span><br><span>                 event_timeout=
_init(&amp;c-&gt;c2.route_wakeup, c-&gt;options.route_delay, now);</span><b=
r><span>                 event_timeout_init(&amp;c-&gt;c2.route_wakeup_expi=
re, c-&gt;options.route_delay + c-&gt;options.route_delay_window, now);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (c-&gt=
;c1.tuntap)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      tun_standby_init(c-&gt;c1.tuntap);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                tun_standby_init(c-&gt;c1.tuntap);</span><=
br><span>             }</span><br><span>             else</span><br><span> =
            {</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail">change 772</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/772?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9966636163c7dfa208d26f1cadb=
f5b81937f3a34 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 772 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vFLtMxsBs4Y=--

