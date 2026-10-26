Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF3606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z4QP132C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ay4V7foM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cHNCPhXW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jy0KqorD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UCbXg+KOEdT0K7lFdio+bO8LAITD3ZwVuSW7NZJphj4=; b=Z4QP132CMUc52CePqNQEfEeykG
	Jem9NWWxn420heOcW0kyorah2lnJydGA+1Z9vRMDsaM/uFAGMLpaXXKlfQB1d4qe7SwQd96SkUx/V
	oMUKSpHJeJvDGsQ2iwrcpYXxE5Avon5tBkxRX8HmtlY5BGMR5if5WWx+DhtNvc0tmJVU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIac-0000000021I-3Ku8;
	Mon, 26 Oct 2026 11:10:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLIab-0000000021C-2L56
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IhiV//kfRSQ+Bc0pRI7x75Rc9G6uC2H8XLSc30EQg8g=; b=Ay4V7foMqCF46uo3utbCt76jOf
 htZty25j5Mik5UIw+tT/39cNoEm64aywBVBwbrAMqrABUrGMcYNVtDU9hFFY61M2EjOKJ+nGLvtqp
 onwt4Obm8B7XazBL1rUPTiatli+ghpw2g8Gud+chLRe+tSXcnTCxSK1KpTciFzASMiWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IhiV//kfRSQ+Bc0pRI7x75Rc9G6uC2H8XLSc30EQg8g=; b=cHNCPhXW7jya1MNf2bdNNxadlf
 qrO0YXHZlkaytHLh47MwzuXiksdpYfTqmAgx47oGQgL76IkCUkqtTFluKb75ZWxMfXKMjglpca3Gn
 gmqd4l77CDgGNzLqCRG4RZDY0O0cyUqaEN7qqtwd5tB33XGVfMallRXLSKgMDIGAuzhU=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIaY-000000005CS-0qX9 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:10:05 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e04773687so867575f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793012995; x=1793617795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IhiV//kfRSQ+Bc0pRI7x75Rc9G6uC2H8XLSc30EQg8g=;
 b=Jy0KqorDKNDcKvXCq3guCQwISyw4xL6u4lcsnRnnW2pTKc7AijUPgpce32CWfsPcXy
 384Gs6WnkQQc4XIrNDFNxbBZYx1fCuBS84ZVON1hgK7ZoUGcZrtx9LAk8NVOXH6wazaX
 7HIjt5VSkXmpumFs4Jt3xX6JveKlIQQ/pAN3ZgBWDzarp5ctWexerCFsVJmOpoCmOVHk
 22qeaOzmHiwxpbomEBbeGUyGTy2DXBKpN4i7nvkrbtjZUHBqBIoAXvjHGaZ1RmSrMtZI
 HBYcXKeLsEB3ICTu/RZS3JO59hhIrPv9TjoLjfQO2WNUWmpJoLwZFqnR/bmavspYG4Ad
 emdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012995; x=1793617795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IhiV//kfRSQ+Bc0pRI7x75Rc9G6uC2H8XLSc30EQg8g=;
 b=UhZqmeaFOQJWV/huXmIc/qwsDo865fqrba500ZpOxKANxxTzZAzpLdxQvSc98R2B7L
 gVLTQLe42OS2SERUht/ayhfByq7UhbI3dtjGr568qhDMMZAqqVmDUka6caQ3EqGtuyAs
 9ZVm9+kQLG8y4YfpdTgOC6JRgVA8mpRFs6EPLWHeB0drkDEy8DPdtK78MhowMQ12KN0a
 cE+cvk0aUz+WcUwcLBaROQaYd3q+zW7dkkoqGPOqcybndMTIoH1bh26YIRp1ai/JOcdV
 XJvqWlAPdssemI5hKL5tgCboSaZrEQsJJ/+07OrxTkOuDm54XJhtW0Rj4prr9Swbtbph
 N3Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdA6rdwgRIUAUJTnouY/HDvwJg8KoCCHXjhEp3mvEPeohyKhnGk4eXYyfse0fwZZdzrresLu2q8iZrOwrC@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKGnfxKgfsHxgZGyz96fwyXsXBPMvxv0DIV7K4qOi3zU8l+QAsR
 G9OGftR4WBGtqR3tuQ7HnmtIuPK9Dj5yIk4TdEmwpN3nIR8mvS2p+n9MBr0f/yrkaEcuHjNBt79
 Gxq8zP+oI5L0VWOJ8QRcm7pAPSkTP+Lzlw4MnkLu+9wxZbh4/hYPO+YqeC0L3W70AiKDV
X-Gm-Gg: AYBFou1acvsMR3HMvNOs9BTEf0GrRYJ18Ov5V/iyVLVmD0EPYWl2dwPRmtG9261zZcD
 gA9PB4Nalv+tmI+o2VbeI5InkKJIFzi8JTNS51/1r3gn9DGcHrpDDQssZjGCwHvVMk21KB1kliF
 alKgNJdapxRI7M1MH8krA/rK1mPRhf37ftKGp6VxPgTtHD3u3pu1PRZDb1PIrhrI3BvQYYXWtZJ
 CeV6F3QrC+mt7FUFIeyDmxHZTZxUvN5ZHkpvNUyUs/tRPRUaqpfvufE8J1gOxR9pZFAFNhwQDuB
 5YOs3FRlhP35BM9K2SsjvWlAifaaB/FKyMJiPn/kJca/EDxId4wo1F5VRqQEIyqiXcXW4c0cSv1
 42hr2hg0SCYQ+z4Nyw/Ee5T+Nki4ebcxN8P7BWsLOucMzrzDbEbG8HSX0DtBIERtXRqoOyWh/+/
 etSOUSwPEP1Scvycy+pOXvQaJPvdDZam+DnPEUvgvGqUoeXwr/BoqbZ2SBY1rnMCYNbT0Yek1mu
 E5z0xFvDgg+SSXKFXs17KjtP/7xjxxmhlAEXQLhQ54TNiGYj0jCzuafnsqavp+pvu418fYML3af
 cqRsP/hNFTwM1tmMj4mIOSumd04MyN/g78nnXDmWt+ZUFe2vBUoHsXzi16tKx0Vz2s8xoZTkuug
 HXv8gcFuvJ+6ESPSSfIL7kwsd6PoiNpVF4n8UYm+u7Q==
X-Received: by 2002:a05:6000:41d0:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e3eb2bdbcmr13057851f8f.7.1793012995045; 
 Mon, 26 Oct 2026 04:09:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb9cesm16492595f8f.27.2026.10.26.04.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:09:54 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 11:09:53 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 5801424a8dd19aee720526a3fb963cbcf9443206
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 11:09:53 +0000
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <23a26634ff16a821374ed5b797a3d7fdd6047741-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLIaY-000000005CS-0qX9
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2263828652946644106=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2263828652946644106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nr4wwzwYZlU="; charset=UTF-8

--nr4wwzwYZlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail )

Change=
 subject: run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the default=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2033?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Id206b12bd67c0b8a014a2c62277b43b18debfd43
Gerrit-Change-Number: 2033
Gerrit=
-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct 2026 11:09:53 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--nr4wwzwYZlU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=
=3Demail">change 2033</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2033?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2033 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 11:09:53 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nr4wwzwYZlU=--


--===============2263828652946644106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2263828652946644106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2263828652946644106==--

