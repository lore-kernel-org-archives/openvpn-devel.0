From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 11:48:38 +0000
In-Reply-To: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
References: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b39aaf371e38afbb4df0c85f3173786ca786d4b8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YnSPWmb1Qqg="; charset=UTF-8
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
To: kallisti5 <alex@...2837...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YnSPWmb1Qqg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 kallisti5. ( http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Haiku: Introduce basic platform / tun support
......................................................................

Haiku: Introduce basic platform / tun support

* Special thanks to Sean Brady's hard work in GSoC 2023 towards creating
  a TUN/TAP driver for Haiku!
* More kudos to Augustin Cavalier for making it functional :-)

Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Gert Doering <gert@...1296...>
Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9
Message-Id: <20241128101538.12810-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
947.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M INSTALL
M configure.ac
M src/openvpn/tun.c
3 files changed, 29 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/687/7

diff --git a/INSTALL b/INSTALL
index 6007338..9739272 100644
--- a/INSTALL
+++ b/INSTALL
@@ -263,6 +263,16 @@

     http://www.whiteboard.ne.jp/~admin2/tuntap/

+* Haiku:
+
+   Haiku can't yet dynamically create TUN/TAP devices, so you need to manu=
ally
+   create one before running openvpn:
+
+     # ifconfig tun/0 up
+
+   A standard reference the dev as "tun" in your config is all that's need=
ed
+   to use the tunnel device.
+
 * Windows

   OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN instal=
lers
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
index 85fe01a..29d823d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1631,6 +1631,13 @@
     {
         windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
     }
+#elif defined(TARGET_HAIKU)
+    /* example: ifconfig tun/0 inet 1.1.1.1 255.255.255.0 mtu 1450 up */
+    argv_printf(&argv, "%s %s inet %s %s mtu %d up", IFCONFIG_PATH,
+                ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Haiku ifconfig failed");
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on=
 this operating system.  You should ifconfig your TUN/TAP device manually o=
r use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -1909,10 +1916,15 @@
         {
             for (int i =3D 0; i < 256; ++i)
             {
+                /* some platforms have a dedicated directory per driver */
+                char *sep =3D "";
+#if defined(TARGET_HAIKU)
+                sep =3D "/";
+#endif
                 snprintf(tunname, sizeof(tunname),
-                         "/dev/%s%d", dev, i);
+                         "/dev/%s%s%d", dev, sep, i);
                 snprintf(dynamic_name, sizeof(dynamic_name),
-                         "%s%d", dev, i);
+                         "%s%s%d", dev, sep, i);
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
Gerrit-PatchSet: 7
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--YnSPWmb1Qqg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by kallisti5.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
687?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Haiku: Introduce basic platform / tun support<br><br=
>* Special thanks to Sean Brady&#39;s hard work in GSoC 2023 towards creati=
ng<br>  a TUN/TAP driver for Haiku!<br>* More kudos to Augustin Cavalier fo=
r making it functional :-)<br><br>Signed-off-by: Alexander von Gluck &lt;al=
ex@...2837...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Chan=
ge-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9<br>Message-Id: &lt;2024112=
8101538.12810-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg29947.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M INSTALL<br>M configure.ac<br>M src/=
openvpn/tun.c<br>3 files changed, 29 insertions(+), 2 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/687/7</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/INSTALL b/INSTALL</span><br><span>index 6007338..9739272 =
100644</span><br><span>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><b=
r><span>@@ -263,6 +263,16 @@</span><br><span> </span><br><span>     http://=
www.whiteboard.ne.jp/~admin2/tuntap/</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+* Haiku:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   Haiku can&#39;t yet dynamically create TUN/TAP devices, so you need=
 to manually</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   crea=
te one before running openvpn:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     # i=
fconfig tun/0 up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   A standard referenc=
e the dev as &quot;tun&quot; in your config is all that&#39;s needed</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   to use the tunnel devic=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 * Windows</span><br><span> </span><br><span>   OpenVPN on Windows needs a =
TUN/TAP kernel driver to work. OpenVPN installers</span><br><span>diff --gi=
t a/configure.ac b/configure.ac</span><br><span>index 0876a6a..7f6e43d 1006=
44</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</s=
pan><br><span>@@ -368,6 +368,11 @@</span><br><span> 		have_tap_header=3D&qu=
ot;yes&quot;</span><br><span> 		ac_cv_header_net_if_h=3D&quot;no&quot;	# ex=
ists, but breaks things</span><br><span> 		;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	*-*-haiku*)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_DEFINE_UNQUOT=
ED([TARGET_PREFIX], [&quot;H&quot;], [Target prefix])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		LIBS=3D&quot;${LIBS} -lnetwork&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+		;;</span><br><span> =
	*)</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;X&quot;],=
 [Target prefix])</span><br><span> 		have_tap_header=3D&quot;yes&quot;</spa=
n><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><s=
pan>index 85fe01a..29d823d 100644</span><br><span>--- a/src/openvpn/tun.c</=
span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1631,6 +1631,13 =
@@</span><br><span>     {</span><br><span>         windows_set_mtu(tt-&gt;a=
dapter_index, AF_INET, tun_mtu);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_HAIKU)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* example: ifconfig tun/0 =
inet 1.1.1.1 255.255.255.0 mtu 1450 up */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s %s inet %s %s mtu=
 %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                ifname, ifconfig_local, ifconfig_remote_netmask, t=
un_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execv=
e_check(&amp;argv, es, S_FATAL, &quot;Haiku ifconfig failed&quot;);</span><=
br><span> #else  /* if defined(TARGET_LINUX) */</span><br><span>     msg(M_=
FATAL, &quot;Sorry, but I don&#39;t know how to do &#39;ifconfig&#39; comma=
nds on this operating system.  You should ifconfig your TUN/TAP device manu=
ally or use an --up script.&quot;);</span><br><span> #endif /* if defined(T=
ARGET_LINUX) */</span><br><span>@@ -1909,10 +1916,15 @@</span><br><span>   =
      {</span><br><span>             for (int i =3D 0; i &lt; 256; ++i)</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* some platforms have a dedicated directory per dr=
iver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    char *sep =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_HAIKU)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                sep =3D &quot;/&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>               =
  snprintf(tunname, sizeof(tunname),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         &quot;/dev/%s%d&quot;, dev, i);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
  &quot;/dev/%s%s%d&quot;, dev, sep, i);</span><br><span>                 s=
nprintf(dynamic_name, sizeof(dynamic_name),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                         &quot;%s%d&quot;, dev, i);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    &quot;%s%s%d&quot;, dev, sep, i);</span><br><span>                 if (=
(tt-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</span><br><span>             =
    {</span><br><span>                     dynamic_opened =3D true;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/687?usp=3Demail">change 687</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/687?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a278374f492a538f0c174ced17=
46c3b1f82b8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 687 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--YnSPWmb1Qqg=--

