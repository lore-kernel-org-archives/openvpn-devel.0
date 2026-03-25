From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 15:38:33 +0000
In-Reply-To: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@...2715...>
References: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <8e3274aec9da18aaac466d39a50c22aacaa33517-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nY1LFMwbWag="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_networking:
 Allow to test --netns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, its_Giaan <gianmarco@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nY1LFMwbWag=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello its_Giaan, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1586?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by its_Giaan


Change subject: test_networking: Allow to test --netns
......................................................................

test_networking: Allow to test --netns

While here also do some cleanups:
- Run under set -eu to better catch errors
- Some comment improvments
- Fix argument handling in test_networking, it
  actually ignored the interface argument

Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_net.sh
M tests/unit_tests/openvpn/test_networking.c
2 files changed, 58 insertions(+), 34 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1586/2

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 8134832..e388971 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -1,8 +1,14 @@
 #!/usr/bin/env bash
+# Requires bash due to array handling

-IFACE=3D"ovpn-dummy0"
+set -eu
+
+IFACE=3D"${IFACE:-ovpn-dummy0}"
+NETNS=3D${NETNS:-}
 UNIT_TEST=3D"./unit_tests/openvpn/networking_testdriver"
+# Tests 0 to LAST_AUTO_TEST output a ip command to compare results
 LAST_AUTO_TEST=3D7
+# Tests after LAST_AUTO_TEST are only executed, no comparison
 LAST_TEST=3D8

 srcdir=3D"${srcdir:-.}"
@@ -12,33 +18,19 @@

 # bail out right away on non-linux. NetLink (the object of this test) is o=
nly
 # used on Linux, therefore testing other platform is not needed.
-#
-# Note: statements in the rest of the script may not even pass syntax chec=
k on
-# solaris/bsd. It uses /bin/bash
 if [ "$(uname -s)" !=3D "Linux" ]; then
     echo "$0: this test runs only on Linux. SKIPPING TEST."
     exit 77
 fi

