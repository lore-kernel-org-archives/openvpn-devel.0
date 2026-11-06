Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166D606A329
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b2XXX3sZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hPlKlbXy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S+FOVFMH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QXuRPwKe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xmQdzqjaIvrqcLA1VPDXG8I2F1TGD15hudYL8ta+91A=; b=b2XXX3sZFQurxkhatQTWWW6dgL
	GYl7l+F19If/GFQK8z5NA4ENQ/aAuLCiYn7C/ubw/zen/xvBcSvZiGBD/htUkgaaqyWJJtqu2Cu0R
	NfTyN8oTQHXtv3mg9//vmVy/4k56p1w/580Xd/0x3PJ8S91eCX3BM55F6Zt4SBpR6PvI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPK2b-00000000053-47Pn;
	Fri, 06 Nov 2026 13:31:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPK2a-0000000004u-1rH0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vVRnKpUMZMlGzP2k37cFgTfbCytn2qPKIgjv0Jqv4iQ=; b=hPlKlbXy+YDJAHYPe9EgE24F0w
 LnmSQSmZZvLUBg1/yef40rnIiHOlJg+39D1jefOhntW1NGjpcFjpTV44y/AIBkUFsyR2r7gmhaneW
 ndyiYdzbykI88ch8BiP8zOTouEQTZ1FI7/hQttGX8fl8xWd8K5mip1N78y0ZgBa2ntQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vVRnKpUMZMlGzP2k37cFgTfbCytn2qPKIgjv0Jqv4iQ=; b=S+FOVFMHWEiJP3zUEInIzERkqJ
 53lMIRBE1zAfD2w+o9acKX8iIs3pUhJg6SlJ1tGnzLN7oA9GzDVvx2XlkgMm4nUH6zo1HzWZfBfOB
 lCY/EAoLEIPUwbSXlfYBAncYq0qOT0nbTvnhgR7cF7w1GAb41a6OiJpv18lb+/BpUzK4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPK2Y-000000003WU-2eeg for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:31:36 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so4386625e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793971888; x=1794576688; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vVRnKpUMZMlGzP2k37cFgTfbCytn2qPKIgjv0Jqv4iQ=;
 b=QXuRPwKee2iyJxnWSexso3nO1qNpk+IHZkeFVHrJ+jHzXHTNB60ndJPdxcFehdxAQI
 6yr+B5yDTWc+v2Ss4EPbFV7j3sNl5lkltIWk4nJOyK4f8G1jrWvC7ays+RQXEzNc0M+r
 gFrS0fVN4Q+c3WNaY21i2YIFrvwrww/8l4t7q3lAulJr5Q7+JxqULCbFwbVTMn1Ga5n3
 75CgcoZgtrmFcZSkd+g7mralyJWYTOJ3JTKobOZ7myNkjcAajv0S8KOVSpxqICKLZYgZ
 qywEZKBcY3hH5fua43xgsqOHoaUDSfrEhfo4wLSKZk0YOdofrZeX52U8n/zkGIWlFcaR
 scfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793971888; x=1794576688;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vVRnKpUMZMlGzP2k37cFgTfbCytn2qPKIgjv0Jqv4iQ=;
 b=cC3ZRmRyzXWc5dFNllPMuBNDRttEPI0UPjuSBV/YgMkg2TnMteQdTAtnqlfquA7Dhh
 xZ+d8ryv3WrLkvGOR7Z/YspbO9GPNi9ohcpUx1ZJYK/jbQ86NPxD/Vqk6uYc8Oool1Pe
 oovTTL9iSKHLAWZZSM1I8YIAizZxdMlXX0dp8U9UQVkbcUtgQdzDkkHEIhF56J/hSe7A
 a8uYnRx57l2EY2NY+nrMXEyPlXALkwZ8coze9MEg+Rg5RPzz/pZHVrqpFAel4Labr/yo
 ug/v3eJgGpXOp+IcgnDPIKs2uzy9Zszidi+A3hWiZ+VoB7jyg5+LsT8u42MZedlh+DZ8
 ToPw==
X-Gm-Message-State: APuU4Z9JUQwOsBSL09i8xkmUQ6PpnAiRfzXk6sUb4ahZqjuzOcCxfifO
 uoW10OiuAXqSY1DUORkwefcSsWgB3Sw6v5zbFLJp9sXbgVy19eFQQnnKpEW5Ihjmcz9hOZdGuHb
 wpW7Y/BAgQ73liSS3s1VK76HzKc/M27UGUrDVOGxAI7WsSOWn2739PmOGNCHgcG/5UsOuwgY9Vt
 fSOSYcOQ==
