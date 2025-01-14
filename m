From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 09:43:55 +0000
References: <gerrit.1736847832000.I9a12a0c127908af9f09d88fb3a493df3763d0cc5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <57a9ad9e2c345ece460491326b4df9285578df19-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DbkcM37WuPU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve peer
 fingerpint documentation
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

--DbkcM37WuPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/859?usp=3Demail

to review the following change.


Change subject: Improve peer fingerpint documentation
......................................................................

Improve peer fingerpint documentation

- fix typo in peer-fingerprint
- use ec_paramgen_curve instead of requiring a subshell

Note: we still use -nodes instead of -noenc as it is more compatible.

closes: issue #666

Change-Id: I9a12a0c127908af9f09d88fb3a493df3763d0cc5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/example-fingerprint.rst
1 file changed, 10 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/859/1

diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/ex=
ample-fingerprint.rst
index 7cdda19..31ca0c1 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -18,7 +18,7 @@
 2. Generate a self-signed certificate for the server:
    ::

-    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyou=
t server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=3Dserver'
+    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -key=
out server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=3Dserve=
r'

 3. Generate SHA256 fingerprint of the server certificate

@@ -28,7 +28,7 @@

     openssl x509 -fingerprint -sha256 -in server.crt -noout

-   This output something similar to:
+   This outputs something similar to:
    ::

      SHA256 Fingerprint=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:=
00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
@@ -64,6 +64,12 @@
     # Ping every 60s, restart if no data received for 5 minutes
     keepalive 60 300

+    # Uncomment the line below if you want to have persistent IP addresses
+    # ifconfig-pool-persist  /etc/openvpn/server/ipp.txt
+
+    # Uncomment the line below to push a DNS server to clients
+    # push "dhcp-option DNS 1.1.1.1"
+
 5. Add at least one client as described in the client section.

 6. Start the server.
@@ -85,7 +91,7 @@
    different name for each client.
    ::

-      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -nod=
es -sha256 -days 3650 -subj '/CN=3Dalice'
+      openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -k=
eyout - -nodes -sha256 -days 3650 -subj '/CN=3Dalice'

    This generate a certificate and a key for the client. The output of the=
 command will look
    something like this:
@@ -162,7 +168,7 @@
       <peer-fingerprint>
       ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99=
:88:77:66:55:44:33:22:11:00
       99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33=
:22:11:00:88:77:66:55:44:33
-      </peer-fingperint>
+      </peer-fingerprint>

 6. (optional) if the client is an older client that does not support the
    :code:`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3=
.3

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/859?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a12a0c127908af9f09d88fb3a493df3763d0cc5
Gerrit-Change-Number: 859
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--DbkcM37WuPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/859?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Improve peer fingerpint documentation<br><br>- fix typo in pe=
er-fingerprint<br>- use ec_paramgen_curve instead of requiring a subshell<b=
r><br>Note: we still use -nodes instead of -noenc as it is more compatible.=
<br><br>closes: issue #666<br><br>Change-Id: I9a12a0c127908af9f09d88fb3a493=
df3763d0cc5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<b=
r>M doc/man-sections/example-fingerprint.rst<br>1 file changed, 10 insertio=
ns(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/59/859/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/example-fi=
ngerprint.rst b/doc/man-sections/example-fingerprint.rst</span><br><span>in=
dex 7cdda19..31ca0c1 100644</span><br><span>--- a/doc/man-sections/example-=
fingerprint.rst</span><br><span>+++ b/doc/man-sections/example-fingerprint.=
rst</span><br><span>@@ -18,7 +18,7 @@</span><br><span> 2. Generate a self-s=
igned certificate for the server:</span><br><span>    ::</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openssl req -x509 =
-newkey ec:&lt;(openssl ecparam -name secp384r1) -keyout server.key -out se=
rver.crt -nodes -sha256 -days 3650 -subj &#39;/CN=3Dserver&#39;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    openssl req -x509 -newkey e=
c -pkeyopt ec_paramgen_curve:secp384r1 -keyout server.key -out server.crt -=
nodes -sha256 -days 3650 -subj &#39;/CN=3Dserver&#39;</span><br><span> </sp=
an><br><span> 3. Generate SHA256 fingerprint of the server certificate</spa=
n><br><span> </span><br><span>@@ -28,7 +28,7 @@</span><br><span> </span><br=
><span>     openssl x509 -fingerprint -sha256 -in server.crt -noout</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   This out=
put something similar to:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   This outputs something similar to:</span><br><span>    ::</span><b=
r><span> </span><br><span>      SHA256 Fingerprint=3D00:11:22:33:44:55:66:7=
7:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff</=
span><br><span>@@ -64,6 +64,12 @@</span><br><span>     # Ping every 60s, re=
start if no data received for 5 minutes</span><br><span>     keepalive 60 3=
00</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    # Uncomment the line below if you want to have persistent IP addresses=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # ifconfig-pool=
-persist  /etc/openvpn/server/ipp.txt</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   # Uncomment the line below to push a DNS server to clients</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    # push &quot;dhcp-option DNS =
1.1.1.1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> 5. Add at least one client as described in the client section.<=
/span><br><span> </span><br><span> 6. Start the server.</span><br><span>@@ =
-85,7 +91,7 @@</span><br><span>    different name for each client.</span><b=
r><span>    ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      openssl req -x509 -newkey ec:&lt;(openssl ecparam -name se=
cp384r1) -nodes -sha256 -days 3650 -subj &#39;/CN=3Dalice&#39;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      openssl req -x509 -newkey =
ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -nodes -sha256 -days 3650=
 -subj &#39;/CN=3Dalice&#39;</span><br><span> </span><br><span>    This gen=
erate a certificate and a key for the client. The output of the command wil=
l look</span><br><span>    something like this:</span><br><span>@@ -162,7 +=
168,7 @@</span><br><span>       &lt;peer-fingerprint&gt;</span><br><span>  =
     ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:8=
8:77:66:55:44:33:22:11:00</span><br><span>       99:88:77:66:55:44:33:22:11=
:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:88:77:66:55:44:33</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      &lt;/peer-fingperint&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      &lt;/peer-=
fingerprint&gt;</span><br><span> </span><br><span> 6. (optional) if the cli=
ent is an older client that does not support the</span><br><span>    :code:=
`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3.3</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/859?usp=3Demail">change 859</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/859?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a12a0c127908af9f09d88fb3a4=
93df3763d0cc5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 859 </div>
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


--DbkcM37WuPU=--

