From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 17:46:16 +0000
References: <gerrit.1765215972000.Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <030325468629591c14a5499ec0ce1544eeaabd0b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZA3+0R/EHGU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZA3+0R/EHGU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1424?usp=3Demail

to review the following change.


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
(cherry picked from commit d623aa6c29545a7f00daaa73d87818a9c5b1e942)
---
M tests/t_client.sh.in
M tests/t_cltsrv.sh
M tests/t_lpback.sh
M tests/t_net.sh
4 files changed, 15 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1424/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9
Gerrit-Change-Number: 1424
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>

--ZA3+0R/EHGU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1424?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tests: Allow to override openvpn binary use=
d<br><br>This makes it easy to test an installed binary for<br>example.<br>=
<br>Change-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Message-Id: &lt;20230511101253.369196-1-frank@...2724...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg26648.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>(cherry picked from commit d623aa6c29545a7f00daaa73d87818a9c5b1e942)<br>-=
--<br>M tests/t_client.sh.in<br>M tests/t_cltsrv.sh<br>M tests/t_lpback.sh<=
br>M tests/t_net.sh<br>4 files changed, 15 insertions(+), 12 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/24/1424/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/tests/t_client.sh.in b/tests/t_c=
lient.sh.in</span><br><span>index 03a0dbf..f6654dd 100755</span><br><span>-=
-- a/tests/t_client.sh.in</span><br><span>+++ b/tests/t_client.sh.in</span>=
<br><span>@@ -18,6 +18,7 @@</span><br><span> </span><br><span> srcdir=3D&qu=
ot;${srcdir:-.}&quot;</span><br><span> top_builddir=3D&quot;${top_builddir:=
-..}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn=
=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><s=
pan> if [ -r &quot;${top_builddir}&quot;/t_client.rc ] ; then</span><br><sp=
an>     . &quot;${top_builddir}&quot;/t_client.rc</span><br><span> elif [ -=
r &quot;${srcdir}&quot;/t_client.rc ] ; then</span><br><span>@@ -49,7 +50,7=
 @@</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><spa=
n> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-if [ ! -x &quot;${top_builddir}/src/openvpn/openvpn&quot; ]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; =
]</span><br><span> then</span><br><span>     echo &quot;no (executable) ope=
nvpn binary in current build tree. FAIL.&quot; &gt;&amp;2</span><br><span> =
    exit 1</span><br><span>@@ -352,9 +353,9 @@</span><br><span>     pidfile=
