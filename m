Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97125606BD4C
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XAHvUeid;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fiCkVRXm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S+xl2PkC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NG19VrqM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B+45deHBOlLM0Bj502Rpn/3pUWvtLaScMnFsIH1yCyY=; b=XAHvUeidqqyuBLMF23hhai6pe6
	k8hm/LkX5+7rkVSXii/LsDR/y4YLFF0bf6HbGtX5r5wROY7O3drM2AvlHz+z3ax+1FLQVwCGs9u+a
	9pyEov6LhNu64LDHUYeZ0fAqoTNMcx7JRTt/CJfh5TyVP1S+HyeOQCzqzDGc5i3ufZFc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPIJA-000000004c1-1xXo;
	Fri, 06 Nov 2026 11:40:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPIJ4-000000004bs-099E
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=84SD89b0kZZ5AhVrpYXsEttbHL5XQP3GTDhaRr/gGik=; b=fiCkVRXmiYSjan18Vlb4nTWYQi
 eezXfQzFDQMOdRlBhUliU5KPvyGsyRFPCdWqAEthhh6jLakSNIFXGvqKdRudcdX5AnJW0wvVak0ll
 LqNsI1Ey8EuSAcP2DDbJ185pD32FWLRySF2Y/xodOL27PzMq3iPFfpnRxoDbvG1jY7+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=84SD89b0kZZ5AhVrpYXsEttbHL5XQP3GTDhaRr/gGik=; b=S+xl2PkCxe1WRmE7getaAN4TDp
 nVkmPXiGvqizt8lBOxLFs8yZqkUmC0TOXWTK+VBWphHhoUmurwaF9FBZnuj8kN2ttyMUxF1cNzqVt
 pUmnzvYwQXcUSZ0Yk65LIltgSEXRvj/kfIZyDkF7hKMgpbv3gpDeHh1Ex2RulmJ2vTXo=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPIJ2-0000000013l-2ESY for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:40:29 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so1144053f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793965222; x=1794570022; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=84SD89b0kZZ5AhVrpYXsEttbHL5XQP3GTDhaRr/gGik=;
 b=NG19VrqMT9LpO8+s7QlXtyM4sg/dPUR9INGnFduKPMrUJ3F616g0Yu6a3ok6YRTkWf
 FR+KV0QrRWUQfw81CXS+y6IoNNb29vzdSRH1isOiP1UrIndzNCgotmBZCvo588nRaPsY
 jLHC2rKUADqqARrQ0yAJGF23Z2jew/k8RYgNDrvfgFjq8d8D3iGjvAVAIESC3qF/IX5+
 rMDR6OPj+Wtb1BwoRRqZ4fWNlXyoEAhzJLNrhjgLi0swTRy3SCsPUkOyKF2WFPBuNqsJ
 pZAzCeI0jI1HGR/QrYDmoxSJFdupN96Tv5lMQ1kwRZPu4Oh0ZWHDs1sJWKUezL6sorzW
 sdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793965222; x=1794570022;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=84SD89b0kZZ5AhVrpYXsEttbHL5XQP3GTDhaRr/gGik=;
 b=A23lh/+DI4pV70/b7vm32IpsjGmDZCwD792pWHqh3BOqAtNg2I5dWGAK1zPg1I92Yv
 RTkOf1DznQdmeJ12SQEzQxw6TtGtUQ8RFfqTTmw2RiwTbQCei/q1m0PpKT2c/WrSHowl
 kbuH1Tq9yQ+MA+y1QJvP4/J6LAf9CVF7HX0P7NkV5/hMBtviQFhMaNGKD4vzFhnmYjgp
 /809G2O1+2DDK3nMb9h6D+mQFKZT4lnUMTSw6ZPdb3BWRJ3UtpztahQ1rVg23+BizFBi
 vTI2lUzbd+Y+7mWqwsNp+MjjeJ73VLxL89Q98kcpunMgUVjVJrwmOzPSPrz0jvHg+aCP
 hKdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvGgSQr4/pslg8+Xb/4BprA6UFmgC/9H2gyjXlEdc0vz8NwRpyathIhMpx9c5H0Oq2OUXFBtj/VkKU8IqQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Ioncuwyc/1taK3qtObTsqG2tI2aoJUodZfYpsuuC8qmbBb6we
 VlFH8dfozw6PCBAzgFBoD664tmIP1o3WSezuJIvYa7BBOUQ+pM1I8qQnEzZYoouTJVuUR0zxmTI
 QCJ/N+oheXf515UyhBIzS7gDlxt+1m/ae+zum0078M47rc/mnN8etQ0pSSnVso5K+NP0B
