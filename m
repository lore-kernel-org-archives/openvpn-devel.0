From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 9 Jan 2026 15:57:07 +0000
References: <gerrit.1767974222000.Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4f8d8e179c07090395c0d05818af2393089b7ddd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ai2nHVSDwBw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure.ac: Clean
 up systemd support
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

--Ai2nHVSDwBw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1463?usp=3Demail

to review the following change.


Change subject: configure.ac: Clean up systemd support
......................................................................

configure.ac: Clean up systemd support

- Do not try to handle very old systemd that was released
  over ten years ago (remove SYSTEMD_NEWER_THAN_216)
- Do not require systemd.pc. I can't find any indication
  that we use any of the variables defined by it. (It
  does not define any libraries, just variables)
- Remove check for sd-daemon.h. We did not use the
  conditional and assumed it was there already.
- Allow libsystemd.pc to define cflags. Previously we
  ignored those.

Change-Id: Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/Makefile.am
M src/openvpn/console_systemd.c
M src/openvpn/init.c
5 files changed, 7 insertions(+), 28 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1463/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 01bbadc..53976a7 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -284,9 +284,6 @@
 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H

-/* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
-#undef HAVE_SYSTEMD_SD_DAEMON_H
-
 /* Define to 1 if you have the <sys/epoll.h> header file. */
 #cmakedefine HAVE_SYS_EPOLL_H

@@ -374,9 +371,6 @@
 /* Path to systemd-ask-password tool */
 #undef SYSTEMD_ASK_PASSWORD_PATH

-/* systemd is newer than v216 */
-#define SYSTEMD_NEWER_THAN_216
-
 /* The tap-windows id */
 #define TAP_WIN_COMPONENT_ID "tap0901"

diff --git a/configure.ac b/configure.ac
index 8ba5673..63d4d6e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1139,28 +1139,14 @@
 dnl
 AM_CONDITIONAL([ENABLE_SYSTEMD], [test "${enable_systemd}" =3D "yes"])
 if test "$enable_systemd" =3D "yes" ; then
-    PKG_CHECK_MODULES([libsystemd], [systemd libsystemd],
+    PKG_CHECK_MODULES([libsystemd], [libsystemd > 216],
                       [],
-                      [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon]=
)]
+                      [AC_MSG_ERROR([systemd enabled but libsystemd is mis=
sing])]
                       )

-    PKG_CHECK_EXISTS([libsystemd > 216],
-                     [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
-                           [systemd is newer than v216])]
-                    )
-
-    AC_CHECK_HEADERS(systemd/sd-daemon.h,
-       ,
-       [
-	   AC_MSG_ERROR([systemd development headers not found.])
-       ])
-
-    saved_LIBS=3D"${LIBS}"
-    LIBS=3D"${LIBS} ${libsystemd_LIBS}"
-    AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is miss=
ing sd_booted()])])
+    OPTIONAL_SYSTEMD_CFLAGS=3D"${libsystemd_CFLAGS}"
     OPTIONAL_SYSTEMD_LIBS=3D"${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
-    LIBS=3D"${saved_LIBS}"

     if test -n "${SYSTEMD_UNIT_DIR}"; then
         systemdunitdir=3D"${SYSTEMD_UNIT_DIR}"
@@ -1377,6 +1363,7 @@
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
 AC_SUBST([OPTIONAL_LZ4_LIBS])
