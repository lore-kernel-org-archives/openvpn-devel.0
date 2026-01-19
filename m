From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 13:56:33 +0000
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <3c5d98d1fbb84eab52fb37ece49faf06cee213a1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SObHlLYqOJk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix rare crash when
 read buffer are not initialised and read is still...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SObHlLYqOJk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1477?usp=3Demail )


Change subject: Fix rare crash when read buffer are not initialised and rea=
d is still signalled
......................................................................

Fix rare crash when read buffer are not initialised and read is still signa=
lled

This assertion happens when we do not expect a read event from the socket a=
nd
then in link_socket_read_tcp the function stream_buf_get_next can trigger
an assert on ASSERT(buf_defined(&sb->next));

To avoid this weird corner case, just always initialise the read buffer
whether or not we expect a read to occur.

Reproducing this bug requires very special circumstances. The reproduction =
is
   openvpn --cert server-secp384r1.crt  --key server-secp384r1.key \
   --dev ml-tan --dev-type tap --tun-mtu 1400 --config ~/fp --topology subn=
et \
   --port 2201 --verb 3  --mode server  --tls-server --proto tcp6-server
   --ifconfig 10.0.0.1 255.255.255.0

as the server side and

  openvpn --client --proto tcp --remote poseidon --port 2201 --dev tap

The client side must be on Linux. Other platform do not reproduce this
bug.

Note that the client will not configure any IP or IPv6 on the interface
and will also not bring up the interface. The server must also send at least
one real data packet to the client (no keepalive ping). Just having the
interface up normally produces enough traffic.

Now forcefully reset the TCP connection. E.g. by executing on the server

    sudo ss --kill sport 2201

This will now trigger the assertion. This happens since OpenVPN waits
forever to get a write back from the poll from the tun/tap device but
this never happens since the device is not up.

As long as we do not get back the tun device for writing, we also do
not put the socket back into the EVENT_READ state. And this also means
that code to initialise the read buffer (stream_buf_set_next) is never
run.

But the reset on the TCP socket triggers the TCP socket to be available
for read, even if it is just for a read of 0 bytes to indicate the reset.
So the link_socket_read_tcp will run into the assert.

Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/socket.c
1 file changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1477/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 093f822..0858e64 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2927,7 +2927,11 @@
 {
     if (s)
     {
-        if ((rwflags & EVENT_READ) && !stream_buf_read_setup(s))
+        /* Always setup the buffer to be able to get a read. There are cor=
ner cases
+         * where the socket select/poll returns a socket for read when we =
do not
+         * expect it, e.g. a read of len 0 when the socket receives a rese=
t */
+        const bool read_setup =3D stream_buf_read_setup(s);
+        if ((rwflags & EVENT_READ) && !read_setup)
         {
             ASSERT(!persistent);
             rwflags &=3D ~EVENT_READ;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Gerrit-Change-Number: 1477
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SObHlLYqOJk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1477?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix rare crash when read buffer are not initialised and read is still s=
ignalled<br><br>This assertion happens when we do not expect a read event f=
rom the socket and<br>then in link_socket_read_tcp the function stream_buf_=
get_next can trigger<br>an assert on ASSERT(buf_defined(&amp;sb-&gt;next));=
<br><br>To avoid this weird corner case, just always initialise the read bu=
ffer<br>whether or not we expect a read to occur.<br><br>Reproducing this b=
ug requires very special circumstances. The reproduction is<br>   openvpn -=
-cert server-secp384r1.crt  --key server-secp384r1.key \<br>   --dev ml-tan=
 --dev-type tap --tun-mtu 1400 --config ~/fp --topology subnet \<br>   --po=
rt 2201 --verb 3  --mode server  --tls-server --proto tcp6-server<br>   --i=
fconfig 10.0.0.1 255.255.255.0<br><br>as the server side and<br><br>  openv=
pn --client --proto tcp --remote poseidon --port 2201 --dev tap<br><br>The =
client side must be on Linux. Other platform do not reproduce this<br>bug.<=
br><br>Note that the client will not configure any IP or IPv6 on the interf=
ace<br>and will also not bring up the interface. The server must also send =
at least<br>one real data packet to the client (no keepalive ping). Just ha=
ving the<br>interface up normally produces enough traffic.<br><br>Now force=
fully reset the TCP connection. E.g. by executing on the server<br><br>    =
sudo ss --kill sport 2201<br><br>This will now trigger the assertion. This =
happens since OpenVPN waits<br>forever to get a write back from the poll fr=
om the tun/tap device but<br>this never happens since the device is not up.=
<br><br>As long as we do not get back the tun device for writing, we also d=
o<br>not put the socket back into the EVENT_READ state. And this also means=
<br>that code to initialise the read buffer (stream_buf_set_next) is never<=
br>run.<br><br>But the reset on the TCP socket triggers the TCP socket to b=
e available<br>for read, even if it is just for a read of 0 bytes to indica=
te the reset.<br>So the link_socket_read_tcp will run into the assert.<br><=
br>Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/socket.c<br>1 f=
ile changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1477/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>in=
dex 093f822..0858e64 100644</span><br><span>--- a/src/openvpn/socket.c</spa=
n><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2927,7 +2927,11 =
@@</span><br><span> {</span><br><span>     if (s)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((rwflags &am=
p; EVENT_READ) &amp;&amp; !stream_buf_read_setup(s))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Always setup the buffer to be =
able to get a read. There are corner cases</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * where the socket select/poll returns a so=
cket for read when we do not</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * expect it, e.g. a read of len 0 when the socket receive=
s a reset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const bool read_setup =3D stream_buf_read_setup(s);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((rwflags &amp; EVENT_READ) &a=
mp;&amp; !read_setup)</span><br><span>         {</span><br><span>          =
   ASSERT(!persistent);</span><br><span>             rwflags &amp;=3D ~EVEN=
T_READ;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">change 1477</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--SObHlLYqOJk=--

