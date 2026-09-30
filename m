Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB7DCA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3VRX4OEihG3lG/Gr76ZnvYyemIymwXPAWRIlYeZohE=; b=eOJdPBi9wtoSYlaNX02dc1r29v
	QvR884y9IUTWDEMou0Llj7mFQKRKl7V01zMG70crecXi+6U+m+pMe1e2eu3Z5iPTJXM1GqmQMai7Y
	v0NOt2uES+fzONw/umb3UR1iZSHIKX1Ptwribs12G2dpGQmPJDvo53dgzoCV8DYEQEHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuQE-0006Zs-Eq;
	Wed, 30 Sep 2026 13:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBuQD-0006Zg-90
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Sd0FXto2g683+AMPnossSXcHR+FbwoL2sqVKyn8brU=; b=c5SOs1o9NOe012OLR94tA00IAu
 4HZQ3MJNXmdUL3wPfZVzRrJ48uxaT/djoBIbn7W+rbBQyxP1wpj3Xlxznw/U81rmShcr6NiYZKsPE
 ybhT/uQTff66dKu3sNMkV9Y4NB1p8S3rlFccPpsPCB9M2wSdRUrj/5bQlANpI7+6SoD8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4Sd0FXto2g683+AMPnossSXcHR+FbwoL2sqVKyn8brU=; b=P1t6+/5ycgmWBhX6kJPJlvz4Wj
 6HIUfdsBeimy7PnBUIYQqUk5lIT3m4gA47kDS/71FwaUrjwhmUi+doJ75Pj6hcEr+6u0aJ3pnBdit
 h+TaMeHtsC2UltSQWnQJo1a4Bl7pERcYPFuXIdpGFVD0+RDAWy7myNxl7fvaWVQDR1Kw=;
Received: from mail-pz2-f37.google.com ([74.125.228.37])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuQB-0005qL-DF for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:32:34 +0000
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7c4c92477so1213536a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790775146; x=1791379946;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Sd0FXto2g683+AMPnossSXcHR+FbwoL2sqVKyn8brU=;
 b=zxLeL3iuik147VIl+Wi3j79TiXUd2PgSnzx/DD6pQHLjyGdlwjnyRhO6MyqL8WhhBE
 7KaIwuF/9DE37Lrla3OXH+CnH1EivqbVC8x/VcTaHzX+jdAAmv0xdXTW9sDP9mJPbg0r
 UC6umvWSzAaowg5ax4AmOkTYi2+yQ4w7hLsw1MQgIdSP60Xu4fhrXYiFoH9d7YSamnKI
 tUuS54OGV8KjyBMNtpPxbSdC21rYggc8GDWnJ+mihrynt789Wg0sFuwAQtlma63u4pzh
 kgysI8gxaCkMJAxIXi7jLZVenEtC2nfK1ShMyR0oAzvvo4sAEexL9tAWcMS9kTZGcda1
 Gz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775146; x=1791379946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Sd0FXto2g683+AMPnossSXcHR+FbwoL2sqVKyn8brU=;
 b=h+bj5jCBUGkUfgH1xT30QCQcL1LjsqrayJD9sFnkuiz3FOyK7FEZV9mhrgW/9jJCou
 RPbqZcf3vZMPtOzJORs9W6++vF6ILE+wTGfEo87CLAP/XqvhYyFWv7cKwLkqyNt5WNOQ
 jfyUvxdUD9mSpeNjlp97tI4ZXJCTVB7eD6J+KpgPo3zDa1+6OXmdK5ZzH1pCPWmZAdhM
 iPg9+MwC6awo0IYt7y8G0Z7NVelCow3BOH/nPPz+4GqrtNA2HyQq5ZXK2qE/C3ahRi8H
 W1BB+QTRlIOoJ1/2DHqn6B+YsCEeC7HZNXgQ/yPrcAyZPIeK/HPSYoyydPdngQHNcojO
 jStQ==
X-Gm-Message-State: AFuF++lOe0EGqYiIhGq9FHQyGWk1aU1Czul/JeID0/Ytm1puEbphHV0J
 5v0hiZkywSms+VyRqPXvXfNByBaoQTrOk5vGzCO08HlZTeRJzh1IwFfI69UCGV650kqPhXbeDRU
 mCATG3w==
