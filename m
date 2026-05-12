Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22670CD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9zfz+/aLLuqlVs9P5EQvqoHYXxLH6RIc9gKXxqPu20=; b=JhyPBLpR+JeX4NPyAw7E5+dnNA
	BHh6qziWfpB77+5EaJm8+KspMjp6xcP6CaqSfSB1TcexnT2t5v3W5VawNgCsLU2A1Kowa/mLcuvxM
	B4gJ0c4fYsO0oHCgiXMjNXUBTQBRXYnyEZJuQc7p04fCBG0F/Pq1O65oz62T57dCoUxo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMoMD-0004Ej-4s;
	Tue, 12 May 2026 14:45:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wMoM9-0004E2-07
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h6A47cZNK89OUWp8g+Os3O6Y2qEQPwVAeYCjOb10kPs=; b=YhizFcQZYL2Hz0GXTHv8XSaYdA
 Inwc0XEa5/VyLPbaWy/lr2UlUaPcpmHIJwmHi8S8NQ04svWZ+Mq/b6MzMa3upaUbWnwFVHCRWFX5M
 k7wvi/umLGnmWzVcG0V2kgOa99X1ebc0GQl6o3DXV+Bd6QCmUx+4qknmueRAM6e/aTyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h6A47cZNK89OUWp8g+Os3O6Y2qEQPwVAeYCjOb10kPs=; b=m9cYVo0P1bzAKfgWme8ZP23IcJ
 5AMvV4xRKm956/+vkAY27397d0oBTSF/gsq3TEhDeXz1Z9BqDDavwhoQdy5HK32oTBgyAyw8zS8xb
 SvViX9jzQRzXrXzJq2vL0sHa792q/HV91uDEh2UoQFZUSzw/QJo4hjIij3atudbeDtLg=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMoM6-0007Il-Rs for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:09 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gFKBG32Xyz9vHn;
 Tue, 12 May 2026 16:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778597094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6A47cZNK89OUWp8g+Os3O6Y2qEQPwVAeYCjOb10kPs=;
 b=AKI7oXtaRKUErLtY766aDBKLKA9tN+Uo02C8LOznCot2my9d/0VwwbB8/ExqMNbCo8ceZS
 4WO+/vhh0UviWDpcK9p1wM6M/d9YWWZoN8loJLS+TyiGMcHQO9ZQhJDPhfPOviTM34tD/U
 Cx/JspLPR0t8Ohl9mzIK3F3W72U/3dxvIW+3UqYJT+EzyMnRhx74HxKqswJti4xHHneHhe
 1GXA6QbY0FdxF12V8AiEfx1rmQKhzceQ8Sv67KjwwdkVk/MSBoEqGrl/M6ure3HNRTZegz
 9t/MgBdlGNWJG4X44nZjBW8pM1Q0pAt3J2ontNh7lWIc7KsIUXyzHf7LgUlarw==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 12 May 2026 16:43:57 +0200
Message-ID: <20260512144358.419599-4-a@unstable.cc>
In-Reply-To: <20260512144358.419599-1-a@unstable.cc>
References: <20260512144358.419599-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wMoM6-0007Il-Rs
Subject: [Openvpn-devel] [PATCH ovpn net-next 4/5] selftests: ovpn: add test
 for bound address
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
Cc: Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Ralf Lici <ralf@mandelbit.com>

Extend the bound socket selftest to cover UDP sockets bound to a local
address.

The address variant verifies that peer1 transmits ovpn data with the
configured local address as the outer source address, even when routing
selects the other underlay device. It also checks peer2 receive-side
binding by accepting packets sent to the configured local address on
both underlay paths.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   7 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 212 +++++++++---------
 .../selftests/net/ovpn/test-bind-addr.sh      |  10 +
 tools/testing/selftests/net/ovpn/test-bind.sh | 185 +++++++++++----
 tools/testing/selftests/net/ovpn/test-mark.sh |   2 +-
 6 files changed, 270 insertions(+), 147 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind-addr.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 5c70cac0a95b..453bee34ea08 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -33,6 +33,7 @@ TEST_FILES = \
 # end of TEST_FILES
 
 TEST_PROGS := \
