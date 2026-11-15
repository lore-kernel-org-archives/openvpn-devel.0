Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7D606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ej8DvE4P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JfkLvSz6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k2k+NiKc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IUtes9hW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i706qgx8w/4cXIfxzIDZJ2GCCf7lSrBYm6ePmuBEf+I=; b=Ej8DvE4PwFu4vZjagrEpzy9NaU
	Cxj92wAiHGgmwQHuIo09mWeCzWxNmR/oE77qJTpvLyEeNQGP8Wo3VEwnQjJol3/Hl4C7yhJeduYab
	tmFK1kZ1e0qIP2h4rmO/FC8m7YUKJmF7YvMOa7IUywUfYq3gKduIEdTFQIm9DisgY1bc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSZ9d-000000004BO-3KDg;
	Sun, 15 Nov 2026 12:16:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSZ9M-000000004Ar-1x6F
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1Vqm3UwLYFhD/kEpEAR18Lz74AJVoQHcShiD1UoPCU=; b=JfkLvSz6LStchtzBLduDx0RLzE
 qZvH8PD+ym1zgKtvhBUpUhLfJGsvLqAQq03BfGSlGgc3fsfTG7ZQOoolGkjTwGBUPVlTHt7qHpVMZ
 UZu/sBYdUzoOSwNJ3+0rwKpQicKMIggn+z0e8jOv+e+Q1l+LRWvwhyYtnHzcUHlFXg1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1Vqm3UwLYFhD/kEpEAR18Lz74AJVoQHcShiD1UoPCU=; b=k2k+NiKchdENvRVWgW9JvlsWH9
 xa7xly3z6d5ebDXW7rfqmV3JytLJCFmgKq9gyiwRdX1eW1sycH87nWwpMuXVxY5kjr8J2zCvS7Mf2
 LXiQURo6936Po+xVYfOQ1YaE5FvFEJdvd2v5fQCxTQamIBw0O4hg8xWF263AWoMH9NYc=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSZ9L-000000008CR-3Fu7 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:16:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-49318428d98so956206f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 04:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794744953; x=1795349753; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z1Vqm3UwLYFhD/kEpEAR18Lz74AJVoQHcShiD1UoPCU=;
 b=IUtes9hWBsoFK22nqtlo5fAs1s88fawsgLhbQOYNgHl8J1vobPMoLYIUFUOR9X0Ct5
 gqz6FrIVAuQPATXBrAWFVCPUKnFeovvj69I5ttqGLQaOE0Da1zpd4LqMLBsfFtv61fKX
 G3CTnNOascgA7iogT6eyvrBcVYyYukAMBDaRt9hrH462GiT64gH6RwvWPDLwtBvTuHU0
 HB6KKVS3bxqlH3jKRio1XzZyNy3AVNVQTYYY/a2mu+d/Q0Oks7MIULRuG1Q+kAndMUIQ
 yIe6Mr/XM4WTy7e4NW7CJ1juKus0Np9JhXP4O0rWNwkRWu/CULqrlUsdSvIs/K0X7cv8
 HfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794744953; x=1795349753;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z1Vqm3UwLYFhD/kEpEAR18Lz74AJVoQHcShiD1UoPCU=;
 b=f0vegzFY62pEkTwtPBcIGhEOygz9lg4b6qgjzTaydlOoGjaKS1GcTPFBPxbMLyLHfb
 10VfzwLNpgmW2KRvKX4CGDH7T9snCkNm44M4tcnYNQ2SZWGElaleKoTCc2Jq6Euct+Pf
 mdXSBRknHrKiE5DVjoQqixbP0nSlXa8RtrWXc6xkOI2kvR5H/lbQsLQFDV7IbU9IZ3x8
 0iosSB3ZV6PWuO8FilQcrFTA3C2rOllUYRsDXmIV2YVyA/SibEEP/Pqog0V2NBzNHInC
 hIorfjtlvohajgYjE5ROVl5G31IyNxqesuIgjV3jJhGLAqhkpe80OWcbIO1AST70UrAS
 +ivQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHoWDGddrl6/C0C/c6dibLUnMyUorsQ17OETvEVqC5kL2wkQqR8p7yLO61pG3fsknDbAvwmrtPAptKpPdMs@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8KtECflg7hq3zAOC0rsRZW0cVuMjSwrDt7O2e+X8Kby2PCaVA7
 Z6VuiShvOOuQPnHbciHkMb44NBPd2DdzgunYg2J43TY5q6xtbG/D0ZB72hRmDm8Ejq4cWDmYeu1
 ++L3bNdBi+pAWvu2jX6oWCu+pP1Mm/+7AlSzzzJRTzHMFEG87ocF/62xxItpYe6FhRXJM
