Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A2C61DFD
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NcgfHFoJFyNLt10cjua4HuAuuZLXJon6Xy7nNZWLY4Q=; b=cIcJ6Jv5JfCyZXaVzjDfqG7DEo
	DrjROxC+ZhYkVUZdBYw93WUD6yE/V80w03BQSEEpRfS3GvuUH/ceeRXNfpc12NRbe/Q52rwRTzb5H
	fKvC/TJEb46D/egIoy9W72sJ5WfEETrEQWgXVO5mZO6Qz77jQ9tX6/xbpiFwRDx87uL0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0xU3-0002Ne-MD;
	Mon, 31 Aug 2026 08:35:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x0xTp-0002EI-CP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HFxOmFIwtRqOQH39In1CEfYNbimN1app4sxa1ALyKm4=; b=R6RqvzGfLJ/SLju8lXZOFukgW5
 bIMpIHseOXeqkrNctBr+RG3gNGGkt/9GwXZA/LZkH1Q8og27IjUwdgo0xL0Ios8kqp8rmGA2rqDLn
 P3CQB2n4HXOPCcs167M11BEBhvxQFqcdXYGDADfPL8ze16Rs6oPnbjD2ybjqG5DT1qRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HFxOmFIwtRqOQH39In1CEfYNbimN1app4sxa1ALyKm4=; b=Z1VYsyiutXpWUk5kMWxdyKncwI
 ozWE6veKU56dLpVjFAOnocIBBSoeZK7Ohl4qLC5cEDP8zrVkuv2LZrA/enEHusSnVhNmOGH8evLjH
 8z5Zfwvhahpf3WKZPAOLyWxzJ0/BngMda71os1LjOAQUjHVBTFiVYGoqrDYfSCQJWfQ8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0xTl-0003lg-6N for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67V8Yo42012507
 for <openvpn-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 10:34:50 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67V8YoZh012506
 for openvpn-devel@lists.sourceforge.net; Mon, 31 Aug 2026 10:34:50 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 10:34:40 +0200
Message-ID: <20260831083449.12484-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x0xTl-0003lg-6N
Subject: [Openvpn-devel] [PATCH v2] dhcp: Fix off-by-one in
 write_dhcp_search_str() temp buffer guard
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

