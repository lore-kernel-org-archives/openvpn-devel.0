From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:33 +0100
Message-Id: <20211207121137.3221-5-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 4/8] ovpn-dco: introduce linux data-channel
 offload support
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

Implement the data-channel offloading using the ovpn-dco kernel
module. See README.dco.md for more details.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                                |   7 +
 README.dco.md                              | 124 +++
 configure.ac                               |  56 ++
 doc/man-sections/advanced-options.rst      |  13 +
 src/openvpn/Makefile.am                    |   8 +-
 src/openvpn/crypto.c                       |  10 +
 src/openvpn/crypto.h                       |   6 +
 src/openvpn/dco.c                          | 272 +++++++
 src/openvpn/dco.h                          | 118 +++
 src/openvpn/errlevel.h                     |   2 +
 src/openvpn/event.h                        |   3 +
 src/openvpn/forward.c                      |  66 +-
 src/openvpn/init.c                         | 153 +++-
 src/openvpn/init.h                         |   2 +-
 src/openvpn/mtcp.c                         |  61 +-
 src/openvpn/mudp.c                         |  13 +
 src/openvpn/multi.c                        | 278 ++++++-
 src/openvpn/multi.h                        |   6 +-
 src/openvpn/networking.h                   |   1 +
 src/openvpn/networking_linuxdco.c          | 848 +++++++++++++++++++++
 src/openvpn/networking_linuxdco.h          |  85 +++
 src/openvpn/openvpn.vcxproj                |   4 +-
 src/openvpn/openvpn.vcxproj.filters        |   6 +
 src/openvpn/options.c                      | 143 +++-
 src/openvpn/options.h                      |  26 +
 src/openvpn/socket.h                       |   1 +
 src/openvpn/ssl.c                          |   6 +-
 src/openvpn/ssl_common.h                   |  13 +
 src/openvpn/ssl_ncp.c                      |   2 +-
 src/openvpn/tun.c                          |  13 +-
 src/openvpn/tun.h                          |   4 +
 tests/unit_tests/openvpn/test_networking.c |   9 +-
 32 files changed, 2305 insertions(+), 54 deletions(-)
 create mode 100644 README.dco.md
 create mode 100644 src/openvpn/dco.c
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/networking_linuxdco.c
 create mode 100644 src/openvpn/networking_linuxdco.h

diff --git a/Changes.rst b/Changes.rst
index b7d7f205..b613d656 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -62,6 +62,13 @@ Optional ciphers in ``--data-ciphers``
     Ciphers in ``--data-ciphers`` can now be prefixed with a ``?`` to mark
     those as optional and only use them if the SSL library supports them.
 
+Data channel offloading with ovpn-dco
+    2.6.0+ implements support for data-channel offloading where the data packets
+    are directly processed and forwarded in kernel space thanks to the ovpn-dco
+    kernel module. The userspace openvpn program acts purely as a control plane
+    application.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/README.dco.md b/README.dco.md
new file mode 100644
index 00000000..e2500d36
--- /dev/null
+++ b/README.dco.md
@@ -0,0 +1,124 @@
+OpenVPN data channel offload
+============================
+2.6.0+ implements support for data-channel offloading where the data packets
+are directly processed and forwarded in kernel space thanks to the ovpn-dco
+kernel module. The userspace openvpn program acts purely as a control plane 
+application.
+
+Overview of current release
+---------------------------
+- See the "Limitations by design" and "Current limitations" sections for
+  features that are not and/or will not be supported by OpenVPN + ovpn-dco
+- The dco branch is based on my working branch and contains a number of
+  other patch sets that are not yet merged into the OpenVPN master branch
+  (e.g. --peer-fingerprint).
+
+
+Getting started (Linux)
+-----------------------
+
+- Use a recent Linux kernel. Ubuntu 20.04 (Linux 5.4.0) and Ubuntu 20.10
+  (Linux 5.8.0) are known to work with ovpn-dco.
+
+Get the ovpn-dco module from one these urls and build it:
+
+* https://gitlab.com/openvpn/ovpn-dco
+* https://github.com/OpenVPN/ovpn-dco
+
+e.g.
+
+    git clone https://github.com/OpenVPN/ovpn-dco
+    cd ovpn-dco
+    make 
+    sudo make install
+    
+If you want to report bugs please ensure to compile ovpn-dco with
+`make DEBUG=1` and include any debug message being printed by the
+kernel (you can view those messages with `dmesg`).
+
+Clone OpenVPN and build dco branch. For example:
+
+    git clone -b dco https://github.com/schwabe/openvpn.git
+    cd openvpn
+    autoreconf -vi
+    ./configure --enable-dco         
+    make
+    make install   # Or run just src/openvpn/openvpn
+
+If you start openvpn it should automatically detect DCO support and use the
+kernel module. Add the option `--disable-dco` to disable data channel offload
+support. If the configuration contains an option that is incompatible with
+data channel offloading OpenVPN will automatically disable DCO support and
+warn the user.
+
+Should OpenVPN be configured to use a feature that is not supported by ovpn-dco
+or should the ovpn-dco kernel module not be available on the system, you will
+see a message like
+
+    Note: Kernel support for ovpn-dco missing, disabling data channel offload.
+
+in your log.
+
+
+DCO and P2P mode
+----------------
+DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
+The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
+overall routing and behave more like a "dumb" tunnel like GRE.
+
+However, DCO requires DATA_V2 to be enabled this requires P2P with NCP capability, which
+is only available in OpenVPN 2.6 and later.
+
+OpenVPN prints a diagnostic message for the P2P NCP result when running in P2P mode:
+
+    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 9484735, cipher=AES-256-GCM
+
+Double check that your have `DATA_v2=1` in your output and a supported AEAD cipher
+(AES-GCM or Chacha20-Poly1305).
+
+Routing with ovpn-dco
+---------------------
+The ovpn-dco kernel module implements a more transparent approach to
+configuring routes to clients (aka 'iroutes') and consults the kernel
+routing tables for forwarding decisions.
+
+- Each client has an IPv4 VPN IP and/or an IPv6 assigned to it
+- Additional IP ranges can be routed to a client by adding a route with
+  a client VPN IP as the gateway/nexthop.
+- No internal routing (iroutes) is available. If you need truly internal
+  routes, this can be achieved either with filtering using `iptables` or
+  using `ip rule`.
+
+
+Limitations by design
+----------------------
+- Layer 3 (dev tun only)
+- only AEAD ciphers are supported and currently only 
+  Chacha20-Poly1305 and AES-GCM-128/192/256
+- no support for compression or compression framing 
+  - see also `--compress migrate` option to move to a setup with compression 
+- various features not implemented since have better replacements
+  - --shaper, use tc instead
+  - packet manipulation, use nftables/iptables instead
+- OpenVPN 2.4.0 is the minimum peer version.
+  - older version are missing support for the AEAD ciphers
+- topology subnet is the only supported `--topology` for servers
+- iroute directives install routes on the host operating system, see also
+  routing with ovpn-dco
+
+Current limitations
+-------------------
+- --persistent-tun not tested/supported
+- fallback to non-dco in client mode missing
+- IPv6 mapped IPv4 addresses need Linux 5.12 to properly work
+- Some incompatible options may not properly fallback to non-dco
+- TCP performance with ovpn-dco can still exhibit bad behaviour and drop to a
+  few megabits per seconds.
+- Not all options that should trigger disabling DCO as they are incompatible
+  are currently identified. Some options that do not trigger disabling DCO
+  are ignored while other might yield unexpected results.
+- ovpn-dco currently does not implement RPF checks and will accept any source
+  IP from any client.
+- If a peer VPN IP is outside the default device subnet, the route needs to be
+  added manually.
+- No per client statistics. Only total statistics available on the interface.  
diff --git a/configure.ac b/configure.ac
index e0f9c332..7d05d905 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,6 +142,13 @@ AC_ARG_ENABLE(
 	[enable_small="no"]
 )
 
