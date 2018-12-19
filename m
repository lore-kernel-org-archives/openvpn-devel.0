From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Dec 2018 15:01:17 +1000
Message-Id: <20181219050118.6568-7-a@...2181...>
In-Reply-To: <20181219050118.6568-1-a@...2181...>
References: <20181219050118.6568-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 6/7] unit tests: implement test for sitnl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

This patch introduces a new unit test that is not executed
by the cmocka framework, but rather used by a new t_net.sh
bash script.

The idea behind this test is to ensure that invoking sitnl
functions or running iproute commands leads to the same
networking (interface and routing table) state.

To achieve this, the t_net.sh script first runs a binary
implemented invoking sitnl functions and then takes a
"screenshot" of the state. Subsequently a series of
iproute commands, expected to mimic exactly the same behaviour
as the sitnl functions invoked before, are executed.
The final state is then compared with the screenshot
previously taken.

If no mismatching is found, the test is passed.

The current unit_test, however, does not cover all the
sitnl functionalities and it is expected to be extended
in the future.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac                               |   2 +
 tests/Makefile.am                          |   3 +-
 tests/t_net.sh                             | 180 ++++++++++++++++
 tests/unit_tests/openvpn/Makefile.am       |  30 ++-
 tests/unit_tests/openvpn/test_networking.c | 229 +++++++++++++++++++++
 5 files changed, 438 insertions(+), 6 deletions(-)
 create mode 100755 tests/t_net.sh
 create mode 100644 tests/unit_tests/openvpn/test_networking.c

diff --git a/configure.ac b/configure.ac
index 2a51ad46..90666f04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -294,9 +294,11 @@ else
 fi
 
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
+AM_CONDITIONAL([TARGET_LINUX], [false])
 case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
+		AM_CONDITIONAL([TARGET_LINUX], [true])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
 		have_sitnl="yes"
 		;;
