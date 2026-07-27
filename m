Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E955C53209
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPdl+OmI1ykMRrFGX3CvGUnsUSsHf1AxChep4u2ibzA=; b=PaI1VxD4CWcCTYCIEulNvLMPnu
	pDcATG9nwZfzJ6A1ehzwHZYEvy5f1de15vYkAuDekYuAnFLjEK+XP8hrFj9zrm6Ml/sQM9z/DBdZ8
	aOO4fSlDl4pN0xT7vCuDZXiGrFf78BL5biKU/B4gS4/OLJROcnU2RpXjixfQ5IU5VL9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woF1U-0000st-HP;
	Mon, 27 Jul 2026 06:41:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1woF1T-0000sj-I6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 06:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=olgU3+9rnN7y7aarm1d5tRDFA5iR2QWDIw/Ftjy1wjc=; b=agpY1HrhMSO5mbyC+wTXepBKAH
 FVL+PzE1Wvb3/P5IjeYr66zfYccZAXqgYNb8mdRSNiRaS3BkcW6nIo4pwCcC4QAQBnmqblmffQXmf
 GMRWot6qe/sLSFNs0lTDN+Hv1sSyHASESfhB0Pic1K+7Svu7gOQEeKWbsTos4Py27uao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=olgU3+9rnN7y7aarm1d5tRDFA5iR2QWDIw/Ftjy1wjc=; b=Gcko+ca2Pt4z3Q9lk26+2Lwn1x
 nJKf9llFYj8dWBB7h+U27J7QeEmdFGxca8rWfHeJb9vpuTQDviJeXUnKBow9RavdPO17IRCjtZ9do
 et4Fp/A1SJNRnyYbZkmQUwSLQbOcVvVfbjajJrF4Z409IOUW2QTvs8cUxDR0mp5EF1SA=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woF1P-0002aw-8J for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 06:41:08 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h7prq3FNnz9tKp;
 Mon, 27 Jul 2026 08:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785134459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olgU3+9rnN7y7aarm1d5tRDFA5iR2QWDIw/Ftjy1wjc=;
 b=yJkENKWWQQyNUcV3yEpeJJjQQP9Od2wTGg9WWGjWcRB3yaNQRxoG4wZorVZFv4M45FovHi
 v/UtjUMi5t+MDBVKQurIWXvw+w0mys6YaIxEszkweDaJLSo65np21i7YrYpLRcLUJRRn3N
 4G84wnWyI4oE6+vKFxon3hRpWpjIZFem9AhFWJffY8cd/J1XevyvpHC0xp0XsWBajpw5zD
 XUvpkB9zA71k0/2N7fy/XnqMEr773YBYcJRrqdzQRp3Gw5kebuI47qSgumC33G7G1PQi8E
 MCy/KbYLYJ+xaIp8hkdIf6pz+ARsLoNh+wUyNuLUlYOQXiWwJ5Sr585KtogGCA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 08:40:41 +0200
Message-ID: <20260727064041.1872159-2-marco@mandelbit.com>
In-Reply-To: <20260727064041.1872159-1-marco@mandelbit.com>
References: <20260727064041.1872159-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h7prq3FNnz9tKp
X-Headers-End: 1woF1P-0002aw-8J
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/2] selftests: ovpn: test
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Extend ovpn-cli with -n to resolve an interface in a named network
namespace and include OVPN_A_TARGET_NETNSID in peer and key requests.

Test peer get and dump requests issued outside the interface network
namespace, including local lookup and invalid NSID failures.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 266 +++++++++++++++++-
 .../testing/selftests/net/ovpn/test-netns.sh  |  81 ++++++
 3 files changed, 337 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-netns.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..01ec1c25efd2 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -39,6 +39,7 @@ TEST_PROGS := \
 	test-float.sh \
 	test-large-mtu.sh \
 	test-mark.sh \
