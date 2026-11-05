Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4B606A330
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WvE58JJv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CmlMAVQX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P7MLth86;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G0mSEAw6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a8X9llyQks3aEj9uWFadRiNGRitxzA2fSBdg/lgOVpM=; b=WvE58JJvFtpO0PH5dFOBDpqZpF
	V/VNlVVj9ngdj2bdcGhtS/FOxtfB1IxcSh/65Hmy+jgffjLuNlgTE1/MLd/bWRw+v87WmpEQ3IaFG
	8W/9Ta67+MimkkdhvyTVCwA3sLZxIBKiZDN5vLIFDelv17eOBE4ULkQBtUhaf4/piT1s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOqLH-000000006Is-2mis;
	Thu, 05 Nov 2026 05:48:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOqLG-000000006Il-24B3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:48:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r9O7we/ZuvsZhWroXYvICxSZjmuyJfYqORA58hWpy8U=; b=CmlMAVQX8EaWkBbWfBePHY8zeO
 PxoH02ixyxxzYqRWC1iq6Qc9r3i3FT/DIURSxQxdz+JtJ9WO9Iofr2SQEhXGaSsU5s7Oh83W7tbCo
 E5kKxJvWxXYaz6yIjPiwwXcGSFdeFVXyM14/Om/R2grFfAW/GcBYVYV6+tQJ+TbUV1sI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r9O7we/ZuvsZhWroXYvICxSZjmuyJfYqORA58hWpy8U=; b=P7MLth86zOaeDFjNVXi972hEKM
 3hA2HsV9k6ZFE2hyyBwwPRQcfaxCYC9Mc69SNmcP77W2oK6lr2ZNW3xaSTL5dP6MLw5pRtUzRA07w
 VnHZCzdCpehim1WF83eWY2a9r4Q2oCgfQ6NkgnWHW2+OLf0x3ypicBgJPUndKOKTzDII=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOqLF-000000002zU-2nIg for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:48:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so13075155e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 21:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793857727; x=1794462527; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r9O7we/ZuvsZhWroXYvICxSZjmuyJfYqORA58hWpy8U=;
 b=G0mSEAw6VxbW1MSUX76++igm5jI14HutHwO7wiqhv74HXT5uyBu0D1UIp+bMmDusju
 8SVdbjxvssvvQ7dWZhOI1BX/giNkT1NuRHMoDOmvpzuwMy2qtjRoROiwnreVd8cVLTLA
 52MZZ+hGQ0Ec1InxWQHjSeJ34LfCBdwfDzqitb5izKg10x1lXRNQzt2drsfwuJs2snIl
 +HbKF+0+nGeKVkX42Y+8f08bNfex5tAEM3p22d+Y0tnLQ2Aoht0n9+qVTq6s9iYLP7g3
 whAVkLFVH63vHztCHnDqLiWfc8Z9D5tvY+KRP/YnP1Luv1AOPrGDzhFdKAlEofbLOK+b
 X/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793857727; x=1794462527;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r9O7we/ZuvsZhWroXYvICxSZjmuyJfYqORA58hWpy8U=;
 b=RR/2nZBOFzD/PM4nVMee8m4drGYgRV+n8YU2Z3xi8ANWSzUhHPniAx9kx9PqBtj33k
 +oy6SufI/HuCbsfKetfYluqE8nWEn5E+4LrtRFpt85aET5D5BlgyJ45GDbElQJCIb/6Q
 1eFoGrTWGtVH+rKpRPGg2zKzfLBFgYV/mmrhIHp7wi/muglQWC50B8LX5pma+ZAHYRjE
 eCXz0we7I90buYHBlY3b9BP9SLugL3lqxHMLHqLQHMKXcWffrW8IqVm63JVFmWz5N1qJ
 3sKLwfO8bByU8yMelBkF1A4AuIjuCGBL3i1zvx4rc0em1/5nTiVhv8VrqECfesudvyz4
 JG1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwc1r+zEOIrNxiAwEm0UBBJG7rI/72jjj0oq2pYidqlrvsPW0g1Zacy8mH4uoVgScjASgn9alktW9i1fuKb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8b1F79+iZnYKE0GpmrSBJiJM1E155OEL/0g02d54BLe6LVB3Au
 ewasYgO9xLeSTPjbQvEEl0SBbXaqgyVhPJPENA63yZ5jq00FRqiiCplt5mHNR3EBplt4eImLK+S
 YPQ8Wyg+2cAZuJu8xs6jnz5Tvh+O3OpFWtQE8Ks0H9hxyQQl57LFT1dYD2YPBSp9UaCaw
