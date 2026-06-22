Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33CCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdDJKZO3k5gFJD2xHKRsOsnRxGwErGxnToxCQcB1W2s=; b=ZGW6ftT5G8zfpGceyKlSmDRIet
	bo1zSHP5av7F1Jjq54tmPyAnOTK/sDEb8NLtSZhR++taB7AncRhfKuR1UfXwtLMLWr3iNVBG/kqtO
	/GnZ8Nv2SOu72NNwX5mS5e2QgxjJPWF1gFvagrvtZY4Qlsb7H03FVOVKc9LV4RBizvfc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbenO-0003dN-BO;
	Mon, 22 Jun 2026 13:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbenE-0003dC-AH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vYFQgjGt9mMUfCrBs1S9RpSpt4hQCFXqiL3hyQsoSUI=; b=iMk+RvA+gf8fvMiUEI4ARnKB0C
 a/ljefj5x1zu8R5xIjXdEDKTkMdohv1KRbSA/J/nzi5Fh7j7rDmXjj2toHoQZcZ+8OBq/8ML2QoVQ
 DSYpHeKmJtuIOajhRK8+vIt1YcZz/u3WA7aTUxTeeIfJaDwil75ONojU96C62AsPcmB4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vYFQgjGt9mMUfCrBs1S9RpSpt4hQCFXqiL3hyQsoSUI=; b=X
 +lXIfBZBaK39cluZPXTdvExXEHQ/Tj9tkyTljX0+gDJ0o8ZmcqmxwuKwuMJPSiqx551c6PcUgAuHh
 yqObSZEdEugJAq41Ev0my+W5S0yIs/y+wDnkayl2W9KqIAgVvh/kt2KsbyuGiN1MOV7F1GmSNuTeW
 ZRoJC8/6xzfx4oX4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbenD-0001Cn-4Y for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:34:28 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso47516315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782135256; x=1782740056; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYFQgjGt9mMUfCrBs1S9RpSpt4hQCFXqiL3hyQsoSUI=;
 b=YaI49KRnlEdenuzV7METWe46SuUQ0XFYAgfT7TaeYINwV+fdvqDpKan/qfZYv99jnG
 9XxSAMyu0TKVlbIC0XNLrDjC2Le0alao1Sq9xY1wXLqL1r9/1tVBckPvFL5hCZfKWrR3
 KvbhmFy+fOmzi1Osm/DVcn/dnCzE1pzAtiJcNU3eS2mh6OZ54TthNyjHWnrKgt/zG/aE
 Onnx0E/ae43f0ZJO5ewFhcJMpvzu+ueav4VxB+Jkv3+8rrzZpxKU6qnoqRqjyQ09Jkm3
 B3EbjKzwCpo2GfpEmciAVcQd+TCtzGeuBSeBzAivqX3pRsvbDf8UbQLKSZ85/mzVFS3I
 JelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782135256; x=1782740056;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vYFQgjGt9mMUfCrBs1S9RpSpt4hQCFXqiL3hyQsoSUI=;
 b=c/fq3uwXmBFQ4znE+Or2QGCyHVePu59QypwUTHWs5LTzXh4y1rxTT15dso03ygak8T
 Cl5VIzfWLrSFyn0CjptBdD2K/ZAz7GGqaTSBjmPS0eJ7AUEKBucFhSsL5hdSOdZNMbYv
 iEhQZpXetIU0VVBLntBUnStK1eoLWTmlcT8LNiAAQcCquJpr15EB8QvabQut0xDiVBSZ
 nn+1EHOCKw2JdfIEbyjTc3lvsRusypIcFpGG2tvbahmke66YWshhxZojoT5QVKL+5zZL
 aiKtqg64rjhgSJAovqzGWvfPKy4hqM/GthGfQU8iLxpSRg4xPdRlv3H5lz8Xetf9OhLu
 bzMg==
