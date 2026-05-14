Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE42CD37AC
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AB0AmvIwUTleNh2Viuhv7e2mvnrYzh4PtVO3M3t6jqQ=; b=SS7uxamCcW+dRvSGgpog53505r
	DOMMGhSFbqiOuPs2LwdRuz3m1lE/Ens0wg8N49h+LYZr9hDqXtGLpXkxBF/BsgJDI0NJm+5Q0rvob
	PaOx3mxSh09fLho62pHH2Kad4ZMT0M0JpsxeYKA9FaK7hE9Le69xbsyiBg/tqjLQUaTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNcNx-0003Vo-FG;
	Thu, 14 May 2026 20:10:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wNcNv-0003VX-Cv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iBN3g1G9aHGreYX3eCc7uyhid+yEUIWuXWZQY7GS1ac=; b=FVKf/2loUZrWOA9JkKuVU3GYOM
 QtTdqf9d7eeCgxMss7sqVa31bL0z6EpZ4qofYaAPK0uFGMWzSTDUEUOfESKvuv1elHNPt3DSvo3hH
 hgN+gwkND4fIGaTHchYhg1l4j7JDrJBsvvoXGK+v/k+7TE7TvHs/sUYPC5cu8X3XbUHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iBN3g1G9aHGreYX3eCc7uyhid+yEUIWuXWZQY7GS1ac=; b=bFUWdlwP7xdrj944vUWjznhrVJ
 UFRpGuq04+5wGcFG3Aoxxh0R/p+jOz3G41dXDenZRum+Sx5A4SvXiABwRj3QjGa6/f2LWTeVtLEXC
 bOALDnwhhkCoTDKT35+8AeuYlTxQf422RpmG9iKVVWjO62bIwUSR0FPCq1/k1Dehwv+I=;