+AC_ARG_ENABLE(
+    [dco],
+    [AS_HELP_STRING([--enable-dco], [enable data channel offload support using ovpn-dco kernel module @<:@default=no@:>@])],
+    ,
+    [enable_dco="no"]
+)
+
 AC_ARG_ENABLE(
 	[iproute2],
 	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
@@ -766,6 +773,53 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+
+
+if test "$enable_dco" = "yes"; then
+dnl
+dnl  Configure path for the ovpn-dco kernel module source directory.
+dnl
+dnl  This is similar to the core librariy, there is an embedded
+dnl  version in this tree which will be used by default.  The
+dnl  git checkout inside the ovpn-dco/ directory is managed via git
+dnl  submodule.
+dnl
+AC_ARG_VAR([DCO_SOURCEDIR], [Alternative ovpn-dco kernel module source directory])
+if test -z "${DCO_SOURCEDIR}"; then
+    DCO_SOURCEDIR="${srcdir}/../ovpn-dco"
+fi
+AC_MSG_NOTICE([Using ovpn-dco source directory: ${DCO_SOURCEDIR}])
+AC_SUBST([DCO_SOURCEDIR])
+
+dnl
+dnl Include generic netlink library used to talk to ovpn-dco
+dnl
+	saved_CFLAGS="${CFLAGS}"
+    PKG_CHECK_MODULES(
+        [LIBNL_GENL],
+        [libnl-genl-3.0 >= 3.2.29],
+        [have_libnl="yes"],
+        [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+    )
+
+    DCO_CFLAGS="-I${DCO_SOURCEDIR}/include/uapi ${LIBNL_GENL_CFLAGS}"
+
+    CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
+    AC_CHECK_HEADERS(
+        [linux/ovpn_dco.h],
+        ,
+        [AC_MSG_ERROR([linux/ovpn_dco.h is missing (use DCO_SOURCE to set path to it, CFLAGS=${CFLAGS})])]
+    )
+    CFLAGS=${saved_CFLAGS}
+    OPTIONAL_DCO_CFLAGS="${DCO_CFLAGS}"
+    OPTIONAL_DCO_LIBS="${LIBNL_GENL_LIBS}"
+
+    AC_DEFINE(ENABLE_LINUXDCO, 1, [Enable linux data channel offload])
+    AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+fi
+AM_CONDITIONAL([ENABLE_OVPNDCO], [test "${enable_dco}" = "yes"])
+
+
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
@@ -1331,6 +1385,8 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 AC_SUBST([OPTIONAL_INOTIFY_CFLAGS])
 AC_SUBST([OPTIONAL_INOTIFY_LIBS])
+AC_SUBST([OPTIONAL_DCO_CFLAGS])
+AC_SUBST([OPTIONAL_DCO_LIBS])
 
 AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 5157c561..cdec9502 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -91,3 +91,16 @@ used when debugging or testing out special usage scenarios.
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
   Currently defaults to operating system default.
 
+--disable-dco
+  Disables the opportunistic use the data channel offloading if available.
+  Without this option, OpenVPN will opportunistically use DCO mode if
+  the config options and the running kernel supports using DCO.
+
+  Data channel offload currently requires data-ciphers to only contain
+  AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
+  ovpn-dco module.
+
+  Note that some options have no effect or not available when
+  DCO mode is enabled.
+
+  A platforms that do not support DCO ``disable-dco`` has no effect.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5883c291..0cc06155 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -30,6 +30,7 @@ AM_CFLAGS = \
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+    ${OPTIONAL_DCO_CFLAGS} \
 	-DPLUGIN_LIBDIR=\"${plugindir}\"
 
 if WIN32
@@ -53,6 +54,7 @@ openvpn_SOURCES = \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
+    dco.c dco.h \
 	dhcp.c dhcp.h \
 	env_set.c env_set.h \
 	errlevel.h \
@@ -85,7 +87,8 @@ openvpn_SOURCES = \
 	multi.c multi.h \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
-	networking.h \
+	networking_linuxdco.c networking_linuxdco.h \
+    networking.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h \
 	openssl_compat.h \
@@ -141,7 +144,8 @@ openvpn_LDADD = \
 	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_SYSTEMD_LIBS) \
 	$(OPTIONAL_DL_LIBS) \
-	$(OPTIONAL_INOTIFY_LIBS)
+	$(OPTIONAL_INOTIFY_LIBS) \
+	$(OPTIONAL_DCO_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a63a2619..57869c66 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -826,6 +826,16 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername, kt->cipher);
     }
+
+#if defined(ENABLE_DCO)
+    /* Keep key material for DCO */
+    static_assert(sizeof(key->cipher) == sizeof(ctx->aead_key), "DCO key size mismatch");
+    if (kt->keep_key_data)
+    {
+        memcpy(ctx->aead_key, key->cipher, sizeof(ctx->aead_key));
+    }
+#endif
+
     if (kt->digest)
     {
         ctx->hmac = hmac_ctx_new();
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1e2ca3cb..bec6883c 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -140,6 +140,9 @@ struct key_type
 {
     const cipher_kt_t *cipher;  /**< Cipher static parameters */
     const md_kt_t *digest;      /**< Message digest static parameters */
+#if defined(ENABLE_DCO)
+    bool keep_key_data;
+#endif
 };
 
 /**
@@ -166,6 +169,9 @@ struct key_ctx
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
+#if defined(ENABLE_DCO)
+    uint8_t aead_key[MAX_CIPHER_KEY_LENGTH];  /**< Keeps the key data for use with DCO */
+#endif
 };
 
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
new file mode 100644
index 00000000..b04122b6
--- /dev/null
+++ b/src/openvpn/dco.c
@@ -0,0 +1,272 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+
+#include "syshead.h"
+
+#include "errlevel.h"
+#include "networking.h"
+
+#include "multi.h"
+#include "dco.h"
+#include "networking_linuxdco.h"
+
+#if defined(ENABLE_DCO)
+#include "ssl_verify.h"
+
+bool
+dco_do_key_dance(struct tuntap *tt, struct tls_multi *multi, const char *ciphername)
+{
+    struct key_state *primary = tls_select_encryption_key(multi);
+    struct key_state *secondary = NULL;
+
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+
+        if (ks == primary)
+        {
+            continue;
+        }
+
+        if (ks->state >= S_GENERATED_KEYS)
+        {
+            ASSERT(ks->authenticated == KS_AUTH_TRUE);
+            ASSERT(key->initialized);
+
+            secondary = ks;
+        }
+    }
+
+    if (!primary)
+    {
+        if (multi->dco_keys_installed >= 1)
+        {
+            msg(D_DCO, "DCO: No encryption key found. Purging data channel keys");
+            dco_del_key(tt, multi->peer_id, OVPN_KEY_SLOT_PRIMARY);
+            if (multi->dco_keys_installed == 2)
+            {
+                dco_del_key(tt, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+            }
+            multi->dco_keys_installed = 2;
+        }
+        return false;
+    }
+
+    /* All keys installed as they should */
+    if (primary->dco_status == DCO_INSTALLED_PRIMARY
+        && (!secondary || secondary->dco_status == DCO_INSTALLED_SECONDARY))
+    {
+        /* Check if we have a previously installed secondary key */
+        if (!secondary && multi->dco_keys_installed == 2)
+        {
+            multi->dco_keys_installed = 1;
+            dco_del_key(tt, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        }
+        return true;
+    }
+
+    int pid = primary->key_id;
+    int sid = secondary ? secondary->key_id : -1;
+
+    msg(D_DCO_DEBUG, "Installing DCO data channel keys for peer %d, "
+                     "primary key-id: %d, secondary key-id: %d.",
+                     multi->peer_id, pid, sid);
+
+    /* General strategy, get primary key installed correctly first. If that is
+     * okay then check if we need to exchange secondary */
+    if (primary->dco_status != DCO_INSTALLED_PRIMARY)
+    {
+        /* ovpn-win-dco does not like to have the install as secondary and then
+          * swap to primary for the first key .... */
+        if (multi->dco_keys_installed == 0)
+        {
+            dco_new_key(tt, multi->peer_id, OVPN_KEY_SLOT_PRIMARY, primary, ciphername);
+            multi->dco_keys_installed = 1;
+        }
+        else
+        {
+            if (primary->dco_status != DCO_INSTALLED_SECONDARY)
+            {
+                dco_new_key(tt, multi->peer_id, OVPN_KEY_SLOT_SECONDARY, primary, ciphername);
+            }
+            dco_swap_keys(tt, multi->peer_id);
+        }
+        primary->dco_status = DCO_INSTALLED_PRIMARY;
+
+        /* if the secondary was installed as primary before the swap demoted
+         * it to secondary */
+        if (secondary && secondary->dco_status == DCO_INSTALLED_PRIMARY)
+        {
+            secondary->dco_status = DCO_INSTALLED_SECONDARY;
+            multi->dco_keys_installed = 2;
+        }
+    }
+
+    /* The primary key is now the correct key but the secondary key might
+     * already a new key that will be later promoted to primary key and we
+     * need to install the key */
+    if (secondary && secondary->dco_status != DCO_INSTALLED_SECONDARY)
+    {
+        dco_new_key(tt, multi->peer_id, OVPN_KEY_SLOT_SECONDARY, secondary, ciphername);
+        secondary->dco_status = DCO_INSTALLED_SECONDARY;
+        multi->dco_keys_installed = 2;
+    }
+    /* delete an expired key */
+    if (!secondary && multi->dco_keys_installed == 2)
+    {
+        dco_del_key(tt, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        multi->dco_keys_installed = 1;
+    }
+
+    /* All keys that we have not installed are set to NOT installed */
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks != primary && ks != secondary)
+        {
+            ks->dco_status = DCO_NOT_INSTALLED;
+        }
+    }
+    return true;
+}
+
+int
+get_dco_cipher(const char *cipher)
+{
+    if (streq(cipher, "AES-256-GCM") || streq(cipher, "AES-128-GCM") ||
+        streq(cipher, "AES-192-GCM"))
+        return OVPN_CIPHER_ALG_AES_GCM;
+    else if (streq(cipher, "CHACHA20-POLY1305"))
+    {
+        return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+    }
+    else if (strcmp(cipher, "none") == 0)
+    {
+        return OVPN_CIPHER_ALG_NONE;
+    }
+    else
+    {
+        return -ENOTSUP;
+    }
+}
+#endif
+
+/* These methods are currently Linux specified but likely to be used any platform that implements Server side DCO */
+#if defined(ENABLE_LINUXDCO)
+
+void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr, bool primary)
+{
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+
+    if (primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        return;
+    }
+
+   int addrtype = (addr->type & MR_ADDR_MASK);
+
+    /* If we do not have local IP addr to install, skip the route */
+    if ((addrtype == MR_ADDR_IPV6 && !mi->context.c2.push_ifconfig_ipv6_defined)
+        || (addrtype == MR_ADDR_IPV4 && !mi->context.c2.push_ifconfig_defined))
+    {
+        return;
+    }
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (addrtype == MR_ADDR_IPV6)
+    {
+        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
+                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+    else if (addrtype == MR_ADDR_IPV4)
+    {
+        in_addr_t dest = htonl(addr->v4.addr);
+        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits,
+                         &mi->context.c2.push_ifconfig_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+}
+
+void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (mi->context.c2.push_ifconfig_defined)
+    {
+        for (const struct iroute *ir = c->options.iroutes; ir != NULL; ir = ir->next)
+        {
+            net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
+                             &mi->context.c2.push_ifconfig_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+
+    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6 = c->options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next)
+        {
+            net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
+                             &mi->context.c2.push_ifconfig_ipv6_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+}
+#else
+void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr, bool primary)
+{
+}
+
+void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+}
+#endif
\ No newline at end of file
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
new file mode 100644
index 00000000..1cfdc8fb
--- /dev/null
+++ b/src/openvpn/dco.h
@@ -0,0 +1,118 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef DCO_H
+#define DCO_H
+
+/* forward declarations, including multi.h leads to nasty include
+ * order problems */
+struct multi_context;
+struct tls_multi;
+struct multi_instance;
+struct mroute_addr;
+struct tuntap;
+
+#if !defined(ENABLE_DCO)
+/* Define dummy type for dco context if DCO is not enabled */
+typedef void *dco_context_t;
+
+static inline void open_tun_dco(struct tuntap *tt, const char* dev) { ASSERT(false); }
+
+static inline void close_tun_dco(struct tuntap *tt) { ASSERT(false); }
+#else
+#include "networking_linuxdco.h"
+#include "crypto.h"
+
+/* forward declarations */
+struct tuntap;
+struct key_state;
+
+void open_tun_dco(struct tuntap *tt, const char* dev);
+
+void close_tun_dco(struct tuntap *tt);
+
+int dco_new_peer(struct tuntap *tt, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+
+
+int ovpn_set_peer(struct tuntap *tt, unsigned  int peerid,
+                  unsigned int keepalive_interval,
+                  unsigned int keepalive_timeout);
+
+int ovpn_do_read_dco(struct dco_context *dco);
+int dco_del_peer(struct tuntap *tt, unsigned int peerid);
+
+int
+dco_del_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot);
+
+int
+dco_new_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot,
+            struct key_state *ks, const char* ciphername);
+
+int dco_swap_keys(struct tuntap *tt, unsigned int peerid);
+
+/**
+ * Does the assertions that the key material is indeed sane.
+ * @param key   the key context to be checked
+ */
+static inline void dco_check_key_ctx(const struct key_ctx_bi *key)
+{
+    ASSERT(key->initialized);
+    /* Double check that we do not have empty keys */
+    const uint8_t empty_key[32] = { 0 };
+    ASSERT(memcmp(key->encrypt.aead_key, empty_key, 32));
+    ASSERT(memcmp(key->decrypt.aead_key, empty_key, 32));
+}
+
+#endif
+
+void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr, bool primary);
+
+void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
+
+
+/**
+ * This function will check if the encryption and decryption keys are installed
+ * to the data channel offload and if not do the necessary steps to ensure that
+ * openvpn and data channel are synced again
+ *
+ * @param tt            Tun tap device context
+ * @param multi         TLS multi instance
+ * @param ciphername    Ciphername to use when installing the keys.
+ * @return
+ */
+bool
+dco_do_key_dance(struct tuntap *tt, struct tls_multi *multi, const char *ciphername);
+
+/**
+ * Translates an OpenVPN Cipher string to a supported cipher enum from DCO
+ * @param cipher OpenVPN cipher string
+ * @return constant that defines the cipher or -ENOTSUP if not supported
+ */
+int get_dco_cipher(const char *cipher);
+#endif
\ No newline at end of file
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 602e48a8..a7054647 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -91,6 +91,7 @@
 #define D_OSBUF              LOGLEV(3, 43, 0)        /* show socket/tun/tap buffer sizes */
 #define D_PS_PROXY           LOGLEV(3, 44, 0)        /* messages related to --port-share option */
 #define D_IFCONFIG           LOGLEV(3, 0,  0)        /* show ifconfig info (don't mute) */
