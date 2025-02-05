From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 16:45:21 +0000
References: <gerrit.1738773918000.I59e34058d6e0611208767fbcf39d1b91784ebcf9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <701d4304c821bc82bc8c6d170c54ca7fedeb5e20-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zfelxF1Bpf0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: add missing (void)
 to win32 function declarations
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

--zfelxF1Bpf0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/886?usp=3Demail

to review the following change.


Change subject: add missing (void) to win32 function declarations
......................................................................

add missing (void) to win32 function declarations

mingw complains about "old-style function definition" and since we
use explicit (void) everyhwere else...

Change-Id: I59e34058d6e0611208767fbcf39d1b91784ebcf9
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
M src/openvpn/error.c
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/886/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 46b2d03..62d7109 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -502,7 +502,7 @@
 }

 const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     /*
      * this API can be called either from user mode or kernel mode,
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ec65d5e..d5bb802 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -505,7 +505,7 @@
 static int orig_stderr;

 int
-get_orig_stderr()
+get_orig_stderr(void)
 {
     return orig_stderr ? orig_stderr : _fileno(stderr);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/886?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59e34058d6e0611208767fbcf39d1b91784ebcf9
Gerrit-Change-Number: 886
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--zfelxF1Bpf0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/886?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">add missing (void) to win32 function declarations<br><br>ming=
w complains about &quot;old-style function definition&quot; and since we<br=
>use explicit (void) everyhwere else...<br><br>Change-Id: I59e34058d6e06112=
08767fbcf39d1b91784ebcf9<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/dco_win.c<br>M src/openvpn/error.c<br>2 files =
changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/86/886/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 46b2d03..62d710=
9 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/=
src/openvpn/dco_win.c</span><br><span>@@ -502,7 +502,7 @@</span><br><span> =
}</span><br><span> </span><br><span> const char *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-dco_get_supported_ciphers()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><=
br><span> {</span><br><span>     /*</span><br><span>      * this API can be=
 called either from user mode or kernel mode,</span><br><span>diff --git a/=
src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index ec65d5e..d5=
bb802 100644</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++ =
b/src/openvpn/error.c</span><br><span>@@ -505,7 +505,7 @@</span><br><span> =
static int orig_stderr;</span><br><span> </span><br><span> int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-get_orig_stderr()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+get_orig_stderr(void)</span><br><spa=
n> {</span><br><span>     return orig_stderr ? orig_stderr : _fileno(stderr=
);</span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/886?usp=3Demail">change 886<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/886?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59e34058d6e0611208767fbcf39=
d1b91784ebcf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 886 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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


--zfelxF1Bpf0=--

