Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EB6C98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4DYg4+HkBcul385YtRFEnsEY5aZcWy5V4GVQH/OuLE=; b=iwrhw+WQfCObxTfRdu5J88aHHa
	ibkaCa781X+pufTROlgvgucB9cdaiwo+Tbu7K+rg5pRHprTQsqc5E4JquNvrOPwVCiA0e9gUDYVMZ
	6dxsuL8SeeH+Wxt/HhzKkHDOQ/ka/Vb+JVN2X6azxarGrqAyoI10y7ODB49HgoUBeAFs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91R4-0000om-Na;
	Tue, 22 Sep 2026 14:25:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x91Qv-0000nt-Ar
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NuWFKiWa11wHoN5Ze5PjQ6Zu35DOMLokSV4aSPNjjY0=; b=JkAoBOn7NTaVsHGWtJ6p9uJBU0
 j8NDt1WPNeQkust+nkxkg992oFFWW+iBobt912bUJHOXHEz0hy3P4SfxTEg+vDbzIqIePuE0kkMJp
 8WXiY3vmfRHPGOCEyYlqcDN0dom8GNV/a/7gvq42ojXsg1j50l7DZVxUpu0YJaSQZCZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NuWFKiWa11wHoN5Ze5PjQ6Zu35DOMLokSV4aSPNjjY0=; b=eMfg929qhOQMgpMg9OMgfB0jUd
 3c+nz0Lbdd0K1ocYDaOv8j1PioR6YFoZfb6CcXnne4YGc9lve5qTNKbJLIiobsOfrqk57/FAgxSaH
 nFZfTNHhUY6kE6Teexdq7WZs0XqhGw3ovXORY9FG8LjOJCUmmiUrwGK6AzKshyQJMb+M=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x91Qu-0005bZ-7B for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:22 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hq2S833tyzNlZ7;
 Tue, 22 Sep 2026 16:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790087112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuWFKiWa11wHoN5Ze5PjQ6Zu35DOMLokSV4aSPNjjY0=;
 b=lru9UP/6Di5BTDFdUAr7CO/nnS1DoyiIAlr2FtBoo24D+nqg8A61eac1uebsP8KFBa6FQb
 elkZ6E0jSTU0nbeg3p8Xf0FSqnp2scWfZBhKS7qdbVZx1E2YYopDzfbzsnqJvZxuth2HEr
 F94jB4h8Mm+hPcc7dRK96HLHpztdMTVKR0BZCiJg8Ywe9lMyEn5HHYEdiFhb5/XjlhA/0/
 ZAbB8mnPQWohkIE2Rp02FdvXq8p44Q29net7aBvM81aZNnRXFbCNh/Yf9KwV2sQXVryKwL
 UOHIPYS0zmzc09/YVzFjzCld73iR2FQp9QZv6utS1eeP1uEwFCbdpPBb/mHxPw==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 16:25:05 +0200
Message-ID: <20260922142505.3138388-3-marco@mandelbit.com>
In-Reply-To: <20260922142505.3138388-1-marco@mandelbit.com>
References: <20260922142505.3138388-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x91Qu-0005bZ-7B
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/3] selftests: ovpn: test
 operations in a foreign netns
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Extend ovpn-cli with -n to resolve an interface in a named network
namespace and include OVPN_A_TARGET_NETNSID in peer and key requests.

