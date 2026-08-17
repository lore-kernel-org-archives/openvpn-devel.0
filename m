Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378C3C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xzrk4TD+wTI/DFA7POYZ0QSFb7sM2sbADMWm22Fkl0=; b=Jq6U1yki3lAmn+A8kKxHbDU9MT
	FCrq7u9cjMBwlM7La9Lwa2pBtDA4GJuZmqWjI0/9IB9w+LDWiWFWH3yKUbina94Sh7CQ3lsv2hBKc
	fhXdMAEwXzfGPkJPyxWUgD51JMCJ6gerYC7EvrrSe2WBK4VJf1ZouwOh2JTE52KZ0s90=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwqc-0003Ss-AN;
	Mon, 17 Aug 2026 12:53:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwqb-0003Sk-2f
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u5POsUheQ7zHagI85/TwsOorg+maThp7AckcZcCZaLw=; b=nUj6WznFWrd/+GZykajfOy9IJz
 HjxPSpAklXfCXMLB0T9jBBa5Ds/XZZ5aay4WoJUQu6IzgNqa0FPVUaPTcVv3ivDshcVUXEZfDTow4
 5mgLYFbFiZ1XqQZ93cZJxutS+mGP7O4REDoEzu8LfxQMJPrOV6Ov9zzKyKiKYcZFvM1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u5POsUheQ7zHagI85/TwsOorg+maThp7AckcZcCZaLw=; b=e
 i+dWk2z5EhEmfGYfvrTCvFOekciUKubL2/m8XfjVSN2RrfDFtOBe1vkiPkjjBkd682R2bmPkUiSVb
 fyCTcOZzxLm8qR+KJA3a//VW52DcM4jbJff2v0Y1udWVt7rZgiQgNUM5rQ6ZySdcJ4/f8hNgZI/Tk
 xEyuVci58InXmQPk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwqb-00042U-6f for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:53:46 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso25888745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786971219; x=1787576019; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u5POsUheQ7zHagI85/TwsOorg+maThp7AckcZcCZaLw=;
 b=hM8Bu7/w2ktDz0gPe1afI/NMBSlFQxnksoNVbtWlJRCfFWrbfkhWUOJosxSO18oZ02
 sL30ht6uuRBAGy/U5xnS15zxHRrGivdOGM70k9XwqHIC6qjyqCJjmMonp4GGcGJfi2pU
 /8BmAwuAuA3fQQEQdyMWQMjXk0ueJ9/Zu2VJgjOuMR3l1QXjJR1i1AFjKq+NFFBO/PWQ
 eWmFoBaG2HmF7rF2LtYXKFoEW/AbW3WFKuM9PqiBKaiGCvqUAyo4+mZrP8LNitglxChn
 hLGg4npPjBbNpbifSm5CyAYqNHlOqme7jn6k4RBXrepuNHg91MfcgGVVIAPoM+Fa859z
 tM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971219; x=1787576019;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u5POsUheQ7zHagI85/TwsOorg+maThp7AckcZcCZaLw=;
 b=MHxFEhd8AOlq3+uHLCpZdxCvTXPeAqK2+MEh7kOyZCkucTvzmwHgMsTql1PlWX6mZE
 f5FLtkICY2dCMbRTgz/SxZZ/6nzf5If8wnYPUBD0g2YrDDZY/2UFRQJYROgLisdJdf9g
 flPVC63G62adIT/VpeH7HMVixVgsjIpiKT4lIIta58Wo93iPvD1y+32DCHWBR/n8Ejt4
 DuJDjiMJNdjf7H9ltrgPIPkfyLN8MlkQbJFrGeetdK2fkhX3GgP1sNs3xPlJtEjaUArt
 At5rt7raHuJjYElenZDUJYSVDG005kGdgsXPIsXjgc+iHi4yJwI/AQt5HGHi8yTTLjsY
 fTPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdXKiRorx6U4zyfVQHVakhcUcDgu+7XHG1Eqc1+1DLt0OzQ/ofK9NgglJ6VCKOvYFCvpEfzOm+d4hlziI5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxEp8wfuv0NrOWAs5mUWoQcqbKhipT2sYTitqR3dgnUGblcfOPK
 Is6kN+1i0S3XljvuruKKqGtFFaaznitAVd55h3cl0CkNAD3nvnHkn8/eX4Y5Y7Z6AFVMqqm6SGf
 /heCFsSHGOJlLF+c5tLkoamDlPtOiUWhFUGPHVDJoR5Nm3NzP8shU3tTwbhEu8Nb40Cq5
X-Gm-Gg: AR+sD13JReERwwfwX+paNLhXOfyaBUydag5mt4NLKcDx521EnHVXiHRyEatGjG8zL9B
 C8m8Hmu5iQvL9DJqHoAIWA1knjFimoY9a6JqiN2/FXCgoXF3C3nHP7b3EUBhHYZrt2WrpVSsGev
 nzWbAfUhczDd2YSasmZYrA43zDH6W/AwSmyHSwn+lNI3kUGetaQ5SwgOA5djWh3KhUp7r+kUWbv
 LHpL4Zfr1A1G19B810pQCUi3fgwAcFrNiTRdJtcLZ3gdXslu3T2FTMYWPPoCR8va7R/sxKzaITz
 Cx4/TtgU234aUhRLjrTaC/MI0AyD/6IuIMeN+mvAiLY/3d7iPSmepO9LqrkO7H4PVW4zSVDt5NO
 jdpxj4vFDZf10zeiT6vgAImhRoKw9APtTwRZ17kJ8wZfdFCUTjCOlwRzF+vMMeD1KrEPx+GRcDb
 gfFgAnRwhjWdZIGHEuohfNqZTIPUS9/Je+hLaua7UAmkKOC/GvEFtnfViGIkm7+T+k+Mk5JTkO5
 YwZ7DZSB5YLvL7hQzLTX+kFOaDiwkikFtCBAoRYffKFL6IO2+SFF8bvgu0yd6LimBunYzVzjX2i
 hEqswgezCdMCC32VH+Xa2hYVegGdVrEEGx2kro4dcsl6oe9GQmc=
X-Received: by 2002:a05:600c:8714:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-49987935852mr426713265e9.2.1786971219106; 
 Mon, 17 Aug 2026 05:53:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm185515005e9.4.2026.08.17.05.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:53:38 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:53:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:53:36 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5cc1c8fab6562e8513cd820d3f5376a3052b9cf3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwqb-00042U-6f
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5610015086176444663=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5610015086176444663==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sBTaYRC2Izo="; charset=UTF-8

--sBTaYRC2Izo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5=
149
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 12:53:36 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--sBTaYRC2Izo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6176=
2374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:=
53:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--sBTaYRC2Izo=--


--===============5610015086176444663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5610015086176444663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5610015086176444663==--