+	test-bind-addr.sh \
 	test-bind.sh \
 	test-chachapoly.sh \
 	test-close-socket-tcp.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 06ce298b6e0e..a51186cbb1dd 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -214,12 +214,13 @@ ovpn_add_peer() {
 	local server_ns="ovpn_peer0"
 	M_ID=${labels[OVPN_SYMMETRIC_ID]}
 	local dev=${2:-"any"}
+	local laddr=${3:-"any"}
 
 	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
 			ip netns exec "${server_ns}" "${OVPN_CLI}" \
-				new_multi_peer tun0 "${dev}" 1 "${M_ID}" \
-				"${OVPN_UDP_PEERS_FILE}"
+				new_multi_peer tun0 "${dev}" "${laddr}" 1 \
+				"${M_ID}" "${OVPN_UDP_PEERS_FILE}"
 
 			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 				ip netns exec "${server_ns}" ${OVPN_CLI} \
@@ -244,7 +245,7 @@ ovpn_add_peer() {
 				${OVPN_UDP_PEERS_FILE})
 			ip netns exec "${peer_ns}" "${OVPN_CLI}" new_peer \
 				tun"${1}" "${dev}" "${PEER_ID}" "${TX_ID}" \
-				"${LPORT}" "${RADDR}" "${RPORT}"
+				"${laddr}" "${LPORT}" "${RADDR}" "${RPORT}"
 			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${1} \
 				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
 		fi
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 312822c27909..0ae371bbaeb9 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -105,7 +105,7 @@ struct ovpn_ctx {
 	sa_family_t sa_family;
 
 	unsigned long peer_id, tx_id;
-	unsigned long lport;
+	const char *laddr, *lport;
 
 	union {
 		struct sockaddr_in in4;
@@ -471,59 +471,29 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
-static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
+static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int type)
 {
-	struct sockaddr_storage local_sock = { 0 };
-	struct sockaddr_in6 *in6;
-	struct sockaddr_in *in;
-	int ret, s, sock_type;
-	size_t sock_len;
-
-	if (proto == IPPROTO_UDP)
-		sock_type = SOCK_DGRAM;
-	else if (proto == IPPROTO_TCP)
-		sock_type = SOCK_STREAM;
-	else
-		return -EINVAL;
+	int ret, s;
 
-	s = socket(family, sock_type, 0);
+	s = socket(family, type, 0);
 	if (s < 0) {
 		perror("cannot create socket");
 		return -1;
 	}
 
-	switch (family) {
-	case AF_INET:
-		in = (struct sockaddr_in *)&local_sock;
-		in->sin_family = family;
-		in->sin_port = htons(ctx->lport);
-		in->sin_addr.s_addr = htonl(INADDR_ANY);
-		sock_len = sizeof(*in);
-		break;
-	case AF_INET6:
-		in6 = (struct sockaddr_in6 *)&local_sock;
-		in6->sin6_family = family;
-		in6->sin6_port = htons(ctx->lport);
-		in6->sin6_addr = in6addr_any;
-		sock_len = sizeof(*in6);
-		break;
-	default:
-		return -1;
-	}
-
 	int opt = 1;
 
 	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
 
 	if (ret < 0) {
 		perror("setsockopt for SO_REUSEADDR");
-		return ret;
+		goto close;
 	}
 
 	ret = setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
 	if (ret < 0) {
 		perror("setsockopt for SO_REUSEPORT");
-		return ret;
+		goto close;
 	}
 
 	if (ctx->mark != 0) {
@@ -531,16 +501,17 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 				 sizeof(ctx->mark));
 		if (ret < 0) {
 			perror("setsockopt for SO_MARK");
-			return ret;
+			goto close;
 		}
 	}
 
 	if (family == AF_INET6) {
 		opt = 0;
-		if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
-			       sizeof(opt))) {
+		ret = setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
+				 sizeof(opt));
+		if (ret < 0) {
 			perror("failed to set IPV6_V6ONLY");
-			return -1;
+			goto close;
 		}
 	}
 
@@ -548,45 +519,87 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx->bind_dev,
 			       strlen(ctx->bind_dev) + 1) != 0) {
 			perror("setsockopt for SO_BINDTODEVICE");
-			return -1;
+			goto close;
 		}
 	}
 
-	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
-	if (ret < 0) {
-		perror("cannot bind socket");
-		goto err_socket;
+	return s;
+close:
+	close(s);
+	return ret;
+}
+
+static int ovpn_setup_socket(struct ovpn_ctx *ctx, sa_family_t family,
+			     int socktype)
+{
+	struct addrinfo *list_ai, *curr_ai;
+	struct addrinfo hints;
+	int ret, socket;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_NUMERICHOST | AI_NUMERICSERV |
+			 (socktype == SOCK_STREAM ? 0 : AI_V4MAPPED) |
+			 (ctx->laddr ? 0 : AI_PASSIVE);
+	hints.ai_family = family;
+	hints.ai_socktype = socktype;
+	ret = getaddrinfo(ctx->laddr, ctx->lport, &hints, &list_ai);
+	if (ret) {
+		fprintf(stderr,
+			"laddr %s, lport %s, getaddrinfo on local address: %s\n",
+			ctx->laddr, ctx->lport, gai_strerror(ret));
+		return ret;
 	}
 
-	ctx->socket = s;
-	ctx->sa_family = family;
-	return 0;
+	for (curr_ai = list_ai; curr_ai; curr_ai = curr_ai->ai_next) {
+		socket = ovpn_socket(ctx, family, socktype);
+		if (socket < 0)
+			continue;
 
-err_socket:
-	close(s);
-	return -1;
+		ret = bind(socket, curr_ai->ai_addr, curr_ai->ai_addrlen);
+		if (ret == 0)
+			break;
+
+		close(socket);
+	}
+
+	freeaddrinfo(list_ai);
+
+	if (ret < 0) {
+		perror("cannot setup socket\n");
+		return ret;
+	}
+
+	return socket;
 }
 
 static int ovpn_udp_socket(struct ovpn_ctx *ctx, sa_family_t family)
 {
-	return ovpn_socket(ctx, family, IPPROTO_UDP);
+	int socket = ovpn_setup_socket(ctx, family, SOCK_DGRAM);
+
+	if (socket < 0)
+		return socket;
+
+	ctx->sa_family = family;
+	ctx->socket = socket;
+	return 0;
 }
 
 static int ovpn_listen(struct ovpn_ctx *ctx, sa_family_t family)
 {
-	int ret;
+	int ret, socket = ovpn_setup_socket(ctx, family, SOCK_STREAM);
 
-	ret = ovpn_socket(ctx, family, IPPROTO_TCP);
-	if (ret < 0)
-		return ret;
+	if (socket < 0)
+		return socket;
 
-	ret = listen(ctx->socket, 10);
+	ret = listen(socket, 10);
 	if (ret < 0) {
 		perror("listen");
-		close(ctx->socket);
+		close(socket);
 		return -1;
 	}
 
+	ctx->sa_family = family;
+	ctx->socket = socket;
 	return 0;
 }
 
@@ -621,18 +634,13 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
 	return ret;
 }
 
