Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6697BC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:MIME-Version:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wWfTJHvOUOvcgKzMibnL2dVEoqxfT8xc8ZJyls5yh00=; b=hUBDih6gS1kqOxTWM1cDhpdFhJ
	9RTFzto562Ex5/vUhqgGCzp4ej3/v1MIRC0SNwypOGRn9rQGZzV2ysLRwiEQk1+uugvVj/bsDyBx6
	p+1a5o2S4V8jXHGy+DJoDg8oD6AERBtRVT2UdOBT4vU8u5HIZtkRSWYT9OtdJhYrzxYw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wezio-0007ev-16;
	Wed, 01 Jul 2026 18:31:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <matthias.andree@gmx.de>) id 1weziZ-0007dp-9t
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:From
 :To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5b4vUiHCH8vkp324ae15nfurnPF0RkVw2sz/y86iaUc=; b=iC0plu/UKcKkq5JdpK5bK1S8pJ
 io6PuE7V4GzaVd1gGN6vInR/GZjUWt9r+Ih5B5tdKMKSdUEYhM0R72M/IxNgI0PM6/TuyxItlEGxj
 lajZ1vbElfYjHO0boYw25zpctF6/uLfaTiVL1bGpKR9xGkJvJKt3FxtHQhfCQJ3FBSTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5b4vUiHCH8vkp324ae15nfurnPF0RkVw2sz/y86iaUc=; b=g
 szIGhdANN6mi6R/XSeY53ft1gjpKw6SCJsjBfzVQvMDumqpFCL+zZjloW10U2stli6l/AYy5+vwaI
 KxqClQUFmpAa0uU0Dq4nHvO3WfvoqcnsQA5WXdA9EwsJE+ml2hrVs7YJs1aI2bDJQvWACFToVSKvZ
 SyTNX2bkPPE99sSQ=;
