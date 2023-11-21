From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 13:01:51 +0000
In-Reply-To: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <03562f640fe2b84af44bc921dbc1e7685647c83d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3rGZoqZizqo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove
 unused/uneeded defines from configure and cmake config
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

--3rGZoqZizqo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail

to look at the new patch set (#3).


Change subject: Remove unused/uneeded defines from configure and cmake conf=
ig
......................................................................

Remove unused/uneeded defines from configure and cmake config

Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
---
M config.h.cmake.in
M configure.ac
2 files changed, 1 insertion(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/443/3

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..85f5fa5 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -139,9 +139,6 @@
 /* Define to 1 if you have the `getpwnam' function. */
 #cmakedefine HAVE_GETPWNAM

-/* Define to 1 if you have the `getrlimit' function. */
-#undef HAVE_GETRLIMIT
-
 /* Define to 1 if you have the `getsockname' function. */
 #cmakedefine HAVE_GETSOCKNAME

@@ -235,8 +232,6 @@
 /* Define to 1 if you have the <pwd.h> header file. */
 #cmakedefine HAVE_PWD_H

-/* Define to 1 if you have the `readv' function. */
-#undef HAVE_READV

 /* Define to 1 if you have the `recvmsg' function. */
 #cmakedefine HAVE_RECVMSG
@@ -383,9 +378,6 @@
 /* Define to 1 if you have the <vfork.h> header file. */
 #undef HAVE_VFORK_H

-/* Define to 1 if you have the `vsnprintf' function. */
-#undef HAVE_VSNPRINTF
-
 /* we always assume a recent mbed TLS version */
 #define HAVE_MBEDTLS_PSA_CRYPTO_H 1
 #define HAVE_MBEDTLS_SSL_TLS_PRF 1
diff --git a/configure.ac b/configure.ac
index 84eaad6..141acc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -655,7 +655,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock readv writev time gettimeofday \
+	setgroups flock time gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Gerrit-Change-Number: 443
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--3rGZoqZizqo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove unused/uneeded defines from configure and cmake config<br><br>=
Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021<br>---<br>M config.h.c=
make.in<br>M configure.ac<br>2 files changed, 1 insertion(+), 9 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43=
/443/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br=
><span>index 19b79bc..85f5fa5 100644</span><br><span>--- a/config.h.cmake.i=
n</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -139,9 +139,6 =
@@</span><br><span> /* Define to 1 if you have the `getpwnam&#39; function.=
 */</span><br><span> #cmakedefine HAVE_GETPWNAM</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the =
`getrlimit&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#undef HAVE_GETRLIMIT</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /* Define to 1 if you have the `getsockname&#39; f=
unction. */</span><br><span> #cmakedefine HAVE_GETSOCKNAME</span><br><span>=
 </span><br><span>@@ -235,8 +232,6 @@</span><br><span> /* Define to 1 if yo=
u have the &lt;pwd.h&gt; header file. */</span><br><span> #cmakedefine HAVE=
_PWD_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* Define to 1 if you have the `readv&#39; function. */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_READV</span><br><span> </s=
pan><br><span> /* Define to 1 if you have the `recvmsg&#39; function. */</s=
pan><br><span> #cmakedefine HAVE_RECVMSG</span><br><span>@@ -383,9 +378,6 @=
@</span><br><span> /* Define to 1 if you have the &lt;vfork.h&gt; header fi=
le. */</span><br><span> #undef HAVE_VFORK_H</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `vsn=
printf&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#undef HAVE_VSNPRINTF</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> /* we always assume a recent mbed TLS version */</span=
><br><span> #define HAVE_MBEDTLS_PSA_CRYPTO_H 1</span><br><span> #define HA=
VE_MBEDTLS_SSL_TLS_PRF 1</span><br><span>diff --git a/configure.ac b/config=
ure.ac</span><br><span>index 84eaad6..141acc6 100644</span><br><span>--- a/=
configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -655,7 +=
655,7 @@</span><br><span> AC_CHECK_FUNCS([ \</span><br><span> 	daemon chroo=
t getpwnam setuid nice system dup dup2 \</span><br><span> 	syslog openlog m=
lockall getrlimit getgrnam setgid \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	setgroups flock readv writev time gettimeofday \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	setgroups flock time gettimeof=
day \</span><br><span> 	setsid chdir \</span><br><span> 	chsize ftruncate e=
xecve getpeereid basename dirname access \</span><br><span> 	epoll_create s=
trsep \</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">change 443</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/443?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf=
7ed29faef0021 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3rGZoqZizqo=--

