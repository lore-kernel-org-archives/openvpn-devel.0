Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD910C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k42rMn/6hhxKjHarBNc1qBcvsd45dqzeLs004cU8di4=; b=UwebeEOctAotmackYYvG2OI0SF
	zMBj0wa8T40D9tsuCXF1Rj0Qlz+fijDbGdLMmALvwDbyBGo3Zqno2dW/v0co6PB9t7X7qwrKKWfEF
	3QZGw2kKQLO/CSKhQZlbclbZT3ET0BViC5m7/x8T8n6lSkZ/AkOE5uoWAySD8iEX1tpA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtMMU-0005Az-Ll;
	Mon, 10 Aug 2026 09:32:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtMMS-0005Aq-S6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 09:32:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DbsTpDAMFQZ6lfqY+WpRswaLYGXc+HApLYmq/KlBMTY=; b=fuByFHsaLVsSKZOX+4Fh+t28PO
 e/kk1IUzB4wmjMolA8gif4+N9mqNbQOK0rJAHYs0LtLbFEjPdQ7xDjJjQJ4h+qeZ4MYb1fJPx+u46
 K1mc0NDzVLxgUfKnEZjmJ5Gpqzb7aJCq4SAZwpeyo+i6zExd7N1U6hNQys2en8aHKoRA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DbsTpDAMFQZ6lfqY+WpRswaLYGXc+HApLYmq/KlBMTY=; b=T
 Afj9Muq029K7kdFOUQu7OhGu5WrnXHQ6kFbY04KQdl5U9YRJ3D91r8cW9k0OwfnclL6SN0+Jz32pC
 MmFmXn4pnl3TgOGvZRhfn4x6CZCv89v1iHG5T8cZ6dViN9+d3T+TuBcS6EEEYhW+1goMFRcIAls3g
 gZm4gVS6bu1ihtiE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtMMT-0003vL-Oi for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 09:32:01 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so15583905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786354312; x=1786959112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DbsTpDAMFQZ6lfqY+WpRswaLYGXc+HApLYmq/KlBMTY=;
 b=Jk9fXdWDXkpkLzKhb7+pLJo0X5p9gRcnvcA0z2W1U/h+/xe45HtWRCKapIKVL+cQr/
 UFrXUIUIIr9Y1A6615ttMq7wk+oXIe4PtdlXq6OnGu1q9/GSZSkW1ZWeV87Gv9MM7V0l
 /dleAwtuHvJNpb6b1FPHPA3z4xkqlUw5rV2USbB8rXsKuOelXBbeJMonC8s/bWeA2QfB
 HrbZUp+PmYAT2Dd1M0HpZvKuPya6gMwDe/9cvx8BmBKQ6zYS/Q3EA3zNnf2B7MaQEi6O
 H6r+OS8Xu6Xgpt50bOdmoFaezfjIFWgCO1dVo1I23dbXlwIHyfWsOybnpn0iwyIoZwrs
 0OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786354312; x=1786959112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DbsTpDAMFQZ6lfqY+WpRswaLYGXc+HApLYmq/KlBMTY=;
 b=J9C+R8HEJ8golQ3SZc4MYkL7P6EDb8qzNjdmZHmCqHTQcEOg+X74dU2VB29noAZNTv
 OOqdsrtVvAjwMIYjFwmarTklBd3CMu+rya/qpNVTwVWAD4hRPeVbRfS0bYFXFupcRSD0
 Km4toWSSAb1gQTytlOiVctp33QuBnnxy/UetGfmaY2ritXsp1Q22YGlYV+b8fIHm9nb3
 f32sYAe6maDzW7Uc++DHz9/5mGeB51E97hNSAGGWSbCiRseyEcpjQSltXgRYYCVzTSR+
 bsv1IL7P10xM8J82OvVSbagg6g8JQS7TEu/60DM5vVnGRCtXYFbbwx2LZKqYuQnfcmOA
 hNlw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1k9ISEDtglpwR7M/PCemi+qCGgo4azXpC+LPvWJxrQ05+FTvH8mao6UxkRkX5rWZyE5jsvYiCAb7hOp4g@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLp7+mPvnsEROX80hAVZV6dHuiAI0DCzBSLPt3q8BCi8Evz7P+
 G9vwEVlh+btMxxzmRJkyZwA0PLjXonAVauPmPqCYeSC0p7DTz9p9XjwpZPrj1T0kodeZLigym+n
 7L3hqhxTY5ylqdl+sM094xRM3q19iPFK1skstphQK3+0T2EdcZv9rzxiHiXih5BitqehqMmzrMU
 4G8YwI6A==
X-Gm-Gg: AR+sD12G9x2V3xaKOrF07QVjVCOL57L2BCs84fS7PotqHVD8980Uf3sRXXrOnbFtEEi
 IeBSBEmhDtmU7NuwtLpwG8wSDnX5dbhSD8F6OeoHKVEkff7ByeDByUny+wTp6ZTn/PZvb04Mbp3
 UFkj6ZNIQwu26xH0bbUmlbj6LHzUXpkLmXSeRBA3cfBVlmBxDnvVkt5VtaRCgLZFkRYxJ4k9qEi
 d+vGmuBkcW9+nbldIgkQMrdoFge0aRyx27E2RrIc28zMkcnbe43jDpgh5T+xMSde5LMKD3l+OjQ
 6EDAKkStbwg2SCcJ151dncdzn7kCGBmnTXWFaAa4AeOf0V2stfxUiNYfOCqWo+IMzRDQTaz+vni
 vafIOm7WX412Rdu9jQDKcp6oV3UAjHVewpT0HNpvTsyfPKQHy3GExBOkOuZHZOQnctrWA1ty0hu
 Ks391mYi2zASAxLxs6y1M2bt1NW0hEcGjfuXtHhPfdb7VngFgMSqYdQD0UJ4nUYYRK9TZf7m/wz
 8+7q5mA8BswM/JPePCbcpyPkDuotANJCjHpOMvztiWmtYIyHUrVLlXt42LVZWlMLHMvxpj1kOPN
 Qy/VnW/bUNqhW+qNznRJrs+uL1OBLKPvVD96yXpDxP0xdIGs3obkEt8P2ihvVw==
X-Received: by 2002:a05:600c:c8a:b0:493:eed4:7210 with SMTP id
 5b1f17b1804b1-49961992a4amr262411775e9.11.1786354311584; 
 Mon, 10 Aug 2026 02:31:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145679sm31805109f8f.3.2026.08.10.02.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:31:51 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 09:31:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: b059b5d88eabdecb0316326b52c2bdd6108d540e
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 09:31:47 +0000
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae14045958eecb60fc5f34c9f15d6fe78f3dcdbe-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtMMT-0003vL-Oi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3624644555196432524=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3624644555196432524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47MKTS5gQ/w="; charset=UTF-8

--47MKTS5gQ/w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

MaxF has =
posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when=
 using p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534=

Gerrit-Change-Number: 1837
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Mon, 10 Aug 2026 09:31:47 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--47MKTS5gQ/w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">change 1837=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7280=
67ef08481c87c7b6918c88ebcaeeec466534 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1837 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 10 Aug 2026 09:31:=
47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--47MKTS5gQ/w=--


--===============3624644555196432524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3624644555196432524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3624644555196432524==--

