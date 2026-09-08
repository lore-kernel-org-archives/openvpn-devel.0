Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA366C79F99
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1yEzFGOmYUASZWZUeFYqj9KvQgW0I2jejKi+WLUkgE=; b=mABmD6hFnaEDWU84h7U4WdPD76
	5L3kVhBcp1uodkivD/vMQb7giENhllJOz5Bz84FihTlaW/Kl3VSQ25vISKtl+NfghfYvKPuQX+OAh
	Qk/xVnH/RpsGgqKheJqrBxylxDqcrAGDmL1MibAnfBOWDsqJQ1ty1l4JyWVbXm25iMr8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ywv-0004q0-FM;
	Tue, 08 Sep 2026 16:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ywu-0004pr-HP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+XFD2ERV42mPV0RKru6dA7ha8EJun4idI5xHMSkNfBI=; b=JkCwfLmXIWmauwblRa77bruAsA
 NxqTfVpb4v2KAf8z0e1Qy7tgOlpVXPRrKlitvHapHQA514EhebfqhUt9E7xc+y/5EBLV2bMMwQINM
 bnmq6uM6kiG04etc1gXsHvipINLf42m7lblt//LbJFKlm2tCQU47y9KBt3s7Ic7t3FjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+XFD2ERV42mPV0RKru6dA7ha8EJun4idI5xHMSkNfBI=; b=m
 YeW94GdzWdafVIKYiFFXZTAl98olfrSEz06hFjE+CqpOxcMYgd4x4Vtw8c+wTaPVZAdw4CFfIqHoH
 uxt2PFoJEtgf2I61IHCjOCjav7RBHNvDObzMz6wiGd62yAKucIwaWIwyqBdtVc3cvRzSfZ3h4opm7
 /db/c0DifopPGJIs=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ywt-0000PX-Rq for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:45:33 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49d0d2d37ceso15971755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885925; x=1789490725; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+XFD2ERV42mPV0RKru6dA7ha8EJun4idI5xHMSkNfBI=;
 b=KfBkNlgyPP126W4KR5tXYaa/74k2Xvgx1FpVmd5IRKHmE3qBsxoGed/FA3TQNkCK3y
 zlWLnGSi2wNU/XpjfCTe2gp9+A5PNjwkswysZyXi6nqfcg3HnmrJ0pU3zfpd9knhlxzL
 kdaVT/qaWPSZMmQofL5aiSLaZMrNAMzt493oMLt93hl6JwtAOiISuYY8UvwS+tcwV13P
 LwJc/yRoEXriQVFDMTDShm1LhHFZZpfA/eJiT0Af27O9psVEc/s6Cc3IVjgTrDTWC/om
 rgmbqWz07+fUlnmMOsJF2NGtnhbmXHcQeZ0Pjxas0K3dtg+WuJvf9bdGCZnAK0h1pBL5
 Oeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885925; x=1789490725;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+XFD2ERV42mPV0RKru6dA7ha8EJun4idI5xHMSkNfBI=;
 b=jlKgcwdntpF06UIensrMEG8mEj558TQApYZLH1GKVScTB8CRX+LIW5nbAGAZoNy5BC
 auCOBce7WxfdFsOsdzCa7WFhYoSS8DQKtVkwXuP5rF+70Fkg/0LWA5SwAupgzun/VBZC
 H3P2P09vg7BPSifNov0dLPBDz85DBQ94K9tae9Lbw8glVDHK0NPv97CPzPtnnjelxqcR
 uluZp/15cWWp9w/fGqHOO8P5y/PwRXFLk0hx4/3usUfZzL9MX1BJyupQ3qHRo+67GR6n
 XQ+jU33heHju6fFX+9j6VgfX8T3ZnMXr0Y0cfpi1lKX6o9mhxzPCqeBSl7ZgavgEm1S1
 b7WA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR6bT+6ycH/GOypDfb1N4Aq5gZVOZ9dJ/n1Ue+k05UwWI0H/2hcE7OHr9gU9eSizqrCCIBaMq+n8qotPLV@lists.sourceforge.net
