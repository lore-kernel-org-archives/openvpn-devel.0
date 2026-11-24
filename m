Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6B606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M09p3V6f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HqlMordh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=al7bU7sw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SWqfqrR1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=++cQTJ59qZGti1a9oetfX6lpLuoJuYKiRTUzwrIAn14=; b=M09p3V6fM10JlC5gNFyeVUcthN
	dxAIezubmSwQXydUI+3Vll4darCJOt0Z2t2QW3Rh3QaI5c6pTxMqK7kmAQL9/6uslsgoKQPfZgidN
	8dk6zOY6UsYZzou64YGgDOJ6qgG5r/r0j5W+zokonW4NNGmKMFYhzaE/2iP7TR/Dql/4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpYA-0000000079T-1Dyv;
	Tue, 24 Nov 2026 12:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpXs-0000000077u-49L2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qo8HH3XC5nxIQksetG6E4mt4U+XCAYo8ohllDLJ12FY=; b=HqlMordhyg5c8kYOiCSR+Qcoay
 7n9Aunaiz9y2xj17UeYpGvn2TFW8x+QMNtJTFHZ3TjXyB1G0Xib04dZzGkraJjkKU6ebc2eIFEGnF
 uQaOkCmcW7qNHfJ/jwrWLoJXdbAwwYy7jH2LnhFz2OvhZiWN6Jk6qQubR3Wdy8Fs2zCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qo8HH3XC5nxIQksetG6E4mt4U+XCAYo8ohllDLJ12FY=; b=al7bU7swN/e1bZd3dp5xxwEajx
 mf6w4ZcX6YEtU61R26jt9pOk5ujZKepbtOg/QHhXG3erhcvn01F37p3j7N8PzAx260FkDU7rbVWsI
 heGhdnyaV0esv2Ic1z/3xMMLoaKhLwKa9NeMmZR9Kwj56lTrpBOjrqOhapCb3gt5yPrM=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpXr-000000000ov-2Si4 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:22:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so2466746f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795522961; x=1796127761; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qo8HH3XC5nxIQksetG6E4mt4U+XCAYo8ohllDLJ12FY=;
 b=SWqfqrR1etEvXMjBE1jSGBQg97kQBgbCUWNb2WkkP+YwFdeQ6mTBpsg/E76qFDZ9Gp
 MGyihYuLSozvFPbX+BAE/EHrup+IrDIYAy8vDrVzvs8+UKhyjbUBrQfG8YO3MDyIUQIE
 8z6KbswYqdlvaF/h0QMXbXXuIhCSgKsB4Tzi9W8kx+89JPUdKEMxBdugtedjRFm0awP7
 HjRSjuFRW/O+OPdmkqXrNpZX+3ksg9BZmBnva15aPeTK08/Ur5NYqi47i8AShDHScdGg
 LgeS49IacUc9IB2Ojl/uJgG7gLKq1b8JcRPsiYER0JP+yjcULg1dCxOni59fe89ZWC8z
 sG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522961; x=1796127761;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qo8HH3XC5nxIQksetG6E4mt4U+XCAYo8ohllDLJ12FY=;
 b=DIiR5eT4qgyq59MObREwbiiI6g+AcOTLeid+v+lCBM1hNMAeZLgh0vfaibeQvLQ+zb
 X5KsPqzkPGZAT7+uL1hSmu60b6X3IC31Uw3mjKa5rbCnkMfR13vDeN9ihW3KlKTn0xK5
 GfgZctLUKr4eG/oL7HnJWg5HQ13HVfDcmUXIV0QYCHHBy2tNklUwqa5f7rCmvdf71OKL
 6EiERh8Rlpn66DYD2RDEIFDDh9dDGkQR7yD2lIUiBiN1ipSXjOnnkntdGzkakoiSX29c
 Cw6szaeYX3MkPH44Nb/PcfppNJqiucsiiZIasU+3bCTEEiXiPQQORX5hSG4kWgJkjbPG
 uYDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEh37LYUZfL/ewLFw/Qwi8E9sCldAAHJnvd4tsxKIRjE6yxxCdwBrKmz1U1ZYfP8WchjRm8iHDgQGYXjpBr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/xignxfbkXEpTtlQO4CRu6wgz6opG2EfgI0AeA7CVW3iSopSZ7
 G7HbfAHy3mfMsVMH/JwpHS2Ov6lEaQRVhUi/L5ID7dyXD7ZvLPyuJLg9zYFmIltLvHdXS1bOWjK
 +wYeXt2W2k/TiSXcmgrVA5OSJFdmQHBa61sxgUB3Nnk+yjKFNlxK4nj8l2YdK2SMl/4S9+rR7NO
 idELQKfA==
