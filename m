From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 13 Dec 2025 12:30:02 +0000
In-Reply-To: <gerrit.1765563351000.I02db40d7335df7ab037ae1deb3e20f25a9b199bd@...2715...>
References: <gerrit.1765563351000.I02db40d7335df7ab037ae1deb3e20f25a9b199bd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <85d4bbcf86bcf1691df2d61b81bbbf21d421e438-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="irR4g99Keck="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--irR4g99Keck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
40?usp=3Demail )

Change subject: options: Avoid some conversion warnings
......................................................................

options: Avoid some conversion warnings

Just use the correct types.

Change-Id: I02db40d7335df7ab037ae1deb3e20f25a9b199bd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1440
Message-Id: <20251213084225.30988-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
061.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 2 insertions(+), 11 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02db40d7335df7ab037ae1deb3e20f25a9b199bd
Gerrit-Change-Number: 1440
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--irR4g99Keck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1440?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Avoid some conversion warnings<br><br>J=
ust use the correct types.<br><br>Change-Id: I02db40d7335df7ab037ae1deb3e20=
f25a9b199bd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1440<br>Message-Id: &lt;20251213084225.30988-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35061.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>=
2 files changed, 2 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 24c3e92..34af0d3 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1154,13 +=
1154,8 @@</span><br><span>     return get_ipv6_addr(ipv6_prefix_spec, &amp;=
t_addr, &amp;t_bits, M_WARN);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static char *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-string_substitute(const char *src, int from, int=
 to, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+string_substitute(const char *src, char from, char to, struct gc_aren=
a *gc)</span><br><span> {</span><br><span>     char *ret =3D (char *)gc_mal=
loc(strlen(src) + 1, true, gc);</span><br><span>     char *dest =3D ret;</s=
pan><br><span>@@ -9306,10 +9301,6 @@</span><br><span>     gc_free(&amp;gc);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> has_udp=
_in_local_list(const struct options *options)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br>=
<span>index 555d9dd..0561c25 100644</span><br><span>--- a/src/openvpn/optio=
ns.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -801,7 =
+801,7 @@</span><br><span> #define PUF_TYPE_IGNORE 2 /**&lt; filter type to=
 ignore a matching option */</span><br><span> #define PUF_TYPE_REJECT 3 /**=
&lt; filter type to reject and trigger SIGUSR1 */</span><br><span>     int =
type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int size;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span=
><br><span>     char *pattern;</span><br><span>     struct pull_filter *nex=
t;</span><br><span> };</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail">change 14=
40</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1440?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02db40d7335df7ab037ae1deb3e=
20f25a9b199bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1440 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--irR4g99Keck=--

