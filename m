From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jan 2024 15:07:09 +0000
In-Reply-To: <gerrit.1705584340000.Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8@...2715...>
References: <gerrit.1705584340000.Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., dazo@...2108...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f90c6a4bd42ec22bd805ff6f71a14d111df1a864-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vhqofO22VlY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove conditional
 text for Apache2 linking exception
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: dazo <dazo@...2108...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vhqofO22VlY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/50=
2?usp=3Demail )

Change subject: Remove conditional text for Apache2 linking exception
......................................................................

Remove conditional text for Apache2 linking exception

With the reimplementation of the tls-export feature and removal/approval
or being trivial of the rest of the code, now all the code falls under
new license. Remove the conditional text of the license to be only valid
for parts of OpenVPN.

Change-Id: Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8
Acked-by: dazo <dazo@...2108...>
Message-Id: <20240118135530.3911-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
077.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M COPYING
1 file changed, 0 insertions(+), 5 deletions(-)




diff --git a/COPYING b/COPYING
index ab59cef..28525d7 100644
--- a/COPYING
+++ b/COPYING
@@ -33,11 +33,6 @@

 Apache2 linking exception:
 ---------------------------
-OpenVPN is currently undergoing a license change to add an exception for
-Apache 2 linking. The following exception is only valid for new contributi=
ons
-after 2023-05-03 and past contribution where the authors have already agre=
ed
-to the exception.
-
   In addition, as a special exception, OpenVPN Inc and the
   contributors give permission to link the code of this program to
   libraries (the "Libraries") licensed under the Apache License

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/502?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8
Gerrit-Change-Number: 502
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: dazo <dazo@...2108...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vhqofO22VlY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/502?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove conditional text for Apache2 linking ex=
ception<br><br>With the reimplementation of the tls-export feature and remo=
val/approval<br>or being trivial of the rest of the code, now all the code =
falls under<br>new license. Remove the conditional text of the license to b=
e only valid<br>for parts of OpenVPN.<br><br>Change-Id: Ia9c5453dc08679ffb7=
3a275ddd4f28095ff1c1f8<br>Acked-by: dazo &lt;dazo@...2108...&gt;<br>Message=
-Id: &lt;20240118135530.3911-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg28077.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M COPYING<br>1 file ch=
anged, 0 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/COPYING b/COPYING</span><br><span>index ab59cef..28525d7 10=
0644</span><br><span>--- a/COPYING</span><br><span>+++ b/COPYING</span><br>=
<span>@@ -33,11 +33,6 @@</span><br><span> </span><br><span> Apache2 linking=
 exception:</span><br><span> ---------------------------</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-OpenVPN is currently undergoing a licens=
e change to add an exception for</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Apache 2 linking. The following exception is only valid for new =
contributions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-after 20=
23-05-03 and past contribution where the authors have already agreed</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-to the exception.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   In addition,=
 as a special exception, OpenVPN Inc and the</span><br><span>   contributor=
s give permission to link the code of this program to</span><br><span>   li=
braries (the &quot;Libraries&quot;) licensed under the Apache License</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/502?usp=3Demail">change 502</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/502?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9c5453dc08679ffb73a275ddd4=
f28095ff1c1f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 502 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: dazo &lt;dazo@...2108...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vhqofO22VlY=--