+AC_SUBST([OPTIONAL_SYSTEMD_CFLAGS])
 AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 19c21c0f..c879585 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -28,6 +28,7 @@
 	$(OPTIONAL_LIBNL_GENL_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
+	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
 	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index d277bd4..9588b95 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -61,13 +61,10 @@
     struct argv argv =3D argv_new();

     argv_printf(&argv, SYSTEMD_ASK_PASSWORD_PATH);
-#ifdef SYSTEMD_NEWER_THAN_216
-    /* the --echo support arrived in upstream systemd 217 */
     if (echo)
     {
         argv_printf_cat(&argv, "--echo");
     }
-#endif
     argv_printf_cat(&argv, "--icon network-vpn");
     argv_printf_cat(&argv, "--timeout=3D0");
     argv_printf_cat(&argv, "%s", prompt);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c014a91..b690dff 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1545,7 +1545,7 @@
 #else
 #ifdef ENABLE_SYSTEMD
         sd_notifyf(0, "STATUS=3DFailed to start up: %s With Errors\nERRNO=
=3D1", message);
-#endif /* HAVE_SYSTEMD_SD_DAEMON_H */
+#endif
         msg(M_INFO, "%s With Errors", message);
 #endif
     }
@@ -5052,4 +5052,4 @@
     packet_id_free(&c->c2.crypto_options.packet_id);

     context_gc_free(c);
-}
\ No newline at end of file
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1463?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc
Gerrit-Change-Number: 1463
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Ai2nHVSDwBw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1463?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure.ac: Clean up systemd support<br><=
br>- Do not try to handle very old systemd that was released<br>  over ten =
years ago (remove SYSTEMD_NEWER_THAN_216)<br>- Do not require systemd.pc. I=
 can&#39;t find any indication<br>  that we use any of the variables define=
d by it. (It<br>  does not define any libraries, just variables)<br>- Remov=
e check for sd-daemon.h. We did not use the<br>  conditional and assumed it=
 was there already.<br>- Allow libsystemd.pc to define cflags. Previously w=
e<br>  ignored those.<br><br>Change-Id: Ie59e03ce01575acaeaf690f582eb5cfa80=
eb37fc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M config.h.cmake.in<br>M configure.ac<br>M src/openvpn/Makefile.am<br>M =
src/openvpn/console_systemd.c<br>M src/openvpn/init.c<br>5 files changed, 7=
 insertions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/63/1463/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/config.h.cmake.in b/config.h.cmake.in</span><br><span>index 01bbadc..53976=
