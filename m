Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7B606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CjdRmmpJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DenyT13v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=if4dkTb8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gyUVPkqg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MJZh+eW2zbRcrEuzlliZbReCHauXAl/7JHC4F2BZwdo=; b=CjdRmmpJ/8UXSU1Ydoqf5IsRx5
	w7+8c8amnqbd6tIyDItLVy+vV3719uuPpqDvKUiKEkIIxTZ6Ejw2kPOjI6lLcFQlr9co0GkuVxaq6
	Xd49uh/O/9ETFO74+r3/8Grb22iLIPa2dBtE68Z8BV+ZClB7MrhBF3MNINOI2AMsHzWY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW6tJ-0000000009d-1Nch;
	Wed, 25 Nov 2026 06:54:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW6tH-0000000009O-0C2C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SUiqCC0fzAFnV0JurP2lcxCkFY84hsIegQEB7QnC7q0=; b=DenyT13vvRThZeATyy5OWG9qja
 SchdSAD4rUJC1qDZ2ptpKxrlQiobUN+PUwc2h9pSZzgnK8fFXIKuwhEezQs88j1CJuw9O9iCtIfII
 ecnla5kkaQhujDC5QDtQbQLg/uqEgy8ybqDpbqkaOckspfrOMlL2yXF75jAtDL2nfe28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SUiqCC0fzAFnV0JurP2lcxCkFY84hsIegQEB7QnC7q0=; b=if4dkTb8Qa3ixESvli+8YQ8F81
 N4M3joaqZyctvzUm6rLJ9Is1Dw82ZqiZe4/QuMDCFR2FsESh9uJR3KmQRz8BLqKew03OuPEMMiuhI
 6Ejm7d4lCdLc6KDLzT3XkqBQFZIRf00qwllx2MQ+g6rqPmB87Sbu5VgSvUxW/Lk8xyvI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW6tF-000000008O1-06Uh for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 06:54:02 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so5014987f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 22:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795589634; x=1796194434; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SUiqCC0fzAFnV0JurP2lcxCkFY84hsIegQEB7QnC7q0=;
 b=gyUVPkqgg3L0vmXhaxfMaKfx5BeXr41kdvvkh0W99virg73LGiX3cpthGed1ZpzR7y
 DAGZDUdQTd9TF18caYnjCJBQnc3uz/3Wm+idYpzKwuuYWx2Har38SBSJYonm83+NUHa4
 yuC03kYnBf5gixURMd2zgYtBm/QwPwf7bkZ+Jxtc9KDN0Ffi2AEwuac2q5eap887Tgwo
 c7DTS33mTIpciCA304tZtR0KJ23/FLOwAs/SpwGY5E0cb0utZwwadnlVk2aMsN+lpTef
 FIzDnlmgJcrzUxmlUe5ywOG15v5WyqZSAzZFXmbNthG8D3/X6+rXPbpB9deP9C1z0FIc
 ePPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795589634; x=1796194434;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SUiqCC0fzAFnV0JurP2lcxCkFY84hsIegQEB7QnC7q0=;
 b=SynCc/6pZBNaAzR4YEAgQNkTpCgSl4pGKMnM8r4+eNVaXYU8RinRuGm6YMRAY6qYzZ
 Pr0n4so/GYw5xo8qJyvQMckHRXL4LkMerHAGAWN7g0SFOQrxWIQM46pLgOT/wh5L+vPd
 3wxxYUasRIr8BUQYVP/cbthPxwPR8bb2vteNhUiLvr510lTEf5VQ2iYsKn7ZCkrr00CO
 b43lZJ3PLchBMOP8OB/60nLZH/m9KOIOvNx1/TQXbUbEgcqux1+j5jorsh08nu1EILbd
 Le+gtQVejWFYfVqIwLpwT5eBXq0QV2gx34X0pJY1gnupdHlYlvOB235Yk75rfXrxxNSc
 WGDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFosJVYIQsx7InMNZtGzA2KKZhTNmXcHzIaZ5+U87Sj0ES//to2yZ1TYtLB1nEUV2J/cKb2gp6xJcG0BAWT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9AOHxdmAxenqtsa25nfE7iMYU9OVIyrr3CedEG70hh+uRgkxh0
 j7+PfvLpLLDBCuhDea9buTexbBApKml1Fhex7wFzh0/DqsuoaHE9R3niUGbFdzjUevLqyld9nDe
 2WoQizIxtxrnTqKn21S8UeqED9/XLoCpm0+nJuYYgZHdre9+fdosuLtxKLsCsqfPe0BFT04+XS3
 102VEncQ==