-# Commands used to retrieve the network state.
-# State is retrieved after running sitnl and after running
-# iproute commands. The two are then compared and expected to be equal.
-typeset -a GET_STATE
-GET_STATE[0]=3D"ip link show dev $IFACE | sed 's/^[0-9]\+: //'"
-GET_STATE[1]=3D"ip addr show dev $IFACE | sed 's/^[0-9]\+: //'"
-GET_STATE[2]=3D"ip route show dev $IFACE"
-GET_STATE[3]=3D"ip -6 route show dev $IFACE"
-
-LAST_STATE=3D$((${#GET_STATE[@]} - 1))
-
 reload_dummy()
 {
-    $RUN_SUDO ip link del $IFACE
-    $RUN_SUDO ip link add $IFACE address 00:11:22:33:44:55 type dummy
-    $RUN_SUDO ip link set dev $IFACE state up
+    $RUN_SUDO $IP_EXEC ip link del $IFACE || true
+    $RUN_SUDO $IP_EXEC ip link add $IFACE address 00:11:22:33:44:55 type d=
ummy
+    $RUN_SUDO $IP_EXEC ip link set dev $IFACE state up

     if [ $? -ne 0 ]; then
-        echo "can't create interface $IFACE"
+        echo "can't create interface $IFACE $IP_NETNS"
         exit 1
     fi
 }
@@ -51,7 +43,7 @@
         # the unit-test prints to stdout the iproute command corresponding
         # to the sitnl operation being executed.
         # Format is "CMD: <commandhere>"
-        OUT=3D$($RUN_SUDO $UNIT_TEST $k $IFACE)
+        OUT=3D$($RUN_SUDO $UNIT_TEST $k $IFACE $NETNS)
         # ensure unit test worked properly
         if [ $? -ne 0 ]; then
             echo "unit-test $k errored out:"
@@ -60,7 +52,7 @@
         fi

         NEW=3D$(echo "$OUT" | sed -n 's/CMD: //p')
-        CMD=3D"$CMD $RUN_SUDO $NEW ;"
+        CMD=3D"$CMD $IP_EXEC $NEW ;"
     done

     # collect state for later comparison
@@ -72,13 +64,18 @@

 ## execution starts here

+set +eu
+
 # t_client.rc required only for RUN_SUDO definition
+RUN_SUDO=3D
 if [ -r "${top_builddir}"/t_client.rc ]; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ]; then
     . "${srcdir}"/t_client.rc
 fi

+set -eu
+
 if [ ! -x "$openvpn" ]; then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
@@ -129,6 +126,24 @@
     fi
 fi

+IP_EXEC=3D"$RUN_SUDO"
+if [ -n "$NETNS" ]; then
+    echo "Using netns $NETNS"
+    [ -f "/run/netns/$NETNS" ] || $RUN_SUDO ip netns add "$NETNS"
+    IP_EXEC=3D"$RUN_SUDO ip netns exec $NETNS"
+fi
+
+# Commands used to retrieve the network state.
+# State is retrieved after running sitnl and after running
+# iproute commands. The two are then compared and expected to be equal.
+typeset -a GET_STATE
+GET_STATE[0]=3D"$IP_EXEC ip link show dev $IFACE | sed 's/^[0-9]\+: //'"
+GET_STATE[1]=3D"$IP_EXEC ip addr show dev $IFACE | sed 's/^[0-9]\+: //'"
+GET_STATE[2]=3D"$IP_EXEC ip route show dev $IFACE"
+GET_STATE[3]=3D"$IP_EXEC ip -6 route show dev $IFACE"
+
+LAST_STATE=3D$((${#GET_STATE[@]} - 1))
+
 for i in $(seq 0 $LAST_AUTO_TEST); do
     # reload dummy module to cleanup state
     reload_dummy
@@ -167,7 +182,7 @@
 done

 # remove interface for good
-$RUN_SUDO ip link del $IFACE
+$IP_EXEC ip link del $IFACE

 for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
     $RUN_SUDO $UNIT_TEST $i
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/=
openvpn/test_networking.c
index 1c9cac1..4e2cce8 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -6,26 +6,27 @@
 #include <cmocka.h>

 static char *iface =3D "ovpn-dummy0";
+static openvpn_net_ctx_t *ctx =3D NULL;

 static int
 net__iface_up(bool up)
 {
     printf("CMD: ip link set %s %s\n", iface, up ? "up" : "down");

-    return net_iface_up(NULL, iface, up);
+    return net_iface_up(ctx, iface, up);
 }

 static int
 net__iface_new(const char *name, const char *type)
 {
-    return net_iface_new(NULL, name, type, NULL);
+    return net_iface_new(ctx, name, type, NULL);
 }

 static int
 net__iface_type(const char *name, const char *type)
 {
     char ret_type[IFACE_TYPE_LEN_MAX];
-    int ret =3D net_iface_type(NULL, name, ret_type);
+    int ret =3D net_iface_type(ctx, name, ret_type);
     if (ret =3D=3D 0)
     {
         assert_string_equal(type, ret_type);
@@ -37,7 +38,7 @@
 static int
 net__iface_del(const char *name)
 {
-    return net_iface_del(NULL, name);
+    return net_iface_del(ctx, name);
 }

 static int
@@ -45,7 +46,7 @@
 {
     printf("CMD: ip link set %s mtu %d\n", iface, mtu);

-    return net_iface_mtu_set(NULL, iface, mtu);
+    return net_iface_mtu_set(ctx, iface, mtu);
 }

 static int
@@ -64,7 +65,7 @@

     printf("CMD: ip addr add %s/%d dev %s broadcast +\n", addr_str, prefix=
len, iface);

-    return net_addr_v4_add(NULL, iface, &addr, prefixlen);
+    return net_addr_v4_add(ctx, iface, &addr, prefixlen);
 }

 static int
@@ -81,7 +82,7 @@

     printf("CMD: ip -6 addr add %s/%d dev %s\n", addr_str, prefixlen, ifac=
e);

-    return net_addr_v6_add(NULL, iface, &addr, prefixlen);
+    return net_addr_v6_add(ctx, iface, &addr, prefixlen);
 }

 static int
@@ -110,7 +111,7 @@
     }
     printf("\n");

-    return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v4_add(ctx, &dst, prefixlen, NULL, iface, 0, metric);
 }

 static int
@@ -146,7 +147,7 @@
     }
     printf("\n");

-    return net_route_v4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v4_add(ctx, &dst, prefixlen, &gw, iface, 0, metric);
 }

 static int
@@ -173,7 +174,7 @@
     }
     printf("\n");

-    return net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v6_add(ctx, &dst, prefixlen, NULL, iface, 0, metric);
 }

 static int
@@ -206,7 +207,7 @@
     }
     printf("\n");
