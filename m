From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 20:58:37 +0000
In-Reply-To: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
References: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0255953b50c2714d660ce071e9b6c69fdd38f36e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Oakm+H1rpss="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Oakm+H1rpss=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1327/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I94d2bdd234a1c416b78924d044bf7e57f1bed8c4
Gerrit-Change-Number: 1327
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Oakm+H1rpss=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">fix key_state_gen_auth_control_file=
s probably checking file creation<br><br>When the auth_failed_reason_file w=
as added, it was forgotten to also add it<br>to the conditions that determi=
ne if the file creation was successful.<br><br>Reported-by: Joshua Rogers &=
lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)<br>=
Change-Id: I94d2bdd234a1c416b78924d044bf7e57f1bed8c4<br>Signed-off-by: Arne=
 Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327<br>Messa=
ge-Id: &lt;20251030193940.1295-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg34067.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_ve=
rify.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1=
327/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verif=
y.c</span><br><span>index 993d22c..a16f5fa 100644</span><br><span>--- a/src=
/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span>=
<br><span>@@ -992,7 +992,7 @@</span><br><span>     const char *apf =3D plat=
form_create_temp_file(opt-&gt;tmp_dir, &quot;apf&quot;, &amp;gc);</span><br=
><span>     const char *afr =3D platform_create_temp_file(opt-&gt;tmp_dir, =
&quot;afr&quot;, &amp;gc);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (acf &amp;&amp; apf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (acf &amp;&amp; apf &amp;&amp; afr)</=
span><br><span>     {</span><br><span>         ads-&gt;auth_control_file =
=3D string_alloc(acf, NULL);</span><br><span>         ads-&gt;auth_pending_=
file =3D string_alloc(apf, NULL);</span><br><span>@@ -1004,7 +1004,7 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (acf &amp=
;&amp; apf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn (acf &amp;&amp; apf &amp;&amp; afr);</span><br><span> }</span><br><span=
> </span><br><span> /**</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail">change 1=
327</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1327?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--Oakm+H1rpss=--