+#define D_DCO                LOGLEV(3, 0, 0)         /* show DCO related messages */
 
 #define D_SHOW_PARMS         LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
 #define D_SHOW_OCC           LOGLEV(4, 51, 0)        /* show options compatibility string */
@@ -113,6 +114,7 @@
 #define D_TUN_RW             LOGLEV(6, 69, M_DEBUG)  /* show TUN/TAP reads/writes */
 #define D_TAP_WIN_DEBUG      LOGLEV(6, 69, M_DEBUG)  /* show TAP-Windows driver debug info */
 #define D_CLIENT_NAT         LOGLEV(6, 69, M_DEBUG)  /* show client NAT debug info */
+#define D_DCO_DEBUG          LOGLEV(6, 69, M_DEBUG)  /* show DCO related lowlevel debug messages */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index d67d69f6..fc815a59 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -72,6 +72,9 @@
 #define MANAGEMENT_WRITE    (1 << (MANAGEMENT_SHIFT + WRITE_SHIFT))
 #define FILE_SHIFT          8
 #define FILE_CLOSED         (1 << (FILE_SHIFT + READ_SHIFT))
+#define DCO_SHIFT           10
+#define DCO_READ            (1 << (DCO_SHIFT + READ_SHIFT))
+#define DCO_WRITE           (1 << (DCO_SHIFT + WRITE_SHIFT))
 
 /*
  * Initialization flags passed to event_set_init
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 41ef12e3..02aa6659 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -41,6 +41,7 @@
 #include "dhcp.h"
 #include "common.h"
 #include "ssl_verify.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -50,7 +51,6 @@ counter_type link_read_bytes_global;  /* GLOBAL */
 counter_type link_write_bytes_global; /* GLOBAL */
 
 /* show event wait debugging info */
-
 #ifdef ENABLE_DEBUG
 
 static const char *
@@ -139,6 +139,22 @@ context_reschedule_sec(struct context *c, int sec)
         c->c2.timeval.tv_usec = 0;
     }
 }
+#if defined(ENABLE_DCO)
+static void
+check_dco_key_status(struct context *c)
+{
+    /* DCO context is not yet initialised or enabled */
+    if ((!c->c2.did_open_tun && !c->c1.tuntap)|| !dco_enabled(&c->options))
+    {
+        return;
+    }
+
+    struct tls_multi *multi = c->c2.tls_multi;
+
+    dco_do_key_dance(c->c1.tuntap, multi, c->options.ciphername);
+}
+#endif
+
 
 /*
  * In TLS mode, let TLS level respond to any control-channel
@@ -181,6 +197,13 @@ check_tls(struct context *c)
     }
 
     interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
+#if defined(ENABLE_DCO)
+    /* Our current code has no good hooks in the TLS machinery to install
+     * the keys to DCO. So we check/install keys after the whole TLS
+     * machinery has been completed
+     */
+    check_dco_key_status(c);
+#endif
 
     if (wakeup)
     {
@@ -1084,6 +1107,15 @@ process_incoming_link(struct context *c)
     perf_pop();
 }
 
+#if defined(ENABLE_LINUXDCO)
+static void
+process_incoming_dco(struct context *c)
+{
+    msg(M_INFO, __func__);
+    ovpn_do_read_dco(&c->c1.tuntap->dco);
+}
+#endif
+
 /*
  * Output: c->c2.buf
  */
@@ -1605,9 +1637,17 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = link_socket_write(c->c2.link_socket,
-                                         &c->c2.to_link,
-                                         to_addr);
+#if defined(ENABLE_LINUXDCO)
+                if (c->c2.link_socket->info.dco_installed)
+                {
+                    size = ovpn_do_write_dco(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id, &c->c2.to_link);
+                }
+                else
+#endif
+                {
+                    size = link_socket_write(c->c2.link_socket, &c->c2.to_link,
+                                             to_addr);
+                }
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
@@ -1870,6 +1910,9 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = FILE_SHIFT;
 #endif
+#ifdef ENABLE_LINUXDCO
+    static int dco_shift = 10;    /* Event from DCO module */
+#endif
 
     /*
      * Decide what kind of events we want to wait for.
@@ -1977,6 +2020,12 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+#if defined(ENABLE_LINUXDCO)
+    if (socket & EVENT_READ && c->c2.did_open_tun)
+    {
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *) &dco_shift);
+    }
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -2099,4 +2148,13 @@ process_io(struct context *c)
             process_incoming_tun(c);
         }
     }
+#if defined(ENABLE_LINUXDCO)
+    else if (status & DCO_READ)
+    {
+        if(!IS_SIG(c))
+        {
+            process_incoming_dco(c);
+        }
+    }
+#endif
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4fee7f49..4668fd04 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -53,6 +53,7 @@
 #include "tls_crypt.h"
 #include "forward.h"
 #include "auth_token.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -1367,15 +1368,25 @@ do_init_timers(struct context *c, bool deferred)
     }
 
     /* initialize pings */
-
-    if (c->options.ping_send_timeout)
+#if defined(ENABLE_DCO)
+    if (dco_enabled(&c->options))
     {
-        event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        /* The DCO kernel module will send the pings instead of user space */
+        event_timeout_clear(&c->c2.ping_rec_interval);
+        event_timeout_clear(&c->c2.ping_send_interval);
     }
-
-    if (c->options.ping_rec_timeout)
+    else
+#endif
     {
-        event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        if (c->options.ping_send_timeout)
+        {
+            event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        }
+
+        if (c->options.ping_rec_timeout)
+        {
+            event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        }
     }
 
     if (!deferred)
@@ -2097,6 +2108,7 @@ tun_abort(void)
  * Handle delayed tun/tap interface bringup due to --up-delay or --pull
  */
 
