Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414A7CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bcQ1+iD05937PR7AST9NioJnlkGhHMAH6+ZTWX7oKmw=; b=datyohZulA0RA2LtvPy0j+bZjS
	ammxwZpK5RD6kwfHBkZqJEzuOZgUFWQ7DCOeErqZlp5GXkBndM49pl7zrpYvy13hHvbyC9DO+FKLU
	kdKa1xYKPB1E7n0HtdyEXqZDWQC2vlSkl06yPnurmKFNz/X6/WOFZFj7/rhiwzLX4ZlY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPduY-0006gL-37;
	Wed, 20 May 2026 10:12:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wPduC-0006ev-Ue
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JdjH1+cOtW5upDCTo+C83qYiT3kfPQsYywBtkyM0nNU=; b=nDgVro3w22Wz8TF6LGqHx9jxre
 IUsC6LNqznMrtM369RTGa+FevXZ14sgU7kJ2DkkRKBDXtY/3n0dZpi0CyuZUwbmswfCLAC9hpkVLr
 jnrAV7aAEQ97Wt49gzRv9kOoHp5Sry/kNWkG9YWj3R09KEJPJLb2gKyU8rerSiR6nuH0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JdjH1+cOtW5upDCTo+C83qYiT3kfPQsYywBtkyM0nNU=; b=JbmQ2u80ZSbK60ZLC+it2sniQS
 5fmauVEz2iDFqhpyPkZd4jOKpBcW0PgT9nMPKkLyfb94ZQ7/nlfy+WNTuhs1qbyewq9Slgeb438yj
 /DgMB5YnenPlymTnCQFb/zeEY/BV9m3WxUIUumJRbifQKV6C2m6iiJUVwdSOYNkw6K6k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPduC-0006kT-19 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:12:01 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64KABrSJ017475
 for <openvpn-devel@lists.sourceforge.net>; Wed, 20 May 2026 12:11:53 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 64KABrZK017474
 for openvpn-devel@lists.sourceforge.net; Wed, 20 May 2026 12:11:53 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 20 May 2026 12:11:44 +0200
Message-ID: <20260520101152.17453-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wPduC-0006kT-19
Subject: [Openvpn-devel] [PATCH v1] Fix: port-share and multi-socket
 interaction
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

When port-share is used, enforce the presence
of a TCP listener by checking the local_list
entries insted of rely on the global
connection_entry proto field.

Github: #1027

Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1680
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1680
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0c2866c..0ecb59c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2490,8 +2490,13 @@
             msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);
         }
 #if PORT_SHARE
+        bool has_tcp = false;
+        for (int i = 0; i < ce->local_list->len && !has_tcp; i++)
+        {
+            has_tcp = (ce->local_list->array[i]->proto == PROTO_TCP_SERVER);
+        }
         if ((options->port_share_host || options->port_share_port)
-            && (ce->proto != PROTO_TCP_SERVER))
+            && !has_tcp)
         {
             msg(M_USAGE, "--port-share only works in TCP server mode "
                          "(--proto values of tcp-server, tcp4-server, or tcp6-server)");


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
