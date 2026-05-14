Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BDBCD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFDPlTbzBetfijiYfur7bcBGZSX5enWAUSECRFMXm2Q=; b=WM88RDbka9iT3bm2VGwqQSQLoj
	6+f2KlscfL9L3pj4tdO+Tvvylc6B0dICnD7x1Kqz2igheE4gBVQleGdlJdg9co+KANb6kQlS7H6XQ
	x387DOLzpolDZg17d7ZglALpgnpUeFyZQtyMWSQvGkcbUaVrY0m8aYL6f2yIYQGOTwRw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNc8e-0003A6-Au;
	Thu, 14 May 2026 19:54:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wNc8c-0003A0-U3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XVgwIFvQyaQVO6Szm9p4KX5sJjBPI/Fi3BvU7BnNMUI=; b=BoqtSIZ/BaHboNeh1qFt69LYWg
 j+mswHUfMKhyifMi+I8g4cBUf2zxNwKXwB3GvZvR6IpH2zzp34ex9sHoppRFC2XuUIska2YczlEzX
 Wvq9HywRPfX2hU2SKQRw6CjaHWR4G8Jz6fPOuAav6lZMghPZWJgEFXZaoC3msANDpDIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XVgwIFvQyaQVO6Szm9p4KX5sJjBPI/Fi3BvU7BnNMUI=; b=W2hJwVpnZnLKHSzeTrDg4JuDy4
 IjbkOKagWZ8pGiiq0RqnbqRyxqNsWrovZU5/a+/aBYv7t8lz9En4nyc4bwBc+dKWVp9XdJwbG7+tL
 bgjHfcN8LeQ29ODnpklRVCAt8N1KsgtMTaiPIP0/qettHTqBdDq0foYbbxfkfVBxBNe8=;
