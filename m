Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49319606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k6arMezN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h2C561Cx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BLYYhzMA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M2QXXNm/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gmqmeCdyG5Dc7Fs6cwKwe0XxYoDmrASUOcWKlpDfU5s=; b=k6arMezNfbrlTffXKufOw0VrSw
	RiDLnGc/YZqIUPI7mH5cZshD4IskmEtNfeJ1DW5cfhh+FiU/aKu7ovW65UnEwlBVL40HmkzzgQh0Q
	DdV/hTzINAav2AyT9eUD9WwviWCQ2OyqXTXc0ciQl70Y1yFQIol/rga/+JH58CgRVb6k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN2Nq-000000003nh-2CbK;
	Sat, 31 Oct 2026 06:16:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN2Np-000000003nb-0qUF
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 06:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cqz9V7ia4mCgfU3crfA3ghYqr24198MT1l3/Am8nZSw=; b=h2C561CxAlJBsznDwlHmsF7Zpg
 mUYfj5EGYS02Dsm0Pc6cEiKcOiIFzJ0wKELkXBzc2XUOzh4LcZhgRQFyacpc7oWskWWQUVD9gJTgn
 alnnJkKBcs9+Pu7CxCoycm2yLRBZKAiQpBYDjnW+fxH/plyru7a4wD2xkcTv8SWy88NA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cqz9V7ia4mCgfU3crfA3ghYqr24198MT1l3/Am8nZSw=; b=BLYYhzMAbcbyorElq97gVTg0h3
 Sgk86MXCVXNd4h52H0BRqlVLLXdbUM0i++52N98hVNwt7v+JQ8NdroXRFtedip3AhbjhmUHT19qAY
 aPonltoLT5+cUdcJ9HW8UH+KobP0gADTCfR5Taf5lPgQUtdiELdCW2z9UwcN/DxbirOc=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN2No-0000000088j-0akt for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 06:16:05 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so12235855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793427357; x=1794032157; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cqz9V7ia4mCgfU3crfA3ghYqr24198MT1l3/Am8nZSw=;
 b=M2QXXNm/zPhEqK0luR8iAdniEEMPmYQMdSMwfWUAzLbvu2utRV6GyQPR9GELsEi0R9
 aTqa/h2mDAkc1tt5Uub5lCJ4N3hWuhYyAE6dK2WWLsICv6odD5lEfbCAUeCBcmaRHA7J
 RiNzNj6QacI1Apwz0WG61OrxvNwGGfSrV8+WiFi2MqswPhifTaqJrFjb0WSk5qjkrTMG
 Sd5XSoE8fqlViaSaeHX4YxCGUsNPSsm0ME6Ky2OYCdUqvg7AEhWLbzttUiuvD/dwvQYY
 RUmnitKu3V0BITj8vl5y4rqYJCgePku9U9/jd1NOF4lCYPC8MpioUFNMHmpq2/kNMV+p
 sE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427357; x=1794032157;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cqz9V7ia4mCgfU3crfA3ghYqr24198MT1l3/Am8nZSw=;
 b=aV9425A8aBm3eGAiLYRqmFuWXHY9iwUHrDW8ty2R5fenz1NUW1byChmE1tR38r9XDK
 3nttsKLmUNaNId6avRD1pulgVoDig3BFmaKfxP2aIKUQuTSe2RNxSTrlSegrNSXS0ekX
 g1HO1/Cn3Ikjx/QdmdY6tSl6+1Dv3KrygoKtuw87dpqDc/uLCx5Z4j7s/l3po9f7BGWE
 bHt1x8BYfCzR6KsBCeqwWoOBep3MBVZnMOyjEjFMEPZBsY4G6EfsRBoeSJNXh/Upge3c
 vjAIRiGkTohlNS35WkjG+vvXBLWkvFb/rX8GifUyqfUTxmrqMAZXaDA+nWoQ1rYZQRAD
 aMww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYo2abJva7XIRu1RDLDKHWOGa0j77kn//y1vgAQdsn4LbE7Ao5guU3pSEbFbWoQIK+YFdwx5+SY/t1TSaP@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJuTT8XMtt0pYoXMkrCk7Osen4dM8mIAbGyW1gPNWFFdEXFrn+g
 y6aYL6kYP2kyS2bfgbUsjM3cPqiLtT2CkSHLnXh4ggaK1mdyMhh57E8Je7KTWI9MWySJxH+e/4X
 KYWhpSAElEN4row3cnfKlffIzc65bFPwSdfqil36wSW4RbnRyYhBpF8QE2yxU8a1RWhHA
X-Gm-Gg: AYBFou2wA17zhJZnfRI2smIL1qI8VVhezKbtwqdspPlLzNSeDnIdergIPW4h601uNqE
 NSHeN7gIvycSt4I7OgEabje9To4cAr76g6M0mh6lvDU3UcxpU+XWlSpMs7/xGE7BLOH1AVCmHmk
 7rJHLSvdn+IzFKb45X/GLPr8mRyEALFa0ISItly8+58ER5kBZIgN5Vu5fpSI7+oVnFmC4nhqF/G
 kZ2v3n6OjbmzJ+zRjVkx/E83yYzrqdNRBpUkPQ39u8If07KKmbqOOjDpJLtjT8Ni51rvxCUA54N
 NLweHtNmhTQ2JB4UmJByx+CFW9nnqtISa2I2aZ4+tSnPVMjOrK2ff3zaiDMNfqKPe+Jxu32ZBdg
 JR7wL/Tt/JWGx5Hx+ncU/pyGpXJnwly8Iptx1F+6nFJM8SrAg//vjQbFJMKE8kDOL334Ikdn/Hq
 cYgqtmzjMJLTpzzTfICzUvkJYSWxoHj/oqHjYUYA8wGOLuQca75cXe6gWCmKdFT21aFlJlIejar
 gZP53rZ7a2hvzt3WD4BdKEYpVDqDYFeCfOzrytbCs3SpeQ9Zgv4neWUcPFjtSNOW7lO4QkTNrfU
 RsdNZhmDanGqGBTtvm6KklRswWFPZ05ymrf5gJWcWYvrcU27NtBwcgOWbwvwGzmuR5KFtIq2i2h
 XTOO6ezU7zFxl73OLuXiFtNDT5lBbHrCFSVcRowz4oT9GjncXaTWwGIlHxP4RjWAHKRUwME4jvF
 SLgvlZyFk5tS6GOBc=
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr97660725e9.5.1793427357446; 
 Fri, 30 Oct 2026 23:15:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7706516sm72019355e9.0.2026.10.30.23.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 23:15:57 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 06:15:55 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: 96c6b6477a3538e936b0043ac238579e58f501f1
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 06:15:55 +0000
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1d3881de599c885106dd628d0a90c42d3eafa46-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN2No-0000000088j-0akt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7358683529925300865=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7358683529925300865==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f7VEh6eo4f8="; charset=UTF-8

--f7VEh6eo4f8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Selva Nair=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Selva Nair=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail )

Change subject: Incr=
ease the buffer size for alert-message in management user-pass query
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
73?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea14ef08=
268e6f6309e4bac4acff27958da8b045
Gerrit-Change-Number: 2073
Gerrit-PatchSet=
: 2
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Sat, 31 Oct 2026 06:15:55 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--f7VEh6eo4f8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Selva Nair=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Selva Nair=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">ch=
ange 2073</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2073 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Na=
ir &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Sat, 31 Oct 2026 06:15:55 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--f7VEh6eo4f8=--


--===============7358683529925300865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7358683529925300865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7358683529925300865==--

