From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 13 Dec 2023 14:07:04 +0000
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a62a7c27ec47e156c053e47c11f3ba5f81743c05-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kh3ph3FkaMk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move get_tmp_dir to
 win32-util.c and error out on failure
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

--kh3ph3FkaMk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail

to review the following change.


Change subject: Move get_tmp_dir to win32-util.c and error out on failure
......................................................................

Move get_tmp_dir to win32-util.c and error out on failure

Currently we only warn in get_tmp_dir fails and set o->tmp_dir to
a null pointer. This will not be caught by check_file_access_chroot
either since that ignores NULL pointers but other parts of OpenVPN
will assume that tmp_dir is set to a non-NULL string.

Also move get_tmp_dir to ssl-utils.c to use it in unit tests.

Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
M src/openvpn/win32-util.c
M src/openvpn/win32-util.h
M src/openvpn/win32.c
4 files changed, 34 insertions(+), 29 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/481/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 503e832..9863261 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -885,7 +885,15 @@
 #ifdef _WIN32
     /* On Windows, find temp dir via environment variables */
     o->tmp_dir =3D win_get_tempdir();
-#else
+
+    if (!o->tmp_dir)
+    {
+        /* Warn if we can't find a valid temporary directory, which should
+         * be unlikely. */
+        msg(M_USAGE, "Could not find a suitable temporary directory."
+            " (GetTempPath() failed).  Consider using --tmp-dir");
+    }
+#else  /* ifdef _WIN32 */
     /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp=
' */
     o->tmp_dir =3D getenv("TMPDIR");
     if (!o->tmp_dir)
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 81e504a..c5e7505 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -147,4 +147,26 @@
     }
     return true;
 }
+
+const char *
+win_get_tempdir(void)
+{
+    static char tmpdir[MAX_PATH];
+    WCHAR wtmpdir[MAX_PATH];
+
+    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))
+    {
+        return NULL;
+    }
+
+    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) =
> sizeof(tmpdir))
+    {
+        msg(M_WARN, "Could not get temporary directory. Path is too long."
+            "  Consider using --tmp-dir");
+        return NULL;
+    }
+
+    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), N=
ULL, NULL);
+    return tmpdir;
+}
 #endif /* _WIN32 */
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index ac37979..98bf74b 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -40,5 +40,8 @@
 /* return true if filename is safe to be used on Windows */
 bool win_safe_filename(const char *fn);

+/* Find temporary directory */
+const char *win_get_tempdir(void);
+
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e998d90..6b7ba5e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1137,34 +1137,6 @@
     set_win_sys_path(buf, es);
 }

-
-const char *
-win_get_tempdir(void)
-{
-    static char tmpdir[MAX_PATH];
-    WCHAR wtmpdir[MAX_PATH];
-
-    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))
-    {
-        /* Warn if we can't find a valid temporary directory, which should
-         * be unlikely.
-         */
-        msg(M_WARN, "Could not find a suitable temporary directory."
-            " (GetTempPath() failed).  Consider using --tmp-dir");
-        return NULL;
-    }
-
-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) =
> sizeof(tmpdir))
-    {
-        msg(M_WARN, "Could not get temporary directory. Path is too long."
-            "  Consider using --tmp-dir");
-        return NULL;
-    }
-
-    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), N=
ULL, NULL);
-    return tmpdir;
-}
-
 static bool
 win_block_dns_service(bool add, int index, const HANDLE pipe)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Gerrit-Change-Number: 481
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kh3ph3FkaMk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move get_tmp_dir to win32-util.c and error out on failure<br>=
<br>Currently we only warn in get_tmp_dir fails and set o-&gt;tmp_dir to<br=
>a null pointer. This will not be caught by check_file_access_chroot<br>eit=
her since that ignores NULL pointers but other parts of OpenVPN<br>will ass=
ume that tmp_dir is set to a non-NULL string.<br><br>Also move get_tmp_dir =
to ssl-utils.c to use it in unit tests.<br><br>Change-Id: I525ccf7872880367=
b248ebebb0ddc83551498042<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/win32-util.c<br>M s=
rc/openvpn/win32-util.h<br>M src/openvpn/win32.c<br>4 files changed, 34 ins=
ertions(+), 29 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/81/481/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c=
 b/src/openvpn/options.c</span><br><span>index 503e832..9863261 100644</spa=
