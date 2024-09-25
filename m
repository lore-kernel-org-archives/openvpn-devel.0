From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 14:26:11 +0000
References: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <da3ca77fc69c6cedeccc08cc06e2f95d64abcafd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+CMdie4P8Ts="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+CMdie4P8Ts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail

to review the following change.


Change subject: Remove null check after checking for checking for did_open_=
tun
......................................................................

Remove null check after checking for checking for did_open_tun

If we indicate that the tun device has been opened the c1.tuntap struct
is guaranteed to be defined. This extra null check is something that
Coverity flags as we access a do a null check after already accessing fields
of tuntap

Change-Id: I9966636163c7dfa208d26f1cadbf5b81937f3a34
---
M src/openvpn/init.c
1 file changed, 1 insertion(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/772/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--+CMdie4P8Ts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove null check after checking for checking for did_open_tu=
n<br><br>If we indicate that the tun device has been opened the c1.tuntap s=
truct<br>is guaranteed to be defined. This extra null check is something th=
at<br>Coverity flags as we access a do a null check after already accessing=
 fields<br>of tuntap<br><br>Change-Id: I9966636163c7dfa208d26f1cadbf5b81937=
f3a34<br>---<br>M src/openvpn/init.c<br>1 file changed, 1 insertion(+), 4 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/72/772/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index 876edad..ae911a9 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-2546,10 +2546,7 @@</span><br><span>             {</span><br><span>        =
         event_timeout_init(&amp;c-&gt;c2.route_wakeup, c-&gt;options.route=
_delay, now);</span><br><span>                 event_timeout_init(&amp;c-&g=
t;c2.route_wakeup_expire, c-&gt;options.route_delay + c-&gt;options.route_d=
elay_window, now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (c-&gt;c1.tuntap)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    tun_standby_init(c-&gt;c1.tuntap);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                tun_standby_init(c-&=
gt;c1.tuntap);</span><br><span>             }</span><br><span>             =
else</span><br><span>             {</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demai=
l">change 772</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9966636163c7dfa208d26f1cadb=
f5b81937f3a34 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 772 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--+CMdie4P8Ts=--

