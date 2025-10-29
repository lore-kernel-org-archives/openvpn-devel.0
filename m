From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 13:43:52 +0000
References: <gerrit.1761745430000.I648ee99b1152b1248d1b3e64af7679ab99f1388f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8e0d63c7d47c3f238db8fcc9e39c80e91217bf8e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cTs/hH8C36Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix warnings about
 conversion from int to unsigned char/uint8_t
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

--cTs/hH8C36Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail

to review the following change.


Change subject: Fix warnings about conversion from int to unsigned char/uin=
t8_t
......................................................................

Fix warnings about conversion from int to unsigned char/uint8_t

When compiling with cmake -DCMAKE_BUILD_TYPE=3DASAN under Ubuntu 25.10
(gcc 15.2.0).

Explicitly cast these instances to uint8_t/unssigned char to silence this
warning.

Change-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/httpdigest.c
M src/openvpn/mroute.c
2 files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1328/1

diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index be20638..3e6520a 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -46,7 +46,7 @@
         }
         else
         {
-            Hex[i * 2] =3D (j + 'a' - 10);
+            Hex[i * 2] =3D (unsigned char)(j + 'a' - 10);
         }
         j =3D Bin[i] & 0xf;
         if (j <=3D 9)
@@ -55,7 +55,7 @@
         }
         else
         {
-            Hex[i * 2 + 1] =3D (j + 'a' - 10);
+            Hex[i * 2 + 1] =3D (unsigned char)(j + 'a' - 10);
         }
     }
     Hex[HASHHEXLEN] =3D '\0';
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index b50d48f..d17902f 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -337,7 +337,7 @@
             }
             else
             {
-                ma->v6.addr.s6_addr[byte--] &=3D (0xFF << bits_to_clear);
+                ma->v6.addr.s6_addr[byte--] &=3D (uint8_t)(0xFF << bits_to=
_clear);
                 bits_to_clear =3D 0;
             }
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f
Gerrit-Change-Number: 1328
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--cTs/hH8C36Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix warnings about conversion from int to u=
nsigned char/uint8_t<br><br>When compiling with cmake -DCMAKE_BUILD_TYPE=3D=
ASAN under Ubuntu 25.10<br>(gcc 15.2.0).<br><br>Explicitly cast these insta=
nces to uint8_t/unssigned char to silence this<br>warning.<br><br>Change-Id=
: I648ee99b1152b1248d1b3e64af7679ab99f1388f<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>---<br>M src/openvpn/httpdigest.c<br>M src/openv=
pn/mroute.c<br>2 files changed, 3 insertions(+), 3 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/28/1328/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/httpdigest.c b/src/openvpn/htt=
pdigest.c</span><br><span>index be20638..3e6520a 100644</span><br><span>---=
 a/src/openvpn/httpdigest.c</span><br><span>+++ b/src/openvpn/httpdigest.c<=
/span><br><span>@@ -46,7 +46,7 @@</span><br><span>         }</span><br><spa=
n>         else</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            Hex[i * 2] =3D (j + &#39;a&#39; - 10);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            Hex[i * 2] =
=3D (unsigned char)(j + &#39;a&#39; - 10);</span><br><span>         }</span=
><br><span>         j =3D Bin[i] &amp; 0xf;</span><br><span>         if (j =
&lt;=3D 9)</span><br><span>@@ -55,7 +55,7 @@</span><br><span>         }</sp=
an><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            Hex[i * 2 + 1] =3D (j + &#39;a&=
#39; - 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    Hex[i * 2 + 1] =3D (unsigned char)(j + &#39;a&#39; - 10);</span><br><sp=
an>         }</span><br><span>     }</span><br><span>     Hex[HASHHEXLEN] =
=3D &#39;\0&#39;;</span><br><span>diff --git a/src/openvpn/mroute.c b/src/o=
penvpn/mroute.c</span><br><span>index b50d48f..d17902f 100644</span><br><sp=
an>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</s=
pan><br><span>@@ -337,7 +337,7 @@</span><br><span>             }</span><br>=
<span>             else</span><br><span>             {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                ma-&gt;v6.addr.s6_addr[byt=
e--] &amp;=3D (0xFF &lt;&lt; bits_to_clear);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ma-&gt;v6.addr.s6_addr[byte--] &am=
p;=3D (uint8_t)(0xFF &lt;&lt; bits_to_clear);</span><br><span>             =
    bits_to_clear =3D 0;</span><br><span>             }</span><br><span>   =
      }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail">change 1328</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I648ee99b1152b1248d1b3e64af7=
679ab99f1388f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1328 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--cTs/hH8C36Y=--

