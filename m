From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 18:15:54 +0000
References: <gerrit.1765563351000.I02db40d7335df7ab037ae1deb3e20f25a9b199bd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e54875bd86a0efd640fa04944c0df8e41b950715-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YsdoVhMA8VY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Avoid some
 conversion warnings
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

--YsdoVhMA8VY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail

to review the following change.


Change subject: options: Avoid some conversion warnings
......................................................................

options: Avoid some conversion warnings

Just use the correct types.

Change-Id: I02db40d7335df7ab037ae1deb3e20f25a9b199bd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1440/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 24c3e92..34af0d3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1154,13 +1154,8 @@
     return get_ipv6_addr(ipv6_prefix_spec, &t_addr, &t_bits, M_WARN);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static char *
-string_substitute(const char *src, int from, int to, struct gc_arena *gc)
+string_substitute(const char *src, char from, char to, struct gc_arena *gc)
 {
     char *ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);
     char *dest =3D ret;
@@ -9306,10 +9301,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 has_udp_in_local_list(const struct options *options)
 {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 555d9dd..0561c25 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -801,7 +801,7 @@
 #define PUF_TYPE_IGNORE 2 /**< filter type to ignore a matching option */
 #define PUF_TYPE_REJECT 3 /**< filter type to reject and trigger SIGUSR1 */
     int type;
-    int size;
+    size_t size;
     char *pattern;
     struct pull_filter *next;
 };

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02db40d7335df7ab037ae1deb3e20f25a9b199bd
Gerrit-Change-Number: 1440
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--YsdoVhMA8VY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">options: Avoid some conversion warnings<br>=
<br>Just use the correct types.<br><br>Change-Id: I02db40d7335df7ab037ae1de=
b3e20f25a9b199bd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>2 files =
changed, 2 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1440/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex 24c3e92..34af0d3 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1154,13 +1154,=
8 @@</span><br><span>     return get_ipv6_addr(ipv6_prefix_spec, &amp;t_add=
r, &amp;t_bits, M_WARN);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static char *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-string_substitute(const char *src, int from, int to, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+string_substitute(const char *src, char from, char to, struct gc_arena *gc=
)</span><br><span> {</span><br><span>     char *ret =3D (char *)gc_malloc(s=
trlen(src) + 1, true, gc);</span><br><span>     char *dest =3D ret;</span><=
br><span>@@ -9306,10 +9301,6 @@</span><br><span>     gc_free(&amp;gc);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> has_udp_in_l=
ocal_list(const struct options *options)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span=
>index 555d9dd..0561c25 100644</span><br><span>--- a/src/openvpn/options.h<=
/span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -801,7 +801,=
7 @@</span><br><span> #define PUF_TYPE_IGNORE 2 /**&lt; filter type to igno=
re a matching option */</span><br><span> #define PUF_TYPE_REJECT 3 /**&lt; =
filter type to reject and trigger SIGUSR1 */</span><br><span>     int type;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int size;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br>=
<span>     char *pattern;</span><br><span>     struct pull_filter *next;</s=
pan><br><span> };</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail">change 1440</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02db40d7335df7ab037ae1deb3e=
20f25a9b199bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1440 </div>
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

--YsdoVhMA8VY=--

