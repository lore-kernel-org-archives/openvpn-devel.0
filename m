From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 11:30:50 +0000
References: <gerrit.1761737448000.I70e221ff5d9752fec17bad18fd41dcf188ae8fbc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <44a3f5a239d65cbe0e3b9d4ea3e7f512e7ad3b46-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ozkiDa9PGGo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure that
 get_sigtype always return non-NULL
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

--ozkiDa9PGGo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail

to review the following change.


Change subject: Ensure that get_sigtype always return non-NULL
......................................................................

Ensure that get_sigtype always return non-NULL

There is a theoretical possibility that OpenSSL returns an NID that
OBJ_nid2sn cannot resolve and thus the function return NULL.

This is however extremely unlikely. But we still cover this case now
to make linters/code checker happy and avoid similar false positives
in the future.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I70e221ff5d9752fec17bad18fd41dcf188ae8fbc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 9 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1325/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d997141..1e1912e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2408,7 +2408,15 @@
             return "(error getting name)";

         default:
-            return OBJ_nid2sn(nid);
+            const char *type =3D OBJ_nid2sn(nid);
+            if (!type)
+            {
+                /* This is unlikely to ever happen as OpenSSL is unlikely =
to
+                 * return an NID it cannot resolve itself but we silence
+                 * linter/code checkers here */
+                type =3D "(error getting name, OBJ_nid2sn failed)";
+            }
+            return type;
     }
 }
 #endif /* ifndef LIBRESSL_VERSION_NUMBER */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70e221ff5d9752fec17bad18fd41dcf188ae8fbc
Gerrit-Change-Number: 1325
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ozkiDa9PGGo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Ensure that get_sigtype always return non-N=
ULL<br><br>There is a theoretical possibility that OpenSSL returns an NID t=
hat<br>OBJ_nid2sn cannot resolve and thus the function return NULL.<br><br>=
This is however extremely unlikely. But we still cover this case now<br>to =
make linters/code checker happy and avoid similar false positives<br>in the=
 future.<br><br>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Fo=
und-by: ZeroPath (https://zeropath.com/)<br>Change-Id: I70e221ff5d9752fec17=
bad18fd41dcf188ae8fbc<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 9 insertions(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/25/1325/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_=
openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index d997141..1e1912=
e 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>++=
+ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2408,7 +2408,15 @@</span>=
<br><span>             return &quot;(error getting name)&quot;;</span><br><=
span> </span><br><span>         default:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            return OBJ_nid2sn(nid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            const char *type =3D OBJ_nid=
2sn(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   /* This is unlikely to ever happen as OpenSSL is unlikely to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 * return an NI=
D it cannot resolve itself but we silence</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 * linter/code checkers here */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                type =3D =
&quot;(error getting name, OBJ_nid2sn failed)&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return type;</span><br><span>     }=
</span><br><span> }</span><br><span> #endif /* ifndef LIBRESSL_VERSION_NUMB=
ER */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail">change 1325</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1325?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70e221ff5d9752fec17bad18fd4=
1dcf188ae8fbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1325 </div>
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

--ozkiDa9PGGo=--

