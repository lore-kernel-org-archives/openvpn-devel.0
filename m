From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 5 May 2025 15:00:55 +0000
In-Reply-To: <gerrit.1746440138000.I9cae7314203424e4a604073c5445559260172477@...2715...>
References: <gerrit.1746440138000.I9cae7314203424e4a604073c5445559260172477@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c9697f5bf159407cb5a2bd42821510282ee66b03-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b9zPM1MEC+k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add
 information-gathering about DNS resolvers configured to t_client....
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

--b9zPM1MEC+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/961?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add information-gathering about DNS resolvers configured to=
 t_client.sh(.in)
......................................................................

Add information-gathering about DNS resolvers configured to t_client.sh(.in)

With the patchsets to add DNS configuration on Unix+MacOS systems, and
the addition of test stanzas to excercise and verify the OS specific
"dns-updown" script, it becomes important to trace test failures
("did it not ping because the DNS was not installed, or did something
else fail?") and also verify that DNS config is properly restored at
the end of each test.

Linux is probed with "resolvectl status", if available, and
"cat resolv.conf" if not.  MacOS uses scutil --dns.

All other platforms use "cat resolv.conf" for now (because even if
"a tool to maintain DNS config" is available, in the end resolv.conf
is always where the final config lands).

Include a bit of restructuring to handle linux iproute2 testing in the
"Linux" branch, and make the control flow more amenable to having a
second case / esac block.

Change-Id: I9cae7314203424e4a604073c5445559260172477
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250505142224.24935-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
568.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_client.sh.in
1 file changed, 41 insertions(+), 23 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/961/4

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 1ccadeb..7a271b6 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -166,53 +166,71 @@
 # this is higly system dependent...
 get_ifconfig_route()
 {
-    # linux / iproute2? (-> if configure got a path)
-    if [ -n "@IPROUTE@" ]
-    then
-	echo "-- linux iproute2 --"
-	@IPROUTE@ addr show     | grep -v valid_lft
-	@IPROUTE@ route show
-	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-=
9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar=
) [0-9]+ms//g'
-	return
-    fi
-
-    # try uname
-    case `uname -s` in
+    UNAME=3D`uname -s`
+    case $UNAME in
 	Linux)
-	   echo "-- linux / ifconfig --"
-	   LANG=3DC @IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	   LANG=3DC @NETSTAT@ -rn -4 -6
-	   return
-	   ;;
+            # linux / iproute2? (-> if configure got a path)
+            if [ -n "@IPROUTE@" ]
+            then
+                echo "-- linux iproute2 --"
+                @IPROUTE@ addr show     | grep -v valid_lft
+                @IPROUTE@ route show
+                @IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e =
's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e =
's/ (rtt|rttvar) [0-9]+ms//g'
+            else
+	        echo "-- linux / ifconfig --"
+	        LANG=3DC @IFCONFIG@ -a |egrep  "( addr:|encap:)"
+	        LANG=3DC @NETSTAT@ -rn -4 -6
+            fi
+            ;;
 	FreeBSD|NetBSD|Darwin)
 	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
 	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
 	   ;;
 	OpenBSD)
 	   echo "-- OpenBSD --"
 	   @IFCONFIG@ -a | egrep "(flags=3D|inet)" | \
 		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
 	   ;;
 	SunOS)
 	   echo "-- Solaris --"
 	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
 	   ;;
 	AIX)
 	   echo "-- AIX --"
 	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
 	   ;;
+        *)
+           echo "get_ifconfig_route(): no idea how to get info on your OS =
(`uname -s`).  FAIL." >&2
+           exit 20
+           ;;
     esac

-    echo "get_ifconfig_route(): no idea how to get info on your OS.  FAIL.=
" >&2
-    exit 20
+    # another round of per-platform information gathering, for DNS info
+    # for most of the platforms "cat /etc/resolv.conf" is good enough
+    # except Linux and MacOS
+    case $UNAME in
+	Linux)
+            if [ -x /usr/bin/resolvectl ] ; then
+                echo "-- linux resolvectl --"
+                resolvectl status
+            else
+                echo "-- linux resolv.conf --"
+                cat /etc/resolv.conf
+            fi
+            ;;
+	Darwin)
+            echo "-- MacOS scutil --dns"
+            scutil --dns
+            ;;
+        *)
+            echo "-- resolv.conf --"
+            cat /etc/resolv.conf
+            ;;
+    esac
 }

 # ----------------------------------------------------------

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/961?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9cae7314203424e4a604073c5445559260172477
Gerrit-Change-Number: 961
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--b9zPM1MEC+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/961?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add information-gathering about DNS resolvers=
 configured to t_client.sh(.in)<br><br>With the patchsets to add DNS config=
