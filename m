Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E7606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E2Ps1rEc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kjdSkLbe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y+k2ogm1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Fy9qGORI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mtN9ivd98Jf5WIjlscQZ91Xyr5W+xNMbNYAwY72oGIw=; b=E2Ps1rEcQFdBxvtrhMFQ81krYN
	aH11yi3LKiJzqIp9n+tnbj+7JNoBEVCl25dJ2BouBykAKAKY6BqD3vq8EQe2VSt4wQwXOqhGLJmcR
	FGNHS3t+hdLzMSiANwQYtvYWUAwr+W+l9uSgj5Hl9O4Mrskx7MwcozXBaUWVhpN2NBLg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBMS-000000006o1-0CDT;
	Tue, 03 Nov 2026 10:03:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBMQ-000000006nu-2Wq9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OD9v0GlM1IZTM4L/NUGjPkx4g9uSOt4rB974zC9JDJg=; b=kjdSkLbe5O63VWFELi/DrO7I3B
 B8D/nAf/1ncnvZ3XrA04+bO3Aj/Er7dHyPfTespXuSvlDAOWirvDgZAO/jwcZeQ79eG1wPwDltaOo
 7Q2+kzA22qdCT9iQt2Gi0dolk7b1SxEfeB1UH5JgIXwAjkoVayBNrxndpj8PrKI5W+Fg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OD9v0GlM1IZTM4L/NUGjPkx4g9uSOt4rB974zC9JDJg=; b=Y+k2ogm13ZYq1UsIHXWc1dUg6t
 HwkoHkXVsZgUCLUBMBUFgRX/+3jGF+YQxodctGk/qaL26IoCJvkxFq06OVZYEk9d4UZMTK42t/uJk
 Mi4bMtriK6GhVtj9SUi8JfPYz6huPjlsPNVIsPRSJBDhxewVc8SCZCKs/VDkarkBj6N8=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBMO-000000007TI-48SL for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:03:22 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso35012675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793700194; x=1794304994; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OD9v0GlM1IZTM4L/NUGjPkx4g9uSOt4rB974zC9JDJg=;
 b=Fy9qGORIFPI5QMf9rzlFQR+Tok9egJeZsKkPGlbi5NAmLeD8kHC4Pvr/sUuczZdl/u
 UDBmogkWzkqmJzVmSX5QBOA1eTilu3icxSHg0F6TluOsDLym7AZRx52POfYI3fj48A1M
 1Uw0uL1QyIrTWr+J6ZaM9j+3IhS5Lg/nJE3HYB2TqG6uPFt/pF5rLnt77dFwhCv/cKcM
 /meVGmrIraV/EkJzcA6xs1CpqeImul9YXdnQf7Wtt1W6JirfZFWj8Ar1xQdt0XcBx2ZX
 ErS8VnhnqekMV1Q2AKMLMs1FS6QEHJ8Nkzz5cntDtMP3AXI9eloRo4TjIK9e3Z+LAybI
 nIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700194; x=1794304994;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OD9v0GlM1IZTM4L/NUGjPkx4g9uSOt4rB974zC9JDJg=;
 b=YYGi21E1jiu5hNRN59uMhM5biXCE4/3L2/2SN5xrKlcTUuKb370avL9qQBajcedhPR
 vziZcukQyfTIj+mFXiB1CGinFjmesz05P/wmfP78TbeLUKzP1VzgPvttknX7jDX98aEp
 gya1j5N8z4HHHoYBrzl5FpDKNuY/Ei31KvkuLNhn3GkfsbVImGCernb+fZmJpM7sIRMn
 p2T6RJixg4PZaGakx+RSZCU45fA5A5xmBN432ztuIXnv8t4iXSHL4xqlvxvFjCbqNbBv
 yAvy27pLOI8OYhI5wv3im+z8zhHqPp1U8PgXP77K0XdHbB//2T7F/TDiX/eoeqQei4oa
 /mKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoRHHOZoLS/0JYnO5VcB4AsAncA9liNa9Jw2jrOY045gchSDTtN8WlSYxgLmMRIYYybWnhptKpBSkDRBb0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9rs38Dt7sebZ8/JliMMIOVDUcGxU4tavTJ2yG7AaGhsDsj9cej
 AZBlZ3zpvk+xVGVDWTGrnsWHV7PoRU9hcoZ58aSWWMkokfEQjt2p7E3Zo7hFYh8kaXd+mXn8CsI
 kM6e6H5Rd4oyAnJzUCgl+JiL09CtvY7oM8AIBotPmk3CqH1Sy87vU8l/iAojcFM+6MvoiKePJZ8
 JuX8UreA==
