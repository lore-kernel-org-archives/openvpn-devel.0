From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 10:25:31 +0000
References: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d6de0d7a5b6606bbf335bf10d157a5a55fed910c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gSX8y8rbDEY="; charset=UTF-8
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

--gSX8y8rbDEY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/366/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 683d76a..a14eb59 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2357,8 +2357,10 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gSX8y8rbDEY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add warning for the --show-groups command that some groups ar=
e missing<br><br>OpenSSL has a weird way of only reporting EC curves that a=
re implemented<br>in a certain way in the list of all EC cruves. Note this =
fact and point<br>out that also the very important curves X448 and X25519 a=
re affected.<br><br>Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097<br=
>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 4 insertions(+), 2 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/66/366/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openv=
pn/ssl_openssl.c</span><br><span>index 683d76a..a14eb59 100644</span><br><s=
pan>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_o=
penssl.c</span><br><span>@@ -2357,8 +2357,10 @@</span><br><span> void</span=
><br><span> show_available_curves(void)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Consider using openss=
l &#39;ecparam -list_curves&#39; as\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-           &quot;alternative to running this command.=
\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print=
f(&quot;Consider using &#39;openssl ecparam -list_curves&#39; as alternativ=
e to running\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &quot;this command.\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &quot;Note this output does only list curves=
/group that OpenSSL considers as\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           &quot;builtin EC curves. It does not list a=
dditional curves nor X448 or X25519\n&quot;);</span><br><span> #ifndef OPEN=
SSL_NO_EC</span><br><span>     EC_builtin_curve *curves =3D NULL;</span><br=
><span>     size_t crv_len =3D 0;</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail"=
>change 366</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d=
2429d65c00097 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 366 </div>
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


--gSX8y8rbDEY=--

