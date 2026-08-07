Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7BC5AC7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vbvoOLNMrrYGwHh9JsoFRJ4gluVCzykOAQLCekCBhE=; b=fzE06deSVXaye9ERjmf/5K4Eur
	WyQfYCK+mhsdCcbORIespCHnt4yl7mZgt4Du6uT6IKDF6HUsg4V56WXujp10QR1lPhWlw+x4pU6q6
	kUbiXXOLt9zOb2Dx962/jgocg3NxkvyX7B8lLwpxbIlFgGyBrO3TxRSOilMxV6Og1ilo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsIjE-0005YW-RG;
	Fri, 07 Aug 2026 11:27:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jkbullard@gmail.com>) id 1wsIjD-0005YG-1x
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kyYnI+ZRaDr95i4ZtBJlCVww5qMmd0+uzXfRFC9EajU=; b=ElUO7gAI9qc/KTgqQ0Nr4+9l+g
 6eHouMircecTkHM0EWkZ5xSCCCuUgIoyoJ/CJlZg+OXgA/HttgepwcnYOIfeHWJZuONACbnlU+a4r
 H+vDXK4xAbf5vYc1OVIIUtBWSxy3BgCViB7rmIPANrjPUcxWAHuIjENQFdkvT/81vEuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kyYnI+ZRaDr95i4ZtBJlCVww5qMmd0+uzXfRFC9EajU=; b=TIRPXFfEPL2jzdU+i60kSnBADR
 JqatyytoqV21SI7YNOQXxPoMIMcPpYk45G6cxa4JVNfd2aj2MkfvUAow7uMRcOA06/AniuXcl7txh
 4F/p8qbWfrpUfmgFQQV30d42AIv2d1ithE8+twsngxlcLIzqt1xgjnt8kSXUFOdIuucU=;
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsIjD-00012x-1B for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:27:07 +0000
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b2a22c52c1so3231555e87.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 04:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102020; cv=none;
 d=google.com; s=arc-20260327;
 b=Viv+QB9lrhAwDQeEBHOOzWFnwlRhY/iK3nJvE/73zTAYaMl7eInTd5ChyZkZX2rsPu
 /CQKV7yi5dwPresqH984Y5wiVB/kwOe/2wKovby2ZTLxplfYXoWhhqqNMr98nTDwVZ65
 2WuAlom8PU0qpWw0aNf82X8LxtwT7NFxuax5f+/jFsRlvQ7EyCITecglaYosnJqf7mRU
 zKoj8pEQcsXrVleQNsERRokzSXteVlh5rDkltIsSC7bPGus365F6kRwkSzqLhCWzioKs
 TB5mMLwUAM/e8Q1nXWHXqN6NAFR9yx3nsHcIm0A5JBrr4vhqxSDr/zt4/XP5ee7kYSr6
 bEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kyYnI+ZRaDr95i4ZtBJlCVww5qMmd0+uzXfRFC9EajU=;
 fh=L96WDcmZPEPEj/5RUQ+YbWLf2/+v3QniKqdE9zL23ak=;
 b=EkO5ClMLObBd5lb8iInSYX53u656Uej99ndBs+b2FH5sgprBHfhu9a6GpreXcKyrW0
 72ihn6fT2d7k29omK/fFdrlnJMV//kRhKmOfOdRiA0Dp6c9F9Oo8iVeFSdTkmHQeKfkC
 MtZQesXUfWxde3btn+QYV9/JGQkpsiagQR8ceoiZ+FZSxHZ/bIb6EsuhD2kYmI2iHhh6
 mJoAliZQDpe703eicVSxwmFWqQd4BDCx5HwQ+r2QkQ+b2Qi4AwXkw7KFPAuDIx/19GnL
 io/drmCXAxNqZsdP3hf8GKhtru4r48L5mG18ZREA8ip02vrX/Jdxnik8C36oWSYQji5U
 +sRg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786102020; x=1786706820; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kyYnI+ZRaDr95i4ZtBJlCVww5qMmd0+uzXfRFC9EajU=;
 b=Le3KdhUxSxvP9tGX5FwcxVH6ii2D6hj2gK11owHYrNVQFzjCMQhWLjVFyw6v6vJrCM
 aKQiVrkZyh1S8QSMFhRDEu1/MfYLktaF+84XJqqscXlzlfjdXd4TPs1lyTGTOBLzCVWr
 fawHUHefkC//WR1dyvIQz2oj2Cakig6sEOvlyHIYRYQ1+osWX3iE4D2/e6VOo/fBGR0N
 WXYjQvT9RSy/6aFl7tMeSMqiKOi3de9PqDfFxorvNZ7sftYvVgtLDK0/JH5xANjFYnuj
 WpSvBNE1dLGUMKqoKCt3H6+vAxJYehjvnHDecTu1CWlNWqPTHNPcOIkhMwDZynAe9QGl
 fizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102020; x=1786706820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kyYnI+ZRaDr95i4ZtBJlCVww5qMmd0+uzXfRFC9EajU=;
 b=paSr8k+LfSSGkQkHciypYmj8FVU9fEeWZZKFtgCj2GK5voEvtRCxhn4e0dTzbZUTiA
 AiFHTXhNBGBW0DqB013XRuqG+4Y8X/8gixajNXXt0GLUJSt3KqTG7f7OaVC7NgBhK4uf
 rCPEVqIk79ViM+tEm3hxuNpugWIST39yvq8PZnJGzBoosEL3BdYDwZlaITCqWNL7rT3V
 QkaiP3SVCinfU80bphRkgXf0gs9A1n6fnE2GiHfvoQVaKqWZWWq9qKjkAUQkiJz+7SB+
 SIKscJDQthAJONUNdIZEHUCMY985QzF0hm3PyZ+m3rSFSY18dRkdru1iQPOOm61ZKI1Q
 VnFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI0oUgt8aeuA/dSZBJh3dnv0kMIe9uMTC3yhjiT4SgifhCkoqZsNnRE3QnVDWUBFD1N3r/IXZYgP8hLt8V@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzOYjf3aLPOD8kPuQGYnoxbEpy4q+aNLzNpQSpvb+T5UKfPgb8G
 0L3boFFgjhspiNNkmvtUPcMXTGiIaxukq3+tubb8pbDdObDBEv/23Ye2leQl8JiM/iE//MefgZ5
 ofXuycg2UBsh9rZjgqQsTzgnvtW1j3ug=
