From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Jan 2024 21:34:01 +0000
In-Reply-To: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5577028ce88ce51ea5d91b6310b65884f6049c65-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UaWEMUhjrqU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UaWEMUhjrqU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/48=
1?usp=3Demail )

Change subject: Move get_tmp_dir to win32-util.c and error out on failure
......................................................................

Move get_tmp_dir to win32-util.c and error out on failure

Currently we only warn in get_tmp_dir fails and set o->tmp_dir to
a null pointer. This will not be caught by check_file_access_chroot
either since that ignores NULL pointers but other parts of OpenVPN
will assume that tmp_dir is set to a non-NULL string.

Also move get_tmp_dir to win32-util.c to use it in unit tests.

Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240108171349.15871-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
964.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/win32-util.c
M src/openvpn/win32-util.h
M src/openvpn/win32.c
M src/openvpn/win32.h
5 files changed, 34 insertions(+), 32 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1b28a19..f54f276 100644
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
+        /* Error out if we can't find a valid temporary directory, which s=
hould
+         * be very unlikely. */
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
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 3605966..aa8513b 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -286,9 +286,6 @@
 /* call self in a subprocess */
 void fork_to_self(const char *cmdline);

-/* Find temporary directory */
-const char *win_get_tempdir(void);
-
 bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);

 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Gerrit-Change-Number: 481
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--UaWEMUhjrqU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/481?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Move get_tmp_dir to win32-util.c and error out=
 on failure<br><br>Currently we only warn in get_tmp_dir fails and set o-&g=
t;tmp_dir to<br>a null pointer. This will not be caught by check_file_acces=
s_chroot<br>either since that ignores NULL pointers but other parts of Open=
VPN<br>will assume that tmp_dir is set to a non-NULL string.<br><br>Also mo=
ve get_tmp_dir to win32-util.c to use it in unit tests.<br><br>Change-Id: I=
525ccf7872880367b248ebebb0ddc83551498042<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Message-Id: &lt;20240108171349.15871-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27964.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/options.c<br>M src/openvpn/win32-util.c<br>M src/openvpn/win32-util.h<=
br>M src/openvpn/win32.c<br>M src/openvpn/win32.h<br>5 files changed, 34 in=
sertions(+), 32 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 1b28a19..f54f276 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -885,7 +88=
5,15 @@</span><br><span> #ifdef _WIN32</span><br><span>     /* On Windows, =
find temp dir via environment variables */</span><br><span>     o-&gt;tmp_d=
ir =3D win_get_tempdir();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;tmp_dir)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* Error out if we can&#39;t fi=
nd a valid temporary directory, which should</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * be very unlikely. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Could not f=
ind a suitable temporary directory.&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot; (GetTempPath() failed).  Consider =
using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* =
ifdef _WIN32 */</span><br><span>     /* Non-windows platforms use $TMPDIR, =
and if not set, default to &#39;/tmp&#39; */</span><br><span>     o-&gt;tmp=
_dir =3D getenv(&quot;TMPDIR&quot;);</span><br><span>     if (!o-&gt;tmp_di=
r)</span><br><span>diff --git a/src/openvpn/win32-util.c b/src/openvpn/win3=
2-util.c</span><br><span>index 81e504a..c5e7505 100644</span><br><span>--- =
a/src/openvpn/win32-util.c</span><br><span>+++ b/src/openvpn/win32-util.c</=
span><br><span>@@ -147,4 +147,26 @@</span><br><span>     }</span><br><span>=
     return true;</span><br><span> }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_get_t=
empdir(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    static char tmpdir[MA=
X_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR w=
tmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!GetTempPathW=
(_countof(wtmpdir), wtmpdir))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (WideCharToMultiByte(CP_UTF8,=
 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; sizeof(tmpdir))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Could not get temporary =
directory. Path is too long.&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;  Consider using --tmp-dir&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, si=
zeof(tmpdir), NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return tmpdir;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> #endif /* _WIN32 */</span><br><span>diff --git a/s=
rc/openvpn/win32-util.h b/src/openvpn/win32-util.h</span><br><span>index ac=
37979..98bf74b 100644</span><br><span>--- a/src/openvpn/win32-util.h</span>=
<br><span>+++ b/src/openvpn/win32-util.h</span><br><span>@@ -40,5 +40,8 @@<=
/span><br><span> /* return true if filename is safe to be used on Windows *=
/</span><br><span> bool win_safe_filename(const char *fn);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Find temporary =
directory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const c=
har *win_get_tempdir(void);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* OPENVPN_WIN32_UTIL_H */</span><br><span=
> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpn/win32.=
c b/src/openvpn/win32.c</span><br><span>index e998d90..6b7ba5e 100644</span=
><br><span>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win3=
2.c</span><br><span>@@ -1137,34 +1137,6 @@</span><br><span>     set_win_sys=
_path(buf, es);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-win_get_tempdir(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static char tm=
pdir[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    WC=
HAR wtmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!GetTempPath=
W(_countof(wtmpdir), wtmpdir))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* Warn if we can&#39;t find a valid temporary directory, which should</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         * be unlikely.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Could n=
ot find a suitable temporary directory.&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &quot; (GetTempPath() failed).  Conside=
r using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (WideCharToMultiByte(CP_UTF=
8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; sizeof(tmpdir))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Could not get temporary di=
rectory. Path is too long.&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;  Consider using --tmp-dir&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir)=
, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn tmpdir;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool<=
/span><br><span> win_block_dns_service(bool add, int index, const HANDLE pi=
pe)</span><br><span> {</span><br><span>diff --git a/src/openvpn/win32.h b/s=
rc/openvpn/win32.h</span><br><span>index 3605966..aa8513b 100644</span><br>=
<span>--- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</=
span><br><span>@@ -286,9 +286,6 @@</span><br><span> /* call self in a subpr=
ocess */</span><br><span> void fork_to_self(const char *cmdline);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Find tempo=
rary directory */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cons=
t char *win_get_tempdir(void);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> bool win_wfp_block_dns(const NET_IFINDEX index, =
const HANDLE msg_channel);</span><br><span> </span><br><span> bool win_wfp_=
uninit(const NET_IFINDEX index, const HANDLE msg_channel);</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/481?usp=3Demail">change 481</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525ccf7872880367b248ebebb0d=
dc83551498042 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--UaWEMUhjrqU=--

