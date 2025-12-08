From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:38:49 +0000
In-Reply-To: <gerrit.1765215972000.Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9@...2715...>
References: <gerrit.1765215972000.Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <088c7724a725d757d8eb3d7aa35c25675d045637-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UjfRE+1/cE4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: tests: Allow to
 override openvpn binary used
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

--UjfRE+1/cE4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
24?usp=3Demail )

Change subject: tests: Allow to override openvpn binary used
......................................................................

tests: Allow to override openvpn binary used

This makes it easy to test an installed binary for
example.

Change-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230511101253.369196-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
648.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1424
(cherry picked from commit d623aa6c29545a7f00daaa73d87818a9c5b1e942)
Message-Id: <20251208193950.16969-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
907.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_client.sh.in
M tests/t_cltsrv.sh
M tests/t_lpback.sh
M tests/t_net.sh
4 files changed, 15 insertions(+), 12 deletions(-)




diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 03a0dbf..f6654dd 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -18,6 +18,7 @@

 srcdir=3D"${srcdir:-.}"
 top_builddir=3D"${top_builddir:-..}"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 if [ -r "${top_builddir}"/t_client.rc ] ; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ] ; then
@@ -49,7 +50,7 @@
     exit "${TCLIENT_SKIP_RC}"
 fi

-if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
+if [ ! -x "${openvpn}" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
@@ -352,9 +353,9 @@
     pidfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
     openvpn_conf=3D"$openvpn_conf --writepid $pidfile $up"
     output " run openvpn $openvpn_conf"
-    echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
+    echo "# ${openvpn} $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
     umask 022
-    $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDI=
R/$SUF:openvpn.log &
+    $RUN_SUDO "${openvpn}" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
     sudopid=3D$!

     # Check if OpenVPN has initialized before continuing.  It will check e=
very 3rd second up
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 752251e..4a8643a 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -22,6 +22,7 @@
 srcdir=3D"${srcdir:-.}"
 top_srcdir=3D"${top_srcdir:-..}"
 top_builddir=3D"${top_builddir:-..}"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=3D
@@ -55,8 +56,8 @@
 for i in 1 2 3 ; do
   set +e
   (
-  "${top_builddir}/src/openvpn/openvpn" --script-security 2 --cd "${root}"=
 ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-exit=
 180 --config "sample-config-files/loopback-server" &
-  "${top_builddir}/src/openvpn/openvpn" --script-security 2 --cd "${top_sr=
cdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exi=
t --ping-exit 180 --config "sample-config-files/loopback-client"
+  "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role=
 srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-con=
fig-files/loopback-server" &
+  "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} =
--setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --confi=
g "sample-config-files/loopback-client"
   ) 3>log.$$.signal >log.$$ 2>&1
   e1=3D$?
   wait $!
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 5aabbd5..482016a 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -21,6 +21,7 @@

 set -eu
 top_builddir=3D"${top_builddir:-..}"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exi=
t 77" 1 2 15
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3

@@ -71,7 +72,7 @@


 # Get list of supported ciphers from openvpn --show-ciphers output
-CIPHERS=3D$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
+CIPHERS=3D$(${openvpn} --show-ciphers | \
             sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*=
$/d')

 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
@@ -90,23 +91,23 @@
 # Also test cipher 'none'
 CIPHERS=3D${CIPHERS}$(printf "\nnone")

-"${top_builddir}/src/openvpn/openvpn" --genkey secret key.$$
+"${openvpn}" --genkey secret key.$$
 set +e

 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ =
--cipher ${cipher} ) >log.$$ 2>&1
+    ( "${openvpn}" --test-crypto --secret key.$$ --cipher ${cipher} ) >log=
.$$ 2>&1
     test_end $? log.$$
 done

 test_start "Testing tls-crypt-v2 server key generation... "
-"${top_builddir}/src/openvpn/openvpn" \
+"${openvpn}" \
     --genkey tls-crypt-v2-server tc-server-key.$$ >log.$$ 2>&1
 test_end $? log.$$

 test_start "Testing tls-crypt-v2 key generation (no metadata)... "
-"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+"${openvpn}" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ >log.$$ 2>&1
 test_end $? log.$$
=20
@@ -118,7 +119,7 @@
     i=3D$(expr $i + 1)
 done
 test_start "Testing tls-crypt-v2 key generation (max length metadata)... "
-"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+"${openvpn}" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ "${METADATA}" \
     >log.$$ 2>&1
 test_end $? log.$$
diff --git a/tests/t_net.sh b/tests/t_net.sh
index bc91f82..8134832 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -7,7 +7,7 @@

 srcdir=3D"${srcdir:-.}"
 top_builddir=3D"${top_builddir:-..}"
-openvpn=3D"${top_builddir}/src/openvpn/openvpn"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"


 # bail out right away on non-linux. NetLink (the object of this test) is o=
nly

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1424?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9
Gerrit-Change-Number: 1424
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UjfRE+1/cE4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1424?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tests: Allow to override openvpn binary used<br>=
<br>This makes it easy to test an installed binary for<br>example.<br><br>C=
hange-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Message-Id: &lt;20230511101253.369196-1-frank@...2641...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg26648.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.o=
penvpn.net/c/openvpn/+/1424<br>(cherry picked from commit d623aa6c29545a7f0=
0daaa73d87818a9c5b1e942)<br>Message-Id: &lt;20251208193950.16969-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg34907.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M tests/t_client.sh.in<br>M tests/t_cltsrv.sh<br>M tests/t_lp=
back.sh<br>M tests/t_net.sh<br>4 files changed, 15 insertions(+), 12 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in</span><br><span=
>index 03a0dbf..f6654dd 100755</span><br><span>--- a/tests/t_client.sh.in</=
span><br><span>+++ b/tests/t_client.sh.in</span><br><span>@@ -18,6 +18,7 @@=
</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-.}&quot;</span=
><br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+openvpn=3D&quot;${openvpn:-${top_bui=
lddir}/src/openvpn/openvpn}&quot;</span><br><span> if [ -r &quot;${top_buil=
ddir}&quot;/t_client.rc ] ; then</span><br><span>     . &quot;${top_builddi=
r}&quot;/t_client.rc</span><br><span> elif [ -r &quot;${srcdir}&quot;/t_cli=
ent.rc ] ; then</span><br><span>@@ -49,7 +50,7 @@</span><br><span>     exit=
 &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${top_build=
dir}/src/openvpn/openvpn&quot; ]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if [ ! -x &quot;${openvpn}&quot; ]</span><br><span> then</span=
><br><span>     echo &quot;no (executable) openvpn binary in current build =
tree. FAIL.&quot; &gt;&amp;2</span><br><span>     exit 1</span><br><span>@@=
 -352,9 +353,9 @@</span><br><span>     pidfile=3D&quot;${top_builddir}/test=
