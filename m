From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jan 2024 13:25:42 +0000
References: <gerrit.1705584340000.Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <e4b61b216ece4a3a81b3c67fef6877d6e85fb829-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UbtnmTLM7VE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UbtnmTLM7VE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/502?usp=3Demail

to review the following change.


Change subject: Remove conditional text for Apache2 linking exception
......................................................................

Remove conditional text for Apache2 linking exception

With the reimplementation of the tls-export feature and removal/approval
or being trivial of the rest of the code, now all the code falls under
new license. Remove the conditional text of the license to be only valid
for parts of OpenVPN.

Change-Id: Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8
---
M COPYING
1 file changed, 0 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/502/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--UbtnmTLM7VE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/502?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove conditional text for Apache2 linking exception<br><br>=
With the reimplementation of the tls-export feature and removal/approval<br=
>or being trivial of the rest of the code, now all the code falls under<br>=
new license. Remove the conditional text of the license to be only valid<br=
>for parts of OpenVPN.<br><br>Change-Id: Ia9c5453dc08679ffb73a275ddd4f28095=
ff1c1f8<br>---<br>M COPYING<br>1 file changed, 0 insertions(+), 5 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
02/502/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/COPYING b/COPYING</span><br><span>index ab59c=
ef..28525d7 100644</span><br><span>--- a/COPYING</span><br><span>+++ b/COPY=
ING</span><br><span>@@ -33,11 +33,6 @@</span><br><span> </span><br><span> A=
pache2 linking exception:</span><br><span> ---------------------------</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenVPN is currently under=
going a license change to add an exception for</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Apache 2 linking. The following exception is only =
valid for new contributions</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-after 2023-05-03 and past contribution where the authors have already=
 agreed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-to the excepti=
on.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
  In addition, as a special exception, OpenVPN Inc and the</span><br><span>=
   contributors give permission to link the code of this program to</span><=
br><span>   libraries (the &quot;Libraries&quot;) licensed under the Apache=
 License</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/502?usp=3Demail">change 502</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/502?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9c5453dc08679ffb73a275ddd4=
f28095ff1c1f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 502 </div>
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


--UbtnmTLM7VE=--

