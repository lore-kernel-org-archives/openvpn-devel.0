Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70083CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLgEMqnIkQomttCirALTspeUWEgJjZFz5E/5FK5nXjw=; b=XaQH9uODYxbZyttcfLDq/OuaqM
	4xJ7nIr84LkkKz2l9g780kbRJ49fyJD2cGnt1DzyHP7IocJaviSfnPOJTUMzMO8Kn8dcqWJANeZNc
	jftiS/kAm4iKH/Ki1tvE66PAW6TgUy57uuD1q5F8SWZV89SZ3a89kD7JSX8sZNcz+N9U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNebM-0001mO-Mz;
	Thu, 14 May 2026 22:32:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wNebK-0001mI-TE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RpB7QFXKlXRHTkYzw1v9/eZAf9Z21AiEo8rCZTFunsM=; b=S/lFeTOwcqYfENtQk3p6GlC3RV
 Gpa5ltD9HpH3JIs2G721IXyXwh+C+N43zxO4jbDARgkbRo/46xsJwMSYQxwzJaFtFYfN08m695IC1
 wJIGYp0wYbO5c1oc8GnuyGkcW1ddDD0rHQWBFzzeGdVnP8TeQ04yoYZJZ53SQ8ZYnkms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RpB7QFXKlXRHTkYzw1v9/eZAf9Z21AiEo8rCZTFunsM=; b=BmCLHuD1y3sDMhQHkPdEuOEhVJ
 ehqF0iBV/Hu6rrRAqsrDnbx8+l8pzLXt1vnc2tZWJM3mxIZl1YzttQJjmJEL7kO/4Fi40xHJ5/DMc
 5sMNiABGzJPTjluXrhI5tPjP+YnCZIKtZyl5PjhqMrIRDgpDyX+FUa617hnbWsUecOdQ=;
Received: from mail-vk1-f170.google.com ([209.85.221.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNebH-0000xy-KG for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:32:16 +0000
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5752b27958fso2698603e0c.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 15:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778797930; x=1779402730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RpB7QFXKlXRHTkYzw1v9/eZAf9Z21AiEo8rCZTFunsM=;
 b=nU3dxvu2sOzp/UcseDL6QMc8dj2eXxYKWVeD0LrJD6i6iQGY4pL2MwgL58yAX/hzAk
 MdEY4qfdwQG/IW92kmV49xDRGieldpdDejBpp6JK6Z55IuWcoqwNWB7nXmZLQlTEsi7Z
 UexHhm/NLZ84xPhzbE59n/kpkotxYTyjCSSVmbf3+ZNHBQlsADbQrsR0NzTzw/JfBX6a
 j1BZiVbfmZhxdWxeoKRDgPUZlo/QO9oQV4tgAGhWMvNPv+jqhNNn8PPMab/YbzUQG3wA
 fv7Pu1L1xoLLWxsh9NX5hez5H5Eu19UvXEEDMPcUgNhaGjj9SikgfVzUeWxvVDrdTJhK
 Oa9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+80eB/FV/nAS9oafXT0oQzvW68dVt+I1oH9nnrXRfalZCqCBaRe3/JrZA5O9KBu3ydPt29rk4bW3qJUJ9y@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxWcFXim0AJvvlHpQqfnJBgX0lU9ozSGYurt8GW4yNQh8d/hxLK
 vfJhhuLVrDu1+IBPpgWckYfuw0TNySvp/1DKg//li6j60WHdhoiHpKFke3PMxfHA
X-Gm-Gg: Acq92OHppJmfRLO8dhAvTqqAuR7IdJka3yD6UUFGhJqOQRvWdJo7UvV26pZ3lJ/A6Z8
 t/BY5I/UbpcyaakzXd/BbGo7TSAcvUcXDF28rwuk9nhvyMhkCkvxIQbh+6KaWcAo4ljnehFF+83
 XWfgfd9pG4kN7EzRLE1fye3kwfpMIyKeqNnzBCTG9jzNRRaQy6JvSDmfPjh8Jy51MjgbTrD3Ef5
 +KD8ZWudMq/YaYWqxKsy8k9L2jquiyRubAaN7SAfW7ZUcce/zJZCfy6Sr5nt2FtsgWbEZVxBJkO
 qusU7XSYFu/RewbhuLFdE4+nQB3xywDhD2gnw5adhS4OoZlnhviZw1J4ebLV/FCq7d5F5MhFp+m
 VURlrTy2955qgjHEemrI4KNIqIOMq6nDKS6OqofcKGkehMe8HDtGjCDadOUpiQw4K5BzfwXQOYR
 FZ0PWmOU2Sn1hwcd8DlNUnNk8NK6vHZPR7+3PJADoOq2sRINVK8RuOxak80GhV
X-Received: by 2002:a05:6123:128:b0:56b:8e1c:582d with SMTP id
 71dfb90a1353d-5760c09b0f8mr943466e0c.14.1778797930111; 
 Thu, 14 May 2026 15:32:10 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5760f58feacsm261549e0c.1.2026.05.14.15.32.09
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 15:32:09 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-94de664b541so2784835241.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 15:32:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/T9r+gr41fMBOO9cAU688up5yzj3uxa5WOmZ2P2eJjmK3gqEvmX5i1gpwKhi1/8X/aZuyGiJDeG3XoSJXA@lists.sourceforge.net
X-Received: by 2002:a05:6102:4428:b0:633:f2bf:7de4 with SMTP id
 ada2fe7eead31-63a3d42bf6amr848417137.10.1778797929484; Thu, 14 May 2026
 15:32:09 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
From: Piotr Dobrogost <2026@p.dobrogost.net>
Date: Fri, 15 May 2026 00:31:33 +0200
X-Gmail-Original-Message-ID: <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
X-Gm-Features: AVHnY4J8a_Z5Jyc91DbKBxN93kr4PzeEHTWLiRa6jv5kzrgUCmQc956B3w6ZXi8
Message-ID: <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wNebH-0000xy-KG
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

T24gRnJpLCBNYXkgMTUsIDIwMjYgYXQgMTI6MTbigK9BTSBBbnRvbmlvIFF1YXJ0dWxsaSA8YUB1
bnN0YWJsZS5jYz4gd3JvdGU6Cj4KPgo+IEluIHRoaXMgZHVtcCBldmVyeXRoaW5nIHNlZW1zIHRv
IGJlIHdvcmtpbmcgZmluZS4KPiBEaWQgeW91IGF0dGVtcHQgYSBwaW5nIGFmdGVyIHRoZSBWUE4g
Y29ubmVjdGlvbiB3YXMgc3VjY2Vzc2Z1bD8KCkkgZGlkIG5vdCwgYnV0IEkgcmVwZWF0ZWQgdGhl
IHN0ZXBzIG5vdywgYW5kIHBpbmcgZG9lcyBub3Qgd29yay4KQnR3LCBJIGZvdW5kIG91dCBzb21l
b25lIGVsc2UgYSBmZXcgZGF5cyBhZ28gaGFkIHRoZSBzYW1lIHByb2JsZW0gb24KV2luZG93cyBh
bmQgYWRkaW5nIGRpc2FibGUtZGNvIGluIGEgY29uZmlnIGFsc28gZml4ZWQgdGhlIGlzc3VlLgoK
UmVnYXJkcywKUGlvdHIgRG9icm9nb3N0CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
