From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 15:46:47 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@...2715...>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e715fe72369e4c2753d71c1f12c2b4807aa4e986-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uXdc8tbJ2bs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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

--uXdc8tbJ2bs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1675?usp=3Demail

to look at the new patch set (#3).


Change subject: lladdr: Clean up code
......................................................................

lladdr: Clean up code

cppcheck complained about the creation of a useless
variable on Windows. With the old code this was not
fixable in a good way. So rewrite the whole code to
hopefully be much more readable.

Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/lladdr.c
1 file changed, 39 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1675/3

diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index d8bcad9..5160780 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -13,42 +13,55 @@
 #include "lladdr.h"
 #include "proto.h"

+#ifdef TARGET_LINUX
+static int
+set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *l=
laddr)
+{
+    uint8_t addr[OPENVPN_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
+    return (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
+}
+#else /* TARGET_LINUX */
+
+#if defined(TARGET_SOLARIS) || defined(TARGET_FREEBSD)
+#define IFCONFIG_LLADDR_CMD "ether"
+#elif defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)
+#define IFCONFIG_LLADDR_CMD "lladdr"
+#endif
+static int
+set_lladdr_ifconfig(const char *ifname, const char *lladdr, const struct e=
nv_set *es)
+{
+#ifdef IFCONFIG_LLADDR_CMD
+    struct argv argv =3D argv_new();
+    argv_msg(M_INFO, &argv);
+    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
+    int r =3D openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to se=
t link layer address.");
+    argv_free(&argv);
+    return r;
+#else
+    msg(M_WARN,
+        "Sorry, but I don't know how to configure link layer addresses on =
this operating system.");
+    return -1;
+#endif
+}
+#endif /* TARGET_LINUX */
+
 int
 set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,=
 const struct env_set *es)
 {
-    int r;
-
     if (!ifname || !lladdr)
     {
         return -1;
     }

 #if defined(TARGET_LINUX)
-    uint8_t addr[OPENVPN_ETH_ALEN];
+    int r =3D set_lladdr_linux(ctx, ifname, lladdr);
+#else
+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);
+#endif

-    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
-    r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
-#else /* if defined(TARGET_LINUX) */
-    struct argv argv =3D argv_new();
-#if defined(TARGET_SOLARIS)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_OPENBSD)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_DARWIN)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_FREEBSD)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#else  /* if defined(TARGET_SOLARIS) */
-    msg(M_WARN,
-        "Sorry, but I don't know how to configure link layer addresses on =
this operating system.");
-    return -1;
-#endif /* if defined(TARGET_SOLARIS) */
-    argv_msg(M_INFO, &argv);
-    r =3D openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set li=
nk layer address.");
-    argv_free(&argv);
-#endif /* if defined(TARGET_LINUX) */
-
-    if (r)
+    if (r > 0)
     {
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Number: 1675
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uXdc8tbJ2bs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1675?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">lladdr: Clean up code<br><br>cppcheck complained=
 about the creation of a useless<br>variable on Windows. With the old code =
this was not<br>fixable in a good way. So rewrite the whole code to<br>hope=
fully be much more readable.<br><br>Change-Id: Ibe7b3c17176c97a1cbb4d9cc877=
35b05e62c4f43<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/openvpn/lladdr.c<br>1 file changed, 39 insertions(+), 26 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/75/1675/3</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr.c=
 b/src/openvpn/lladdr.c</span><br><span>index d8bcad9..5160780 100644</span=
><br><span>--- a/src/openvpn/lladdr.c</span><br><span>+++ b/src/openvpn/lla=
ddr.c</span><br><span>@@ -13,42 +13,55 @@</span><br><span> #include &quot;l=
laddr.h&quot;</span><br><span> #include &quot;proto.h&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_LIN=
UX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+set_lladdr_linux(openvpn_n=
et_ctx_t *ctx, const char *ifname, const char *lladdr)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint8_t addr[OPENVPN_ETH_ALEN];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return (net_addr_ll_set(ctx=
, ifname, addr) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* TA=
RGET_LINUX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_SOLARI=
S) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define IFCONFIG_LLADDR_CMD &quot;ether&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_OPENBSD) || define=
d(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IFCONFIG_LLADDR_CMD &quot;lladdr&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+set_lladdr_ifconfig(const char *ifname, const char *lladdr, const struct =
env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef IFCONFIG_LLADDR_CM=
D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv ar=
gv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    argv_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG=
_PATH, ifname, lladdr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int r =3D openvpn_execve_check(&amp;argv, es, M_WARN, &quot;ERROR: =
Unable to set link layer address.&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return r;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        &quot;Sorry, but I don&#39;t know how to configure link layer a=
ddresses on this operating system.&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* TAR=
GET_LINUX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> int</span><br><span> set_lladdr(openvpn_net_ctx_t *ctx, const ch=
ar *ifname, const char *lladdr, const struct env_set *es)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!ifna=
me || !lladdr)</span><br><span>     {</span><br><span>         return -1;</=
span><br><span>     }</span><br><span> </span><br><span> #if defined(TARGET=
_LINUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t ad=
dr[OPENVPN_ETH_ALEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int r =3D set_lladdr_linux(ctx, ifname, lladdr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sscanf(lladd=
r, MAC_FMT, MAC_SCAN_ARG(addr));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* if defined(TARGET_LI=
NUX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct arg=
v argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(TARGET_SOLARIS)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    argv_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH=
, ifname, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
if defined(TARGET_OPENBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    argv_printf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH,=
 ifname, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#eli=
f defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    argv_printf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH, i=
fname, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    argv_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifn=
ame, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /=
* if defined(TARGET_SOLARIS) */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        &quot;Sorry, but I don&#39;t know how to configure link layer a=
ddresses on this operating system.&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* if defined(TARGET_SOLARIS) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    r =3D openvpn_execve_check(&=
amp;argv, es, M_WARN, &quot;ERROR: Unable to set link layer address.&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;a=
rgv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if def=
ined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (r &gt; 0)</span><br><s=
pan>     {</span><br><span>         msg(M_INFO, &quot;TUN/TAP link layer ad=
dress set to %s&quot;, lladdr);</span><br><span>     }</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1675?usp=3Demail">change 1675</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1675?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc877=
35b05e62c4f43 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1675 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--uXdc8tbJ2bs=--

