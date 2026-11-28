Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96017606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fY2cZh2w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OwL5/3R3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bw7qKjMx;
	dkim=neutral header.d=eigentlich.net header.i=@eigentlich.net header.a=rsa-sha256 header.s=mx0 header.b=kva566Im
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XtDN+gMn5cdO+VyTs/7QNPKu71+BpEAVXDLzAu0Qe5M=; b=fY2cZh2wRmaSrn
	CnyhxhrEVKo/d9/D9QV7a/ytt97ugCga8vbioOm5kkOi9Qb86Cr3jrXlohbzEJ2Kkz2XzNrjDHqgM
	7ze6JuMpUHdVzMmbKa/Qkob0kLPYmMkpmilpV/rEZpaZKyHdp3GI3fnDIN5WarbXIjNdEPiyYhK1y
	CYk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX79b-000000007rJ-28h5;
	Sat, 28 Nov 2026 01:23:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <heiko@ist.eigentlich.net>) id 1xX79Z-000000007r5-1Hj5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jLP22hTs8poClZ67YNjX1D/Qrn7lRRIrAJS4cDJmj3w=; b=OwL5/3R3r2iL1O3uR8d2MNY5W0
 /WxxohrTkiXZ2mSXwmipFY8AKBK5ugDIH1TSyUSzKwqe3nnA8WvDWTQ4qdQwfdj6+2/xBG7fMTZSr
 iOL0hY7sJcZBQEky8+EqQJzQ/PJx1oea9GLU0h79oS05LJIsDNQAU0YsrW0/BspBf8Mw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jLP22hTs8poClZ67YNjX1D/Qrn7lRRIrAJS4cDJmj3w=; b=Bw7qKjMxTVmwF0xI5H51m7AuBD
 TDhChAAL2QGGBR03HaaCKOxN/cWDSO8lcF6n0JTjF0+ft5gxnUMHoN8QFMPc4ay7zAh8+D7mJORf2
 KntXdnllQZetIWIRcqdJ5qGNmFwEcEGQueTBBQdhBCkUtYp/Fj6RUzDpuKxRmwJBEjHo=;
Received: from exit0.net ([152.53.135.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX79Y-000000007iK-1A1L for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eigentlich.net;
 s=mx0; t=1795828046;
 bh=MG5fP1lu2inN4lK/miKY+sPf1NpPVOxNY5sGg0bW6ek=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kva566ImaF0KeRrdhKMwrpWnas4bLL1UDtMGj3WntA8wO0eD+WrSg7UbJpo0Cp45K
 aAAfEvGgT/r0hlIUCjXbsfdYwB/unjJtJxQ7bfY7dRZbvAMPoGh+kJQb8KsWqjny74
 FCmPrlMm2frqnHfGt7QSA66hAq2NMIlqItiH1vlHkuzmgNwPRVED7mKP6FUkqrGRLU
 Oto+xN8e8ksdEU8USeVtzycEjrfjqiiA+lAZq+D0ygI+WyiaurLb1nF/vOPEhz8Ear
 ufwv7+et7Uon1SXJAtnqRyB7X8BG739vVRDPzMS/dc3ksI97IdI6W1dsKhyzwV7ukH
 nnDgq585BpHow==
Received: from coruscant.localnet
 (p200300c97f2cbc00bc64bc9cb92e08cf.dip0.t-ipconnect.de
 [IPv6:2003:c9:7f2c:bc00:bc64:bc9c:b92e:8cf])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by exit0.net (Postfix) with ESMTPSA id 48ED4C12E6;
 Sat, 28 Nov 2026 02:07:26 +0100 (CET)
From: Heiko Hund <heiko@ist.eigentlich.net>
To: openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com
Date: Sat, 28 Nov 2026 02:07:25 +0100
Message-ID: <23326316.EfDdHjke4D@coruscant>
In-Reply-To: <672e65e8b29010734a815bcdf6c15955a24770b0-EmailReviewComments-HTML@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
 <672e65e8b29010734a815bcdf6c15955a24770b0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX79Y-000000007iK-1A1L
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict
 dns var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGVyaQoKT24gRnJlaXRhZywgMjcuIE5vdmVtYmVyIDIwMjYgMTM6MDI6MzcgTWl0dGVsZXVy
b3DDpGlzY2hlIE5vcm1hbHplaXQgRGVyaSAKSGFlcnVkaSAoQ29kZSBSZXZpZXcpIHZpYSBPcGVu
dnBuLWRldmVsIHdyb3RlOgo+IFR3byBzbWFsbCB0aGluZ3MsIG5laXRoZXIgb2YgdGhlbSBibG9j
a2luZzoKPiAKPiAtIGRuc192YXJzX2ZpbGUgc3RpbGwgcGFzc2VzIGRuc192YXJfbmFtZV92YWxp
ZCgpLiBOb3RoaW5nIHNlbmRzIGl0Cj4gICBhbnkgbW9yZSwgYnV0IG9sZCBjb3BpZXMgb2YgdGhl
IHNjcmlwdHMgc3RpbGwgc291cmNlIGl0LCBzbyBpdCBtaWdodAo+ICAgYmUgd29ydGggcmVqZWN0
aW5nIHRoYXQgbmFtZSBleHBsaWNpdGx5LgoKRG9uZSBpbiB0aGUgInJlc3RyaWN0IGRucyB2YXIg
bmFtZXMiIGNvbW1pdC4KCj4gLSBNYXliZSBhIGxpbmUgaW4gQ2hhbmdlcy5tZDogd2l0aCAtLXVz
ZXIsIC0tZG5zLXVwZG93biBzY3JpcHRzIG5vdwo+ICAgZ2V0IHRoZSBkbnNfKiB2YXJzIGluIHRo
ZSBlbnZpcm9ubWVudCBhcyBkb2N1bWVudGVkLCBhbmQKPiAgIGRuc192YXJzX2ZpbGUgaXMgbm8g
bG9uZ2VyIHNldC4KCkRvbmUgaW4gdGhlIG1haW4gY29tbWl0LgoKVGhhbmtzIGZvciB0aGUgcmV2
aWV3LgoKSGVpa28KCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpPcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9vcGVudnBuLWRldmVsCg==
