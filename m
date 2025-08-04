From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 13:37:24 +0000
In-Reply-To: <gerrit.1754309687000.I9159e2e354170ad6dbed5a6ce620f57fa8ab128e@...2715...>
References: <gerrit.1754309687000.I9159e2e354170ad6dbed5a6ce620f57fa8ab128e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <00d0b8ab59a33482ef21ca6393d76906a9437e1a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5XEPopSefpM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: enable -Werror
 for mbedTLS v3 and AWS LC builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5XEPopSefpM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
28?usp=3Demail )

Change subject: GHA: enable -Werror for mbedTLS v3 and AWS LC builds
......................................................................

GHA: enable -Werror for mbedTLS v3 and AWS LC builds

Because we can and so we should.

Change-Id: I9159e2e354170ad6dbed5a6ce620f57fa8ab128e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250804133413.24729-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
505.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index bd5895b..a499e1c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -425,7 +425,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=3Dmbedtls
+        run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks
@@ -489,7 +489,7 @@
           OPENSSL_CFLAGS=3D"-I/${{ env.AWS_LC_INSTALL }}/include" \
           OPENSSL_LIBS=3D"-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto"=
 \
           LDFLAGS=3D"-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl
+          ./configure --with-crypto-library=3Dopenssl --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9159e2e354170ad6dbed5a6ce620f57fa8ab128e
Gerrit-Change-Number: 1128
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--5XEPopSefpM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1128?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">GHA: enable -Werror for mbedTLS v3 and AWS LC=
 builds<br><br>Because we can and so we should.<br><br>Change-Id: I9159e2e3=
54170ad6dbed5a6ce620f57fa8ab128e<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<=
br>Message-Id: &lt;20250804133413.24729-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32505.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/w=
orkflows/build.yaml<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index bd5895b..a499e1c 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -425,7 +425,7 @@</span><br><span>       - name: autoconf<=
/span><br><span>         run: autoreconf -fvi</span><br><span>       - name=
: configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: ./configure --with-crypto-library=3Dmbedtls</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        run: ./configure --with-crypto-library=
=3Dmbedtls --enable-werror</span><br><span>       - name: make all</span><b=
r><span>         run: make -j3</span><br><span>       - name: configure che=
cks</span><br><span>@@ -489,7 +489,7 @@</span><br><span>           OPENSSL_=
CFLAGS=3D&quot;-I/${{ env.AWS_LC_INSTALL }}/include&quot; \</span><br><span=
>           OPENSSL_LIBS=3D&quot;-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lc=
rypto&quot; \</span><br><span>           LDFLAGS=3D&quot;-Wl,-rpath=3D/${{ =
env.AWS_LC_INSTALL }}/lib&quot; \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-          ./configure --with-crypto-library=3Dopenssl</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          ./configure --with-=
crypto-library=3Dopenssl --enable-werror</span><br><span>       - name: mak=
e all</span><br><span>         run: make -j3</span><br><span>       - name:=
 configure checks</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail">change 1128</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1128?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9159e2e354170ad6dbed5a6ce62=
0f57fa8ab128e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1128 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--5XEPopSefpM=--

