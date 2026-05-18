Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD08CD4F4A
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVfyg5HzkYSbKRDn1jW7bnulyBcr2+KsXgPJ9c0O1vk=; b=l0Ykw/W1s4oVOxCLDRlThpLEfd
	b135GNQuhrZfVVGuZ7OpNdpepV0uj4lj5hUdGetLqga4M02ghmWyGK57+tLjjHTohIMYHiBSd94T+
	bO9NemOY9a9bSk7PnP83pivAlLhgndRCR3wImH2Oo7/qSOW5hJYweVlERjydPbSfFHN4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wP40E-0007BN-PV;
	Mon, 18 May 2026 19:51:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <p.dobrogost@gmail.com>) id 1wP40D-0007BH-Fu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SuaZ4ZiZ4DJauPSGPEudhOxYNclsTUwqpFWI5BJdzgs=; b=VHKFw+XCgNatkIIZIvUiY9CpbR
 ZkrFRKb7d5oytDUKZJguZ91mH8FytC+Fo4Kl6J8pleQI6VXS575N2/HTo4jxf6rZMUZ8HiJLkamWe
 YBdexmhJLfLKmCbtbZhQSVMamgMwLxFNsVwbB9YN9soC1rIVy4msqRhEDBASZheZvjTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SuaZ4ZiZ4DJauPSGPEudhOxYNclsTUwqpFWI5BJdzgs=; b=UiR8ITIJqcbHUsn1L1VFh8rsl9
 GOxintq7Isk7plz8DNnlqJQSGaQa5pa+hJJAS+GWk/Hov6ruhwfhUTE7Gtx+drgHXLw2ytV6lecy1
 JTo6IVBEgfMCweFIy7yyaZzG4qF4D5/c2Vhjy09x/f5DxWleUdDfXbSxhwIB5fCSp5aI=;
Received: from mail-ua1-f44.google.com ([209.85.222.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wP40B-0002kA-Li for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:51:49 +0000
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-95cc3522c40so1854175241.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 12:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779133897; x=1779738697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SuaZ4ZiZ4DJauPSGPEudhOxYNclsTUwqpFWI5BJdzgs=;
 b=UUYuMTiFedNxUFSEZFU+GbwhEUaIECie0fpXd/qn2rkVOygU1OVEXXB4znSABW6KbA
 FiF0GHtQZY1YdPHq5BW7xX5r2WKx7pnoJa/StaM1j9CbM1MFagIrkSFlk2XgZMXlb7j3
 BdXkPDjZvgKw42AqP8AKl71RIPy9nRrqnJf2uuBn//36GJZkSbkGt6goTwzRe2OHP1sM
 aJSL0oxpERMfGc9JvY7qdP0WlW5sV0NgY2KtS+Qmm6vnfpwrtYVDy3S9BwhG+wSg/7Zn
 yWgB/wCiQPiWvig2GlfO//iagY9j5Z6p3yANlTlA+RtMSwJrlV1X8qYzkrxTpojtmYGD
 mvXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eErycBNBDXSLXOraLyudmOZqvrZ7ECOD8xCIpL3YwswiH0OAUP2mytpZZZbDirsIDRIpg47VxsjK0Ynwj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwlCyOfiMWZ6AeDL7pumnFvOyQ0eWvTaXzaxK2DInzHxgWHC+ey
 +QoqZif2BdBbMWQZURgrS/MQEphE2H+XP2DNpPL7QHt+svfg2ZskiDxDO7SRj9h8
X-Gm-Gg: Acq92OFcPhfFDXsKfLX6/Iugv0Tnku4qPqiYmOzHxT8xeRpgj6aKm3A6oVSDjxjt7eA
 gar25GNFhZI1+LLlMsqdfpkvS4ebQ+w6xncSKnDTwIrAOf3fBFHYuNDJQZJHqdQ3QCsgVfJZ2Y3
 HfmUHfU+p5GObdo6/DH32qFo5gPSPKVN+O/PPd5H+DmQIlb1YIhG7QxgjMXtJktx1TlaNuBN8Kd
 mNP+P/CzPN7NJMH7eU1Pwcr4J5eaXCjPkC4FVLtNJ/TTTr5vkCt0Gvry4hl/ly42gnO8rDbKZd+
 rHDFeXdflDP3k/nGSYpoXb84el2GQXToEBx4fezd6kczLcIuF0OuqIZIRgkxFgpeWSPGJpcGQnl
 jYyjrfi65hr2WkaeZ0Yqv7IPm2apt/sBxs+iSDDsHXxsFtvwKgUyEgBZTeH0KSV7ebABbQSFaMN
 IZDCrFthiUkOOC2cXCozNu0BFPD1xtD3TlypzcRgtERo7OWHB/AQ1eRHdYTfFN
X-Received: by 2002:a05:6102:6051:b0:634:8685:d335 with SMTP id
 ada2fe7eead31-63a3ec8c2efmr8254447137.14.1779133897204; 
 Mon, 18 May 2026 12:51:37 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com.
 [209.85.222.50]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc2d278a8sm5097440241.6.2026.05.18.12.51.36
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 12:51:36 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-95cc3522c40so1854169241.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 12:51:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9H9yt0PNF9r6fdi0ivaT8GxdV1uIZ0+zcU8/k8VqYcg8RWiBf6qYsyiNpelpHQk63K2inx8OpGpStDb2vV@lists.sourceforge.net
X-Received: by 2002:a05:6102:598d:b0:633:d7ec:153e with SMTP id
 ada2fe7eead31-63a3fc96982mr8919093137.28.1779133896636; Mon, 18 May 2026
 12:51:36 -0700 (PDT)
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
 <CAA6tFMskhqjXx4-vL4zYSjG-koB=a5_koysHKNLh5tDe+QtkvQ@mail.gmail.com>
 <6a401a2a-4df9-4c6a-b250-f0847e5553da@unstable.cc>
In-Reply-To: <6a401a2a-4df9-4c6a-b250-f0847e5553da@unstable.cc>
From: Piotr Dobrogost <2026@p.dobrogost.net>
Date: Mon, 18 May 2026 21:50:59 +0200
X-Gmail-Original-Message-ID: <CAA6tFMuJkNsmk5xJ+GHN4NwvSwY1JEocubft_G32YwhE3SP54A@mail.gmail.com>
X-Gm-Features: AVHnY4KGgCAoUCVysn9DOH2ZO6g34MNOij5EmoI2GfcUxrgjenNM7Klnx-8yOmI
Message-ID: <CAA6tFMuJkNsmk5xJ+GHN4NwvSwY1JEocubft_G32YwhE3SP54A@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>
X-Headers-End: 1wP40B-0002kA-Li
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

T24gTW9uLCBNYXkgMTgsIDIwMjYgYXQgOTozN+KAr1BNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVu
c3RhYmxlLmNjPiB3cm90ZToKPgo+IElmIHlvdSBrZWVwIHRoZSBwaW5nIG9wZW4gaW4gYW5vdGhl
ciB3aW5kb3csIGRvZXMgdGhlIGRyb3BwZWQgY291bnRlcgo+IGluY3JlYXNlIHdpdGggdGhlIGV4
cGVjdGVkLCBidXQgbWlzc2luZywgaWNtcCByZXBsaWVzPwoKVGhpcyBpcyB2ZXJ5IGhhcmQgdG8g
dGVsbCBhcyB0aGUgY291bnRlciBnb2VzIHVwIGV2ZXJ5IGZldyBzZWNvbmRzCndpdGggb3Igd2l0
aG91dCBwaW5nIGFjdGl2ZS4gSSB3b3VsZCBoYXZlIHRvIHNvbWVob3cgaXNvbGF0ZSB0aGUKdHVu
bmVsIGZyb20gb3RoZXIgdHJhZmZpYyB0byBhbnN3ZXIgdGhpcy4gVGhlIGZhY3QgdGhhdCBJJ20g
cHJvYmFibHkKbGVha2luZyBkbnMgcXVlcmllcyBpbnRvIHRoZSB0dW5uZWwgZG9lcyBub3QgaGVs
cC4KCgpSZWdhcmRzLApQaW90cgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCk9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL29wZW52cG4tZGV2ZWwK