+
 /**
  * Helper for do_up().  Take two option hashes and return true if they are not
  * equal, or either one is all-zeroes.
@@ -2110,6 +2122,85 @@ options_hash_changed_or_zero(const struct sha256_digest *a,
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
 
+#ifdef ENABLE_DCO
+static bool
+p2p_dco_add_new_peer(struct context *c)
+{
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct link_socket *ls = c->c2.link_socket;
+
+    if (!dco_enabled(&c->options))
+    {
+        return true;
+    }
+
+    struct in6_addr remote_ip6 = { 0 };
+    struct in_addr remote_ip4 = { 0 };
+
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+
+    const char* gw = NULL;
+    /* In client mode if a P2P style topology is used we assume the
+     * remote-gateway is the IP of the peer */
+    if (c->options.topology == TOP_NET30 || c->options.topology == TOP_P2P)
+    {
+        gw = c->options.ifconfig_remote_netmask;
+    }
+    if (c->options.route_default_gateway)
+    {
+        gw = c->options.route_default_gateway;
+    }
+
+    /* These inet_pton conversion are fatal since options.c already implements
+     * checks to have only valid addresses when setting the options */
+    if (c->options.ifconfig_ipv6_remote)
+    {
+        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &remote_ip6) != 1)
+        {
+            msg(M_FATAL,
+                "DCO peer init: problem converting IPv6 ifconfig remote address %s to binary",
+                c->options.ifconfig_ipv6_remote);
+        }
+        remote_addr6 = &remote_ip6;
+    }
+
+    if (gw)
+    {
+        if (inet_pton(AF_INET, gw, &remote_ip4) != 1)
+        {
+            msg(M_FATAL, "DCO peer init: problem converting IPv4 ifconfig gateway address %s to binary", gw);
+        }
+        remote_addr4 = &remote_ip4;
+    }
+    else if (c->options.ifconfig_local)
+    {
+        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IPv4 (set --route-gateway)");
+    }
+
+    if (!c->c2.link_socket->info.dco_installed)
+    {
+        ASSERT(ls->info.connection_established);
+
+        struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
+
+        dco_new_peer(c->c1.tuntap, multi->peer_id, c->c2.link_socket->sd, NULL,
+                     remoteaddr, remote_addr4, remote_addr6);
+
+        c->c2.tls_multi->dco_peer_added = true;
+        c->c2.link_socket->info.dco_installed = true;
+    }
+
+    if (c->options.ping_send_timeout)
+    {
+        ovpn_set_peer(c->c1.tuntap, multi->peer_id, c->options.ping_send_timeout,
+                      c->options.ping_rec_timeout);
+    }
+
+    return true;
+}
+#endif
+
 bool
 do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
 {
@@ -2161,6 +2252,11 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
 
         if (c->c2.did_open_tun)
         {
+            /* If we are in DCO mode we need to set the new peer options now */
+#if defined(ENABLE_DCO)
+            p2p_dco_add_new_peer(c);
+#endif
+
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
 
             /* if --route-delay was specified, start timer */
@@ -2288,6 +2384,18 @@ do_deferred_p2p_ncp(struct context *c)
     return true;
 }
 
+
+static bool check_dco_pull_options(struct options *o)
+{
+    if (!o->use_peer_id)
+    {
+        msg(D_TLS_ERRORS, "OPTIONS IMPORT: Server did not request DATA_V2 packet "
+                          "format required for data channel offloading");
+        return false;
+    }
+    return true;
+}
+
 /*
  * Handle non-tun-related pulled options.
  */
@@ -2400,8 +2508,17 @@ do_deferred_options(struct context *c, const unsigned int found)
             msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
             return false;
         }
-    }
 
+        /* Check if the pushed options are compatible with DCO if we have DCO
+         * enabled */
+        if (dco_enabled(&c->options) && !check_dco_pull_options(&c->options))
+        {
+            msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
+                              "data channel offloading. Use --disable-dco to connect"
+                              "to this server");
+            return false;
+        }
+    }
     return true;
 }
 
@@ -4332,6 +4449,24 @@ sig:
     close_context(c, -1, flags);
     return;
 }
+#if defined(ENABLE_LINUXDCO)
+static void remove_dco_peer(struct context *c)
+{
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_added)
+    {
+        c->c2.tls_multi->dco_peer_added = false;
+        dco_del_peer(c->c1.tuntap, c->c2.tls_multi->peer_id);
+    }
+}
+#else
+static void remove_dco_peer(struct context *c)
+{
+}
+#endif
 
 /*
  * Close a tunnel instance.
@@ -4358,6 +4493,10 @@ close_instance(struct context *c)
         /* free buffers */
         do_close_free_buf(c);
 
+        /* close peer for DCO if enabled, needs peer-id so must be done before
+         * closing TLS contexts */
+        remove_dco_peer(c);
+
         /* close TLS */
         do_close_tls(c);
 
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 52581f8a..5c719117 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -30,7 +30,7 @@
  * Baseline maximum number of events
  * to wait for.
  */
-#define BASE_N_EVENTS 4
+#define BASE_N_EVENTS 5
 
 void context_clear(struct context *c);
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index bf9b5190..e335dcef 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -61,6 +61,7 @@
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #define MTCP_MANAGEMENT ((void *)4)
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
+#define MTCP_DCO        ((void *)6)
 
 #define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
 
@@ -123,6 +124,8 @@ multi_create_instance_tcp(struct multi_context *m)
     struct hash *hash = m->hash;
 
     mi = multi_create_instance(m, NULL);
+    multi_assign_peer_id(m, mi);
+
     if (mi)
     {
         struct hash_element *he;
@@ -236,6 +239,7 @@ multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
+        mi->socket_set_called = false;
     }
     mtcp->n_esr = 0;
 }
@@ -277,6 +281,9 @@ multi_tcp_wait(const struct context *c,
     }
 #endif
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+#if defined(ENABLE_LINUXDCO)
+    dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -393,6 +400,20 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
     tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
 
+#if defined(ENABLE_LINUXDCO)
+    if (mi && mi->context.c2.link_socket->info.dco_installed)
+    {
+        /* If we got a socket that has been handed over to the kernel
+         * we must not call the normal socket function to figure out
+         * if it is readable or writable */
+        /* Assert that we only have the DCO exptected flags */
+        ASSERT(action & (TA_SOCKET_READ | TA_SOCKET_WRITE));
+
+        /* We are always ready! */
+        return action;
+    }
+#endif
+
     switch (action)
     {
         case TA_TUN_READ:
@@ -516,7 +537,10 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
 
         case TA_INITIAL:
             ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
+            if (!mi->context.c2.link_socket->info.dco_installed)
+            {
+                multi_tcp_set_global_rw_flags(m, mi);
+            }
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -566,7 +590,10 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             }
             else
             {
-                multi_tcp_set_global_rw_flags(m, mi);
+                if (!c->c2.link_socket->info.dco_installed)
+                {
+                    multi_tcp_set_global_rw_flags(m, mi);
+                }
             }
             break;
 
@@ -623,23 +650,22 @@ multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int action,
         /*
          * Dispatch the action
          */
-        {
-            struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
+        struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
 
-            /*
-             * Signal received or TCP connection
-             * reset by peer?
-             */
-            if (touched && IS_SIG(&touched->context))
+        /*
+         * Signal received or TCP connection
+         * reset by peer?
+         */
+        if (touched && IS_SIG(&touched->context))
+        {
+            if (mi == touched)
             {
-                if (mi == touched)
-                {
-                    mi = NULL;
-                }
-                multi_close_instance_on_signal(m, touched);
+                mi = NULL;
             }
+            multi_close_instance_on_signal(m, touched);
         }
 
+
         /*
          * If dispatch produced any pending output
          * for a particular instance, point to
@@ -737,6 +763,13 @@ multi_tcp_process_io(struct multi_context *m)
                     multi_tcp_action(m, mi, TA_INITIAL, false);
                 }
             }
+#if defined(ENABLE_LINUXDCO)
+            /* incoming data on DCO? */
+            else if (e->arg == MTCP_DCO)
+            {
+                multi_process_incoming_dco(m);
+            }
+#endif
             /* signal received? */
             else if (e->arg == MTCP_SIG)
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 07e2caae..1fc391fb 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -227,6 +227,19 @@ multi_process_io_udp(struct multi_context *m)
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
+#ifdef ENABLE_LINUXDCO
+    else if (status & DCO_READ)
+    {
+        if(!IS_SIG(&m->top))
+        {
+            bool ret = true;
+            while (ret)
+            {
+                ret = multi_process_incoming_dco(m);
+            }
+        }
+    }
+#endif
 }
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 103e882e..650804ea 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,10 @@
 
 #include "crypto_backend.h"
 #include "ssl_util.h"
+#include "dco.h"
+
+static void multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig);
+
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -519,6 +523,9 @@ multi_del_iroutes(struct multi_context *m,
 {
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
+
+    dco_delete_iroutes(m, mi);
+
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
@@ -1224,16 +1231,17 @@ multi_learn_in_addr_t(struct multi_context *m,
         addr.netbits = (uint8_t) netbits;
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
-#endif
-        return owner;
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
+#endif
+
+    dco_install_iroute(m, mi, &addr, primary);
+
+    return owner;
 }
 
 static struct multi_instance *
@@ -1257,16 +1265,20 @@ multi_learn_in6_addr(struct multi_context *m,
         mroute_addr_mask_host_bits( &addr );
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+    }
 #endif
-        return owner;
+    if (!primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        dco_install_iroute(m, mi, &addr, primary);
     }
+
+    return owner;
 }
 
 /*
@@ -1764,6 +1776,15 @@ multi_client_set_protocol_options(struct context *c)
     {
         tls_multi->use_peer_id = true;
     }
+    else if (dco_enabled(o))
+    {
+        msg(M_INFO, "Client does not support DATA_V2. Data channel offloaing "
+                    "requires DATA_V2. Dropping client.");
+        auth_set_client_reason(tls_multi, "Data channel negotiation "
+                                          "failed (missing DATA_V2)");
+        return false;
+    }
+
     if (proto & IV_PROTO_REQUEST_PUSH)
     {
         c->c2.push_request_received = true;
@@ -1775,7 +1796,6 @@ multi_client_set_protocol_options(struct context *c)
         o->data_channel_crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
     }
 #endif
-
     /* Select cipher if client supports Negotiable Crypto Parameters */
 
     /* if we have already created our key, we cannot *change* our own
@@ -2271,12 +2291,127 @@ cleanup:
     return ret;
 }
 
+#if defined(ENABLE_LINUXDCO)
+#include <linux/ovpn_dco.h>
+
+static struct sockaddr *
+multi_dco_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+                        struct gc_arena *gc)
+{
+    struct context *c = &mi->context;
+
+    if ((c->options.sockflags & SF_USE_IP_PKTINFO))
+    {
+        struct link_socket_actual *actual = &c->c2.link_socket_info->lsa->actual;
+
+        switch(actual->dest.addr.sa.sa_family)
+        {
+            case AF_INET:
+            {
+                struct sockaddr_in *sock_in4;
+                ALLOC_OBJ_CLEAR_GC(sock_in4, struct sockaddr_in, gc);
+                sock_in4->sin_addr = actual->pi.in4.ipi_addr;
+                sock_in4->sin_family = AF_INET;
+                return (struct sockaddr *) sock_in4;
+            }
+            case AF_INET6:
+            {
+                struct sockaddr_in6 *sock_in6;
+                ALLOC_OBJ_CLEAR_GC(sock_in6, struct sockaddr_in6, gc);
+                sock_in6->sin6_addr = actual->pi.in6.ipi6_addr;
+                sock_in6->sin6_family = AF_INET6;
+                return (struct sockaddr *) sock_in6;
+            }
+            default:
+                ASSERT(0);
+        }
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
+static bool
+multi_dco_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+{
+    struct context *c = &mi->context;
+
+    int peer_id = mi->context.c2.tls_multi->peer_id;
+    int sd = c->c2.link_socket->sd;
+    struct sockaddr *remoteaddr;
+    struct sockaddr *local;
+
+    if (c->mode == CM_CHILD_TCP)
+    {
+        /* the remote address will be inferred from the TCP socket endpoint */
+        remoteaddr = NULL;
+    }
+    else
+    {
+        ASSERT(c->c2.link_socket_info->connection_established);
+        remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
+    }
+
+    struct in_addr remote_ip4 = { 0 };
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+    struct gc_arena gc = gc_new();
+
+    /* In server mode we need to fetch the remote addresses from the push config */
+    if (c->c2.push_ifconfig_defined)
+    {
+        remote_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);
+        remote_addr4 = &remote_ip4;
+    }
+    if (c->c2.push_ifconfig_ipv6_defined)
+    {
+        remote_addr6 = &c->c2.push_ifconfig_ipv6_local;
+    }
+
+    local = multi_dco_get_localaddr(m, mi, &gc);
+
+    if (dco_new_peer(c->c1.tuntap, peer_id, sd, local, remoteaddr,
+                     remote_addr4, remote_addr6) != 0)
+    {
+        gc_free(&gc);
+        return false;
+    }
+
+    c->c2.tls_multi->dco_peer_added = true;
+
+    dco_do_key_dance(c->c1.tuntap, c->c2.tls_multi, c->options.ciphername);
+
+    if (c->options.ping_send_timeout)
+    {
+        ovpn_set_peer(c->c1.tuntap, peer_id, c->options.ping_send_timeout,
+                      c->options.ping_rec_timeout);
+    }
+
+    if (c->mode == CM_CHILD_TCP )
+    {
+        multi_tcp_dereference_instance(m->mtcp, mi);
+        if (close(sd))
+        {
+            msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
+        }
+        c->c2.link_socket->info.dco_installed = true;
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+
+    gc_free(&gc);
+
+    return true;
+}
+#endif
+
 /**
  * Generates the data channel keys
  */
 static bool
