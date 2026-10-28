Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8F606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mMen3MMM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Jp05HT3w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c+ffHwFW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YfJhbTor
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1qAnBOL2k1lVmHodKT8Ng6D++gX0oKrtWrQTSH1pYgQ=; b=mMen3MMMObiDduFVF4uo/ZeV9L
	KJirf5DlQY2CclpqVp9ktIeYibQFYXjw+CYQoKjhiBXJ8lhyzcRQPvR95UyFBG5hf63ABB9A39BaE
	LMxjeOhQR+MZzarIrWKMIKBOvXlJLq4BW5OTtkl3tRrFHTe7IyI9ptcApHece2E5ZG1A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM2b5-000000002iy-2hSa;
	Wed, 28 Oct 2026 12:17:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM2b5-000000002ig-0Y63
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:17:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HcS0/M09kJbIe0pVHxyxEW5FCJ/XymZNNTiyl01uI/8=; b=Jp05HT3w8qubC1kvlOTVDvdIXj
 OnHHvDtQLV43LnHR/1kLEC1K9dL478rd11lYPwileFFW41zsWJxzxt4gz554/ShqWZ1WbDnjoBowm
 KIjqf+bv2PNzdZpaNQfePpWr01ZTSZWnVfN9fVfyBqcIt2S5El1b8oLomQ9a+OBxDNcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HcS0/M09kJbIe0pVHxyxEW5FCJ/XymZNNTiyl01uI/8=; b=c+ffHwFWqAfQ8vsMQdFFSiBUeb
 Gh51qYQ0o5bdefCWyR4qsj/839KGU3z2Mic3Yt07P060l4UP1/AHWSLSiUif6gAQNxDCLqeRY8RYX
 cyDX9HGNNfvvefe95mg3xeCE3PLanPhA3+MRwlKVUHR49aSRO+X6OFiFdwSvgeRlclP8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM2al-000000005FE-3j0e for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:17:22 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so782266f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793189833; x=1793794633; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HcS0/M09kJbIe0pVHxyxEW5FCJ/XymZNNTiyl01uI/8=;
 b=YfJhbTorukjJB3nMsOzfFMyGaRswZSwi1cjBKy8GVNfU4P3abe2AgKwV5t485GjZ1+
 0e97Sa90xEyzTcFBLBXep9Smzz2GTFLPnc/acHR29+qEofczefmip46+gJJEUwzI+Ngg
 bd47/JSRsacsKlytc+x6+Ns551zA0huEMHhfc4XBTSxrVbjx03jkEP3TFkBcPVdiOc4M
 ZDvS9QAYacOTRh5Ish954qS7i6SIBK41dVqPxO4j/785yis1N9ZmR8pLU3IhINPTtpcT
 /oqK4BHRDJ0z8WU3SrbY+4iTTF2t1aV7SSrlAOD5MfTILam/3VQ6jo873C94PlmqlJlb
 2Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189833; x=1793794633;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HcS0/M09kJbIe0pVHxyxEW5FCJ/XymZNNTiyl01uI/8=;
 b=qqMOWGm1S7db9gE20tnVGISKhiabVdocSA8DHwWX4K2dsmkh7mJmSx3VMK0K7QIt4f
 AhnWkvSU49rcQccw5MJBN+92C7+CNi1eb02Pe7sTTtVicB+Sh9TliFhKJ/stY5KNyhyS
 dD691FEaEC5Cnaowv8Jb+gP8amm5bwEtNknxeV/dOvbx7x9aTn8a9m/WsBrWrZn6SoRN
 PNSN0N2cfJZc1qqqCnh/pu2DgKjCQUxFPzzsq107lgMWdk5eQrw6On6RQ4B7v4oL35a8
 nCxRvF/Qb6CI+E1QKjwl+JZd3Rq7zp/+uV6joynIvAK4bv++q0xCtVzjgX8bJb/tbhiV
 wapQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykDEXE41BQG6MQu3qr7+NRVLs7F0ORYsvN7gD6YwGeVsw6mrtoaP2Fghc8fYZdftWFms2O+YW6Dr7Ub9tB@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI21hLgZCI+5ORizo5eA9Gkc3tk8G2bSaVe3HIBgF1IgjhT+0GC
 /O8NV3PZh26KB8Yoz2B6tNoxAhokV4TvGCUp5PLIyJDL9zmut6K1pTSJQoFR0JwTOsPhIzv2ULc
 eLdl4K/K8ju7az1diH9mRpwlGVZIB3mFHldtNtvr1OT8XEFFtEclyVebgsTzUzrUGFlGH2XwwRj
 TRak7pRQ==