X-Gm-Gg: AZFdTZfHVhMSBPeTOvQpQEPotMzsng2flqFg6p6mz0HgHN6FyuS4w3LFakRorup1owv
 +4I0pRAa8bIIMKyY2YeRD148rz9vsNR49HF+9UZf8pO1Ve8lrP+G8qK8VVcy1s3cb4soV+B1GsS
 8LmozDuO3IrlW4sTPZLseowRnWs9Pgy7lXAqCTwHMgdd4SU0Fpfcy79qnIpDU45XeOCvpO8oV/9
 jqPejDhVqs3uhtioXs1Cc5k7Wi8YkzNYTEbc2xiWDuTDyYyXVzEsnfICh6pwLoKe5pZzxxyzmAj
 ZbGprE7e9fINVwWatMS4Spv3nhSnPznFsVXUkr0ewFDnzUbmxU5023p+oLqP1Ld+RZF4F3xV+lg
 dd9ZK5aQMMqjkGFrlMrbOXLMA8mOHTxUPm4Os252/cHUZFeXPRNtp9DrPyb9mes7+Zp7zhUe2sk
 Fi0ApqLcbU5azmdE+twLxax/XGWj4kIdsXKLTMEWqV/7mYTY97y6ONmhUDHJ57Qjnw9+wp8QeYB
 DI/4FestlBnhoIsI3ntWrghcVZv8MRBF8E62atDW2cDDMHZN5EqMz+yf8fiTvj4Dv0sfoNzaXvj
 my1/AcMlP+2UyBRMCghiq0BfRwpygOnCrZ1c/DNK+c8CEHTkreWnDxfx6OTPK7XGb8KiBtbhWwv
 gDDilmGCjUyCby2kk1ynf5TdBi9a7HFWX/cK0zHJjRizjGtFobuV0PQg5b5dvkm3BjbB9wjU+1g
 AaC3xHqTvy/dQKB/E=
X-Received: by 2002:a5d:5e89:0:b0:4a7:5115:22c8 with SMTP id
 ffacd0b85a97d-4ae3aa4548fmr21889871f8f.48.1795589634261; 
 Tue, 24 Nov 2026 22:53:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm32928372f8f.16.2026.11.24.22.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 22:53:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 06:53:52 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: 5aeb3a3f993032b6f77be9c1303a767720a0897b
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 06:53:52 +0000
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d7aa43516a6ee0031f74ceda5bff98b0caccf33-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xW6tF-000000008O1-06Uh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
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
Content-Type: multipart/mixed; boundary="===============0107705815531154420=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0107705815531154420==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sy8Qu+HFZbI="; charset=UTF-8

--Sy8Qu+HFZbI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail )

Change=
 subject: Windows: Switch all uses of address family to ADDRESS_FAMILY type=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review-1

(2 comments)

File src/openvpnserv/interactive=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/comment/ee0ad0d3_d9620508?usp=
=3Demail :
PS1, Line 1909:         MsgToEventLog(M_SYSERR, L"%S: could not =
open interface key for %s family %d (%ld)",
This is changing the format str=
ing for `err`, which is incorrect=2E


https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2342/comment/bcd116ec_bd27eb66?usp=3Demail :
PS1, Line 1917:        =
 MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s famil=
y %d (%ld)",
Changing the format string for `err`, not `family`=2E



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I225c21dbd843601b697fe712=
b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit-PatchSet: 1
Gerrit-Owner=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Wed, 25 Nov 2026 06:53:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--Sy8Qu+HFZbI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/intera=
ctive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/comment/ee0ad0d3_d9620508?usp=
=3Demail">Patch Set #1, Line 1909:</a> <code style=3D"font-family:monospace=
,monospace">        MsgToEventLog(M_SYSERR, L&quot;%S: could not open inter=
face key for %s family %d (%ld)&quot;,</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This is changing the for=
mat string for `err`, which is incorrect=2E</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/comment/bcd116ec_bd27eb66?usp=3Dema=
il">Patch Set #1, Line 1917:</a> <code style=3D"font-family:monospace,monos=
pace">        MsgToEventLog(M_SYSERR, L&quot;%S: could not set name servers=
 &#39;%S&#39; for %s family %d (%ld)&quot;,</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Changing the format =
string for `err`, not `family`=2E</p></li></ul></li></ul><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">cha=
nge 2342</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2342 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 25 Nov 2026 06:53:52 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--Sy8Qu+HFZbI=--


--===============0107705815531154420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0107705815531154420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0107705815531154420==--