=20
-    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v6_add(ctx, &dst, prefixlen, &gw, iface, 0, metric);
 }

 static void
@@ -232,11 +233,19 @@
         return 0;
     }

-    if (argc > 3)
+    if (argc >=3D 3)
     {
         iface =3D argv[2];
     }

+    if (argc >=3D 4)
+    {
+        ctx =3D malloc(sizeof(*ctx));
+        CLEAR(*ctx);
+        ctx->netns =3D argv[3];
+        ctx->gc =3D gc_new();
+    }
+
     test =3D atoi(argv[1]);
     switch (test)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1586?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9
Gerrit-Change-Number: 1586
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--nY1LFMwbWag=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1586?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by its_Giaan</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">test_networking: Allow to test =
--netns<br><br>While here also do some cleanups:<br>- Run under set -eu to =
better catch errors<br>- Some comment improvments<br>- Fix argument handlin=
g in test_networking, it<br>  actually ignored the interface argument<br><b=
r>Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/t_net.sh<br>M te=
sts/unit_tests/openvpn/test_networking.c<br>2 files changed, 58 insertions(=
+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/86/1586/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_net=
.sh b/tests/t_net.sh</span><br><span>index 8134832..e388971 100755</span><b=
r><span>--- a/tests/t_net.sh</span><br><span>+++ b/tests/t_net.sh</span><br=
><span>@@ -1,8 +1,14 @@</span><br><span> #!/usr/bin/env bash</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Requires bash due to array handl=
ing</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
IFACE=3D&quot;ovpn-dummy0&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+set -eu</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IFACE=3D&quot;${IFA=
CE:-ovpn-dummy0}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+NETNS=3D${NETNS:-}</span><br><span> UNIT_TEST=3D&quot;./unit_tests/openv=
pn/networking_testdriver&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# Tests 0 to LAST_AUTO_TEST output a ip command to compare resul=
ts</span><br><span> LAST_AUTO_TEST=3D7</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# Tests after LAST_AUTO_TEST are only executed, no compa=
rison</span><br><span> LAST_TEST=3D8</span><br><span> </span><br><span> src=
dir=3D&quot;${srcdir:-.}&quot;</span><br><span>@@ -12,33 +18,19 @@</span><b=
r><span> </span><br><span> # bail out right away on non-linux. NetLink (the=
 object of this test) is only</span><br><span> # used on Linux, therefore t=
esting other platform is not needed.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Not=
e: statements in the rest of the script may not even pass syntax check on</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# solaris/bsd. It uses =
/bin/bash</span><br><span> if [ &quot;$(uname -s)&quot; !=3D &quot;Linux&qu=
ot; ]; then</span><br><span>     echo &quot;$0: this test runs only on Linu=
x. SKIPPING TEST.&quot;</span><br><span>     exit 77</span><br><span> fi</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Comm=
ands used to retrieve the network state.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# State is retrieved after running sitnl and after runni=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# iproute commands.=
 The two are then compared and expected to be equal.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-typeset -a GET_STATE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-GET_STATE[0]=3D&quot;ip link show dev $IFAC=