X-Gm-Message-State: AFuF++ncGI97dumqva8UMpGlhYxn1iXCaU5sTbItzZWYd1qtyYTXkNlE
 TrhZCAXjRmVEdcwdBWyB4ucocA7ubTSCtIomX8TJhVW9+zaa/WGyoEWk9W6EXHI45mu2PuOEcDj
 WQuWpsetJHa22Bouf93ibZ3pAyi7DW+e9El1YJBS1h5cZIU/SX6z8iZHakT03IeM6hSHT
X-Gm-Gg: AYBFou12LuwCkhiW4JNyT+4dbbjqWlHh6zFmNBlpMv3AihFTVqzVKkTg5QVkOkI1qkg
 YMN6+HzBMWawi/9WCVZZ9PqEJJXg4x0t2cTwAEbr23mkFBbZrZzfw2dxBOb2VjL1KiSzyk6jiNK
 rNFVRCkw7sx3zVEzoH5/Yvq2qcyw/UW+OCeMyRh01eRJDk6Qu7HQWN7phC4tb839yFr/RFztCT6
 WEANCQPd5GrEYreqU6gxN1cOggVwm1/bogvM8M4tGgDDhow86dutWhVdAy5H4OcEAVknw7172uw
 KEZN4F8FjmbYCbRycNrNONuJDoH1cZWC/rojJaTAIH3xYLwwrxzasNWdzv31U9fwzmQso3qS6RK
 XPO92WXwiFGOmF9JGMeccn7oYRIq22R9UiXBDt882fxlwogtHjQgt+EBH49zoPJtOAfLA8cP1Ra
 1tz3PSFl10aeYnfCwVadZGoMeRGdjzPJH/oeXJkp/+2sHxH9TAUH3xrYR/awLQsA6RO2mHbVQnp
 tEZZoxXur5ut5Jjs5ZWegDUVQxoE0jA1Jobx5aSpb3/m3dAy9dc/2+iC+h1rTCRoloklin15RU7
 v4ql7pCUzAwcarNNKIqepvMQbHSSkDemI0zy4caF7lVD9ScDWsw=
X-Received: by 2002:a05:600c:4f89:b0:49c:e1df:79a4 with SMTP id
 5b1f17b1804b1-49cf822c827mr270185145e9.5.1788885925000; 
 Tue, 08 Sep 2026 09:45:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb047afsm384165e9.2.2026.09.08.09.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:45:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:45:22 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1905
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1905?usp=email>
X-Gerrit-Commit: 83a0276cbe830f8e28fe239cef35a83bb75d1001
X-Gerrit-Comment-Date: Tue, 8 Sep 2026 16:45:22 +0000
In-Reply-To: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MTUwMDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab28355696e398536519f1ccf04336c40325de97-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ywt-0000PX-Rq
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dhcp: Fix
 off-by-one in write_dhcp_search_str() temp buffer guard
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9080360709457672839=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9080360709457672839==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cxPdu9zKHM8="; charset=UTF-8

--cxPdu9zKHM8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos, razvanc=2E

cron2 ha=
s posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1905?usp=3Demail )

Change subject: dhcp: Fix off-by-one in wr=
ite_dhcp_search_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

Patc=
hset:

PS1: 
My tree claims that this is already in, as commit cedf9bc20f1a=
f01c544489e62da6ff2c7ca82488



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1905?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
=
Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Change-N=
umber: 1905
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>=

Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: raz=
vanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Ene=
t>
Gerrit-Comment-Date: Tue, 08 Sep 2026 16:45:22 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes

--cxPdu9zKHM8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos, razvanc=2E </p>
<p>Patch set 1:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">My tree claims that thi=
s is already in, as commit cedf9bc20f1af01c544489e62da6ff2c7ca82488</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1905?usp=3Demail">change 1905</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1905?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362=
312ddc659 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1905 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Tue, 08 Sep 2026 16:45:22 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--cxPdu9zKHM8=--


--===============9080360709457672839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9080360709457672839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9080360709457672839==--