uration on Unix+MacOS systems, and<br>the addition of test stanzas to excer=
cise and verify the OS specific<br>&quot;dns-updown&quot; script, it become=
s important to trace test failures<br>(&quot;did it not ping because the DN=
S was not installed, or did something<br>else fail?&quot;) and also verify =
that DNS config is properly restored at<br>the end of each test.<br><br>Lin=
ux is probed with &quot;resolvectl status&quot;, if available, and<br>&quot=
;cat resolv.conf&quot; if not.  MacOS uses scutil --dns.<br><br>All other p=
latforms use &quot;cat resolv.conf&quot; for now (because even if<br>&quot;=
a tool to maintain DNS config&quot; is available, in the end resolv.conf<br=
>is always where the final config lands).<br><br>Include a bit of restructu=
ring to handle linux iproute2 testing in the<br>&quot;Linux&quot; branch, a=
nd make the control flow more amenable to having a<br>second case / esac bl=
ock.<br><br>Change-Id: I9cae7314203424e4a604073c5445559260172477<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250505142224.24935-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg31568.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M tests/t_client.sh.in<br>1 file changed, 41 insertions(+), =
23 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/61/961/4</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/t_client.sh.in b/tests/t_cl=
ient.sh.in</span><br><span>index 1ccadeb..7a271b6 100755</span><br><span>--=
- a/tests/t_client.sh.in</span><br><span>+++ b/tests/t_client.sh.in</span><=
br><span>@@ -166,53 +166,71 @@</span><br><span> # this is higly system depe=
ndent...</span><br><span> get_ifconfig_route()</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    # linux / iproute2? (-&gt; =
if configure got a path)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if [ -n &quot;@IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	echo &quot;-- linux iproute2 --&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	@IPROUTE@ addr show     | grep -v valid_lft</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	@IPROUTE@ route show</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	@IPROUTE@ -o -6 route show | g=
rep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e &#3=
9;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar) [0=
-9]+ms//g&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	return=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    # try uname</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    case `uname -s` in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UNAME=3D`uname -s`</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    case $UNAME in</span><br><span> 	Linux)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- linux / ifconfig =
--&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   LANG=3DC =
@IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	   LANG=3DC @NETSTAT@ -rn -4 -6</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	   return</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            # linux / iproute2? (-&gt; if configure got a pa=
th)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [=
 -n &quot;@IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                echo &quot;-- linux iproute2 --&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                @IPROUTE@ addr show =
    | grep -v valid_lft</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                @IPROUTE@ route show</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                @IPROUTE@ -o -6 route show | grep -v &=
#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e &#39;s/ (mt=
u|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar) [0-9]+ms//=
g&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	        echo &q=
uot;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	        LANG=3DC @IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	        LANG=
=3DC @NETSTAT@ -rn -4 -6</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ;;</span><br><span> 	FreeBSD|NetBSD|Darwin)</span><br><span> 	 =
  echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span> 	=
   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span> 	   @=
NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	   return</span><br><span> 	   =
;;</span><br><span> 	OpenBSD)</span><br><span> 	   echo &quot;-- OpenBSD --=
&quot;</span><br><span> 	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quo=
t; | \</span><br><span> 		sed -e &#39;s/pltime [0-9]*//&#39; -e &#39;s/vlti=
me [0-9]*//&#39;</span><br><span> 	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/=
 { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	   return</span><br><span> 	   ;;</span><br><span> 	SunOS)</span><b=
r><span> 	   echo &quot;-- Solaris --&quot;</span><br><span> 	   @IFCONFIG@=
 -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span> 	   @NETSTAT@ -rn =
| awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	   return</span><br><span> 	   ;;</span><br><=
span> 	AIX)</span><br><span> 	   echo &quot;-- AIX --&quot;</span><br><span=
> 	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span> 	 =
  @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   return</span><br><span> 	 =
  ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+           echo &quot;ge=
t_ifconfig_route(): no idea how to get info on your OS (`uname -s`).  FAIL.=
&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         exit 20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        ;;</span><br><span>     esac</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    echo &quot;get_ifconfig_route(): no id=
ea how to get info on your OS.  FAIL.&quot; &gt;&amp;2</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    exit 20</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    # another round of per-platform information ga=
thering, for DNS info</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    # for most of the platforms &quot;cat /etc/resolv.conf&quot; is good =
enough</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # except =
Linux and MacOS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
case $UNAME in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	Linu=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ =
-x /usr/bin/resolvectl ] ; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                echo &quot;-- linux resolvectl --&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                resolvectl =
status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
echo &quot;-- linux resolv.conf --&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                cat /etc/resolv.conf</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	Darwin)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            echo &quot;-- MacOS scutil --dns&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            scutil --dns</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        *)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- resolv.co=
nf --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    cat /etc/resolv.conf</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    esac</span><br><span> }</span><br><span> </span><br><span> # ----------=
------------------------------------------------</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
61?usp=3Demail">change 961</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/961?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9cae7314203424e4a604073c544=
5559260172477 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 961 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--b9zPM1MEC+k=--

