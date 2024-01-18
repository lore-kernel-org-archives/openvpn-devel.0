From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jan 2024 17:49:30 +0000
In-Reply-To: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
References: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e5cd7236c43f198fb11d27e6bcc1c828ac96ae10-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZKOtkm4vW3E="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZKOtkm4vW3E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/49=
8?usp=3Demail )

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
Gerrit-MessageType: merged

--ZKOtkm4vW3E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/498?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">proxy-options.rst: Add proper documentation fo=
r --http-proxy-user-pass<br><br>And extend examples section for authenticat=
ed HTTP proxies because<br>is was misleading.<br><br>Change-Id: I7a754d0b4a=
76a9227bf922f65176cd9ec4d7670c<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messa=
ge-Id: &lt;20240118164903.22519-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg28083.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/=
proxy-options.rst<br>1 file changed, 32 insertions(+), 3 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy=
-options.rst</span><br><span>index 9cf311f..ad49c60 100644</span><br><span>=
--- a/doc/man-sections/proxy-options.rst</span><br><span>+++ b/doc/man-sect=
ions/proxy-options.rst</span><br><span>@@ -4,7 +4,7 @@</span><br><span>   i=
s required, a file name to an ``authfile`` file containing a username</span=
><br><span>   and password on 2 lines can be given, or :code:`stdin` to pro=
mpt from</span><br><span>   console. Its content can also be specified in t=
he config file with the</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ``--http-proxy-user-pass`` option. (See section on inline files)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--http-proxy-user-pass=
`` option (See `INLINE FILE SUPPORT`_).</span><br><span> </span><br><span> =
  The last optional argument is an ``auth-method`` which should be one</spa=
n><br><span>   of :code:`none`, :code:`basic`, or :code:`ntlm2`.</span><br>=
<span>@@ -25,14 +25,43 @@</span><br><span>   Examples:</span><br><span>   :=
:</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     # no authentication</span><br><span>      http-proxy proxy.example.net=
 3128</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # basic a=
uthentication, load credentials from file</span><br><span>      http-proxy =
proxy.example.net 3128 authfile.txt</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     # basic authentication, ask user for credentials</span=
><br><span>      http-proxy proxy.example.net 3128 stdin</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     http-proxy proxy.example.net 3128 a=
uto basic</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     http-pr=
oxy proxy.example.net 3128 auto-nct ntlm2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     # NTLM authentication, load credentials from fil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     http-proxy pr=
oxy.example.net 3128 authfile.txt ntlm2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     # determine which authentication is required, ask =
user for credentials</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     http-proxy proxy.example.net 3128 auto</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     # determine which authentication is required,=
 but reject basic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   http-proxy proxy.example.net 3128 auto-nct</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     # determine which authentication is required=
, but set credentials</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     http-proxy proxy.example.net 3128 auto</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     http-proxy-user-pass authfile.txt</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     # basic authentication, s=
pecify credentials inline</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     http-proxy proxy.example.net 3128 &quot;&quot; basic</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     &lt;http-proxy-user-pass&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     username</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     password</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     &lt;/http-proxy-user-pas=
s&gt;</span><br><span> </span><br><span>   Note that support for NTLMv1 pro=
xies was removed with OpenVPN 2.7.</span><br><span> </span><br><span style=
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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZKOtkm4vW3E=--