X-Gm-Gg: AYBFou08OEGokQyHugsC2FMnrUs/Y8YFAgnXQP39mtmYYfua11Q9/h3vIi1ICC9c2xW
 Glfe1Ohl+UjU+l6yG7uTluktw0ZyGs+cWhYqdp1i7mz4Rsq6tIFWEckaM8GRyaVhIPKSRKFgz+P
 HKime5F58RII2JpiLdGZvoNxUf9AQMc+GT99EKiVxSiZQiA+8AkG+0+llQ0iKTjNIA7CZl77lUs
 JKwMssacST2wD2hrz/b6lmGb/S0ir49HN7Stc6bbNvhRqteuZK5UZAmDgPbQrbXGAl56I2yo/Px
 Q7lTwEy5SDyjQS4Vgx2ufwCSN2LGMX3yEwCSFzTo36lk/EO26NRJXaC0vfk414fDT3t6D5Yt0LF
 ibs+/cZFkxC6JtCTExGpODiiQY6Eq95COzxm+DgX/woG+5jF7NUu4v3PuBqkhyMxu5GIO3AgDrF
 VoG3Uc4VoXlLORY1NPgiH/iMLLcMF0xcUdIPi8paueQdWT450DPs1yTdgOoFWwv6pu+F1U/Gkxa
 Gd+OySgtLcVo1qPrr1/yj6Pk6YgN1ojzaXNkODALGc2bTBXlqvvGJb16tq7zM+fSAVP9DOh8K3I
 q7mbbEP1GrbyFU5p1BFL6RNTGSSfZd/ll7/4EAQrarmvOQj+Q8dyGjnhthLowvlrzHjwa4kPiME
 v9s2j5jdG7WXNRyqd7zq1/hVzMWiA3Rh4aG70OZtui7GBR6eWgLyNq5NgoNMRPTac4OYRJN6YnU
 d2D/djWVGUQ2zNlVGQmLCtTCr2tIc8ELd8tjU=
X-Received: by 2002:a05:600c:1910:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4b6de4a6b88mr42866375e9.14.1793971887748; 
 Fri, 06 Nov 2026 05:31:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e24012c3sm55089035e9.13.2026.11.06.05.31.27
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:31:27 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:31:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
X-Gerrit-Change-Number: 2040
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2040?usp=email>
X-Gerrit-Commit: b88f198569da0953b6e64fcc5886f04d35802f9d
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 13:31:24 +0000
In-Reply-To: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
References: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDUxODI5MDAwLkllYTE1MTk4OGYyZmExMjBiMTI2MjA1MTU3MjYwNGUzZjQyZWY0YjFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca0dc1ada91e78af4bfbe7ef23fd88f7a912d230-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPK2Y-000000003WU-2eeg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: p2p: don't report
 WAIT/AUTH for a new session while connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3879349479043755742=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3879349479043755742==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UTpmSQ8IQFQ="; charset=UTF-8

--UTpmSQ8IQFQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Arne Schwabe ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail )

Change subject: p2p: don't=
 report WAIT/AUTH for a new session while connected
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

File =
doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
0/comment/84814d43_7e707afd?usp=3Demail :
PS3, Line 430: WAIT          -- (=
Client and point-to-point only) Waiting for
Client and point-to-point is th=
e same=2E I would rather phrase it point-to-point (including client) only=
=2E


File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2040/comment/8d4376c8_defa02a9?usp=3Demail :
PS3, Line 2527: tls_multi_est=
ablished(const struct tls_multi *multi)
If we introduce a new method to che=
ck this condition but only use in the new places but not in the old ones th=
at have the same check that creates inconsitency without a good reason=2E I=
 would rahter see either not to introduce a new function for this or also r=
eplace the current three places that use multi->multi_state >=3D CAS_CONNEC=
T_DONE also with this function=2E


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2040/comment/0b005034_446473ae?usp=3Demail :
PS3, Line 2903:           =
  management_set_state(management, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NU=
LL, NULL);
While I can see that this will work I don't think it is is the c=
orrect fix=2E This still mixes the invidiual connection/session state (move=
 from S_INITIAL to the next) that with the overall multi state of multi (CA=
S_CONNECT_DONE)=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2040?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Iea151988f2fa120b1262051572604e3f42ef4b1c
Gerrit-Change-Number: 2040
Gerr=
it-PatchSet: 3
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio =
Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 1=
3:31:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--UTpmSQ8IQFQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Antonio Quartulli=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">View Change</a></p><p>3 =
comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2040/comment/84814d43_7e707afd?usp=3Demail">Patch Set #3, Line 43=
0:</a> <code style=3D"font-family:monospace,monospace">WAIT          -- (Cl=
ient and point-to-point only) Waiting for</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Client and point-to-po=
int is the same=2E I would rather phrase it point-to-point (including clien=
t) only=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040/comment/8d4376c8_def=
a02a9?usp=3Demail">Patch Set #3, Line 2527:</a> <code style=3D"font-family:=
monospace,monospace">tls_multi_established(const struct tls_multi *multi)</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">If we introduce a new method to check this condition but only use=
 in the new places but not in the old ones that have the same check that cr=
eates inconsitency without a good reason=2E I would rahter see either not t=
o introduce a new function for this or also replace the current three place=
s that use multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE also with this fu=
nction=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2040/comment/0b005034_446473ae?usp=3Demail">Patch Set #3, Line 2903:</a> <=
code style=3D"font-family:monospace,monospace">            management_set_s=
tate(management, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">While I can see that this will work I don&#39;t think it is is the corr=
ect fix=2E This still mixes the invidiual connection/session state (move fr=
om S_INITIAL to the next) that with the overall multi state of multi (CAS_C=
ONNECT_DONE)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">change 2040</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea151988f2fa=
120b1262051572604e3f42ef4b1c </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2040 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartu=
lli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Fri, 06 Nov 2026 13:31:24 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>

</body></html>
--UTpmSQ8IQFQ=--


--===============3879349479043755742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3879349479043755742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3879349479043755742==--

