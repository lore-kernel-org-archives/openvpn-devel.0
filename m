From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Thu, 15 May 2025 08:27:43 +0000
In-Reply-To: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
References: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <3ecb112a4bf0633380b747804572d647c87f8de1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TEb7lr8uGXc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement ovpn
 version detection
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

--TEb7lr8uGXc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
, ralf_lici.

Hello cron2, flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by ordex, Code-Review-1 by cron2


Change subject: Implement ovpn version detection
......................................................................

Implement ovpn version detection

Add detection of the ovpn kernel module type: if a backported
(out-of-tree) version is loaded, the MODULE_VERSION string is read from
sysfs; otherwise, for the in-tree module, the function reports the
kernel release and version.

Change-Id: I7fc033a7ffee73045316763356a95d75ef23f5ad
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 68 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1022/2

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c950e3d..a5f9e06 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1117,10 +1117,77 @@
     return true;
 }

+/**
+ * There's no version indicator in the ovpn in-tree module, so we return a
+ * string containing info about the kernel version and release.
+ */
+static const char *
+dco_version_string_in_tree(struct gc_arena *gc)
+{
+    struct buffer buf =3D alloc_buf_gc(256, gc);
+    struct utsname system;
+
+    if (uname(&system))
+    {
+        return "ERR";
+    }
+
+    buf_puts(&buf, system.release);
+    buf_puts(&buf, " ");
+    buf_puts(&buf, system.version);
+    return BSTR(&buf);
+}
+
+/**
+ * When the module is loaded, the backports version of ovpn has a version =
file
+ * in sysfs. Read it and return the string.
+ *
+ * The caller is responsible for closing the file pointer.
+ */
+static const char *
+dco_version_string_backports(FILE *fp, struct gc_arena *gc)
+{
+    char *str =3D gc_malloc(PATH_MAX, false, gc);
+
+    if (!fgets(str, PATH_MAX, fp))
+    {
+        return "ERR";
+    }
+
+    /* remove potential newline at the end of the string */
+    char *nl =3D strchr(str, '\n');
+    if (nl)
+    {
+        *nl =3D '\0';
+    }
+
+    return str;
+}
+
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    return "Unknown";
+    const char *version;
+    struct stat sb;
+    FILE *fp;
+
+    if (stat("/sys/module/ovpn", &sb) !=3D 0 || !S_ISDIR(sb.st_mode))
+    {
+        return "N/A";
+    }
+
+    /* now that we know for sure that the module is loaded, if there's no
+     * version file it means we're dealing with the in-tree version, other=
wise
+     * it's backports */
+    fp =3D fopen("/sys/module/ovpn/version", "r");
+    if (!fp)
+    {
+        return dco_version_string_in_tree(gc);
+    }
+    version =3D dco_version_string_backports(fp, gc);
+
+    fclose(fp);
+    return version;
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fc033a7ffee73045316763356a95d75ef23f5ad
Gerrit-Change-Number: 1022
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-MessageType: newpatchset

--TEb7lr8uGXc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos, ralf_lici. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by ordex, Code-Review-1 by cron2</p><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Implement ovpn version detec=
tion<br><br>Add detection of the ovpn kernel module type: if a backported<b=
r>(out-of-tree) version is loaded, the MODULE_VERSION string is read from<b=
r>sysfs; otherwise, for the in-tree module, the function reports the<br>ker=
nel release and version.<br><br>Change-Id: I7fc033a7ffee73045316763356a95d7=
5ef23f5ad<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M s=
rc/openvpn/dco_linux.c<br>1 file changed, 68 insertions(+), 1 deletion(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/10=
22/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c=
</span><br><span>index c950e3d..a5f9e06 100644</span><br><span>--- a/src/op=
envpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><=
span>@@ -1117,10 +1117,77 @@</span><br><span>     return true;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * There&#3=
9;s no version indicator in the ovpn in-tree module, so we return a</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * string containing info a=
bout the kernel version and release.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_version_string_in_tree(struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf_gc(256, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct utsname system;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (uname(&amp;system))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return &quot;ERR&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_puts(&amp;buf, system.release);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_puts(&amp;buf, &quot; &quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, system.versi=
on);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR=
(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * When the module is loaded, the backports version of ovpn h=
as a version file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 in sysfs. Read it and return the string.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * The caller is responsible for closing the file pointer.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_version_string_backports(FILE *fp, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *str =3D gc_mall=
oc(PATH_MAX, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!fgets=
(str, PATH_MAX, fp))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n &quot;ERR&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* remove potential newline at=
 the end of the string */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *nl =3D strchr(str, &#39;\n&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (nl)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *nl =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return str;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span>=
<br><span> dco_version_string(struct gc_arena *gc)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return &quot;Unknown&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*version;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 stat sb;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FILE *=
fp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (stat(&quot;/sys/module/ovpn=
&quot;, &amp;sb) !=3D 0 || !S_ISDIR(sb.st_mode))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return &quot;N/A&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 now that we know for sure that the module is loaded, if there&#39;s no</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * version file it =
means we&#39;re dealing with the in-tree version, otherwise</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * it&#39;s backports */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    fp =3D fopen(&quot;/sy=
s/module/ovpn/version&quot;, &quot;r&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!fp)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return dco_version_string_in_tree(gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    version =3D dco_version_string_backports(fp, gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fclose(fp);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return version;</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail=
">change 1022</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fc033a7ffee73045316763356a=
95d75ef23f5ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1022 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TEb7lr8uGXc=--