a7 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/con=
fig.h.cmake.in</span><br><span>@@ -284,9 +284,6 @@</span><br><span> /* Defi=
ne to 1 if you have the &lt;syslog.h&gt; header file. */</span><br><span> #=
cmakedefine HAVE_SYSLOG_H</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;systemd/sd-daemon.=
h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#undef HAVE_SYSTEMD_SD_DAEMON_H</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;sys/epoll.h&=
gt; header file. */</span><br><span> #cmakedefine HAVE_SYS_EPOLL_H</span><b=
r><span> </span><br><span>@@ -374,9 +371,6 @@</span><br><span> /* Path to s=
ystemd-ask-password tool */</span><br><span> #undef SYSTEMD_ASK_PASSWORD_PA=
TH</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* systemd is newer than v216 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define SYSTEMD_NEWER_THAN_216</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /* The tap-windows id */</span><br><sp=
an> #define TAP_WIN_COMPONENT_ID &quot;tap0901&quot;</span><br><span> </spa=
n><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index =
8ba5673..63d4d6e 100644</span><br><span>--- a/configure.ac</span><br><span>=
+++ b/configure.ac</span><br><span>@@ -1139,28 +1139,14 @@</span><br><span>=
 dnl</span><br><span> AM_CONDITIONAL([ENABLE_SYSTEMD], [test &quot;${enable=
_systemd}&quot; =3D &quot;yes&quot;])</span><br><span> if test &quot;$enabl=
e_systemd&quot; =3D &quot;yes&quot; ; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    PKG_CHECK_MODULES([libsystemd], [systemd libsystem=
d],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PKG_CHECK_MO=
DULES([libsystemd], [libsystemd &gt; 216],</span><br><span>                =
       [],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
           [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      [AC_MSG=
_ERROR([systemd enabled but libsystemd is missing])]</span><br><span>      =
                 )</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    PKG_CHECK_EXISTS([libsystemd &gt; 216],</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                     [AC_DEFINE([SYSTE=
MD_NEWER_THAN_216], [1],</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                           [systemd is newer than v216])]</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    )</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    AC_CHECK_HEADERS(systemd/sd-daemon.h,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-       ,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-       [</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	   AC_MSG_ERROR([systemd development headers not found.])</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-       ])</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    saved_LIBS=3D&quot;${LIBS}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LIBS=3D&quot;${LIBS} ${libsystemd_LIBS}=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AC_CHECK_FU=
NCS([sd_booted], [], [AC_MSG_ERROR([systemd library is missing sd_booted()]=
)])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPTIONAL_SYS=
TEMD_CFLAGS=3D&quot;${libsystemd_CFLAGS}&quot;</span><br><span>     OPTIONA=
L_SYSTEMD_LIBS=3D&quot;${libsystemd_LIBS}&quot;</span><br><span>     AC_DEF=
INE(ENABLE_SYSTEMD, 1, [Enable systemd integration])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LIBS=3D&quot;${saved_LIBS}&quot;</span>=
<br><span> </span><br><span>     if test -n &quot;${SYSTEMD_UNIT_DIR}&quot;=
; then</span><br><span>         systemdunitdir=3D&quot;${SYSTEMD_UNIT_DIR}&=
quot;</span><br><span>@@ -1377,6 +1363,7 @@</span><br><span> AC_SUBST([OPTI=
ONAL_LZO_LIBS])</span><br><span> AC_SUBST([OPTIONAL_LZ4_CFLAGS])</span><br>=
<span> AC_SUBST([OPTIONAL_LZ4_LIBS])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+AC_SUBST([OPTIONAL_SYSTEMD_CFLAGS])</span><br><span> AC_SU=
BST([OPTIONAL_SYSTEMD_LIBS])</span><br><span> AC_SUBST([OPTIONAL_PKCS11_HEL=
PER_CFLAGS])</span><br><span> AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])</span=
><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</=
span><br><span>index 19c21c0f..c879585 100644</span><br><span>--- a/src/ope=
nvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><s=
pan>@@ -28,6 +28,7 @@</span><br><span> 	$(OPTIONAL_LIBNL_GENL_CFLAGS) \</sp=
an><br><span> 	$(OPTIONAL_LZO_CFLAGS) \</span><br><span> 	$(OPTIONAL_LZ4_CF=
LAGS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_=
SYSTEMD_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</spa=
n><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span> 	-DPLUGIN_LIBDI=
R=3D\&quot;${plugindir}\&quot; \</span><br><span>diff --git a/src/openvpn/c=
onsole_systemd.c b/src/openvpn/console_systemd.c</span><br><span>index d277=
bd4..9588b95 100644</span><br><span>--- a/src/openvpn/console_systemd.c</sp=
an><br><span>+++ b/src/openvpn/console_systemd.c</span><br><span>@@ -61,13 =
+61,10 @@</span><br><span>     struct argv argv =3D argv_new();</span><br><=
span> </span><br><span>     argv_printf(&amp;argv, SYSTEMD_ASK_PASSWORD_PAT=
H);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SYSTEMD_NEW=
ER_THAN_216</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* the=
 --echo support arrived in upstream systemd 217 */</span><br><span>     if =
(echo)</span><br><span>     {</span><br><span>         argv_printf_cat(&amp=
;argv, &quot;--echo&quot;);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     argv_printf_cat(&a=
mp;argv, &quot;--icon network-vpn&quot;);</span><br><span>     argv_printf_=
cat(&amp;argv, &quot;--timeout=3D0&quot;);</span><br><span>     argv_printf=
_cat(&amp;argv, &quot;%s&quot;, prompt);</span><br><span>diff --git a/src/o=
penvpn/init.c b/src/openvpn/init.c</span><br><span>index c014a91..b690dff 1=
00644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/op=
envpn/init.c</span><br><span>@@ -1545,7 +1545,7 @@</span><br><span> #else</=
span><br><span> #ifdef ENABLE_SYSTEMD</span><br><span>         sd_notifyf(0=
, &quot;STATUS=3DFailed to start up: %s With Errors\nERRNO=3D1&quot;, messa=
ge);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_SY=
STEMD_SD_DAEMON_H */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>         msg(M_INFO, &quot;%s With Errors&quot;, me=
ssage);</span><br><span> #endif</span><br><span>     }</span><br><span>@@ -=
5052,4 +5052,4 @@</span><br><span>     packet_id_free(&amp;c-&gt;c2.crypto_=
options.packet_id);</span><br><span> </span><br><span>     context_gc_free(=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>=
\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1463?usp=3Demail">change 1463</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1463?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie59e03ce01575acaeaf690f582e=
b5cfa80eb37fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1463 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Ai2nHVSDwBw=--

