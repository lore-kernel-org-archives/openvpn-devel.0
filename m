Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336B606A336
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dENmhO2F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L6399KHp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IOOwaL+6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aTv05ZeQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=diK6oIlT/N0ecIkzfACLX9BKf5/aYdv5KYsyHYNBedU=; b=dENmhO2FJGwzAv1ReKyUVwaFMM
	u6ExL5uwyNh4qAvPsiP0myv2lEacHcNbeMJ9Sd/yR6AehEbkgC1qNzHA2jxY6sWgXnwKE4UEwTHek
	RkmTO1x4ME0c5TgWfyaa9t+JckzPC2U56kDq71Wu8QQe4FwHswKfttcRzwSMsfcIw324=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTijz-0000000035g-1qwQ;
	Wed, 18 Nov 2026 16:42:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTijl-0000000035R-0Jdy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0eyQpQfNTQVuuqrEg97we5d9l07wZlGW4nCpb//q+HU=; b=L6399KHp/4U/BpBYKykQRbJgyQ
 um9HJ/IJxZY2zewonwg+v99mAQjgig/zuH1YRTX5+08ZYbP8R3HiaJJsSRSXe3KA+arF9p7+kCX4Y
 jtbayYGftiaB6Mkr7znXYkFCpTg1Ldemmq6CP9mxDyrlltblm9ef41qbPCypMx8wTlCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0eyQpQfNTQVuuqrEg97we5d9l07wZlGW4nCpb//q+HU=; b=IOOwaL+6AGV0S7bxp4cMl8klvT
 3QxFboMKLv8+kpGKZ1zp6xMAXuaWyHugZCGL2w9UnY0VNSujoXFv5q+gSHkEh1Y2kM0zvjQHVqxUV
 ZjQPCYsZyGODLoZx0qXiZn23LCX2FECaMDIhmSiZA1WwZSpD8xu6n09PYqe81iaLOLlw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTijk-000000004Jv-0ib7 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:42:21 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1054400f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795020133; x=1795624933; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0eyQpQfNTQVuuqrEg97we5d9l07wZlGW4nCpb//q+HU=;
 b=aTv05ZeQnxcBbR+/DRqtyAC9VG2gJHxCGW8qkit2nbMooZEsNfca9Zd7bkSe1W2D+K
 hl9yHE9WnhWZwVKJnhngKUaTpU7Zbx8lB6TACTLt9czMynkxvbHlqwV8FhoLjpgSCvKm
 6ghE0c5DYgor7+q+hlCaMhpmXWeT8/bK2AlZnlW/3z8L4pFzjAfOp9lNwu1U5CBwRyvI
 ii5OpxGjO7wowmjlGubSR7lUCHUlfBstMNmV3uXtudFwLCptbEaip5i5TtBpszOg+XpI
 YHCmma6FrJmkEHD262eCMga/6U2kKlbX0wMXh+1/rZBKfOHW6hQO5zSLeCGt5BwNOyNG
 chRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020133; x=1795624933;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0eyQpQfNTQVuuqrEg97we5d9l07wZlGW4nCpb//q+HU=;
 b=n8Nhw2ZqR8phxOlKyw0b6xKxIQltnre6A+mjqiWQIrwAtDpGwBU8wx7llEwU2auhYF
 swZ7+c5gNpi+bh0yCBO8vPw/nEjQV0ZrbC9uUczhgQqp48mFERFBMHGHBEQ1UOMpmDqz
 6DrQzyuFQqz3TTQBi4My0gHR26E0bCCgjOPd4hddEQQ34pKT3Qo5aNSVxRHkVysJ5tiF
 QHVKYYa36QoAdHsMP6Jnmv6tnQ0yKbBFeWozY3yB6wKc/iipWrTuZMYI3SKspjWRzjlv
 yf5SqFLRrJa4cJ+YzTcu50R9JXMQsYjhaOfEPuzV0g4kCibXyDSwnepgVp18qzPC5OX9
 rPmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHMeYmuhC27JBBJh+tvtcja9+pIp47Boy4VH2oTrZNK3vKzCRflVkXkI6sMWQMoLHsRPvnu/WIcrKnhEPuh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/wzXwqQcTpuHKOlexaH2nAqyOr16qdO1AC7sWWdg3c0m3g+TJT
 l41pD7IB3IoJUQDmy6lMBaP+F1gdz4pJeeCoFVZDVuD6wFVwWB2vxEa3winoVtrAPs3CO9hq8o/
 OnSIeDAfuLZ+6muJ81OlLfmaA6Dqm62Yv2+aFDXfKP9VA38Hp0u0og9lkorvSlzM8YWfLpbSihr
 6W+CF5JQ==
