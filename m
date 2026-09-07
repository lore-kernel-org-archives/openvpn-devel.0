Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30164C79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8yfhTsGywgA0JsnIyActrOLTaRAAb5Z3vp4OVS+34E=; b=Gg6VAwsNstJUbDL5BSsBzu1cYY
	SdIHcNAX4BJVagT2+54E/eoKCOWZcRcj19wviU3KtMXPyhw6uKBMLrljnzFMqFUV3CCX1vQRSCnWC
	LU9AU8ACSyPrCE7/fLHH0rV0sZpMqmBdt6CQTlQqyOFDmNk/gIojofBgbNqJ1+dIrLMU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3aku-0006T2-Gh;
	Mon, 07 Sep 2026 14:55:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3akt-0006Sv-Fo
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xaKyrwR8H0N4M1ARoUGSzFxPWYyTOo3eUWomU1rI0f4=; b=bt9iMZ7BOamcAqcej+b3JThDRG
 2rEpJi1jhd+XQPa3wkUY6If0r2P84+944h1iAPTkrJpzNF80ot1yi5QGxGqxqWiZhkCded3XJZ/ki
 3sCRew9EaWGg5dim+ggXzjJN+PWuSsTwkM8eSrLmHSxlm6FNKvcRlY94VJKT129BBjyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xaKyrwR8H0N4M1ARoUGSzFxPWYyTOo3eUWomU1rI0f4=; b=K
 ZSyqlPP/jjHw8Y8OiACEvN/vWaEMp+fDaPfc0P2+6CgULETab8GXS3YOlnENQGY6WrHconYo2q6Wg
 26v30ekAk1UTJ8rBEIUifQdPncTLjKB7WC2BXFeWXdytMvJ+ZQGONMEULcH7worgRzrphyv8NsWbU
 QWOSJNLwROeMQtwk=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3aks-00082j-QV for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:55:31 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4858269e3d9so305200f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788792924; x=1789397724; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xaKyrwR8H0N4M1ARoUGSzFxPWYyTOo3eUWomU1rI0f4=;
 b=Dd9Spu7Oas9PEBOLA8AQA+RHnr83jtxpjhdiiyJ6b7WSk4J1Vip7npV0y6Dfyt7QSS
 StktBsnnnjK3nehgFvPFciZdxxpN/d7q6+NAIRf4iSxZVTThHYavUtFstvhrypaNllmE
 2DYiyNJlBHJ0eJCdt+uXyTBd5hsB23+fF6vt2RcRL01Pg1Y92hX4mrbWnCITxhzcjG8P
 akdbY7NPwsS94B116VSP7qHQf1MFnbNBWRw34+Mf9JRViC9yAQtXduzF0UOYtQoMZYz6
 oMm0i2MP+eDMuosy4+A9iQVADXhLM794rINfuE8Tzc8pcN/yFIZOnzW+wqKmyhlSArVV
 UQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792924; x=1789397724;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xaKyrwR8H0N4M1ARoUGSzFxPWYyTOo3eUWomU1rI0f4=;
 b=agCh1uZsC5ZUKMqQf7Cc088GtcPBSEQ7UnH5YJNJMSK7FBSIo5+HfPsBKyIimts4mp
 GN45StL8yuuIRov7vng/FtkMT4LU4zFxZzhkor6Xoq/Ux47ta2A1u+iSyKSigzfQ2EKs
 QP7dXUdfIxMihwwyn+1UjG8oibiZqm0W5qHfyMAiiZEA83DZMsmXaz6jMIKINZd6qQ59
 8k/sqhs+tzw5ptaeQ+jj3HdzcIdIBvwvui3o5YR5N7499PB2z/xf9fMK/z89RELxRiby
 U4xRB9EQxzu2K+leh2XgEx6vcBD5pOOzbW4X9GZbBdYy681tqUNKYpq+8v/x0DKK36ze
 2cPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+r3SbRiWpMY8/PgXbzv+tI64jnR4IaTtIpDoiPhalq4fLjemv4+lGRLVMX+PAk/qyKx3vA/G1NvY4RlEP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kugokCnEeYrJx7FidjElOc7+1CATr0/edwcyBdmMRByziZxuIk
 SoRAkSp870qHYYz8mzKZOMoIqgGJfkHFRyY+mpz78lPLYDq8qbfiyvDzCIpplKcbwrWRp9Lzp0P
 OzcvMxUA3QICPslNEx96QoIDW81NfQmjylVznF0DJgJjexogKIfAaT7nSUZ8hGHYRVWx9
