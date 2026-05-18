Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2163ACD4F4A
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/JeWr8F1TIgTMo6fNhSpufsglWLNRX1mVYdG54fcJB4=; b=DBa5HnxEK98aTD/fAfRtTuA7qy
	cQy9GZGiSy6FpLy9ccmfy+yON7PpHXyWvu05ux0U2bUoeX7hCF9mZPOgbVL2DePM59ZIejMXD4s2P
	Plavx5lVIEfklbWd0WUVmLi7gcb81lbbW7N8IpDhez6j24VpFxuYV36M6nPO4lQ4ARq8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOyVC-0001Tv-S9;
	Mon, 18 May 2026 13:59:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wOyVB-0001To-4H
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=85XvOa6mN0siZqUBmsxTMU1WgzccmwfGdfwP22g/ycE=; b=bblOlRAkOY40lyEltsnEK/2IIc
 E1LjzDlkhcoQQsy5Eu4NjMH26bb/rSP8uawKbmKZc3IIzBeM2fXnyKpR+Dz16IqaqsNb3Bh6WMWgT
 dtHsrZVASHges2tOCXRs5YqfKtOLJ5BxKWYQQrTa8lfZ1UpcmOmxacUKAVVx5NisQ15Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=85XvOa6mN0siZqUBmsxTMU1WgzccmwfGdfwP22g/ycE=; b=cE/p2rmwxTdI0CrR2suEdMsqe1
 JkCKUUKeayI4qvC6uWUaaGrNDHpKdWZpWuFFue5OQCBqJGsT75gOv+ZcO+WsI/jDZkNBtVeGzjzfi
 PPYkpMcuiCHMcHvCyQHBcA/RicnuyGMzFInrIP7Ny63t7iTEn4RGdy4hNMQ5J74hpS3w=;
