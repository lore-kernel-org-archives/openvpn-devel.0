Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2902FCCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRMM5SrbsSlnBn+Olf2yNcN6rCB8WC4AnvFv23GzABE=; b=ghU0jlmGDLHvIHJ87GEd86oLdj
	fzcyEv7f2uvGIR9cu5GE2BssD038Zqt7X6BU67PfcGy41wYbSDrbv/TPPop0Lp7cLpm6Sfg0OcB9A
	MbnKF1i8neXE5C/JLWzqjuiVCESHe8QkRSQnB5W+kCiLO0I8F8mER69NmfGqq23cNX0c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7BN-0007Qn-U4;
	Sat, 17 Oct 2026 16:22:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <alepacheco99@gmail.com>) id 1xI7BM-0007Qg-4b
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dCKUJ5YGbBEDQoCAIQJ2TwS3Foco8F76JmQqpbJ4HdM=; b=an3igYWr1mhKvFuzzJ61ajqvhw
 lY9LJpolRyH1g+mhBvVXKHfssqulUSY36gUqi1SllQPMuHaPymLK1r1/u5FTgDejqM6yrGeZ4+Hyp
 surabG89rpekom+bcJ/Tkxpb4zQvFlpDoUbW8mu9q5KplJ7EVNZ8nvRp1rIXbvchnEWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dCKUJ5YGbBEDQoCAIQJ2TwS3Foco8F76JmQqpbJ4HdM=; b=PVsfBzDBCB2GWSv0V0JF4XgrAS
 sAZ0PK29+Z/67oiOEwX0eOjei3/ztp1bq0MmfsNEydw/7DZGdHkNu40oIZRwtarJlThSfls+HURiX
 ExkE0ILLazsB7W+uQDArUM7db1+y9xx4qHdrVeWeRbsREk8i3aaIoe62GsEoDSUQQKXA=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7BL-0006UW-IM for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:22:52 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso6636685ad.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792254166; cv=none;
 d=google.com; s=arc-20260327;
 b=Luk1HnOUpmZeQw+Z9CuE9rKVkAqCS9/eIn/jZe2r8/MUVwvaDupT9rjtJaQXiuNAhd
 IBLfS6r/yNU1zBY1jhDfRMk6bJPL7X3JAVegGvNN6WXjNmHVgKH/c1B+/Dymp4kzg/m3
 sSSf/PO6jPfN+mclD3DTf9lnypTi4L6Awc2bnj+jC0fQcwHiDSeSqRHB901Klqoqua2X
 f7mzhFhcTUJoldgopjJHChIV/K0LsyUOv4+LzR2jJYS/ZcQygK6TW1PoyYpRqsFX9+xe
 +Xqk9q5mJopJcRZsL6uMJdO6gZLpu5+hCHIlQaD/4KEUU7y4yg/dDvJBUCR6Ni2/0Old
 OZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:mime-version:references:in-reply-to:from
 :dkim-signature;
 bh=dCKUJ5YGbBEDQoCAIQJ2TwS3Foco8F76JmQqpbJ4HdM=;
 fh=mwocv4RJaXm5cLMv8+a4Z4leEvXCZEtcQaXamycw2Hw=;
 b=RRHI4Z7a8k9NorNws01AeaEZlnp7xmkZcR/MlvEc8QLbncE+NAZUyBKvtId6eJkQZ/
 9A8WhRIXJF3aVMeq8L1fe71YLx0533JvovRcKW1GGnC9ecy9LXc2A8FdK72RVgpx62v0
 eOpXJgQCc6fOenI6i+zetfAa3lUqaW5BteoALoKQQOf9SeUWZRNPlyowokktUqVhUvSB
 Vha7Z1ZNQMLFe2o6/So7h4GNYJ82uWVJwBZesN5xXpKXDRlu9zmVtmr/D1Gud5DG/6si
 0rUTt6e52xI6/Y8Ock/wNuD1gaocKMj7s0+ria623ungQVr0Mg14VekBXXciKpsnV+p4
 R1+A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792254166; x=1792858966; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dCKUJ5YGbBEDQoCAIQJ2TwS3Foco8F76JmQqpbJ4HdM=;
 b=HNTGnaSXmDZf5GAZwbNchVT0JiHS3Q0mC7dxhZidEBLl9+JryJHoNcTXhtT0O6najB
 8I7tHFQrZupOjBu8zhH5Iz9ipSpMEy5rey9HFdkdU85BxMwSnF71hUJEYstrWtl1q5yk
 Y3+S8cdaRIXzxGUm7GmVG9OUfFeLls5J/VCrW3ZOd7zlA/7st5z8bsqMmgGROCyeemtP
 5ydnYPAh1kd6BlX+iqN0n3eDfGMZ21GmkhIj+YmdnOOGjBpmDYB3z9Wdvu25ZQ3iRL7M
 wL7/aDKkulku63DH1WSdUisr6jm5e+T0KBRefuWBOi8t9IIC6Yoytebs1cde89YwyEBi
 lZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792254166; x=1792858966;
 h=content-type:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCKUJ5YGbBEDQoCAIQJ2TwS3Foco8F76JmQqpbJ4HdM=;
 b=CiXAzfJmtj0t1VFOB7anJ77NuCuuDHJ9iuq5Ir4kP4bkSoUqg4iioBlh8wvDM1vpQf
 /okEBaKwcnKHbKNjsGF9RQxwWQmFBd1fujllzkUQD9Drwmp+lrgbV7lQeFMi9+Oj53ew
 Vt9Irx49Msm/ki8NkilwZHUrMvvUDYo8f161qU25N8T3oxxWlyimwKuPRgK6ut0pj5sr
 6Ef5o+uOcKdF82qXkppIl4gpXP3opMj/cb0kqz6nibvK+6QHAs6o+oYyM1aoJun/vRls
 YeN/GKStamA2tiU6DMbWflUUnlB1Qym42VyRXriWMypOzR2PyZEdmjYsj2NgjFzbgUvZ
 I2Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpv0C/pEKPezu1YGSwnkLe4Z/kBi7ytGgfj31bqxO4LvGhdQJfUISZcz830EyEEH6YfnI32QjA8CoGqm2V@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIALbEaTBt9K6VyIn6DBMxIjhuXUQCOXmPx9/BHW+tDkm4TSeKE
 0n5ZFVKDQZ8ZSCqsNGJ8nxjeEg3E/tTVpDdOPWY05N6X3IPAVt8Osx4AGqFLvv3RiYBO+aQLuW8
 a6vp+dRgAlTrsOg98NmgG7QJujGGo+gsT8Urb3fS/koYF
X-Gm-Gg: AYBFou0JnU4efNVKl/y85OBL3amOYhFM4BVkb9nN6x4kisb+l86Jzz8ZM7cuC9eh/yp
 sNbQO4xaKMoonTN+FTO2VfylZA6ngI2qejmeceDgE2Q6xJ/EahPYL/N5EHU9OdsE2c8JoR1m+W6
 ZTLWIGxpFlgybbO7GH1I37/egCgeaTygHUK0CQGXfjvJxb1cO5wXGWi0VbsyNoPgXGYZTQfQ97T
 3qkiT8XkIqsn7qtrqFTJ96ArQxBSI8ME63oOOhE/VhktK2q4wJAA0lHCJKeRzXc58UMk0HezAxV
 99ocf1tifRlon/XIKLr+W2chERqaFqAGnl/guqqKBVCGZfkIa1D/7tqW4EeL5wl6S8k/jzd3cGx
 0U1ln8sXISjAcBTjdGN3qb678YehVSx/g+IKdxKVOIw==
X-Received: by 2002:a17:902:ea03:b0:2e9:a23b:643d with SMTP id
 d9443c01a7336-2e9a6c0a75bmr29821065ad.35.1792254165782; Sat, 17 Oct 2026
 09:22:45 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 12:22:45 -0400
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 12:22:45 -0400
From: Alejandro Pacheco <alepacheco99@gmail.com>
In-Reply-To: <eba2bbbc-ac1a-453a-a46e-1fad8e664b35@unstable.cc>
References: <CAB8Pm=y=qDzUMhAA0-FVL8gce-2can1tkXTU8GFozZXZD58mQQ@mail.gmail.com>
 <eba2bbbc-ac1a-453a-a46e-1fad8e664b35@unstable.cc>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 12:22:45 -0400
X-Gm-Features: AclHuK_V_M9SgHyPCDBWz6CbwppLX6v-MB1Pc97Rp4wLI8qWWTWVIagxErePVTw
Message-ID: <CAB8Pm=xTnNDcex7s9X_fjKPc-6V2GBfjFWOO2qNJ8o3ZG99dDQ@mail.gmail.com>
To: Antonio Quartulli <a@unstable.cc>, openvpn-devel@lists.sourceforge.net
X-Headers-End: 1xI7BL-0006UW-IM
Subject: Re: [Openvpn-devel] [PATCH RESEND] Keep the outgoing control packet
 in a buffer owned by tls_multi
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Antonio,

Thanks for the pointers.  I have pushed the same commit to Gerrit, so
review can happen there:

  https://gerrit.openvpn.net/c/openvpn/+/2002

Thanks,
Alejandro


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