-static int ovpn_connect(struct ovpn_ctx *ovpn)
+static int ovpn_connect(struct ovpn_ctx *ctx)
 {
+	const sa_family_t family = ctx->remote.in4.sin_family;
 	socklen_t socklen;
-	int s, ret;
+	int ret, socket;
 
-	s = socket(ovpn->remote.in4.sin_family, SOCK_STREAM, 0);
-	if (s < 0) {
-		perror("cannot create socket");
-		return -1;
-	}
-
-	switch (ovpn->remote.in4.sin_family) {
+	switch (family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
 		break;
@@ -643,20 +651,22 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -EOPNOTSUPP;
 	}
 
-	ret = connect(s, (struct sockaddr *)&ovpn->remote, socklen);
+	socket = ovpn_setup_socket(ctx, family, SOCK_STREAM);
+	if (socket < 0)
+		return socket;
+
+	ret = connect(socket, (struct sockaddr *)&ctx->remote, socklen);
 	if (ret < 0) {
 		perror("connect");
-		goto err;
+		close(socket);
+		return ret;
 	}
 
 	fprintf(stderr, "connected\n");
 
-	ovpn->socket = s;
-
+	ctx->sa_family = family;
+	ctx->socket = socket;
 	return 0;
-err:
-	close(s);
-	return ret;
 }
 
 static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
@@ -1712,7 +1722,7 @@ static void usage(const char *cmd)
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <dev> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <dev> <peer_id> <tx_id> <laddr> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tdev: transport interface name to bind to, supports 'any'\n");
@@ -1720,16 +1730,20 @@ static void usage(const char *cmd)
 		"\tpeer_id: peer ID found in data packets received from this peer\n");
 	fprintf(stderr,
 		"\ttx_id: peer ID to be used when sending to this peer, 'none' for symmetric peer ID\n");
