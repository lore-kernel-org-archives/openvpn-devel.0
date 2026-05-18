Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C8CD343F
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ais881khiXp1pxlkaCsNyQ6X+cKPt+6uqzmlLiCT0+o=; b=Q/EY1vW4CiHxC545OHd/zwnQ/w
	LIKPxFMU3jSCPQc85vAcMQD3iOBrw3Q3MhHRx9ADx4ti5bJ9oj8yfwkJ2B4yORAPO7B43WtpQnXDW
	n2y2H8j6mZdG/d/fIJ3VzE4sZH80sM0miVmwjzj5512WdU3td0GptfmpX1uWEjtuNJz8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wP3kj-0007qU-NB;
	Mon, 18 May 2026 19:35:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wP3kM-0007o1-My
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5t8cIyONSv3Z5jkMm72sya4K8O8rqVpDoE6AorT+HwU=; b=lZ7FS1fgtQXAQnpq6iRHBJV56e
 pAg5RVHe8iCd8P7hr5+7XfWLyuMS+4LTRiwzjiGF8KQ+pC2uENZTTQ9elRmMFy48Kj5iHyG5VTank
 ishE6B1HvhD+A5rbzFwWj6ZoVOr7cCw3cr6RDjHfQIGOoaUamqBjJBmsI+L+C/wj8vP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5t8cIyONSv3Z5jkMm72sya4K8O8rqVpDoE6AorT+HwU=; b=FBOHItlAx3bXw3cEpJ85sslFXT
 jiW9hxtL9jJhU7PVNxYQnGpg2l6sDnd1+huSJ12RV6PIfxSK/LdmbAgMNXXltKc8R6uRSe6TFufHg
 6O2qtLKZVJ06E9fk4rYM0qwVrudfJp30aRj+TMCdEXclDMwpk5qU/Z4m5yz0o3N8JKk0=;
Received: from mail-vs1-f51.google.com ([209.85.217.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wP3k7-0001tr-LQ for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:35:12 +0000
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-636970cf66cso2022596137.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 12:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132901; x=1779737701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5t8cIyONSv3Z5jkMm72sya4K8O8rqVpDoE6AorT+HwU=;
 b=qsc4AU+sqhnliRxaBwuv7+BarNSQ+vZE5Wrh/TKcEe4xATsMsKnfd+b2hT64CVHzXh
 ZyJPHA8v3s6SPwcoqP0/figICTZ9owl64Tvd3s0l8l8kSwp6l4c12HkTDKszbtO6O28L
 TRJmh5WhbET3tbg3MiqGQKhuiMQNPa+D8FFWOnnPjOF8smyrAOAc+phoswpRfNPk9RJH
 PLbbTg7KEtrwNFMMzEy94+Vrj/LvuyuR8zGYYT2jL0QPY0yWwyUxvEMwylIuz3R91UNN
 GW/LcHJ+hgr/U9Q4YAJ51F4U3Y47s8XEXkBchT9AtXgcbFV1g117tWu92PifOPW9lU+C
 SzbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qlSwunWPWGCqx7reS1Pi/OvCJbhNL9oZMXOvChatkTCz1jQEgPSCXFWMI4dVNv1lK4qg8Jp6ib1lJjRQv@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwI5EonIxXzlyewuii+pCceGZpnADij2WHK1nXmvrLNesyH3794
 eU4ave5VPfrEvcGtXyz0/H1mhGS+TBnWnpj/VNLQPWImj4tRm2xuPlZq0rq4heuk
X-Gm-Gg: Acq92OG5JVWx5hfj+bvrVg7xt3gCAIKNyTpxZPn8hUpQwqc83hMFVSSc3YuEFBpGwsO
 1+G8Fbu1Hy5G1cGfstJ/gek4Ufb8kXdtnozMZC6o/OqSX3IJt7DsTQgSLtloy7Mcj2bMhDmvemV
 UR6Ma10o641NzKTI9qtYAhmGQsEhYcViKXqXTdGaaSR8ejWZEru0E48VHesIrw9/ojo3uV5CURn
 Iw5VaWh8ZR/XSaygyNbhSGrACVkgn1B0WnLjSBw9mwczc7Hbrh0xCluSWrK9D9MYK8uDJSJY68X
 bTbN6m8l5l3xKpa3d68tpPc81Hg2xjyLZqvUhTjrBybujapNVmCfMhiFyDujHU/gxMAqYsQicKE
 6eIroJqNjE3/xbfnkZbqXkFfUxzrecsYZnkANC8gT76yKwS7s/59ZTCFkSbdbMZFFHB7reb+NjN
 46sGS25PpPg60i87Jy0FV34HBeV59hduNjkc0a7tRKSsZTbs4K+44Pl4OEEj1k
X-Received: by 2002:a05:6102:6c6:b0:611:959c:86b with SMTP id
 ada2fe7eead31-638b7acd7b3mr9207256137.16.1779132901147; 
 Mon, 18 May 2026 12:35:01 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc2cc387esm5324006241.4.2026.05.18.12.35.00
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 12:35:00 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-63201e0d6b8so2841500137.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 12:35:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8YvTzcD3EV6bFicgdedh9u3vWOu1biQYNbjaYPUIy7V8C3iAEjcncZgJ8UsbZ3VBPy63HMxENVEgjXEA5n@lists.sourceforge.net
X-Received: by 2002:a05:6102:6:b0:65a:fec7:137b with SMTP id
 ada2fe7eead31-65afec72d9emr987382137.0.1779132900682; Mon, 18 May 2026
 12:35:00 -0700 (PDT)
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
Date: Mon, 18 May 2026 21:34:23 +0200
X-Gmail-Original-Message-ID: <CAA6tFMskhqjXx4-vL4zYSjG-koB=a5_koysHKNLh5tDe+QtkvQ@mail.gmail.com>
X-Gm-Features: AVHnY4IHbFOCibkVsB7HSMFl912qK0lZPgn2swwek6fWyeY58yL3c4h7QO5_7GY
Message-ID: <CAA6tFMskhqjXx4-vL4zYSjG-koB=a5_koysHKNLh5tDe+QtkvQ@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wP3k7-0001tr-LQ
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
bGQgeW91IGNoZWNrIHRoZSBzdGF0cyB3aXRoICdpcCAtcwo+IGxpbmsgb3Zwbi1zZngnID8KCltt
aW5lckBob3N0eF1+JSBpcCAtcyBsaW5rIHNob3cgZGV2IG92cG4tc2Z4CgoxMDogb3Zwbi1zZng6
IDxQT0lOVE9QT0lOVCxOT0FSUCxVUCxMT1dFUl9VUD4gbXR1IDE1MDAgcWRpc2Mgbm9xdWV1ZQpz
dGF0ZSBVUCBtb2RlIERFRkFVTFQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDAKICAgbGluay9ub25l
CiAgIFJYOiAgYnl0ZXMgcGFja2V0cyBlcnJvcnMgZHJvcHBlZCAgbWlzc2VkICAgbWNhc3QKICAg
ICAgICAgICAgMCAgICAgICAwICAgICAgMCAgICAgIDYzICAgICAgIDAgICAgICAgMAogICBUWDog
IGJ5dGVzIHBhY2tldHMgZXJyb3JzIGRyb3BwZWQgY2FycmllciBjb2xsc25zCiAgICAgICAgMjQ3
NDQgICAgIDEyMCAgICAgIDAgICAgICAgMyAgICAgICAwICAgICAgIDAKCgpSZWdhcmRzLApQaW90
cgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52
cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2
ZWwK