n><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/o=
ptions.c</span><br><span>@@ -885,7 +885,15 @@</span><br><span> #ifdef _WIN3=
2</span><br><span>     /* On Windows, find temp dir via environment variabl=
es */</span><br><span>     o-&gt;tmp_dir =3D win_get_tempdir();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!o-&gt;tmp_dir)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* Warn if we can&#39;t find a valid temporary directory, which shou=
ld</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * be unl=
ikely. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_USAGE, &quot;Could not find a suitable temporary directory.&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot; (GetTe=
mpPath() failed).  Consider using --tmp-dir&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else  /* ifdef _WIN32 */</span><br><span>     /* Non-w=
indows platforms use $TMPDIR, and if not set, default to &#39;/tmp&#39; */<=
/span><br><span>     o-&gt;tmp_dir =3D getenv(&quot;TMPDIR&quot;);</span><b=
r><span>     if (!o-&gt;tmp_dir)</span><br><span>diff --git a/src/openvpn/w=
in32-util.c b/src/openvpn/win32-util.c</span><br><span>index 81e504a..c5e75=
05 100644</span><br><span>--- a/src/openvpn/win32-util.c</span><br><span>++=
+ b/src/openvpn/win32-util.c</span><br><span>@@ -147,4 +147,26 @@</span><br=
><span>     }</span><br><span>     return true;</span><br><span> }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+win_get_tempdir(void)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    static char tmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    WCHAR wtmpdir[MAX_PATH];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; si=
zeof(tmpdir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;Could not get temporary directory. Path is too long.&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;  Consider u=
sing --tmp-dir&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    WideCharToMultiByte(CP_UT=
F8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return tmpdir;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* _WIN32 */<=
/span><br><span>diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-u=
til.h</span><br><span>index ac37979..98bf74b 100644</span><br><span>--- a/s=
rc/openvpn/win32-util.h</span><br><span>+++ b/src/openvpn/win32-util.h</spa=
n><br><span>@@ -40,5 +40,8 @@</span><br><span> /* return true if filename i=
s safe to be used on Windows */</span><br><span> bool win_safe_filename(con=
st char *fn);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Find temporary directory */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+const char *win_get_tempdir(void);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENVPN_W=
IN32_UTIL_H */</span><br><span> #endif /* ifdef _WIN32 */</span><br><span>d=
iff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index=
 e998d90..6b7ba5e 100644</span><br><span>--- a/src/openvpn/win32.c</span><b=
r><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1137,34 +1137,6 @@</s=
pan><br><span>     set_win_sys_path(buf, es);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-win_get_tempdir(void)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    static char tmpdir[MAX_PATH];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    WCHAR wtmpdir[MAX_PATH];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* Warn if we can&#39;t find a valid tempor=
ary directory, which should</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * be unlikely.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(M_WARN, &quot;Could not find a suitable temporary directory.&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot; (=
GetTempPath() failed).  Consider using --tmp-dir&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt;=
 sizeof(tmpdir))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &=
quot;Could not get temporary directory. Path is too long.&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            &quot;  Consider usin=
g --tmp-dir&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    WideCharToMultiByte(CP_UTF8, 0, wtmp=
dir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return tmpdir;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static bool</span><br><span> win_block_dns_service(bool =
add, int index, const HANDLE pipe)</span><br><span> {</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/481?usp=3Demail">change 481</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525ccf7872880367b248ebebb0d=
dc83551498042 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--kh3ph3FkaMk=--

