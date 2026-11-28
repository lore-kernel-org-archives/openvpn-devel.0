Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4174606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PrK06yXs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a9OG2kB1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P/Mivem3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9DCxGnNl7GmQoHLYoK4/VbZ/uBVRY7DGdag8BQ7AETU=; b=PrK06yXsibsK6G
	6Wk9BHXhD7A7Jcos9MXcCsihhZda+wtY23f7faZB2otxUAARSY2ejE2n9XFEuM2FEKDA50Kx0QAB7
	niRJ+Q3DXA79uplCXFu0k7ie0ftv8uWbwJGT/WgahW0fTUHyninrM8+21N6H+wfZ4SoAQgSiWpA1N
	M+w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXLM5-000000001HY-2cAr;
	Sat, 28 Nov 2026 16:32:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xXLM3-000000001HS-32QJ for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nkoS8yOHzTFwqOrtEmxAcu6N9o5oqkEx3/t07L7W8kc=; b=a9OG2kB1ZHKAD10IRouNkTcaGa
 hoGswSWTcu0YBXkCj7ZHejM74tigubsQ0X7e1RuNdb26d2gYayMW6YNdhrRGkKLSpjUSNKPPqW9/2
 XTNtW4nAQycx103dt3P1Dt3LcI4HHDJmbIdHnEyo/bgyhndSetJ/LtTw/6TVKggrJDv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nkoS8yOHzTFwqOrtEmxAcu6N9o5oqkEx3/t07L7W8kc=; b=P/Mivem3dQMnL9nUYhpX6vSu7F
 U9jidrPBELqmJH7sh6YJgDRfLK4f820Zdv2wWaNyPW9cGlodEb79n24T4Ms2O10udE2MqnmhZ7GQZ
 IMx809htUMIDHeVAZPz3Xat/TfUHPMlXINcEEUH8nxvIVsZnNeeh7/v4hxNaTrcDQXSQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xXLM1-000000005bD-1Sy1 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:32:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ASGWgSt032202
 for <openvpn-devel@lists.sourceforge.net>; Sat, 28 Nov 2026 17:32:42 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ASGWgUf032201
 for openvpn-devel@lists.sourceforge.net; Sat, 28 Nov 2026 17:32:42 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 28 Nov 2026 17:32:33 +0100
Message-ID: <20261128163241.32170-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795883372000.I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed@gerrit.openvpn.net>
References: <gerrit.1795883372000.I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xXLM1-000000005bD-1Sy1
Subject: [Openvpn-devel] [PATCH v1] Remove the obsolete debug/ valgrind
 helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

doval has been broken since commit 34cb9132 ("build: standard directory
layout") moved it into debug/: it looks up valgrind-suppress and the
openvpn binary relative to debug/, where neither exists.
valgrind-suppress was last updated in commit 3710e66e ("updated
valgrind-suppress for OpenSSL 0.9.8") and only matches glibc 2.5
objects. dovalns is a generic valgrind wrapper.

Drop the directory, its EXTRA_DIST entry and the memdbg.h references
to the suppressions file.

Change-Id: I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2365
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2365
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/Makefile.am b/Makefile.am
index d3910ed..a8afa8e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -42,7 +42,6 @@
 
 EXTRA_DIST = \
 	contrib \
-	debug \
 	ltrc.inc \
 	CMakeLists.txt \
 	CMakePresets.json \
diff --git a/debug/doval b/debug/doval
deleted file mode 100755
index e215510..0000000
--- a/debug/doval
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-PROGDIR=`dirname $0`
-unset LD_LIBRARY_PATH
-valgrind --tool=memcheck --error-limit=no --suppressions=$PROGDIR/debug/valgrind-suppress --gen-suppressions=all --leak-check=full --show-reachable=yes --num-callers=32 $PROGDIR/openvpn "$@"
diff --git a/debug/dovalns b/debug/dovalns
deleted file mode 100755
index 482ae3f..0000000
--- a/debug/dovalns
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-valgrind --tool=memcheck --error-limit=no --gen-suppressions=all --leak-check=full --show-reachable=yes --num-callers=32 $*
diff --git a/debug/valgrind-suppress b/debug/valgrind-suppress
deleted file mode 100644
index d7de12f..0000000
--- a/debug/valgrind-suppress
+++ /dev/null
@@ -1,1182 +0,0 @@
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlopen
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlopen
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlsym
-   fun:libdl_resolve_symbol
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlopen
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/libc-2.7.so
-   obj:/lib/ld-2.7.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.7.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/libc-2.7.so
-   obj:/lib/ld-2.7.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.7.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/libc-2.7.so
-   obj:/lib/ld-2.7.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.7.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/ld-2.7.so
-   obj:/lib/libc-2.7.so
-   obj:/lib/ld-2.7.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.7.so
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_verify
-   fun:EVP_VerifyFinal
-   fun:ASN1_item_verify
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:X509_verify_cert
-   fun:ssl_verify_cert_chain
-   fun:ssl3_get_client_certificate
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_mod_exp_mont
-   fun:BN_BLINDING_create_param
-   fun:RSA_setup_blinding
-   obj:/usr/lib/libcrypto.so.0.9.8
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_nnmod
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_nnmod
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_verify
-   fun:EVP_VerifyFinal
-   fun:ASN1_item_verify
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:X509_verify_cert
-   fun:ssl_verify_cert_chain
-   fun:ssl3_get_client_certificate
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto.so.0.9.8
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_mod_exp_mont
-   fun:BN_BLINDING_create_param
-   fun:RSA_setup_blinding
-   obj:/usr/lib/libcrypto.so.0.9.8
-   obj:/usr/lib/libcrypto.so.0.9.8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:*
-   obj:*
-   obj:*
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/ld-2.5.so
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2.5.so
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libc-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlsym
-   fun:libdl_resolve_symbol
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   obj:/lib/ld-2.5.so
-   obj:/lib/libdl-2.5.so
-   fun:dlopen
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:CRYPTO_malloc
-   fun:sk_new
-   obj:/usr/lib/libssl.so.0.9.8
-   fun:SSL_COMP_get_compression_methods
-   fun:SSL_library_init
-   fun:init_ssl_lib
-   fun:init_static
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:getdelim
-   fun:getpass
-   fun:get_console_input
-   fun:get_user_pass
-   fun:context_init_1
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.5.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.5.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.5.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.5.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.7.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.7.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2.7.so
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-}
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 1f94582..62c75ec 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -26,20 +26,15 @@
 /*
  * Valgrind debugging support.
  *
- * Valgrind is a great tool for debugging memory issues,
- * though it seems to generate a lot of warnings in OpenSSL
- * about uninitialized data. To silence these warnings,
- * I've put together a suppressions file
- * in debug/valgrind-suppress.
+ * Valgrind is a great tool for debugging memory issues.
  *
- * Also, grep for VALGRIND_MAKE_READABLE in the OpenVPN source.
+ * Grep for VALGRIND_MAKE_READABLE in the OpenVPN source.
  * Because valgrind thinks that some of the data passed from
  * OpenSSL back to OpenVPN is tainted due to being sourced
  * from uninitialized data, we need to untaint it before use --
  * otherwise we will get a lot of useless warnings.
  *
- *   valgrind --tool=memcheck --error-limit=no --suppressions=debug/valgrind-suppress
- * --gen-suppressions=yes ./openvpn ...
+ *   valgrind --tool=memcheck --error-limit=no --gen-suppressions=yes ./openvpn ...
  */
 
 #ifdef USE_VALGRIND


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
