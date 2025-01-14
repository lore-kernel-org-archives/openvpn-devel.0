From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 15:58:43 +0000
In-Reply-To: <gerrit.1736847832000.I9a12a0c127908af9f09d88fb3a493df3763d0cc5@...2715...>
References: <gerrit.1736847832000.I9a12a0c127908af9f09d88fb3a493df3763d0cc5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6f6b964f5a5d8950f0495c09b7c11b16b3ab8f5a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4QG+3+H+Iww="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve peer
 fingerprint documentation
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

--4QG+3+H+Iww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
9?usp=3Demail )

Change subject: Improve peer fingerprint documentation
......................................................................

Improve peer fingerprint documentation

- fix typo in peer-fingerprint
- use ec_paramgen_curve instead of requiring a subshell

Note: we still use -nodes instead of -noenc as it is more compatible.

Github: closes OpenVPN/openvpn#666

Change-Id: I9a12a0c127908af9f09d88fb3a493df3763d0cc5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250114134909.31334-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
447.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/example-fingerprint.rst
1 file changed, 10 insertions(+), 4 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--4QG+3+H+Iww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/859?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Improve peer fingerprint documentation<br><br>=
- fix typo in peer-fingerprint<br>- use ec_paramgen_curve instead of requir=
ing a subshell<br><br>Note: we still use -nodes instead of -noenc as it is =
more compatible.<br><br>Github: closes OpenVPN/openvpn#666<br><br>Change-Id=
: I9a12a0c127908af9f09d88fb3a493df3763d0cc5<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Message-Id: &lt;20250114134909.31334-1-frank@...2641...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30447.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc=
/man-sections/example-fingerprint.rst<br>1 file changed, 10 insertions(+), =
4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections=
/example-fingerprint.rst</span><br><span>index 7cdda19..31ca0c1 100644</spa=
n><br><span>--- a/doc/man-sections/example-fingerprint.rst</span><br><span>=
+++ b/doc/man-sections/example-fingerprint.rst</span><br><span>@@ -18,7 +18=
,7 @@</span><br><span> 2. Generate a self-signed certificate for the server=
:</span><br><span>    ::</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    openssl req -x509 -newkey ec:&lt;(openssl ecparam =
-name secp384r1) -keyout server.key -out server.crt -nodes -sha256 -days 36=
50 -subj &#39;/CN=3Dserver&#39;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:sec=
p384r1 -keyout server.key -out server.crt -nodes -sha256 -days 3650 -subj &=
#39;/CN=3Dserver&#39;</span><br><span> </span><br><span> 3. Generate SHA256=
 fingerprint of the server certificate</span><br><span> </span><br><span>@@=
 -28,7 +28,7 @@</span><br><span> </span><br><span>     openssl x509 -finger=
print -sha256 -in server.crt -noout</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   This output something similar to:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   This outputs something =
similar to:</span><br><span>    ::</span><br><span> </span><br><span>      =
SHA256 Fingerprint=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:=
22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff</span><br><span>@@ -64,6 +64,12 @=
@</span><br><span>     # Ping every 60s, restart if no data received for 5 =
minutes</span><br><span>     keepalive 60 300</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # Uncomment the line below =
if you want to have persistent IP addresses</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    # ifconfig-pool-persist  /etc/openvpn/server/ip=
p.txt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    # Uncomment the line below to=
 push a DNS server to clients</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    # push &quot;dhcp-option DNS 1.1.1.1&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> 5. Add at least one =
client as described in the client section.</span><br><span> </span><br><spa=
n> 6. Start the server.</span><br><span>@@ -85,7 +91,7 @@</span><br><span> =
   different name for each client.</span><br><span>    ::</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      openssl req -x5=
09 -newkey ec:&lt;(openssl ecparam -name secp384r1) -nodes -sha256 -days 36=
50 -subj &#39;/CN=3Dalice&#39;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:se=
cp384r1 -keyout - -nodes -sha256 -days 3650 -subj &#39;/CN=3Dalice&#39;</sp=
an><br><span> </span><br><span>    This generate a certificate and a key fo=
r the client. The output of the command will look</span><br><span>    somet=
hing like this:</span><br><span>@@ -162,7 +168,7 @@</span><br><span>       =
&lt;peer-fingerprint&gt;</span><br><span>       ff:ee:dd:cc:bb:aa:99:88:77:=
66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00</span>=
<br><span>       99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:6=
6:55:44:33:22:11:00:88:77:66:55:44:33</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      &lt;/peer-fingperint&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      &lt;/peer-fingerprint&gt;</span><br><span>=
 </span><br><span> 6. (optional) if the client is an older client that does=
 not support the</span><br><span>    :code:`peer-fingerprint` (e.g. OpenVPN=
 2.5 and older, OpenVPN Connect 3.3</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/859?usp=3Demai=
l">change 859</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/859?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a12a0c127908af9f09d88fb3a4=
93df3763d0cc5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 859 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--4QG+3+H+Iww=--

