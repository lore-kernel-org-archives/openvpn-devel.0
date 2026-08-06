Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ACAC56205
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CVtLoz7nrfhsLYNUXYSsJWAHgbF/ukMDBYUdrAyxUek=; b=kPaDhwMjpZk1Md92BrFvg0kg+/
	2w9BetYOFD1vVUorIARB8Q3M4ofbYArDoRW12omv6ZeKqx9dNYePCrCWtwHIL+waSUtGGs6H1byyN
	2BBwOuFM8fRNR8M6i/u+ar3Zkbb6BrbB2rPaC2QCRvsPj8l2RboNU+FZ+rLc9Jw0mG4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws0S2-0005Rw-6J;
	Thu, 06 Aug 2026 15:56:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1ws0S0-0005Rd-R4;
 Thu, 06 Aug 2026 15:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGVLlBtJAiWsd96n1lPvL7tDpkv5wL6fc3q2CoMkTUc=; b=kS2QidMJbiMghl0XRsXLh/+D35
 aMiuxkeKKBTscau1bsaw8RPNYqFGjmhPjwpufU2Svz6YGVIa+x5xidkQZuxKTDSmeZgdCjgmnXf1F
 faVrYr3EvrxBAQLGRCgdULZ7x/4cImo4g580XaspLvAd2TqA5hNPFiLgxkAOzGm9vQ2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:To
 :From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xGVLlBtJAiWsd96n1lPvL7tDpkv5wL6fc3q2CoMkTUc=; b=Z
 Wk3ZABIGRZlCaHV/IkoGEBG8FQOT8gR6TzzWhGBRc/3bRrfU+o/DUDunV6velIpULokTVstBx8XkI
 ioQJWRl55dWTFCCi4A81Cpv14e+cterPGFiEEOoLQaGL3bww53Ehp3PQWfPtiwmG7j7EVUpunzX0g
 k6sxmvGpr8HGjjjk=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws0S4-0004Ph-FV; Thu, 06 Aug 2026 15:56:09 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGBhc5FL0zMlDm;
 Thu, 06 Aug 2026 17:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786031760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGVLlBtJAiWsd96n1lPvL7tDpkv5wL6fc3q2CoMkTUc=;
 b=e2rZAaaJfvqXvi5BWjC7VdBCd4T255WW9i4Wajy0fTmx+yOCZnBZYMcIk8yICXqikNvhHB
 +CqJDNwRaEyF1Sg5Pz+jL3MHwiMfNavjt0bKfnFxTwA30RN+Z5kgdU+mX/iogjNNjJx0+D
 xGxJb4Xbq0YOS2DQ69fVGUJgkBk59XILKTDJRGUx9tnY9PbMbnNS7Faw/K9gv8o72uLvcr
 VanpJIdE1mywH8Wc5223L5/jtgffxxIL/8Dtlisdv+z3jd0f2fvUwpxVnCN8HzokGqcxcR
 U9Xh2/MAfhv2oBqsskj8Ao57kpXpgApqPyV3cM2OaTP6eNjEVesDMoO/VY/2OA==
Date: Thu, 6 Aug 2026 17:55:58 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-announce@lists.sourceforge.net,
 openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <anSujqGNSs4NDZsP@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1ws0S4-0004Ph-FV
Subject: [Openvpn-devel] OpenVPN 2.6.22 released
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

