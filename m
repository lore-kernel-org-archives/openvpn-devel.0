From: Kristof Provost <kprovost@...2661...>
Date: Fri, 12 Aug 2022 15:41:53 +0200
Message-Id: <20220812134154.16729-2-kprovost@...2661...>
In-Reply-To: <20220812134154.16729-1-kprovost@...2661...>
References: <20220812134154.16729-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Implement data-channel offload for FreeBSD. The implementation and flow
is very similar to that of the Linux DCO support.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 configure.ac                   |   5 +
 src/openvpn/Makefile.am        |   1 +
 src/openvpn/dco.c              |   8 +
 src/openvpn/dco_freebsd.c      | 645 +++++++++++++++++++++++++++++++++
 src/openvpn/dco_freebsd.h      |  59 +++
 src/openvpn/dco_internal.h     |   1 +
 src/openvpn/forward.c          |   8 +-
 src/openvpn/mtcp.c             |   4 +-
 src/openvpn/mudp.c             |   2 +-
 src/openvpn/multi.c            |   4 +-
 src/openvpn/options.c          |   8 +-
 src/openvpn/options.h          |   4 +-
 src/openvpn/ovpn_dco_freebsd.h |  64 ++++
 src/openvpn/tun.c              |  39 +-
 src/openvpn/tun.h              |   6 +
 15 files changed, 827 insertions(+), 31 deletions(-)
 create mode 100644 src/openvpn/dco_freebsd.c
 create mode 100644 src/openvpn/dco_freebsd.h
 create mode 100644 src/openvpn/ovpn_dco_freebsd.h

diff --git a/configure.ac b/configure.ac
index 9466fe15..f715b404 100644
--- a/configure.ac
+++ b/configure.ac
@@ -787,6 +787,11 @@ dnl
 			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
 			;;
+		*-*-freebsd*)
+			LIBS="${LIBS} -lnv"
+			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
+			AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
+			;;
 		*)
 			AC_MSG_NOTICE([Ignoring --enable-dco on non Linux platform])
 			;;
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index aaa1dbce..2a139b23 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -54,6 +54,7 @@ openvpn_SOURCES = \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	dco.c dco.h dco_internal.h \
+	dco_freebsd.c dco_freebsd.h \
 	dco_linux.c dco_linux.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 4f40255e..07dc1087 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -271,6 +271,14 @@ dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
         return false;
     }
 
+#if defined(TARGET_FREEBSD)
+    if (! proto_is_udp(ce->proto))
+    {
+        msg(msglevel, "TCP is not supported.");
+        return false;
+    }
+#endif
+
     return true;
 }
 
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
new file mode 100644
index 00000000..06b4d6a9
--- /dev/null
+++ b/src/openvpn/dco_freebsd.c
@@ -0,0 +1,645 @@
+/*
+ *  Interface to FreeBSD dco networking code
+ *
+ *  Copyright (C) 2022 Rubicon Communications, LLC (Netgate). All Rights Reserved.
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
+#if defined(ENABLE_DCO) && defined(TARGET_FREEBSD)
+
+#include "syshead.h"
+
+#include <sys/param.h>
+#include <sys/linker.h>
+#include <sys/nv.h>
+#include <netinet/in.h>
+
+#include "dco_freebsd.h"
+#include "dco.h"
+#include "tun.h"
+#include "crypto.h"
+#include "ssl_common.h"
+
+static nvlist_t *
+sockaddr_to_nvlist(const struct sockaddr *sa)
+{
+    nvlist_t *nvl = nvlist_create(0);
+
+    nvlist_add_number(nvl, "af", sa->sa_family);
+
+    switch (sa->sa_family)
+    {
+        case AF_INET:
+        {
+            const struct sockaddr_in *in = (const struct sockaddr_in *)sa;
+            nvlist_add_binary(nvl, "address", &in->sin_addr, sizeof(in->sin_addr));
+            nvlist_add_number(nvl, "port", in->sin_port);
+            break;
+        }
+
+        case AF_INET6:
+        {
+            const struct sockaddr_in6 *in6 = (const struct sockaddr_in6 *)sa;
+            nvlist_add_binary(nvl, "address", &in6->sin6_addr, sizeof(in6->sin6_addr));
+            nvlist_add_number(nvl, "port", in6->sin6_port);
+            break;
+        }
+
+        default:
+            ASSERT(0);
+    }
+
+    return (nvl);
+}
+
+int
+dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    nvl = nvlist_create(0);
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    if (localaddr)
+    {
+        nvlist_add_nvlist(nvl, "local", sockaddr_to_nvlist(localaddr));
+    }
+
+    if (remoteaddr)
+    {
+        nvlist_add_nvlist(nvl, "remote", sockaddr_to_nvlist(remoteaddr));
+    }
+
+    if (remote_in4)
+    {
+        nvlist_add_binary(nvl, "vpn_ipv4", &remote_in4->s_addr,
+                          sizeof(remote_in4->s_addr));
+    }
+
+    if (remote_in6)
+    {
+        nvlist_add_binary(nvl, "vpn_ipv6", remote_in6, sizeof(*remote_in6));
+    }
+
+    nvlist_add_number(nvl, "fd", sd);
+    nvlist_add_number(nvl, "peerid", peerid);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_NEW_PEER;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_ERR | M_ERRNO, "Failed to create new peer");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+static int
+open_fd(dco_context_t *dco)
+{
+    int ret;
+
+    ret = pipe2(dco->pipefd, O_CLOEXEC | O_NONBLOCK);
+    if (ret != 0)
+    {
+        return -1;
+    }
+
+    dco->fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    if (dco->fd != -1)
+    {
+        dco->open = true;
+    }
+    dco->dco_packet_in = alloc_buf(PAGE_SIZE);
+
+    return dco->fd;
+}
+
+static void
+close_fd(dco_context_t *dco)
+{
+    close(dco->pipefd[0]);
+    close(dco->pipefd[1]);
+    close(dco->fd);
+}
+
+bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
+    if (open_fd(dco) < 0)
+    {
+        msg(M_ERR, "Failed to open socket");
+        return false;
+    }
+    return true;
+}
+
+static int
+create_interface(struct tuntap *tt, const char *dev)
+{
+    int ret;
+    struct ifreq ifr;
+
+    CLEAR(ifr);
+
+    /* Create ovpnx first, then rename it. */
+    snprintf(ifr.ifr_name, IFNAMSIZ, "ovpn");
+    ret = ioctl(tt->dco.fd, SIOCIFCREATE2, &ifr);
+    if (ret)
+    {
+        msg(M_ERR | M_ERRNO, "Failed to create interface %s", ifr.ifr_name);
+        return ret;
+    }
+
+    /* Rename */
+    if (!strcmp(dev, "tun"))
+    {
+        ifr.ifr_data = "ovpn";
+    }
+    else
+    {
+        ifr.ifr_data = (char *)dev;
+    }
+    ret = ioctl(tt->dco.fd, SIOCSIFNAME, &ifr);
+    if (ret)
+    {
+        /* Delete the created interface again. */
+        (void)ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
+        msg(M_ERR | M_ERRNO, "Failed to create interface %s", ifr.ifr_data);
+        return ret;
+    }
+
+    snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
+    tt->actual_name = string_alloc(tt->dco.ifname, NULL);
+
+    return 0;
+}
+
+static int
+remove_interface(struct tuntap *tt)
+{
+    int ret;
+    struct ifreq ifr;
+
+    CLEAR(ifr);
+    snprintf(ifr.ifr_name, IFNAMSIZ, "%s", tt->dco.ifname);
+
+    ret = ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
+    if (ret)
+    {
+        msg(M_ERR | M_ERRNO, "Failed to remove interface %s", ifr.ifr_name);
+    }
+
+    tt->dco.ifname[0] = 0;
+
+    return ret;
+}
+
+int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    int ret;
+
+    ret = create_interface(tt, dev);
+
+    if (ret < 0)
+    {
+        msg(M_ERR, "Failed to create interface");
+    }
+
+    return ret;
+}
+
+void
+close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+    remove_interface(tt);
+    close_fd(&tt->dco);
+}
+
+int
+dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    nvl = nvlist_create(0);
+    nvlist_add_number(nvl, "peerid", peerid);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_SWAP_KEYS;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to swap keys");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+int
+dco_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    nvl = nvlist_create(0);
+    nvlist_add_number(nvl, "peerid", peerid);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_DEL_PEER;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to delete peer");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+int
+dco_del_key(dco_context_t *dco, unsigned int peerid,
+            dco_key_slot_t slot)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+
+    nvl = nvlist_create(0);
+    nvlist_add_number(nvl, "slot", slot);
+    nvlist_add_number(nvl, "peerid", peerid);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_DEL_KEY;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to delete key");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+static nvlist_t *
+key_to_nvlist(const uint8_t *key, const uint8_t *implicit_iv, const char *ciphername)
+{
+    nvlist_t *nvl;
+    size_t key_len;
+
+    nvl = nvlist_create(0);
+
+    nvlist_add_string(nvl, "cipher", ciphername);
+
+    if (strcmp(ciphername, "none") != 0)
+    {
+        key_len = cipher_kt_key_size(ciphername);
+
+        nvlist_add_binary(nvl, "key", key, key_len);
+        nvlist_add_binary(nvl, "iv", implicit_iv, 8);
+    }
+
+    return (nvl);
+}
+
+static int
+start_tun(dco_context_t *dco)
+{
+    struct ifdrv drv;
+    int ret;
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_START_VPN;
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_ERR | M_ERRNO, "Failed to start vpn");
+    }
+
+    return ret;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+        __func__, slot, keyid, peerid, ciphername);
+
+    nvl = nvlist_create(0);
+
+    nvlist_add_number(nvl, "slot", slot);
+    nvlist_add_number(nvl, "keyid", keyid);
+    nvlist_add_number(nvl, "peerid", peerid);
+
+    nvlist_add_nvlist(nvl, "encrypt",
+                      key_to_nvlist(encrypt_key, encrypt_iv, ciphername));
+    nvlist_add_nvlist(nvl, "decrypt",
+                      key_to_nvlist(decrypt_key, decrypt_iv, ciphername));
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_NEW_KEY;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_ERR | M_ERRNO, "Failed to set key");
+    }
+    else
+    {
+        ret = start_tun(dco);
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout,
+             int mss)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    nvl = nvlist_create(0);
+    nvlist_add_number(nvl, "peerid", peerid);
+    nvlist_add_number(nvl, "interval", keepalive_interval);
+    nvlist_add_number(nvl, "timeout", keepalive_timeout);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_SET_PEER;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to set keepalive");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+int
+dco_do_read(dco_context_t *dco)
+{
+    struct ifdrv drv;
+    uint8_t buf[4096];
+    nvlist_t *nvl;
+    const uint8_t *pkt;
+    size_t pktlen;
+    int ret;
+
+    /* Flush any pending data from the pipe. */
+    (void)read(dco->pipefd[1], buf, sizeof(buf));
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_GET_PKT;
+    drv.ifd_data = buf;
+    drv.ifd_len = sizeof(buf);
+
+    ret = ioctl(dco->fd, SIOCGDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to read control packet");
+        return -errno;
+    }
+
+    nvl = nvlist_unpack(buf, drv.ifd_len, 0);
+    if (!nvl)
+    {
+        msg(M_WARN, "Failed to unpack nvlist");
+        return -EINVAL;
+    }
+
+    dco->dco_message_peer_id = nvlist_get_number(nvl, "peerid");
+
+    if (nvlist_exists_binary(nvl, "packet"))
+    {
+        pkt = nvlist_get_binary(nvl, "packet", &pktlen);
+        memcpy(BPTR(&dco->dco_packet_in), pkt, pktlen);
+        dco->dco_packet_in.len = pktlen;
+        dco->dco_message_type = OVPN_CMD_PACKET;
+    }
+    else
+    {
+        dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
+        dco->dco_message_type = OVPN_CMD_DEL_PEER;
+    }
+
+    nvlist_destroy(nvl);
+
+    return 0;
+}
+
+int
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    nvl = nvlist_create(0);
+
+    nvlist_add_binary(nvl, "packet", BSTR(buf), BLEN(buf));
+    nvlist_add_number(nvl, "peerid", peer_id);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_SEND_PKT;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to send control packet");
+        ret = -errno;
+    }
+    else
+    {
+        ret = BLEN(buf);
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
+bool
+dco_available(int msglevel)
+{
+    struct if_clonereq ifcr;
+    char *buf = NULL;
+    int fd;
+    int ret;
+    bool available = false;
+
+    /* Attempt to load the module. Ignore errors, because it might already be
+     * loaded, or built into the kernel. */
+    (void)kldload("if_ovpn");
+
+    fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    if (fd < 0)
+    {
+        return false;
+    }
+
+    CLEAR(ifcr);
+
+    /* List cloners and check if openvpn is there. That tells us if this kernel
+     * supports if_ovpn (i.e. DCO) or not. */
+    ret = ioctl(fd, SIOCIFGCLONERS, &ifcr);
+    if (ret != 0)
+    {
+        goto out;
+    }
+
+    buf = malloc(ifcr.ifcr_total * IFNAMSIZ);
+
+    ifcr.ifcr_count = ifcr.ifcr_total;
+    ifcr.ifcr_buffer = buf;
+    ret = ioctl(fd, SIOCIFGCLONERS, &ifcr);
+    if (ret != 0)
+    {
+        goto out;
+    }
+
+    for (int i = 0; i < ifcr.ifcr_total; i++)
+    {
+        if (strcmp(buf + (i * IFNAMSIZ), "openvpn") == 0)
+        {
+            available = true;
+            goto out;
+        }
+    }
+
+out:
+    free(buf);
+    close(fd);
+
+    return available;
+}
+
+void
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    uint8_t buf[128];
+    int ret;
+
+    if (!dco || !dco->open)
+    {
+        return;
+    }
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_POLL_PKT;
+    drv.ifd_len = sizeof(buf);
+    drv.ifd_data = buf;
+
+    ret = ioctl(dco->fd, SIOCGDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to poll for packets");
+        return;
+    }
+
+    nvl = nvlist_unpack(buf, drv.ifd_len, 0);
+    if (!nvl)
+    {
+        msg(M_WARN, "Failed to unpack nvlist");
+        return;
+    }
+
+    if (nvlist_get_number(nvl, "pending") > 0)
+    {
+        (void)write(dco->pipefd[0], " ", 1);
+        event_ctl(es, dco->pipefd[1], EVENT_READ, arg);
+    }
+
+    nvlist_destroy(nvl);
+}
+
+const char *
+dco_get_supported_ciphers()
+{
+    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+
+#endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
new file mode 100644
index 00000000..3594f229
--- /dev/null
+++ b/src/openvpn/dco_freebsd.h
@@ -0,0 +1,59 @@
+/*
+ *  Interface to FreeBSD dco networking code
+ *
+ *  Copyright (C) 2022 Rubicon Communications, LLC (Netgate). All Rights Reserved.
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
+#ifndef DCO_FREEBSD_H
+#define DCO_FREEBSD_H
+
+#if defined(ENABLE_DCO) && defined(TARGET_FREEBSD)
+
+#include <buffer.h>
+#include "event.h"
+
+#include "ovpn_dco_freebsd.h"
+
+typedef enum ovpn_key_slot dco_key_slot_t;
+typedef enum ovpn_key_cipher dco_cipher_t;
+
+enum ovpn_message_type_t {
+    OVPN_CMD_DEL_PEER,
+    OVPN_CMD_PACKET,
+};
+
+enum ovpn_del_reason_t {
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+    OVPN_DEL_PEER_REASON_USERSPACE,
+};
+
+typedef struct dco_context {
+    bool open;
+    int fd;
+    int pipefd[2];
+
+    char ifname[IFNAMSIZ];
+
+    struct buffer dco_packet_in;
+
+    int dco_message_type;
+    int dco_message_peer_id;
+    int dco_del_peer_reason;
+} dco_context_t;
+
+#endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
+#endif /* ifndef DCO_FREEBSD_H */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 3ceb26d6..728e3092 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -27,6 +27,7 @@
 
 #if defined(ENABLE_DCO)
 
+#include "dco_freebsd.h"
 #include "dco_linux.h"
 
 /**
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 55c939c4..14ad24fa 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1113,7 +1113,7 @@ process_incoming_link(struct context *c)
 static void
 process_incoming_dco(struct context *c)
 {
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
     struct link_socket_info *lsi = get_link_socket_info(c);
     dco_context_t *dco = &c->c1.tuntap->dco;
 
@@ -1140,7 +1140,7 @@ process_incoming_dco(struct context *c)
 
     c->c2.buf = orig_buff;
     buf_init(&dco->dco_packet_in, 0);
-#endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+#endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */
 }
 
 /*
@@ -1946,7 +1946,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = FILE_SHIFT;
 #endif
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     static int dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
 #endif
 
@@ -2056,7 +2056,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_shift);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index eb88a56a..1abb903f 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -283,7 +283,7 @@ multi_tcp_wait(const struct context *c,
     }
 #endif
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif
 
@@ -763,7 +763,7 @@ multi_tcp_process_io(struct multi_context *m)
                     multi_tcp_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
             /* incoming data on DCO? */
             else if (e->arg == MTCP_DCO)
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index ddb1efc9..4ab18b72 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -381,7 +381,7 @@ multi_process_io_udp(struct multi_context *m)
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
     else if (status & DCO_READ)
     {
         if (!IS_SIG(&m->top))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dcf4438d..53ee3e1a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3154,7 +3154,7 @@ multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *m
     multi_close_instance(m, mi, false);
 }
 
