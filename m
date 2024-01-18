From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jan 2024 17:49:29 +0000
In-Reply-To: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
References: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e5cd7236c43f198fb11d27e6bcc1c828ac96ae10-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q63eP7ipc1s="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: proxy-options.rst:
 Add proper documentation for --http-proxy-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q63eP7ipc1s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: proxy-options.rst: Add proper documentation for --http-prox=
y-user-pass
......................................................................

proxy-options.rst: Add proper documentation for --http-proxy-user-pass

And extend examples section for authenticated HTTP proxies because
is was misleading.

Change-Id: I7a754d0b4a76a9227bf922f65176cd9ec4d7670c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240118164903.22519-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
083.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/proxy-options.rst
1 file changed, 32 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/498/2

diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-op=
tions.rst
index 9cf311f..ad49c60 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -4,7 +4,7 @@
   is required, a file name to an ``authfile`` file containing a username
   and password on 2 lines can be given, or :code:`stdin` to prompt from
   console. Its content can also be specified in the config file with the
-  ``--http-proxy-user-pass`` option. (See section on inline files)
+  ``--http-proxy-user-pass`` option (See `INLINE FILE SUPPORT`_).

   The last optional argument is an ``auth-method`` which should be one
   of :code:`none`, :code:`basic`, or :code:`ntlm2`.
@@ -25,14 +25,43 @@
   Examples:
   ::

+     # no authentication
      http-proxy proxy.example.net 3128
+     # basic authentication, load credentials from file
      http-proxy proxy.example.net 3128 authfile.txt
+     # basic authentication, ask user for credentials
      http-proxy proxy.example.net 3128 stdin
-     http-proxy proxy.example.net 3128 auto basic
-     http-proxy proxy.example.net 3128 auto-nct ntlm2
+     # NTLM authentication, load credentials from file
+     http-proxy proxy.example.net 3128 authfile.txt ntlm2
+     # determine which authentication is required, ask user for credentials
+     http-proxy proxy.example.net 3128 auto
+     # determine which authentication is required, but reject basic
+     http-proxy proxy.example.net 3128 auto-nct
+     # determine which authentication is required, but set credentials
+     http-proxy proxy.example.net 3128 auto
+     http-proxy-user-pass authfile.txt
+     # basic authentication, specify credentials inline
+     http-proxy proxy.example.net 3128 "" basic
+     <http-proxy-user-pass>
+     username
+     password
+     </http-proxy-user-pass>

   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.

+--http-proxy-user-pass userpass
+  Overwrite the username/password information for ``--http-proxy``. If spe=
cified
+  as an inline option (see `INLINE FILE SUPPORT`_), it will be interpreted=
 as
+  username/password separated by a newline. When specified on the command =
line
+  it is interpreted as a filename same as the third argument to ``--http-p=
roxy``.
+
+  Example::
+
+    <http-proxy-user-pass>
+    username
+    password
+    </http-proxy-user-pass>
+
 --http-proxy-option args
   Set extended HTTP proxy options. Requires an option ``type`` as argument
   and an optional ``parameter`` to the type.  Repeat to set multiple

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7a754d0b4a76a9227bf922f65176cd9ec4d7670c
Gerrit-Change-Number: 498
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Q63eP7ipc1s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/498?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">proxy-options.rst: Add proper documentation for --ht=
tp-proxy-user-pass<br><br>And extend examples section for authenticated HTT=
P proxies because<br>is was misleading.<br><br>Change-Id: I7a754d0b4a76a922=
7bf922f65176cd9ec4d7670c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id:=
 &lt;20240118164903.22519-1-gert@...1296...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg28083.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/proxy-=
options.rst<br>1 file changed, 32 insertions(+), 3 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/498/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-=
options.rst</span><br><span>index 9cf311f..ad49c60 100644</span><br><span>-=
-- a/doc/man-sections/proxy-options.rst</span><br><span>+++ b/doc/man-secti=
ons/proxy-options.rst</span><br><span>@@ -4,7 +4,7 @@</span><br><span>   is=
 required, a file name to an ``authfile`` file containing a username</span>=
<br><span>   and password on 2 lines can be given, or :code:`stdin` to prom=
pt from</span><br><span>   console. Its content can also be specified in th=
e config file with the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  ``--http-proxy-user-pass`` option. (See section on inline files)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--http-proxy-user-pass`=
` option (See `INLINE FILE SUPPORT`_).</span><br><span> </span><br><span>  =
 The last optional argument is an ``auth-method`` which should be one</span=
><br><span>   of :code:`none`, :code:`basic`, or :code:`ntlm2`.</span><br><=
span>@@ -25,14 +25,43 @@</span><br><span>   Examples:</span><br><span>   ::=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    # no authentication</span><br><span>      http-proxy proxy.example.net =
3128</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # basic au=
thentication, load credentials from file</span><br><span>      http-proxy p=
roxy.example.net 3128 authfile.txt</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     # basic authentication, ask user for credentials</span>=
<br><span>      http-proxy proxy.example.net 3128 stdin</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     http-proxy proxy.example.net 3128 au=
to basic</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     http-pro=
xy proxy.example.net 3128 auto-nct ntlm2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     # NTLM authentication, load credentials from file=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     http-proxy pro=
xy.example.net 3128 authfile.txt ntlm2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     # determine which authentication is required, ask u=
ser for credentials</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     http-proxy proxy.example.net 3128 auto</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     # determine which authentication is required, =
but reject basic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  http-proxy proxy.example.net 3128 auto-nct</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     # determine which authentication is required,=
 but set credentials</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     http-proxy proxy.example.net 3128 auto</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     http-proxy-user-pass authfile.txt</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     # basic authentication, sp=
ecify credentials inline</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     http-proxy proxy.example.net 3128 &quot;&quot; basic</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     &lt;http-proxy-user-pass&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     username</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     password</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     &lt;/http-proxy-user-pass=
&gt;</span><br><span> </span><br><span>   Note that support for NTLMv1 prox=
ies was removed with OpenVPN 2.7.</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+--http-proxy-user-pass userpass</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Overwrite the username/pass=
word information for ``--http-proxy``. If specified</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  as an inline option (see `INLINE FILE S=
UPPORT`_), it will be interpreted as</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  username/password separated by a newline. When specified=
 on the command line</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  it is interpreted as a filename same as the third argument to ``--http-p=
roxy``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Example::</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;http-proxy-user-pass&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    username</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    password</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;/http-proxy-user-pass&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> --http-proxy-option args</s=
pan><br><span>   Set extended HTTP proxy options. Requires an option ``type=
`` as argument</span><br><span>   and an optional ``parameter`` to the type=
.  Repeat to set multiple</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail">change =
498</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a754d0b4a76a9227bf922f6517=
6cd9ec4d7670c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 498 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Q63eP7ipc1s=--