-multi_client_generate_tls_keys(struct context *c)
+multi_client_generate_tls_keys(struct multi_context *m, struct multi_instance *mi)
 {
+    struct context *c = &mi->context;
     struct frame *frame_fragment = NULL;
 #ifdef ENABLE_FRAGMENT
     if (c->options.ce.fragment)
@@ -2293,6 +2428,13 @@ multi_client_generate_tls_keys(struct context *c)
         return false;
     }
 
+#if defined(ENABLE_LINUXDCO)
+    if (dco_enabled(&c->options) && !multi_dco_add_new_peer(m, mi))
+    {
+        return false;
+    }
+#endif
+
     return true;
 }
 
@@ -2399,7 +2541,7 @@ multi_client_connect_late_setup(struct multi_context *m,
     }
     /* Generate data channel keys only if setting protocol options
      * has not failed */
-    else if (!multi_client_generate_tls_keys(&mi->context))
+    else if (!multi_client_generate_tls_keys(m, mi))
     {
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
@@ -2659,6 +2801,14 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         (*cur_handler_index)++;
     }
 
+    /* Check if we have forbidding options in the current mode */
+    if (dco_enabled(&mi->context.options)
+        && check_option_conflict_dco(D_MULTI_ERRORS, &mi->context.options))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to incompatible options");
+        cc_succeeded = false;
+    }
+
     if (cc_succeeded)
     {
         multi_client_connect_late_setup(m, mi, *option_types_found);
@@ -3077,6 +3227,98 @@ done:
     gc_free(&gc);
 }
 
