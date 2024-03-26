From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Mar 2024 13:13:43 +0000
In-Reply-To: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
References: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <17c327840097985bc599746a8e4bc7347242ac82-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tRLusn2XPJU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add bracket in
 fingerprint message and do not warn about missing veri...
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

--tRLusn2XPJU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add bracket in fingerprint message and do not warn about mi=
ssing verification
......................................................................

Add bracket in fingerprint message and do not warn about missing verificati=
on

Github: fixes OpenVPN/openvpn#516

Change-Id: Ia73d53002f4ba2658af18c17cce1b68f79de5781
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240326103853.494572-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
474.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/ssl_verify.c
2 files changed, 4 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/546/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f2ce926..02205e7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3594,7 +3594,8 @@
         && !o->tls_verify
         && o->verify_x509_type =3D=3D VERIFY_X509_NONE
         && !(o->ns_cert_type & NS_CERT_CHECK_SERVER)
-        && !o->remote_cert_eku)
+        && !o->remote_cert_eku
+        && !(o->verify_hash_depth =3D=3D 0 && o->verify_hash))
     {
         msg(M_WARN, "WARNING: No server certificate verification method ha=
s been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
     }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c7d7799..930769b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -718,8 +718,8 @@
             const char *hex_fp =3D format_hex_ex(BPTR(&cert_fp), BLEN(&cer=
t_fp),
                                                0, 1, ":", &gc);
             msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
-                "certificate hash verification failed. (got "
-                "fingerprint: %s", hex_fp);
+                "certificate hash verification failed. (got certificate "
+                "fingerprint: %s)", hex_fp);
             goto cleanup;
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia73d53002f4ba2658af18c17cce1b68f79de5781
Gerrit-Change-Number: 546
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--tRLusn2XPJU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
546?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add bracket in fingerprint message and do not=
 warn about missing verification<br><br>Github: fixes OpenVPN/openvpn#516<b=
r><br>Change-Id: Ia73d53002f4ba2658af18c17cce1b68f79de5781<br>Signed-off-by=
: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240326103853.494572-1-fran=
k@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg28474.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvpn/ssl_verify.c<br>2 =
files changed, 4 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/46/546/2</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/init.c b/src/openvpn/init.c</span><br><span>index f2ce926..02205e=
7 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src=
/openvpn/init.c</span><br><span>@@ -3594,7 +3594,8 @@</span><br><span>     =
    &amp;&amp; !o-&gt;tls_verify</span><br><span>         &amp;&amp; o-&gt;=
verify_x509_type =3D=3D VERIFY_X509_NONE</span><br><span>         &amp;&amp=
; !(o-&gt;ns_cert_type &amp; NS_CERT_CHECK_SERVER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; !o-&gt;remote_cert_eku)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !o-&=
gt;remote_cert_eku</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &amp;&amp; !(o-&gt;verify_hash_depth =3D=3D 0 &amp;&amp; o-&gt;verif=
y_hash))</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;=
WARNING: No server certificate verification method has been enabled.  See h=
ttp://openvpn.net/howto.html#mitm for more info.&quot;);</span><br><span>  =
   }</span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ss=
l_verify.c</span><br><span>index c7d7799..930769b 100644</span><br><span>--=
- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c=
</span><br><span>@@ -718,8 +718,8 @@</span><br><span>             const cha=
r *hex_fp =3D format_hex_ex(BPTR(&amp;cert_fp), BLEN(&amp;cert_fp),</span><=
br><span>                                                0, 1, &quot;:&quot=
;, &amp;gc);</span><br><span>             msg(D_TLS_ERRORS, &quot;TLS Error=
: --tls-verify/--peer-fingerprint&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                &quot;certificate hash verification faile=
d. (got &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         &quot;fingerprint: %s&quot;, hex_fp);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                &quot;certificate hash verificat=
ion failed. (got certificate &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                &quot;fingerprint: %s)&quot;, hex_fp);</spa=
n><br><span>             goto cleanup;</span><br><span>         }</span><br=
><span>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail">change 546</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/546?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia73d53002f4ba2658af18c17cce=
1b68f79de5781 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 546 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tRLusn2XPJU=--

