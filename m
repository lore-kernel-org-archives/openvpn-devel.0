Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1507C54FCD
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtH3URR6j0z2uTrXAAhJ1RZu0SvUkO0jnmtFcJD4yUs=; b=ALjJntSS6rz/nATJZBZYUo1YXD
	CeKub4HGnHAb1Ap0wiMf/ec3my5F+CLhuPBUekuDlK4XRyDFevx+Jbntp9P1JztRwuZkgDI5KINfa
	wjdQYxys40pwvpOmKxMyNlojTq8NstPqi/oiZZYzK60pdxE8v/IFT1+jUGg25NAQHo7M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp4Y6-0001R2-Vu;
	Wed, 29 Jul 2026 13:42:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp4Xu-0001Qo-0p
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gq1go1a5RnvOt4FRF7UF1JUcrFzeideIha7URoR+KtM=; b=SGvjXgfupYc48rP/R/1G33V47L
 tFnL0348YrAikZEnOJPoSDn/8kV/eDzc3bYtkslWLcqQM5syEQF7j5Hc2z14gV0NzVwGosdTWK3ex
 eKTf0y1opUfJ7KkeQeQz4O7maOFnxDIf4S1eblr+B7rqpNU7eDo+wZb2YvvZVLuFLmOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gq1go1a5RnvOt4FRF7UF1JUcrFzeideIha7URoR+KtM=; b=MkGqKHdM8/cngSui+1sxlyCkSn
 Q7PO1INuIeUYEARduaczhi5SF2vQ1kdQIw43xxHCufj2H8zWHyJ+dr3teHZ9jMNcboRoWYl0BmzKV
 HSlaOXhzHFz7UBKoiJnK+bAlFXp+u0Mp4rvHLmwvIYHML4azCOS8K+NsvtwdnTOQc19c=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp4Xo-00086n-E8 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:42:03 +0000
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h9D5X32TMzFrCG;
 Wed, 29 Jul 2026 15:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785332512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gq1go1a5RnvOt4FRF7UF1JUcrFzeideIha7URoR+KtM=;
 b=x27FP/c7/udQGaxPa51KQDHmK3C28vLyd8O35nhm1ojlAq0yRzdg/9+PqzO8Tj16xIa+sS
 I4WrEHh/pdjdvbQ2k2JBf4RnwNaa14/QYiUfeu0eMX6UdVy8RpB1FdV72jhShIQW3pZr98
 +qHitL2/5DX2ibcui2d3fUIx8AeL1MZM4Lo0sGffYC4soqDpL8mUV80/fmBnCgwjzT3wWG
 XxHw/N/u8NdDhHMG7YrWIB/INWS9xW4lb+FlaRaUAcfFjOWTnxjaL+BCSRLRnALxwNObN2
 dSagVuDCaylb+yAXFSfFnYsBaZoHKtXMylu/BPIw6CL3omAyHiUZeE6D7qNtpw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 15:41:31 +0200
Message-ID: <256a0f1828ffa78a4c1c002b5561812eb1d4635e.1785330764.git.ralf@mandelbit.com>
In-Reply-To: <bd44d25247e13a6f0c7d72a17db03cbf17b351e6.1785330764.git.ralf@mandelbit.com>
References: <bd44d25247e13a6f0c7d72a17db03cbf17b351e6.1785330764.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp4Xo-00086n-E8
Subject: [Openvpn-devel] [PATCH ovpn net v2 2/2] selftests: ovpn: add rtnl
 link mode check
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

Add a get_iface command to ovpn-cli that queries RTM_GETLINK and parses
the ovpn rtnl linkinfo nest, including IFLA_OVPN_MODE.

When called without an interface name, make get_iface issue a filtered
RTM_GETLINK dump for ovpn links. Use the dump form in the main ovpn
selftest to verify that each namespace reports exactly one ovpn
interface with the expected name and mode: MP for the server and P2P for
the clients.

This exercises the rtnl link-info dump path used by ovpn_fill_info.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch added in v2.

 tools/testing/selftests/net/ovpn/ovpn-cli.c | 157 +++++++++++++++++++-
 tools/testing/selftests/net/ovpn/test.sh    |  48 +++++-
 2 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..f633dcea2833 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -78,6 +78,7 @@ struct nl_ctx {
 enum ovpn_cmd {
 	CMD_INVALID,
 	CMD_NEW_IFACE,
+	CMD_GET_IFACE,
 	CMD_DEL_IFACE,
 	CMD_LISTEN,
 	CMD_CONNECT,
@@ -1417,6 +1418,143 @@ static int ovpn_new_iface(struct ovpn_ctx *ovpn)
 	return ret;
 }
 
+static const char *ovpn_mode_str(enum ovpn_mode mode)
+{
+	switch (mode) {
+	case OVPN_MODE_P2P:
+		return "P2P";
+	case OVPN_MODE_MP:
+		return "MP";
+	}
+
+	return "unknown";
+}
+
+static int ovpn_handle_iface(struct nlmsghdr *msg, void *arg)
+{
+	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
+	struct nlattr *data[IFLA_OVPN_MAX + 1];
+	struct nlattr *attrs[IFLA_MAX + 1];
+	const struct ifinfomsg *ifinfo;
+	bool dump = *(bool *)arg;
+	enum ovpn_mode mode;
+	const char *kind;
+	int ret;
+
+	if (msg->nlmsg_type != RTM_NEWLINK) {
+		fprintf(stderr, "unexpected rtnl message type: %u\n",
+			msg->nlmsg_type);
+		return -EINVAL;
+	}
+
+	if (msg->nlmsg_len < NLMSG_LENGTH(sizeof(*ifinfo))) {
+		fprintf(stderr, "truncated rtnl link message\n");
+		return -EINVAL;
+	}
+
+	ifinfo = NLMSG_DATA(msg);
+	ret = nla_parse(attrs, IFLA_MAX, (struct nlattr *)IFLA_RTA(ifinfo),
+			IFLA_PAYLOAD(msg), NULL);
+	if (ret < 0) {
+		fprintf(stderr, "cannot parse rtnl link attributes: %d\n", ret);
+		return ret;
+	}
+
+	if (!attrs[IFLA_LINKINFO]) {
+		fprintf(stderr, "missing linkinfo for ifindex %d\n",
+			ifinfo->ifi_index);
+		return -EINVAL;
+	}
+
+	ret = nla_parse(linkinfo, IFLA_INFO_MAX,
+			nla_data(attrs[IFLA_LINKINFO]),
+			nla_len(attrs[IFLA_LINKINFO]), NULL);
+	if (ret < 0) {
+		fprintf(stderr, "cannot parse linkinfo attributes: %d\n", ret);
+		return ret;
+	}
+
+	if (!linkinfo[IFLA_INFO_KIND]) {
+		fprintf(stderr, "missing link kind for ifindex %d\n",
+			ifinfo->ifi_index);
+		return -EINVAL;
+	}
+
+	kind = nla_get_string(linkinfo[IFLA_INFO_KIND]);
+	if (strcmp(kind, OVPN_FAMILY_NAME)) {
+		fprintf(stderr, "unexpected link kind: %s\n", kind);
+		return -EINVAL;
+	}
+
+	if (!linkinfo[IFLA_INFO_DATA]) {
+		fprintf(stderr, "missing ovpn link data for ifindex %d\n",
+			ifinfo->ifi_index);
+		return -EINVAL;
+	}
+
+	ret = nla_parse(data, IFLA_OVPN_MAX,
+			nla_data(linkinfo[IFLA_INFO_DATA]),
+			nla_len(linkinfo[IFLA_INFO_DATA]), NULL);
+	if (ret < 0) {
+		fprintf(stderr, "cannot parse ovpn link data: %d\n", ret);
+		return ret;
+	}
+
+	if (!data[IFLA_OVPN_MODE]) {
+		fprintf(stderr, "missing ovpn mode for ifindex %d\n",
+			ifinfo->ifi_index);
+		return -EINVAL;
+	}
+
+	mode = nla_get_u8(data[IFLA_OVPN_MODE]);
+	fprintf(stdout, "ifindex %d\n", ifinfo->ifi_index);
+	if (attrs[IFLA_IFNAME])
+		fprintf(stdout, "ifname %s\n",
+			nla_get_string(attrs[IFLA_IFNAME]));
+	fprintf(stdout, "kind %s\n", kind);
+	fprintf(stdout, "mode %s\n", ovpn_mode_str(mode));
+
+	return dump;
+}
+
+static int ovpn_get_iface(struct ovpn_ctx *ovpn)
+{
+	uint32_t ext_filter_mask = RTEXT_FILTER_SKIP_STATS;
+	struct ovpn_link_req req = { 0 };
+	bool dump = !ovpn->ifindex;
+	struct rtattr *linkinfo;
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	if (dump)
+		req.n.nlmsg_flags |= NLM_F_DUMP;
+	req.n.nlmsg_type = RTM_GETLINK;
+
+	/* don't include stats */
+	if (ovpn_addattr(&req.n, sizeof(req), IFLA_EXT_MASK,
+			 &ext_filter_mask, sizeof(ext_filter_mask)) < 0)
+		return -1;
+
+	/* if no iface was provided as argument, dump only the ovpn ifaces */
+	if (dump) {
+		linkinfo = ovpn_nest_start(&req.n, sizeof(req), IFLA_LINKINFO);
+		if (!linkinfo)
+			return -1;
+
+		if (ovpn_addattr(&req.n, sizeof(req), IFLA_INFO_KIND,
+				 OVPN_FAMILY_NAME,
+				 strlen(OVPN_FAMILY_NAME) + 1) < 0)
+			return -1;
+
+		ovpn_nest_end(&req.n, linkinfo);
+	}
+
+	req.i.ifi_family = AF_PACKET;
+	req.i.ifi_index = ovpn->ifindex;
+
+	return ovpn_rt_send(&req.n, 0, 0, ovpn_handle_iface, &dump);
+}
+
 static int ovpn_del_iface(struct ovpn_ctx *ovpn)
 {
 	struct ovpn_link_req req = { 0 };
@@ -1672,6 +1810,11 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
 	fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
 
+	fprintf(stderr,
+		"* get_iface [iface]: dump ovpn interface attributes\n");
+	fprintf(stderr,
+		"\tiface: optional ovpn interface name; omit it to dump all ovpn interfaces in the current netns\n");
+
 	fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 
@@ -1926,6 +2069,9 @@ static enum ovpn_cmd ovpn_parse_cmd(const char *cmd)
 	if (!strcmp(cmd, "new_iface"))
 		return CMD_NEW_IFACE;
 
+	if (!strcmp(cmd, "get_iface"))
+		return CMD_GET_IFACE;
+
 	if (!strcmp(cmd, "del_iface"))
 		return CMD_DEL_IFACE;
 
@@ -1994,6 +2140,9 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 	case CMD_NEW_IFACE:
 		ret = ovpn_new_iface(ovpn);
 		break;
+	case CMD_GET_IFACE:
+		ret = ovpn_get_iface(ovpn);
+		break;
 	case CMD_DEL_IFACE:
 		ret = ovpn_del_iface(ovpn);
 		break;
@@ -2170,8 +2319,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 {
 	int ret;
 
-	/* no args required for LISTEN_MCAST */
-	if (ovpn->cmd == CMD_LISTEN_MCAST)
+	/* no args required for LISTEN_MCAST or GET_IFACE in dump mode */
+	if (ovpn->cmd == CMD_LISTEN_MCAST ||
+	    (ovpn->cmd == CMD_GET_IFACE && argc == 2))
 		return 0;
 
 	/* all commands need an ifname */
@@ -2181,7 +2331,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 	strscpy(ovpn->ifname, argv[2], IFNAMSIZ - 1);
 	ovpn->ifname[IFNAMSIZ - 1] = '\0';
 
-	/* all commands, except NEW_IFNAME, needs an ifindex */
+	/* all commands, except CMD_NEW_IFACE, needs an ifindex */
 	if (ovpn->cmd != CMD_NEW_IFACE) {
 		ovpn->ifindex = if_nametoindex(ovpn->ifname);
 		if (!ovpn->ifindex) {
@@ -2207,6 +2357,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		ovpn->mode_set = true;
 		break;
+	case CMD_GET_IFACE:
 	case CMD_DEL_IFACE:
 		break;
 	case CMD_LISTEN:
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..acd4aed0d254 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,49 @@ ovpn_prepare_network() {
 	done
 }
 
+ovpn_check_iface() {
+	local expected
+	local peer_ns
+	local actual
+	local ifname
+	local count
+	local mode
+	local dump
+	local p
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ifname="tun${p}"
+		mode="P2P"
+		[ "${p}" -eq 0 ] && mode="MP"
+
+		if ! dump=$(ip netns exec "${peer_ns}" ${OVPN_CLI} get_iface);
+		then
+			printf 'failed to dump ovpn ifaces in %s\n' "${peer_ns}"
+			return 1
+		fi
+
+		# ensure exactly 1 iface is reported
+		count=$(printf '%s\n' "${dump}" | grep -c '^ifindex ' || true)
+		if [ "${count}" -ne 1 ]; then
+			printf 'unexpected iface count (%d) in %s\n' \
+				"${count}" "${peer_ns}"
+			return 1
+		fi
+
+		# validate the stable interface attributes
+		printf -v expected 'ifname %s\nmode %s' "${ifname}" "${mode}"
+		actual=$(printf '%s\n' "${dump}" |
+			sed -n -e '/^ifname /p' -e '/^mode /p')
+		if [[ "${actual}" != "${expected}" ]]; then
+			printf 'unexpected ovpn interface in %s:\n' "${peer_ns}"
+			printf 'expected:\n%s\nactual:\n%s\n' \
+				"${expected}" "${actual}"
+			return 1
+		fi
+	done
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,15 +336,16 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
 modprobe -q ovpn || true
 
 ovpn_run_stage "setup network topology" ovpn_prepare_network
+ovpn_run_stage "validate iface modes" ovpn_check_iface
 ovpn_run_stage "run baseline data traffic" ovpn_run_basic_traffic
 ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
 [ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