X-Gm-Gg: AZFdTZdRKDkD3o8kZKI/WXIx7o1U4sGDB6C55/SVtv9wSfbPmnn4ob6QIZDlOSK7rwr
 xSVISehOGrP/+JKceAQ87GF+OLmxZ1bMMjUKu0Ik8MrVsko+jWVONNip2o8MgsG9rasAfNYbROI
 wWjNEZHZkyECRzkp8QZVfstWlJs6nWcpNoPC5gv5C6jgbNU0WUSjOTMrZVqR4Ev8yFJewVLcJWE
 0EPJb3qj+dGSYGJl5j7+lREX1lDRWQx1mIhbTBKph8n8AcIA9mH53lHJhckvzA9iVguZhH4doQx
 OaF/MMcx5o4xn47gTcajc5GDsRV5XKjpt2T0zeoRN9pIDV0aGJe5hhMpCWNN6LZHuAkRYphowaJ
 GqghGgLnS3lbhlnJ+xduWcFZHBxdOo3qJ4EF7yO/ceAcUHVbIq0x/Np/9uZ0lMRjNTz+mXDV+Ff
 9NiJIYP6vMw3+hamB+PyA9G0bRNsHtiXDZVtLZEpBSbnbTsOmr2qR0Dqafmf+3RLgIusG44LVvG
 OqcD8XCXOjmoji1X65+Bo+2ShyddXoFZVHf9M5uemOMDoU0iLg1FT5dPIjd0E+Nh8wGuXwvo5zJ
 ROFNi76x10hz88bBHsx2q01eObGirhnhDn4fKtdcOXD/Gyw56dYcd+hMpe511fZW2sBtKbFD5Cl
 sO0Va3ByDeUb0y9DYoKwov4WYWPTswtBZaqOktgBugDY1GYbPiVBbmFMP7g0XSv0Nj8GZH4hHuY
 Ot62J3T+mnWDURCus=
X-Received: by 2002:a5d:5f42:0:b0:4a7:9630:7b4c with SMTP id
 ffacd0b85a97d-4a796308123mr4277559f8f.47.1795020133422; 
 Wed, 18 Nov 2026 08:42:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a885b81daesm958728f8f.20.2026.11.18.08.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:42:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:42:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 5a1090cb382ecdf4f80d611cc42553934488cce2
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 16:42:11 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <695ac24d4194b922cbca02902074cab99bf7efb1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTijk-000000004Jv-0ib7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0455742586047566829=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0455742586047566829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kM0JaBRldsI="; charset=UTF-8

--kM0JaBRldsI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail )

Cha=
nge subject: dhcp: locate the UDP header via the IP header length
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comm=
ent)

File src/openvpn/dhcp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2209/comment/0d3b4b3d_21ba3981?usp=3Demail :
PS1, Line 160:     const str=
uct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);
Are th=
ere potential issues with unaligned access here?



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
G=
errit-Change-Number: 2209
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 18 Nov 2026 16:4=
2:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--kM0JaBRldsI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dhcp=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/0d3b4b3d_21ba3981?usp=3Demail">Pa=
tch Set #1, Line 160:</a> <code style=3D"font-family:monospace,monospace"> =
   const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ip=
buf);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Are there potential issues with unaligned access here?</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2209?usp=3Demail">change 2209</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd7=
84153367e4fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2209=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026=
 16:42:11 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body><=
/html>
--kM0JaBRldsI=--


--===============0455742586047566829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0455742586047566829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0455742586047566829==--

