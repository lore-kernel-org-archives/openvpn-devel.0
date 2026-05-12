Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECC3CD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N5/vAvEQYcrsV93/xkkumbPA+OYhJGcGAjYGtvyffYg=; b=kZak1ZTqLgVfFPsHVvIxaVCbcQ
	WQEOO4bE7pDA7NpXUekvLoiI0LVyeo6ctcEsXoQ5/xZoZ9HgNN3ivwlePmOHv6h4ZCd3rO3UT2jjD
	ehST275VN1RF8Dc2qCyxWTSh0gYO5TQ/d5w0SdeO+ZRK5xcA/ITyax3OZPq4cYqiFtpE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMoM1-0004DD-KK;
	Tue, 12 May 2026 14:45:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wMoLz-0004CK-4C
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9oqCH6Fh9tuLFZak4ekzZkC0zAVwT8b6FQSixi4fziU=; b=HuDuIjOTsC/RTRJdbAz3YxuyIJ
 4ljiwbf+CBxa2lZdJYXJYwcXaFRwPyJW2Td6n8Igw0umIj+Jk42CGvLjS59Za9LBsOwykyuo9K/yn
 q0xEgedyk8zBNeaYgmTkD7OpTDW3cNewLDmdvTlxxztCn1/RbVoF1qMA4D0gCr/YxFro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9oqCH6Fh9tuLFZak4ekzZkC0zAVwT8b6FQSixi4fziU=; b=T
 C3lB+RHhEtfE7dN49uNrT3KmjijD9yUb851vDfR/nhDZY/PyHF37EbAcHDr//haYrbUty8QrN3eGC
 /oFIRm54BLxvL4NH89BfV8wochhCklnJQKogmcFfSwJtxdX8H8b04rurR4DVr0hlVSTttXBddO4nV
 Frs34nDTjf8+mmoY=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMoLx-0007ID-L4 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:44:59 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gFKBB26Ppz9v0b;
 Tue, 12 May 2026 16:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778597090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9oqCH6Fh9tuLFZak4ekzZkC0zAVwT8b6FQSixi4fziU=;
 b=FtuFPNDHVku9HVgiJDZrJsh9/fxDC5VmX1uh9+G0GwLyu6+TTw1b8Zwn6WORL5L4NejzKW
 zVdyxTrscH1qftApNiZHJ+4te2BPVc7+Z+D8Nb53bPj+QI8PNU8pYvHRxaC/j12ALowGJJ
 VA4WBiZxPzNcLZfhbcnFQJengNDt1sJ4d4SNdUUm+AUV4qm8pIOFycJhX/NxzVmxKn8GQO
 l+n/8wW5WkVfIPWC1ogkCQcV+xerxQVybAaYAW7rLauhx9x7ClqPZ2PzNEtcyzAZ9mOAmc
 z+ALtu5k1pL5wVPrPkuhYtxVO96iRn+DwhR7y0/EWwUzXP2kyw5aRjUV5NIJpg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 12 May 2026 16:43:54 +0200
Message-ID: <20260512144358.419599-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gFKBB26Ppz9v0b
X-Headers-End: 1wMoLx-0007ID-L4
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/5] ovpn: use bound device in
 UDP when available
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

RnJvbTogUmFsZiBMaWNpIDxyYWxmQG1hbmRlbGJpdC5jb20+CgpVc2UgdGhlIHNvY2tldOKAmXMg
Ym91bmQgbmV0d29yayBpbnRlcmZhY2UgaWYgaXTigJlzIGV4cGxpY2l0bHkgc3BlY2lmaWVkCnZp
YSB0aGUgLS1iaW5kLWRldiBvcHRpb24gaW4gb3BlbnZwbi4KClNpZ25lZC1vZmYtYnk6IFJhbGYg
TGljaSA8cmFsZkBtYW5kZWxiaXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbnRvbmlvIFF1YXJ0dWxs
aSA8YW50b25pb0BvcGVudnBuLm5ldD4KLS0tCiBkcml2ZXJzL25ldC9vdnBuL3VkcC5jIHwgNCAr
KystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvb3Zwbi91ZHAuYyBiL2RyaXZlcnMvbmV0L292cG4vdWRwLmMK
aW5kZXggNDkzYTVhMDc0NGFmLi43OGI5YWVhMDZkZTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0
L292cG4vdWRwLmMKKysrIGIvZHJpdmVycy9uZXQvb3Zwbi91ZHAuYwpAQCAtMTUzLDYgKzE1Myw3
IEBAIHN0YXRpYyBpbnQgb3Zwbl91ZHA0X291dHB1dChzdHJ1Y3Qgb3Zwbl9wZWVyICpwZWVyLCBz
dHJ1Y3Qgb3Zwbl9iaW5kICpiaW5kLAogCQkuZmw0X2Rwb3J0ID0gYmluZC0+cmVtb3RlLmluNC5z
aW5fcG9ydCwKIAkJLmZsb3dpNF9wcm90byA9IHNrLT5za19wcm90b2NvbCwKIAkJLmZsb3dpNF9t
YXJrID0gc2stPnNrX21hcmssCisJCS5mbG93aTRfb2lmID0gc2stPnNrX2JvdW5kX2Rldl9pZiwK
IAl9OwogCWludCByZXQ7CiAKQEAgLTIzMCw3ICsyMzEsOCBAQCBzdGF0aWMgaW50IG92cG5fdWRw
Nl9vdXRwdXQoc3RydWN0IG92cG5fcGVlciAqcGVlciwgc3RydWN0IG92cG5fYmluZCAqYmluZCwK
IAkJLmZsNl9kcG9ydCA9IGJpbmQtPnJlbW90ZS5pbjYuc2luNl9wb3J0LAogCQkuZmxvd2k2X3By
b3RvID0gc2stPnNrX3Byb3RvY29sLAogCQkuZmxvd2k2X21hcmsgPSBzay0+c2tfbWFyaywKLQkJ
LmZsb3dpNl9vaWYgPSBiaW5kLT5yZW1vdGUuaW42LnNpbjZfc2NvcGVfaWQsCisJCS5mbG93aTZf
b2lmID0gc2stPnNrX2JvdW5kX2Rldl9pZiA/OgorCQkJCSAgICAgIGJpbmQtPnJlbW90ZS5pbjYu
c2luNl9zY29wZV9pZCwKIAl9OwogCiAJbG9jYWxfYmhfZGlzYWJsZSgpOwotLSAKMi41My4wCgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52cG4t
ZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwK
