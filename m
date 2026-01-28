From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 28 Jan 2026 13:19:17 +0000
In-Reply-To: <gerrit.1769556650000.Id530d890ba01cffb74d3dc04ad10b153f7bea1d4@...2715...>
References: <gerrit.1769556650000.Id530d890ba01cffb74d3dc04ad10b153f7bea1d4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <56ce041b74557f8e7a5838cc0916fc4e4e0f1872-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aScycTIkLoM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Prevent NULL
 pointer dereference with --dns-updown
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

--aScycTIkLoM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
98?usp=3Demail )

Change subject: Prevent NULL pointer dereference with --dns-updown
......................................................................

Prevent NULL pointer dereference with --dns-updown

If the dns-updown option appears in the config twice, there is a chance
of a NULL pointer dereference when comparing the script path to the
default script path. This happens when a custom script is set, after the
dns-updown script was disabled first. In that case the script path is
NULL, which leads to the deref during a strcmp(3).

Reported-by: <aarnav@...2953...>
Change-Id: Id530d890ba01cffb74d3dc04ad10b153f7bea1d4
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1498
Message-Id: <20260128110443.24410-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
479.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85669e0..2bca647 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7890,7 +7890,7 @@
         }
         else
         {
-            if (streq(dns->updown, DEFAULT_DNS_UPDOWN))
+            if (dns->updown && streq(dns->updown, DEFAULT_DNS_UPDOWN))
             {
                 /* Unset the default command to prevent warnings */
                 dns->updown =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id530d890ba01cffb74d3dc04ad10b153f7bea1d4
Gerrit-Change-Number: 1498
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aScycTIkLoM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1498?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Prevent NULL pointer dereference with --dns-updo=
wn<br><br>If the dns-updown option appears in the config twice, there is a =
chance<br>of a NULL pointer dereference when comparing the script path to t=
he<br>default script path. This happens when a custom script is set, after =
the<br>dns-updown script was disabled first. In that case the script path i=
s<br>NULL, which leads to the deref during a strcmp(3).<br><br>Reported-by:=
 &lt;aarnav@...2953...&gt;<br>Change-Id: Id530d890ba01cffb74d3dc04ad10b153f=
7bea1d4<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1498<br>Message-Id: &lt;20260128110443.24410-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg35479.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 1 insertion(+)=
, 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 85669e0..2bca647 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7890,7 +7=
890,7 @@</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (streq(dns-&gt;updown, DEFAULT_DNS_UPDOWN))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (dns-&gt;updown &amp;&amp=
; streq(dns-&gt;updown, DEFAULT_DNS_UPDOWN))</span><br><span>             {=
</span><br><span>                 /* Unset the default command to prevent w=
arnings */</span><br><span>                 dns-&gt;updown =3D NULL;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1498?usp=3Demail">change 1498</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1498?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id530d890ba01cffb74d3dc04ad1=
0b153f7bea1d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1498 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--aScycTIkLoM=--