X-Gm-Gg: AYBFou3abwvMfU3/2FA76c/KiI+gEK/DAcswsiHdcoddCP4maKzZDijyBnJerom2K/z
 PT/CEXKCeIE78zIQdL6MHw4k7JnloLvT2f9NeDmiWae8GkJ+EjeWheZUaVfwHQM3CJF2l3pmLI4
 2FiEZaU0qf/dfkHYNy6EC+I8YF4Ur+ZApEn/q2KMf2GbcVzWSqSTdO8YjtMr1A4pJxMOLkzDRUG
 CaiJ7fPzmqpw0ZkTuzUM3SKiutcWACOyiDbXVBfTnkcYtbVFVVXQwMS70s33CMlL5lTcnFwc8OF
 j18SV2oeFvuUQ44CYiSAkko48cZ+iJhOeiNP8FgRj/l+w4dbxD80rlsX7jykMUNlspJianR2zXw
 44aIsv1hzXBNzZXSpNsHJXbdD6WUqmvnaj+VaCX4lmDKkNHjhFHQh0IIwkpjvk1JBcWTTx8lrXy
 1uN3JmdKgQdM+4I41OywN+XQXmO6NzHYOTW7hcMBfK3hlBijLmUvhCeRUb3aK59UbXEOluigVhl
 VxTYboDeCl7jQ5GQRh3G6d7C76cN6bSqAl5/pIb286YNm85HkTiie/xysBNOqT44GFYBrdXt2tj
 fjIxD/VB+VChHUugX5tEVr3CN5Jd62vg7jALo3c3a9wcHUkM5t0UJ/4pjihDpmhR/fGWv+Trdeo
 DgLd8Pnan/873er47WQV6SAWduCYigw/8N+6UUPqNHeBcH0Zyyuz0StSeEex1jKUNCa06wBn4Df
 dffoKi6fmtZNzOAJI6
X-Received: by 2002:a5d:45c2:0:b0:48e:f10:ce31 with SMTP id
 ffacd0b85a97d-48e5d2ee8aamr4428843f8f.28.1793189832914; 
 Wed, 28 Oct 2026 05:17:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm28094098f8f.4.2026.10.28.05.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 05:17:12 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 12:17:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: cadb8ca8c1ff8c268285fc89bb059e4623e2e0ff
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 12:17:10 +0000
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e64c205a908a969f140d3b669bb6ebffdcec721d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM2al-000000005FE-3j0e
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7681736206433100619=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MISSING_HEADERS,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7681736206433100619==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w6ALVmd5YlU="; charset=UTF-8

--w6ALVmd5YlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2058?usp=3Demail )

Change subject: Mark buffer in=
valid with username mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(3 comments)

Commit M=
essage:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/54232f58_f=
c9190d0?usp=3Demail :
PS1, Line 11: not mark the buffer as invalid in those=
 case kike the certificate
> Typo: "in those case" -> "in those cases"=2E
D=
one


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/678fa24a_8ccf=
f2b4?usp=3Demail :
PS1, Line 11: not mark the buffer as invalid in those ca=
se kike the certificate
> Typo: "kike" -> "like"=2E
Done


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/3f1143b3_ff219309?usp=3Demail :
P=
S1, Line 14: Reported-By: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/=
issues/1137
> Minor nit: it's usually "Reported-by" (lowercase "b")=2E
Done=




-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a=
22f914e76c1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 28 Oct 2026 12:17:10 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>

--w6ALVmd5YlU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><p>3 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comm=
ent/54232f58_fc9190d0?usp=3Demail">Patch Set #1, Line 11:</a> <code style=
=3D"font-family:monospace,monospace">not mark the buffer as invalid in thos=
e case kike the certificate</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;in those case=
&quot; -&gt; &quot;in those cases&quot;=2E</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/678fa2=
4a_8ccff2b4?usp=3Demail">Patch Set #1, Line 11:</a> <code style=3D"font-fam=
ily:monospace,monospace">not mark the buffer as invalid in those case kike =
the certificate</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Typo: &quot;kike&quot; -&gt; &quot;li=
ke&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2058/comment/3f1143b3_ff219309?usp=3Demail">Patch =
Set #1, Line 14:</a> <code style=3D"font-family:monospace,monospace">Report=
ed-By: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issues/1137</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Minor nit: it&#39;s usually &quot;Reported-by&quot; (lowerca=
se &quot;b&quot;)=2E</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3De=
mail">change 2058</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2058?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2058 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 12:17:10 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>

</body></html>
--w6ALVmd5YlU=--


--===============7681736206433100619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7681736206433100619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7681736206433100619==--

