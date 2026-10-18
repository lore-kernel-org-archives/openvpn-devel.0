Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE35ACCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4GMM2jw0nsknhLBx7C9a5wF9hH8xA6tZQZzk/wwNSg=; b=dEr3MFQpU0UvdzNruqIDiW8liX
	7k4ytoxhUs/8JdEInfpDou1J4KZHX95xWYotmWKzYee5RsL+WY7lFfW9y/l8NI3AtrVWbrOfXcmoQ
	xe9qs7gQA2Jd7QgA/zf2IbqasH+f5l1cbuhGTRu7PnzpMFRi6AysP6HSlwMhp4TnLmpo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISwu-0003pJ-01;
	Sun, 18 Oct 2026 15:37:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xISwt-0003pC-4M
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=unJw1UzI4vb+ulhpTDKp8rNwtFClhpDgpgvWapAFW0A=; b=GZTqtgdKlJLpV/p5mHWsMsHSUq
 5EPNE1Wbr0BH96YEbGFnhbDPVCLaNOrNbB7YA2uU9NuslFMTckN8CVhMhM7iToDoTggeU+FZx/7H/
 Y7nRtp64UhINOmkC10kAIZ5C6/wyfKvMhbb/CkrEHt2CHv4kIFtfmv/zA5FyhhFLymcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=unJw1UzI4vb+ulhpTDKp8rNwtFClhpDgpgvWapAFW0A=; b=T
 EiRq5puTS7F/+cC03PfnD7BevQtYC+lfuycVWPv1Bu0SA8YCazanmybrfWeDpiaXY4lkhGmsZUp2Q
 3eJq7zd0HL8H2AlBYjOfW4PkS1tomf7U6hUFB8l6NAcoZnAAdUdD0TgklWR1f41uaQV8Q1lxOHHtN
 CsFCwJ6ZWkvy0iaE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xISwt-0007om-0w for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:37:23 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so9551175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792337836; x=1792942636; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=unJw1UzI4vb+ulhpTDKp8rNwtFClhpDgpgvWapAFW0A=;
 b=J8hF0AqzZwFpmuvg1BHKUrumtTTgU1jRZk66yymkMRWeQf7/Gp1aj/eHstuWl+t+hc
 JvzBDlBQBh26m36CRfK/+6ZSYMVk9tzbV+JANPNdZqbsUy1Uf00QHeCH9Jo7MN/gmLwE
 qLAXMsAXZvxbxZDsqXfpNfhjKpB4cdVND3fbKIOpCx4gKfn61b8mIHXTIL4YJoygRrPf
 UWAzflqaM7tYu4S3US3zDn7LSzzoXn0FD2LSQCvqm/lWun8yGGOAJK7jaSQtJAHw4cEk
 MLwRDKdjlpmT6xI9rRFkWMpNylAU8hnE+1rU6YquU51ln5+EiJ8IYrDvLsnPCY1HdNk2
 k5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792337836; x=1792942636;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=unJw1UzI4vb+ulhpTDKp8rNwtFClhpDgpgvWapAFW0A=;
 b=vDCmYEcmHh3WEIq3buUplpLSN31B3uoQD/yEAWPsNUks6N97Yv83ok8WTqDUPWDBqX
 JV+tluxpGcMaOnBUsxIIGOMAXqyknT9q3Lok5KMAuJ5t8S1hoPI1t+QZB8KOzz0PxZCd
 pTkWEMHC6dp5fE6Mwi7TZOTXlgy9hkzH4zaxOL/tE1SAQ0qXQ9l8sMVjPa9PaZsnJ1VK
 EAEj9ETh8doetJJCJMiYVEt+VM3f3ndYy6GQDeP/86MNRpFQ8R62/Rqt3ozuV9AjmJHQ
 si9b7DN4Yri1vup2FnLQ/LVCFx6g1D89cBg11qiYd7Ej0IHSxfelKqzCvfFWoctPprby
 FL6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEekpNOGdWIDlnr4wU57JWwxcNFVrLyPvaGQDgFNZeqV7s9HpkCHwH+xZdgMgOwp0KBQwLD3iH1Xyf+Cxk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLAJT01jbzJ404WfJ1lLtXmIASIecU22yBl0BqLVAmo3bXCU3Dj
 MSk96Df0GqtrHfBl2T9K/maye3mgPSae8erou+lPig6FyUyKUqb19JwlCsOImagwsUMcZ/WjCCG
 Cvpgpwhk8uy+rTYu8L1mX0PgzOF3jhab6gbxPEGpOWMJBu+L2E2r9yxMKMOeNLaAbocCc
