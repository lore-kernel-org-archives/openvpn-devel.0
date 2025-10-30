From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 20:58:39 +0000
In-Reply-To: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
References: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0255953b50c2714d660ce071e9b6c69fdd38f36e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="or1Est+nOSc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: fix
 key_state_gen_auth_control_files probably checking file creation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--or1Est+nOSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
27?usp=3Demail )

Change subject: fix key_state_gen_auth_control_files probably checking file=
 creation
......................................................................

fix key_state_gen_auth_control_files probably checking file creation

When the auth_failed_reason_file was added, it was forgotten to also add it
to the conditions that determine if the file creation was successful.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I94d2bdd234a1c416b78924d044bf7e57f1bed8c4
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327
Message-Id: <20251030193940.1295-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
067.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify.c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 993d22c..a16f5fa 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -992,7 +992,7 @@
     const char *apf =3D platform_create_temp_file(opt->tmp_dir, "apf", &gc=
);
     const char *afr =3D platform_create_temp_file(opt->tmp_dir, "afr", &gc=
);

-    if (acf && apf)
+    if (acf && apf && afr)
     {
         ads->auth_control_file =3D string_alloc(acf, NULL);
         ads->auth_pending_file =3D string_alloc(apf, NULL);
@@ -1004,7 +1004,7 @@
     }

     gc_free(&gc);
-    return (acf && apf);
+    return (acf && apf && afr);
 }

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I94d2bdd234a1c416b78924d044bf7e57f1bed8c4
Gerrit-Change-Number: 1327
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--or1Est+nOSc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1327?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">fix key_state_gen_auth_control_files probably ch=
ecking file creation<br><br>When the auth_failed_reason_file was added, it =
was forgotten to also add it<br>to the conditions that determine if the fil=
e creation was successful.<br><br>Reported-by: Joshua Rogers &lt;contact@...1186...=
.2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)<br>Change-Id: I9=
4d2bdd234a1c416b78924d044bf7e57f1bed8c4<br>Signed-off-by: Arne Schwabe &lt;=
arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327<br>Message-Id: &lt;20=
251030193940.1295-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg34067.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 f=
ile changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><=
br><span>index 993d22c..a16f5fa 100644</span><br><span>--- a/src/openvpn/ss=
l_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@=
@ -992,7 +992,7 @@</span><br><span>     const char *apf =3D platform_create=
_temp_file(opt-&gt;tmp_dir, &quot;apf&quot;, &amp;gc);</span><br><span>    =
 const char *afr =3D platform_create_temp_file(opt-&gt;tmp_dir, &quot;afr&q=
uot;, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (acf &amp;&amp; apf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (acf &amp;&amp; apf &amp;&amp; afr)</span><br><s=
pan>     {</span><br><span>         ads-&gt;auth_control_file =3D string_al=
loc(acf, NULL);</span><br><span>         ads-&gt;auth_pending_file =3D stri=
ng_alloc(apf, NULL);</span><br><span>@@ -1004,7 +1004,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return (acf &amp;&amp; apf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (acf &amp=
;&amp; apf &amp;&amp; afr);</span><br><span> }</span><br><span> </span><br>=
<span> /**</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail">change 1327</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I94d2bdd234a1c416b78924d044b=
f7e57f1bed8c4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1327 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--or1Est+nOSc=--