X-Gm-Gg: AYBFou2vhTQVxIS1OgJyThnYcYNZAEeiQC2XqmVBXE2xRgoZjYtxtY9yEtYa4dITuPb
 qLqbqRYftdQXPwQTpM9245280D785/aFzEF7bHHg8cM6BOITnO4qABWsTqa9O809D4Lk5vaw/vY
 69u8xyowFW9Tiw87hrIDr1tmXkWc1C19GOc79vs+7CCQvkmr8mnjjl3D/HnaymKLAQ846uGuve5
 dZ9B0rIpCNJs38rw3Prajln+eVlX9HkpHS/gJbYaR5xRNXh4zQXpF+QypahHHz3fCleXOW+G+MF
 Pq5rQL/PYBFSbRtSAtQg9ghqI4CHpfLiL0LCoIRiv4zkVlgAakpOtj1XJhpKlwgEsH+1x7MPBFo
 5+P98FCwNehI/73zw8279q4kPMsaGZpEwvMIXLx8txlhoUMkczJIPIehp7VnSFsyi/8guSAILTV
 iMKrFzVNC64hSZCDdbFgT0rYijU36e9/2JoAud1u+KvxbsnoiNe4xQctutlMkRRl6g0gE1Pvgxi
 C6iABB8oFXqrm3TMyk4/4is1HzBJ1n5qmqB+7A4Fpo49NfbjeoT7GMlabkdCVMgvP4TutT10+I8
 rP9vu7bCK+eiohZ47m6YDXLHEw9JWmgIlm/Tsgvf9OILwveds4Hg+e7y0DNFRbea3w8oYYRnedw
 h1hOf7ixDozoJ3vucl/XglUhWQHWkEuV3RCOQFMTfFAUQup9bRjNDwC+bmHEnZLUvoL6EevrRQv
 T2rc3M4uwRg5O+oIU=
X-Received: by 2002:a05:6000:18a3:b0:48d:f3a5:4563 with SMTP id
 ffacd0b85a97d-49c70ed9360mr19217450f8f.20.1794744952914; 
 Sun, 15 Nov 2026 04:15:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm16372067f8f.23.2026.11.15.04.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 04:15:52 -0800 (PST)
X-Google-Original-From: "Alexandre Laroche (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 12:15:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 6a596ff7bfdfe93fb03bc11d7967a8507bff1f5d
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 12:15:51 +0000
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c1c4c68b7d12c1ef864924ae3974f49cbe13b31-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSZ9L-000000008CR-3Fu7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alexandre Laroche \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Alexandre Laroche \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5140678061065750945=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5140678061065750945==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ff9Lz+BbLjM="; charset=UTF-8

--ff9Lz+BbLjM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Alexandre Laroche has posted comments on this change by Alexandre Laroche=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail )

Change=
 subject: Check the result of unchecked allocations in the server
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

Patch s=
et 2 addresses the review:

- src/openvpn/=2Edirstamp: removed, it was comm=
itted by mistake=2E
- backend_x509_get_serial_hex(): good catch on malloc(0=
)=2E The buffer now comes from gc_malloc(len_serial, false, gc), which neve=
r returns NULL for a size of 0 with an arena, and the free() is gone since =
the gc owns it=2E Both callers pass a gc arena=2E Tested with a CA and clie=
nt certificate that both have serial 0: the handshake completes and tls_ser=
ial_hex_N is empty as before=2E The ssl unit tests pass=2E


-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52=
cbb7429
Gerrit-Change-Number: 2155
Gerrit-PatchSet: 2
Gerrit-Owner: Alexand=
re Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 15 Nov 2026 12:15:51 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--ff9Lz+BbLjM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Alexand=
re Laroche has posted comments on this change by Alexandre Laroche=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">P=
atch set 2 addresses the review:</p><ul class=3D"blocks"><li>src/openvpn/=
=2Edirstamp: removed, it was committed by mistake=2E</li><li>backend_x509_g=
et_serial_hex(): good catch on malloc(0)=2E The buffer now comes from gc_ma=
lloc(len_serial, false, gc), which never returns NULL for a size of 0 with =
an arena, and the free() is gone since the gc owns it=2E Both callers pass =
a gc arena=2E Tested with a CA and client certificate that both have serial=
 0: the handshake completes and tls_serial_hex_N is empty as before=2E The =
ssl unit tests pass=2E</li></ul><p><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2155?usp=3Demail">View Change</a></p><ul style=3D"list-style:=
 none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2155?usp=3Demail">change 2155</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9=
bff5e52cbb7429 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
55 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Alexandre Laroche </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Sun, 15 Nov 2026 12:15:51 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>

</body></html>
--ff9Lz+BbLjM=--


--===============5140678061065750945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5140678061065750945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5140678061065750945==--