X-Gm-Gg: AYBFou0PrQ1TituWnhF5T7l4UatwJr+kIS/+ds8l3QrNkXwV2i8lika2qA14sX6IMAd
 ibxp2O5MvT3Y3y1n/2ISuSwpAYjLadcOTaDLuLioqv0vcwjewuMsxwiac/X1iHLh2C2iBHBKQzN
 ki9e3gYgvH8wo8Ttc/Dtzt5Bd3wnHIYNX/BgASK0wIuzGLFtCKpP+4o0oV91szBholSO8YsHkqZ
 bBPgDYCoAi5xXbQ2jZffZNH1WXAs5jP/EL7/5lVUYybh7QRAFA7K1Xtp6ytci+JiSFeGrMSld8A
 +L5cov1eDrJ3xn01Vsz7a5irLRH6IjTW5GRafCjPut+NLYRQC0ML2uDi37y2XNS/zzEePAD7MMI
 8pAv9rQn2F80tiG3DQY0vZnERMh0oPPADkvyTlnpobej/43QWPNKu/qR8GlxtX/ZcPLpz35sAc9
 Rqd07DzvnQ0LevUDT6aBjhNP5r7VvBTPUaUuAKrdYNks7NAswAm6znU6eX7awfAolX/Z/e3TgKJ
 wCZz9fZTrDTyv3PwoyWeKA3O90gEfwzwbBoJ9OSH2zQh3JNuypBxiWQhl3PT3HCY28TUdUP8UtD
 LDSRS6nN9NmlfNKCVsNMxdHH1VNN9wME+Na9nrlBjxl5Sl9fNaw=
X-Received: by 2002:adf:e181:0:b0:485:a09c:650d with SMTP id
 ffacd0b85a97d-485a09c6631mr8188071f8f.3.1788792924230; 
 Mon, 07 Sep 2026 07:55:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm30676883f8f.24.2026.09.07.07.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:55:23 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 14:55:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
X-Gerrit-Change-Number: 1767
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1767?usp=email>
X-Gerrit-Commit: 6f2ad2bfd2adf630a3c2dc5916f947541e2b3383
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 14:55:22 +0000
In-Reply-To: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
References: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTk0MjkzMDAwLkk4ODg3ZmE3Y2NmNDA3ZDcyN2MyYjU5Mzk3MDAwMTQ5ZTQ1NDg3ZTEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0aaf55402d7f7256fbac27842159a39bc7f7efe4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3aks-00082j-QV
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Convert Changes.rst
 to Markdown
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0679090863287357509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0679090863287357509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MMxEYuDF5Ck="; charset=UTF-8

--MMxEYuDF5Ck=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1767?usp=3Demail )

Change subject: Convert Changes=
=2Erst to Markdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS1: 
> I suggest the follow=
ing further edits to the =2Emd file: [=E2=80=A6]
Incorporated=2E But also d=
ecided to completely reformat these lists=2E



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
Gerrit=
-Change-Number: 1767
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Co=
mment-Date: Mon, 07 Sep 2026 14:55:22 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--MMxEYuDF5Ck=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I suggest the followin=
g further edits to the =2Emd file: [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Incorporate=
d=2E But also decided to completely reformat these lists=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1767?usp=3Demail">change 1767</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1767?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1767 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 07 Sep 2026 14:55:22 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--MMxEYuDF5Ck=--


--===============0679090863287357509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0679090863287357509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0679090863287357509==--

