Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB957C44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbZ7ZiSrTW0/QkuLeLKhDiw844GI6YbElvbk970uJYg=; b=IINiEPYaGJGsfa2d29sY99ijFj
	mD5S5hRns3cnWdnzNc0158usVp+aI4P+/NcY4ca9W+gEq6k+k1g20MPMAZfC6/l4UE+P3Gi5l6fXB
	XnrJoU15riaGzBcZjRYfLNomvzd1BGR/Ohhbkj3VqIkeJjDC8kX8SPbpYOvfLIE01/r8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk67e-00036g-4c;
	Wed, 15 Jul 2026 20:22:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wk67d-00036a-AR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 20:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OMBcyCPEUS6oRYLIpFJZ/1pl2Yt9Vj42w2CmYMqsa+U=; b=hSLBs3ra7o3eIt+e99oOL/wH+I
 hjxdJDt+qxrK6Y4KcJwAdasDX3ZPYcZL02WyXTFCrw+ovUpdeaUM1pJaGzkDctmJszh/u3xEDQIus
 cHCWV6zjiAg1x/mebIIqb6+o3fjpfjTq7YDbeYR7qzyoPb3i5FMlZW0tF5a4xodElFqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OMBcyCPEUS6oRYLIpFJZ/1pl2Yt9Vj42w2CmYMqsa+U=; b=I0p06tDp+hGO07uZ7NWISnonMw
 4KFrvJKQ7I68Kiop4BAESzj2LcytTC1lEwXZsuDf+q9HsuYyERAG7YqmnIHYynKciiUjIxDLASykt
 hK71er0rffWQ3JiIjjrgl5RsfhXhuSeAKjElT61RTRtc67vg0mM5Ivcq4MXI+Ku87cxs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wk67b-0007Qj-1P for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 20:22:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66FKMBtV009053
 for <openvpn-devel@lists.sourceforge.net>; Wed, 15 Jul 2026 22:22:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66FKMAmO009052
 for openvpn-devel@lists.sourceforge.net; Wed, 15 Jul 2026 22:22:10 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 15 Jul 2026 22:22:02 +0200
Message-ID: <20260715202210.9010-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wk67b-0007Qj-1P
Subject: [Openvpn-devel] [PATCH v2] proto: correct 802.1Q length check in
 is_ipv_X
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

RnJvbTogcm9vdHZlY3RvcjIgPGR4Ym5hdmVlZC5rQGdtYWlsLmNvbT4KCkdpdGh1YjogT3BlblZQ
Ti9vcGVudnBuIzEwNDQKClRoaXMgaGFzIGFsc28gYmVlbiByZXBvcnRlZCB0d2ljZSBhcyBhIHNl
Y3VyaXR5IHJlbGV2YW50IGJ1ZywgYnV0Cm9ubHkgbGF0ZXIgdGhhbiB0aGUgb3JpZ2luYWwgZmlu
ZGluZyAtIGFuZCBpdCBpc24ndC4KCldoaWxlIC0tY2xpZW50LW5hdCB3b3VsZCBtb2RpZnkgYSAz
MmJpdCBpbnRlZ2VyICJhZnRlciB0aGUgcGFja2V0IgoodGhlIHBsYWNlIHdoZXJlIGFuIElQdjQg
YWRkcmVzcyB3b3VsZCBiZSwgaW4gYSB3ZWxsLWZvcm1lZCBwYWNrZXQpLAp0aGUgdW5kZXJseWlu
ZyBidWZmZXIgaXMgYWx3YXlzIG1heC1mcmFtZSBzaXplZCwgYW5kIHdlIG5ldmVyIGxvb2sKYXQg
dGhlICJtb2RpZmllZCBpbnRlZ2VyIiBhZnRlcndhcmRzLCBzbyB0aGVyZSBhcmUgbm8gY29uc2Vx
dWVuY2VzCndhcnJhbnRpbmcgYWxsb2NhdGlvbiBvZiBhIENWRSBJRC4KClNpZ25lZC1vZmYtYnk6
IHJvb3R2ZWN0b3IyIDxkeGJuYXZlZWQua0BnbWFpbC5jb20+CkFja2VkLWJ5OiBBcm5lIFNjaHdh
YmUgPGFybmUtb3BlbnZwbkByZmMyNTQ5Lm9yZz4KQWNrZWQtYnk6IEFudG9uaW8gUXVhcnR1bGxp
IDxhbnRvbmlvQG1hbmRlbGJpdC5jb20+CkdlcnJpdCBVUkw6IGh0dHBzOi8vZ2Vycml0Lm9wZW52
cG4ubmV0L2Mvb3BlbnZwbi8rLzE3ODkKUmVwb3J0ZWQtQnk6IOeroOmxvOWTpSAod3d3LmFpcHlh
aXB5LmNvbSkKUmVwb3J0ZWQtQnk6IFl1IFpoYW5nIFdvbmcgPHdvbmd5dXpoYW5nNDVAZ21haWwu
Y29tPgpDaGFuZ2UtSWQ6IEk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZl
Ci0tLQoKVGhpcyBjaGFuZ2Ugd2FzIHJldmlld2VkIG9uIEdlcnJpdCBhbmQgYXBwcm92ZWQgYnkg
YXQgbGVhc3Qgb25lCmRldmVsb3Blci4gSSByZXF1ZXN0IHRvIG1lcmdlIGl0IHRvIG1hc3Rlci4K
CkdlcnJpdCBVUkw6IGh0dHBzOi8vZ2Vycml0Lm9wZW52cG4ubmV0L2Mvb3BlbnZwbi8rLzE3ODkK
VGhpcyBtYWlsIHJlZmxlY3RzIHJldmlzaW9uIDIgb2YgdGhpcyBDaGFuZ2UuCgpBY2tlZC1ieSBh
Y2NvcmRpbmcgdG8gR2Vycml0IChyZWZsZWN0ZWQgYWJvdmUpOgpBcm5lIFNjaHdhYmUgPGFybmUt
b3BlbnZwbkByZmMyNTQ5Lm9yZz4KQW50b25pbyBRdWFydHVsbGkgPGFudG9uaW9AbWFuZGVsYml0
LmNvbT4KCiAgICAgICAgCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9wcm90by5jIGIvc3JjL29w
ZW52cG4vcHJvdG8uYwppbmRleCAxM2ZlMGE1Li43ODVjMDIxIDEwMDY0NAotLS0gYS9zcmMvb3Bl
bnZwbi9wcm90by5jCisrKyBiL3NyYy9vcGVudnBuL3Byb3RvLmMKQEAgLTcwLDcgKzcwLDcgQEAK
ICAgICAgICAgaWYgKHByb3RvID09IGh0b25zKE9QRU5WUE5fRVRIX1BfODAyMVEpKQogICAgICAg
ICB7CiAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgb3BlbnZwbl84MDIxcWhkciAqZXZoOwotICAg
ICAgICAgICAgaWYgKEJMRU5aKGJ1ZikgPCBzaXplb2Yoc3RydWN0IG9wZW52cG5fZXRoaGRyKSAr
IHNpemVvZihzdHJ1Y3Qgb3BlbnZwbl9pcGhkcikpCisgICAgICAgICAgICBpZiAoQkxFTlooYnVm
KSA8IHNpemVvZihzdHJ1Y3Qgb3BlbnZwbl84MDIxcWhkcikgKyBzaXplb2Yoc3RydWN0IG9wZW52
cG5faXBoZHIpKQogICAgICAgICAgICAgewogICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
ICAgICAgICAgICAgIH0KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpPcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9vcGVudnBuLWRldmVsCg==