VGhlIE9wZW5WUE4gY29tbXVuaXR5IHByb2plY3QgdGVhbSBpcyBwcm91ZCB0byByZWxlYXNlIE9w
ZW5WUE4gMi42LjIyLiBUaGlzIGlzIGEgCmJ1Z2ZpeCByZWxlYXNlIGZpeGluZyBzZXZlcmFsIHNl
Y3VyaXR5IGlzc3Vlcy4KCioqSW1wb3J0YW50IG5vdGU6KioKCkFmdGVyIHRoaXMgcmVsZWFzZSB0
aGUgc3VwcG9ydCBzdGF0dXMgb2YgT3BlblZQTiAyLjYgY2hhbmdlcyBmcm9tICJGdWxsIFN1cHBv
cnQiIHRvIAoiT2xkIFN0YWJsZSBTdXBwb3J0Ii4gVGhpcyBtZWFucyB0aGF0IHdlIG1pZ2h0IG5v
dCBwcm92aWRlIFdpbmRvd3MgaW5zdGFsbGVyIApkb3dubG9hZHMgb2YgZnV0dXJlIDIuNi54IHJl
bGVhc2VzLiBQbGVhc2UgdXBncmFkZSB0byBPcGVuVlBOIDIuNy4KClNlY3VyaXR5IGZpeGVzOgoK
KiBvcGVudnBuc2VydiAod2luZG93cyk6IGJldHRlciBzY3J1dGluaXplIGNvbW1hbmQgbGluZSBw
YXNzZWQgaW4gZnJvbSB0aGUgY29udHJvbCAKICBzb2NrZXQgdG8gb3BlbnZwbi4gVGhpcyB3b3Vs
ZCBsZWFkIHRvIGNpcmN1bXZlbnRpbmcgYWRtaW4gcmVzdHJpY3Rpb25zIG9uIGFsbG93ZWQgCiAg
b3BlbnZwbiBjb25maWcgZGlyZWN0b3JpZXMgKGJ1dCBuZXZlciB0byAicmVhZCBmaWxlcyB0aGUg
dXNlciBoYXMgbm8gcGVybWlzc2lvbnMgCiAgZm9yIikgKENWRS0yMDI2LTYzNjQ5KQogIEJ1ZyBm
b3VuZCBieSDnq6Dpsbzlk6UgKHd3dy5haXB5YWlweS5jb20pCiogZGNvOiBtYWtlIGtleSBzdGF0
ZSBkZXN5bmMgcmVjb3ZlcmFibGUKICBUaGlzIHdhcyByZXBvcnRlZCBhcyBhICJ3aXRoIHN1aXRh
YmxlIHRpbWluZywgYSBrZXktdXBkYXRlIGRlLXN5bmMgYmV0d2VlbiBPcGVuVlBOIAogIGFuZCB0
aGUga2VybmVsIGNvdWxkIHRyaWdnZXIgYW4gQVNTRVJUKCkiLCBhbmQgd2FzIGluaXRpYWxseSBo
YW5kbGVkIGFzIHNlY3VyaXR5IAogIHJlcG9ydC4gSXQgdHVybmVkIG91dCB0byBiZSBub3QgZXhw
bG9pdGFibGUsIGJ1dCB0aGUgc3RhdGUgbWFjaGluZSB3YXMgbm90IHZlcnkgCiAgcm9idXN0IGFu
ZCBzbyB0aGUgb3Bwb3J0dW5pdHkgd2FzIHVzZWQgdG8gaW1wcm92ZSB0aGUgY29kZS4KICBCdWcg
Zm91bmQgYnkg56ug6bG85ZOlICh3d3cuYWlweWFpcHkuY29tKQoKQnVnZml4ZXM6CgoqIHJlZnVz
ZSBpbmNvbWluZyBIQVJEIFJFU0VUIHBhY2tldHMgd2l0aCBhIHNlcXVlbmNlIElEICE9IDAgKHRo
aXMgaXMgYmFzaWNhbGx5IAogIG1ha2luZyBhbiBPcGVuVlBOIHNlcnZlciBpZ25vcmUgYW5kIGxv
ZyBhICJzaG91bGQgbmV2ZXIgaGFwcGVuIiBjbGllbnQtc2lkZSAKICBtaXNiZWhhdmlvdXIsIHdo
aWNoIGNvdWxkIGxlYWQgdG8gVExTIGhhbmRzaGFrZSBlc3RhYmxpc2htZW50IGZhaWx1cmVzIGlu
IHAycCBUTFMgCiAgc2V0dXBzKQoqIGNvcnJlY3QgbWluaW11bSBwYWNrZXQgbGVuZ3RoIGNoZWNr
IGZvciA4MDIuMXEgdGFnZ2VkIHBhY2tldHMgKEdpdGh1YjogCiAgT3BlblZQTi9vcGVudnBuIzEw
NDQpLgogIFRoaXMgd2FzIGFsc28gcmVwb3J0ZWQgKHR3aWNlKSBhcyBhIHNlY3VyaXR5IGJ1Zywg
YXMgdGVjaG5pY2FsbHkgT3BlblZQTiB3aXRoIAogIC0tY2xpZW50LW5hdCB3b3VsZCByZWFkIGFu
ZCB3cml0ZSB1cCB0byA0IGJ5dGVzICJhZnRlciB0aGUgZW5kIG9mIHRoZSBwYWNrZXQiIC0gCiAg
YnV0IGR1ZSB0byB0aGUgT3BlblZQTiBwYWNrZXQgYnVmZmVyIGxheW91dHMsIHdoaWNoIGFyZSBh
bHdheXMgZnVsbC1mcmFtZS1zaXplZCAKICB0aGlzIGlzIGZ1bGx5IHNhZmUgYW5kIGhhcyBubyBh
ZHZlcnNlIGNvbnNlcXVlbmNlcy4KCk1vcmUgZGV0YWlscyBjYW4gYmUgZm91bmQgaW4gdGhlIENo
YW5nZXMgZG9jdW1lbnQ6Cgo8aHR0cHM6Ly9naXRodWIuY29tL09wZW5WUE4vb3BlbnZwbi9ibG9i
L3YyLjYuMjIvQ2hhbmdlcy5yc3Q+CgpTb3VyY2UgY29kZSBhbmQgV2luZG93cyBpbnN0YWxsZXJz
IGNhbiBiZSBkb3dubG9hZGVkIGZyb20gb3VyIGRvd25sb2FkIHBhZ2U6Cgo8aHR0cHM6Ly9jb21t
dW5pdHkub3BlbnZwbi5uZXQvRG93bmxvYWRzPgoKUGFja2FnZXMgZm9yIERlYmlhbiwgVWJ1bnR1
LCBGZWRvcmEsIFJIRUwsIGFuZCBvcGVuU1VTRSBhcmUgYXZhaWxhYmxlIGluIHRoZSB2YXJpb3Vz
Cm9mZmljaWFsIENvbW11bml0eSByZXBvc2l0b3JpZXM6Cgo8aHR0cHM6Ly9jb21tdW5pdHkub3Bl
bnZwbi5uZXQvUGFnZXMvT3BlblZQTiUyMHNvZnR3YXJlJTIwcmVwb3M+CgpLaW5kIHJlZ2FyZHMs
Ci0tIAogIEZyYW5rIExpY2h0ZW5oZWxkCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