-#if (defined(ENABLE_DCO) && defined(TARGET_LINUX)) || defined(ENABLE_MANAGEMENT)
+#if (defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))) || defined(ENABLE_MANAGEMENT)
 static void
 multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
 {
@@ -3163,7 +3163,7 @@ multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const
 }
 #endif
 
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
 static void
 process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,
                             dco_context_t *dco)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0ce3158b..14cb4cc4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -183,7 +183,7 @@ static const char usage_message[] =
     "                  does not begin with \"tun\" or \"tap\".\n"
     "--dev-node node : Explicitly set the device node rather than using\n"
     "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
     "--disable-dco   : Do not attempt using Data Channel Offload.\n"
 #endif
     "--lladdr hw     : Set the link layer address of the tap device.\n"
@@ -1794,7 +1794,7 @@ show_settings(const struct options *o)
     SHOW_STR(dev);
     SHOW_STR(dev_type);
     SHOW_STR(dev_node);
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
     SHOW_BOOL(tuntap_options.disable_dco);
 #endif
     SHOW_STR(lladdr);
@@ -3670,7 +3670,7 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     }
 
     /* check if any option should force disabling DCO */
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
 #endif
 
@@ -5872,7 +5872,7 @@ add_option(struct options *options,
 #endif
     else if (streq(p[0], "disable-dco"))
     {
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
         options->tuntap_options.disable_dco = true;
 #endif
     }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ec3c44b1..212f4b05 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -876,7 +876,7 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
 
 /**
  * Returns whether the current configuration has dco enabled.
@@ -887,7 +887,7 @@ dco_enabled(const struct options *o)
     return !o->tuntap_options.disable_dco;
 }
 
-#else /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+#else /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))*/
 
 static inline bool
 dco_enabled(const struct options *o)
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
new file mode 100644
index 00000000..abebbb78
--- /dev/null
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -0,0 +1,64 @@
+/*-
+ * SPDX-License-Identifier: BSD-2-Clause-FreeBSD
+ *
+ * Copyright (c) 2021 Rubicon Communications, LLC (Netgate)
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _NET_IF_OVPN_H_
+#define _NET_IF_OVPN_H_
+
+#include <sys/types.h>
+#include <netinet/in.h>
+
+/* Maximum size of an ioctl request. */
+#define OVPN_MAX_REQUEST_SIZE	4096
+
+enum ovpn_notif_type {
+	OVPN_NOTIF_DEL_PEER,
+};
+
+enum ovpn_key_slot {
+	OVPN_KEY_SLOT_PRIMARY	= 0,
+	OVPN_KEY_SLOT_SECONDARY	= 1
+};
+
+enum ovpn_key_cipher {
+	OVPN_CIPHER_ALG_NONE			= 0,
+	OVPN_CIPHER_ALG_AES_GCM			= 1,
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305	= 2
+};
+
+#define OVPN_NEW_PEER		_IO  ('D', 1)
+#define OVPN_DEL_PEER		_IO  ('D', 2)
+#define OVPN_GET_STATS		_IO  ('D', 3)
+#define OVPN_NEW_KEY		_IO  ('D', 4)
+#define OVPN_SWAP_KEYS		_IO  ('D', 5)
+#define OVPN_DEL_KEY		_IO  ('D', 6)
+#define OVPN_SET_PEER		_IO  ('D', 7)
+#define OVPN_START_VPN		_IO  ('D', 8)
+#define OVPN_SEND_PKT		_IO  ('D', 9)
+#define OVPN_POLL_PKT		_IO  ('D', 10)
+#define OVPN_GET_PKT		_IO  ('D', 11)
+
+#endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f3152a52..11025267 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1722,7 +1722,7 @@ tun_name_is_fixed(const char *dev)
     return has_digit(dev);
 }
 
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static bool
 tun_dco_enabled(struct tuntap *tt)
 {
@@ -1836,9 +1836,9 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
         tt->actual_name = string_alloc(dynamic_opened ? dynamic_name : dev, NULL);
     }
 }
