From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 14 May 2025 21:02:52 +0000
References: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f18c12a353addbbcbfee5ffe9f85e60afabc6b5f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NzEwmM4jaxc="; charset=UTF-8
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

--NzEwmM4jaxc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail

to review the following change.


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
1 file changed, 69 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1022/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c950e3d..7ee0613 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1117,10 +1117,78 @@
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
+    struct buffer buf =3D alloc_buf_gc(256, gc);
+    char *str =3D BSTR(&buf);
+
+    if (!fgets(str, BCAP(&buf), fp))
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
+    return BSTR(&buf);
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
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--NzEwmM4jaxc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Implement ovpn version detection<br><br>Add detection of the=
 ovpn kernel module type: if a backported<br>(out-of-tree) version is loade=
d, the MODULE_VERSION string is read from<br>sysfs; otherwise, for the in-t=
ree module, the function reports the<br>kernel release and version.<br><br>=
Change-Id: I7fc033a7ffee73045316763356a95d75ef23f5ad<br>Signed-off-by: Ralf=
 Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file=
 changed, 69 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/22/1022/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index c950e3d..=
7ee0613 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><spa=
n>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1117,10 +1117,78 @@</sp=
an><br><span>     return true;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * There&#39;s no version indicator in th=
e ovpn in-tree module, so we return a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * string containing info about the kernel version and re=
lease.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_version_string_in_tree(st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct utsname system;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (uname(&amp;system))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return &quot;ERR&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, system=
.release);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p=
uts(&amp;buf, &quot; &quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_puts(&amp;buf, system.version);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return BSTR(&amp;buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * When the modu=
le is loaded, the backports version of ovpn has a version file</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * in sysfs. Read it and return =
the string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The caller is responsi=
ble for closing the file pointer.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dc=
o_version_string_backports(FILE *fp, struct gc_arena *gc)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(256, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *str =3D BSTR(&am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!fgets(str, BCAP(&amp;b=
uf), fp))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;ERR=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* remove potential newline at the end of=
 the string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *nl =3D strchr(str, &#39;\n&#39;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (nl)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *nl =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;buf);=
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
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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


--NzEwmM4jaxc=--

