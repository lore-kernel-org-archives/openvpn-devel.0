Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F39606A338
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fvfXbotv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NCYsAWme;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IPG+qHjQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ED9uoqO6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hDh59dvKLE3pRX2oa4D0uyXBg406W7R/xIcPdbQQnzQ=; b=fvfXbotvaz0JKmb8JL0Bh0YZtg
	NlbTobnf7Yt1yNxIh603p6c/wb34Wiays7nmAuI1LR9gZ8u9+K1afRMqX5J4Xo35luU61GY8YN8LP
	a7zNGXA1XnEd8Y5N0nqUBPzCZjSo11waBxaZhl2PC3awGMmcCkw5jTsWKynjHlHic7sg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwW3-000000003HE-0iRJ;
	Mon, 16 Nov 2026 13:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwW0-000000003H7-2Dpr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VKj1gkkAb1EwC7fg7X2rKHX63IYyciMQUuIjVVsBvuU=; b=NCYsAWmeJ6aa8ViixzLgCJpUAl
 L79RzSWCManrJmkhQjHs78rX88OnEpitM2pwWjGWUw7s/t6bGOWRrgAX+ZwI2DRm2UjPTQRTZZx4r
 aFn3iBNOlYWTKZ9RciRp6XN6NqOTW1gKsuFXzCw/9vIf96K5VvYVnSDbX8QSiBQgLj88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VKj1gkkAb1EwC7fg7X2rKHX63IYyciMQUuIjVVsBvuU=; b=IPG+qHjQEr/JIQU7bryFvfUpoR
 dtevB/YheM3avw4mu124/uhbanma/+/Od51R3M2EWvWmBZXZJDukkzLCZKulXmykKMv+TT093yqdT
 IfZ8cdOxf6oitS2RgdsRPz/lyGYMxMFMizQHb76WjveAxBo5Fbe3i4LEN2G7ZumUb9RE=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwVz-0000000074v-0cOO for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:12:56 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1357406f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834768; x=1795439568; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VKj1gkkAb1EwC7fg7X2rKHX63IYyciMQUuIjVVsBvuU=;
 b=ED9uoqO6eBAAXpEfwSzdzcUBg8rFF1/PnUCnY928Meawmf0fvThX40fpYQA2hcZGyF
 1vcd8ubmbGgISY9Uy/O7365CJ+Q4Q94LFJrloUJr+NhoDg5E80OHxkw793I1EUgYg8zl
 w93KPbh3TJxpC2vBK2rzElcfjB1DhupoBoVqVl9X3ytnBY6T/NQSdCBN2NtTbWo25Cd0
 Q7HURg/h3yOFeOfo6rr+noUFN3dZhlXtKzo/CCyBjx49ptwdRGInyYcOQVEzq0gLGmVL
 lVFsJAJjtMCynRWprUUMXwKAblA/CxbVd18l/ZZNE7gAcU08SeNAbPgXHqwDdreiI1lJ
 dRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834768; x=1795439568;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VKj1gkkAb1EwC7fg7X2rKHX63IYyciMQUuIjVVsBvuU=;
 b=pWFcSAwZji26/wQQOPVYOwBvSz73tX9xqpWVlLBL9z1T+uz5eAffK4G6SCY20kiR6u
 XPi7EFMJitz5ZWso2S0kPp1t++I56G8qpxXr8bniuSUu7mhQHydB2PUhvTEhz+mMqBHL
 4uGE2ve01vdi5IbEh6Eltbweq0UVgcdff7l2cCTgVXpXc7DqkB+NrdelWOf4VUbOXmhv
 49f2pbc3k168OTt+6KvntxxiI3gtF0F4MZR8nITyCuNucleDea1bz/12eaV3Jx4GXpxu
 rKYmHdJbfAIXmtx/ThyxKqT4hCe4wh0QkgQO3PNtvmyoPKZS6O05nOhIwXw/0+IVCRs/
 lUzg==