=3D&quot;${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid&quot;</span><br><sp=
an>     openvpn_conf=3D&quot;$openvpn_conf --writepid $pidfile $up&quot;</s=
pan><br><span>     output &quot; run openvpn $openvpn_conf&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;# src/openvpn/ope=
nvpn $openvpn_conf&quot; &gt;$LOGDIR/$SUF:openvpn.log</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;# ${openvpn} $openvpn_conf=
&quot; &gt;$LOGDIR/$SUF:openvpn.log</span><br><span>     umask 022</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    $RUN_SUDO &quot;${top_buil=
ddir}/src/openvpn/openvpn&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn.=
log &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    $RUN_S=
UDO &quot;${openvpn}&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn.log &=
amp;</span><br><span>     sudopid=3D$!</span><br><span> </span><br><span>  =
   # Check if OpenVPN has initialized before continuing.  It will check eve=
ry 3rd second up</span><br><span>diff --git a/tests/t_cltsrv.sh b/tests/t_c=
ltsrv.sh</span><br><span>index 752251e..4a8643a 100755</span><br><span>--- =
a/tests/t_cltsrv.sh</span><br><span>+++ b/tests/t_cltsrv.sh</span><br><span=
>@@ -22,6 +22,7 @@</span><br><span> srcdir=3D&quot;${srcdir:-.}&quot;</span=
><br><span> top_srcdir=3D&quot;${top_srcdir:-..}&quot;</span><br><span> top=
_builddir=3D&quot;${top_builddir:-..}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+openvpn=3D&quot;${openvpn:-${top_builddir}/src/open=
vpn/openvpn}&quot;</span><br><span> trap &quot;rm -f log.$$ log.$$.signal ;=
 trap 0 ; exit 77&quot; 1 2 15</span><br><span> trap &quot;rm -f log.$$ log=
.$$.signal ; exit 1&quot; 0 3</span><br><span> addopts=3D</span><br><span>@=
@ -55,8 +56,8 @@</span><br><span> for i in 1 2 3 ; do</span><br><span>   se=
t +e</span><br><span>   (</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &quot;${top_builddir}/src/openvpn/openvpn&quot; --script-security 2 -=
-cd &quot;${root}&quot; ${addopts} --setenv role srv --down &quot;${downscr=
ipt}&quot; --tls-exit --ping-exit 180 --config &quot;sample-config-files/lo=
opback-server&quot; &amp;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  &quot;${top_builddir}/src/openvpn/openvpn&quot; --script-security 2 -=
-cd &quot;${top_srcdir}/sample&quot; ${addopts} --setenv role clt --down &q=
uot;${downscript}&quot; --tls-exit --ping-exit 180 --config &quot;sample-co=
nfig-files/loopback-client&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &quot;${openvpn}&quot; --script-security 2 --cd &quot;${root=
}&quot; ${addopts} --setenv role srv --down &quot;${downscript}&quot; --tls=
-exit --ping-exit 180 --config &quot;sample-config-files/loopback-server&qu=
ot; &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;${=
openvpn}&quot; --script-security 2 --cd &quot;${top_srcdir}/sample&quot; ${=
addopts} --setenv role clt --down &quot;${downscript}&quot; --tls-exit --pi=
ng-exit 180 --config &quot;sample-config-files/loopback-client&quot;</span>=
<br><span>   ) 3&gt;log.$$.signal &gt;log.$$ 2&gt;&amp;1</span><br><span>  =
 e1=3D$?</span><br><span>   wait $!</span><br><span>diff --git a/tests/t_lp=
back.sh b/tests/t_lpback.sh</span><br><span>index 5aabbd5..482016a 100755</=
span><br><span>--- a/tests/t_lpback.sh</span><br><span>+++ b/tests/t_lpback=
.sh</span><br><span>@@ -21,6 +21,7 @@</span><br><span> </span><br><span> se=
t -eu</span><br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn=3D&quot;${openvpn=
:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span> trap &quot;rm=
 -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77&quot=
; 1 2 15</span><br><span> trap &quot;rm -f key.$$ tc-server-key.$$ tc-clien=
t-key.$$ log.$$ ; exit 1&quot; 0 3</span><br><span> </span><br><span>@@ -71=
,7 +72,7 @@</span><br><span> </span><br><span> </span><br><span> # Get list=
 of supported ciphers from openvpn --show-ciphers output</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-CIPHERS=3D$(${top_builddir}/src/openvpn/=
openvpn --show-ciphers | \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+CIPHERS=3D$(${openvpn} --show-ciphers | \</span><br><span>          =
   sed -e &#39;/The following/,/^$/d&#39; -e s&#39;/ .*//&#39; -e &#39;/^[[=
:space:]]*$/d&#39;)</span><br><span> </span><br><span> # SK, 2014-06-04: cu=
rrently the DES-EDE3-CFB1 implementation of OpenSSL is</span><br><span>@@ -=
90,23 +91,23 @@</span><br><span> # Also test cipher &#39;none&#39;</span><b=
r><span> CIPHERS=3D${CIPHERS}$(printf &quot;\nnone&quot;)</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&quot;${top_builddir}=
/src/openvpn/openvpn&quot; --genkey secret key.$$</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+&quot;${openvpn}&quot; --genkey secret key.$$=
</span><br><span> set +e</span><br><span> </span><br><span> for cipher in $=
{CIPHERS}</span><br><span> do</span><br><span>     test_start &quot;Testing=
 cipher ${cipher}... &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ( &quot;${top_builddir}/src/openvpn/openvpn&quot; --test-crypto -=
-secret key.$$ --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ( &quot;${openvpn}&quot; --test-=
crypto --secret key.$$ --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><b=
r><span>     test_end $? log.$$</span><br><span> done</span><br><span> </sp=
an><br><span> test_start &quot;Testing tls-crypt-v2 server key generation..=
. &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-&quot;${top_b=
uilddir}/src/openvpn/openvpn&quot; \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+&quot;${openvpn}&quot; \</span><br><span>     --genkey tls=
-crypt-v2-server tc-server-key.$$ &gt;log.$$ 2&gt;&amp;1</span><br><span> t=
est_end $? log.$$</span><br><span> </span><br><span> test_start &quot;Testi=
ng tls-crypt-v2 key generation (no metadata)... &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-&quot;${top_builddir}/src/openvpn/openvpn&=
quot; --tls-crypt-v2 tc-server-key.$$ \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+&quot;${openvpn}&quot; --tls-crypt-v2 tc-server-key.$$ =
\</span><br><span>     --genkey tls-crypt-v2-client tc-client-key.$$ &gt;lo=
g.$$ 2&gt;&amp;1</span><br><span> test_end $? log.$$</span><br><span> </spa=
n><br><span>@@ -118,7 +119,7 @@</span><br><span>     i=3D$(expr $i + 1)</sp=
an><br><span> done</span><br><span> test_start &quot;Testing tls-crypt-v2 k=
ey generation (max length metadata)... &quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-&quot;${top_builddir}/src/openvpn/openvpn&quot; --t=
ls-crypt-v2 tc-server-key.$$ \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+&quot;${openvpn}&quot; --tls-crypt-v2 tc-server-key.$$ \</span><=
br><span>     --genkey tls-crypt-v2-client tc-client-key.$$ &quot;${METADAT=
A}&quot; \</span><br><span>     &gt;log.$$ 2&gt;&amp;1</span><br><span> tes=
t_end $? log.$$</span><br><span>diff --git a/tests/t_net.sh b/tests/t_net.s=
h</span><br><span>index bc91f82..8134832 100755</span><br><span>--- a/tests=
/t_net.sh</span><br><span>+++ b/tests/t_net.sh</span><br><span>@@ -7,7 +7,7=
 @@</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-.}&quot;</s=
pan><br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-openvpn=3D&quot;${top_builddir}/src=
/openvpn/openvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</s=
pan><br><span> </span><br><span> </span><br><span> # bail out right away on=
 non-linux. NetLink (the object of this test) is only</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1424?usp=3Demail">change 1424</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1424?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida7a64a299cd5bf7ae4f0cc7257=
56b5f5cc408f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1424 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--ZA3+0R/EHGU=--