Received: from mout.gmx.net ([212.227.15.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weziS-0004ZJ-Ph for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782930674; x=1783535474; i=matthias.andree@gmx.de;
 bh=5b4vUiHCH8vkp324ae15nfurnPF0RkVw2sz/y86iaUc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=b+CYNEyWUINtktDOj2Q3rXCCYQajLoxsHE0O1nK9qfIgIGvREpBLCWddVXA/0lxh
 Xz0FSIpuegnIv7AwJsIyReSvOrQu5UQ8+cR2OhNXkQwhK7QS2QIP9AuunYxAbjk2F
 ewVwfn+6xE3ceUmqUNxtpfjqY1FvvnagLdu1yW3v3zwNrkMbv/84BEKRFoK8qFZW0
 E7RNkgyOmuaD/7EcckIkXg0ac4zj0evoD7EyS0h2sWDPnWTWr8rVa2Vl0DXrLfXeC
 VKIqjuLCrUK8D1wBWGX2Xo552J83CYDBQkFB4O79cLhJGymdkKsMKrqZsLKFYh6SL
 lF9J4iadgWvNIaHNqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1wUS6q3TSs-00WZC1 for
 <openvpn-devel@lists.sourceforge.net>; Wed, 01 Jul 2026 20:31:14 +0200
Message-ID: <4fc05e83-ba18-49e7-904c-cc3182980652@gmx.de>
Date: Wed, 1 Jul 2026 20:31:14 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US, de-DE, en-GB
To: openvpn-devel@lists.sourceforge.net
X-Provags-ID: V03:K1:UdSKX0wbjfU8T86Mm0nxzfqXYHPW/xS1uv5ASC04ft4933dCmov
 y3gdZSQoToru+51VjpimFplTdzPjpKc0XxBVFif1GPTsNrpwCkjTmdJoZFKZwE33poDuvlV
 MejqlgZJRvBwuZSHQajV+JxWMK1CivONqBuYIuIu3HEi8opygj4qVBZ7zG1vMG1rdsDhxmf
 068++t40A0KSo+f7u0zow==
UI-OutboundReport: notjunk:1;M01:P0:cSSqE3ea4p8=;/a0tsD14fiaRs/UWa5CSDf8u+dI
 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
 Nihk1r3WwVFonYow+rr6ddVygvbGKZI/3B9E=
X-Headers-End: 1weziS-0004ZJ-Ph
Subject: [Openvpn-devel] [PATCH] Limit file size assignment to safe size_t
 range.
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
From: Matthias Andree via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Matthias Andree <matthias.andree@gmx.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

U29tZSBvcGVyYXRpbmcgc3lzdGVtcyAoRnJlZUJTRCAxNCBvbiBpMzg2KSBoYXZlCnNpemVvZihz
aXplX3QpID09IDQgKHdoaWNoIGlzIHVzZWQgZm9yIG9iamVjdCBzaXplcykKc2l6ZW9mKG9mZl90
KcKgID09IDggKHdoaWNoIGlzIHVzZWQgZm9yIGZpbGUgc2l6ZXMpLApzbyBhc3NpZ25pbmcgYSBm
aWxlIHNpemUgb2J0YWluZWQgZnJvbSBzdGF0IHRvIGEgc2l6ZV90CmNhdXNlcyBqdXN0aWZpZWQg
Y29tcGlsZXIgd2FybmluZ3MgYWJvdXQgYSBuYXJyb3dpbmcKY29udmVyc2lvbi4KCkl0IGlzIHNh
ZmUgdG8gYXNzdW1lIGEgMzItYml0IHBsYXRmb3JtIHdpbGwgbm90IHdhbnQKdG8gbG9hZCBhID49
IDQgR0IgZmlsZSB0aGVyZSwgc28gbGV0J3MganVzdCBBU1NFUlQoKQp0aGF0IHRoZSBvZmZfdCB3
ZSBhcmUgYWJvdXQgdG8gYXNzaWduIGZpdHMgaW50bwphIHNpemVfdCBvYmplY3QuCgpTaWduZWQt
b2ZmLWJ5OiBNYXR0aGlhcyBBbmRyZWUgPG1hdHRoaWFzLmFuZHJlZUBnbXguZGU+Ci0tLQogwqBz
cmMvb3BlbnZwbi9idWZmZXIuYyB8IDUgKysrKy0KIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL2J1ZmZlci5j
IGIvc3JjL29wZW52cG4vYnVmZmVyLmMKaW5kZXggNWYyYjIzMzguLjRiNmFjYjM2IDEwMDY0NAot
LS0gYS9zcmMvb3BlbnZwbi9idWZmZXIuYworKysgYi9zcmMvb3BlbnZwbi9idWZmZXIuYwpAQCAt
MTM5MSw3ICsxMzkxLDEwIEBAIGJ1ZmZlcl9yZWFkX2Zyb21fZmlsZShjb25zdCBjaGFyICpmaWxl
bmFtZSwgCnN0cnVjdCBnY19hcmVuYSAqZ2MpCiDCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7CiDC
oCDCoCDCoH0KCi3CoCDCoCBjb25zdCBzaXplX3Qgc2l6ZSA9IGZpbGVfc3RhdC5zdF9zaXplOwor
wqAgwqAgLyogZm9yIHNvbWUgc3lzdGVtcywgb2ZmX3QgaXMgNjMgYml0cyB3aWRlICsgc2lnbiBi
aXQgYW5kIHNpemVfdCBpcyAKMzIgYml0cworwqAgwqAgwqAqIHdpZGUsIGFuZCB3ZSBuZWVkIHRv
IGF2b2lkIG5lZ2F0aXZlIGdhcmJhZ2Ugd3JhcHBpbmcgYXJvdW5kICovCivCoCDCoCBBU1NFUlQo
ZmlsZV9zdGF0LnN0X3NpemUgPj0gMCAmJiBmaWxlX3N0YXQuc3Rfc2l6ZSA8PSBTSVpFX01BWCk7
CivCoCDCoCBjb25zdCBzaXplX3Qgc2l6ZSA9IChzaXplX3QpZmlsZV9zdGF0LnN0X3NpemU7CiDC
oCDCoCDCoHJldCA9IGFsbG9jX2J1Zl9nYyhzaXplICsgMSwgZ2MpOyAvKiBzcGFjZSBmb3IgdHJh
aWxpbmcgXDAgKi8KIMKgIMKgIMKgc2l6ZV90IHJlYWRfc2l6ZSA9IGZyZWFkKEJQVFIoJnJldCks
IDEsIHNpemUsIGZwKTsKIMKgIMKgIMKgaWYgKHJlYWRfc2l6ZSA9PSAwKQotLSAKMi41NC4wCgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52cG4t
ZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwK
