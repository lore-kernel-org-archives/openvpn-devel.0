From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 16:52:28 +0000
In-Reply-To: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5d03b05ed37ef2314d256872495c415ae916b85d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3lSPVyxLhKw="; charset=UTF-8
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

--3lSPVyxLhKw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
M src/openvpn/win32.h
5 files changed, 34 insertions(+), 32 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/481/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e498114..79958db 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--3lSPVyxLhKw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Move get_tmp_dir to win32-util.c and error ou=
t on failure<br><br>Currently we only warn in get_tmp_dir fails and set o-&=
gt;tmp_dir to<br>a null pointer. This will not be caught by check_file_acce=
ss_chroot<br>either since that ignores NULL pointers but other parts of Ope=
nVPN<br>will assume that tmp_dir is set to a non-NULL string.<br><br>Also m=
ove get_tmp_dir to ssl-utils.c to use it in unit tests.<br><br>Change-Id: I=
525ccf7872880367b248ebebb0ddc83551498042<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/win=
32-util.c<br>M src/openvpn/win32-util.h<br>M src/openvpn/win32.c<br>M src/o=
penvpn/win32.h<br>5 files changed, 34 insertions(+), 32 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/481/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index e498114..79958db 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -885,7=
 +885,15 @@</span><br><span> #ifdef _WIN32</span><br><span>     /* On Windo=
ws, find temp dir via environment variables */</span><br><span>     o-&gt;t=
mp_dir =3D win_get_tempdir();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;tmp_dir)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Error out if we can&#39;=
t find a valid temporary directory, which should</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * be very unlikely. */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Could n=
ot find a suitable temporary directory.&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot; (GetTempPath() failed).  Consi=
der using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else =
 /* ifdef _WIN32 */</span><br><span>     /* Non-windows platforms use $TMPD=
IR, and if not set, default to &#39;/tmp&#39; */</span><br><span>     o-&gt=
;tmp_dir =3D getenv(&quot;TMPDIR&quot;);</span><br><span>     if (!o-&gt;tm=
p_dir)</span><br><span>diff --git a/src/openvpn/win32-util.c b/src/openvpn/=
win32-util.c</span><br><span>index 81e504a..c5e7505 100644</span><br><span>=
--- a/src/openvpn/win32-util.c</span><br><span>+++ b/src/openvpn/win32-util=
.c</span><br><span>@@ -147,4 +147,26 @@</span><br><span>     }</span><br><s=
pan>     return true;</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_g=
et_tempdir(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static char tmpdi=
r[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCH=
AR wtmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!GetTempP=
athW(_countof(wtmpdir), wtmpdir))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (WideCharToMultiByte(CP_U=
TF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; sizeof(tmpdir))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Could not get tempor=
ary directory. Path is too long.&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;  Consider using --tmp-dir&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir=
, sizeof(tmpdir), NULL, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return tmpdir;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span> #endif /* _WIN32 */</span><br><span>diff --git=
 a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h</span><br><span>inde=
x ac37979..98bf74b 100644</span><br><span>--- a/src/openvpn/win32-util.h</s=
pan><br><span>+++ b/src/openvpn/win32-util.h</span><br><span>@@ -40,5 +40,8=
 @@</span><br><span> /* return true if filename is safe to be used on Windo=
ws */</span><br><span> bool win_safe_filename(const char *fn);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Find tempor=
ary directory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+con=
st char *win_get_tempdir(void);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* OPENVPN_WIN32_UTIL_H */</span><br><=
span> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpn/wi=
n32.c b/src/openvpn/win32.c</span><br><span>index e998d90..6b7ba5e 100644</=
span><br><span>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/=
win32.c</span><br><span>@@ -1137,34 +1137,6 @@</span><br><span>     set_win=
_sys_path(buf, es);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-win_get_tempdir(void)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static char=
 tmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 WCHAR wtmpdir[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!GetTempP=
athW(_countof(wtmpdir), wtmpdir))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* Warn if we can&#39;t find a valid temporary directory, which should<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * be unlikely=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Coul=
d not find a suitable temporary directory.&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            &quot; (GetTempPath() failed).  Cons=
ider using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (WideCharToMultiByte(CP_=
UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; sizeof(tmpdir))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Could not get temporary=
 directory. Path is too long.&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &quot;  Consider using --tmp-dir&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpd=
ir), NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return tmpdir;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bo=
ol</span><br><span> win_block_dns_service(bool add, int index, const HANDLE=
 pipe)</span><br><span> {</span><br><span>diff --git a/src/openvpn/win32.h =
b/src/openvpn/win32.h</span><br><span>index 3605966..aa8513b 100644</span><=
br><span>--- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.=
h</span><br><span>@@ -286,9 +286,6 @@</span><br><span> /* call self in a su=
bprocess */</span><br><span> void fork_to_self(const char *cmdline);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Find te=
mporary directory */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
onst char *win_get_tempdir(void);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> bool win_wfp_block_dns(const NET_IFINDEX inde=
x, const HANDLE msg_channel);</span><br><span> </span><br><span> bool win_w=
fp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/481?usp=3Demail">change 481</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525ccf7872880367b248ebebb0d=
dc83551498042 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3lSPVyxLhKw=--

