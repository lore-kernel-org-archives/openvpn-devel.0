From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 15:38:37 +0000
In-Reply-To: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
References: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <edf797ede1536e876b6c538bdbc8a7b34c43d5f5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yrO5tIe0XlI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Haiku: Introduce
 basic platform / tun support
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

--yrO5tIe0XlI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail

to look at the new patch set (#2).


Change subject: Haiku: Introduce basic platform / tun support
......................................................................

Haiku: Introduce basic platform / tun support

* Special thanks to Sean Brady's hard work in GSoC 2023 towards creating
  a TUN/TAP driver for Haiku!
* More kudos to Augustin Cavalier for making it functional :-)

Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9
---
M configure.ac
M src/openvpn/tun.c
2 files changed, 22 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/687/2

diff --git a/configure.ac b/configure.ac
index 0876a6a..7f6e43d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -368,6 +368,11 @@
 		have_tap_header=3D"yes"
 		ac_cv_header_net_if_h=3D"no"	# exists, but breaks things
 		;;
+	*-*-haiku*)
+		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])
+		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["H"], [Target prefix])
+		LIBS=3D"${LIBS} -lnetwork"
+		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
 		have_tap_header=3D"yes"
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 85fe01a..e428fb9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1631,6 +1631,16 @@
     {
         windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
     }
+#elif defined(TARGET_HAIKU)
+    {
+        /* example: ifconfig tun/0 inet 1.1.1.1 255.255.255.0 mtu 1450 up =
*/
+        /* XXX: Need to add ifconfig_remote_netmask since right now it is =
just NULL */
+        argv_printf(&argv, "%s %s inet %s %s mtu %d up", IFCONFIG_PATH,
+            ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, es, S_FATAL, "Haiku ifconfig failed");
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on=
 this operating system.  You should ifconfig your TUN/TAP device manually o=
r use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -1909,10 +1919,17 @@
         {
             for (int i =3D 0; i < 256; ++i)
             {
+#if defined(TARGET_HAIKU)
+                snprintf(tunname, sizeof(tunname),
+                         "/dev/%s/%d", dev, i);
+                snprintf(dynamic_name, sizeof(dynamic_name),
+                         "%s/%d", dev, i);
+#else
                 snprintf(tunname, sizeof(tunname),
                          "/dev/%s%d", dev, i);
                 snprintf(dynamic_name, sizeof(dynamic_name),
                          "%s%d", dev, i);
+#endif
                 if ((tt->fd =3D open(tunname, O_RDWR)) > 0)
                 {
                     dynamic_opened =3D true;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9
Gerrit-Change-Number: 687
Gerrit-PatchSet: 2
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--yrO5tIe0XlI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>kallisti5 <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Haiku: Introduce basic platform / tun support<br><br>* Special thanks=
 to Sean Brady&#39;s hard work in GSoC 2023 towards creating<br>  a TUN/TAP=
 driver for Haiku!<br>* More kudos to Augustin Cavalier for making it funct=
ional :-)<br><br>Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9<br>--=
-<br>M configure.ac<br>M src/openvpn/tun.c<br>2 files changed, 22 insertion=
s(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/87/687/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac<=
/span><br><span>index 0876a6a..7f6e43d 100644</span><br><span>--- a/configu=
re.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -368,6 +368,11 =
@@</span><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br><span> 		=
ac_cv_header_net_if_h=3D&quot;no&quot;	# exists, but breaks things</span><b=
r><span> 		;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	*-*-h=
aiku*)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_DEFINE([=
TARGET_HAIKU], [1], [Are we running Haiku?])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;H&quo=
t;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+		LIBS=3D&quot;${LIBS} -lnetwork&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		;;</span><br><span> 	*)</span><br><span> 		AC_DEFINE=
_UNQUOTED([TARGET_PREFIX], [&quot;X&quot;], [Target prefix])</span><br><spa=
n> 		have_tap_header=3D&quot;yes&quot;</span><br><span>diff --git a/src/ope=
nvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 85fe01a..e428fb9 10064=
4</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn=
/tun.c</span><br><span>@@ -1631,6 +1631,16 @@</span><br><span>     {</span>=
<br><span>         windows_set_mtu(tt-&gt;adapter_index, AF_INET, tun_mtu);=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#elif defined(TARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* example: ifconfig tun/0 inet 1.1.1.1 255.255.255.0 mtu 1450 up */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* XXX: Need=
 to add ifconfig_remote_netmask since right now it is just NULL */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;arg=
v, &quot;%s %s inet %s %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ifname, ifconfig_local, i=
fconfig_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;Haik=
u ifconfig failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> #else  /* if defined(TARGET_LINUX) */</span><b=
r><span>     msg(M_FATAL, &quot;Sorry, but I don&#39;t know how to do &#39;=
ifconfig&#39; commands on this operating system.  You should ifconfig your =
TUN/TAP device manually or use an --up script.&quot;);</span><br><span> #en=
dif /* if defined(TARGET_LINUX) */</span><br><span>@@ -1909,10 +1919,17 @@<=
/span><br><span>         {</span><br><span>             for (int i =3D 0; i=
 &lt; 256; ++i)</span><br><span>             {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(TARGET_HAIKU)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                snprintf(tunname, sizeof(=
tunname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               &quot;/dev/%s/%d&quot;, dev, i);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                snprintf(dynamic_name, sizeof(d=
ynamic_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   &quot;%s/%d&quot;, dev, i);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#else</span><br><span>                 snprintf(=
tunname, sizeof(tunname),</span><br><span>                          &quot;/=
dev/%s%d&quot;, dev, i);</span><br><span>                 snprintf(dynamic_=
name, sizeof(dynamic_name),</span><br><span>                          &quot=
;%s%d&quot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span>                 if ((tt-&gt;fd =3D open(tunname, =
O_RDWR)) &gt; 0)</span><br><span>                 {</span><br><span>       =
              dynamic_opened =3D true;</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=3De=
mail">change 687</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a278374f492a538f0c174ced17=
46c3b1f82b8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 687 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yrO5tIe0XlI=--