+
+#if defined(ENABLE_LINUXDCO)
+
+static void
+process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,  dco_context_t *dco)
+{
+    struct buffer orig_buf = mi->context.c2.buf;
+    int peer_id = dco->dco_meesage_peer_id;
+
+    mi->context.c2.buf = dco->dco_packet_in;
+
+    multi_process_incoming_link(m, mi, 0);
+
+    mi->context.c2.buf = orig_buf;
+    if (BLEN(&dco->dco_packet_in) < 1)
+    {
+        msg(D_DCO, "Received too short packet for peer %d" , peer_id);
+        goto done;
+    }
+
+    uint8_t *ptr = BPTR(&dco->dco_packet_in);
+    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+    if (op == P_DATA_V2 || op == P_DATA_V2)
+    {
+        msg(D_DCO, "DCO: received data channel packet for peer %d" , peer_id);
+        goto done;
+    }
+    done:
+    buf_init(&dco->dco_packet_in, 0);
+}
+
+static void
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+{
+    const char *reason = "(unknown reason by ovpn-dco)";
+    switch (dco->dco_del_peer_reason)
+    {
+    case OVPN_DEL_PEER_REASON_EXPIRED:
+        reason = "ovpn-dco: ping expired";
+        break;
+    case OVPN_DEL_PEER_REASON_TRANSPORT_ERROR:
+        reason = "ovpn-dco: transport error";
+        break;
+    case OVPN_DEL_PEER_REASON_USERSPACE:
+        /* This very likely ourselves but might be another process, so
+         * still process it */
+        reason = "ovpn-dco: userspace request";
+        break;
+    }
+
+    /* When kernel already deleted the peer, the socket is no longer
+     * installed and we don't need to cleanup the state in the kernel */
+    mi->context.c2.tls_multi->dco_peer_added = false;
+    mi->context.sig->signal_text = reason;
+    multi_signal_instance(m, mi, SIGTERM);
+
+}
+
+bool
+multi_process_incoming_dco(struct multi_context *m)
+{
+    dco_context_t *dco = &m->top.c1.tuntap->dco;
+
+    struct multi_instance *mi = NULL;
+
+    int ret = ovpn_do_read_dco(&m->top.c1.tuntap->dco);
+
+    int peer_id = dco->dco_meesage_peer_id;
+
+    if ((peer_id >= 0) && (peer_id < m->max_clients) && (m->instances[peer_id]))
+    {
+        mi = m->instances[peer_id];
+        if (dco->dco_message_type == OVPN_CMD_PACKET)
+        {
+            process_incoming_dco_packet(m, mi, dco);
+        }
+        else if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+        {
+            process_incoming_del_peer(m, mi, dco);
+        }
+    }
+    else
+    {
+        msg(D_DCO, "Received packet for peer-id unknown to OpenVPN: %d" , peer_id);
+    }
+
+    dco->dco_message_type = 0;
+    dco->dco_meesage_peer_id = -1;
+    return ret > 0;
+}
+#endif
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6e85c21c..71883ee5 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -98,7 +98,9 @@ struct client_connect_defer_state
  * server-mode.
  */
 struct multi_instance {
-    struct schedule_entry se;  /* this must be the first element of the structure */
+    struct schedule_entry se;  /* this must be the first element of the structure,
+                                * We cast between this and schedule_entry so the
+                                * beginning of the struct must be identical */
     struct gc_arena gc;
     bool halt;
     int refcount;
@@ -308,6 +310,8 @@ void multi_process_float(struct multi_context *m, struct multi_instance *mi);
 bool multi_process_post(struct multi_context *m, struct multi_instance *mi, const unsigned int flags);
 
 
+bool multi_process_incoming_dco(struct multi_context *m);
+
 /**************************************************************************/
 /**
  * Demultiplex and process a packet received over the external network
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 2f0ee160..cb57802b 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -27,6 +27,7 @@ struct context;
 
 #ifdef ENABLE_SITNL
 #include "networking_sitnl.h"
+#include "dco.h"
 #elif ENABLE_IPROUTE
 #include "networking_iproute2.h"
 #else
diff --git a/src/openvpn/networking_linuxdco.c b/src/openvpn/networking_linuxdco.c
new file mode 100644
index 00000000..ca6284e7
--- /dev/null
+++ b/src/openvpn/networking_linuxdco.c
@@ -0,0 +1,848 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(ENABLE_LINUXDCO)
+
+#include "syshead.h"
+
+#include "errlevel.h"
+#include "buffer.h"
+#include "networking.h"
+
+#include "socket.h"
+#include "tun.h"
+#include "ssl.h"
+#include "fdmisc.h"
+#include "ssl_verify.h"
+
+#include <linux/ovpn_dco.h>
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+
+
+/* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
+ * have to explicitly do it to prevent the kernel from failing upon
+ * parsing of the message
+ */
+#define nla_nest_start(_msg, _type) \
+	nla_nest_start(_msg, (_type) | NLA_F_NESTED)
+
+static int ovpn_get_mcast_id(dco_context_t *dco);
+
+void dco_check_key_ctx(const struct key_ctx_bi *key);
+
+typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
+
+int
+resolve_ovpn_netlink_id(int msglevel)
+{
+    int ret;
+    struct nl_sock* nl_sock = nl_socket_alloc();
+
+    ret = genl_connect(nl_sock);
+    if (ret)
+    {
+        msg(msglevel, "Cannot connect to generic netlink: %s",
+                nl_geterror(ret));
+        goto err_sock;
+    }
+    set_cloexec(nl_socket_get_fd(nl_sock));
+
+    ret = genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);
+    if (ret < 0)
+    {
+        msg(msglevel, "Cannot find ovpn_dco netlink component: %s",
+            nl_geterror(ret));
+    }
+
+err_sock:
+    nl_socket_free(nl_sock);
+    return ret;
+}
+
+static struct nl_msg *ovpn_dco_nlmsg_create(dco_context_t *dco,
+                                            enum ovpn_nl_commands cmd)
+{
+    struct nl_msg *nl_msg = nlmsg_alloc();
+    if (!nl_msg)
+    {
+        msg(M_ERR, "cannot allocate netlink message");
+        return NULL;
+    }
+
+    genlmsg_put(nl_msg, 0, 0, dco->ovpn_dco_id, 0, 0, cmd, 0);
+    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco->ifindex);
+
+    return nl_msg;
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    msg(M_INFO, "cannot put into netlink message");
+    return NULL;
+}
+
+static int ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+{
+    int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+
+    switch (ret) {
+    case -NLE_INTR:
+        msg(M_WARN, "%s: netlink received interrupt due to signal - ignoring", prefix);
+        break;
+    case -NLE_NOMEM:
+        msg(M_ERR, "%s: netlink out of memory error", prefix);
+        break;
+    case -M_ERR:
+        msg(M_WARN, "%s: netlink reports blocking read - aborting wait", prefix);
+        break;
+    case -NLE_NODEV:
+        msg(M_ERR, "%s: netlink reports device not found:", prefix);
+        break;
+    case -NLE_OBJ_NOTFOUND:
+        msg(M_INFO, "%s: netlink reports object not found, ovpn-dco unloaded?", prefix);
+        break;
+    default:
+        if (ret)
+        {
+            msg(M_NONFATAL|M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
+        }
+        break;
+    }
+
+    return ret;
+}
+
+/**
+ * Send a preprared netlink message and registers cb as callback if non-null.
+ *
+ * The method will also free nl_msg
+ * @param dco       The dco context to use
+ * @param nl_msg    the message to use
+ * @param cb        An optional callback if the caller expects an answers\
+ * @param prefix    A prefix to report in the error message to give the user context
+ * @return          status of sending the message
+ */
+static int
+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
+                 const char* prefix)
+{
+    dco->status = 1;
+
+    if (cb)
+    {
+        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
+    }
+    else
+    {
+        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, NULL, dco);
+    }
+
+    nl_send_auto(dco->nl_sock, nl_msg);
+
+    while (dco->status == 1)
+    {
+        ovpn_nl_recvmsgs(dco, prefix);
+    }
+
+    if (dco->status < 0)
+    {
+        msg(M_INFO, "%s: failed to send netlink message: %s (%d)",
+            prefix, strerror(-dco->status), dco->status);
+    }
+
+    return dco->status;
+}
+
+struct sockaddr *
+mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
+{
+    struct sockaddr_in6 *sock6 = ((struct sockaddr_in6 *)sock);
+    if (sock->sa_family == AF_INET6 &&
+        memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff", 12)==0)
+    {
+
+        struct sockaddr_in* sock4;
+        ALLOC_OBJ_CLEAR_GC(sock4, struct sockaddr_in, gc);
+        memcpy (&sock4->sin_addr, sock6->sin6_addr.s6_addr +12, 4);
+        sock4->sin_port = sock6->sin6_port;
+        sock4->sin_family = AF_INET;
+        return (struct sockaddr *) sock4;
+    }
+    return sock;
+}
+
+int dco_new_peer(struct tuntap *tt, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    struct gc_arena gc = gc_new();
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_NEW_PEER);
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
+    int ret = -EMSGSIZE;
+
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET, sd);
+
+    /* Set the remote endpoint if defined (for UDP) */
+    if (remoteaddr)
+    {
+        remoteaddr = mapped_v4_to_v6(remoteaddr, &gc);
+        int alen = af_addr_size(remoteaddr->sa_family);
+
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remoteaddr);
+    }
+
+    if (localaddr)
+    {
+        localaddr = mapped_v4_to_v6(localaddr, &gc);
+        if (localaddr->sa_family == AF_INET)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_addr),
+                    &((struct sockaddr_in *)localaddr)->sin_addr);
+        }
+        else if (localaddr->sa_family == AF_INET6)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6_addr),
+                    &((struct sockaddr_in6 *)localaddr)->sin6_addr);
+        }
+    }
+
+    /* Set the primary VPN IP addresses of the peer */
+    if (remote_in4)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+    }
+    if (remote_in6)
+    {
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
+                remote_in6);
+    }
+    nla_nest_end(nl_msg, attr);
+
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    gc_free(&gc);
+    return ret;
+}
+
+static int
+ovpn_nl_cb_finish(struct nl_msg (*msg)__attribute__((unused)), void *arg)
+{
+    int *status = arg;
+
+    *status = 0;
+    return NL_SKIP;
+}
+
+static int
+ovpn_nl_cb_error(struct sockaddr_nl (*nla)__attribute__((unused)),
+                 struct nlmsgerr *err, void *arg)
+{
+    struct nlmsghdr *nlh = (struct nlmsghdr *)err - 1;
+    struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
+    int len = nlh->nlmsg_len;
+    struct nlattr *attrs;
+    int *ret = arg;
+    int ack_len = sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
+
+    *ret = err->error;
+
+    if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
+        return NL_STOP;
+
+    if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
+        ack_len += err->msg.nlmsg_len - sizeof(*nlh);
+
+    if (len <= ack_len)
+        return NL_STOP;
+
+    attrs = (void *)((unsigned char *)nlh + ack_len);
+    len -= ack_len;
+
+    nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
+    if (tb_msg[NLMSGERR_ATTR_MSG]) {
+        len = strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
+                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+        msg(M_WARN, "kernel error: %*s\n", len,
+            (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
+    }
+
+    return NL_STOP;
+}
+
+static void
+ovpn_dco_init_netlink(dco_context_t *dco)
+{
+    dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_ERR);
+
+    dco->nl_sock = nl_socket_alloc();
+
+
+    if (!dco->nl_sock)
+    {
+        msg(M_ERR, "Cannot create netlink socket");
+    }
+
+    /* TODO: Why are we setting this buffer size? */
+    nl_socket_set_buffer_size(dco->nl_sock, 8192, 8192);
+
+    int ret = genl_connect(dco->nl_sock);
+    if (ret)
+    {
+        msg(M_ERR, "Cannot connect to generic netlink: %s",
+            nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket_get_fd(dco->nl_sock));
+
+    dco->nl_cb = nl_cb_alloc(NL_CB_DEFAULT);
+    if (!dco->nl_cb)
+    {
+        msg(M_ERR, "failed to allocate netlink callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
+
+    nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
+              &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
+              &dco->status);
+
+    /* The async PACKET messages confuse libnl and it will drop them with
+     * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
+     * number check */
+    nl_socket_disable_seq_check(dco->nl_sock);
+}
+
+static void
+ovpn_dco_uninit_netlink(dco_context_t *dco)
+{
+    nl_socket_free(dco->nl_sock);
+    dco->nl_sock = NULL;
+
+    /* Decrease reference count */
+    nl_cb_put(dco->nl_cb);
+
+    memset(dco, 0, sizeof(*dco));
+}
+
+static void ovpn_dco_register(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    ovpn_get_mcast_id(dco);
+
+    if (dco->ovpn_dco_mcast_id < 0)
+    {
+        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
+    }
+
+    /* Register for Ovpn dco specific messages */
+    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    if (ret)
+    {
+        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
+    }
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_REGISTER_PACKET);
+    if (!nl_msg)
+    {
+        msg(M_ERR, "%s: cannot allocate message to register for control packets",
+            __func__);
+    }
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    if (ret)
+    {
+        msg(M_ERR, "%s: failed to register for control packets: %d", __func__,
+            ret);
+    }
+    nlmsg_free(nl_msg);
+}
+
+void
+open_tun_dco(struct tuntap *tt, const char* dev)
+{
+    msg(D_DCO_DEBUG, __func__);
+    ASSERT(tt->type == DEV_TYPE_TUN);
+
+    ovpn_dco_init_netlink(&tt->dco);
+
+    if (!strcmp(dev, "tun"))
+    {
+        /* If no specific name has been requested use an auto-assigned name */
+        dev = NULL;
+    }
+
+    tt->dco.ifindex = net_iface_new(dev, "ovpn-dco");
+
+    char if_name[IFNAMSIZ];
+    if(!if_indextoname(tt->dco.ifindex, if_name))
+    {
+        msg(M_ERR|M_ERRNO, "Cannot resolve interface name for dco interface: ");
+    }
+    tt->actual_name = string_alloc(if_name, NULL);
+    uint8_t *dcobuf = malloc(65536);
+    buf_set_write(&tt->dco.dco_packet_in, dcobuf, 65536);
+    tt->dco.dco_meesage_peer_id = -1;
+
+    ovpn_dco_register(&tt->dco);
+}
+
+void
+close_tun_dco(struct tuntap *tt)
+{
+    msg(D_DCO_DEBUG, __func__);
+
+    net_iface_del_index(tt->dco.ifindex);
+    ovpn_dco_uninit_netlink(&tt->dco);
+    free(tt->dco.dco_packet_in.data);
+}
+
+int dco_swap_keys(struct tuntap *tt, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_SWAP_KEYS);
+    if (!nl_msg)
+        return -ENOMEM;
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int dco_del_peer(struct tuntap *tt, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_DEL_PEER);
+    if (!nl_msg)
+        return -ENOMEM;
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int
+dco_del_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_DEL_KEY);
+    if (!nl_msg)
+        return -ENOMEM;
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+int
+dco_new_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot,
+             struct key_state *ks, const char* ciphername)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+        __func__, slot, ks->key_id, peerid, ciphername);
+    const int nonce_len = 8;
+
+    struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+
+    dco_check_key_ctx(key);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_NEW_KEY);
+    if (!nl_msg)
+        return -ENOMEM;
+
+    int dco_cipher = get_dco_cipher(ciphername);
+    ASSERT(dco_cipher >= 0);
+
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, ks->key_id);
+
+    NLA_PUT_U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);
+
+    if (dco_cipher != OVPN_CIPHER_ALG_NONE)
+    {
+        size_t key_len = cipher_kt_key_size(cipher_kt_get(ciphername));
+        struct nlattr *key_enc = nla_nest_start(nl_msg, OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, key->encrypt.aead_key);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_len,
+                key->encrypt.implicit_iv);
+        nla_nest_end(nl_msg, key_enc);
+
+        struct nlattr *key_dec = nla_nest_start(nl_msg, OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, key->decrypt.aead_key);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_len,
+                key->decrypt.implicit_iv);
+        nla_nest_end(nl_msg, key_dec);
+    }
+    else
+    {
+        /* Check that --auth is disabled. Normally, we would catch this
+         * inconsistency earlier but since the "none" is only for debug and
+         * requires manual editing of DCO_SUPPORTED_CIPHERS, it should be fine
+         * to abort here */
+        if (key->encrypt.hmac != NULL)
+        {
+            msg(M_FATAL, "FATAL: DCO with cipher none requires --auth none");
+        }
+        /* ovpn-dco needs empty encrypt/decrypt keys with cipher none */
+        struct nlattr *key_enc = nla_nest_start(nl_msg,
+                                                OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, 16,
+                key->encrypt.aead_key);
+        nla_nest_end(nl_msg, key_enc);
+
+        struct nlattr *key_dec = nla_nest_start(nl_msg,
+                                                OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, 16,
+                key->decrypt.aead_key);
+        nla_nest_end(nl_msg, key_dec);
+    }
+    nla_nest_end(nl_msg, attr);
+
+    secure_memzero(key->encrypt.aead_key, sizeof (key->encrypt.aead_key));
+    secure_memzero(key->decrypt.aead_key, sizeof (key->decrypt.aead_key));
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+int ovpn_set_peer(struct tuntap *tt, unsigned int peerid,
+                  unsigned int keepalive_interval,
+                  unsigned int keepalive_timeout)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d", __func__, peerid,
+                     keepalive_interval, keepalive_timeout);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(&tt->dco, OVPN_CMD_SET_PEER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+                keepalive_interval);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+                keepalive_timeout);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(&tt->dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+static int mcast_family_handler(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+    struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+
+    nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[CTRL_ATTR_MCAST_GROUPS])
+        return NL_SKIP;
+
+    struct nlattr *mcgrp;
+    int rem_mcgrp;
+    nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
+    {
+        struct nlattr *tb_mcgrp[CTRL_ATTR_MCAST_GRP_MAX + 1];
+
+        nla_parse(tb_mcgrp, CTRL_ATTR_MCAST_GRP_MAX,
+                  nla_data(mcgrp), nla_len(mcgrp), NULL);
+
+        if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME] ||
+            !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
+        {
+            continue;
+        }
+
+        if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
+                    OVPN_NL_MULTICAST_GROUP_PEERS,
+                    nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])) != 0)
+        {
+            continue;
+        }
+        dco->ovpn_dco_mcast_id = nla_get_u32(tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID]);
+        break;
+    }
+
+    return NL_SKIP;
+}
+/**
+ * Lookup the multicast id for OpenVPN. This method and its help method currently
+ * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS but
+ * extended in the future if we need to lookup more than one mcast id.
+  */
+static int
+ovpn_get_mcast_id(dco_context_t *dco)
+{
+    dco->ovpn_dco_mcast_id = -ENOENT;
+
+    /* Even though 'nlctrl' is a constant, there seem to be no library
+     * provided define for it */
+    int ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+
+    struct nl_msg *nl_msg = nlmsg_alloc();
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+
+    int ret = -EMSGSIZE;
+    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+    struct nlmsghdr *nlh = nlmsg_hdr(msg);
+
+    if (!genlmsg_valid_hdr(nlh, 0))
+    {
+        msg(D_DCO, "ovpn-dco: invalid header");
+        return NL_SKIP;
+    }
+
+    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+                  genlmsg_attrlen(gnlh, 0), NULL))
+    {
+        msg(D_DCO, "received bogus data from ovpn-dco");
+        return NL_SKIP;
+    }
+
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_SKIP;
+    }
+
+    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO, "ovpn-dco: received message type %d with mismatched ifindex %d\n",
+            gnlh->cmd, ifindex);
+        return NL_SKIP;
+    }
+
+    switch (gnlh->cmd) {
+    case OVPN_CMD_DEL_PEER:
+    {
+        if (!attrs[OVPN_ATTR_DEL_PEER])
+        {
+            msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
+            return NL_SKIP;
+        }
+
+        struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
+        if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
+                             attrs[OVPN_ATTR_DEL_PEER], NULL))
+        {
+            msg(D_DCO, "received bogus del peer packet data from ovpn-dco");
+            return NL_SKIP;
+        }
+
+        if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+        {
+            msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
+            return NL_SKIP;
+        }
+        if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+        {
+            msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
+            return NL_SKIP;
+        }
+        int reason = nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+        unsigned int peerid = nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);
+
+        msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
+            ifindex, peerid, reason);
+        dco->dco_meesage_peer_id = peerid;
+        dco->dco_del_peer_reason = reason;
+        dco->dco_message_type = OVPN_CMD_DEL_PEER;
+
+        break;
+    }
+    case OVPN_CMD_PACKET:
+    {
+        if (!attrs[OVPN_ATTR_PACKET])
+        {
+            msg(D_DCO, "ovpn-dco: no packet in OVPN_CMD_PACKET message");
+            return NL_SKIP;
+        }
+        struct nlattr *pkt_attrs[OVPN_PACKET_ATTR_MAX + 1];
+
+        if (nla_parse_nested(pkt_attrs, OVPN_PACKET_ATTR_MAX,
+                             attrs[OVPN_ATTR_PACKET], NULL))
+        {
+            msg(D_DCO, "received bogus cmd packet data from ovpn-dco");
+            return NL_SKIP;
+        }
+        if (!pkt_attrs[OVPN_PACKET_ATTR_PEER_ID])
+        {
+            msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without peer id");
+            return NL_SKIP;
+        }
+        if (!pkt_attrs[OVPN_PACKET_ATTR_PACKET])
+        {
+            msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without packet");
+            return NL_SKIP;
+        }
+
+        unsigned int peerid = nla_get_u32(pkt_attrs[OVPN_PACKET_ATTR_PEER_ID]);
+
+        uint8_t *data = nla_data(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+        int len = nla_len(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+
+        msg(D_DCO_DEBUG, "ovpn-dco: received OVPN_PACKET_ATTR_PACKET, ifindex: %d peer-id: %d, len %d",
+            ifindex, peerid, len);
+        if (BLEN(&dco->dco_packet_in) > 0)
+        {
+            msg(D_DCO, "DCO packet buffer still full?!");
+            return NL_SKIP;
+        }
+        buf_init(&dco->dco_packet_in, 0);
+        buf_write(&dco->dco_packet_in, data, len);
+        dco->dco_meesage_peer_id = peerid;
+        dco->dco_message_type = OVPN_CMD_PACKET;
+        break;
+    }
+    default:
+        msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
+        dco->dco_message_type = 0;
+        return NL_SKIP;
+    }
+
+    return NL_OK;
+}
+
+int
+ovpn_do_read_dco(struct dco_context *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
+    return ovpn_nl_recvmsgs(dco, __func__);
+}
+
+int
+ovpn_do_write_dco(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    packet_size_type len = BLEN(buf);
+    dmsg(D_STREAM_DEBUG, "DCO: WRITE %d offset=%d", (int)len, buf->offset);
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d, len=%d", __func__, peer_id, len);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PACKET);
+
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_PACKET);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_PACKET_ATTR_PEER_ID, peer_id);
+    NLA_PUT(nl_msg, OVPN_PACKET_ATTR_PACKET, len, BSTR(buf));
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    if (ret)
+    {
+        goto nla_put_failure;
+    }
+
+    /* return the length of the written data in case of success */
+    ret = len;
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+#endif
diff --git a/src/openvpn/networking_linuxdco.h b/src/openvpn/networking_linuxdco.h
new file mode 100644
index 00000000..be39437e
--- /dev/null
+++ b/src/openvpn/networking_linuxdco.h
@@ -0,0 +1,85 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef NETWORKING_LINUXDCO_H
+#define NETWORKING_LINUXDCO_H
+#if defined(ENABLE_LINUXDCO)
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <linux/ovpn_dco.h>
+
+typedef enum ovpn_key_slot ovpn_key_slot_t;
+
+#include "event.h"
+
+#define DCO_IROUTE_METRIC   100
+
+#define DCO_SUPPORTED_CIPHERS "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305"
+
+struct dco_context {
+    struct nl_sock *nl_sock;
+    struct nl_cb *nl_cb;
+    int status;
+
+    int ovpn_dco_id;
+    int ovpn_dco_mcast_id;
+
+    unsigned int ifindex;
+
+    struct buffer dco_packet_in;
+
+    int dco_message_type;
+    int dco_meesage_peer_id;
+    int dco_del_peer_reason;
+
+};
+
+typedef struct dco_context dco_context_t;
+
+
+/**
+ * @brief resolves the netlink ID for ovpn-dco
+ *
+ * This function queries the kernel via a netlink socket
+ * whether the ovpn-dco netlink namespace is available
+ *
+ * This function can be used to determine if the kernel
+ * support DCO offloading.
+ *
+ * @return ID on success, negative error code on error
+ */
+int
+resolve_ovpn_netlink_id(int msglevel);
+
+static inline void
+dco_event_set(struct dco_context *dco,
+              struct event_set *es,
+              void *arg) {
+    if (dco && dco->nl_sock) {
+        event_ctl(es, nl_socket_get_fd(dco->nl_sock), EVENT_READ, arg);
+    }
+}
+
+int ovpn_do_write_dco(dco_context_t *dco, int peer_id, struct buffer *buf);
+
+#endif
+#endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 65ee6839..b394cd4a 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -253,8 +253,9 @@
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
-    <ClCompile Include="env_set.c" />
+    <ClCompile Include="dco.c" />
     <ClCompile Include="dhcp.c" />
