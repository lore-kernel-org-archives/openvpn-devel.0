Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC7DCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0XpeFv0IhBgtBX88fSc1jfF5XEcmtEDvkqk2OyQD6jk=; b=e2Cx5it82myTC22+E59F53XcLJ
	mJei8dK5dmmQzch3OP22XIJbP/m+Ysf3B6C2joelv+MV9gi/RuoyZwrXXn/SJhKFxMm6XcdxdGQD3
	zi27vHOFBPeIK/+ecLvBBGSpt3v/ewhUjUsUxwen7OzcihFuKu5Z8Wui2QVseFfXvSSY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3xm-0003EE-Eb;
	Sat, 03 Oct 2026 17:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xD3xl-0003Ce-00
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0N4zee8z5eb86ueHHX7sKBdblERmgnp308xm/bs4dWo=; b=SPoFdM+T6Dgh2IWM2Uo/uJ1dZz
 eQNa+706ZmM5SW4rE7/Tdtnh+m8kMi9Ss6/S/qB131tvPFaY20r6WqR36GHjC9JplSyTkz8zftQVl
 ZbTuXyfKcxABc5REUFrE4QTIkWGUhEwTR2zMHpx6nLrQZ9FhZmvQzsdvRpGNO8I77MNY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0N4zee8z5eb86ueHHX7sKBdblERmgnp308xm/bs4dWo=; b=AjeMNsDtOxwM3txOQgqZl9fv+U
 e1arPBhQ+qAQcDdkX3EIXwzE6ylN2T6QHP+oSq7WIccXGG5xgzxi/tsGSZj+FigAop2VpKycsKqFB
 NrOE8BHohaUkNCk6yJ80fogbQUmyj2EDfdiJwajiyRjwZBFDJBjphmOo7sl8vAlyNMV8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD3xR-0003Uq-3O for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:55:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693HtUL5006376
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 19:55:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693HtU9h006375
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 19:55:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 19:55:24 +0200
Message-ID: <20261003175529.6360-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
References: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xD3xR-0003Uq-3O
Subject: [Openvpn-devel] [PATCH v3] Fix various issues found by cppcheck
 2.21.0
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

From: Frank Lichtenheld <frank@lichtenheld.com>

- Fix several constVariablePointer issues that
  were newly reported
- Fix one unreadVariable issue that was newly
  reported
- Remove --showtime=summary from cppcheck args
  again, it is now much more verbose

Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1954
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1954
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index ad012ac..3c71c83 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -33,7 +33,7 @@
  --suppress-xml=${SCRIPT_DIR}/cppcheck-suppressions.xml --inline-suppr \
  --cppcheck-build-dir=${CPPCHECK_DIR} \
  --check-level=${CPPCHECK_CHECK_LEVEL} --max-configs=10 \
- --error-exitcode=1 --showtime=summary"
+ --error-exitcode=1"
 
 set -x
 
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6d88f6f..9fc0e3b 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -534,7 +534,7 @@
     ASSERT(sock->info.connection_established);
 
     struct sockaddr *remoteaddr = &sock->info.lsa->actual.dest.addr.sa;
-    struct tls_multi *multi = c->c2.tls_multi;
+    const struct tls_multi *multi = c->c2.tls_multi;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode the kernel automatically removes an existing peer
      * when adding a new peer. FreeBSD needs to explicitly be told to do that */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4794b7e..2b08ada 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -316,10 +316,9 @@
 multi_get_instance_udp_real(struct multi_context *m, struct mroute_addr *real)
 {
     struct hash *hash = m->hash;
-    struct hash_element *he;
     const uint64_t hv = hash_value(hash, real);
     struct hash_bucket *bucket = hash_bucket(hash, hv);
-    he = hash_lookup_fast(hash, bucket, real, hv);
+    const struct hash_element *he = hash_lookup_fast(hash, bucket, real, hv);
     if (he)
     {
         return he->value;
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 69c5a50..24dce84 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -184,7 +184,6 @@
         {
             tbs = buf;
             tbslen = (size_t)buflen;
-            sigalg.op = "Sign";
         }
         else
         {
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 19f3d54..65ecb3c 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -323,8 +323,7 @@
         return port;
     }
 
-    struct servent *service;
-    service = getservbyname(servname, NULL);
+    const struct servent *service = getservbyname(servname, NULL);
     if (service)
     {
         return service->s_port;
diff --git a/tests/unit_tests/openvpn/siphash_openssl.c b/tests/unit_tests/openvpn/siphash_openssl.c
index c301f2d..99a7763 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.c
+++ b/tests/unit_tests/openvpn/siphash_openssl.c
@@ -101,7 +101,7 @@
 bool
 siphash_openssl_available(void *sip_context)
 {
-    struct siphash_context *sip = sip_context;
+    const struct siphash_context *sip = sip_context;
 
     return (bool)(sip->mac);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