E | sed &#39;s/^[0-9]\+: //&#39;&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-GET_STATE[1]=3D&quot;ip addr show dev $IFACE | sed &#39;s/=
^[0-9]\+: //&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-GET_STATE[2]=3D&quot;ip route show dev $IFACE&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-GET_STATE[3]=3D&quot;ip -6 route show dev $=
IFACE&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-LAST_STATE=3D$((${#GET_STATE[@]=
} - 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> reload_dummy()</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    $RUN_SUDO ip link del $IFACE</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    $RUN_SUDO ip link add $IFACE address 00:11:2=
2:33:44:55 type dummy</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    $RUN_SUDO ip link set dev $IFACE state up</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    $RUN_SUDO $IP_EXEC ip link del $IFACE || true=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO $IP_E=
XEC ip link add $IFACE address 00:11:22:33:44:55 type dummy</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO $IP_EXEC ip link set =
dev $IFACE state up</span><br><span> </span><br><span>     if [ $? -ne 0 ];=
 then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &qu=
ot;can&#39;t create interface $IFACE&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        echo &quot;can&#39;t create interface $IFACE=
 $IP_NETNS&quot;</span><br><span>         exit 1</span><br><span>     fi</s=
pan><br><span> }</span><br><span>@@ -51,7 +43,7 @@</span><br><span>        =
 # the unit-test prints to stdout the iproute command corresponding</span><=
br><span>         # to the sitnl operation being executed.</span><br><span>=
         # Format is &quot;CMD: &lt;commandhere&gt;&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        OUT=3D$($RUN_SUDO $UNIT_TEST $k=
 $IFACE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OUT=
=3D$($RUN_SUDO $UNIT_TEST $k $IFACE $NETNS)</span><br><span>         # ensu=
re unit test worked properly</span><br><span>         if [ $? -ne 0 ]; then=
</span><br><span>             echo &quot;unit-test $k errored out:&quot;</s=
pan><br><span>@@ -60,7 +52,7 @@</span><br><span>         fi</span><br><span=
> </span><br><span>         NEW=3D$(echo &quot;$OUT&quot; | sed -n &#39;s/C=
MD: //p&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
CMD=3D&quot;$CMD $RUN_SUDO $NEW ;&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        CMD=3D&quot;$CMD $IP_EXEC $NEW ;&quot;</span><b=
r><span>     done</span><br><span> </span><br><span>     # collect state fo=
r later comparison</span><br><span>@@ -72,13 +64,18 @@</span><br><span> </s=
pan><br><span> ## execution starts here</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+set +eu</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> # t_client.rc required only for=
 RUN_SUDO definition</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+RUN_SUDO=3D</span><br><span> if [ -r &quot;${top_builddir}&quot;/t_client.=
rc ]; then</span><br><span>     . &quot;${top_builddir}&quot;/t_client.rc</=
span><br><span> elif [ -r &quot;${srcdir}&quot;/t_client.rc ]; then</span><=
br><span>     . &quot;${srcdir}&quot;/t_client.rc</span><br><span> fi</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -eu=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> i=
f [ ! -x &quot;$openvpn&quot; ]; then</span><br><span>     echo &quot;no (e=
xecutable) openvpn binary in current build tree. FAIL.&quot; &gt;&amp;2</sp=
an><br><span>     exit 1</span><br><span>@@ -129,6 +126,24 @@</span><br><sp=
an>     fi</span><br><span> fi</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+IP_EXEC=3D&quot;$RUN_SUDO&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$NETNS&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;Usin=
g netns $NETNS&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [ -f &quot;/run/netns/$NETNS&quot; ] || $RUN_SUDO ip netns add &quot;$=
NETNS&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IP_E=
XEC=3D&quot;$RUN_SUDO ip netns exec $NETNS&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Comma=
nds used to retrieve the network state.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# State is retrieved after running sitnl and after runn=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# iproute comman=
ds. The two are then compared and expected to be equal.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+typeset -a GET_STATE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+GET_STATE[0]=3D&quot;$IP_EXEC ip link =
show dev $IFACE | sed &#39;s/^[0-9]\+: //&#39;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+GET_STATE[1]=3D&quot;$IP_EXEC ip addr sho=
w dev $IFACE | sed &#39;s/^[0-9]\+: //&#39;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+GET_STATE[2]=3D&quot;$IP_EXEC ip route show d=
ev $IFACE&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GET_=
STATE[3]=3D&quot;$IP_EXEC ip -6 route show dev $IFACE&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+LAST_STATE=3D$((${#GET_STATE[@]} - 1))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> for i in $(seq 0 =
$LAST_AUTO_TEST); do</span><br><span>     # reload dummy module to cleanup =
state</span><br><span>     reload_dummy</span><br><span>@@ -167,7 +182,7 @@=
</span><br><span> done</span><br><span> </span><br><span> # remove interfac=
e for good</span><br><span style=3D"color: hsl(0, 100%, 40%);">-$RUN_SUDO i=
p link del $IFACE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+$I=
P_EXEC ip link del $IFACE</span><br><span> </span><br><span> for i in $(seq=
 $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span>     $RUN_SUDO =
$UNIT_TEST $i</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ne=
tworking.c b/tests/unit_tests/openvpn/test_networking.c</span><br><span>ind=
ex 1c9cac1..4e2cce8 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_networking.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_networ=
king.c</span><br><span>@@ -6,26 +6,27 @@</span><br><span> #include &lt;cmoc=
ka.h&gt;</span><br><span> </span><br><span> static char *iface =3D &quot;ov=
pn-dummy0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic openvpn_net_ctx_t *ctx =3D NULL;</span><br><span> </span><br><span> sta=
tic int</span><br><span> net__iface_up(bool up)</span><br><span> {</span><b=
r><span>     printf(&quot;CMD: ip link set %s %s\n&quot;, iface, up ? &quot=
;up&quot; : &quot;down&quot;);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return net_iface_up(NULL, iface, up);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_iface_up(ct=
x, iface, up);</span><br><span> }</span><br><span> </span><br><span> static=
 int</span><br><span> net__iface_new(const char *name, const char *type)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn net_iface_new(NULL, name, type, NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return net_iface_new(ctx, name, type, NULL);</=
span><br><span> }</span><br><span> </span><br><span> static int</span><br><=
span> net__iface_type(const char *name, const char *type)</span><br><span> =
{</span><br><span>     char ret_type[IFACE_TYPE_LEN_MAX];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_iface_type(NULL, na=
me, ret_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ret =3D net_iface_type(ctx, name, ret_type);</span><br><span>     if (re=
t =3D=3D 0)</span><br><span>     {</span><br><span>         assert_string_e=
qual(type, ret_type);</span><br><span>@@ -37,7 +38,7 @@</span><br><span> st=
atic int</span><br><span> net__iface_del(const char *name)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return net_ifac=
e_del(NULL, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return net_iface_del(ctx, name);</span><br><span> }</span><br><span> </s=
pan><br><span> static int</span><br><span>@@ -45,7 +46,7 @@</span><br><span=
> {</span><br><span>     printf(&quot;CMD: ip link set %s mtu %d\n&quot;, i=
face, mtu);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return net_iface_mtu_set(NULL, iface, mtu);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return net_iface_mtu_set(ctx, iface=
, mtu);</span><br><span> }</span><br><span> </span><br><span> static int</s=
pan><br><span>@@ -64,7 +65,7 @@</span><br><span> </span><br><span>     prin=
tf(&quot;CMD: ip addr add %s/%d dev %s broadcast +\n&quot;, addr_str, prefi=
xlen, iface);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return net_addr_v4_add(NULL, iface, &amp;addr, prefixlen);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_addr_v4=
_add(ctx, iface, &amp;addr, prefixlen);</span><br><span> }</span><br><span>=
 </span><br><span> static int</span><br><span>@@ -81,7 +82,7 @@</span><br><=
span> </span><br><span>     printf(&quot;CMD: ip -6 addr add %s/%d dev %s\n=
&quot;, addr_str, prefixlen, iface);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return net_addr_v6_add(NULL, iface, &a=
mp;addr, prefixlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return net_addr_v6_add(ctx, iface, &amp;addr, prefixlen);</span><br><s=
pan> }</span><br><span> </span><br><span> static int</span><br><span>@@ -11=
0,7 +111,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&q=
uot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, m=
etric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return n=
et_route_v4_add(ctx, &amp;dst, prefixlen, NULL, iface, 0, metric);</span><b=
r><span> }</span><br><span> </span><br><span> static int</span><br><span>@@=
 -146,7 +147,7 @@</span><br><span>     }</span><br><span>     printf(&quot;=
\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, ifac=
e, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn net_route_v4_add(ctx, &amp;dst, prefixlen, &amp;gw, iface, 0, metric)=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span>@@ -173,7 +174,7 @@</span><br><span>     }</span><br><span>     pri=
ntf(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, NUL=
L, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return net_route_v6_add(ctx, &amp;dst, prefixlen, NULL, iface, 0, met=
ric);</span><br><span> }</span><br><span> </span><br><span> static int</spa=
n><br><span>@@ -206,7 +207,7 @@</span><br><span>     }</span><br><span>    =
 printf(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen,=
 &amp;gw, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return net_route_v6_add(ctx, &amp;dst, prefixlen, &amp;gw, ifa=
ce, 0, metric);</span><br><span> }</span><br><span> </span><br><span> stati=
c void</span><br><span>@@ -232,11 +233,19 @@</span><br><span>         retur=
n 0;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (argc &gt; 3)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (argc &gt;=3D 3)</span><br><span>     {</sp=
an><br><span>         iface =3D argv[2];</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argc =
&gt;=3D 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ctx =3D malloc(=
sizeof(*ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   CLEAR(*ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ctx-&gt;netns =3D argv[3];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ctx-&gt;gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     test =3D atoi(argv[1]);</span><br><span>   =
  switch (test)</span><br><span>     {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1586?usp=3D=
email">change 1586</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1586?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3=
364dac9e8b6d9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1586 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--nY1LFMwbWag=--