X-Gm-Gg: AYBFou2DdgjAI16rP5gmzBoFuYHEStvZmgwKfmeAV/0VDME24C2dg9wYaTu5/6mgIpa
 Kfqf7f81tdnUBpPd3ATlNuXLO2kSFmbKrdTYNYO8N+MVuLQMk3TM5YlprD/rvNNNz6OoV0WWq6w
 77o3MejlobRgPNv02ZKkOsGC0rq5VscpYBsjJWW2Zs6+tE43lIg6l8Ev/6dClE4QTh6WeLQj6/9
 tKdJEo6gzTHlTdnw03PPCjKVxkyoObtNYvNoiXYb481zp9CpS/V/lrF5OI8Syey7AYYNSuKGB3L
 WolULXb8zHpn/ppzXIK9+bH/d0TiHSYonru+ktCzPiqWit6v+34fL6+8L4UONQZGIRPN4Qhb4pZ
 5tnJEZwXvrrdSyLT2ZG8iKbcK4/cJjpENBdmQPgXffGBpDTKa5UUnPQf8Xi2m40C1gcwiSFRCLV
 gsJ6ylPYSMPVLucHtUmSD49/xHRWhSPz6+xlI32KYXBeWzDPm6K92OxoUM4hQt+rC673U36ij5n
 5jCD5pkVuF1G2K4Y5aGsVfJ78Tj4Xbrthh4caxV7zUPIAsrvdbFIJWXZksDX1QSVX9T6G7alg71
 AchMCw8bJgosPp7VzeklbU7GCxOQGRBHv0X3elO2zo2DHA1ZLn0OrqC1V8OXBPjHL1/JHko0U+o
 P1ZphdioN4APTymGutkju1GacB3RVU/jTGq13sAUrg28y4As5aPbtoj4uTEqm4Qq6gujSXoS6dl
 WGpYewL5XyRv8pXM7Bsgz+dWRWnQQLP8whe7M=
X-Received: by 2002:a05:600c:4443:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4b6df5eacc4mr36904075e9.10.1793965221793; 
 Fri, 06 Nov 2026 03:40:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6dc6e0cfbsm57445485e9.0.2026.11.06.03.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:40:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:40:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 960b56641b7814262f6a811e7f4338d4224bb741
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:40:19 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1b956ef5d71ba8b4a1ebf06f3e06125c8f7b47ee-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPIJ2-0000000013l-2ESY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
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
Content-Type: multipart/mixed; boundary="===============4320062918668467768=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4320062918668467768==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P1wtDQ/+Jwk="; charset=UTF-8

--P1wtDQ/+Jwk=
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


Patch Set 5:=
 Code-Review-1

(1 comment)

Patchset:

PS5: 
Unit test fails:

```
[ RUN  =
    ] test_acc_common_protocols
[  ERROR   ] --- Test failed with exception=
: Segmentation fault(11)
[  FAILED  ] test_acc_common_protocols
```



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c9=
50761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 5
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Fri, 06 Nov 2026 11:40:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--P1wtDQ/+Jwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">Vie=
w Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2130?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Unit te=
st fails:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```<br>[ RUN      ] test_acc_common_protocols<br>[  ERROR   ]=
 --- Test failed with exception: Segmentation fault(11)<br>[  FAILED  ] tes=
t_acc_common_protocols<br>```</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change =
2130</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2130 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Fri, 06 Nov 2026 11:40:19 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--P1wtDQ/+Jwk=--


--===============4320062918668467768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4320062918668467768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4320062918668467768==--