Received: from mail-vk1-f182.google.com ([209.85.221.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNcNk-0000PQ-PO for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:10:10 +0000
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso7553302e0c.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 13:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778789403; x=1779394203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBN3g1G9aHGreYX3eCc7uyhid+yEUIWuXWZQY7GS1ac=;
 b=D85naYUNvxrs5828cqsOHQNSYZMK6Z33o5q++T4m4AXnjEvB4jzLsbdFzjItZvXrVc
 oL3b8hFaWYCsNiKvaQENzMl5IrlmIiG3G0ZM06ZQmPgc9JNKXOk2IStRUezofGMYAU2n
 1RdBiiDgD121/SFpHdxEMZUDn0mdQOXcuO1tDoRC1QmEOknqujWKnpfmoBP4JwwORh/V
 fRBBq7BN+gMmFf/JAfyUzPQuh0gU1q9MzqDIhIC5wOcgQdAMnnicfI/L1S2YjCAEdchg
 OkR/nrfutAcJGskTWzDhKiCHVHb49DPZkNcqTGOXgHl8nmkHgD6X84qzo/HFXRLhfT1k
 3zig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XGLRDzeoz4UYpWBzeKqoCT5QwmbaKnbePdD2zMplyL6b/2YSL3p0WtLGiLrgy4FEm4FwqqjBCU5mlsYb4@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz3BdYzGJ2wdYVKxdSUhin4QeYBeS1xPXTMINBXTvxVxel5n+3V
 vsvhloNQEO4pjJryFB4rNgqJlmglgnwKvj3KIT+o7sG+jkB9xQRYv2QL/jvt28yQ
X-Gm-Gg: Acq92OH5MoTPvSbSIEQMAJdBGo6BbKd+ljIqUXrPi7R1vFU2nWBMbl0ouKobT1bw1bS
 ThIK8eslWgyeCh8qHRdqtr3UoTjIIaWLOyv8ddR4fxO6htFokES/m08VcKG2I4MuEjIlufeJyAN
 A2/a1SAclnwdRjGG3FdwqvVd6H3IfXDL1YO3psyE3qKss7u/DgenpXfMARoQMbJtP6Ib1+f+vc1
 /pi4Tcf00/v2hdZj/m4yEm9XALqhSJe3v5RBLK5NvCDE1vc8Eq3FR8BoQFDv70JdOpSbVjnDksb
 XhKiJmZ1pDfVxQyQnFC7gWGUvbaLzvswb1o4Bc648g/sdCepceUjWOL3flNJ2ZAuXqLEUUVCH0S
 p6Mnp2O6i/qFWObP0dNOD0U7pGiROBTBh1Eu7PP0rSBsmw59PwOYJx0kzza6VZaycJ1TVreoNI9
 OY2oc4aJSbynQTo37Bvc//bu9SCGaxpf+SsNbyudl2xyYao8xryLUGK3/WvqPs
X-Received: by 2002:a05:6122:8b17:b0:575:19a7:ae16 with SMTP id
 71dfb90a1353d-5760c05016dmr906809e0c.11.1778789403077; 
 Thu, 14 May 2026 13:10:03 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-575fa772918sm2188038e0c.12.2026.05.14.13.10.02
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 13:10:02 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-628086439b6so6392122137.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 13:10:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/h35XJpeMG6ATLKQ+rsKw4n0iA1XqJNMC+i1udqY59RZhkQaGB8kUwRo9K4oJUybozw+UAFnF5sLiJji1t@lists.sourceforge.net
X-Received: by 2002:a67:e104:0:b0:62a:1bba:64ee with SMTP id
 ada2fe7eead31-63a3c8016a5mr553957137.6.1778789402757; Thu, 14 May 2026
 13:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
In-Reply-To: <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
From: Piotr Dobrogost <2026@p.dobrogost.net>
Date: Thu, 14 May 2026 22:09:25 +0200
X-Gmail-Original-Message-ID: <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
X-Gm-Features: AVHnY4IhY-eBTokjVN1XgdEThBwWhFbjT-qAIIQiyJawpCt5aaNKBVRuBLML2nA
Message-ID: <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wNcNk-0000PQ-PO
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

T24gVGh1LCBNYXkgMTQsIDIwMjYgYXQgOTo1OOKAr1BNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVu
c3RhYmxlLmNjPiB3cm90ZToKPgo+IFRoaXMgbG9va3MgaW50ZXJlc3RpbmcsIGJ1dCBwbGVhc2Ug
ZG9uJ3QgZmlsdGVyIGZvciAiaWNtcCIsIGJlY2F1c2Ugb24KPiB0aGUgdXBsaW5rIGludGVyZmFj
ZSB5b3UgY2FuJ3Qgc2VlIHdoYXQncyBpbnNpZGUgdGhlIE9wZW5WUE4gcGFja2V0cy4KPiBTbyBo
ZXJlIHlvdSBhcmUgZmlsdGVyaW5nIGZvciAib3V0ZXJuIElDTVBzIi4KPgo+IFBsZWFzZSByYXRo
ZXIgZmlsdGVyIGZvciAiaG9zdCB4eXouc2Z4LnBsIiBhbmQgZG8gdGhlIHRlc3QgYWdhaW4uCgoK
W21pbmVyQGhvc3R4IH5dJCBzdWRvIHRjcGR1bXAgLWkgZW5wNXMwIGhvc3QgeHl6LnNmeC5wbApk
cm9wcGVkIHByaXZzIHRvIHRjcGR1bXAKdGNwZHVtcDogdmVyYm9zZSBvdXRwdXQgc3VwcHJlc3Nl
ZCwgdXNlIC12W3ZdLi4uIGZvciBmdWxsIHByb3RvY29sIGRlY29kZQpsaXN0ZW5pbmcgb24gZW5w
NXMwLCBsaW5rLXR5cGUgRU4xME1CIChFdGhlcm5ldCksIHNuYXBzaG90IGxlbmd0aCAyNjIxNDQg
Ynl0ZXMKMjI6MDM6MzAuNzM4MzE4IElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdp
YzogVURQLCBsZW5ndGggOTYKMjI6MDM6MzAuNzM4MzU4IElQIGhvc3R4LjQ1MzU2ID4geHl6LnNm
eC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggOTYKMjI6MDM6MzAuNzM4NTA5IElQIGhvc3R4LjQ1
MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggOTkKMjI6MDM6MzAuNzM4NTQw
IElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggOTkKMjI6
MDM6MzAuNzQ3MDE2IElQIHh5ei5zZngucGwubmV0bWFnaWMgPiBob3N0eC41MDEzOTogVURQLCBs
ZW5ndGggMTM5CjIyOjAzOjMwLjc0NzAxOSBJUCB4eXouc2Z4LnBsLm5ldG1hZ2ljID4gaG9zdHgu
NTAxMzk6IFVEUCwgbGVuZ3RoIDQ5MwoyMjowMzozMC43NDcwMTkgSVAgeHl6LnNmeC5wbC5uZXRt
YWdpYyA+IGhvc3R4LjUwMTM5OiBVRFAsIGxlbmd0aCAxNDIKMjI6MDM6MzAuNzQ3MDE5IElQIHh5
ei5zZngucGwubmV0bWFnaWMgPiBob3N0eC41MDEzOTogVURQLCBsZW5ndGggMTQyCjIyOjAzOjMw
Ljc0NzE3OCBJUCBob3N0eCA+IHh5ei5zZngucGw6IElDTVAgaG9zdHggdWRwIHBvcnQgNTAxMzkK
dW5yZWFjaGFibGUsIGxlbmd0aCAxNzUKMjI6MDM6MzAuNzQ3MTk2IElQIGhvc3R4ID4geHl6LnNm
eC5wbDogSUNNUCBob3N0eCB1ZHAgcG9ydCA1MDEzOQp1bnJlYWNoYWJsZSwgbGVuZ3RoIDUyOQoy
MjowMzozMC43NDcyMDMgSVAgaG9zdHggPiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0
IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5ndGggMTc4CjIyOjAzOjMwLjc0NzIwOSBJUCBob3N0eCA+
IHh5ei5zZngucGw6IElDTVAgaG9zdHggdWRwIHBvcnQgNTAxMzkKdW5yZWFjaGFibGUsIGxlbmd0
aCAxNzgKMjI6MDM6MzAuODMyMTM4IElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdp
YzogVURQLCBsZW5ndGggMTA3CjIyOjAzOjMwLjgzODY2OSBJUCB4eXouc2Z4LnBsLm5ldG1hZ2lj
ID4gaG9zdHguNTAxMzk6IFVEUCwgbGVuZ3RoIDIwMQoyMjowMzozMC44Mzg3MzQgSVAgaG9zdHgg
PiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5n
dGggMjM3CjIyOjAzOjM1Ljc3MTg4NyBJUCBob3N0eC40NTM1NiA+IHh5ei5zZngucGwubmV0bWFn
aWM6IFVEUCwgbGVuZ3RoIDk2CjIyOjAzOjM1Ljc3MTk3MiBJUCBob3N0eC40NTM1NiA+IHh5ei5z
ZngucGwubmV0bWFnaWM6IFVEUCwgbGVuZ3RoIDk2CjIyOjAzOjM1Ljc3MjA4NiBJUCBob3N0eC40
NTM1NiA+IHh5ei5zZngucGwubmV0bWFnaWM6IFVEUCwgbGVuZ3RoIDg4CjIyOjAzOjM1Ljc3MjA5
OSBJUCBob3N0eC40NTM1NiA+IHh5ei5zZngucGwubmV0bWFnaWM6IFVEUCwgbGVuZ3RoIDg4CjIy
OjAzOjM1Ljc3OTYxNyBJUCB4eXouc2Z4LnBsLm5ldG1hZ2ljID4gaG9zdHguNTAxMzk6IFVEUCwg
bGVuZ3RoIDEzOQoyMjowMzozNS43Nzk2MTggSVAgeHl6LnNmeC5wbC5uZXRtYWdpYyA+IGhvc3R4
LjUwMTM5OiBVRFAsIGxlbmd0aCAxMzEKMjI6MDM6MzUuNzc5NjU3IElQIGhvc3R4ID4geHl6LnNm
eC5wbDogSUNNUCBob3N0eCB1ZHAgcG9ydCA1MDEzOQp1bnJlYWNoYWJsZSwgbGVuZ3RoIDE3NQoy
MjowMzozNS43Nzk2NjUgSVAgaG9zdHggPiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0
IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5ndGggMTY3CjIyOjAzOjM1Ljc4Mjc2MCBJUCB4eXouc2Z4
LnBsLm5ldG1hZ2ljID4gaG9zdHguNTAxMzk6IFVEUCwgbGVuZ3RoIDQ5MwoyMjowMzozNS43ODI3
NjEgSVAgeHl6LnNmeC5wbC5uZXRtYWdpYyA+IGhvc3R4LjUwMTM5OiBVRFAsIGxlbmd0aCAxMzEK
MjI6MDM6MzUuNzgyOTE2IElQIGhvc3R4ID4geHl6LnNmeC5wbDogSUNNUCBob3N0eCB1ZHAgcG9y
dCA1MDEzOQp1bnJlYWNoYWJsZSwgbGVuZ3RoIDUyOQoyMjowMzozNS43ODI5MzkgSVAgaG9zdHgg
PiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5n
dGggMTY3CjIyOjAzOjM2LjAyMTgxMSBJUCBob3N0eC40NTM1NiA+IHh5ei5zZngucGwubmV0bWFn
aWM6IFVEUCwgbGVuZ3RoIDk2CjIyOjAzOjM2LjAzMTQ5NyBJUCB4eXouc2Z4LnBsLm5ldG1hZ2lj
ID4gaG9zdHguNTAxMzk6IFVEUCwgbGVuZ3RoIDE5MAoyMjowMzozNi4wMzE1NTAgSVAgaG9zdHgg
PiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5n
dGggMjI2CjIyOjAzOjM3LjU4NTU4NiBJUCB4eXouc2Z4LnBsLm5ldG1hZ2ljID4gaG9zdHguMzU0
ODc6IFVEUCwgbGVuZ3RoIDM3CjIyOjAzOjM3LjU4NTYzNyBJUCBob3N0eCA+IHh5ei5zZngucGw6
IElDTVAgaG9zdHggdWRwIHBvcnQgMzU0ODcKdW5yZWFjaGFibGUsIGxlbmd0aCA3MwoyMjowMzoz
Ny43MDUzNzEgSVAgaG9zdHguNDUzNTYgPiB4eXouc2Z4LnBsLm5ldG1hZ2ljOiBVRFAsIGxlbmd0
aCAxMDgKMjI6MDM6MzcuNzE0NDE2IElQIHh5ei5zZngucGwubmV0bWFnaWMgPiBob3N0eC41MDEz
OTogVURQLCBsZW5ndGggMTA1CjIyOjAzOjM3LjcxNDUzMSBJUCBob3N0eCA+IHh5ei5zZngucGw6
IElDTVAgaG9zdHggdWRwIHBvcnQgNTAxMzkKdW5yZWFjaGFibGUsIGxlbmd0aCAxNDEKMjI6MDM6
MzguNzM2MDEwIElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5n
dGggMTA4CjIyOjAzOjM4Ljc0MjgwMCBJUCB4eXouc2Z4LnBsLm5ldG1hZ2ljID4gaG9zdHguNTAx
Mzk6IFVEUCwgbGVuZ3RoIDEwNQoyMjowMzozOC43NDI4MzUgSVAgaG9zdHggPiB4eXouc2Z4LnBs
OiBJQ01QIGhvc3R4IHVkcCBwb3J0IDUwMTM5CnVucmVhY2hhYmxlLCBsZW5ndGggMTQxCjIyOjAz
OjM5Ljc2MDAyNSBJUCBob3N0eC40NTM1NiA+IHh5ei5zZngucGwubmV0bWFnaWM6IFVEUCwgbGVu
Z3RoIDEwOAoyMjowMzozOS43NjY0NzAgSVAgeHl6LnNmeC5wbC5uZXRtYWdpYyA+IGhvc3R4LjQ1
MzU2OiBVRFAsIGxlbmd0aCAzNwoyMjowMzozOS43NjY0NzEgSVAgeHl6LnNmeC5wbC5uZXRtYWdp
YyA+IGhvc3R4LjUwMTM5OiBVRFAsIGxlbmd0aCAxMDUKMjI6MDM6MzkuNzY2NDk1IElQIGhvc3R4
ID4geHl6LnNmeC5wbDogSUNNUCBob3N0eCB1ZHAgcG9ydCA1MDEzOQp1bnJlYWNoYWJsZSwgbGVu
Z3RoIDE0MQoyMjowMzo0MC43ODQwNTMgSVAgaG9zdHguNDUzNTYgPiB4eXouc2Z4LnBsLm5ldG1h
Z2ljOiBVRFAsIGxlbmd0aCAxMDgKMjI6MDM6NDAuNzkwNDE0IElQIHh5ei5zZngucGwubmV0bWFn
aWMgPiBob3N0eC41MDEzOTogVURQLCBsZW5ndGggMTA1CjIyOjAzOjQwLjc5MDQ0MyBJUCBob3N0
eCA+IHh5ei5zZngucGw6IElDTVAgaG9zdHggdWRwIHBvcnQgNTAxMzkKdW5yZWFjaGFibGUsIGxl
bmd0aCAxNDEKMjI6MDM6NDEuMDIxNzAyIElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRt
YWdpYzogVURQLCBsZW5ndGggODUKMjI6MDM6NDEuMDIxNzQ2IElQIGhvc3R4LjQ1MzU2ID4geHl6
LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggODUKMjI6MDM6NDEuMDIxNzU5IElQIGhvc3R4
LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggODgKMjI6MDM6NDEuMDIx
NzY5IElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQLCBsZW5ndGggODgK
MjI6MDM6NDEuMDIxODgxIElQIGhvc3R4LjQ1MzU2ID4geHl6LnNmeC5wbC5uZXRtYWdpYzogVURQ
LCBsZW5ndGggODgKMjI6MDM6NDEuMDMwNTI3IElQIHh5ei5zZngucGwubmV0bWFnaWMgPiBob3N0
eC41MDEzOTogVURQLCBsZW5ndGggNDgyCjIyOjAzOjQxLjAzMDUyNyBJUCB4eXouc2Z4LnBsLm5l
dG1hZ2ljID4gaG9zdHguNTAxMzk6IFVEUCwgbGVuZ3RoIDEzMQoKClJlZ2FyZHMsClBpb3RyIERv
YnJvZ29zdAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ck9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52
cG4tZGV2ZWwK