+	test-netns.sh \
 	test-symmetric-id-float.sh \
 	test-symmetric-id-tcp.sh \
 	test-symmetric-id.sh \
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..6ea39b3ecc29 100644
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
@@ -1365,12 +1373,196 @@ static int ovpn_rt_send(struct nlmsghdr *payload, pid_t peer,
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
+	int target_fd, ret;
+	char path[PATH_MAX];
+	int len;
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
@@ -1662,8 +1854,10 @@ static int ovpn_listen_mcast(void)
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
@@ -1966,6 +2160,26 @@ static enum ovpn_cmd ovpn_parse_cmd(const char *cmd)
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
@@ -2021,6 +2235,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			}
 
 			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.target_netnsid = ovpn->target_netnsid;
 			peer_ctx.sa_family = ovpn->sa_family;
 			peer_ctx.asymm_id = ovpn->asymm_id;
 
@@ -2107,6 +2322,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			peer_ctx.ifindex = ovpn->ifindex;
+			peer_ctx.target_netnsid = ovpn->target_netnsid;
 			peer_ctx.socket = ovpn->socket;
 			peer_ctx.sa_family = AF_UNSPEC;
 			peer_ctx.asymm_id = ovpn->asymm_id;
@@ -2179,13 +2395,19 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
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
 
@@ -2432,29 +2654,51 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 int main(int argc, char *argv[])
 {
 	struct ovpn_ctx ovpn;
+	const char *program = argv[0];
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
 
diff --git a/tools/testing/selftests/net/ovpn/test-netns.sh b/tools/testing/selftests/net/ovpn/test-netns.sh
new file mode 100755
index 000000000000..ab351e2cf4f0
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-netns.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 OpenVPN, Inc.
+#
+#	Author:	Marco Baffo <marco@mandelbit.com>
+
+#set -x
+set -eE
+
+source ./common.sh
+
+TARGET_IFINDEX=
+ovpn_test_finished=0
+
+ovpn_test_exit() {
+	ovpn_cleanup
+	modprobe -r ovpn || true
+
+	if [ "${ovpn_test_finished}" -eq 0 ]; then
+		ktap_print_totals
+	fi
+}
+
+ovpn_netns_prepare_network() {
+	local peer_ns="ovpn_peer0"
+
+	ovpn_cmd_ok "create namespace peer0" ovpn_create_ns 0
+	ovpn_cmd_ok "create peer0 interface" \
+		ip netns exec "${peer_ns}" "${OVPN_CLI}" new_iface tun0 P2P
+	ovpn_cmd_ok "register peer1 in peer0 namespace" \
+		ip netns exec "${peer_ns}" "${OVPN_CLI}" new_peer tun0 1 \
+			none 1194 ::1 1195
+
+	TARGET_IFINDEX=$(ip -n "${peer_ns}" -j link show tun0 | \
+		jq -er '.[0].ifindex')
+}
+
+ovpn_netns_get_peer() {
+	ovpn_cmd_ok "get peer through target namespace" \
+		"${OVPN_CLI}" -n ovpn_peer0 get_peer tun0 1
+}
+
+ovpn_netns_dump_peers() {
+	ovpn_cmd_ok "dump peers through target namespace" \
+		"${OVPN_CLI}" -n ovpn_peer0 get_peer tun0
+}
+
+ovpn_netns_reject_local_lookup() {
+	ovpn_cmd_fail "reject local namespace lookup" \
+		"${OVPN_CLI}" get_peer tun0 1
+}
+
+ovpn_netns_reject_invalid_nsid() {
+	local request
+
+	printf -v request '{"ifindex":%d,"target-netnsid":-1}' \
+		"${TARGET_IFINDEX}"
+	ovpn_cmd_fail "reject invalid target netns ID" \
+		"${OVPN_YNL}" --family ovpn --dump peer-get \
+			--json "${request}" --output-json
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
+
+ktap_print_header
+ktap_set_plan 5
+
+ovpn_cleanup
+modprobe -q ovpn || true
+
+ovpn_run_stage "prepare foreign-netns interface" ovpn_netns_prepare_network
+ovpn_run_stage "get foreign-netns peer" ovpn_netns_get_peer
+ovpn_run_stage "dump foreign-netns peers" ovpn_netns_dump_peers
+ovpn_run_stage "reject local namespace lookup" \
+	ovpn_netns_reject_local_lookup
+ovpn_run_stage "reject invalid target netns ID" \
+	ovpn_netns_reject_invalid_nsid
+
+ovpn_test_finished=1
+ktap_finished
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