X-Gm-Gg: AZFdTZcqnjnvPsKuccUUHUyC5J2kJSDVcBZvceW+j+e7Tef/7Jew1v/+OJW1safe4XD
 EAuLR9KXw821kZkGxs+Fz9AvuLfqgR9g5AzzcwgZtgrEtUAm06xiVXrLTRrlQuzXFJXeqvUmrhB
 aOIa08HuvZF2rtXH/4RQ0yRv1Rie3ck459JHqfiCZrhjGaI8SWUMB30aziqRWcfLnh45hNuoGbE
 9cG264bEMnj+FExW+HnDXm1uiLwW3pfrZMbsuiCtOoRJWeE165eXdtJ9OerpsmZbVasq41srqyA
 0AMEWd78TbLDp5FMqfr9nTJrKZ5NLSQHucrOwUYnsIZeoJw3MczpzZ4cCowzIEBmViGfKnzAbBD
 79WAJvIxGhUZJk5v0C1eCJtln9ET6KcezY8c1B6CS6nhhRcNPzOp6KdBFkUg+lhQ2+zmAcFeTmt
 OEGrnnahqMQ8+S/g+pSwkASBarbcKxPF5Vudjh6QCgJI/6KyB+chOmdSnn7AXJuatuQKe0v/ZNR
 uhCRwJKHQXMRfwFLEn784sIQZDLqDVOdWXkAfc0eth4rMjHA/uuKrOFsRlMeDLtc3W2IX4A7X99
 lpIQ+85/vncR2N3tSd9mqoV6721pc8OcNiqujNUKROBzaRXISXD8toeIkYAS+Z97T2Tx9/eVozK
 P4SCdR82yRbXir0ZdoBkP6yBwEHgYSioTzsMgP6vkkau3b6Vm26UZcc4HHq6QQVN97eWhB/bnx3
 exb0idQNBDE+do848=
X-Received: by 2002:a05:6000:26ca:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-4abb0f3c225mr27050312f8f.17.1795522960739; 
 Tue, 24 Nov 2026 04:22:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm27416939f8f.38.2026.11.24.04.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:22:40 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:22:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
X-Gerrit-Change-Number: 2334
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2334?usp=email>
X-Gerrit-Commit: 091e19b84eaa5fcb61b888d94b7a3687efc3b437
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 12:22:39 +0000
In-Reply-To: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLkllOTAyZGJjNDVlNGFjYTBjNzJiYzRiNGU4Y2MxZTE3ZDI5YjQ3YWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab947dd0083ec968d3ff945f3bc486bc48b8f160-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpXr-000000000ov-2Si4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make the
 options mode an enum
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5570108494795937363=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5570108494795937363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4DwxWMrVvSg="; charset=UTF-8

--4DwxWMrVvSg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail )

Change=
 subject: options: make the options mode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8c=
c1e17d29b47aa1
Gerrit-Change-Number: 2334
Gerrit-PatchSet: 2
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 2=
4 Nov 2026 12:22:39 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--4DwxWMrVvSg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=
=3Demail">change 2334</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2334?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2334 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 12:22:39 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4DwxWMrVvSg=--


--===============5570108494795937363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5570108494795937363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5570108494795937363==--