RnJvbTogTmV4b3J5IDxTdDR5bDNyMzBAaG90bWFpbC5kZT4KCkVhY2ggc2VhcmNoIGxpc3QgZW50
cnkgY29uc3VtZXMgc3RybGVuKHB0cikgKyAyIGJ5dGVzIG9mIHRtcF9idWY6IG9uZQpsZWFkaW5n
IGxhYmVsIGxlbmd0aCBieXRlLCB0aGUgZG9tYWluIGNoYXJhY3RlcnMsIGFuZCBvbmUgdHJhaWxp
bmcgTlVMLgpUaGUgZ3VhcmQgb25seSBhY2NvdW50ZWQgZm9yIHN0cmxlbihwdHIpICsgMSwgc28g
YSBzZXF1ZW5jZSBvZiBlbnRyaWVzCndob3NlIGFjY3VtdWxhdGVkIGxlbmd0aCBsYW5kcyBleGFj
dGx5IG9uIHRoZSBib3VuZGFyeSBwYXNzZWQgdGhlIGNoZWNrCmFuZCB0aGVuIHdyb3RlIHRtcF9i
dWZbMjU2XSwgb25lIGJ5dGUgcGFzdCB0aGUgMjU2IGJ5dGUgYXJyYXkuCgpUaGUgZXhpc3Rpbmcg
ImxlbiA+IDI1NSIgY2hlY2sgZW5mb3JjZXMgdGhlIGNvcnJlY3QgdXBwZXIgYm91bmQsIGJ1dCBp
dApydW5zIGFmdGVyIHRoYXQgd3JpdGUgaGFzIGFscmVhZHkgaGFwcGVuZWQuCgpUaGUgZW50cmll
cyBjYW4gYmUgcHVzaGVkIGJ5IHRoZSBzZXJ2ZXI6IC0tZGhjcC1vcHRpb24gZmFsbHMgdW5kZXIK
T1BUX1BfREhDUEROUywgd2hpY2ggcHVsbF9wZXJtaXNzaW9uX21hc2soKSBpbmNsdWRlcywgYW5k
CnZhbGlkYXRlX2RvbWFpbigpIGltcG9zZXMgbm8gbGVuZ3RoIGxpbWl0LgoKUmVwcm9kdWNlZCB1
bmRlciBBZGRyZXNzU2FuaXRpemVyLCB3aGljaCByZXBvcnRzIGEgb25lIGJ5dGUKc3RhY2stYnVm
ZmVyLW92ZXJmbG93IGF0IGRoY3AuYzozMDguIFRoZSBhZGRlZCB1bml0IHRlc3QgY292ZXJzIHRo
ZQpib3VuZGFyeTsgaXQgZmFpbHMgYmVmb3JlIHRoaXMgY2hhbmdlIGFuZCBwYXNzZXMgYWZ0ZXIg
aXQuIFRoZSB0d28KZXhpc3RpbmcgY2FzZXMgbWFya2VkICJtYXhpbXVtIGxlbmd0aCIgYXJlIHVu
YWZmZWN0ZWQsIHNpbmNlIGEgMjUzCmNoYXJhY3RlciBkb21haW4gc3RpbGwgc2F0aXNmaWVzIDI1
MyArIDAgKyAyIDw9IDI1Ni4KClRoaXMgd2FzIHJlcG9ydGVkIGluZGVwZW5kZW50bHkgYnkgQW5k
cmUgS3JvcHAgYW5kIENow61uaCBOZ3V54buFbiBWxINuLgpQYXRjaCBhdXRob3IgaXMgQW5kcmUg
S3JvcHAsIHJlY29yZGluZyBib3RoIHJlcG9ydHMgaW4gdGhlIFJlcG9ydGVkLUJ5OgoKQ1ZFOiAy
MDI2LTgxNzM4CkNoYW5nZS1JZDogSTZhODg2YTFjYWMyZDQ3MjU4NTlkYWIyMzI1Y2QzNjIzMTJk
ZGM2NTkKU2lnbmVkLW9mZi1ieTogTmV4b3J5IDxTdDR5bDNyMzBAaG90bWFpbC5kZT4KQWNrZWQt
Ynk6IEdlcnQgRG9lcmluZyA8Z2VydEBncmVlbmllLm11Yy5kZT4KR2Vycml0IFVSTDogaHR0cHM6
Ly9nZXJyaXQub3BlbnZwbi5uZXQvYy9vcGVudnBuLysvMTg4NApSZXBvcnRlZC1CeTogQW5kcmUg
S3JvcHAgKE5leG9yeSkKUmVwb3J0ZWQtQnk6IENoaW5oTmd1eWVuCi0tLQoKVGhpcyBjaGFuZ2Ug
d2FzIHJldmlld2VkIG9uIEdlcnJpdCBhbmQgYXBwcm92ZWQgYnkgYXQgbGVhc3Qgb25lCmRldmVs
b3Blci4gSSByZXF1ZXN0IHRvIG1lcmdlIGl0IHRvIG1hc3Rlci4KCkdlcnJpdCBVUkw6IGh0dHBz
Oi8vZ2Vycml0Lm9wZW52cG4ubmV0L2Mvb3BlbnZwbi8rLzE4ODQKVGhpcyBtYWlsIHJlZmxlY3Rz
IHJldmlzaW9uIDIgb2YgdGhpcyBDaGFuZ2UuCgpBY2tlZC1ieSBhY2NvcmRpbmcgdG8gR2Vycml0
IChyZWZsZWN0ZWQgYWJvdmUpOgpHZXJ0IERvZXJpbmcgPGdlcnRAZ3JlZW5pZS5tdWMuZGU+Cgog
ICAgICAgIApkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vZGhjcC5jIGIvc3JjL29wZW52cG4vZGhj
cC5jCmluZGV4IGE1NGFiM2YuLjVjZGNmY2YgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL2RoY3Au
YworKysgYi9zcmMvb3BlbnZwbi9kaGNwLmMKQEAgLTI3Nyw3ICsyNzcsOSBAQAogICAgIHsKICAg
ICAgICAgY29uc3QgY2hhciAqcHRyID0gc3RyX2FycmF5W2ldOwogCi0gICAgICAgIGlmIChzdHJs
ZW4ocHRyKSArIGxlbiArIDEgPiBzaXplb2YodG1wX2J1ZikpCisgICAgICAgIC8qIEVhY2ggZW50
cnkgY29uc3VtZXMgc3RybGVuKHB0cikgKyAyIGJ5dGVzOiBvbmUgbGVhZGluZyBsYWJlbCBsZW5n
dGgKKyAgICAgICAgICogYnl0ZSBhbmQgb25lIHRyYWlsaW5nIE5VTC4gKi8KKyAgICAgICAgaWYg
KHN0cmxlbihwdHIpICsgbGVuICsgMiA+IHNpemVvZih0bXBfYnVmKSkKICAgICAgICAgewogICAg
ICAgICAgICAgKmVycm9yID0gdHJ1ZTsKICAgICAgICAgICAgIG1zZyhNX1dBUk4sICJ3cml0ZV9k
aGNwX3NlYXJjaF9zdHI6IHRlbXAgYnVmZmVyIG92ZXJmbG93IGJ1aWxkaW5nIERIQ1Agb3B0aW9u
cyIpOwpkaWZmIC0tZ2l0IGEvdGVzdHMvdW5pdF90ZXN0cy9vcGVudnBuL3Rlc3RfZGhjcC5jIGIv
dGVzdHMvdW5pdF90ZXN0cy9vcGVudnBuL3Rlc3RfZGhjcC5jCmluZGV4IDEwNGZjOWEuLjNhODRl
MWUgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3VuaXRfdGVzdHMvb3BlbnZwbi90ZXN0X2RoY3AuYworKysg
Yi90ZXN0cy91bml0X3Rlc3RzL29wZW52cG4vdGVzdF9kaGNwLmMKQEAgLTEyMCw2ICsxMjAsMjQg
QEAKICAgICBhc3NlcnRfbWVtb3J5X2VxdWFsKEJQVFIoJm91dF9idWYpLCBvdXRwdXRfNSwgc2l6
ZW9mKG91dHB1dF81KSk7CiAgICAgYXNzZXJ0X2ZhbHNlKGVycm9yKTsKIAorICAgIC8qIFNldmVy
YWwgZW50cmllcyB3aG9zZSBhY2N1bXVsYXRlZCBsZW5ndGggbGFuZHMgZXhhY3RseSBvbiB0aGUg
Z3VhcmQKKyAgICAgKiBib3VuZGFyeS4gRWFjaCBlbnRyeSBjb25zdW1lcyBzdHJsZW4oKSsyIGJ5
dGVzIG9mIHRtcF9idWYgKG9uZSBsZW5ndGgKKyAgICAgKiBwcmVmaXggcGx1cyBvbmUgdHJhaWxp
bmcgTlVMKSwgYnV0IHRoZSBndWFyZCBvbmx5IGFjY291bnRzIGZvcgorICAgICAqIHN0cmxlbigp
KzEsIHNvIHRoZSBsYXN0IGVudHJ5IHdyaXRlcyBvbmUgYnl0ZSBwYXN0IHRtcF9idWZbMjU2XS4K
KyAgICAgKiBTaXplczogNCB4IDUwIGxlYXZlcyBsZW4gPT0gMjA4LCB0aGUgZmluYWwgNDcgbWFr
ZXMKKyAgICAgKiA0NyArIDIwOCArIDEgPT0gMjU2LCB3aGljaCB0aGUgZ3VhcmQgc3RpbGwgYWNj
ZXB0cy4gKi8KKyNkZWZpbmUgRDUwICJhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYSIKKyNkZWZpbmUgRDQ3ICJhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYWFhYWFhYSIKKyAgICBjb25zdCBjaGFyICpvdmVyZmxvd19saXN0W10g
PSB7IEQ1MCwgRDUwLCBENTAsIEQ1MCwgRDQ3IH07CisgICAgYXNzZXJ0X2ludF9lcXVhbChzdHJs
ZW4oRDUwKSwgNTApOworICAgIGFzc2VydF9pbnRfZXF1YWwoc3RybGVuKEQ0NyksIDQ3KTsKKyAg
ICBidWZfY2xlYXIoJm91dF9idWYpOworICAgIHdyaXRlX2RoY3Bfc2VhcmNoX3N0cigmb3V0X2J1
ZiwgREhDUF9ET01BSU5fU0VBUkNILCBvdmVyZmxvd19saXN0LCA1LCAmZXJyb3IpOworICAgIC8q
IHRvdGFsIGlzIDI1NyA+IDI1NSwgc28gdGhlIG9wdGlvbiBtdXN0IGJlIHJlamVjdGVkIC0tIHRo
ZSBwb2ludCBvZiB0aGlzCisgICAgICogY2FzZSBpcyB0aGF0IHRtcF9idWYgbXVzdCBub3QgYmUg
d3JpdHRlbiBvdXQgb2YgYm91bmRzIG9uIHRoZSB3YXkuICovCisgICAgYXNzZXJ0X3RydWUoZXJy
b3IpOworICAgIGVycm9yID0gZmFsc2U7CisKICAgICBnY19mcmVlKCZnYyk7CiB9CiAKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpPcGVudnBuLWRldmVs
IG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVudnBuLWRldmVsCg==
