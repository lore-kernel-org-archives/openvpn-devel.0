Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FDC43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tFTJyuSSUN8mkyIYeWWLA8wnTRX+EIKlDEhKhB6IQ9k=; b=Mkt+LXpd9n2FpvvbpDNzXvqfjQ
	lxFq2SPQrhvtes6b1CnpkCaBDZaXhNua+xhFQO3R/yPHrR0/UONjIvLe/heaQv6ieKyICICVlNsPz
	laAxcKEKdKYNrxheB/jgENg6cWuBGEwrBJewaexWQOWiqmFJ8dPhjkqkF60tbFFe9ggA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfElG-0008AD-2L;
	Thu, 02 Jul 2026 10:35:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wfElD-00089x-N5;
 Thu, 02 Jul 2026 10:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOuo6E7X/Sd6xwJeN3OoTfDj6qa/wL8xbMXU3KBXngY=; b=atf0EacfIi1P49+8zy5LCdnybP
 sbyjvaX0InlEIQ8+zimP6vpsdKTs/NR5DVT+Gh6TsUsFDoianFyun+70nIKoIvrWoeQ0d/SUFaP7L
 gmp8cXnL37Qj6GD0bhvIVU49zBI68Qq9RUWVSrce/4TzJjTVQK9faZtJuM1z4cW8/YTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:To
 :From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mOuo6E7X/Sd6xwJeN3OoTfDj6qa/wL8xbMXU3KBXngY=; b=X
 9nNfvbakFNr3viGwrJZpgaNbmlq8s65LrcptELqql37pYdgaB9aa2BlzznJK2SxrQ/MacLeu3S3ej
 Cpbl0Fk4WtzFsNAwenClMvdlJsYEZw7WEjYoHDxotodR07uc5X2q5D87OTJUFB8+owMNutgwHladR
 2WlH15zjBWPqlpyI=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfElD-0000NW-0x; Thu, 02 Jul 2026 10:35:12 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grY585yTPz8v1B;
 Thu, 02 Jul 2026 12:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1782988124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mOuo6E7X/Sd6xwJeN3OoTfDj6qa/wL8xbMXU3KBXngY=;
 b=zQKc5C8LHzVzsd/o2sLVPIwzRgq3uM9a1y3Xh+47ALVxrJ7ruPzY6BAdF27m+tqK8Us88E
 hdVDEA8Y0iLO6TNXycRDjhcP9bH8QIRfM9Q4sFNTcfxHRmsBLZOXLkpimFRUuVxoiz9nZ/
 04Ejdq3BJoSs0epPK/vx9A/MEXbAr1VPGGsiUFI+zU6JE75dvmWigmlqcyDhiOkktXa+cf
 tHkfyDGZeUNqnOikezQCQ2b5mdE9Ianku1xU7x4suDF8ZULx4zD+GQ/IQVNE4GdyQR+fjJ
 CPMnyo8kRoWfevYgEkPgdvbe99K805rkzxLse8yM7DobY+f1N3SpQDy2TNDUjg==
Date: Thu, 2 Jul 2026 12:28:42 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-announce@lists.sourceforge.net,
 openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <akY9Wslu76gU50Iy@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1wfElD-0000NW-0x
Subject: [Openvpn-devel] OpenVPN 2.6.21 released
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
ZW5WUE4gMi42LjIxLgpUaGlzIGlzIGEgYnVnZml4IHJlbGVhc2UgZml4aW5nIHNldmVyYWwgc2Vj
dXJpdHkgaXNzdWVzLgoKU2VjdXJpdHkgZml4ZXM6CgoqIEZpeCB1c2UtYWZ0ZXItZnJlZSBidWcg
aW4gYWNrX3dyaXRlX2J1ZigpLCB0cmlnZ2VyYWJsZSBieSBhIHdlbGwtdGltZWQgc2VxdWVuY2Ug
b2YgY29udHJvbCBjaGFubmVsICsKICBhdXRoZW50aWNhdGlvbiBwYWNrZXRzIChDVkUtMjAyNi0x
Mjk5NikKICBCdWcgZm91bmQgYnkgbXVsdGlwbGUgcmVzZWFyY2hlcnM6CiAgICAqIOeroOmxvOWT
pSAod3d3LmFpcHlhaXB5LmNvbSkKICAgICogSGFpeWFuZyBIdWFuZwogICAgKiBIYXJ1a2kgT3lh
bWEgKFdhc2VkYSBVbml2ZXJzaXR5KQoqIEZpeCB1c2UtYWZ0ZXItZnJlZSBidWcgaW4gdGxzX3dy
YXBfcmVuZWcoKSwgdHJpZ2dlcmFibGUgYnkgc3VpdGFibGUgc2VxdWVuY2Ugb2YgZHluYW1pYyB0
bHMtY3J5cHQKICBjb250cm9sLWNoYW5uZWwgcGFja2V0cyAoQ1ZFLTIwMjYtMTMxMTcpCiAgQnVn
IGZvdW5kIGJ5IG11bHRpcGxlIHJlc2VhcmNoZXJzOgogICAgKiBUcmFjZTM3IExhYnMgKGdpdGh1
Yi5jb20vdHJhY2UzN2xhYnMpCiAgICAqIEhhaXlhbmcgSHVhbmcKKiBGaXggc2VydmVyIGNyYXNo
IG9uIHJlY2VwdGlvbiBvZiBzdWl0YWJseSBtYWxmb3JtZWQgYXV0aC10b2tlbiwgaWYgLS1hdXRo
LWdlbi10b2tlbiBleHRlcm5hbC1hdXRoIGlzCiAgYWN0aXZlIChDVkUtMjAyNi0xMzEyMikKICBC
dWcgZm91bmQgYnkgSGFpeWFuZyBIdWFuZy4KKiBGaXggbWVtb3J5LWxlYWsgaW4gdGxzLWNyeXB0
LXYyIGNsaWVudCBrZXkgaGFuZGxpbmcgdGhhdCBjb3VsZCBsZWFkIHRvIG91dC1vZi1tZW1vcnkg
c2l0dWF0aW9ucyBhbmQKICBzdWJzZXF1ZW50IHNlcnZlciBjcmFzaGVzIChDVkUtMjAyNi0xMjkz
MikKICBCdWcgZm91bmQgYnkgVmFsdG9uIFRhaGlyaS4KKiBGaXggcG9zc2libGUgMS1ieXRlIGJ1
ZmZlciBvdmVycnVuIG9uIE5UTE12MiBwcm94eSByZXNwb25zZXMuIChDVkUtMjAyNi0xMTc3MSkK
ICBCdWcgZm91bmQgYnkgVHJpc3RhbiBNYWRhbmkgKEBUcmlzdGFuSW5TZWMpLgoqIEZpeCBhbm90
aGVyIG1lbW9yeSBsZWFrIG9uIHJlY2VwdGlvbiBvZiBzdWl0YWJsZSB0bHMtY3J5cHQtdjIgcGFj
a2V0cyB0aGF0IGNvdWxkIGxlYWQgdG8gYW4gb3V0IG9mIG1lbW9yeQogIHNpdHVhdGlvbiBhbmQg
c2VydmVyIGNyYXNoIChDVkUtMjAyNi0xMzY5OCkKICBCdWcgZm91bmQgYnkgTWF4IEZpbGxpbmdl
ci4gT3ZlcmxhcHMgd2l0aCBhIHJlcG9ydCBmcm9tIFZhbHRvbiBUYWhpcmkgdGhhdCB3ZSBiZWxp
ZXZlIHRvIGJlIGZpeGVkIGJ5IHRoaXMKICBidWdmaXggYXMgd2VsbC4KCkJ1Z2ZpeGVzOgoKKiBX
aW5kb3dzOiBmaXggcGx1Z2luIHRydXN0ZWQtZGlyIGNoZWNrIHByZWZpeCBieXBhc3MgKHRoaXMg
Zml4ZXMgYSBidWcgaW4gdGhlIHBhdGggY2hlY2tpbmcgbG9naWMgd2UgZG8gb24KICBXaW5kb3dz
IGZvciAiaXMgbG9hZGluZyBhIHBsdWdpbiBmcm9tIHRoaXMgcGF0aCBhbGxvd2VkPyIsIGJ1dCBz
aW5jZSB3ZSBjb3VsZCBub3QgZmluZCBhIHdheSB0byBleHBsb2l0CiAgdGhpcyB1bmxlc3Mgc3Rh
cnRpbmcgd2l0aCBhZG1pbiBwcml2cyBvciBhIHNvY2lhbCBlbmdpbmVlcmluZyBhdHRhY2ssIG5v
dCBjbGFzc2lmaWVkIGFzIGEgc2VjdXJpdHkgZml4KQoqIG9wdGlvbnM6IGZpeCB1c2UtYWZ0ZXIt
ZnJlZSBvZiBETlMgb3B0aW9ucyBvbiBjbGllbnQgY29ubmVjdCAodXNpbmcgc3VpdGFibGUgLS1k
bnMgb3IgLS1kaGNwLW9wdGlvbiBETlMKICBvcHRpb25zIGluIGEgc2VydmVyIGNvbmZpZyAtIG5v
dCBwdXNoZWQsIGJ1dCBhcHBseWluZyB0byB0aGUgc2VydmVyIGl0c2VsZiAtIHRyaWdnZXJzIGEg
ZG91YmxlIGZyZWUoKSBhbmQKICB1c2UtYWZ0ZXItZnJlZSBjb25kaXRpb24sIHBvc3NpYmx5IGNy
YXNoaW5nIHRoZSBzZXJ2ZXIpIChHaXRodWI6IE9wZW5WUE4vb3BlbnZwbiMxMDYwKQoqIE51bGwt
dGVybWluYXRlIHRscy1jcnlwdCBjbGllbnQga2V5cyB3aGVuIHRlc3RpbmcgLSBub24tZXhwbG9p
dGFibGUgc3RybGVuKCkgb24gYSBidWZmZXIgdGhhdCBpcyBub3QKICBudWxsLXRlcm1pbmF0ZWQK
KiBFbnN1cmUgcHVzaGVkIHR1bi1tdHUgaXMgbm8gbG93ZXIgdGhhbiBUVU5fTVRVX01JTiAtIHRo
aXMgZml4ZXMgYSBidWcgd2hlcmUgYSBzZXJ2ZXIgY2FuIHB1c2ggYSBzdWl0YWJsZQogIGNvbWJp
bmF0aW9uIG9mIG9wdGlvbnMgYW5kIG1ha2UgdGhlIGNsaWVudCBBU1NFUlQoKS4KICAoUmVwb3J0
ZWQgYXMgc2VjdXJpdHkgaXNzdWUgYnkgSGFpeWFuZyBIdWFuZywgYnV0IGl0IHdhcyBkZWNpZGVk
IHRoYXQgdGhlIHNlcnZlciBhbHdheXMgaGFzIG1lYW5zIHRvIG1ha2UKICB0aGUgY2xpZW50ICJu
b3QgZnVuY3Rpb24gcHJvcGVybHkiLCBhbmQgaXQgY2FuIG5vdCBiZSBleHBsb2l0ZWQgYmV5b25k
IHRoYXQpCgpNb3JlIGRldGFpbHMgY2FuIGJlIGZvdW5kIGluIHRoZSBDaGFuZ2VzIGRvY3VtZW50
OgoKPGh0dHBzOi8vZ2l0aHViLmNvbS9PcGVuVlBOL29wZW52cG4vYmxvYi92Mi42LjIxL0NoYW5n
ZXMucnN0PgoKU291cmNlIGNvZGUgYW5kIFdpbmRvd3MgaW5zdGFsbGVycyBjYW4gYmUgZG93bmxv
YWRlZCBmcm9tIG91ciBkb3dubG9hZCBwYWdlOgoKPGh0dHBzOi8vY29tbXVuaXR5Lm9wZW52cG4u
bmV0L0Rvd25sb2Fkcz4KClBhY2thZ2VzIGZvciBEZWJpYW4sIFVidW50dSwgRmVkb3JhLCBSSEVM
LCBhbmQgb3BlblNVU0UgYXJlIGF2YWlsYWJsZSBpbiB0aGUgdmFyaW91cwpvZmZpY2lhbCBDb21t
dW5pdHkgcmVwb3NpdG9yaWVzOgoKPGh0dHBzOi8vY29tbXVuaXR5Lm9wZW52cG4ubmV0L1BhZ2Vz
L09wZW5WUE4lMjBzb2Z0d2FyZSUyMHJlcG9zPgoKS2luZCByZWdhcmRzLAotLSAKICBGcmFuayBM
aWNodGVuaGVsZAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCk9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29w
ZW52cG4tZGV2ZWwK