X-Gm-Gg: AYBFou1mCPnxrDcB9MNyR0DchCFRBsPFxAE5aAkTr7+Vx+JpA/IzpkMrjIKlIG2voH1
 NSy9N7NmlAcjm80HzWOP/y9PJR4MRsa4lCnNzGxYWrfdkDxxmhNMYmhERKiaFl7v5BNOJ5OLwez
 /KxdivtOwo6DOgYoBqqrCYUg5sJWdAmFIX6pyx2utrNhD3qrUY/SzBW0YEsclLcGo87KpG4ustZ
 Zz4Ilq8pA465mJ2imqp7HV1Pd9jPFguaOAtW9qv+gjv2hLh+eIiSoUCKubhRvfos1v0r+HXpV7x
 MXyWZqsbXEnjk6u+Jn6lX3q/G7ajssda3uTIHOx5mAPFRO97ImthKJ0klvK3rQ8QRe3Amy6SMIt
 +gMUlQzwQE3zf+yNrFLEMdC9uhv+Tqw/1GsiwfM5nAUHNQde0HB/Ef547TyUkrndja4S75lEFVa
 BxlYQgrDnJHdvrloVX7V2B5BYbowmkPnBcM7PWcUEP9mLSSEN9OsrJVuavS+lBS6eawOqOZ20Nd
 Np0PNDQeglqvJg+iL/izCXz4vrYaKS8D6oNC7or3RHg9qrJFmSMeRBVkgk9/txv6EBolvfuNM4Q
 Pz8jShHEa6qK61mMxbJN55fEJC7lLx5XVvyV9Nesx0QFLFyAxd+v6vE7ppzPvbieLeJXpgudAbs
 GKS/n5Yg7ztlNPC9ECn43qPu3GsCy6cGLq2k4D8UgcZXGyaMs4CsGMr8X+Op3Vx7JXS8P2r06sb
 WvECYJK7fHB86Z222wG7FbJjezzqL8fOqfO+M=
X-Received: by 2002:a05:600c:4e50:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4ac16bc461emr289348155e9.7.1793700194195; 
 Tue, 03 Nov 2026 02:03:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea72254csm173111235e9.1.2026.11.03.02.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:03:13 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:03:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: bdffcbf4c648ffabd4d06de8fd5263ae4b71d203
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:03:11 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <44375ba0d96f9d35020460feb7d43f0fbea80042-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOBMO-000000007TI-48SL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5944383768074997323=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5944383768074997323==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1J5C0Dcoeg="; charset=UTF-8

--Z1J5C0Dcoeg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E

Arne Schwabe has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail =
)

Change subject: Introduce get_key_by_management_key_id helper function
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 14=
: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4=
2d8785959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-P=
atchSet: 14
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attent=
ion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, =
03 Nov 2026 10:03:11 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Z1J5C0Dcoeg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Gert Doering, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 14:<span style=3D"border-radius: 3px; display: inline-b=
lock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +=
2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?u=
sp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;">=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1856?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Tue, 03 Nov 2026 10:03:11 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--Z1J5C0Dcoeg=--


--===============5944383768074997323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5944383768074997323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5944383768074997323==--