X-Forwarded-Encrypted: i=1;
 AL+hErFn2YFRvQEEh7WcEQ5T9O0iW92b8byZGUsV2em6dXrNbsdhO8XoHdz3WSkxelDRdJtfwYgIyNefJFsMUxNh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9xLh5TdMqusarylAVw1Jur7sO9+mqLs4YrkBN5c8L0ltm95bIq
 TMnwHxFUZPSueuIW3A5XgStbCwMJndV7hja7WxwAGsz1nruOBMDLoW8tJYECar1reJ5VI5/xD0d
 LReRoX+ExTy4EITpjcsCask5vGFk2UAsuq8aVoTra8kOLn4qZsYOTkD1BoEMCV8AexaPy
X-Gm-Gg: AZFdTZdWXR1RRCBT/mxgyCJs5i4inNJuS3MhJnqAWd2cmjTC4ZpTWERQmVEiSYS8gh3
 4I4P1Wi/JWi+PIxLRVJZxaASMI+25II7hOWBZYqr8ZYPbTYijh8xXkcF2hPd5FVpRXTbwnFIdwt
 5gP7ODDbceyAWNioFHfXiLQnkm6EnDR3VEc9SoJ4U0npzxrbNMxohBs5gZPhPX3woxrogq7YDf9
 afl2F4l02+Rt6651aTIb8w7eAqO9aCRJyQS3JY21XP7Z1eIRYEp/UXOhCLzfsMXnpK9aLWwlGnf
 3FhZLhkV2Ku/F86j5V0GSWw3mjNsNtgtJAgyPqQqq7USgdLfgR7qpZ/e5ijyCdb6HLq8eP6BjWi
 /WaN0PSxIOSwm9C9jvPjbGTCVk5svYYJkqnsJlPIYxvirF8457MhWbrKw0awS7MjX+ewQ9L137I
 7G4FwbL0kbT3uwCBWSYopDt5MDE9PqwJBv3rvM3foBlewoOkCmGDm5UIazkyrdE7z9hnJAa7KZy
 u32tlZCGCT5nsgZSKhVKgEFNELKWaqGZkKVoP0wz7j4GsgmgjCS2yqJ7u4UqxSPvRTPWChJzs44
 9dXVFQ1vyBBHkZ4AaiffXDUdNZ6zdfM5N/wOAD4CE0Ga37pH4jkodD4SrrYPIX7zi1fuQhSGA9y
 kmfOCiCbp9i5Mfjo/BNCc435Ddz8oD9yiNIDsoNrUKbJvGMs67EzYPiEsvwQU0fcIfTpcFHxgXN
 3o1R83fJsHQn/VTMs=
X-Received: by 2002:a05:6000:46d0:b0:498:2754:6a80 with SMTP id
 ffacd0b85a97d-49c725e538bmr15867901f8f.28.1794834768338; 
 Mon, 16 Nov 2026 05:12:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm22257780f8f.24.2026.11.16.05.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:12:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:12:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: 361eebdd53b6542dfbe737298db14e43e2950bd3
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 13:12:46 +0000
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a453b1aa25fb7b202c5b65c2dd412946a3e6fb96-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSwVz-0000000074v-0cOO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: drop
 impossible out-of-memory branches
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1980736803926621041=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1980736803926621041==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kmp/DeCtI4A="; charset=UTF-8

--kmp/DeCtI4A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail )

Change subject: option=
s: drop impossible out-of-memory branches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: -Code-Review

(1 comment)

Patch=
set:

PS1: 
Oops, wrong commit=2E



-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2196?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Gerrit-Change-Nu=
mber: 2196
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 16 Nov 2026 =
13:12:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--kmp/DeCtI4A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">View Change</a></p>=
<p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Oops, wrong commit=2E</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2196?usp=3Demail">change 2196</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d=
53cc9e79d7a3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2196=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 13:12:46 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--kmp/DeCtI4A=--


--===============1980736803926621041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1980736803926621041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1980736803926621041==--

