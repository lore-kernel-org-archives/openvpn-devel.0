Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBAECCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uxs1Y3Jr4u9kYGZQVRrOcVAJ2PBLVCnqteNXhXZmAoM=; b=drlJkKuJoB91riVif9YlXqBG4Q
	sA+3gaHYmSe/HeJVNOCG0HprKkrIJk3XrAiuF6seCpVN9xWro/q5jovRr/T/fGVr68hRLpXcvzE/v
	RDtmkI1ug0wSrsidiQQwRpYktNh7vo7M6X+eUGH7NUH3GB+LaUFLrC9CmUvc5mdqfNSE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISGh-0004TY-90;
	Sun, 18 Oct 2026 14:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xISGe-0004TS-9j
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q4xRvsD18XipaT/TfTu5rGzNpwDy/LDUYN9lBWgdKMg=; b=MG7uSm58LVY8CFcThQWXrI2h1Q
 4UpAh9EigSAC0OWue68b02ZymsPcAquA79fmo/Pqkc+fT+8lWQOAFqKu9PH7Gu49OLPn/FHFmH5yo
 IxjUwfa+mdFvokq2OATPMSsO4tqV9MaSX39lgw12yPeylZonU/KpLyLYJnvuJqSQX8BU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q4xRvsD18XipaT/TfTu5rGzNpwDy/LDUYN9lBWgdKMg=; b=Z
 QKT3KwD/rwskG6Am3e1yqMNypeTYmQI+9dXVQVh97iRqFB45uemZ1KXYaezsb+TA4TS8tSgQTY/yi
 gBS5nxoWWVzQUTzOUHfkWc6PLo+un/vpEJ/CGb1F0IfoS1wwlKbq+4ofkzKTzwkfE91T6AivvhYUP
 /EpjVngF0yGdeJTg=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xISGa-0000fP-0C for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:53:41 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so2053805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792335213; x=1792940013; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q4xRvsD18XipaT/TfTu5rGzNpwDy/LDUYN9lBWgdKMg=;
 b=Zzst2P+MRc5DVuMnb6+vrq69fOgTCbjGJpr0U6LIjAgAuklTxitmBhPImWZdC+UCrw
 Hdw+cNVcOu09E6fo3arP58HvVQ9XNNXR5Kw4fv3us9KGux+Dus3Hd9VU8Uvolc7Lc+5H
 ewv+yefFqnxOx7FwIt/4Mr6jMbDDexBTSbRSBTNy1B4YNozDBFzcqQZbjljrpbm8oRj8
 wMHh5DZoVBucMjUI/DNLU2mrN9nHNTFVQCCQUEF8orXG5P8ptPDSLoqXqVE8ANwQHCE5
 JIa/iSpjWDerbyYHrh0HgfbrQDdMI5taMoR0eay/r+nubCJwD35MbTRhig4HsMr8Xz23
 cQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792335213; x=1792940013;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q4xRvsD18XipaT/TfTu5rGzNpwDy/LDUYN9lBWgdKMg=;
 b=Y1fvAM60f3/JshKDWOV8Xyves8Bk0MqicgAiq3OGo9GvNhOOQ2eCBeuqKYnDJsmzRY
 vngrBzwy7hVqfK7nHv77MiIBc30hxChR3S8VN24q+ZMhKrr1px5QxendYe06mDM15Siy
 1D4O0N8QbOC/qfC/IF+n8QlF3E8Z9OGxQH/QFlNYeSfh/NPMi56coBCExSJRUvWoaQKz
 +pUtXvaS/sPDD+HrfEr41lxVHkMe0iIuMI78h9rw40hVKSzGSKH9UbNDWjLeR1Unn17z
 8Ou1wBSYAdEDMVW5Zx1Q3RZis8UAEvxfpkPT8JPHN1q6ayCQfDUDErB1SjtRILzpJBfs
 Mz1g==
X-Gm-Message-State: AFq9FYIbBBfMMykTu5fBUXKaRoRqsrUAZQj9/AbUfnQu7w8TY/pFl5ma
 qzfrd0KSZ5w05nlABmgftcFZEttftoCdpBea53Fsb4yHSgZWFw9IIOMsWW/YrwGjlX8sQ6UcN0v
 N19jUZQnz00H3Mtriwck3WeBWx4Ur7tUy9zlspZnoHQTSSDJ2xNeGOJ2J2ozFHJ7+wx7s
X-Gm-Gg: AYBFou3hI8o5u7EbTsWf/pEkfk+tCDdngrEkcaAGz4rHqWEVZGPeqezzBf/WHnb7zoo
 Lmi/4nbngWKwspr9xfGpBEQjjlDjTIDFqOWvpyA+gy1d0nA8yKmRZ0Ezu1PrFb10NRSWPK7+Ik0
 Rvk84vF6VMEge7CNCo6L/6d52UkljmkVmlkfNJVRYtBdTxlKS26h9Rj/BzW9RkPNaai27SujLZu
 0fs1YaVOxqL3kdErF8RpmxHn2CY7L5RfIYRiZ2YxzRTKVvl7j3gL0aGfzz92WybFSbI6DE5xWqH
 S4683YlNANLuElse+OFWbji/CZKY2A8+IEyYUXW1AmcrTK6OXnEFyTXmK7tugY5LM4X4+W1+GVk
 nhHOhQsqy/GUZhcdl1PN9VRnu4BdsEG+nJaaR2abP+SX3XHuOD8x5n1OO2SQmAGLHKoIPOzj/F3
 MCqQa1E45tWAgNpxK4EgPA4GmfwbBRJJG5vQUpBH2GtkbDwj4BUPncCulEoOqOaYuX5F/C/odto
 RkNMw0whEkkHse5nBvicgoeTwqeJobY57WlmnXkHBVgoKR+vtg2w/8iDSwYu8+kOJKNmRPf4zH/
 gpKw6wl6LrHLGKvWv5VnFtC82gdVkIGOq0Bt46fTmIwGnRYis6jhbwfpzbYO
X-Received: by 2002:a05:600c:8b0a:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4a1dbdf1a18mr85475605e9.2.1792335213146; 
 Sun, 18 Oct 2026 07:53:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510ba3sm17235229f8f.56.2026.10.18.07.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:53:32 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:53:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 262d36962c98a8ba3e5b6f4029bd9a21dca7389b
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 14:53:31 +0000
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf248f7acd8a3d6586203c890f0468ec2a497fce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xISGa-0000fP-0C
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6555209026271964196=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6555209026271964196==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ugiKBDpTI7I="; charset=UTF-8

--ugiKBDpTI7I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail )

Change subject: Fix cppcheck warning=
s on macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2014?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Gerrit-Change-Number: 20=
14
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 1=
4:53:31 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ugiKBDpTI7I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering has posted comme=
nts on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">change 2014</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10ebb582182=
9bf738e58fec23f9f9dd65d4626d3 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2014 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Sun, 18 Oct 2026 14:53:31 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--ugiKBDpTI7I=--


--===============6555209026271964196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6555209026271964196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6555209026271964196==--