+	fprintf(stderr,
+		"\tladdr: local UDP address to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr, "\traddr: peer IP address\n");
 	fprintf(stderr, "\trport: peer UDP port\n");
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <dev> <lport> <id_type> <peers_file> [mark]: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <dev> <laddr> <lport> <id_type> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tdev: transport interface name to bind to, supports 'any'\n");
+	fprintf(stderr,
+		"\tladdr: local UDP address to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr, "\tid_type:\n");
 	fprintf(stderr,
@@ -2224,11 +2238,8 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		if (argc < 6)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[3], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = NULL;
+		ovpn->lport = argv[3];
 
 		if (strcmp(argv[4], "SYMM") == 0) {
 			ovpn->asymm_id = false;
@@ -2252,6 +2263,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		ovpn->sa_family = AF_INET;
 		ovpn->asymm_id = strcmp(argv[4], "none");
 
+		ovpn->laddr = NULL;
+		ovpn->lport = "1";
+
 		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5],
 					  argv[6], NULL);
 		if (ret < 0) {
@@ -2271,52 +2285,46 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_NEW_PEER:
-		if (argc < 9)
+		if (argc < 10)
 			return -EINVAL;
 
 		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
 
 		ovpn->asymm_id = strcmp(argv[5], "none");
 
-		ovpn->lport = strtoul(argv[6], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = strcmp(argv[6], "any") == 0 ? NULL : argv[6];
+		ovpn->lport = argv[7];
 
-		const char *vpnip = (argc > 9) ? argv[9] : NULL;
+		const char *vpnip = (argc > 10) ? argv[10] : NULL;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[7],
-					  argv[8], vpnip);
+		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[8],
+					  argv[9], vpnip);
 		if (ret < 0)
 			return -1;
 		break;
 	case CMD_NEW_MULTI_PEER:
-		if (argc < 7)
+		if (argc < 8)
 			return -EINVAL;
 
 		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
 
-		ovpn->lport = strtoul(argv[4], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = strcmp(argv[4], "any") == 0 ? NULL : argv[4];
+		ovpn->lport = argv[5];
 
-		if (!strcmp(argv[5], "SYMM")) {
+		if (!strcmp(argv[6], "SYMM")) {
 			ovpn->asymm_id = false;
-		} else if (!strcmp(argv[5], "ASYMM")) {
+		} else if (!strcmp(argv[6], "ASYMM")) {
 			ovpn->asymm_id = true;
 		} else {
-			fprintf(stderr, "Cannot parse id type: %s\n", argv[5]);
+			fprintf(stderr, "Cannot parse id type: %s\n", argv[6]);
 			return -1;
 		}
 
-		ovpn->peers_file = argv[6];
+		ovpn->peers_file = argv[7];
 
 		ovpn->mark = 0;
-		if (argc > 7) {
-			ovpn->mark = strtoul(argv[7], NULL, 10);
+		if (argc > 8) {
+			ovpn->mark = strtoul(argv[8], NULL, 10);
 			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
 				fprintf(stderr, "mark value out of range\n");
 				return -1;
diff --git a/tools/testing/selftests/net/ovpn/test-bind-addr.sh b/tools/testing/selftests/net/ovpn/test-bind-addr.sh
new file mode 100755
index 000000000000..e33a433ceb4b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-bind-addr.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+BIND_TYPE="ADDR"
+
+source test-bind.sh
diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh b/tools/testing/selftests/net/ovpn/test-bind.sh
index bc0b8a0b4373..8d83bfef0917 100755
--- a/tools/testing/selftests/net/ovpn/test-bind.sh
+++ b/tools/testing/selftests/net/ovpn/test-bind.sh
@@ -10,6 +10,7 @@
 set -eE
 
 OVPN_PROTO=UDP
+BIND_TYPE=${BIND_TYPE:-"DEV"}
 
 source ./common.sh
 
@@ -62,8 +63,9 @@ ovpn_bind_prepare_network() {
 	ovpn_cmd_ok "bring up peer2 second underlay link" \
 		ip -n ovpn_peer2 link set veth2 up
 
-	# Some test cases intentionally bind peer1 to a device that does not
-	# match the route-selected underlay, so allow asymmetric underlay paths.
+	# Some test cases intentionally bind peer1 to a device or address that
+	# does not match the route-selected underlay, so allow asymmetric
+	# underlay paths.
 	ovpn_cmd_ok "disable peer1 global rp_filter" \
 		ip netns exec ovpn_peer1 sysctl -w \
 			net.ipv4.conf.all.rp_filter=0
@@ -110,8 +112,10 @@ ovpn_bind_prepare_network() {
 ovpn_bind_configure_peers() {
 	local dev1="$1"
 	local dev2="$2"
-	local raddr4_peer1="$3"
-	local raddr4_peer2="$4"
+	local laddr4_peer1="$3"
+	local laddr4_peer2="$4"
+	local raddr4_peer1="$5"
+	local raddr4_peer2="$6"
 
 	ip netns exec ovpn_peer1 "${OVPN_CLI}" del_peer tun1 1 \
 		>/dev/null 2>&1 || true
@@ -121,15 +125,16 @@ ovpn_bind_configure_peers() {
 	# Close any active userspace socket before installing a new peer pair.
 	killall "$(basename "${OVPN_CLI}")" 2>/dev/null || true
 
-	ovpn_cmd_ok "create peer1 bound peer on ${dev1}" \
+	ovpn_cmd_ok "create peer1 bound peer" \
 		ip netns exec ovpn_peer1 "${OVPN_CLI}" new_peer tun1 \
-			"${dev1}" 1 10 1 "${raddr4_peer1}" 1
+			"${dev1}" 1 10 "${laddr4_peer1}" 1 "${raddr4_peer1}" 1
 	ovpn_cmd_ok "install peer1 key" \
 		ip netns exec ovpn_peer1 "${OVPN_CLI}" new_key tun1 1 1 0 \
 			"${OVPN_ALG}" 0 data64.key
-	ovpn_cmd_ok "create peer2 bound peer on ${dev2}" \
+	ovpn_cmd_ok "create peer2 bound peer" \
 		ip netns exec ovpn_peer2 "${OVPN_CLI}" new_peer tun2 \
-			"${dev2}" 10 1 1 "${raddr4_peer2}" 1
+			"${dev2}" 10 1 "${laddr4_peer2}" 1 \
+			"${raddr4_peer2}" 1
 	ovpn_cmd_ok "install peer2 key" \
 		ip netns exec ovpn_peer2 "${OVPN_CLI}" new_key tun2 10 1 0 \
 			"${OVPN_ALG}" 1 data64.key
@@ -153,7 +158,7 @@ ovpn_bind_start_capture() {
 	OVPN_BIND_TCPDUMP_PIDS+=("${pid}")
 }
 
-ovpn_bind_run_positive_case() {
+ovpn_bind_run_dev_positive_case() {
 	local dev1="$1"
 	local dev2="$2"
 	local raddr4_peer1="$3"
@@ -165,8 +170,8 @@ ovpn_bind_run_positive_case() {
 	local header2="0x4800000a"
 	local ping_start_delay="0.3"
 
-	ovpn_bind_configure_peers "${dev1}" "${dev2}" "${raddr4_peer1}" \
-		"${raddr4_peer2}"
+	ovpn_bind_configure_peers "${dev1}" "${dev2}" any any \
+		"${raddr4_peer1}" "${raddr4_peer2}"
 	filter="$(printf '(%s) or (%s)' \
 		"$(ovpn_build_capture_filter "${header1}" "${raddr4_peer1}")" \
 		"$(ovpn_build_capture_filter "${header2}" "${raddr4_peer2}")")"
@@ -192,7 +197,7 @@ ovpn_bind_run_positive_case() {
 	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
 }
 
-ovpn_bind_run_sender_negative_case() {
+ovpn_bind_run_dev_sender_negative_case() {
 	local dev1="$1"
 	local raddr4_peer1="$2"
 	local raddr4_peer2="$3"
@@ -201,7 +206,7 @@ ovpn_bind_run_sender_negative_case() {
 	local header="0x4800000a"
 	local ping_start_delay="0.3"
 
-	ovpn_bind_configure_peers "${dev1}" any "${raddr4_peer1}" \
+	ovpn_bind_configure_peers "${dev1}" any any any "${raddr4_peer1}" \
 		"${raddr4_peer2}"
 	filter="$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")"
 
@@ -217,7 +222,7 @@ ovpn_bind_run_sender_negative_case() {
 	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
 }
 
-ovpn_bind_run_receiver_negative_case() {
+ovpn_bind_run_dev_receiver_negative_case() {
 	local dev2="$1"
 	local raddr4_peer1="$2"
 	local raddr4_peer2="$3"
@@ -226,7 +231,7 @@ ovpn_bind_run_receiver_negative_case() {
 	local header="0x4800000a"
 	local ping_start_delay="0.3"
 
-	ovpn_bind_configure_peers any "${dev2}" "${raddr4_peer1}" \
+	ovpn_bind_configure_peers any "${dev2}" any any "${raddr4_peer1}" \
 		"${raddr4_peer2}"
 	filter="$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")"
 
@@ -242,40 +247,138 @@ ovpn_bind_run_receiver_negative_case() {
 	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
 }
 
+ovpn_bind_run_addr_positive_case() {
+	local laddr4_peer1="$1"
+	local raddr4_peer1="$2"
+	local raddr4_peer2="$3"
+	local expected_dev="$4"
+	local unexpected_dev="$5"
+	local filter
+	local header="0x4800000a"
+	local ping_start_delay="0.3"
+
+	ovpn_bind_configure_peers any any "${laddr4_peer1}" any \
+		"${raddr4_peer1}" "${raddr4_peer2}"
+	filter="$(printf '(%s) and src host %s' \
+		"$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")" \
+		"${laddr4_peer1}")"
+
+	# The route-selected device must carry peer1 data packets with the
+	# explicitly bound local address as outer source address.
+	ovpn_bind_start_capture "${expected_dev}" 1 "${filter}"
+
+	# The other underlay device must not carry peer1 data packets with the
+	# explicitly bound local address.
+	ovpn_bind_start_capture "${unexpected_dev}" 1 "${filter}"
+
+	sleep "${ping_start_delay}"
+	ovpn_cmd_ok "send tunnel traffic from peer1 to peer2" \
+		ip netns exec ovpn_peer1 ping -qfc 10 -w 3 5.5.5.2
+	ovpn_cmd_ok "capture bound source on ${expected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+
+	ovpn_cmd_fail "capture bound source on ${unexpected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+}
+
+ovpn_bind_run_addr_receiver_positive_case() {
+	local laddr4_peer2="$1"
+	local raddr4_peer1="$2"
+	local raddr4_peer2="$3"
+	local expected_dev="$4"
+	local unexpected_dev="$5"
+	local filter
+	local header="0x4800000a"
+	local ping_start_delay="0.3"
+
+	ovpn_bind_configure_peers any any any "${laddr4_peer2}" \
+		"${raddr4_peer1}" "${raddr4_peer2}"
+	filter="$(printf '(%s) and dst host %s' \
+		"$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")" \
+		"${raddr4_peer1}")"
+
+	# The destination-matching underlay device must carry peer1 data
+	# packets to the address peer2 is bound to.
+	ovpn_bind_start_capture "${expected_dev}" 1 "${filter}"
+
+	# The other underlay device must not carry those packets.
+	ovpn_bind_start_capture "${unexpected_dev}" 1 "${filter}"
+
+	sleep "${ping_start_delay}"
+	ovpn_cmd_ok "send tunnel traffic from peer1 to peer2" \
+		ip netns exec ovpn_peer1 ping -qfc 10 -w 3 5.5.5.2
+	ovpn_cmd_ok "capture bound destination on ${expected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+
+	ovpn_cmd_fail "capture bound destination on ${unexpected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+}
+
+ovpn_bind_run_dev_tests() {
+	ktap_set_plan 9
+
+	ovpn_run_stage "setup network topology" ovpn_bind_prepare_network
+	ovpn_run_stage "peer1 bind_dev=veth1 routes over veth1" \
+		ovpn_bind_run_dev_positive_case \
+		veth1 any 10.10.10.2 10.10.10.1 veth1 veth2
+	ovpn_run_stage "peer1 bind_dev=veth2 routes over veth2" \
+		ovpn_bind_run_dev_positive_case \
+		veth2 any 20.20.20.2 20.20.20.1 veth2 veth1
+	ovpn_run_stage "peer2 bind_dev=veth1 replies over veth1" \
+		ovpn_bind_run_dev_positive_case \
+		any veth1 10.10.10.2 10.10.10.1 veth1 veth2
+	ovpn_run_stage "peer2 bind_dev=veth2 replies over veth2" \
+		ovpn_bind_run_dev_positive_case \
+		any veth2 20.20.20.2 20.20.20.1 veth2 veth1
+	ovpn_run_stage "peer1 bind_dev=veth1 blocks veth2 egress" \
+		ovpn_bind_run_dev_sender_negative_case \
+		veth1 20.20.20.2 20.20.20.1 veth2
+	ovpn_run_stage "peer1 bind_dev=veth2 blocks veth1 egress" \
+		ovpn_bind_run_dev_sender_negative_case \
+		veth2 10.10.10.2 10.10.10.1 veth1
+	ovpn_run_stage "peer2 bind_dev=veth1 rejects veth2 ingress" \
+		ovpn_bind_run_dev_receiver_negative_case \
+		veth1 20.20.20.2 20.20.20.1 veth2
+	ovpn_run_stage "peer2 bind_dev=veth2 rejects veth1 ingress" \
+		ovpn_bind_run_dev_receiver_negative_case \
+		veth2 10.10.10.2 10.10.10.1 veth1
+}
+
+ovpn_bind_run_addr_tests() {
+	ktap_set_plan 5
+
+	ovpn_run_stage "setup network topology" ovpn_bind_prepare_network
+	ovpn_run_stage "peer1 bind_addr=10.10.10.1 sends from 10.10.10.1 \
+		via veth2" ovpn_bind_run_addr_positive_case \
+		10.10.10.1 20.20.20.2 10.10.10.1 veth2 veth1
+	ovpn_run_stage "peer1 bind_addr=20.20.20.1 sends from 20.20.20.1 \
+		via veth1" ovpn_bind_run_addr_positive_case \
+		20.20.20.1 10.10.10.2 20.20.20.1 veth1 veth2
+	ovpn_run_stage "peer2 bind_addr=10.10.10.2 accepts dst 10.10.10.2 \
+		via veth1" ovpn_bind_run_addr_receiver_positive_case \
+		10.10.10.2 10.10.10.2 10.10.10.1 veth1 veth2
+	ovpn_run_stage "peer2 bind_addr=20.20.20.2 accepts dst 20.20.20.2 \
+		via veth2" ovpn_bind_run_addr_receiver_positive_case \
+		20.20.20.2 20.20.20.2 20.20.20.1 veth2 veth1
+}
+
 trap ovpn_test_exit EXIT
 trap ovpn_stage_err ERR
 
 ktap_print_header
-ktap_set_plan 9
 
 ovpn_cleanup
 modprobe -q ovpn || true
 
-ovpn_run_stage "setup network topology" ovpn_bind_prepare_network
-ovpn_run_stage "peer1 bind_dev=veth1 routes over veth1" \
-	ovpn_bind_run_positive_case \
-	veth1 any 10.10.10.2 10.10.10.1 veth1 veth2
-ovpn_run_stage "peer1 bind_dev=veth2 routes over veth2" \
-	ovpn_bind_run_positive_case \
-	veth2 any 20.20.20.2 20.20.20.1 veth2 veth1
-ovpn_run_stage "peer2 bind_dev=veth1 replies over veth1" \
-	ovpn_bind_run_positive_case \
-	any veth1 10.10.10.2 10.10.10.1 veth1 veth2
-ovpn_run_stage "peer2 bind_dev=veth2 replies over veth2" \
-	ovpn_bind_run_positive_case \
-	any veth2 20.20.20.2 20.20.20.1 veth2 veth1
-ovpn_run_stage "peer1 bind_dev=veth1 blocks veth2 egress" \
-	ovpn_bind_run_sender_negative_case \
-	veth1 20.20.20.2 20.20.20.1 veth2
-ovpn_run_stage "peer1 bind_dev=veth2 blocks veth1 egress" \
-	ovpn_bind_run_sender_negative_case \
-	veth2 10.10.10.2 10.10.10.1 veth1
-ovpn_run_stage "peer2 bind_dev=veth1 rejects veth2 ingress" \
-	ovpn_bind_run_receiver_negative_case \
-	veth1 20.20.20.2 20.20.20.1 veth2
-ovpn_run_stage "peer2 bind_dev=veth2 rejects veth1 ingress" \
-	ovpn_bind_run_receiver_negative_case \
-	veth2 10.10.10.2 10.10.10.1 veth1
+if [ "${BIND_TYPE}" = "ADDR" ]; then
+	ovpn_bind_run_addr_tests
+else
+	ovpn_bind_run_dev_tests
+fi
 
 ovpn_test_finished=1
 ktap_finished
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 010f5b44dbf4..581d208c18ac 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -39,7 +39,7 @@ ovpn_mark_prepare_network() {
 
 	ovpn_cmd_ok "create server-side multi-peer with fwmark" \
 		ip netns exec ovpn_peer0 "${OVPN_CLI}" new_multi_peer tun0 \
-			any 1 ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
+			any any 1 ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "install server key for peer ${p}" \
 			ip netns exec ovpn_peer0 "${OVPN_CLI}" new_key tun0 \
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
