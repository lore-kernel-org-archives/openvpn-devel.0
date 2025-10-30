From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 20:55:53 +0000
In-Reply-To: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
References: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4974d7d942c1e905ebdddd172a384b15c65a4c1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PZdwOLyhGvc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PZdwOLyhGvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
26?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
Gerrit-Change-Number: 1326
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PZdwOLyhGvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1326?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">clean up environment variable handling in verify=
_user_pass_script<br><br>The username environment variable is already set b=
y the<br>set_verify_user_pass_env function before the verify_user_pass_scri=
pt<br>function is called, so this call is not doing anything but might erro=
neously<br>made people think that this needs to be cleaned up.<br><br>Also =
ensure that the password is clean from the env even in an error case.<br><b=
r>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPa=
th (https://zeropath.com/)<br>Change-Id: I6c502508026c6b85bb092ada4d16d985b=
20dd41f<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1326<br>Message-Id: &lt;20251030194402.1729-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg34069.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 6 insertion=
s(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><=
br><span>index 04ef27e..993d22c 100644</span><br><span>--- a/src/openvpn/ss=
l_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@=
@ -1329,7 +1329,7 @@</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    setenv_str(session-&gt;opt-&gt;es, &quot;username&quot;, up-&gt;usernam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* usern=
ame env is already set by set_verify_user_pass_env */</span><br><span>     =
    setenv_str(session-&gt;opt-&gt;es, &quot;password&quot;, up-&gt;passwor=
d);</span><br><span>     }</span><br><span> </span><br><span>@@ -1377,10 +1=
377,6 @@</span><br><span>         /* purge auth control filename (and file =
itself) for non-deferred returns */</span><br><span>         key_state_rm_a=
uth_control_files(&amp;ks-&gt;script_auth);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!session-&gt;opt-&gt;a=
uth_user_pass_verify_script_via_file)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        setenv_del(session-&gt;opt-&gt;es, &quot;password&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><=
br><span> done:</span><br><span>     if (tmp_file &amp;&amp; strlen(tmp_fil=
e) &gt; 0)</span><br><span>@@ -1389,6 +1385,11 @@</span><br><span>     }</s=
pan><br><span> </span><br><span> error:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!session-&gt;opt-&gt;auth_user_pass_verify_scri=
pt_via_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_del(se=
ssion-&gt;opt-&gt;es, &quot;password&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     argv_free(&amp;argv);</span><br><span>    =
 gc_free(&amp;gc);</span><br><span>     return retval;</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1326?usp=3Demail">change 1326</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1326?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--PZdwOLyhGvc=--

