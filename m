From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 20:55:50 +0000
In-Reply-To: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
References: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4974d7d942c1e905ebdddd172a384b15c65a4c1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UlELkA0tc9c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clean up environment
 variable handling in verify_user_pass_script
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

--UlELkA0tc9c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: clean up environment variable handling in verify_user_pass_=
script
......................................................................

clean up environment variable handling in verify_user_pass_script

The username environment variable is already set by the
set_verify_user_pass_env function before the verify_user_pass_script
function is called, so this call is not doing anything but might erroneously
made people think that this needs to be cleaned up.

Also ensure that the password is clean from the env even in an error case.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1326
Message-Id: <20251030194402.1729-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
069.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify.c
1 file changed, 6 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1326/2

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..993d22c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1329,7 +1329,7 @@
     }
     else
     {
-        setenv_str(session->opt->es, "username", up->username);
+        /* username env is already set by set_verify_user_pass_env */
         setenv_str(session->opt->es, "password", up->password);
     }

@@ -1377,10 +1377,6 @@
         /* purge auth control filename (and file itself) for non-deferred =
returns */
         key_state_rm_auth_control_files(&ks->script_auth);
     }
-    if (!session->opt->auth_user_pass_verify_script_via_file)
-    {
-        setenv_del(session->opt->es, "password");
-    }

 done:
     if (tmp_file && strlen(tmp_file) > 0)
@@ -1389,6 +1385,11 @@
     }

 error:
+    if (!session->opt->auth_user_pass_verify_script_via_file)
+    {
+        setenv_del(session->opt->es, "password");
+    }
+
     argv_free(&argv);
     gc_free(&gc);
     return retval;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
Gerrit-Change-Number: 1326
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UlELkA0tc9c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">clean up environment variable handl=
ing in verify_user_pass_script<br><br>The username environment variable is =
already set by the<br>set_verify_user_pass_env function before the verify_u=
ser_pass_script<br>function is called, so this call is not doing anything b=
ut might erroneously<br>made people think that this needs to be cleaned up.=
<br><br>Also ensure that the password is clean from the env even in an erro=
r case.<br><br>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Fou=
nd-by: ZeroPath (https://zeropath.com/)<br>Change-Id: I6c502508026c6b85bb09=
2ada4d16d985b20dd41f<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...2068...=
7...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1326<br>Message-Id: &lt;2025103019440=
2.1729-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg34069.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed=
, 6 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/26/1326/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>i=
ndex 04ef27e..993d22c 100644</span><br><span>--- a/src/openvpn/ssl_verify.c=
</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -1329,7 =
+1329,7 @@</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv=
_str(session-&gt;opt-&gt;es, &quot;username&quot;, up-&gt;username);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* username env is=
 already set by set_verify_user_pass_env */</span><br><span>         setenv=
_str(session-&gt;opt-&gt;es, &quot;password&quot;, up-&gt;password);</span>=
<br><span>     }</span><br><span> </span><br><span>@@ -1377,10 +1377,6 @@</=
span><br><span>         /* purge auth control filename (and file itself) fo=
r non-deferred returns */</span><br><span>         key_state_rm_auth_contro=
l_files(&amp;ks-&gt;script_auth);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!session-&gt;opt-&gt;auth_user_p=
ass_verify_script_via_file)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        se=
tenv_del(session-&gt;opt-&gt;es, &quot;password&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span> =
done:</span><br><span>     if (tmp_file &amp;&amp; strlen(tmp_file) &gt; 0)=
</span><br><span>@@ -1389,6 +1385,11 @@</span><br><span>     }</span><br><s=
pan> </span><br><span> error:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!session-&gt;opt-&gt;auth_user_pass_verify_script_via_fil=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        setenv_del(session-&gt;=
opt-&gt;es, &quot;password&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&=
amp;gc);</span><br><span>     return retval;</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?=
usp=3Demail">change 1326</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c502508026c6b85bb092ada4d1=
6d985b20dd41f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1326 </div>
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

--UlELkA0tc9c=--

