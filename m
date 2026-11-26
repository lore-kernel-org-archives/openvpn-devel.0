Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A624606A327
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FPgSU0uY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cwSpmXxb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A0makG11;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHfvZF64
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ssrC7i6h9zzvxYQbKcdzwPlxLarI4e5AQuqqZDFnyI4=; b=FPgSU0uYKRcvp+989GtIKFWw71
	7Y9SdC0j3ZCs6ECVjAF8XiEJa7hCXxlyESDHfAtyJDxja6CaxCBEw1BChmWB/gOCuhT80WJ45Oi0x
	GmqnGdoRuFvwFAxUuifhOahJpyL6vc9fNbL7/TadajNY6vUu3WC6jg84Z/Awnb3655Xw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWHU-0000000053o-1CMA;
	Thu, 26 Nov 2026 10:00:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <farshidrezaiyan@gmail.com>)
 id 1xWWHS-0000000053i-423J for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:00:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DpQ/wzHzDWA1gUSkihlBZ0jJx/rPB5TUE1XifIjm8KE=; b=cwSpmXxbPGtz+yslj8tT03bGPm
 brWXPVLqf/Wbwq3y+4i9h//uX8dTIHhSgPlx5ZlVNq65nL6QBlsVQE2QJKuryVLHXKR6hEQqYrH6g
 7irqpyNV1lJwdSqGhYHvflzsCSaAtgvs/UptqiTWyMAtuSbdg3Nt4tO+Yyq1loTBxTL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DpQ/wzHzDWA1gUSkihlBZ0jJx/rPB5TUE1XifIjm8KE=; b=A0makG119zI+50xkSdpfib1Qfa
 vGz4KrcHambNTEBqGYLa9NujkhpYLHho8DzaNeviChW7sTBvjnQXKMA5QhvDE4Q+rYWflHHlyYbw2
 50E9hMr5cHHUHzJX1GiKWMMAWP344RwtI/qVqUNWEYX0RNje6Yb7l1dlTGMhBEJ9YGtg=;
Received: from mail-qv1-f43.google.com ([209.85.219.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWWHR-000000002y0-1UFY for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:00:42 +0000
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-92130d3ee15so63574446d6.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:00:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795687235; cv=none;
 d=google.com; s=arc-20260327;
 b=h3GcpjOnrgJjLVriwdzYpM30gvIy5u17trc6HZF6g18e+oTZcZdG+3HpN5Tzj6ezYf
 BQm1Gf0RFaVekC8Knvf7s+q4VO4ghCp7U7ZMVGV8+WPjBCIBV0IUcNEzSHJdPwr854Zx
 noQTN9aqMVKAFlXwBiGRKLpGk5Amn7fKEwPyP5nphhTKH6rJ+j0zm/tENxReTelVDDsg
 6gsxpxs4uqws38uArJk9OD0Tq8fIz8ePqg65MCOiGtS6EFbNqS/0tHfKqm7c+x1Eh2Gm
 FjKVl/zTxTN71RwIRd6H6Ny9BT/h0Izh3WiaaJNRXlcSDVAjTC1VGeQsqXEKOPe7GJ77
 WjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DpQ/wzHzDWA1gUSkihlBZ0jJx/rPB5TUE1XifIjm8KE=;
 fh=gICqYLyTjUHOXPqKVVQaaaS53Er+PlXogQsKB/UqCLg=;
 b=dT8kFnGAMjxwUZDy8RetJIJLeVA3oLU3ceqezykL9T0aDuAHoi/5ZD4Cg8/NWJFmJy
 wgRJAKGGvbOk/p8SwW/2TgHQoIFYPUB3yzQ6mKSeQSeS23B3s8zKT0QWJxvre9jfTyyM
 CClXtf7h5GjGPG/+r/uQBg9+atKiw1iFDu4E+ohBpApaZq6ydMsZ7w4s6XMYZgD2uErD
 UQA/ZvlNGAAJClF2Pp27ZNCtP+z1YICNCr1EN71J0Wl1mV8TcU6OnM+8al5dZQZiiirL
 3tVYaXkLf59bpRrPhBAgzBwOmlJGIiNv577h6yqpe+K1uRgBczEKTi6wcoZr16ZfDFFI
 Lxeg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795687235; x=1796292035; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DpQ/wzHzDWA1gUSkihlBZ0jJx/rPB5TUE1XifIjm8KE=;
 b=yHfvZF64B9B139EVFtPlLO/ycUXn3jUHgIfUpe2UzjDZSyTizzNu1TjhfxeG+jtbQE
 bOp7jmC6IRxN36CGIZPzuH2zcUvaYOxovQwGiWWB3zzn+LFaXl/5fOF2BKj2bqj/mtPV
 cZcmspRVaq/tpIyZAxn9/Dcq32lfLC2hUsOhekZIJ3iRU9kb7l4bYo3/u3hndmWpKVz2
 AnM8HI+JiOsL9cpRPsDBj5wtTHwDjp+Wg+3aPHYh6kQCXU6wpwG9GATsBy3Pb4mxDUap
 IumTKY8Rlru4ZTuLnpvP8UW4BoaKWeOdeHYJxOj0nslTfQ/2XsDGXDbwRtgmuLZDjqz2
 9nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687235; x=1796292035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DpQ/wzHzDWA1gUSkihlBZ0jJx/rPB5TUE1XifIjm8KE=;
 b=NKHz6p1UePTaAbSueaxSbvKcIvu72cd6svag2UgP1xmK6dyoZz2tXbn8s6LYLbD5SQ
 4ozqyv16HNoeF9NQTjH5TP7m2dghoO2a79oOwrN/ABgtFgj9V3M1++xP6697FtdU2+wf
 H1i1YhtQTrjeqtMUVepvGxTV6+AHXn3W4nsl9D1BvbK8tfeJSAMvEjQhwMKPwlEJk1un
 iMTI1NfCXIvlNxBOYGwjS6gfVi6Es1Nm+EMrkh7l0OOHDjpcFmyw36KptoTXKsDn5XF6
 TL7CpPEKnsJhQXaqNc40Vt6UGij273BrDph+6TUN+BdTcEgIQJflvqt+OCxxty7eBMbC
 hZmQ==
X-Gm-Message-State: APuU4Z/PC6zrV62ZT4YPAegicDM2kbhcnXvLljBlcZRtFpWwc5gXKNoY
 ymv36o4936FTjeXMsmDiwVa6cbvOs3rDw+650Mvuf2kV/9YMZ/ZceMHj63PBjnd7aIC2Nn6BiUL
 JIWejDW/ydLr8df0snempQgmdZVU0YKVn2r0xRLq2Yw==
X-Gm-Gg: AZFdTZdKkZSf3Q45afIVWPWqXwSuvWXxLMCU2IfgvW2M7Mf8ECHA79A1UtevZdN35Il
 i6ux+k3f6AihgkDdCT5KJnXdIy33EVJWGn+JLLSGtZpjOBeTGDfK/DEO0javwIaO/WOvXCp/kEB
 HAtdqVWu5OnRFHR1WGtcM+00OKKf+ybf6a2LzoDSQ44bldp9to39fQbxmo2ngbfOw3szP+jCkzZ
 7kgQQPZUYfKwcZUDuzi/v1Yqw1A5O//z07cN6Xuq5EuN0AAN/H65me2O2tC0rg+f2TK//4WMpXm
 dPCBPa1aH7q83RnpHRs4ho4dAA8aJiv4whDQ6LiUC8gPqRscXuKgY7qXZIJzRhnb/TOldYjk68d
 EB57fUSa6dLSCEJ3mAABmioNDC6bjdnNhGQJHIWTXMhrRtNrEn/O34ZRJ3LML+7QqrFZT76cnVU
 eRu0Kwvw==
X-Received: by 2002:a05:6214:2686:b0:921:7a02:7a53 with SMTP id
 6a1803df08f44-9217a027bc0mr87229366d6.36.1795687234964; Thu, 26 Nov 2026
 02:00:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADJo8AbsiVxntM2bXe+RsjA756MvwiTqw9FLa7d5KT1q0YT3+g@mail.gmail.com>
 <20261126092547.132254-1-ralf@mandelbit.com>
In-Reply-To: <20261126092547.132254-1-ralf@mandelbit.com>
From: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
Date: Thu, 26 Nov 2026 13:30:23 +0330
X-Gm-Features: Aa3M54oaHnBIEk5f5qZFv1CXRz80QChJwAfDqO-FhmPiVhPw3YcXyYUiACsHy2M
Message-ID: <CADJo8AZYsktGpACy5xZEsXm9OSZ1Y0xqBrAKw0WS348z+DgTeQ@mail.gmail.com>
To: Ralf Lici <ralf@mandelbit.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWWHR-000000002y0-1UFY
Subject: Re: [Openvpn-devel] [PATCH] multi: call client-disconnect handlers
 when late client setup fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUmFsZiwKCkRvbmUsIHRoZSBwYXRjaCBpcyBub3cgb24gR2Vycml0OgpodHRwczovL2dlcnJp
dC5vcGVudnBuLm5ldC9jL29wZW52cG4vKy8yMzUwCgpJdCBpcyB0aGUgc2FtZSBjaGFuZ2UgYXMg
dGhlIG1haWxlZCB2ZXJzaW9uLCByZWJhc2VkIG9uIGN1cnJlbnQgbWFzdGVyCmFuZCB3aXRoIGEg
Q2hhbmdlLUlkLiBJIGFkZGVkIHlvdSBhcyBhIHJldmlld2VyLiBUaGUgbWFpbGVkIHZlcnNpb24g
Y2FuCmJlIGRyb3BwZWQuCgpUaGFua3MsCkZhcnNoaWQKCk9uIFRodSwgTm92IDI2LCAyMDI2IGF0
IDEyOjU14oCvUE0gUmFsZiBMaWNpIDxyYWxmQG1hbmRlbGJpdC5jb20+IHdyb3RlOgo+Cj4gSGkg
RmFyc2hpZCwKPgo+IFdvdWxkIHlvdSBtaW5kIHVwbG9hZGluZyB0aGUgcGF0Y2ggdG8gR2Vycml0
IFsxXSBpbnN0ZWFkPyBJdCdzIG91cgo+IHByZWZlcnJlZCB3b3JrZmxvdyBmb3IgcmV2aWV3Lgo+
Cj4gTG9nZ2luZyBpbiBzaG91bGQgYmUgc3RyYWlnaHRmb3J3YXJkIHdpdGggeW91ciBHaXRIdWIg
YWNjb3VudC4gV2hlbiB5b3UKPiBwdXNoIG1ha2Ugc3VyZSB0byBpbmNsdWRlIHRoZSBDaGFuZ2Ut
SWQgdGFnIFsyXS4KPgo+IFRoYW5rcyEKPgo+IFsxXSBodHRwczovL2dlcnJpdC5vcGVudnBuLm5l
dC8KPiBbMl0gaHR0cHM6Ly9nZXJyaXQtcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20vRG9jdW1lbnRh
dGlvbi91c2VyLWNoYW5nZWlkLmh0bWwKPgo+IC0tCj4gUmFsZiBMaWNpCj4gTWFuZGVsYml0IFNy
bAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52
cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2
ZWwK
