From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 13:42:36 +0000
In-Reply-To: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
References: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2115aad57d564ee1ca45bccead2fc9b740c9445b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5ho099Q9OSM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5ho099Q9OSM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail

to look at the new patch set (#7).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Add warning for the --show-groups command that some groups =
are missing
......................................................................

Add warning for the --show-groups command that some groups are missing

OpenSSL has a weird way of only reporting EC curves that are implemented
in a certain way in the list of all EC cruves. Note this fact and point
out that also the very important curves X448 and X25519 are affected.

Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
---
M src/openvpn/ssl_openssl.c
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/366/7

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 686ecf7..2b3f4f4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2359,8 +2359,10 @@
 void
 show_available_curves(void)
 {
-    printf("Consider using openssl 'ecparam -list_curves' as\n"
-           "alternative to running this command.\n");
+    printf("Consider using 'openssl ecparam -list_curves' as alternative t=
o running\n"
+           "this command.\n"
+           "Note this output does only list curves/group that OpenSSL cons=
iders as\n"
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
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--5ho099Q9OSM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #7</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Add warning for the --show-groups command that some group=
s are missing<br><br>OpenSSL has a weird way of only reporting EC curves th=
at are implemented<br>in a certain way in the list of all EC cruves. Note t=
his fact and point<br>out that also the very important curves X448 and X255=
19 are affected.<br><br>Change-Id: I86641bf60d62a50e9b2719e809d2429d65c0009=
7<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 4 insertions(+),=
 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/66/366/7</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/o=
penvpn/ssl_openssl.c</span><br><span>index 686ecf7..2b3f4f4 100644</span><b=
r><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/s=
sl_openssl.c</span><br><span>@@ -2359,8 +2359,10 @@</span><br><span> void</=
span><br><span> show_available_curves(void)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Consider using op=
enssl &#39;ecparam -list_curves&#39; as\n&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-           &quot;alternative to running this comm=
and.\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
rintf(&quot;Consider using &#39;openssl ecparam -list_curves&#39; as altern=
ative to running\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &quot;this command.\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &quot;Note this output does only list cu=
rves/group that OpenSSL considers as\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           &quot;builtin EC curves. It does not li=
st additional curves nor X448 or X25519\n&quot;);</span><br><span> #ifndef =
OPENSSL_NO_EC</span><br><span>     EC_builtin_curve *curves =3D NULL;</span=
><br><span>     size_t crv_len =3D 0;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Dem=
ail">change 366</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d=
2429d65c00097 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 366 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5ho099Q9OSM=--

