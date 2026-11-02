Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FA606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FaCz+7xH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EXdAT6v9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=brCBmWQa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=O/8jJINZc+dKPhnVQQwj5iWZHJFsKx82p9QXHYTzx+U=; b=FaCz+7xHKokKPB
	3XeO9L5DJQ9jpzAr1UGArP1mNVlXm57MnCfReE5Qc51XqgOKbpdPhIXc+l/YGO1qCkcrxSpYXoWjo
	xuhROMrXwtDE8rgsp7jm/ZjRrYZRL0PAr7kMwqyp8yzaxwqxN6I7pb7Ds+Kr8PRO+oWlI3pbh8Eb6
	LsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNo07-000000000vd-379u;
	Mon, 02 Nov 2026 09:06:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNo06-000000000vL-22oa for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjiiegHw7Qgdwj8l0L5QR+W0hHyNjrC1F3HiNvDoHSU=; b=EXdAT6v9jmMqUSGSrCrJhvwRkr
 AdAOpxIxbuXMQdFhESA7CnK2pLkPzVzhs4yHB7OxohpH2hOl0WsbZ/Haz0r+huAAP6oRO1mmsB4ry
 09aHr1+hs9dbJT82iGQ54jyz25tbTAN1OlxYAJFWluJIuMS5q0vgmvHKnZJXSseuj/d0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjiiegHw7Qgdwj8l0L5QR+W0hHyNjrC1F3HiNvDoHSU=; b=brCBmWQaw3/qbPLpIM6GGcjF7q
 0/SycVFeGiqnnjXq4EbA+dodJGAW+Yb1SEwcZukknCKK7H8SYtgd7LsY1b839dlu2REPwq2TzKRoV
 //zxB8ViM4oWZW7JVKiRujzRXHfh3/vAeK4cm7HieOjsPw5jMGlv8B7X6rWjmAqKgJBk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNo03-000000000ew-0wEO for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:06:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A296ZKk024930
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 10:06:35 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A296Z8O024920
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 10:06:35 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 10:06:29 +0100
Message-ID: <20261102090635.24906-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNo03-000000000ew-0wEO
Subject: [Openvpn-devel] [PATCH v2] auth_token: Wipe the server secret key
 after loading it
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

From: Hansaem Wi <hansaemw@gmail.com>

auth_token_init_secret() reads the auth-token server key into a 2048
byte buffer, copies it into a struct key on the stack, converts that
into a struct key_parameters on the stack and frees the buffer with
free_buf(), so all three copies of the key stay in memory.
tls_crypt_v2_init_server_key() already wipes its struct key after
init_key_ctx(); do the same here for the struct key and the struct
key_parameters, and clear the buffer before freeing it.

Found by scanning freed heap blocks for the key from test_auth_token.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2076
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2076
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 969f37f..84558af 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -172,6 +172,9 @@
     key_parameters_from_key(&key_params, &key);
     init_key_ctx(key_ctx, &key_params, &kt, false, "auth-token secret");
 
+    secure_memzero(&key, sizeof(key));
+    secure_memzero(&key_params, sizeof(key_params));
+    buf_clear(&server_secret_key);
     free_buf(&server_secret_key);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