-#endif /* !_WIN32 && !TARGET_LINUX */
+#endif /* !_WIN32 && !TARGET_LINUX && !TARGET_FREEBSD*/
 
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static void
 open_tun_dco_generic(const char *dev, const char *dev_type,
                      struct tuntap *tt, openvpn_net_ctx_t *ctx)
@@ -1911,7 +1911,7 @@ open_tun_dco_generic(const char *dev, const char *dev_type,
         tt->actual_name = string_alloc(dev, NULL);
     }
 }
-#endif /* TARGET_LINUX */
+#endif /* TARGET_LINUX || TARGET_FREEBSD*/
 
 #if !defined(_WIN32)
 static void
@@ -2294,7 +2294,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (tun_dco_enabled(tt))
     {
         close_tun_dco(tt, ctx);
@@ -2915,20 +2915,27 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, tt);
-
-    if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
+    if (tun_dco_enabled(tt))
     {
-        int i = IFF_POINTOPOINT | IFF_MULTICAST;
+        open_tun_dco_generic(dev, dev_type, tt, ctx);
+    }
+    else
+    {
+        open_tun_generic(dev, dev_type, dev_node, tt);
 
-        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+        if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
         {
-            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
-        }
-        i = 1;
-        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
-        {
-            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+            int i = IFF_POINTOPOINT | IFF_MULTICAST;
+
+            if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+            {
+                msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
+            }
+            i = 1;
+            if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
+            {
+                msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+            }
         }
     }
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8ec8f51f..ea4946e9 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -142,6 +142,12 @@ struct tuntap_options {
     bool disable_dco;
 };
 
+#elif defined(TARGET_FREEBSD)
+
+struct tuntap_options {
+    bool disable_dco;
+};
+
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
 struct tuntap_options {
-- 
2.37.1