+    <ClCompile Include="env_set.c" />
     <ClCompile Include="error.c" />
     <ClCompile Include="event.c" />
     <ClCompile Include="fdmisc.c" />
@@ -335,6 +336,7 @@
     <ClInclude Include="crypto_backend.h" />
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
+    <ClInclude Include="dco.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="env_set.h" />
     <ClInclude Include="errlevel.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index f5fdfcd7..abb591e4 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -39,6 +39,9 @@
     <ClCompile Include="dhcp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="error.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -287,6 +290,9 @@
     <ClInclude Include="cryptoapi.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="dco.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="dhcp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ac13412a..a3014415 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -60,6 +60,7 @@
 #include "forward.h"
 #include "ssl_verify.h"
 #include "platform.h"
+#include "dco.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -105,6 +106,9 @@ const char title_string[] =
 #endif
 #endif
     " [AEAD]"
+#ifdef ENABLE_LINUXDCO
+    " [DCO]"
+#endif
     " built on " __DATE__
 ;
 
@@ -3220,6 +3224,133 @@ options_set_backwards_compatible_options(struct options *o)
 #endif
 }
 
+#if defined(ENABLE_DCO)
+static bool
+check_option_conflict_dco_ce(const struct connection_entry *ce, int msglevel)
+{
+    if (ce->fragment)
+    {
+        msg(msglevel, "Note: --fragment disables data channel offload.");
+        return true;
+    }
+
+    if (ce->http_proxy_options)
+    {
+        msg(msglevel, "Note: --http-proxy disables data channel offload.");
+        return true;
+    }
+
+    if (ce->socks_proxy_server)
+    {
+        msg(msglevel, "Note --socks-proxy disable data channel offload.");
+        return true;
+    }
+
+    return false;
+}
+
+#if defined(ENABLE_LINUXDCO)
+static bool check_option_conflict_dco_platform(int msglevel, const struct options *o)
+{
+    if (resolve_ovpn_netlink_id(D_TUNTAP_INFO) < 0)
+    {
+        msg(D_TUNTAP_INFO, "Note: Kernel support for ovpn-dco missing, disabling "
+                            "data channel offload.");
+        return true;
+    }
+    return false;
+}
+#endif
+
+bool check_option_conflict_dco(int msglevel, const struct options *o)
+{
+    if (o->tuntap_options.disable_dco)
+    {
+        /* already disabled by --disable-dco, no need to print warnings */
+        return true;
+    }
+
+    if (check_option_conflict_dco_platform(msglevel, o))
+    {
+        return true;
+    }
+
+    if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
+    {
+        msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
+        return true;
+    }
+
+    /* At this point the ciphers have already been normalised */
+    if (o->enable_ncp_fallback
+        && !tls_item_in_cipher_list(o->ciphername, DCO_SUPPORTED_CIPHERS))
+    {
+        msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
+                      "disables data channel offload.", o->ciphername);
+        return true;
+    }
+
+    if (o->connection_list)
+    {
+        const struct connection_list *l = o->connection_list;
+        for (int i = 0; i < l->len; ++i)
+        {
+            if (check_option_conflict_dco_ce(l->array[i], msglevel))
+            {
+                return true;
+            }
+        }
+    }
+    else
+    {
+        if (check_option_conflict_dco_ce(&o->ce, msglevel))
+        {
+            return true;
+        }
+    }
+
+    if (o->mode == MODE_SERVER && o->topology != TOP_SUBNET)
+    {
+        msg(msglevel, "Note: NOT using '--topology subnet' disables data channel offload.");
+        return true;
+    }
+
+#ifdef USE_COMP
+    if(o->comp.alg != COMP_ALG_UNDEF)
+    {
+        msg(msglevel, "Note: Using compression disables data channel offload.");
+
+        if (o->mode == MODE_SERVER && !(o->comp.flags & COMP_F_MIGRATE))
+        {
+            /* We can end up here from the multi.c call, only print the
+             * note if it is not already enabled */
+            msg(msglevel, "Consider using the '--compress migrate' option.");
+        }
+        return true;
+    }
+#endif
+
+    struct gc_arena gc = gc_new();
+
+
+    char *tmp_ciphers = string_alloc(o->ncp_ciphers, &gc);
+    const char *token;
+    while ((token = strsep(&tmp_ciphers, ":")))
+    {
+        if (!tls_item_in_cipher_list(token, DCO_SUPPORTED_CIPHERS))
+        {
+            msg(msglevel, "Note: cipher '%s' in --data-ciphers is not supported "
+                "by ovpn-dco, disabling data channel offload.", token);
+            gc_free(&gc);
+            return true;
+        }
+    }
+    gc_free(&gc);
+
+    return false;
+}
+#endif /* if defined(TARGET_LINUX) */
+
 static void
 options_postprocess_mutate(struct options *o)
 {
@@ -3306,7 +3437,11 @@ options_postprocess_mutate(struct options *o)
             "option set). ");
         o->verify_hash_no_ca = true;
     }