s/$LOGDIR/openvpn-$SUF.pid&quot;</span><br><span>     openvpn_conf=3D&quot;=
$openvpn_conf --writepid $pidfile $up&quot;</span><br><span>     output &qu=
ot; run openvpn $openvpn_conf&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &quot;# src/openvpn/openvpn $openvpn_conf&quot; &gt;=
$LOGDIR/$SUF:openvpn.log</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    echo &quot;# ${openvpn} $openvpn_conf&quot; &gt;$LOGDIR/$SUF:openv=
pn.log</span><br><span>     umask 022</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    $RUN_SUDO &quot;${top_builddir}/src/openvpn/openvpn&quo=
t; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn.log &amp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO &quot;${openvpn}&quot; $o=
penvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn.log &amp;</span><br><span>     sud=
opid=3D$!</span><br><span> </span><br><span>     # Check if OpenVPN has ini=
tialized before continuing.  It will check every 3rd second up</span><br><s=
pan>diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh</span><br><span>inde=
x 752251e..4a8643a 100755</span><br><span>--- a/tests/t_cltsrv.sh</span><br=
><span>+++ b/tests/t_cltsrv.sh</span><br><span>@@ -22,6 +22,7 @@</span><br>=
<span> srcdir=3D&quot;${srcdir:-.}&quot;</span><br><span> top_srcdir=3D&quo=
t;${top_srcdir:-..}&quot;</span><br><span> top_builddir=3D&quot;${top_build=
dir:-..}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openv=
pn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br>=
<span> trap &quot;rm -f log.$$ log.$$.signal ; trap 0 ; exit 77&quot; 1 2 1=
5</span><br><span> trap &quot;rm -f log.$$ log.$$.signal ; exit 1&quot; 0 3=
</span><br><span> addopts=3D</span><br><span>@@ -55,8 +56,8 @@</span><br><s=
pan> for i in 1 2 3 ; do</span><br><span>   set +e</span><br><span>   (</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;${top_builddir}/s=
rc/openvpn/openvpn&quot; --script-security 2 --cd &quot;${root}&quot; ${add=
opts} --setenv role srv --down &quot;${downscript}&quot; --tls-exit --ping-=
exit 180 --config &quot;sample-config-files/loopback-server&quot; &amp;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;${top_builddir}/s=
rc/openvpn/openvpn&quot; --script-security 2 --cd &quot;${top_srcdir}/sampl=
e&quot; ${addopts} --setenv role clt --down &quot;${downscript}&quot; --tls=
-exit --ping-exit 180 --config &quot;sample-config-files/loopback-client&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;${openvp=
n}&quot; --script-security 2 --cd &quot;${root}&quot; ${addopts} --setenv r=
ole srv --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 --confi=
g &quot;sample-config-files/loopback-server&quot; &amp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  &quot;${openvpn}&quot; --script-secur=
ity 2 --cd &quot;${top_srcdir}/sample&quot; ${addopts} --setenv role clt --=
down &quot;${downscript}&quot; --tls-exit --ping-exit 180 --config &quot;sa=
mple-config-files/loopback-client&quot;</span><br><span>   ) 3&gt;log.$$.si=
gnal &gt;log.$$ 2&gt;&amp;1</span><br><span>   e1=3D$?</span><br><span>   w=
ait $!</span><br><span>diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh</=
span><br><span>index 5aabbd5..482016a 100755</span><br><span>--- a/tests/t_=
lpback.sh</span><br><span>+++ b/tests/t_lpback.sh</span><br><span>@@ -21,6 =
+21,7 @@</span><br><span> </span><br><span> set -eu</span><br><span> top_bu=
ilddir=3D&quot;${top_builddir:-..}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn=
/openvpn}&quot;</span><br><span> trap &quot;rm -f key.$$ tc-server-key.$$ t=
c-client-key.$$ log.$$ ; trap 0 ; exit 77&quot; 1 2 15</span><br><span> tra=
p &quot;rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1&quot=
; 0 3</span><br><span> </span><br><span>@@ -71,7 +72,7 @@</span><br><span> =
</span><br><span> </span><br><span> # Get list of supported ciphers from op=
envpn --show-ciphers output</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-CIPHERS=3D$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+CIPHERS=3D$(${openvpn}=
 --show-ciphers | \</span><br><span>             sed -e &#39;/The following=
/,/^$/d&#39; -e s&#39;/ .*//&#39; -e &#39;/^[[:space:]]*$/d&#39;)</span><br=
><span> </span><br><span> # SK, 2014-06-04: currently the DES-EDE3-CFB1 imp=
lementation of OpenSSL is</span><br><span>@@ -90,23 +91,23 @@</span><br><sp=
an> # Also test cipher &#39;none&#39;</span><br><span> CIPHERS=3D${CIPHERS}=
$(printf &quot;\nnone&quot;)</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-&quot;${top_builddir}/src/openvpn/openvpn&quot; --=
genkey secret key.$$</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+&quot;${openvpn}&quot; --genkey secret key.$$</span><br><span> set +e</spa=
n><br><span> </span><br><span> for cipher in ${CIPHERS}</span><br><span> do=
</span><br><span>     test_start &quot;Testing cipher ${cipher}... &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ( &quot;${top_build=
dir}/src/openvpn/openvpn&quot; --test-crypto --secret key.$$ --cipher ${cip=
her} ) &gt;log.$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ( &quot;${openvpn}&quot; --test-crypto --secret key.$$ --ciph=
er ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span>     test_end $? log.=
$$</span><br><span> done</span><br><span> </span><br><span> test_start &quo=
t;Testing tls-crypt-v2 server key generation... &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-&quot;${top_builddir}/src/openvpn/openvpn&=
quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;${open=
vpn}&quot; \</span><br><span>     --genkey tls-crypt-v2-server tc-server-ke=
y.$$ &gt;log.$$ 2&gt;&amp;1</span><br><span> test_end $? log.$$</span><br><=
span> </span><br><span> test_start &quot;Testing tls-crypt-v2 key generatio=
n (no metadata)... &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-&quot;${top_builddir}/src/openvpn/openvpn&quot; --tls-crypt-v2 tc-serve=
r-key.$$ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;${o=
penvpn}&quot; --tls-crypt-v2 tc-server-key.$$ \</span><br><span>     --genk=
ey tls-crypt-v2-client tc-client-key.$$ &gt;log.$$ 2&gt;&amp;1</span><br><s=
pan> test_end $? log.$$</span><br><span> </span><br><span>@@ -118,7 +119,7 =
@@</span><br><span>     i=3D$(expr $i + 1)</span><br><span> done</span><br>=
<span> test_start &quot;Testing tls-crypt-v2 key generation (max length met=
adata)... &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&quot=
;${top_builddir}/src/openvpn/openvpn&quot; --tls-crypt-v2 tc-server-key.$$ =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;${openvpn}&q=
uot; --tls-crypt-v2 tc-server-key.$$ \</span><br><span>     --genkey tls-cr=
ypt-v2-client tc-client-key.$$ &quot;${METADATA}&quot; \</span><br><span>  =
   &gt;log.$$ 2&gt;&amp;1</span><br><span> test_end $? log.$$</span><br><sp=
an>diff --git a/tests/t_net.sh b/tests/t_net.sh</span><br><span>index bc91f=
82..8134832 100755</span><br><span>--- a/tests/t_net.sh</span><br><span>+++=
 b/tests/t_net.sh</span><br><span>@@ -7,7 +7,7 @@</span><br><span> </span><=
br><span> srcdir=3D&quot;${srcdir:-.}&quot;</span><br><span> top_builddir=
=3D&quot;${top_builddir:-..}&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-openvpn=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn=3D&quot;${openvp=
n:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span> </span><br><=
span> </span><br><span> # bail out right away on non-linux. NetLink (the ob=
ject of this test) is only</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1424?usp=3Demail">chang=
e 1424</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1424?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida7a64a299cd5bf7ae4f0cc7257=
56b5f5cc408f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1424 </div>
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

--UjfRE+1/cE4=--