diff --git a/tests/Makefile.am b/tests/Makefile.am
index e6803864..67acf7e3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,7 +14,8 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
-test_scripts = t_client.sh
+test_scripts = t_net.sh
+test_scripts += t_client.sh
 test_scripts += t_lpback.sh t_cltsrv.sh
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
diff --git a/tests/t_net.sh b/tests/t_net.sh
new file mode 100755
index 00000000..0be5bb42
--- /dev/null
+++ b/tests/t_net.sh
@@ -0,0 +1,180 @@
+#!/bin/sh
+
+IFACE="dummy0"
+UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
+MAX_TEST=${1:-7}
+
+KILL_EXEC=`which kill`
+CC=${CC:-gcc}
+
+srcdir="${srcdir:-.}"
+top_builddir="${top_builddir:-..}"
+openvpn="${top_builddir}/src/openvpn/openvpn"
+
+
+# bail out right away on non-linux. NetLink (the object of this test) is only
+# used on Linux, therefore testing other platform is not needed.
+#
+# Note: statements in the rest of the script may not even pass syntax check on
+# solaris/bsd. It uses /bin/bash
+if [ "$(uname -s)" != "Linux" ]; then
+    echo "$0: this test runs only on Linux. SKIPPING TEST."
+    exit 77
+fi
+
+# Commands used to retrieve the network state.
+# State is retrieved after running sitnl and after running
+# iproute commands. The two are then compared and expected to be equal.
+typeset -a GET_STATE
+GET_STATE[0]="ip link show dev $IFACE | sed 's/^[0-9]\+: //'"
+GET_STATE[1]="ip addr show dev $IFACE | sed 's/^[0-9]\+: //'"
+GET_STATE[2]="ip route show dev $IFACE"
+GET_STATE[3]="ip -6 route show dev $IFACE"
+
+LAST_STATE=$((${#GET_STATE[@]} - 1))
+
+reload_dummy()
+{
+    $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
+    $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --mktun >/dev/null
+    if [ $? -ne 0 ]; then
+        echo "can't create interface $IFACE"
+        exit 1
+    fi
+
+    #ip link set dev $IFACE address 00:11:22:33:44:55
+}
+
+run_test()
+{
+    # run all test cases from 0 to $1 in sequence
+    CMD=
+    for k in $(seq 0 $1); do
+        # the unit-test prints to stdout the iproute command corresponding
+        # to the sitnl operation being executed.
+        # Format is "CMD: <commandhere>"
+        OUT=$($RUN_SUDO $UNIT_TEST $k $IFACE)
+        # ensure unit test worked properly
+        if [ $? -ne 0 ]; then
+            echo "unit-test $k errored out:"
+            echo "$OUT"
+            exit 1
+        fi
+
+        NEW=$(echo "$OUT" | sed -n 's/CMD: //p')
+        CMD="$CMD $RUN_SUDO $NEW ;"
+    done
+
+    # collect state for later comparison
+    for k in $(seq 0 $LAST_STATE); do
+        STATE_TEST[$k]="$(eval ${GET_STATE[$k]})"
+    done
+}
+
+
+## execution starts here
+
+if [ -r "${top_builddir}"/t_client.rc ]; then
+    . "${top_builddir}"/t_client.rc
+elif [ -r "${srcdir}"/t_client.rc ]; then
+    . "${srcdir}"/t_client.rc
+else
+    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
+    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
+    exit 77
+fi
+
+if [ ! -x "$openvpn" ]; then
+    echo "no (executable) openvpn binary in current build tree. FAIL." >&2
+    exit 1
+fi
+
+if [ ! -x "$UNIT_TEST" ]; then
+    echo "no test_networking driver available. SKIPPING TEST." >&2
+    exit 77
+fi
+
+
+# Ensure PREFER_KSU is in a known state
+PREFER_KSU="${PREFER_KSU:-0}"
+
+# make sure we have permissions to run ifconfig/route from OpenVPN
+# can't use "id -u" here - doesn't work on Solaris
+ID=`id`
+if expr "$ID" : "uid=0" >/dev/null
+then :
+else
+    if [ "${PREFER_KSU}" -eq 1 ];
+    then
+        # Check if we have a valid kerberos ticket
+        klist -l 1>/dev/null 2>/dev/null
+        if [ $? -ne 0 ];
+        then
+            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
+            PREFER_KSU=0
+            echo "$0: No Kerberos ticket available.  Will not use ksu."
+        else
+            RUN_SUDO="ksu -q -e"
+        fi
+    fi
+
+    if [ -z "$RUN_SUDO" ]
+    then
+        echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
+        echo "      must be set correctly in 't_client.rc'. SKIP." >&2
+        exit 77
+    else
+        # We have to use sudo. Make sure that we (hopefully) do not have
+        # to ask the users password during the test. This is done to
+        # prevent timing issues, e.g. when the waits for openvpn to start
+	    if $RUN_SUDO $KILL_EXEC -0 $$
+        then
+	        echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+        else
+	        echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+	        exit 77
+        fi
+    fi
+fi
+
+for i in $(seq 0 $MAX_TEST); do
+    # reload dummy module to cleanup state
+    reload_dummy
+    typeset -a STATE_TEST
+    run_test $i
+
+    # reload dummy module to cleanup state before running iproute commands
+    reload_dummy
+
+    # CMD has been set by the unit test
+    eval $CMD
+    if [ $? -ne 0 ]; then
+        echo "error while executing:"
+        echo "$CMD"
+        exit 1
+    fi
+
+    # collect state after running manual ip command
+    for k in $(seq 0 $LAST_STATE); do
+        STATE_IP[$k]="$(eval ${GET_STATE[$k]})"
+    done
+
+    # ensure states after running unit test matches the one after running
+    # manual iproute commands
+    for j in $(seq 0 $LAST_STATE); do
+        if [ "${STATE_TEST[$j]}" != "${STATE_IP[$j]}" ]; then
+            echo "state $j mismatching after '$CMD'"
+            echo "after unit-test:"
+            echo "${STATE_TEST[$j]}"
+            echo "after iproute command:"
+            echo "${STATE_IP[$j]}"
+            exit 1
+        fi
+    done
+
+done
+
+# remove interface for good
+$RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
+
+exit 0
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b4304e35..e4471c09 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,17 +1,22 @@
 AUTOMAKE_OPTIONS = foreign
 
-check_PROGRAMS=
+test_binaries=
 
 if HAVE_LD_WRAP_SUPPORT
-check_PROGRAMS += argv_testdriver buffer_testdriver
+test_binaries += argv_testdriver buffer_testdriver
 endif
 
-check_PROGRAMS += crypto_testdriver packet_id_testdriver
+test_binaries += crypto_testdriver packet_id_testdriver
 if HAVE_LD_WRAP_SUPPORT
-check_PROGRAMS += tls_crypt_testdriver
+test_binaries += tls_crypt_testdriver
 endif
 
-TESTS = $(check_PROGRAMS)
+TESTS = $(test_binaries)
+check_PROGRAMS = $(test_binaries)
+
+if TARGET_LINUX
+check_PROGRAMS += networking_testdriver
+endif
 
 openvpn_includedir = $(top_srcdir)/include
 openvpn_srcdir = $(top_srcdir)/src/openvpn
@@ -68,3 +73,18 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/run_command.c
+
+networking_testdriver_CFLAGS = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+networking_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_LIBS)
+networking_testdriver_SOURCES = test_networking.c mock_msg.c \
+	$(openvpn_srcdir)/networking_sitnl.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
new file mode 100644
index 00000000..66035011
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -0,0 +1,229 @@
+#include "config.h"
+#include "syshead.h"
+#include "networking.h"
+
+#include "mock_msg.h"
+
+
+static char *iface = "dummy0";
+
+#ifdef ENABLE_SITNL
+
+static int
+net__iface_up(bool up)
+{
+    printf("CMD: ip link set %s %s\n", iface, up ? "up" : "down");
+
+    return net_iface_up(NULL, iface, up);
+}
+
+static int
+net__iface_mtu_set(int mtu)
+{
+    printf("CMD: ip link set %s mtu %d\n", iface, mtu);
+
+    return net_iface_mtu_set(NULL, iface, mtu);
+}
+
+static int
+net__addr_v4_add(const char *addr_str, int prefixlen, const char *brd_str)
+{
+    in_addr_t addr, brd;
+    int ret;
+
+    ret = inet_pton(AF_INET, addr_str, &addr);
+    if (ret != 1)
+        return -1;
+
+    ret = inet_pton(AF_INET, brd_str, &brd);
+    if (ret != 1)
+        return -1;
+
+    addr = ntohl(addr);
+    brd = ntohl(brd);
+
+    printf("CMD: ip addr add %s/%d brd %s dev %s\n", addr_str, prefixlen,
+           brd_str, iface);
+
+    return net_addr_v4_add(NULL, iface, &addr, prefixlen, &brd);
+}
+
+static int
+net__addr_v6_add(const char *addr_str, int prefixlen)
+{
+    struct in6_addr addr;
+    int ret;
+
+    ret = inet_pton(AF_INET6, addr_str, &addr);
+    if (ret != 1)
+        return -1;
+
+    printf("CMD: ip -6 addr add %s/%d dev %s\n", addr_str, prefixlen, iface);
+
+    return net_addr_v6_add(NULL, iface, &addr, prefixlen);
+}
+
+static int
+net__route_v4_add(const char *dst_str, int prefixlen, int metric)
+{
+    in_addr_t dst;
+    int ret;
+
+    if (!dst_str)
+        return -1;
+
+    ret = inet_pton(AF_INET, dst_str, &dst);
+    if (ret != 1)
+        return -1;
+
+    dst = ntohl(dst);
+
+    printf("CMD: ip route add %s/%d dev %s", dst_str, prefixlen, iface);
+    if (metric > 0)
+        printf(" metric %d", metric);
+    printf("\n");
+
+    return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+
+}
+
+static int
+net__route_v4_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
+                     int metric)
+{
+    in_addr_t dst, gw;
+    int ret;
+
+    if (!dst_str || !gw_str)
+        return -1;
+
+    ret = inet_pton(AF_INET, dst_str, &dst);
+    if (ret != 1)
+        return -1;
+
+    ret = inet_pton(AF_INET, gw_str, &gw);
+    if (ret != 1)
+        return -1;
+
+    dst = ntohl(dst);
+    gw = ntohl(gw);
+
+    printf("CMD: ip route add %s/%d dev %s via %s", dst_str, prefixlen, iface,
+           gw_str);
+    if (metric > 0)
+        printf(" metric %d", metric);
+    printf("\n");
+
+    return net_route_v4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+}
+
+static int
+net__route_v6_add(const char *dst_str, int prefixlen, int metric)
+{
+    struct in6_addr dst;
+    int ret;
+
+    if (!dst_str)
+        return -1;
+
+    ret = inet_pton(AF_INET6, dst_str, &dst);
+    if (ret != 1)
+        return -1;
+
+    printf("CMD: ip -6 route add %s/%d dev %s", dst_str, prefixlen, iface);
+    if (metric > 0)
+        printf(" metric %d", metric);
+    printf("\n");
+
+    return net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+
+}
+
+static int
+net__route_v6_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
+                     int metric)
+{
+    struct in6_addr dst, gw;
+    int ret;
+
+    if (!dst_str || !gw_str)
+        return -1;
+
+    ret = inet_pton(AF_INET6, dst_str, &dst);
+    if (ret != 1)
+        return -1;
+
+    ret = inet_pton(AF_INET6, gw_str, &gw);
+    if (ret != 1)
+        return -1;
+
+    printf("CMD: ip -6 route add %s/%d dev %s via %s", dst_str, prefixlen,
+           iface, gw_str);
+    if (metric > 0)
+        printf(" metric %d", metric);
+    printf("\n");
+
+    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+}
+
+static void
+usage(char *name)
+{
+    printf("Usage: %s <0-7>\n", name);
+}
+
+int
+main(int argc, char *argv[])
+{
+    int test;
+
+    mock_set_debug_level(10);
+
+    if (argc < 2)
+    {
+        usage(argv[0]);
+        return -1;
+    }
+
+    if (argc > 3)
+    {
+        iface = argv[2];
+    }
+
+    test = atoi(argv[1]);
+    switch (test)
+    {
+        case 0:
+            return net__iface_up(true);
+        case 1:
+            return net__iface_mtu_set(1281);
+        case 2:
+            return net__addr_v4_add("10.255.255.1", 24, "10.255.255.255");
+        case 3:
+            return net__addr_v6_add("2001::1", 64);
+        case 4:
+            return net__route_v4_add("11.11.11.0", 24, 0);
+        case 5:
+            return net__route_v4_add_gw("11.11.12.0", 24, "10.255.255.2", 0);
+        case 6:
+            return net__route_v6_add("2001:babe:cafe:babe::", 64, 600);
+        case 7:
+            return net__route_v6_add_gw("2001:cafe:babe::", 48, "2001::2", 600);
+        default:
+            printf("invalid test: %d\n", test);
+            break;
+    }
+
+    usage(argv[0]);
+    return -1;
+}
+
+#else
+
+int
+main(int argc, char *argv[])
+{
+    return 0;
+}
+
+#endif /* ENABLE_SITNL */
-- 
2.19.2


