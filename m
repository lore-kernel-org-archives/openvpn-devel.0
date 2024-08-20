From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 20 Aug 2024 12:25:33 +0000
References: <gerrit.1724156731000.I2f018ffc3e067b7967289a87e06f730de0d7e8a8@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9f39214e2d65c2f1a2b15374587f576664c1c939-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M8QVH2K8eno="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GitHub: preventing
 errors on GitHub Mac runner images
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

--M8QVH2K8eno=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/732?usp=3Demail

to review the following change.


Change subject: GitHub: preventing errors on GitHub Mac runner images
......................................................................

GitHub: preventing errors on GitHub Mac runner images

Change-Id: I2f018ffc3e067b7967289a87e06f730de0d7e8a8
Signed-off-by: Marco Baffo <marco@...2726...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/732/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6e361d5..616b322 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -249,7 +249,11 @@
       UBSAN_OPTIONS: print_stacktrace=3D1
     steps:
       - name: Install dependencies
-        run: brew install openssl@...2560... openssl@...1554... lzo lz4 ma=
n2html cmocka libtool automake autoconf libressl
+        run: |
+          # Unlink and re-link to prevent errors when github mac runner im=
ages
+          # https://github.com/actions/setup-python/issues/577
+          brew list -1 | grep python | while read formula; do brew unlink =
$formula; brew link --overwrite $formula; done
+          brew install openssl@...2560... openssl@...1554... lzo lz4 man2h=
tml cmocka libtool automake autoconf libressl
       - name: Checkout OpenVPN
         uses: actions/checkout@...2691...
       - name: autoconf

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/732?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f018ffc3e067b7967289a87e06f730de0d7e8a8
Gerrit-Change-Number: 732
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--M8QVH2K8eno=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/732?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GitHub: preventing errors on GitHub Mac runner images<br><br>=
Change-Id: I2f018ffc3e067b7967289a87e06f730de0d7e8a8<br>Signed-off-by: Marc=
o Baffo &lt;marco@...2726...&gt;<br>---<br>M .github/workflows/build.yaml<b=
r>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/32/732/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span=
>index 6e361d5..616b322 100644</span><br><span>--- a/.github/workflows/buil=
d.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@=
@ -249,7 +249,11 @@</span><br><span>       UBSAN_OPTIONS: print_stacktrace=
=3D1</span><br><span>     steps:</span><br><span>       - name: Install dep=
endencies</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run:=
 brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka=
 libtool automake autoconf libressl</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          # Unlink and re-link to prevent errors when github mac=
 runner images</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     # https://github.com/actions/setup-python/issues/577</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          brew list -1 | grep python =
| while read formula; do brew unlink $formula; brew link --overwrite $formu=
la; done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          b=
rew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka l=
ibtool automake autoconf libressl</span><br><span>       - name: Checkout O=
penVPN</span><br><span>         uses: actions/checkout@...2691...</span><br=
><span>       - name: autoconf</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/732?usp=3Demail">ch=
ange 732</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/732?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f018ffc3e067b7967289a87e06=
f730de0d7e8a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 732 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--M8QVH2K8eno=--

