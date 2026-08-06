Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00714C5AC67
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASkyuT2aaIw01VZ9maxjCoBjOy83TyN45rQBpu2Q7Jw=; b=BvXqH2rR602zyOUr0kVcLP0uyq
	s5y8PLNaSkIpk0rbHBCAnB/ouDvEsDIRhxm8YSeB6CpAKuAH9kLKAak5jYLPQh2l9l9ctdfSaU8Lr
	emBvLvNxknLoHBjwcLW1cSeJ9vEFWvpPa18YS4ERP4jJjkTm61fn99esN3BwChJ174Es=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws3nf-00046c-3J;
	Thu, 06 Aug 2026 19:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jkbullard@gmail.com>) id 1ws3nQ-00046N-Vd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 19:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TbmsCZjiWuME36jbIOwr/BKunKQAiOgfFrjX1GB1l/o=; b=D8+r9Eeop97+8hH/rLoalljv4N
 AaBFtC0sDkzFIjyZdP+5RAxoL5+pwxlFEe70Gh0Q4VTtUI1jKz2D/5OZFXNdrTTs4T0fd4fPpDNjF
 34CVEN25M2tASOpGZ6LHIpa1idYFBZlnGBdXXJ1fx1X5JBkA/3a3Ph2+XN6zzTs5AhJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TbmsCZjiWuME36jbIOwr/BKunKQAiOgfFrjX1GB1l/o=; b=euVfcMKuq4VwGJxX3LQYsbempt
 RuUbX54Q9r5Zu2yv/gUzR/3hLa0y6mqEyYc4m6Jw7MoJ2GR++uWKf6eJK3TtdUW+S9P1kXwqRhh6V
 k3g1DhMI380RPzQBT0Xjm8IjGDODkEsYU1iT23MZOW11bHqN1K7tyud8EZDNeiP27wx4=;
Received: from mail-lj1-f177.google.com ([209.85.208.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ws3nN-0004Na-D6 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 19:30:25 +0000
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-39c8dbf4f38so24359041fa.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 12:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786044618; cv=none;
 d=google.com; s=arc-20260327;
 b=HF4Hrc+a4nNOnrmBrYokoqTtGLTcdHmPRhqU+NL4suilZGxCcB9y+OvEj5Nkib9bH0
 AFpYERZf13CsnV+7RJUiK940bw0hUr0B18wVsJqy+CAR9xIn7E+fWn1H3c6ygxS3TDuu
 xubXo9fVs4eoi02TfucSUXceLIvdBAoOD0rHBSm3/LCu5CvkccTNdw9DCyu5JB+n/uwk
 Ewi/3dvUIp0XuxGFc39ts/6MxbFt5F49VJOahswUDdiuWHg0XbDBM2m4TDLYo1hPNAIh
 PUUBtZkVgZQnhuFMAjRxB0QA4JpV9ETHGs48xDEhg0AEtVF5zJJbOSbL204+FCGAdjB5
 OaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TbmsCZjiWuME36jbIOwr/BKunKQAiOgfFrjX1GB1l/o=;
 fh=e7WtX+/0WlcL03MiXXSk/zdf2qelQFYWrtwZZmNxLIk=;
 b=kcIn4GTFdcmBDFm6MBBRgpMHrBn9BeZYlVqnd//M5DThbTgHu/KBVFWGBQ0HAsLt/e
 GlSQZEqvvpSFn+eA2D14FmPeaMPHB2rBly58WpcP5FY3fuY46nm8xpVZLELobR9sVEYM
 4FsngKLeFA/SFoCWwYrt2Z77BdUuZNK6Oomo5EZjOvCHsCwZz9Haf4rvpWOw9S7PYsWx
 l6B0H7ky4qsXZ9yx9btnpDjKLoU9FjJ2fEOmJ4qQERIolxN2qLIcuFkclPOn7NEYHx5c
 BeCMT+4fqhZxkhEKdvZyWWvU5ZIGmQH/AJlUdMdGpIg9a5tEXrs/Tw/vNCD6MVe/dm/C
 nO1A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786044618; x=1786649418; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TbmsCZjiWuME36jbIOwr/BKunKQAiOgfFrjX1GB1l/o=;
 b=e40UFUoEtxMP0f4BwE2AGj97WdgenDzLgSGQ3Jro7mWu6JrMKLDhHdH1E+792CLXBY
 aUQMkK+l+mIFk4r4ImlyHyaDznaYfjFppokmRRuxVgyUP8HRk3VNGKepBsmZl25eSGwJ
 zF6Avtnge77qJbCCzofDsyZF6cg1viLkWOgqP4WX/zAFIVxKQ4gQfDG0srrPQuc8dAq3
 6qtcRAc7c8rxRYCqZZ3CYnsltSQSLULVxDQoQmJ1GD0e4gGnNiJ4t5hjDP9DU9a0xtl2
 IWDiFNFlizokrXTFCZwxgr8aq+o6a1S4loxeH9a9iOfdq8SZChHuhtzH86C9hiUHEXUh
 KOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786044618; x=1786649418;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TbmsCZjiWuME36jbIOwr/BKunKQAiOgfFrjX1GB1l/o=;
 b=QLixEryMFAtcIzgUZ8nklrqSMlq3+LiNVGdlpVdcUs9ynOG0YiGfZPs45OBUkRO2+m
 AUPAxQHKQmogPKB01Vex4avog400R14OMNO0fmN714V7oorGYRuDWGmIN/kpoLr8JSYv
 /8geA+KAMPs5SNWTvjHOVfllv7S+O7jdOuASXWfW/gTL0lMekf/+E3/Qyurkgta3LuWp
 5bzpXmI01Jys+t7f+/0tbgAWUkWD7PcoIAhESc+T+sJqIRISiSxfZ48vRXurk78FgtAf
 JR8MBTkFzvgWjo5xCCvfV5TVk/nV8tTbJ5LX7kfnoKPIYcFFlPtO8PuIKP78IDvsLUD7
 zleA==
X-Gm-Message-State: AOJu0YzkKytHMjG7k6myqEIYU9ij8V1/HljCYhvIhdGJkT4PVEy82mPy
 2hKASNNVwIPdCvEDEkkkCAWKKkcIoAlVWZjeeJ5tQwm1vQlVgTQyG6PG1K1dC3Istgvf06g4rF8
 CW5QfnrClazBdZTX8F16Yxz9/qQbCRH8=
X-Gm-Gg: AR+sD12DtqjdNdvbBOb46M+crzMArbN6er/SEuP1zCucly4ylyzaq0Jb3/V4MWsumWt
 hHHe5pbTJ2Eb4JXYp2mY4b7pA3LbXb3ezNi8ZDa6ZcBNQ/PYusqui8/FVg6uiaHO+vw6vOnIuRP
 oUkD+OMu1+FTRrs/mpISRFf65byjiESIJfOdLL0amxuebgprqcUWUaxvIhkrmL0pWhyFu1hTTPm
 jiPDPGV2UR/j5iD3DRt+0FC9rG+AQIxrS9blzCKh726huxkEWClduOp3CYr7hK4Z7G8dEL6fFB2
 P8uJy2s0TX5jw7b5aJQUicJiABW+GQKt1i4QIpmfoH7uErrajoEWClkRpUKuPC+UyZs4hc+Nk5V
 RLwE8obX0TWTkbXaBk37WRSZDE1cNbP16mld3+ALBhj/mkIffFEwwrFik0ztnKa4NJsaqqtwJVn
 NnJoEBgHY=
X-Received: by 2002:a2e:be8c:0:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-39fbae1baedmr20523581fa.2.1786044617943; Thu, 06 Aug 2026
 12:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <4579e6f6-0d3d-433b-a74f-6e1c8ab629aa@openvpn.com>
In-Reply-To: <4579e6f6-0d3d-433b-a74f-6e1c8ab629aa@openvpn.com>
From: "Jonathan K. Bullard" <jkbullard@gmail.com>
Date: Thu, 6 Aug 2026 15:29:40 -0400
X-Gm-Features: AUfX_mwWH7UW6QjyUIQPQL_OukqNnEH90IHvGD-W7AiybeEKWWQdXOJVQt99Dbo
Message-ID: <CAEsd45QZ3wYQ2PUxO+NSJhXcixzrJgzNDZ1p-enUx-BQbXGGzA@mail.gmail.com>
To: Johan Draaisma <johan@openvpn.com>
X-Headers-End: 1ws3nN-0004Na-D6
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

SGksIGV2ZXJ5b25lIQoKVGhhbmtzLCBhcyBhbHdheXMsIGZvciB0aGUgdXBkYXRlLgoKT24gV2Vk
LCBBdWcgNSwgMjAyNiBhdCAxMDo1N+KAr0FNIEpvaGFuIERyYWFpc21hIHZpYSBPcGVudnBuLWRl
dmVsCjxvcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4gd3JvdGU6Cj4KPiAgVGhl
cmUgYXJlIGFsc28gc29tZSBzZWN1cml0eSBmaXhlcyBiYWNrcG9ydGVkIHRvIDIuNSBidXQgdGhh
dCBicmFuY2ggZG9lcyBub3QgaGF2ZSBvZmZpY2lhbCByZWxlYXNlcyBhbnltb3JlIChvdXQgb2Yg
c3VwcG9ydCkuCgpBcmUgdGhlIGRldnMgcGxhbm5pbmcgdG8gYmFja3BvcnQgYW55IG1vcmUgb2Yg
dGhlIHJlY2VudCBzZWN1cml0eQpmaXhlcyB0byB0aGUgMi41IGJyYW5jaD8gVGhlcmUncyBvbmx5
IG9uZSBjb21taXQgWzFdIG9uIEdpdEh1YiBzaW5jZQpKdWx5IDEsIGFuZCBpdCBkb2Vzbid0IGFm
ZmVjdCAib3BlbnZwbiIgY29kZSwgb25seSAib3BlbnZwbnNlcnYiIGNvZGUsCnNvIGl0J3Mgbm90
IHJlbGV2YW50IHRvIFR1bm5lbGJsaWNrLiAoVGhlcmUgYXJlIG5vIGNoYW5nZXMgdG8KQ2hhbmdl
cy5yc3QsIGVpdGhlci4pCgpJZiB0aGVyZSBhcmUgbW9yZSBiYWNrcG9ydHMgcGxhbm5lZCwgZG9l
cyBhbnlvbmUgaGF2ZSBhbiBpZGVhIG9mIHdoZW4KdGhleSBtaWdodCBiZSBhdmFpbGFibGU/Cgoo
SSdtIG5vdCBhc2tpbmcgZm9yIG1vcmUgb3IgZmFzdGVyIGJhY2twb3J0cywgYnV0IEkgd291bGQg
bGlrZSB0byBrbm93CmlmIGFueSBhcmUgcGxhbm5lZCBhbmQgaWYgc28sIHdoZW4gdGhleSBtaWdo
dCBoYXBwZW4uIEFuZCBJIHVuZGVyc3RhbmQKdGhhdCBwbGFucyBjYW4gY2hhbmdlISkKCkJlc3Qg
cmVnYXJkcywKCkpvbiBCdWxsYXJkClR1bm5lbGJsaWNrCgpbMV0gQ29tbWl0IDY4ZTE4ZTUgImlu
dGVyYWN0aXZlOiBmb3JiaWQgIi0tc2V0ZW52IG9wdCIgaW4gc3RhcnR1cApkYXRhIiBtYWRlIG9u
IEF1Z3VzdCAzLCAyMDI2IGF0IDk6MTMgQU0gRURUCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZw
bi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
