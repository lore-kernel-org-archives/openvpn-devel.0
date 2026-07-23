Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A2BC531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOhEkkcxLZl66u4ezthoOHbbghXvL+0Up1QD63QyY0o=; b=c6ziKqFz1wz77TGgvcvGVqJ7x2
	FLOBDKeOPu5iOXYLOcQ86DEFuhuOU3VBpaU5jNwSVGnfstEhjbobR12bML91WB/Wckixx/Ov0q5mJ
	JkNJX7J0ygWZGhXD7AhKPdHxtyNQByN4FJensa8DGXoSgGwJstKven6q7CLRh9SZ+yHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxmy-0001Ew-NE;
	Thu, 23 Jul 2026 18:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wmxmx-0001En-Ei
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4i3NKhJCvvNB3+dCp/fFcNTuqTYMGUrijC2udZfso8E=; b=Kf+njg8lm5w611WaDLdvb/XBp8
 Esi4NPJ9sML/r+z7EX/SpP/BNOhsaSNkri/OcuN58amXacSMh+xE6n4XfSDKa0bBjrlQsJE8xErgS
 Ts6HRBh4Z2Iobay27MeeK9gGpVp7WwcSoNpEYy7wJn5e9ENTrkEru6YqFUy3WSwrzGE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4i3NKhJCvvNB3+dCp/fFcNTuqTYMGUrijC2udZfso8E=; b=CMIq6IN6jIbltO/4MjTZc+dcTd
 580/uOz76aL8GSVC8Hi0gyTGo64H0h9fjbGqhQG2JjXlVFLww+SsQWxxL+6wuq5MKYCRbeKu6RoE3
 POa1mmIzwS94GaQJLwI6lqDD/lLYVyuF/6i+InD0vzLGWGxp5vXb4U3vDoQ3fNmiq2g0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmxmy-0002TO-Ta for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:04:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66NI4kqe017433
 for <openvpn-devel@lists.sourceforge.net>; Thu, 23 Jul 2026 20:04:46 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66NI4k49017432
 for openvpn-devel@lists.sourceforge.net; Thu, 23 Jul 2026 20:04:46 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 23 Jul 2026 20:04:38 +0200
Message-ID: <20260723180445.17392-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
References: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wmxmy-0002TO-Ta
Subject: [Openvpn-devel] [PATCH v1] Silence warning with gcc 15 and O0/01
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

RnJvbTogQXJuZSBTY2h3YWJlIDxhcm5lQHJmYzI1NDkub3JnPgoKV2hlbiBjb21waWxpbmcgd2l0
aCBsb3cgb3B0aW1pc2F0aW9uIGxldmVsIGdjYyBjb21wbGFpbnMKCiAgIHJvdXRlLmM6MTc4Mzo0
NDogZXJyb3I6IGNvbnZlcnNpb24gZnJvbSDigJhpbnTigJkgdG8g4oCYdWludDhfdOKAmSB7YWth
IOKAmHVuc2lnbmVkIGNoYXLigJl9IG1heSBjaGFuZ2UgdmFsdWUgWy1XZXJyb3I9Y29udmVyc2lv
bl0KICAgIDE3ODMgfCAgICAgICAgICAgICByNi0+bmV0d29yay5zNl9hZGRyW2J5dGUtLV0gJj0g
KDB4ZmYgPDwgYml0c190b19jbGVhcik7CgpXaXRoIGhpZ2hlciBpdCBhcHBhcmVudGx5IGRldGVj
dHMgdGhhdCB0aGlzIGlzIGNhbm5vdCBiZSBhbmQgZG9lcyBub3QKdHJpZ2dlciB0aGUgd2Fybmlu
Zy4gRXhwbGljaXRseSBjYXN0IHRvIHVpbnQ4X3QgdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcKCkNo
YW5nZS1JZDogSTk2ZDM2OTg2MDFiYjVhYWMzYTBkN2FjNmFjNWI1ZGQyM2M5NzU1MTcKU2lnbmVk
LW9mZi1ieTogQXJuZSBTY2h3YWJlIDxhcm5lQHJmYzI1NDkub3JnPgpBY2tlZC1ieTogRnJhbmsg
TGljaHRlbmhlbGQgPGZyYW5rQGxpY2h0ZW5oZWxkLmNvbT4KR2Vycml0IFVSTDogaHR0cHM6Ly9n
ZXJyaXQub3BlbnZwbi5uZXQvYy9vcGVudnBuLysvMTczMQotLS0KClRoaXMgY2hhbmdlIHdhcyBy
ZXZpZXdlZCBvbiBHZXJyaXQgYW5kIGFwcHJvdmVkIGJ5IGF0IGxlYXN0IG9uZQpkZXZlbG9wZXIu
IEkgcmVxdWVzdCB0byBtZXJnZSBpdCB0byBtYXN0ZXIuCgpHZXJyaXQgVVJMOiBodHRwczovL2dl
cnJpdC5vcGVudnBuLm5ldC9jL29wZW52cG4vKy8xNzMxClRoaXMgbWFpbCByZWZsZWN0cyByZXZp
c2lvbiAxIG9mIHRoaXMgQ2hhbmdlLgoKQWNrZWQtYnkgYWNjb3JkaW5nIHRvIEdlcnJpdCAocmVm
bGVjdGVkIGFib3ZlKToKRnJhbmsgTGljaHRlbmhlbGQgPGZyYW5rQGxpY2h0ZW5oZWxkLmNvbT4K
CiAgICAgICAgCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9yb3V0ZS5jIGIvc3JjL29wZW52cG4v
cm91dGUuYwppbmRleCA4MWNlODY3Li44ZWE3NDVkIDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9y
b3V0ZS5jCisrKyBiL3NyYy9vcGVudnBuL3JvdXRlLmMKQEAgLTE3ODAsNyArMTc4MCw3IEBACiAg
ICAgICAgIH0KICAgICAgICAgZWxzZQogICAgICAgICB7Ci0gICAgICAgICAgICByNi0+bmV0d29y
ay5zNl9hZGRyW2J5dGUtLV0gJj0gKDB4ZmYgPDwgYml0c190b19jbGVhcik7CisgICAgICAgICAg
ICByNi0+bmV0d29yay5zNl9hZGRyW2J5dGUtLV0gJj0gKHVpbnQ4X3QpKDB4ZmYgPDwgYml0c190
b19jbGVhcik7CiAgICAgICAgICAgICBiaXRzX3RvX2NsZWFyID0gMDsKICAgICAgICAgfQogICAg
IH0KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpPcGVu
dnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVudnBuLWRl
dmVsCg==