X-Gm-Gg: AR+sD10C0fOBPBQUj3PeIRlhi72nJj3uYC4f92XKlO5M+EMFGddq+WbYdwulJGogN/0
 2qYw8vh8yz9FFuogyp+MO/908Fz7t0QYJH/I5B7a4scEOwfnkDUGRpTgaESJC7buMPS8U28TecB
 pkg3wsmG0hKz7qOX8jPBo5WpBoyrSneyUYHLOD9/15UaPzUR155B/Xf2cNLRvIgeoeqxkBl+CON
 QTWUn2LpvZKDsqv/m/DU0Bb06TXellrGtaRMFwHuaodz65DFNUdTKfsYX2Jutjo2XvaB1+Go0nF
 m3QllwDrqj0VjxZjYt8ziAmaj18NhpuH/iFDRhU9ibRqLZ/19lTjcoRu2pdSDfHaBpPGDGTTBKv
 w7THjKJslDocfdECr+K8DlHCiZDj9wLE1zWS3OTlmYSZTR6BI7O3tVex9z0OkR3udTFvsW7oEH8
 GQHdVN6kDJ
X-Received: by 2002:a05:6512:628a:b0:5b1:589b:3579 with SMTP id
 2adb3069b0e04-5b2f4b84a6emr3624482e87.4.1786102020138; Fri, 07 Aug 2026
 04:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <4579e6f6-0d3d-433b-a74f-6e1c8ab629aa@openvpn.com>
 <CAEsd45QZ3wYQ2PUxO+NSJhXcixzrJgzNDZ1p-enUx-BQbXGGzA@mail.gmail.com>
 <anWFk3gQChQuLtC9@greenie.muc.de>
