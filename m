Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F552CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNh6ZUipImzt5TqCRrffEqKKJuCZFg5SYMFTnOWG01k=; b=K0Uazfej+aLUpeWZzUV4WIGhp7
	UYDsudKOJwbBG73yHtQN5MrhTPeHtVUSSCQMy4KwYsIb6LKupcfuFVcGYyI4r8OjgyarWFdFQnei9
	hg2sIz3tveG0nkkr63ZcvNCIRuR/awNGJLPUmS5fAvRp4q8EBdAyj6APyplUSCtNmCFo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNeeh-0006zV-3U;
	Thu, 14 May 2026 22:35:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNeeY-0006zH-Bq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:35:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FXH4HpLRc+aPpO17Jzstb7rCb3EfUov9iei6V5kVC8k=; b=TJlB1RAJK1dYa2XC4kdJhe0NXy
 61KnlngevHc0ESzrEjwxIAc9z24wlskEIdPTl8OZk5KEyeHPW+IHVxudPwoy54Au4XLm28EAOeqWT
 aYEHvlDjbs8oDMAQAum1yi/MXLHviWyN/DG7p1cPYTBw3q6FzIIM0LRqvnHlOzrfXlFY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FXH4HpLRc+aPpO17Jzstb7rCb3EfUov9iei6V5kVC8k=; b=XGurgHkGxjfLh3VDRs4lPjSGed
 RoUT5vcMkOKMcnlXKlfn/whdmD1Mh5IJo4bOwXHAK54Eb93VA4rG2F3d5jeCyVn/pWya7Nurf9jAL
 UgnyI0UJnHk82Y28HFdRNJMjAXPBXXb2QtjjHRtmPUq+BgtXwDN7yo432iJepfx1KL+8=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNeeX-00016W-34 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:35:39 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gGlXD0Q69z9v7T;
 Fri, 15 May 2026 00:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778798124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXH4HpLRc+aPpO17Jzstb7rCb3EfUov9iei6V5kVC8k=;
 b=XtWh0QMhm1OX7CIMWaO2na95jLzUFkwSzbCPRbwkjY7Y5vOBcu4MEHOAryPK4IHtEa2KBt
 ZLvwIXaaKDtkBR8zXfb4L+Bp26UIz5h9BI9he7hNHB/bcZ0+s52PK5wnjfRIJcM7aRFUPR
 XAoXUaNSMyco8obY7cqknvmSralInDM+NFHhhklvH5mJpHToddqyEF5AYJ7OxVEbOqshNR
 vku7aIK98wQpznkMFoKkMVbyWh9wM6q70g89IwAXQxCbg/mGBBWYV56YTFcRkutRr+T3P3
 lZDvYy2W/KM5ForcYTDlDC+7tC70TVBmznCWKwj4TheEmJDvAJI7TH7uPIS1fA==
Message-ID: <8551e880-5411-4475-983f-7eefba4b700e@unstable.cc>
Date: Fri, 15 May 2026 00:35:21 +0200
MIME-Version: 1.0
To: Piotr Dobrogost <2026@p.dobrogost.net>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
X-Headers-End: 1wNeeX-00016W-34
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN tunnel stopped working
 (no traffic) after upgrade to OpenVPN 2.7 (Fedora 44)
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
Cc: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

T24gMTUvMDUvMjAyNiAwMDozMSwgUGlvdHIgRG9icm9nb3N0IHdyb3RlOgo+IE9uIEZyaSwgTWF5
IDE1LCAyMDI2IGF0IDEyOjE24oCvQU0gQW50b25pbyBRdWFydHVsbGkgPGFAdW5zdGFibGUuY2M+
IHdyb3RlOgo+Pgo+Pgo+PiBJbiB0aGlzIGR1bXAgZXZlcnl0aGluZyBzZWVtcyB0byBiZSB3b3Jr
aW5nIGZpbmUuCj4+IERpZCB5b3UgYXR0ZW1wdCBhIHBpbmcgYWZ0ZXIgdGhlIFZQTiBjb25uZWN0
aW9uIHdhcyBzdWNjZXNzZnVsPwo+IAo+IEkgZGlkIG5vdCwgYnV0IEkgcmVwZWF0ZWQgdGhlIHN0
ZXBzIG5vdywgYW5kIHBpbmcgZG9lcyBub3Qgd29yay4KClllYWgsIEkgZ3Vlc3NlZCBzbywgYnV0
IHdlIG5lZWQgdGhlIGR1bXAgZnJvbSB0aGUgaGFuZHNoYWtlIHVwIHVudGlsIHRoZSAKbm9uLXdv
cmtpbmcgcGluZy4gU28gd2UgY2FuIGNvbXBhcmUgcGFja2V0cy4KCj4gQnR3LCBJIGZvdW5kIG91
dCBzb21lb25lIGVsc2UgYSBmZXcgZGF5cyBhZ28gaGFkIHRoZSBzYW1lIHByb2JsZW0gb24KPiBX
aW5kb3dzIGFuZCBhZGRpbmcgZGlzYWJsZS1kY28gaW4gYSBjb25maWcgYWxzbyBmaXhlZCB0aGUg
aXNzdWUuCj4gCgoidHVubmVsIGRvZXMgbm90IHdvcmsiIGlzIGEgcHJldHR5IGdlbmVyaWMgImZh
aWx1cmUiLCB0aGVyZWZvcmUgaXQncyAKcHJldHR5IGRpZmZpY3VsdCB0byBjb3JyZWxhdGUgd2l0
aG91dCBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLgpPbiB0b3Agb2YgdGhhdCwgRENPIG9uIFdpbmRv
d3MgaXMgYSB0b3RhbGx5IGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiwgc28gCml0J3MgcXVpdGUg
ZGlmZmljdWx0IHRoYXQgdGhlIHR3byBwcm9ibGVtcyBhcmUgcmVsYXRlZC4KCgpSZWdhcmRzLAoK
PiBSZWdhcmRzLAo+IFBpb3RyIERvYnJvZ29zdAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QK
PiBPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwKCi0tIApBbnRvbmlvIFF1
YXJ0dWxsaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpPcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVu
dnBuLWRldmVsCg==