-
+#if defined(ENABLE_LINUXDCO)
+    o->tuntap_options.disable_dco = check_option_conflict_dco(D_DCO, o);
+#elif defined(TARGET_LINUX)
+    o->tuntap_options.disable_dco  = true;
+#endif
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
@@ -5643,6 +5778,12 @@ add_option(struct options *options,
         options->windows_driver = parse_windows_driver(p[1], M_FATAL);
     }
 #endif
+    else if (streq(p[0], "disable-dco") || streq(p[0], "dco-disable"))
+    {
+#if defined(TARGET_LINUX)
+        options->tuntap_options.disable_dco = true;
+#endif
+    }
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d4f41cd7..0affc71f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -862,4 +862,30 @@ void options_string_import(struct options *options,
                            unsigned int *option_types_found,
                            struct env_set *es);
 
+/**
+ * Returns whether the current configuration has dco enabled.
+ */
+#ifdef ENABLE_LINUXDCO
+static inline bool
+dco_enabled(struct options *o) { return !o->tuntap_options.disable_dco; }
+
+/**
+ * Checks whether the options struct has any option that is not supported by
+ * our current dco implementation. If so it prints a warning at warning level
+ * for the first conflicting option found and returns false
+ * @param msglevel  the msg level to use to print the warnings
+ * @param o         the optiions struct that hold the options
+ * @return          true if a conflict with dco is detected.
+ */
+bool
+check_option_conflict_dco(int msglevel, const struct options *o);
+#else
+/* Dummy functions to avoid ifdefs in the other code */
+
+static inline bool
+dco_enabled(struct options *o) { return false; }
+
+static inline bool
+check_option_conflict_dco(int msglevel, struct options *o) { return false; }
+#endif
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cc1e0c36..57142f4e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -120,6 +120,7 @@ struct link_socket_info
     sa_family_t af;                     /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
     bool bind_ipv6_only;
     int mtu_changed;            /* Set to true when mtu value is changed */
+    bool dco_installed;
 };
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4a4859c3..3e0be874 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1880,6 +1880,10 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, true, true);
 
+#if defined(ENABLE_DCO)
+    session->opt->key_type.keep_key_data = dco_enabled(options);
+#endif
+
     bool packet_id_long_form = cipher_kt_mode_ofb_cfb(session->opt->key_type.cipher);
     session->opt->crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
     if (packet_id_long_form)
@@ -2236,7 +2240,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
             {
                 buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
             }
-            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
+            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version());
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
 #endif
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f851bd2b..0da3c1f2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -167,6 +167,12 @@ enum auth_deferred_result {
     ACF_FAILED        /**< deferred auth has failed */
 };
 
+enum dco_key_status {
+    DCO_NOT_INSTALLED,
+    DCO_INSTALLED_PRIMARY,
+    DCO_INSTALLED_SECONDARY
+};
+
 /**
  * Security parameter state of one TLS and data channel %key session.
  * @ingroup control_processor
@@ -240,6 +246,8 @@ struct key_state
 
     struct auth_deferred_status plugin_auth;
     struct auth_deferred_status script_auth;
+
+    enum dco_key_status dco_status;
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
@@ -634,6 +642,11 @@ struct tls_multi
     /**< Array of \c tls_session objects
      *   representing control channel
      *   sessions with the remote peer. */
+
+    /* Only used when DCO is used to remember how many keys we installed
+     * for this session */
+    int dco_keys_installed;
+    bool dco_peer_added;
 };
 
 /**  gets an item  of \c key_state objects in the
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 4b95406e..7f5e6fe8 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -489,4 +489,4 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
         multi->use_peer_id, multi->peer_id, common_cipher);
 
     gc_free(&gc);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 75d5eaf7..fb3c2e8b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1957,6 +1957,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         open_null(tt);
     }
+    else if (!tt->options.disable_dco)
+    {
+        open_tun_dco(tt, dev);
+    }
     else
     {
         /*
@@ -2206,7 +2210,14 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
-    close_tun_generic(tt);
+    if (!tt->options.disable_dco)
+    {
+        close_tun_dco(tt);
+    }
+    else
+    {
+        close_tun_generic(tt);
+    }
     free(tt);
 }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index aa1e47b5..d5beb11c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -40,6 +40,7 @@
 #include "misc.h"
 #include "networking.h"
 #include "ring_buffer.h"
+#include "networking_linuxdco.h"
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
@@ -138,6 +139,7 @@ struct tuntap_options {
 
 struct tuntap_options {
     int txqueuelen;
+    bool disable_dco;
 };
 
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
@@ -218,6 +220,8 @@ struct tuntap
     /* Some TUN/TAP drivers like to be ioctled for mtu
      * after open */
     int post_open_mtu;
+
+    dco_context_t dco;
 };
 
 static inline bool
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 37b97188..20ac9e94 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -1,7 +1,10 @@
 #include "config.h"
 #include "syshead.h"
+#include "error.h"
 #include "networking.h"
 
+#include "mock_msg.h"
+
 
 static char *iface = "ovpn-dummy0";
 
@@ -16,8 +19,10 @@ net__iface_up(bool up)
 static int
 net__iface_new(const char *name, const char* type)
 {
-    printf("CMD: ip link add %s type %s\n", name, type);
-    return net_iface_new(name, type);
+    printf("CMD: ip link add type %s\n", type);
+    int ifidx = net_iface_new(NULL, type);
+    printf("ifindex: %d\n", ifidx);
+    return ifidx;
 }
 
 static int
-- 
2.32.0