X-Gm-Message-State: AOJu0YynNGN2xue/vsxQVbkkoonGeIqbjiXl5s/vh3oajHulIY9hX7bp
 yNpvPqvgCHz/kIrnFG/xVelCjXlKJBTumMlAAatAEbZVZDuAn1b/WdYoSSz4nRjnox7FxAhd9SK
 j/Ez2Pchogf+GAsVo2yO6jwo0JF1do63OHUfwqalqhrBWNVaz6IzP0j0ay70Y/aexu4W3
X-Gm-Gg: AfdE7cmQoWKRslyuYjG1YLL+e/W0FFZP35Ic1LmREPfzgolvDuEbx16W1nfjaNIbXPu
 K3Ct8ESmqHVHWT5T32sjby3adifO7Hr3DHxT0CaO1+gd0XVkGBPKRSXbjsDtywEIQgS1XZ67Xto
 UZVv8kI8NgxifT6pRS1Tehnm5n3Cu3sehce6qcF41p8uSaB1T43iObSOYAf2gL0HV+v4Slpcb/B
 DGTaGUDsLzThCqi9SJyF+AkB7gkNRIpPpwqPOfMujjVVnepJ9o2oOyHz73JnzbtWQ/76pEsgmwr
 ttdogk5xeBAqIBLZtYFNVfR7EnC0uHi/PpazOo6/Nr3l/qAHk+MCeGAacRARyVgqxyeIlCyfN8y
 JpC3ByMf5t8c0j/Cp/k3oeT/GR+jVA6xHOwabbfNhau29iGvb3OFv1FEwo8+c6MdmnZEEB9F/EO
 0NBeTGS2pKext4hmDSsghlUJhUSOrpsG186FmCJeBiqseJfGBQ/7ckvcXzhVIjF1wpIy7Z0z1D+
 Aw8ua50kDeZEP3TZ/jWbVlwfUDSPfpXa4MGRihlZ9mtcBJpy8jaBiYE+lZ0iGGWkNY2/UX0V3mh
 IGA=
X-Received: by 2002:a05:600d:6451:20b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-492409fbebamr148267095e9.4.1782135254938; 
 Mon, 22 Jun 2026 06:34:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm315906045e9.2.2026.06.22.06.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:34:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:34:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
X-Gerrit-Change-Number: 1570
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1570?usp=email>
X-Gerrit-Commit: 17df5a96967aade7a3a3f8c34e78a3dc466a708a
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 13:34:11 +0000
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkliODE0MDEwN2Y5ODE2NGQyYTJlMTc2OGE2ZDhhYzY1MDE2Y2Q3ZjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b58111af6982f5fbbd4cb7ea6516dedc59f5a18e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbenD-0001Cn-4Y
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash values
 in our hash map from uint32_t to uint64_t
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8998557773508012311=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8998557773508012311==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gzpqo/YsYRY="; charset=UTF-8

--Gzpqo/YsYRY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1570?usp=3Demail )

Change subject: Change hash values in our has=
h map from uint32_t to uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2

(1 comment)

File src/open=
vpn/list=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570/comment/9a9d0=
f28_a813ec44?usp=3Demail :
PS5, Line 37: hash_init(const uint32_t n_buckets=
, uint32_t iv,
any specific reason you removed const from iv? It doesn't br=
eak anything, but looks like a spurious change?



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Gerr=
it-Change-Number: 1570
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon,=
 22 Jun 2026 13:34:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Gzpqo/YsYRY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1570?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/list=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570/c=
omment/9a9d0f28_a813ec44?usp=3Demail">Patch Set #5, Line 37:</a> <code styl=
e=3D"font-family:monospace,monospace">hash_init(const uint32_t n_buckets, u=
int32_t iv,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">any specific reason you removed const from iv? It do=
esn&#39;t break anything, but looks like a spurious change?</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1570?usp=3Demail">change 1570</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1570?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 13:34:11 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Gzpqo/YsYRY=--


--===============8998557773508012311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8998557773508012311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8998557773508012311==--

