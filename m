Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AABCCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RkPCz0nJozbPHTJZX/XmHbZ9J7frLm6bKD5HYS8MLqY=; b=OdGqpPnwAhghu0CDbTiisD/g3X
	p0vzwkKrbm+CDi/qvqC2QNqvpMAk/ve88mRD41pWtWOHzK5cmZOmCCt8x+knaImgQkMeX5L2wgvR4
	MFuMzR5x9x6UGEAY/LlGFJEmYXvDMen1S6Oq2UMvI/cyHY2v9ryHCFn+qrF5lqi7krto=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIMuk-0001pL-P4;
	Sun, 18 Oct 2026 09:10:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIMuk-0001oe-2x
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ov+kMJZ6jxR1BUUYFOqmnaw4B8P6oTn5CfxpCAqXCbY=; b=FceM463m/V10ua/TKxr6RRe+Qv
 KAEsCmi4QPxZaaS8DansyPG1Lq7dK32CYyfNLkepc0Bz06giCesWST5G9Tt23r3RU3+fw/nkpNAPP
 lDFf9AUPS9rafSaVzuVLGwlD78UUDixxhQQeNQJtR+ZJ+RAIlrHxnkfPOcHAdxDADl6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ov+kMJZ6jxR1BUUYFOqmnaw4B8P6oTn5CfxpCAqXCbY=; b=B
 xb3xJDWG9hXpm+XacHZyxcA6mgBRVOxQYDPwbwAxv69NM2DWHXXE/NxwJArKECE/SmjWJor3hF9vK
 NrXS9IFY9fIgV8KxPaON9dZ2KB8eCkMpuXuIUV996HBLB9TLG1ogHa5SRtPKp9NC92R3owXKtNPOv
 YSG9UJFRAXg5v8LM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIMuQ-0000Kt-Uh for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:10:29 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso582450f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792314620; x=1792919420; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ov+kMJZ6jxR1BUUYFOqmnaw4B8P6oTn5CfxpCAqXCbY=;
 b=M4XkS1ZvDNCsbyyDo7JDIKRZwe8w0fL3VufZJS678Q+bQ92Uo6q4VX8J3fnHEViQGy
 brqLNTPPCCvKX8cXdklYb5t9sGmgFmkUTQHWkcL6APYqstIcHDThdXjp0LtEzCFDS5cq
 0Tvk5gZX7BHJPXjcSsFQl8nO05jvFgHo62gF081LqHPM1KcA8COZ2ns52h6ypu1QxpAr
 P/d/1DR302n+invDHPh5MDk2OPqg9ePdjsfS0iAEuDA87WqecccWR74G+4mcfc50towa
 60XtCIWX8UjmmsYN5lLHqIbHLiErlLzbTGZetF3/segnMpXBD3HQ4y5Y/52cYnEN390B
 F+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792314620; x=1792919420;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ov+kMJZ6jxR1BUUYFOqmnaw4B8P6oTn5CfxpCAqXCbY=;
 b=MPW6/zxtqFd6gq2tSPIpsBE/9Y897UKgwb3kM74jtDUiXHnFhkBgRBXkQol5I9D/SR
 g5G5YrUtSz3CebWLRFoudK22sdvOlvNPCCUWyfVb8hU7gUfNda6Dpd4zyy5A2f2zXlzu
 /FfNNFD3WaaBBB7JtRC829HXjmcpS9SxbOQoXqaJx0z791tZDHSU10G05kLu9/5el40U
 NfGS+jQeyOszKscNNrCSJkE7awO1eBCeG9YCX4qjf4IOQuwLrgID+0D2ivitUWwOVM2m
 hE8ll3wxaQg47xW5XA5ORhtXherkHnmxQAbG6GUhtFoCXeYnGcWJ2mxFk6mjBHSJx1oL
 NiDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCGvwlAYjDVekBSt/4cgC6ys7bsrG6d+8cX306R48m9T0ZymqR+r3AhnHP6xajcBRHSyJC7JKg5bCDuEge@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL1VM3Agms6J9RWJYAbYvmNkIwKS1kNtfjBRvsyniHrhMaIcnl3
 2+NX5ACI7tYGKFDXoO4//n5wHk2q/Uorw5I0G/MWmRymuhPY4VpmTFEDmaBiI8QJ0MYrqfOElE+
 yjSFGgB6+7XG85fCQKGdvO7DbTT4eFi/vIJLoFNqM3Q9Dpi0lsbiUKBZgGzIUBvWAy9tKAXhSUF
 zLrkJrdw==
