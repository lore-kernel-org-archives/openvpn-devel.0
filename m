From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:16:58 +0000
In-Reply-To: <gerrit.1763880426000.I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca@...2715...>
References: <gerrit.1763880426000.I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e2653e70f104ce2956c55820db5824e7cf500b1d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OpMrW5aSGlA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: fix off
 by one error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OpMrW5aSGlA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
95?usp=3Demail )

Change subject: iservice: fix off by one error
......................................................................

iservice: fix off by one error

In case there is more than one non-ignored interface domain, the start
of the next domain was off by one glyph. That meant that all but the
first domain was ignored when converting to MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1395
Message-Id: <20251126104938.5612-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
678.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce37ac2f..13e303a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2234,7 +2234,8 @@
                     return NO_ERROR;
                 }

-                pos =3D comma + 1;
+                /* Comma pos is now +1 after adding leading dot */
+                pos =3D comma + 2;
             }
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1395?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca
Gerrit-Change-Number: 1395
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OpMrW5aSGlA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1395?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: fix off by one error<br><br>In case th=
ere is more than one non-ignored interface domain, the start<br>of the next=
 domain was off by one glyph. That meant that all but the<br>first domain w=
as ignored when converting to MULTI_SZ.<br><br>Reported-by: Marc Heuse &lt;=
marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Change-Id: I3ebf3=
0f6d9edc66eb54fb3f1b5634c96d156b1ca<br>Signed-off-by: Heiko Hund &lt;heiko@=
...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit =
URL: https://gerrit.openvpn.net/c/openvpn/+/1395<br>Message-Id: &lt;2025112=
6104938.5612-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg34678.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 f=
ile changed, 2 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index ce37ac2f..13e303a 100644</span><br><span>--- a/src=
/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactiv=
e.c</span><br><span>@@ -2234,7 +2234,8 @@</span><br><span>                 =
    return NO_ERROR;</span><br><span>                 }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                pos =3D=
 comma + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        /* Comma pos is now +1 after adding leading dot */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                pos =3D comma + 2;</=
span><br><span>             }</span><br><span>         }</span><br><span>  =
   }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1395?usp=3Demail">change 1395</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1395?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ebf30f6d9edc66eb54fb3f1b56=
34c96d156b1ca </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1395 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--OpMrW5aSGlA=--

