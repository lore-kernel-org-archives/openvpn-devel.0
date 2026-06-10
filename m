Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02F4CD8CB2
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y3NeMLzED8JTw0IVKYjmzFXDmedFRLqZqQgfvxb+kwI=; b=kFJSdbliXmFvhcOnISERQdPFA9
	JjDX9Ai81tD//b0eJYvn9MLOGQuOiyUApt6JUBL5+KZAnPBP0xgeF9vE9yaksaWhTb8bYuyiaP2qT
	w2X6RQmWXtNbazmd/5qBqP8kDePQ1L74lrcBSJp3mWiqww5jBMAFzHhobBKpvqK9KnaY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXHSQ-0003eA-KV;
	Wed, 10 Jun 2026 11:50:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXHSP-0003ck-Eh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AyxicUeI34tD0aVDhVBlQCV/SDQId767Ka7OpFAITds=; b=UIu0zH+aFjx7yktjbAHIh3J9AC
 7nPxEiDqjNIRi4mwgF8pzhQTBly16PQhCXtj3ECuy9kFcMRhuRzPW3Feq3GUlFvoVykv6PZDUB8hO
 DH5nr81S7exqdzS5LDeyt5zo+bG+uOz+waC5+ySAGZtqrs+xdrNKunS0Min0+YwAw8c0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AyxicUeI34tD0aVDhVBlQCV/SDQId767Ka7OpFAITds=; b=f
 keyXdD6HT2vPdg4WZoGs5tya3LA2ZFHIFvI8VpEhYf9nevkDdoeiogcKOxa4zvZr2oxnmhc5tksRo
 LsVeu304X3kr7Rs865abNwZrIU0v38csn8/rMt6eC6rd2hJJBwZX43y6CxggnYN+OgUPX/lMmzpV1
 l7ZalmGGK/4n1cjY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXHS6-0001UI-DT for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:50:37 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso55780345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781092228; x=1781697028; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AyxicUeI34tD0aVDhVBlQCV/SDQId767Ka7OpFAITds=;
 b=FJxn9ETqvTCbAgK94aaByc7WOe/Pht9ArYbJYAHAtaaY/t+nopSO6OCY7lZFK2BO72
 4zQlZNqiIk1SEzR7w0f8kbFHsb1KoqmY4Z0F9PIihBHQf/s+xTyrMikEo1eKQ6XwtmUr
 EIjqP+1tNHBUc6a+0yaPkjP4l4l2wcEbnymc9BTh0+2GRus/2sSvMRN8X/lRqRj8vg3W
 1uDi5h7sEl22IJjwWgjXxCzh5Ga8yPJDZ8+vTbMsneMcsbDcCEbB2IfqW3eZ+ujJslk5
 jfqOK5ZdIcZtENHNi0aHcZbLRGSF7NDHSzHnHySHg7kDEaGoQXPwjIvvbuo2HTIFALlJ
 fsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781092228; x=1781697028;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyxicUeI34tD0aVDhVBlQCV/SDQId767Ka7OpFAITds=;
 b=GkGSaVVe+6+J3YVZEhcWy6ZUR8toiDwMNEFkLnuZQkIwFG0gUn+U7eUz5OLszo9BDh
 NPqhRYfHl4UOu691h9Gn/ikl8ISRcW8lyekOoST3ZtT1ryE8oWmOCQfb6H0b1HxwU/B2
 lCJc2XfWBXxtKx70bXn6UyNYw3ofGwbw2UPL09NPzMBLrTfTIKcthPgPZPCDhjFn/TBU
 RH7w/kwUN/LPjr26OZA3qZI+CwEOxuI/djQgj3cPMhvItcQVCTHwPlHFJpBZAR2XbMqa
 lpz4RGn7ssWrkOPFufMUUSHVimIIbnE908S0SGn2GjXA/y9+5QkIhy/K8jtJubvTIzon
 IpNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UMWs9+SjySu7eihrlOBEXQ7PBtPKNk66OPzFjhRLkeC3FLyqw+R44srBK01TJQ84HLmrTp4cqc2MZi1Du@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz8NghT0GBxQcclghI+PHZRLNmbTRzrhW7tx9ovxx7lEkWVY9Gp
 e0nuAlqIGvkgq27EQhV/761l7c6Vzmg1dDr37VWmqi3qw0GN4ehsQ62p5sIlPe2k2pFd1Ax8wgX
 5m3aKErcy3SnGcssmmX8/Nq8HXNF6WKj5YzFMl8uxjv4P7XQ4P+LU6tGHQCdaUmKdwmYGM3y9OA
 mhXVmo1A==
X-Gm-Gg: Acq92OHmOP63UdKI6yqNF3DS8mXGuuGj5evOkdPRsjV6k2jbeWBsPXUAfqy2/WWVnuM
 jmSpZ6GrUqIkP2tamOs0KWGmbX8RmgvMauL3xW1ZBulR/JbkuOqdRRp/IUF5Fu93x0UnQjo9cZn
 U6N5HmIGV7SBfxUs2vAKGnIkwI2zsvpCXh6Zgt3MeB/3/s9KjZmwKhAE3Dq5l1tmnbMC9BmdIdG
 C8R4++0nQQIQLVLUpPvWHEJSkBZU8/NAZR+386Hk2/hkeBmceBBnfSNvCpqp3ALB9dK+8DGSH3u
 yctItjGOniG7JD7lN1LB9wfk5Cvudx4DcHp5plPq+5KA4knZ7iWf8/ObzgsI9JmnHuAG+Lk9rS8
 6Jwz1l2NzN+GYEEFiDaFO4CKe5KtdDcAyZsf8rqLwO4j1QJXuXJPNJvRuzVdGuSylA5JgLWiNqV
 U07MoUUOBI8ZMb1glNJvjCOLZr2sRKOnUhCgQLSIZIOE89t930ACs9xH6nFysY+yHACnp2ISDaD
 YNYmkQo6t5GinwbsZcj21ZWY94/5YZKKfM3OuxQzXChU5scb55cznAMeKSJJQ2mxZiIHNpe8S/L
 /XxxG+Cd0Nc90h73qVOf4do2
X-Received: by 2002:a05:600c:c0d3:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-490c265c091mr289191475e9.14.1781092228183; 
 Wed, 10 Jun 2026 04:50:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dcab44dfsm59245475e9.2.2026.06.10.04.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:50:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 11:50:25 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: dcb3bbe0ad6d29ae420af36f86b911f284a8bf06
X-Gerrit-Comment-Date: Wed, 10 Jun 2026 11:50:25 +0000
In-Reply-To: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <302045448fc2953b47c7feefa5b3ae45c239c83a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXHS6-0001UI-DT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for user
 defined L3 master devices
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6486001801460126057=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6486001801460126057==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CnnhzMHGsWk="; charset=UTF-8

--CnnhzMHGsWk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1703?usp=3Demail )

Change subject: Add support for user defined =
L3 master devices
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: -Code-Review


-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1703?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
Gerrit-Change-Number:=
 1703
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Wed, 10 Jun 2026 11:50:25 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--CnnhzMHGsWk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">change 1703</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I115a17a2c61c65f48aea4=
1d94150f34ea31f82da </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1703 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Wed, 10 Jun 2026 11:50:25 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--CnnhzMHGsWk=--


--===============6486001801460126057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6486001801460126057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6486001801460126057==--