X-Gm-Gg: AYBFou24erXTkYrQrZ5FHye/lTCTAJj987CeSc3Z6+eE8DuBL23aGJZEvJxitS8cKc9
 v7rMgeRY+sVOFP3iADOx5gvFVnDxhNHoq3dAhIxJwM1/SEQ48ZpzDF1jyfxvtk8U2rUnHqCTmo6
 l0NI0FQTwPgQvZaHF6m8CRne+gOsemRT5f9Uxssd5OAOp9Vob0f+STK8iYY/X/zHqhmCGlB0lUW
 L8l1+35AVJ8e+ISr3phrnlgBA2ep4BUiGseUHrXftZYCi87K+LhXypXJestOTMp/a7OwS4NE+Ma
 DiGqpgflfHa+GJyGAoTF5GIHA/1fTpv2/8jWfMPiKFs2k8K6fTX/s4tqiwWcjxp4RWu65ajFQ+M
 4EKiCB8Suhbq/aL7FZznghgYlSy4A62bNx7qXHDUMNyjMxfrwOpyoOoM/X4ZYGRGEG2gSak3tqJ
 pCg7rz7AlmQSvg4AcIoihf/gFbFR1bVU7yx6tyrN7jQBQzXO8PbQa7Rs/vuH+cYawpsaAdEpTWZ
 OF4O/N2JqowLIHlBX0PIaFSiQ+pBXQS01Ymtr4MXAT13rSGjMKDdtjfSmWcNBxYekQBlI5iNruQ
 ME4xWFPT905Tm86yw6O45KLRo4jzNGn3xoGEI2EkHsorOJCNgKZQMCC8YeAfFNVsZwcQYuab6os
 0u7q5jWYZtcYbP42TJMg7CXspI5w5uFQ9dYi+jx8Q+zthWcGcTYM1M8SLvcK10HB1M3UsQK4p8Q
 oTeVe/2CFGNhi6vx9qXHLUAw7Owrh8MVk+rUM=
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4ac17e10acemr372663255e9.29.1793857726962; 
 Wed, 04 Nov 2026 21:48:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56eb4da1esm65311025e9.6.2026.11.04.21.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 21:48:46 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 05:48:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4789b833c6308269796058871518caef61e2f1b5
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 05:48:44 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a406643eefe27f673e4c39e8cb49660f3f5fead6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOqLF-000000002zU-2nIg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7362653167890746770=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7362653167890746770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vjqKKDfPeEA="; charset=UTF-8

--vjqKKDfPeEA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:=
 Code-Review-1

(2 comments)

Patchset:

PS3: 
test_acc=2Ec:187 fails:

```=

[ RUN      ] test_parse_acc_parameters
[  ERROR   ] --- 1920 !=3D 2048
[  =
 LINE   ] --- test_acc=2Ec:187: error: Failure!
```


Commit Message:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/841bf794_c6ef5615?usp=
=3Demail :
PS3, Line 12: Fix that the management notification about negotia=
ted protocol is not send
Typo: "is not sent"=2E



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Ge=
rrit-Change-Number: 2130
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 05 Nov 2026 =
05:48:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--vjqKKDfPeEA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">Vie=
w Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2130?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">test_ac=
c=2Ec:187 fails:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">```<br>[ RUN      ] test_parse_acc_parameters<br>[  ER=
ROR   ] --- 1920 !=3D 2048<br>[   LINE   ] --- test_acc=2Ec:187: error: Fai=
lure!<br>```</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Comm=
it Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/841bf794_c6ef5615?us=
p=3Demail">Patch Set #3, Line 12:</a> <code style=3D"font-family:monospace,=
monospace">Fix that the management notification about negotiated protocol i=
s not send</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Typo: &quot;is not sent&quot;=2E</p></li></ul></li></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 05:48:44 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--vjqKKDfPeEA=--


--===============7362653167890746770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7362653167890746770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7362653167890746770==--