X-Gm-Gg: AYBFou10aku5m8PDVqxa8ZY11CaeCaN8fm70p/9UeunhC0RdLgJbbxr55Zr3Fn+WuJY
 9SKtB/n6AxknKnuYM5EicnQdpZaLXyxOF5wDzSV0/5v8Ao9ch7UQ1DrrEGAOXNYdP9jPbxG4azK
 n1AYlhzt9wp5G1BBkxV0D47n/Jt+HVdsaL6y7YRD21OhJQiSFlEi5yJzR+aU7MJJhpTQSQ4kCM/
 mE8ntCJKEL7GZH/tuBubn5uj5iEU2n/GtXmrHT6cjzYhQ9q1uoHjPwgnKQI9fT6aGEsOjOF8QJe
 Fd7x5cj11UWzIOtsfETGW121Ch9VHF2HUyCkoebk2TDZZINlTf+Os+cwxNhOnzrG8G7QbCfuhO6
 eYU4FRSn1Ok7m3AC3LqcfTrVYR2suttgTAG6Q0M4wFJq8FjKgGzzfNN4W5p87NDL+odCubtHJY2
 JVQRdyaw/MN9u+s1Jo7guqT3ASuKv//CIEHXYbUnRT3qUYXEa327SMpbzNGNZliMTe/vNzhyoEC
 SP2110KRXWthQJVnKqJ0GdAxKmp+6DPhAFn2Puuuh2zZdvJLGAtrkXrHxCfpRnMg+LtUrLoqA==
X-Received: by 2002:a05:690e:4505:20b0:672:f0b6:263d with SMTP id
 956f58d0204a3-676834669c7mr362845d50.76.1790774832998; 
 Wed, 30 Sep 2026 06:27:12 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67680ac3521sm704189d50.1.2026.09.30.06.27.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 06:27:12 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 30 Sep 2026 09:27:07 -0400
Message-ID: <20260930132707.51452-3-drew@linuxkids.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930132707.51452-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
 <20260930132707.51452-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBuQB-0005qL-DF
Subject: [Openvpn-devel] [PATCH v3 2/2] Make CRL reload EOF detection
 independent of stale error queue entries
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

backend_tls_ctx_reload_crl() treats a NULL from PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PEM_R_NO_START_LINE. ERR_peek_error()
returns the OLDEST queued error, so any entry left behind earlier in the
thread turns a clean EOF into a "CRL: cannot read CRL from file" warning,
prints the unrelated errors as if they came from the CRL file, and still
installs the CRLs already parsed. The previous commit removes the
leftover that triggered this in practice; this one stops the loop from
depending on the queue being clean at all.

If the queue is not empty when the CRL is loaded, say so at D_LOW with
the queued errors, since that is a bug somewhere else worth seeing, then
start the loop from an empty queue so only errors raised by
PEM_read_bio_X509_CRL() are visible. Test the error it raised last
rather than the oldest one, and clear the queue on the EOF path instead
of popping a single entry.

Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
 src/openvpn/ssl_openssl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 7cfe9f4a..b14cbbe9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1360,6 +1360,19 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, b
     }
 
     int num_crls_loaded = 0;
+    /*
+     * The EOF test below must only see errors raised by
+     * PEM_read_bio_X509_CRL(). Anything already queued was left by an
+     * earlier operation in this thread and would otherwise be what
+     * ERR_peek_error() returns, turning a clean EOF into "cannot read CRL".
+     * Report it, since that is a bug elsewhere, then start from an empty
+     * queue (crypto_msg() drains the queue while printing it).
+     */
+    if (ERR_peek_error() != 0)
+    {
+        crypto_msg(D_LOW, "CRL: OpenSSL error queue not empty on CRL load");
+    }
+    ERR_clear_error();
     while (true)
     {
         X509_CRL *crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
@@ -1367,13 +1380,15 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, b
         {
             /*
              * PEM_R_NO_START_LINE can be considered equivalent to EOF.
+             * ERR_peek_last_error() is the error PEM_read_bio_X509_CRL()
+             * raised last; ERR_peek_error() would be the oldest queued one.
              */
-            bool eof = ERR_GET_REASON(ERR_peek_error()) == PEM_R_NO_START_LINE;
+            bool eof = ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE;
             /* but warn if no CRLs have been loaded */
             if (num_crls_loaded > 0 && eof)
             {
                 /* remove that error from error stack */
-                (void)ERR_get_error();
+                ERR_clear_error();
                 break;
             }
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
