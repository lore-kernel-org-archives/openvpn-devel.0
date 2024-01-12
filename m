From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 14:14:07 +0000
References: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a42b41a5152820deb8665e21cf723ce39378c935-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cra83WZlAvI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Cra83WZlAvI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail

to review the following change.


Change subject: proxy-options.rst: Add proper documentation for --http-prox=
y-user-pass
......................................................................

proxy-options.rst: Add proper documentation for --http-proxy-user-pass

And extend examples section for authenticated HTTP proxies because
is was misleading.

Change-Id: I7a754d0b4a76a9227bf922f65176cd9ec4d7670c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/proxy-options.rst
1 file changed, 32 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/498/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Cra83WZlAvI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/498?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">proxy-options.rst: Add proper documentation for --http-proxy-=
user-pass<br><br>And extend examples section for authenticated HTTP proxies=
 because<br>is was misleading.<br><br>Change-Id: I7a754d0b4a76a9227bf922f65=
176cd9ec4d7670c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M doc/man-sections/proxy-options.rst<br>1 file changed, 32 inse=
rtions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/98/498/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/proxy-=
options.rst b/doc/man-sections/proxy-options.rst</span><br><span>index 9cf3=
11f..ad49c60 100644</span><br><span>--- a/doc/man-sections/proxy-options.rs=
t</span><br><span>+++ b/doc/man-sections/proxy-options.rst</span><br><span>=
@@ -4,7 +4,7 @@</span><br><span>   is required, a file name to an ``authfil=
e`` file containing a username</span><br><span>   and password on 2 lines c=
an be given, or :code:`stdin` to prompt from</span><br><span>   console. It=
s content can also be specified in the config file with the</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  ``--http-proxy-user-pass`` option. =
(See section on inline files)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``--http-proxy-user-pass`` option (See `INLINE FILE SUPPORT`_).=
</span><br><span> </span><br><span>   The last optional argument is an ``au=
th-method`` which should be one</span><br><span>   of :code:`none`, :code:`=
basic`, or :code:`ntlm2`.</span><br><span>@@ -25,14 +25,43 @@</span><br><sp=
an>   Examples:</span><br><span>   ::</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     # no authentication</span><br><spa=
n>      http-proxy proxy.example.net 3128</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     # basic authentication, load credentials from fi=
le</span><br><span>      http-proxy proxy.example.net 3128 authfile.txt</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     # basic authentica=
tion, ask user for credentials</span><br><span>      http-proxy proxy.examp=
le.net 3128 stdin</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 http-proxy proxy.example.net 3128 auto basic</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     http-proxy proxy.example.net 3128 auto-nct ntl=
m2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # NTLM authe=
ntication, load credentials from file</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     http-proxy proxy.example.net 3128 authfile.txt ntlm2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # determine wh=
ich authentication is required, ask user for credentials</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     http-proxy proxy.example.net 3128=
 auto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # determi=
ne which authentication is required, but reject basic</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     http-proxy proxy.example.net 3128 au=
to-nct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # determ=
ine which authentication is required, but set credentials</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     http-proxy proxy.example.net 312=
8 auto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     http-pro=
xy-user-pass authfile.txt</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     # basic authentication, specify credentials inline</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     http-proxy proxy.example.net=
 3128 &quot;&quot; basic</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     &lt;http-proxy-user-pass&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     username</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     password</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     &lt;/http-proxy-user-pass&gt;</span><br><span> </span><br><span=
>   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--http=
-proxy-user-pass userpass</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Overwrite the username/password information for ``--http-proxy``. I=
f specified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as an =
inline option (see `INLINE FILE SUPPORT`_), it will be interpreted as</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  username/password separ=
ated by a newline. When specified on the command line</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  it is interpreted as a filename same as=
 the third argument to ``--http-proxy``.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  Example::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;http-proxy-user-p=
ass&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    username=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    password</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;/http-proxy-user-p=
ass&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> --http-proxy-option args</span><br><span>   Set extended HTTP proxy o=
ptions. Requires an option ``type`` as argument</span><br><span>   and an o=
ptional ``parameter`` to the type.  Repeat to set multiple</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/498?usp=3Demail">change 498</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/498?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a754d0b4a76a9227bf922f6517=
6cd9ec4d7670c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 498 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Cra83WZlAvI=--