In-Reply-To: <anWFk3gQChQuLtC9@greenie.muc.de>
From: "Jonathan K. Bullard" <jkbullard@gmail.com>
Date: Fri, 7 Aug 2026 07:26:23 -0400
X-Gm-Features: AUfX_mw2TC4n5AEMPtkjd-WUBpwzMBXQVoq3JAgklezkpPYFuBlSkyO_X9nd8VE
Message-ID: <CAEsd45S1TnAAjf-ajtzYGEqy53XdbuFFNqxA2rwExTFtAUPGfg@mail.gmail.com>
To: Gert Doering <gert@greenie.muc.de>
X-Headers-End: 1wsIjD-00012x-1B
Subject: Re: [Openvpn-devel] IRC community meeting summary
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

VGhhbmtzLCBHZXJ0LgoKT24gRnJpLCBBdWcgNywgMjAyNiBhdCAzOjEz4oCvQU0gR2VydCBEb2Vy
aW5nIDxnZXJ0QGdyZWVuaWUubXVjLmRlPiB3cm90ZToKPgo+IEhpLAo+Cj4gT24gVGh1LCBBdWcg
MDYsIDIwMjYgYXQgMDM6Mjk6NDBQTSAtMDQwMCwgSm9uYXRoYW4gSy4gQnVsbGFyZCB3cm90ZToK
PiA+IE9uIFdlZCwgQXVnIDUsIDIwMjYgYXQgMTA6NTc/Pz9BTSBKb2hhbiBEcmFhaXNtYSB2aWEg
T3BlbnZwbi1kZXZlbAo+ID4gPG9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PiB3
cm90ZToKPiA+ID4KPiA+ID4gIFRoZXJlIGFyZSBhbHNvIHNvbWUgc2VjdXJpdHkgZml4ZXMgYmFj
a3BvcnRlZCB0byAyLjUgYnV0IHRoYXQgYnJhbmNoIGRvZXMgbm90IGhhdmUgb2ZmaWNpYWwgcmVs
ZWFzZXMgYW55bW9yZSAob3V0IG9mIHN1cHBvcnQpLgo+ID4KPiA+IEFyZSB0aGUgZGV2cyBwbGFu
bmluZyB0byBiYWNrcG9ydCBhbnkgbW9yZSBvZiB0aGUgcmVjZW50IHNlY3VyaXR5Cj4gPiBmaXhl
cyB0byB0aGUgMi41IGJyYW5jaD8gVGhlcmUncyBvbmx5IG9uZSBjb21taXQgWzFdIG9uIEdpdEh1
YiBzaW5jZQo+ID4gSnVseSAxLCBhbmQgaXQgZG9lc24ndCBhZmZlY3QgIm9wZW52cG4iIGNvZGUs
IG9ubHkgIm9wZW52cG5zZXJ2IiBjb2RlLAo+ID4gc28gaXQncyBub3QgcmVsZXZhbnQgdG8gVHVu
bmVsYmxpY2suIChUaGVyZSBhcmUgbm8gY2hhbmdlcyB0bwo+ID4gQ2hhbmdlcy5yc3QsIGVpdGhl
ci4pCj4KPiBJIGZvcmdvdCBDaGFuZ2VzLnJzdCAoImJlY2F1c2UgZm9yIHRoZSBvdGhlciBicmFu
Y2hlcyB3ZSBvbmx5IHVwZGF0ZSB0aGlzCj4gb24gYW4gYWN0dWFsIHJlbGVhc2UiKS4KPgo+IFRo
ZSBvdGhlciBDVkUgZml4ZWQgaW4gdGhpcyByZWxlYXNlICgiTWFrZSAtLXg1MDktdXNlcm5hbWUt
ZmllbGQgd29yayB3aXRoCj4gTWJlZCBUTFMiKSB3YXMgYSBjb25zZXF1ZW5jZSBvZiBhIDIuNyBj
aGFuZ2UsIGFuZCBkb2VzIG5vdCBhZmZlY3QgMi41IG9yIDIuNi4KPgoKQWgsIG5vdyBJIGdldCBp
dCEgVGhhbmtzLgoKCj4gVGhlIENWRXMgaW4gMi43LjUgKEp1bHkgMXN0KSB0aGF0IGFyZSBhbHNv
IHJlbGV2YW50IHRvIDIuNS8yLjYgY29kZSBzaG91bGQKPiBhbGwgYmUgYmFja3BvcnRlZC4KPgo+
Cj4gPiBJZiB0aGVyZSBhcmUgbW9yZSBiYWNrcG9ydHMgcGxhbm5lZCwgZG9lcyBhbnlvbmUgaGF2
ZSBhbiBpZGVhIG9mIHdoZW4KPiA+IHRoZXkgbWlnaHQgYmUgYXZhaWxhYmxlPwo+ID4KPiA+IChJ
J20gbm90IGFza2luZyBmb3IgbW9yZSBvciBmYXN0ZXIgYmFja3BvcnRzLCBidXQgSSB3b3VsZCBs
aWtlIHRvIGtub3cKPiA+IGlmIGFueSBhcmUgcGxhbm5lZCBhbmQgaWYgc28sIHdoZW4gdGhleSBt
aWdodCBoYXBwZW4uIEFuZCBJIHVuZGVyc3RhbmQKPiA+IHRoYXQgcGxhbnMgY2FuIGNoYW5nZSEp
Cj4KPiBBcmUgeW91IG1pc3Npbmcgc29tZXRoaW5nIHNwZWNpZmljYWxseT8gIEkgbWlnaHQgaGF2
ZSBsb3N0IHRyYWNrIG9mCj4gd2hpY2ggYnJhbmNoIGlzIGFmZmVjdGVkIGJ5IHdoYXQuCj4KCk5v
LCBJIGhhdmVuJ3QgbG9va2VkIGludG8gaXQgaW4gbW9yZSBkZXRhaWw7IEknbSB0cnVzdGluZyB0
aGUgT3BlblZQTiBkZXZzLgoKCj4gVGhhdCBzYWlkLCAyLjUgaXMgaW4gImRlYWQgc29mdHdhcmUg
bWFpbnRlbmFuY2UgbW9kZSIgLSB3ZSBhdHRlbXB0IHRvCj4gYmFja3BvcnQgc2VjdXJpdHkgLyBj
cmFzaCBidWdzLCBvbiBhIGJlc3QgZWZmb3J0IGJhc2lzLiAgVGhlcmUgd2lsbCBub3QKPiBiZSBu
ZXcgMi41LnggcmVsZWFzZXMsIGFuZCB3ZSB2ZXJ5IG11Y2ggZW5jb3VyYWdlIHVzZXJzIHRvIG1p
Z3JhdGUgdG8KPiBhIGN1cnJlbnQgcmVsZWFzZS4KPgo+ICAgaHR0cHM6Ly9jb21tdW5pdHkub3Bl
bnZwbi5uZXQvUGFnZXMvU3VwcG9ydGVkJTIwdmVyc2lvbnMKPgo+IChsb29raW5nIGF0IHRoaXMs
IEkgc2VlIGl0J3Mgb2ZmaWNpYWxseSAidW5zdXBwb3J0ZWQiIGFscmVhZHkgLSBJIHRob3VnaHQK
PiAyLjUgd2FzIHN0aWxsIGluICJnaXQgdHJlZSBvbmx5IiwgYnV0IGV2ZW4gdGhhdCByYW4gb3V0
IGFscmVhZHkpCgpVbmRlcnN0b29kLiBUaGFua3MgYWdhaW4gZm9yIGFsbCB5b3VyIGhlbHAuCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3BlbnZwbi1k
ZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