Use -n for existing peer and key operations that do not create transport
sockets, exercising foreign-netns requests throughout the test suite.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/common.sh    |   8 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 265 +++++++++++++++++-
 .../selftests/net/ovpn/test-close-socket.sh   |   4 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |   6 +-
 tools/testing/selftests/net/ovpn/test.sh      |  50 ++--
 5 files changed, 288 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e3..4f2510fb6d7f7 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -221,7 +221,7 @@ ovpn_add_peer() {
 				${OVPN_UDP_PEERS_FILE}
 
 			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-				ip netns exec "${server_ns}" ${OVPN_CLI} \
+				"${OVPN_CLI}" -n "${server_ns}" \
 					new_key tun0 ${p} 1 0 ${OVPN_ALG} 0 \
 					data64.key
 			done
@@ -244,7 +244,7 @@ ovpn_add_peer() {
 			ip netns exec "${peer_ns}" ${OVPN_CLI} new_peer \
 				tun${1} ${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} \
 				${RPORT}
-			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${1} \
+			"${OVPN_CLI}" -n "${peer_ns}" new_key tun${1} \
 				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
 		fi
 	else
@@ -252,8 +252,8 @@ ovpn_add_peer() {
 			(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
 				1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
 				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-					ip netns exec "${server_ns}" \
-						${OVPN_CLI} new_key tun0 ${p} \
+					"${OVPN_CLI}" -n "${server_ns}" \
+						new_key tun0 ${p} \
 						1 0 ${OVPN_ALG} 0 data64.key
 				done
 			}) &
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0f..a0e4f2f581b59 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -6,6 +6,7 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <fcntl.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <inttypes.h>
@@ -21,6 +22,7 @@
 #include <linux/ovpn.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
+#include <linux/net_namespace.h>
 
 #include <netlink/socket.h>
 #include <netlink/netlink.h>
@@ -121,6 +123,8 @@ struct ovpn_ctx {
 
 	unsigned int ifindex;
 	char ifname[IFNAMSIZ];
+	const char *target_netns_name;
+	int target_netnsid;
 	enum ovpn_mode mode;
 	bool mode_set;
 
@@ -224,6 +228,10 @@ static struct nl_ctx *nl_ctx_alloc_flags(struct ovpn_ctx *ovpn, int cmd,
 	if (ovpn->ifindex > 0)
 		NLA_PUT_U32(ctx->nl_msg, OVPN_A_IFINDEX, ovpn->ifindex);
 
+	if (ovpn->target_netnsid >= 0)
+		NLA_PUT_S32(ctx->nl_msg, OVPN_A_TARGET_NETNSID,
+			    ovpn->target_netnsid);
+
 	return ctx;
 nla_put_failure:
 err_msg:
@@ -1365,12 +1373,195 @@ static int ovpn_rt_send(struct nlmsghdr *payload, pid_t peer,
 	return ret;
 }
 
+static int ovpn_parse_netnsid(struct nlmsghdr *msg, void *arg)
+{
+	struct rtgenmsg *gen;
+	struct rtattr *attr;
+	int len;
+
+	if (msg->nlmsg_type != RTM_NEWNSID ||
+	    msg->nlmsg_len < NLMSG_LENGTH(sizeof(*gen)))
+		return -EINVAL;
+
+	gen = NLMSG_DATA(msg);
+	len = NLMSG_PAYLOAD(msg, sizeof(*gen));
+	attr = (struct rtattr *)((char *)gen + NLMSG_ALIGN(sizeof(*gen)));
+
+	for (; RTA_OK(attr, len); attr = RTA_NEXT(attr, len)) {
+		if (attr->rta_type != NETNSA_NSID)
+			continue;
+
+		if (RTA_PAYLOAD(attr) < sizeof(int32_t))
+			return -EINVAL;
+
+		memcpy(arg, RTA_DATA(attr), sizeof(int32_t));
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+struct ovpn_netns_req {
+	struct nlmsghdr n;
+	struct rtgenmsg g;
+	char buf[64];
+};
+
+static int ovpn_get_netnsid(int netns_fd, int *netnsid)
+{
+	struct ovpn_netns_req req = { 0 };
+	uint32_t fd = netns_fd;
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.g));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_GETNSID;
+	req.g.rtgen_family = AF_UNSPEC;
+
+	if (ovpn_addattr(&req.n, sizeof(req), NETNSA_FD, &fd,
+			 sizeof(fd)) < 0)
+		return -EMSGSIZE;
+
+	*netnsid = NETNSA_NSID_NOT_ASSIGNED;
+	return ovpn_rt_send(&req.n, 0, 0, ovpn_parse_netnsid, netnsid);
+}
+
+static int ovpn_assign_netnsid(int netns_fd)
+{
+	/* NETNSA_NSID_NOT_ASSIGNED asks the kernel to allocate an NSID. */
+	int32_t netnsid = NETNSA_NSID_NOT_ASSIGNED;
+	struct ovpn_netns_req req = { 0 };
+	uint32_t fd = netns_fd;
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.g));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_NEWNSID;
+	req.g.rtgen_family = AF_UNSPEC;
+
+	if (ovpn_addattr(&req.n, sizeof(req), NETNSA_NSID, &netnsid,
+			 sizeof(netnsid)) < 0 ||
+	    ovpn_addattr(&req.n, sizeof(req), NETNSA_FD, &fd,
+			 sizeof(fd)) < 0)
+		return -EMSGSIZE;
+
+	return ovpn_rt_send(&req.n, 0, 0, NULL, NULL);
+}
+
+/* Get the target NSID relative to the current netns, assigning one if necessary. */
+static int ovpn_get_or_assign_netnsid(int netns_fd)
+{
+	int netnsid, ret;
+
+	ret = ovpn_get_netnsid(netns_fd, &netnsid);
+	if (ret < 0)
+		return ret;
+
+	if (netnsid >= 0)
+		return netnsid;
+
+	ret = ovpn_assign_netnsid(netns_fd);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
+	ret = ovpn_get_netnsid(netns_fd, &netnsid);
+	if (ret < 0)
+		return ret;
+
+	if (netnsid < 0)
+		return -ENOENT;
+
+	return netnsid;
+}
+
+static int ovpn_parse_ifindex(struct nlmsghdr *msg, void *arg)
+{
+	struct ifinfomsg *ifinfo;
+
+	if (msg->nlmsg_type != RTM_NEWLINK ||
+	    msg->nlmsg_len < NLMSG_LENGTH(sizeof(*ifinfo)))
+		return -EINVAL;
+
+	ifinfo = NLMSG_DATA(msg);
+	if (ifinfo->ifi_index <= 0)
+		return -EINVAL;
+
+	*(unsigned int *)arg = ifinfo->ifi_index;
+
+	return 0;
+}
+
 struct ovpn_link_req {
 	struct nlmsghdr n;
 	struct ifinfomsg i;
 	char buf[256];
 };
 
+static int ovpn_get_ifindex(int netnsid, const char *ifname,
+			    unsigned int *ifindex)
+{
+	struct ovpn_link_req req = { 0 };
+	int32_t id = netnsid;
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_GETLINK;
+	req.i.ifi_family = AF_UNSPEC;
+
+	if (ovpn_addattr(&req.n, sizeof(req), IFLA_TARGET_NETNSID, &id,
+			 sizeof(id)) < 0 ||
+	    ovpn_addattr(&req.n, sizeof(req), IFLA_IFNAME, ifname,
+			 strlen(ifname) + 1) < 0)
+		return -EMSGSIZE;
+
+	return ovpn_rt_send(&req.n, 0, 0, ovpn_parse_ifindex, ifindex);
+}
+
+#define NETNS_RUN_DIR "/var/run/netns"
+
+static int ovpn_resolve_netns(struct ovpn_ctx *ovpn)
+{
+	int len, target_fd, ret;
+	char path[PATH_MAX];
+
+	if (!ovpn->target_netns_name[0] ||
+	    strchr(ovpn->target_netns_name, '/')) {
+		fprintf(stderr, "invalid network namespace name: %s\n",
+			ovpn->target_netns_name);
+		return -EINVAL;
+	}
+
+	len = snprintf(path, sizeof(path), "%s/%s", NETNS_RUN_DIR,
+		       ovpn->target_netns_name);
+	if (len < 0 || len >= (int)sizeof(path))
+		return -ENAMETOOLONG;
+
+	target_fd = open(path, O_RDONLY);
+	if (target_fd < 0) {
+		ret = errno;
+		fprintf(stderr, "cannot open network namespace %s: %s\n",
+			ovpn->target_netns_name, strerror(ret));
+		return -ret;
+	}
+
+	ovpn->target_netnsid = ovpn_get_or_assign_netnsid(target_fd);
+	if (ovpn->target_netnsid < 0) {
+		ret = ovpn->target_netnsid;
+		fprintf(stderr, "cannot resolve network namespace ID for %s\n",
+			ovpn->target_netns_name);
+		goto out;
+	}
+
+	ret = ovpn_get_ifindex(ovpn->target_netnsid, ovpn->ifname,
+			       &ovpn->ifindex);
+	if (ret < 0) {
+		fprintf(stderr, "cannot find interface %s in namespace %s\n",
+			ovpn->ifname, ovpn->target_netns_name);
+	}
+out:
+	close(target_fd);
+
+	return ret;
+}
+
 static int ovpn_new_iface(struct ovpn_ctx *ovpn)
 {
 	struct rtattr *linkinfo, *data;
@@ -1662,8 +1853,10 @@ static int ovpn_listen_mcast(void)
 static void usage(const char *cmd)
 {
 	fprintf(stderr,
-		"Usage %s <command> <iface> [arguments..]\n",
+		"Usage %s [-n <netns>] <command> <iface> [arguments..]\n",
 		cmd);
+	fprintf(stderr,
+		"\t-n netns: run peer/key operations on an interface in the named network namespace\n");
 	fprintf(stderr, "where <command> can be one of the following\n\n");
 
 	fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn interface\n");
@@ -1968,6 +2161,26 @@ static enum ovpn_cmd ovpn_parse_cmd(const char *cmd)
 	return CMD_INVALID;
 }
 
+static bool ovpn_cmd_supports_target_netns(enum ovpn_cmd cmd)
+{
+	switch (cmd) {
+	case CMD_LISTEN:
+	case CMD_CONNECT:
+	case CMD_NEW_PEER:
+	case CMD_NEW_MULTI_PEER:
+	case CMD_SET_PEER:
+	case CMD_DEL_PEER:
+	case CMD_GET_PEER:
+	case CMD_NEW_KEY:
+	case CMD_DEL_KEY:
+	case CMD_GET_KEY:
+	case CMD_SWAP_KEYS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* Send process to background and waits for signal.
  *
  * This helper is called at the end of commands
@@ -2023,6 +2236,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			}
 
 			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.target_netnsid = ovpn->target_netnsid;
 			peer_ctx.sa_family = ovpn->sa_family;
 			peer_ctx.asymm_id = ovpn->asymm_id;
 
@@ -2109,6 +2323,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.target_netnsid = ovpn->target_netnsid;
 			peer_ctx.socket = ovpn->socket;
 			peer_ctx.sa_family = AF_UNSPEC;
 			peer_ctx.asymm_id = ovpn->asymm_id;
@@ -2181,13 +2396,19 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 	strscpy(ovpn->ifname, argv[2], IFNAMSIZ - 1);
 	ovpn->ifname[IFNAMSIZ - 1] = '\0';
 
-	/* all commands, except NEW_IFNAME, needs an ifindex */
+	/* all commands, except NEW_IFACE, need an ifindex */
 	if (ovpn->cmd != CMD_NEW_IFACE) {
-		ovpn->ifindex = if_nametoindex(ovpn->ifname);
-		if (!ovpn->ifindex) {
-			fprintf(stderr, "cannot find interface: %s\n",
-				strerror(errno));
-			return -1;
+		if (ovpn->target_netns_name) {
+			ret = ovpn_resolve_netns(ovpn);
+			if (ret < 0)
+				return ret;
+		} else {
+			ovpn->ifindex = if_nametoindex(ovpn->ifname);
+			if (!ovpn->ifindex) {
+				fprintf(stderr, "cannot find interface: %s\n",
+					strerror(errno));
+				return -1;
+			}
 		}
 	}
 
@@ -2433,30 +2654,52 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 int main(int argc, char *argv[])
 {
+	const char *program = argv[0];
 	struct ovpn_ctx ovpn;
 	int ret;
 
+	memset(&ovpn, 0, sizeof(ovpn));
+	if (argc > 1 && !strcmp(argv[1], "-n")) {
+		if (argc < 4) {
+			fprintf(stderr,
+				"Error: -n requires a namespace and a command.\n\n");
+			usage(program);
+			return -EINVAL;
+		}
+
+		ovpn.target_netns_name = argv[2];
+		argc -= 2;
+		argv += 2;
+	}
+
 	if (argc < 2) {
-		usage(argv[0]);
+		usage(program);
 		return -1;
 	}
 
-	memset(&ovpn, 0, sizeof(ovpn));
+	ovpn.target_netnsid = NETNSA_NSID_NOT_ASSIGNED;
 	ovpn.sa_family = AF_UNSPEC;
 	ovpn.cipher = OVPN_CIPHER_ALG_NONE;
 
 	ovpn.cmd = ovpn_parse_cmd(argv[1]);
 	if (ovpn.cmd == CMD_INVALID) {
 		fprintf(stderr, "Error: unknown command.\n\n");
-		usage(argv[0]);
+		usage(program);
 		return -1;
 	}
 
+	if (ovpn.target_netns_name &&
+	    !ovpn_cmd_supports_target_netns(ovpn.cmd)) {
+		fprintf(stderr, "Error: -n is not supported for command %s.\n",
+			argv[1]);
+		return -EOPNOTSUPP;
+	}
+
 	ret = ovpn_parse_cmd_args(&ovpn, argc, argv);
 	if (ret < 0) {
 		fprintf(stderr, "Error: invalid arguments.\n\n");
 		if (ret == -EINVAL)
-			usage(argv[0]);
+			usage(program);
 		return ret;
 	}
 
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index ec9a51bbf3c92..0e4e33b2973fd 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -40,10 +40,10 @@ ovpn_prepare_network() {
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
-			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 set_peer tun0 \
 				${p} 60 120
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+			"${OVPN_CLI}" -n "${peer_ns}" set_peer \
 				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
 	done
 }
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 7c1d56e9c525d..8a9ca52f86be1 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -42,7 +42,7 @@ ovpn_mark_prepare_network() {
 			ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "install server key for peer ${p}" \
-			ip netns exec ovpn_peer0 "${OVPN_CLI}" new_key tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 new_key tun0 \
 				"${p}" 1 0 "${OVPN_ALG}" 0 data64.key
 	done
 
@@ -53,10 +53,10 @@ ovpn_mark_prepare_network() {
 	for p in $(seq 1 3); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
-			ip netns exec ovpn_peer0 "${OVPN_CLI}" set_peer tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 set_peer tun0 \
 				"${p}" 60 120
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
-			ip netns exec "${peer_ns}" "${OVPN_CLI}" set_peer \
+			"${OVPN_CLI}" -n "${peer_ns}" set_peer \
 				tun"${p}" $((p + OVPN_ID_OFFSET)) 60 120
 	done
 }
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032f..468dd7985c8f2 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -48,10 +48,10 @@ ovpn_prepare_network() {
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
-			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 set_peer tun0 \
 				${p} 60 120
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+			"${OVPN_CLI}" -n "${peer_ns}" set_peer \
 				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
 	done
 }
@@ -151,14 +151,14 @@ ovpn_run_key_rollover() {
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "add secondary key on peer0 for peer ${p}" \
-			ip netns exec ovpn_peer0 ${OVPN_CLI} new_key tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 new_key tun0 \
 				${p} 2 1 ${OVPN_ALG} 0 data64.key
 		ovpn_cmd_ok "add secondary key on peer${p} for peer ${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${p} \
+			"${OVPN_CLI}" -n "${peer_ns}" new_key tun${p} \
 				$((p + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 \
 				data64.key
 		ovpn_cmd_ok "swap keys on peer${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} swap_keys \
+			"${OVPN_CLI}" -n "${peer_ns}" swap_keys \
 				tun${p} $((p + OVPN_ID_OFFSET))
 	done
 }
@@ -166,22 +166,22 @@ ovpn_run_key_rollover() {
 ovpn_run_queries() {
 	ovpn_log "Querying all peers:"
 
-	ovpn_cmd_ok "query all peers from peer0" \
-		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0
-	ovpn_cmd_ok "query all peers from peer1" \
-		ip netns exec ovpn_peer1 ${OVPN_CLI} get_peer tun1
+	ovpn_cmd_ok "query all peers on peer0" \
+		"${OVPN_CLI}" -n ovpn_peer0 get_peer tun0
+	ovpn_cmd_ok "query all peers on peer1" \
+		"${OVPN_CLI}" -n ovpn_peer1 get_peer tun1
 
 	ovpn_log "Querying peer 1:"
 
-	ovpn_cmd_ok "query peer 1 from peer0" \
-		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0 1
+	ovpn_cmd_ok "query peer 1 on peer0" \
+		"${OVPN_CLI}" -n ovpn_peer0 get_peer tun0 1
 }
 
 ovpn_query_peer_missing() {
 	ovpn_log "Querying non-existent peer 20:"
 
 	ovpn_cmd_fail "query missing peer 20 on peer0" \
-		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0 20
+		"${OVPN_CLI}" -n ovpn_peer0 get_peer tun0 20
 }
 
 ovpn_run_peer_cleanup() {
@@ -191,9 +191,9 @@ ovpn_run_peer_cleanup() {
 	ovpn_log "Deleting peer 1:"
 
 	ovpn_cmd_ok "delete peer1 on peer0" \
-		ip netns exec ovpn_peer0 ${OVPN_CLI} del_peer tun0 1
+		"${OVPN_CLI}" -n ovpn_peer0 del_peer tun0 1
 	ovpn_cmd_ok "delete peer1 on peer1" \
-		ip netns exec ovpn_peer1 ${OVPN_CLI} del_peer tun1 \
+		"${OVPN_CLI}" -n ovpn_peer1 del_peer tun1 \
 			$((1 + OVPN_ID_OFFSET))
 
 	ovpn_log "Querying keys:"
@@ -201,10 +201,10 @@ ovpn_run_peer_cleanup() {
 	for p in $(seq 2 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "query peer${p} key 1" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} get_key tun${p} \
+			"${OVPN_CLI}" -n "${peer_ns}" get_key tun${p} \
 				$((p + OVPN_ID_OFFSET)) 1
 		ovpn_cmd_ok "query peer${p} key 2" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} get_key tun${p} \
+			"${OVPN_CLI}" -n "${peer_ns}" get_key tun${p} \
 				$((p + OVPN_ID_OFFSET)) 2
 	done
 }
@@ -217,16 +217,16 @@ ovpn_run_traffic_delete_peer() {
 	ovpn_run_bg ping_pid ip netns exec ovpn_peer2 ping -qf -w 4 5.5.5.1
 	sleep 2
 	ovpn_cmd_ok "delete peer0 peer 2" \
-		ip netns exec ovpn_peer0 ${OVPN_CLI} del_peer tun0 2
+		"${OVPN_CLI}" -n ovpn_peer0 del_peer tun0 2
 
 	if [ "${OVPN_PROTO}" == "TCP" ]; then
 		# In TCP mode this command is expected to fail for both peers.
 		ovpn_cmd_mayfail "delete peer2 peer 2 (TCP non-fatal)" \
-			ip netns exec ovpn_peer2 ${OVPN_CLI} del_peer tun2 \
+			"${OVPN_CLI}" -n ovpn_peer2 del_peer tun2 \
 				$((2 + OVPN_ID_OFFSET))
 	else
-		ovpn_cmd_ok "delete peer2 peer 2" ip netns exec ovpn_peer2 \
-			${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET))
+		ovpn_cmd_ok "delete peer2 peer 2" "${OVPN_CLI}" -n ovpn_peer2 \
+			del_peer tun2 $((2 + OVPN_ID_OFFSET))
 	fi
 
 	wait "${ping_pid}" || true
@@ -241,10 +241,10 @@ ovpn_run_key_cleanup() {
 	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "delete key 1 for peer${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} del_key tun${p} \
+			"${OVPN_CLI}" -n "${peer_ns}" del_key tun${p} \
 				$((p + OVPN_ID_OFFSET)) 1
 		ovpn_cmd_ok "delete key 2 for peer${p}" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} del_key tun${p} \
+			"${OVPN_CLI}" -n "${peer_ns}" del_key tun${p} \
 				$((p + OVPN_ID_OFFSET)) 2
 	done
 }
@@ -258,11 +258,11 @@ ovpn_run_timeouts() {
 	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 		# Non-fatal: this may fail in some protocol modes.
 		ovpn_cmd_mayfail "set peer0 timeout for peer ${p} (non-fatal)" \
-			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+			"${OVPN_CLI}" -n ovpn_peer0 set_peer tun0 \
 				${p} 3 3
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "disable timeout on peer${p} while peer0 adjusts \
-			state" ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+			state" "${OVPN_CLI}" -n "${peer_ns}" set_peer \
 			tun${p} $((p + OVPN_ID_OFFSET)) 0 0
 	done
 	# wait for peers to timeout
@@ -273,7 +273,7 @@ ovpn_run_timeouts() {
 	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer${p} P2P timeout" \
-			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+			"${OVPN_CLI}" -n "${peer_ns}" set_peer \
 				tun${p} $((p + OVPN_ID_OFFSET)) 3 3
 	done
 	sleep 5
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
