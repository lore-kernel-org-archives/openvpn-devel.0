Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ACDCA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQBmP3jAMbuq1dVStX0dRsPD0sM9EzhMhUlOXus57y0=; b=WBN9K788iIzfxRzFLVyVIZlatL
	xu8VQBM7LpT0IAhhgyBoNzjGwTAglm6y5+ArkqOqk9G9sTItdCdyKvVK+XDgKlCy+B7+f4uDwe7ky
	SVohIAxIKjlw/AaZEKKoIaHcCL+SFYrvIeNT+YBZNCDFT6CTlYDP2b8cwmby/2uH+FkE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEmLy-0002ea-IX;
	Thu, 08 Oct 2026 11:32:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEmLn-0002eN-Bu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dOaIWY1lntHXJy7TsPZTQI2wkfZPMQXv5GmU89HdIek=; b=YMBwazCYwmgxGYDJlZ8LaUNnWV
 exVIDDGU4Wpqw3qHt1a1WVdn32g+6jiOWdfDwFSbn2zaRy5vdoQERh9fHi8RQVmPAMlkKiBuFJ7IA
 eXSCDKwbnNF8bygw6zGCyzHkJEffFtJ8L9SrvzMP9zHvWU7CmpJvAN5DhQgBJkphYsDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dOaIWY1lntHXJy7TsPZTQI2wkfZPMQXv5GmU89HdIek=; b=Q
 AlnkrW9JJ3QuSea9STsn/S0jyHA5LINGMrC0d/GLPTrItW+/rWWuTcuHfBeIP1Dw8/0TA36I0e3wI
 F4i0/KQL7KIKNoyBKIWgq2QTF5Vf/SNbvSaYc5MmbO8oJbl/Dg8LK3rz7vsKB2S1SiuTmgpGOiNRd
 RSe+MQMtBF+Yt/0g=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEmLj-0004Oy-GG for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:31:48 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so24833125e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791459101; x=1792063901; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dOaIWY1lntHXJy7TsPZTQI2wkfZPMQXv5GmU89HdIek=;
 b=TANeDos1oeDPVU/yJ4KP2NsxOfPwwL6iMmN4iugMvBwypsoBEQFesUvdlL/zCeWosw
 lsuy053crHI7/q7lPAZ+BOzEOk9ekkdLmy56HcqxJI0TtgdpwjwdT5AomzLgcKP3ObSB
 vaSzWY3aPwtHONNn8GWwtY+LPiJLBbmWSwzDQji8fJLU/SJWrBRyccYON2es2TWIVzQl
 N+RuLwMF4fl/mI2EExQ4/F72v9x8wMjf3AqU9xkVqRdz2hMoflBT01SFIStUktpVgLdd
 q/JrsejC5h1ZHiiqUxzzFy66hxQ2fCRMRf0RGLrEmsK26lcNQfdpzdujc3bwVK/MkeBW
 4lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791459101; x=1792063901;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dOaIWY1lntHXJy7TsPZTQI2wkfZPMQXv5GmU89HdIek=;
 b=W5rZmdeVUwMCR0ZEHFSwoyf9Ne0gDOcEbG6iQdX3DRNPtmgNOA0w6DXiKauRWjGURW
 y+OwPgDpTV3rG73BsKJa6nlZPpjWxshV+jQccGFyRX68neU9sbZ0Bn96y2X0d0bGpezP
 LO3h9sZap0qYxRTCVpg4bKR+Kx0IT8me70mO7YLcUAAS2lFJgUygt+h0jy98FwHf/2hZ
 IA9vmeOC86RCajIhzfoxBpBN6FxftO8p/AWyGXoxnMOA7Dx7fO9Y9ZxLiOXSjVVYa1nr
 9xJHmC5FX00nIrs01Ob+BKRqz4MxYE7mCTz/3y7fqADsZTYdZxndms370ms5kRP50VJJ
 WzNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrFURxnqUw9d2eHVtmqdS3uI8Iga0zJYRh+SmtdBe9aADKLsnFIW/K+ZWJ8I/C6PvPOjANnJZ78ft9wmI3@lists.sourceforge.net
X-Gm-Message-State: AFuF++nwxzms6MH/JOqtjsbXEslTDgMLUPibjz4dS6XWP9G4Vp1oMoWh
 KuGzbm0KuEzxtjNdcvc439Vx9ONf1AMwLwFaveWWmiFijDL3I+ysgVk4YSoNkZbx2Z+T+k8izKn
 OD1c3jQGgYexlDbHCYjTJsEwrC0r8cFtLlxqxx/E7xfH/7yUuT8yuRmoaip0hkqaKp+r7
X-Gm-Gg: AYBFou28OGWNBZZD5t+1SCoyZ31kR+JITSFM6EvtU56Ye5SkQwACt2y92qxpAFvL3in
 bkBUnhehItsvdJ89DGsFJzin/fdrMHo9hCdV7obCJ+g7cY9NA4bbZ/9OhvWYUrOe2ir30LbFLy8
 NUMv9DN/R8HZD3ELamHKSZ0W77JYC+P1b+uKOcTDeCBXMI1VIfMfebPUpizYSyjBjj3yCHDhYrP
 lZraXZhiOqU5qYnaU9q28IyuLh4SiPwFsEuKXFz7Gr59JC80YrUFe850OWbq49hS1uOtBxw1Sj0
 p5Vv94/58LkrTTUb6EkK2j3S7lbiQHT9shPikRiDfO43+gR2XZ/Du7mdR8fKUK/yN1TPL8Cp3cZ
 8t64eMwUzINctTrajWEi64XxItFPM6CPXpBe1YihG/mA7xz85blkfiFPbmPrMubWGdYEikfcJ8s
 9aRBRqR0AzL9v/TjoD4W3SF0aug3uVrIkrogn2HpBEVaMuussDGjNnts9WzWZK2SYDsrP13gjHS
 RtIQHgLxLN1vxkkSJviJl97tw7tVJ3or/bz0SswaZ76oQ7LsvmEccJIsAN3/Q0OG2bjPxTI0RKe
 cX5c5Hia9KHoiDUgmcJE3ozv4rzqcTh0riS1QiO5orrXL5tLby3o/TtJ3/CfwlFZy0em18U=
X-Received: by 2002:a05:600c:524c:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a180085842mr96859265e9.0.1791459100775; 
 Thu, 08 Oct 2026 04:31:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a184260f9asm67107585e9.0.2026.10.08.04.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 04:31:40 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 11:31:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 2053743b421fb08fd90ece583fc563b6ae2e03b9
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 11:31:39 +0000
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a20ae65e970faa874ad38ab1544293b676d1afae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEmLj-0004Oy-GG
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Fix issues with string functions
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7132520003108071071=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7132520003108071071==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KRpoeBPFzq8="; charset=UTF-8

--KRpoeBPFzq8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail )

Change=
 subject: config=2Eh=2Ecmake=2Ein: Fix issues with string functions
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
86?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5349f6=
6f5c1b52889c2f593e01c21824f937f0
Gerrit-Change-Number: 1986
Gerrit-PatchSet=
: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 08 Oct 2026 11:31:39 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--KRpoeBPFzq8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=
=3Demail">change 1986</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1986?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1986 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
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
lay:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 11:31:39 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KRpoeBPFzq8=--


--===============7132520003108071071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7132520003108071071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7132520003108071071==--