Received: from mail-ua1-f50.google.com ([209.85.222.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOyV6-0001zk-OZ for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:59:22 +0000
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-95d0476492bso1539704241.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 06:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112750; x=1779717550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85XvOa6mN0siZqUBmsxTMU1WgzccmwfGdfwP22g/ycE=;
 b=sHLMi4cS++NdBPRh1hTCBI8TtTE0lXNkujNgpiyiMT/Z3anyTdx4sXgeCyhKoSdUc4
 DFRsdQfOZ7wIsnmjMUUkavTUnB6rjMBckCcMJh0c1OdFG602Zltx3c0wx5HEiLJp0fqT
 716NNU0E/EpXKnqE1btWtjWKNd0avu7Yg3aENb8ik1Mp1EalG6Ky8awLtUl8A7MBVfJc
 CJqZxsJZsycE6/Ub1bV+5faUkQIEQ0NAJtk/jlKIhUWgGKN6ZEUGKIdP0ZVBXpmS+r2x
 QhZH/Iid7l4qKNTr7mTERkCrWkwILvgwogjdTes0bgoaZbPo0pN6RDX/mbTeTxsu2mbe
 OOoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zIx+pMARhNYbW4d5Xzxkc8Idp3wwV6Hx6zagMeC/qr93gfVx3a1b7hPNe5MbzBHjSMfAuM23so5MyPUFI@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw8BKVSgfdjs0rLjRyq0OxIzptksNgaepyk12YbLPeyf84aQTv2
 5R6kiRpp6asyby15hP+0end82KqZb6xCUcFfF98+bCXoxstg7jGHx1XUMaiTDA==
X-Gm-Gg: Acq92OHdWd/MBL3RdD6Mjx8WjOVfwOMtkL4ouZ7jlY8ym1v3yXXyBj2ifDhZjCiIsaA
 A5zJSjmY/JYhK6J4OPn+a68couRHRXJroA9rN4rCm6LmqCa5ul6tsNS4imvd9tJ/PL+GOwTSJWK
 wRFw40F6/xQ5AMB/lFT3cS1CxEMTEqgC8rDCNj+QwhZk+su8qzNJsFt1V6VW+s22V6+iJIO5Kr2
 B8Lku6Q7rP4JCuWT7gmCNs7YbnAiPXAoI/PMZRGhIqkpbJPFN+b69WsJkRf9W9vEtjOckHIODF5
 22fhQQMm51G5WSR2Aq3EhG0RDSQUQtft7JSIrY5yhniKj0yIDAYwyX0YAHqkvJ2QI9oZKK8vsPF
 K9hKQedozTONQRjOCV24parRfi5+peYTHKSMl/gERCxgpE1nbQmulQmcXNGHwOcjy65JkrZZw/f
 /XXJUhaPtQaQBS9UqD9bWLN6Fn1J8eAC/0HuN9TwDp4rk2s3cP5HnYpBdeRHxd
X-Received: by 2002:a05:6102:c92:b0:631:487a:239c with SMTP id
 ada2fe7eead31-63a3cc15f71mr7978110137.6.1779112750281; 
 Mon, 18 May 2026 06:59:10 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com.
 [209.85.222.50]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc2d278a8sm4598379241.6.2026.05.18.06.59.09
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 06:59:09 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-95d0476492bso1539693241.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 06:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/bf1T4/dFXPRo8Oc8azGMFjU/0vPQuDCR6jH4q5qUyzBRntZFSWEyw0ETrrH6OakUhjdunrbel7lNtkkBl@lists.sourceforge.net
X-Received: by 2002:a05:6102:5493:b0:631:37cb:1e64 with SMTP id
 ada2fe7eead31-63a3cd147f1mr7909330137.4.1779112749432; Mon, 18 May 2026
 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
 <aga71mZ3jRgl0TEA@greenie.muc.de>
 <CAA6tFMuzF31kpzB5j7pRTh6nC2RRSwBkTEiFLGu3XGOvYgb7mw@mail.gmail.com>
 <agjUFRBdLyfZvlWN@greenie.muc.de>
 <e519fd93-d75f-4422-b7b2-8860b510595a@unstable.cc>
In-Reply-To: <e519fd93-d75f-4422-b7b2-8860b510595a@unstable.cc>
From: Piotr Dobrogost <2026@p.dobrogost.net>
Date: Mon, 18 May 2026 15:58:33 +0200
X-Gmail-Original-Message-ID: <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
X-Gm-Features: AVHnY4L8SqnMbAbX6ulrAlBy-nN8We5HJa2hhAA02ubxvp6wc0oXJVX2X-8KInQ
Message-ID: <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wOyV6-0001zk-OZ
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

T24gTW9uLCBNYXkgMTgsIDIwMjYgYXQgOToyMuKAr0FNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVu
c3RhYmxlLmNjPiB3cm90ZToKPgo+IFBpb3RyLCBub3Qgc3VyZSBJIGFza2VkIGJlZm9yZTogY291
bGQgeW91IGNoZWNrIHRoZSBzdGF0cyB3aXRoICdpcCAtcwo+IGxpbmsgb3Zwbi1zZngnID8KCkkg
d2lsbCwgYnV0IGluIHRoZSBtZWFudGltZSwgSSB3YW50ZWQgdG8gYXNrIGEgcXVlc3Rpb246IGlz
IGRjbyBvbiB0aGUKc2VydmVyIGFuZCBjbGllbnQgdG90YWxseSBpbmRlcGVuZGVudCBpbiB0aGUg
c2Vuc2UgdGhhdCBpdCBjYW4gYmUKdHVybmVkIG9uIG9ubHkgb24gb25lIHNpZGUgYW5kIG5vdCBv
biB0aGUgb3RoZXIgc2lkZSwgYW5kIGl0IHdvdWxkCndvcmsgb24gdGhlIHNpZGUgd2hlcmUgaXQn
cyB0dXJuZWQgb24/ClJlYWRpbmcgdGhlIGFuc3dlciB0byB0aGUgcXVlc3Rpb24gIkRvIGJvdGgg
dGhlIGNsaWVudCBhbmQgc2VydmVyIG5lZWQKdG8gc3VwcG9ydCBEQ08/IiBhdApodHRwczovL2Js
b2cub3BlbnZwbi5uZXQvb3BlbnZwbi1kYXRhLWNoYW5uZWwtb2ZmbG9hZC1kY28tdGhlLWRlZmlu
aXRpdmUtZ3VpZGUtdG8tdGhlLXBlcmZvcm1hbmNlLWJvb3N0LW1ha2luZy1vcGVudnBuLXRoZS1m
YXN0ZXN0LXZwbi1wcm90b2NvbApJIHdvdWxkIHRoaW5rIHNvLCBidXQgbWF5YmUgSSdtIHdyb25n
LCBhbmQgdGhlIHJlYXNvbiBpdCBkb2VzIG5vdCB3b3JrCmlzIHNpbXBseSB0aGF0IGl0J3MgdHVy
bmVkIG9mZiBvbiB0aGUgc2VydmVyIHNpZGU/CgoKUmVnYXJkcywKUGlvdHIKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpPcGVudnBuLWRldmVsIG1haWxp
bmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVudnBuLWRldmVsCg==
