From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 18:02:55 +0000
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <d9231da943c076fb0f3159e94f0c179eecf3a077-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o2kErrNAnBc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix setting DCO
 ifmode failing on big endian archs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--o2kErrNAnBc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1547?usp=3Demail )


Change subject: Fix setting DCO ifmode failing on big endian archs
......................................................................

Fix setting DCO ifmode failing on big endian archs

The problem is basically that SITNL_ADDATTR is not type safe and on
big endian architcutre passing a smaller size than the underlying
integer type of data causes only the more significant byte(s) to be passed
instead.

Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
---
M src/openvpn/networking_sitnl.c
1 file changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1547/1

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a5b2905..1214db2 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1337,7 +1337,13 @@
     {
         dco_context_t *dco =3D arg;
         struct rtattr *data =3D SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_=
DATA);
-        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &dco->ifmode, s=
izeof(uint8_t));
+
+        /* the netlink format is uint8_t for this and using something
+         * other than uint8_t here causes the values to be 0 when passed
+         * on big endian arch as we only take the byte directly at the add=
ress
+         */
+        uint8_t ifmode =3D (uint8_t)dco->ifmode;
+        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &ifmode, sizeof=
(uint8_t));
         SITNL_NEST_END(&req.n, data);
     }
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Gerrit-Change-Number: 1547
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--o2kErrNAnBc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1547?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix setting DCO ifmode failing on big endian archs<br><br>The problem i=
s basically that SITNL_ADDATTR is not type safe and on<br>big endian archit=
cutre passing a smaller size than the underlying<br>integer type of data ca=
uses only the more significant byte(s) to be passed<br>instead.<br><br>Chan=
ge-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35<br>---<br>M src/openvpn/ne=
tworking_sitnl.c<br>1 file changed, 7 insertions(+), 1 deletion(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/47/1547/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl.c b/src/op=
envpn/networking_sitnl.c</span><br><span>index a5b2905..1214db2 100644</spa=
n><br><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/=
openvpn/networking_sitnl.c</span><br><span>@@ -1337,7 +1337,13 @@</span><br=
><span>     {</span><br><span>         dco_context_t *dco =3D arg;</span><b=
r><span>         struct rtattr *data =3D SITNL_NEST(&amp;req.n, sizeof(req)=
, IFLA_INFO_DATA);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     SITNL_ADDATTR(&amp;req.n, sizeof(req), IFLA_OVPN_MODE, &amp;dco-&gt;if=
mode, sizeof(uint8_t));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the =
netlink format is uint8_t for this and using something</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * other than uint8_t here cause=
s the values to be 0 when passed</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * on big endian arch as we only take the byte directl=
y at the address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uin=
t8_t ifmode =3D (uint8_t)dco-&gt;ifmode;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        SITNL_ADDATTR(&amp;req.n, sizeof(req), IFLA_OV=
PN_MODE, &amp;ifmode, sizeof(uint8_t));</span><br><span>         SITNL_NEST=
_END(&amp;req.n, data);</span><br><span>     }</span><br><span> #endif</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1547?usp=3Demail">change 1547</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1547?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fb=
c63030fa10f35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--o2kErrNAnBc=--