X-Gm-Gg: AYBFou1Ti7urFQLmnV4lA0Pu6aXf5+YYHZzh/misGNwa9CZ2GxSteCIFXmRVlVwbcFU
 W9KClHb4vlWOHhEn/nXKTUjEHj2qPKCB9IMpvcHgIFILqB3siiaIcB5EMcagMeXCrpyfuON4Fbv
 VbkYLcpTn+1ekudJjrFg1cOMhTGW6eOLvvzPORwhz+Coy0BirIUxo55vpraFFMxyTpQKQs8ZJJm
 K1d4iaez+TyrcJr6yiGo+LL5/RYoswhID15Kj0GUDT+Mcr/88hzfrLjQEsAW0UOxDIzeIRZ0/IC
 czCEXgVbg4ZopKF9JJqSrrMb+EvGW34DAwViYy7mnRxjQAldttL+tkvFZayF8ao1K4oKngpjaSs
 YmdQgEY/G24SlSWFzXHypRk48UYDaZL4gJeazymuJOwIQz5O66BU8TU9GlPSOsfvZyhZkJIpSlZ
 SyVZu1WzAfULSwOk9wO4hTuTZS4CEtNgn8zoX5kI78MXp1mAwh+I4WziSetO7BSJlO7kzk64fEk
 dShd6iarRgQQljIosivOPbFlB4kdBLt+DLHHaAJEPVzAA5TCHnw0SKvmI064Y8H5rMgXIHEK1QE
 khWFOaJhyiMQzvpfrFW5cTGxvwTMIaVjIN1Xn1Dnpb6JZXrxeSquxnc4Rxm8Atr8Vc9IEz5f
X-Received: by 2002:a05:600c:870b:b0:4a1:d487:2dc8 with SMTP id
 5b1f17b1804b1-4a1d760518amr111856045e9.18.1792337836293; 
 Sun, 18 Oct 2026 08:37:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm89436885e9.0.2026.10.18.08.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:37:15 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:37:14 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
X-Gerrit-Change-Number: 2004
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2004?usp=email>
X-Gerrit-Commit: a7b30d8b6adb00967b43c8c5c5036db3d0cbbd86
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 15:37:14 +0000
In-Reply-To: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkkwMjQ1MTc1ZjI4ODRkNTY4Mzg5OTBmNTNjZWU2MzgxYjk4MWI3OWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <59de2e497d3774533d438d2d28a6d2313f4fecdb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xISwt-0007om-0w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc: Avoid
 conversion warnings in parse_auth_challenge
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4221824347639782475=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4221824347639782475==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KkolFRYp+jU="; charset=UTF-8

--KkolFRYp+jU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail )

Change subject=
: misc: Avoid conversion warnings in parse_auth_challenge
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0245175f2884d5683=
8990f53cee6381b981b79c1
Gerrit-Change-Number: 2004
Gerrit-PatchSet: 1
Gerri=
t-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 18 Oc=
t 2026 15:37:14 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--KkolFRYp+jU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail=
">change 2004</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
004?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I0245175f2884d56838990f53cee6381b981b79c1 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2004 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 15:37:14 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KkolFRYp+jU=--


--===============4221824347639782475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4221824347639782475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4221824347639782475==--