X-Gm-Gg: AYBFou1Ypjghiic5W+dscK8tsje4LS8V2R49XBYZRamAxcIOjpCyIPaxLJaV6muWTK6
 AsbDGEX+IUh/xZSxMHtTcThrOmYefvgZWHJRs833GY67XvPPN6HVfOScqnh7+LVp+3zGuDLe3Bv
 MM8b7HN3FKsa3mcA+58TjXlLOnJqakqTX7g3TQbJ4E39IfQ82JY3aazBlvmKGp/WxGWC3sJ/fkH
 eCg7l5Bf2SeEE8Sp7tJw6KzmdslsRaMGzfllfZ7IMFS/vvaKa8TP5Anw4FoWiH/pHPIRwKXwE6/
 8azbZVdO0MPLTp+1Zhm3mmHbiBx1U4HNDd+xwLSU8GGm6Z+KbtHLYc2Z3eSMjONin+pZsb67rpX
 SDek2QMDh1DUuFUiMig26ztWV1K3bjIbv595XgQhp5wartMoXnwHjASMt1cuNRii1FmJ165UFqH
 7DoXjOV9LJ2Wuy7tRta9J8VwxCcphmCziFiYiZai1F4ox4RdP9d6nQvzKz7pEtniyejpzWDT9mb
 mHoAfUBT4+T96GN1yHw+mTso9R3VvmFjGoFUuMikAy2btG+BjrrvvpVEC+aHdWrBFH9sr+wNEIN
 k5PLVVB8kqfC45Zl1xoD/dzauSFE6r1h0VwHuNeGIh1hZGJxxJFEAvFdMvFi
X-Received: by 2002:a05:6000:260f:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-48e07988925mr8797027f8f.8.1792314620224; 
 Sun, 18 Oct 2026 02:10:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4edea3sm16543168f8f.28.2026.10.18.02.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:10:19 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:10:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 690ed32a0c87a92f2be1aecd90650d31f56953b4
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 09:10:17 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b39fb5beb9c36d748c2d25ca62ace96bcfceb3c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIMuQ-0000Kt-Uh
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1486083448933221334=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1486083448933221334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PijQCzEMC6U="; charset=UTF-8

--PijQCzEMC6U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

Gert Doering has posted comments on this change by Antoni=
o Quartulli=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demai=
l )

Change subject: multi: assign clients from a named, tagged subnet-pool=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 6:

(1 comment)

Patchset:

PS6: 
Also

```
esrc/openvpn/options=2Ec:6370:=
13: warning: %d in format string (no=2E 1) requires
+'int' but the argument=
 type is 'unsigned int'=2E [invalidPrintfArgType_sint]
e            msg(msg=
level, "--subnet-pool-ipv6 network must be between /64 and
+/124 (not /%d)"=
,
e            ^
```



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1783?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Ge=
rrit-PatchSet: 6
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2E=
com>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Su=
n, 18 Oct 2026 09:10:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=


--PijQCzEMC6U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>Gert Doering has posted comments on this change by Antonio Quartul=
li=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1783?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> =
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Also</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```<br>esrc/openvpn/options=2Ec:6370:13: warning: %d in forma=
t string (no=2E 1) requires<br>+&#39;int&#39; but the argument type is &#39=
;unsigned int&#39;=2E [invalidPrintfArgType_sint]<br>e            msg(msgle=
vel, &quot;--subnet-pool-ipv6 network must be between /64 and<br>+/124 (not=
 /%d)&quot;,<br>e            ^<br>```</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"=
>change 1783</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
83?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Antoni=
o Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun=
, 18 Oct 2026 09:10:17 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>

</body></html>
--PijQCzEMC6U=--


--===============1486083448933221334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1486083448933221334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1486083448933221334==--