Received: from mail-vs1-f42.google.com ([209.85.217.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNc8b-0007ni-IB for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:54:31 +0000
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-6329f0e0a16so3597033137.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788459; x=1779393259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XVgwIFvQyaQVO6Szm9p4KX5sJjBPI/Fi3BvU7BnNMUI=;
 b=JXcj2GQ7T5uD8gYHGVsxmSamqpmmIkiTJ6Gh07Mgbidf29346KI2lvUy7hY0AKLUZv
 u3Z8P/1D8ls/mKxahFrwd/9mKiIwo4KEwZe6M2pghsfc7nQI/qKynEAwiwJXQkPPG9Fv
 7G3t+/seLrD3ViMx3anszmictYr24nSYTQmSrXMCEXokW2/zsnfjAta/7ArJPqohnn1I
 vJZCHsKgrETslXDbrh7fJTv3dR9feRuLwhaNl+i/SlFl0a9UJWoKrkHZKqP8PGQXGM45
 iLY9BPz7ftUdT38ieCZwJ15ZTo0exwm5fe1D5hfsmcjOKil2upYJC+01/xeNFsp8FIo5
 6Cbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d/du7Wc+m0IoKgTNmrGaPkHVsaxwJYZ6nyu2E5vEckawTClmTexZatXK6+X/BBeDXK4jWyaoUmQwyLb9w@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzXzgw68YojfXCudXfCGXyhy1GR/JYO395KHnULW3LdfU4P59HT
 jGOtFp6nV75TFQ06E0tnbrOqmprA2KBT+dRQP6V6Da+1ZaPsOy854w0Ytd63tyHg
X-Gm-Gg: Acq92OGrVGgKimhp7OT+VCmey6UIewwwwoiObnoM1gmVWuaddFUXVKF4P5LtVlwCde2
 megqI2Q9n4iRMesYLThi0cMOmU+El847lV0nBxDH++dL43zeHbuK/XN8u3rG+IIZmsUdMpZVJL+
 aaTc9D0pIQ3NGx2PG6R/6TModC3ioccaD8jiocZNPKrHbNfcPvj9Yf7exCexmLGEZsVrfb48JwA
 kuW3A2m1z0Cfioz3uhK47CPCfl8pAHe515k+94uR99HnE9WJ5/+SRr2oDnKUt+p34R6/jUjbqsQ
 Dynq4n04yj4JfZQwkI0YbKUVWZMOMGBxInOcyQ4Q0k3HrHpJWYbvT/rx6X8Ub4WFwiUi9tDgWY+
 prdgQwYLgyb0V4Uo99MD4wgAJK8HglJBhEPX+ZctMEw0hgf9qTQfN9UQ4szotFvhFe+W7KUZ8Oo
 5d+60L+/tqR/IevX1mi64DbbqqCNLkXIuHS0pHSDA/2W/gcfMOgSzmdGPOWgSCFUqo5eGjgCw=
X-Received: by 2002:a05:6102:4a8b:b0:631:26f6:7022 with SMTP id
 ada2fe7eead31-63a3f697fcbmr487842137.23.1778788459044; 
 Thu, 14 May 2026 12:54:19 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fad742c58sm1806356241.9.2026.05.14.12.54.18
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 12:54:18 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-63145ce291bso4108662137.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 12:54:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ86JjjQoa4e2rNRrtSEg5nT6oM0DhTDpj5wGG3sVI055kznmNRijdJmF/Kwi43Scw3hdsvJIv/euAJgNICT@lists.sourceforge.net
X-Received: by 2002:a05:6102:3f07:b0:62e:c8ff:d6c8 with SMTP id
 ada2fe7eead31-63a3d52d673mr492251137.8.1778788458682; Thu, 14 May 2026
 12:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
In-Reply-To: <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
From: Piotr Dobrogost <2026@p.dobrogost.net>
Date: Thu, 14 May 2026 21:53:42 +0200
X-Gmail-Original-Message-ID: <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
X-Gm-Features: AVHnY4LhXCf6np74WdTeUHmrjDVJIt_DuNB-36GjN2YozL8lpu1BJ-m_9ZvEsDw
Message-ID: <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wNc8b-0007ni-IB
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

T24gVGh1LCBNYXkgMTQsIDIwMjYgYXQgMjoxM+KAr1BNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVu
c3RhYmxlLmNjPiB3cm90ZToKPgo+IFdlIGhhdmUgYWxzbyB0cmllZCB0byByZXByb2R1Y2UgdGhl
IGlzc3VlIGxvY2FsbHkgb24gYSBGZWRvcmEgNDQgd2l0aCBubwo+IGx1Y2suIEl0IHNlZW1zIHRv
IGJlIHdvcmtpbmcgZmluZSBoZXJlLgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdXBw
b3J0IGFuZCBlZmZvcnQuCgoKPiBUaGVyZWZvcmUgaXQgbWF5IGJlIHNvbWV0aGluZyBzcGVjaWZp
YyB0byB5b3VyIGNvbmZpZ3VyYXRpb24gb3Igc2V0dXAuCj4KPiBBbW9uZyBhbGwgb3RoZXIgdGhp
bmdzLCBjb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgeW91ciBPcGVuVlBOIGNvbmZpZwo+IGZpbGUg
c28gdGhhdCB3ZSBjYW4gY2hlY2sgaWYgdGhlcmUgaXMgYW55IG9wdGlvbiBsZWFkaW5nIHRvIHRo
aXMgaXNzdWU/CgpNeSBjb25maWc6Ci0tLS0tCmNsaWVudApkZXYgb3Zwbi1zZngKZGV2LXR5cGUg
dHVuCgpwcm90byB1ZHAKcmVtb3RlIHZwbi5zZngucGwgMTE5NApyZW1vdGUgdnBuLnNmeC5wbCAx
MTk2CnJlbW90ZS1yYW5kb20KCnJlc29sdi1yZXRyeSBpbmZpbml0ZQpub2JpbmQKZGhjcC1vcHRp
b24gZG9tYWluLXNlYXJjaCBzZngubG9jYWwKCnNjcmlwdC1zZWN1cml0eSAyCnNldGVudiBQQVRI
IC91c3Ivc2JpbjovdXNyL2Jpbgp1cCAvZXRjL29wZW52cG4vY2xpZW50L3VwZGF0ZS1zeXN0ZW1k
LXJlc29sdmVkLnNoCmRvd24gL2V0Yy9vcGVudnBuL2NsaWVudC91cGRhdGUtc3lzdGVtZC1yZXNv
bHZlZC5zaApkb3duLXByZQoKcGVyc2lzdC1rZXkKcGVyc2lzdC10dW4KCnBrY3MxMiAvZXRjL29w
ZW52cG4vY2xpZW50L3NmeC52cG4ucDEyCmFza3Bhc3MgL2V0Yy9vcGVudnBuL2NsaWVudC9zZngu
cGFzcwoKbXV0ZS1yZXBsYXktd2FybmluZ3MKdmVyYiA1Ci0tLS0tCgoKPiBUaGlzIChhbmQgYWxz
byBvbiB0aGUgbG9jYWwgTEFOIGludGVyZmFjZSB0byBzZWUgaWYgdGhleSBhcmUgYWN0dWFsbHkK
PiBnZXR0aW5nIG91dCkuCgpbbWluZXJAaG9zdHggfl0kIHN1ZG8gdGNwZHVtcCAtaSBlbnA1czAg
aWNtcApkcm9wcGVkIHByaXZzIHRvIHRjcGR1bXAKdGNwZHVtcDogdmVyYm9zZSBvdXRwdXQgc3Vw
cHJlc3NlZCwgdXNlIC12W3ZdLi4uIGZvciBmdWxsIHByb3RvY29sIGRlY29kZQpsaXN0ZW5pbmcg
b24gZW5wNXMwLCBsaW5rLXR5cGUgRU4xME1CIChFdGhlcm5ldCksIHNuYXBzaG90IGxlbmd0aCAy
NjIxNDQgYnl0ZXMKMjE6MzU6MDQuNjk0NjQ3IElQIGhvc3R4ID4geHl6LnNmeC5wbDogSUNNUCBo
b3N0eCB1ZHAgcG9ydCA0NjA5OQp1bnJlYWNoYWJsZSwgbGVuZ3RoIDE0MQoyMTozNTowNS43MTg2
ODQgSVAgaG9zdHggPiB4eXouc2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0IDQ2MDk5CnVucmVh
Y2hhYmxlLCBsZW5ndGggMTQxCjIxOjM1OjA2Ljc0MjM2NiBJUCBob3N0eCA+IHh5ei5zZngucGw6
IElDTVAgaG9zdHggdWRwIHBvcnQgNDYwOTkKdW5yZWFjaGFibGUsIGxlbmd0aCAxNDEKMjE6MzU6
MDcuNzY2MDEyIElQIGhvc3R4ID4geHl6LnNmeC5wbDogSUNNUCBob3N0eCB1ZHAgcG9ydCA0NjA5
OQp1bnJlYWNoYWJsZSwgbGVuZ3RoIDE0MQoyMTozNTowOC43OTA5MDggSVAgaG9zdHggPiB4eXou
c2Z4LnBsOiBJQ01QIGhvc3R4IHVkcCBwb3J0IDQ2MDk5CnVucmVhY2hhYmxlLCBsZW5ndGggMTQx
CgoKPj4gSGF2ZSB5b3UgdHJpZWQgcnVubmluZyB0Y3BkdW1wIG9uIG9uIHRoZSBvdGhlciBlbmQg
dG8gc2VlIGlmIHBpbmdzIGFyZQo+PiByZWNlaXZlZCBvciBub3Q/IEp1c3QgdG8gdW5kZXJzdGFu
ZCB3aGVyZSBwYWNrZXRzIGFyZSBnZXR0aW5nIHN0dWNrLgoKTm8sIGJ1dCBJIGNvdWxkIHRyeSBp
ZiBuZWVkIGJlLgoKCj4gTWlnaHQgdGhlcmUgYmUgc29tZSBuZXcgZmlyZXdhbGxpbmcgc3R1ZmYg
aW52b2x2ZWQgdGhhdCBkb2VzIG5vdCBrbm93Cj4gaG93IHRvIGRlYWwgd2l0aCBvdnBuIGludGVy
ZmFjZXM/CgpJIGhhdmUgdGhlIGZpcmV3YWxsIGRpc2FibGVkOgoKW21pbmVyQGhvc3R4IH5dJCBz
eXN0ZW1jdGwgc3RhdHVzIGZpcmV3YWxsZAril4sgZmlyZXdhbGxkLnNlcnZpY2UgLSBmaXJld2Fs
bGQgLSBkeW5hbWljIGZpcmV3YWxsIGRhZW1vbgogICAgTG9hZGVkOiBsb2FkZWQgKC91c3IvbGli
L3N5c3RlbWQvc3lzdGVtL2ZpcmV3YWxsZC5zZXJ2aWNlOwpkaXNhYmxlZDsgcHJlc2V0OiBlbmFi
bGVkKQogICBEcm9wLUluOiAvdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbS9zZXJ2aWNlLmQKICAgICAg
ICAgICAg4pSU4pSAMTAtdGltZW91dC1hYm9ydC5jb25mCiAgICBBY3RpdmU6IGluYWN0aXZlIChk
ZWFkKQogICAgICBEb2NzOiBtYW46ZmlyZXdhbGxkKDEpCgoKUmVnYXJkcywKUGlvdHIgRG9icm9n
b3N0CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3Bl
bnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1k
ZXZlbAo=
