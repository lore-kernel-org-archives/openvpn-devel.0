From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Oct 2023 20:19:07 +0000
In-Reply-To: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
References: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <917af56c40977b1007971776b2a1afd7a00687fb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vuir7U4yvLw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add warning for the
 --show-groups command that some groups are missing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vuir7U4yvLw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add warning for the --show-groups command that some groups =
are missing
......................................................................

Add warning for the --show-groups command that some groups are missing

OpenSSL has a weird way of only reporting EC curves that are implemented
in a certain way in the list of all EC curves. Note this fact and point
out that also the very important curves X448 and X25519 are affected.

Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231009105714.34598-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
193.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/366/8

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b5cc9a7..b561e9d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2249,8 +2249,10 @@
 void
 show_available_curves(void)
 {
-    printf("Consider using openssl 'ecparam -list_curves' as\n"
-           "alternative to running this command.\n");
+    printf("Consider using 'openssl ecparam -list_curves' as alternative t=
o running\n"
+           "this command.\n"
+           "Note this output does only list curves/groups that OpenSSL con=
siders as\n"
+           "builtin EC curves. It does not list additional curves nor X448=
 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves =3D NULL;
     size_t crv_len =3D 0;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
Gerrit-Change-Number: 366
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--vuir7U4yvLw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #8</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
366?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add warning for the --show-groups command tha=
t some groups are missing<br><br>OpenSSL has a weird way of only reporting =
EC curves that are implemented<br>in a certain way in the list of all EC cu=
rves. Note this fact and point<br>out that also the very important curves X=
448 and X25519 are affected.<br><br>Change-Id: I86641bf60d62a50e9b2719e809d=
2429d65c00097<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Me=
ssage-Id: &lt;20231009105714.34598-1-frank@...2641...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27193.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/s=
sl_openssl.c<br>1 file changed, 4 insertions(+), 2 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/366/8</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span>=
<br><span>index b5cc9a7..b561e9d 100644</span><br><span>--- a/src/openvpn/s=
sl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><spa=
n>@@ -2249,8 +2249,10 @@</span><br><span> void</span><br><span> show_availa=
ble_curves(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    printf(&quot;Consider using openssl &#39;ecparam -list_cu=
rves&#39; as\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
          &quot;alternative to running this command.\n&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Consider using =
&#39;openssl ecparam -list_curves&#39; as alternative to running\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;this =
command.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &quot;Note this output does only list curves/groups that OpenSSL co=
nsiders as\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &quot;builtin EC curves. It does not list additional curves nor X=
448 or X25519\n&quot;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><s=
pan>     EC_builtin_curve *curves =3D NULL;</span><br><span>     size_t crv=
_len =3D 0;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail">change 366</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/366?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d=
2429d65c00097 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 366 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vuir7U4yvLw=--

