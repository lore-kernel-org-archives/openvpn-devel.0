From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Apr 2024 00:22:01 +0000
References: <gerrit.1712017317000.I5b14bf90bb07935f0bb84373ec4e62352752c03f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ea26a4f148f5749da84ea67b49a4a56ef38f1045-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QIrfg9bK/W0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Match ifdef for
 get_sigtype function with if ifdef of caller
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

--QIrfg9bK/W0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail

to review the following change.


Change subject: Match ifdef for get_sigtype function with if ifdef of caller
......................................................................

Match ifdef for get_sigtype function with if ifdef of caller

These two ifdef needs to be the same otherwise the compiler will
break with a undefined function.

Change-Id: I5b14bf90bb07935f0bb84373ec4e62352752c03f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/551/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6f29c3d..a158617 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2166,7 +2166,8 @@
     EVP_PKEY_free(pkey);
 }

-#if !defined(LIBRESSL_VERSION_NUMBER)  && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL
+#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL) \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >=3D 0=
x3090000fL)
 /**
  * Translate an OpenSSL NID into a more human readable name
  * @param nid

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5b14bf90bb07935f0bb84373ec4e62352752c03f
Gerrit-Change-Number: 551
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--QIrfg9bK/W0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Match ifdef for get_sigtype function with if ifdef of caller<=
br><br>These two ifdef needs to be the same otherwise the compiler will<br>=
break with a undefined function.<br><br>Change-Id: I5b14bf90bb07935f0bb8437=
3ec4e62352752c03f<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br=
>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 2 insertions(+), 1 d=
eletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/51/551/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvp=
n/ssl_openssl.c</span><br><span>index 6f29c3d..a158617 100644</span><br><sp=
an>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_op=
enssl.c</span><br><span>@@ -2166,7 +2166,8 @@</span><br><span>     EVP_PKEY=
_free(pkey);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if !defined(LIBRESSL_VERSION_NUMBER)  &amp;&am=
p; OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if (!defined(LIBRESSL_VERSION_NUMBER) &amp;&amp;=
 OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL) \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    || (defined(LIBRESSL_VERSION_NUMBER) &amp;&a=
mp; LIBRESSL_VERSION_NUMBER &gt;=3D 0x3090000fL)</span><br><span> /**</span=
><br><span>  * Translate an OpenSSL NID into a more human readable name</sp=
an><br><span>  * @param nid</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail">chang=
e 551</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b14bf90bb07935f0bb84373ec4=
e62352752c03f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 551 </div>
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


--QIrfg9bK/W0=--

