Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA20C79FBF
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqxEM8jQgcqqjcrk/5UVdVm0xTvV7FyyzwTap5yZpvM=; b=ALRMmmMoNB+BvSWToLFxZUDhuj
	IsKd3vc+pR0PegCyrpP4Uo/cvqqg3N2dPolz4VHLx7sx9zvJHIL3lODExcEf1on9P8TmC2RnSWrgz
	/VOHPh1DPQLrLy1Z4bbBxtgJDE4KPXK7+fVy41TQvPm3G2sehaNfyHa4Owg2K5JZS77o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4jzE-00074O-7q;
	Thu, 10 Sep 2026 18:59:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4jyo-00073i-UA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 18:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NFa+/BqF7XWg74kHetvlubNrvInjb/xG6dLZTv054Ls=; b=Il6CvVLsVtngKdCsnUYPyU/Gpc
 FKzvba7kimdyMa1DgahtT06qMC9vXLOTTe0w71m4BPLBrKw8lsrSfOLh7CIPAFsc3ELxnMuF7aXy0
 kh1mDgO+P8KLRZjk+fqi6WuyCrtxTtFjkYlQ9euzWlNR3IdoXvTiJTlMgfmKXWslKg4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NFa+/BqF7XWg74kHetvlubNrvInjb/xG6dLZTv054Ls=; b=S
 lFI+/V4XeozvT4OFz52J0kPA0ESIU/LKHhZf1AJNqM0ElsuNVzdcKjJN2Cgor/1XKbGSLJ72+sEyi
 dgyDhaogSo9gaO0UCGnkS8ZDQzQSuSpYtVvsxkFamrO7VQuKKceCgGbBQ/3EXQc98Q2Wh6WC7IztN
 eZER1nb6iXNX/5aM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4jyZ-0002sd-Dy for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 18:58:25 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b91369ef6so1282845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789066697; x=1789671497; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NFa+/BqF7XWg74kHetvlubNrvInjb/xG6dLZTv054Ls=;
 b=BHf1XadLdAkHlMtOT9NqVanFjWPiQbqjtoHLkRE2Rch/RqlvrhTw3F7cEOHvz6fqnZ
 o2GdqhshDuwJTXKyZTRxwN7/B36pMLRXVcfty6+joOPK20y6mkyfQozWRbpPS65Hbejm
 l6Gih91QlTKhcb1/GZySSo2O38OSlH9xG1OXF7Fqkzt6c5G8ACG0OoP0ZF3rdteGXbha
 C6meT2BNqBfJhhVEs/vqzlwIF/chSeFp6RKmg1t+zhkDr+f4+IDzt8UW0V8OHTMehFaE
 rSjgixoTbfhVlt6DezWn35un9hbdciHLtwIkNTtSXGGxL7OHziW5H0/y0w3tHQnwpm0X
 L8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789066697; x=1789671497;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NFa+/BqF7XWg74kHetvlubNrvInjb/xG6dLZTv054Ls=;
 b=IZeFT2cLS2N+qI1o5kmBwF6WxWo1QADSkqrbCgfqkZjwzEntKkW4GT3VbOHYBikOCb
 HvLN6eaby2ElpwHpPe8pIOwhTIODIU0GKks0vng5j+xd7ShDJU8Q39Hy5UQmHxZ0TP9p
 cTFBcvJNJI2/AYvrSNThRWrkVS9jm667CGB4GWTlzAGiQa5mE/Crh4HbK6UicQM+FA2k
 sw7a9yqR9Qzqk/Ozn82FcYAHsH2WELpru2c+Q/6Kp0AspTWjblmsiisBw0HyiKPFUxNX
 oGZgRqiR3SeFXK3UMmey6QjvrPqPf2kCEzdvXiQ617osNhv9u/oLUYxrYANjci8gFoGP
 OD+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk/VQBFV7cH1u6Ov4tW3OE4dfIjTbwN2/+1d0LHYU+AuHFkpucv6fYx3irRL9ZosHoBljhnaKxuLAh8VDZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++kC6WwyfLCHq5WQErCZGr0cSd1++jqtpO13+NvzdwzQ2LAtgzHz
 dywV8hyrYRu5D3DVkHML25ScJ5J0VdD8oxZ2uUtg8MNhx0nBzzYZmYten33oCd6FsMlZ2MLHxGt
 wiE0KqLA/H5nEXzBP7/vsKkPwgmgSOcm9MzQrEkcwJZ+juMiekZlsvulrd0PRQZ5XkiJ+
X-Gm-Gg: AYBFou1YWi3WpxSJnagPmLax2Sv/F66aO7UCKxM9pAeSn639BiQn7/yInwLfQKw1Z9w
 IwrXGvDQyqIGPAA717Cu4Vh6Sn5BG9oaxDTAnG7gFhJcPhsfr1O+s5R1LFbhmbRD//PBuZ34tmV
 pS91E0GF4KV4Ah2MUWy55Y+FqrrUzczY85CHRF6qIaRugjCOjizn7tyIBdPetlYvNmSwjDNfmy+
 4Ww+HkBbHQyIIVQdAOiFAD+OJXQCQ0hfmoPoWzD3CFixhTZ5uDXJ3XEh8bwWXhrC8WJeRY9ojVp
 gWgriuY9GkZ8MTluSO23K33xncrSwxUjPzspNiPaKTsLLEkFwran697au5dkCFIUYzlt1Pjvxax
 6h2PtHVJmY04HDF/Yg/x0qgKRlj4TqXekf4hJiFAIGWgo0Dywk7kmujeBp0fR+KuPbe0UTUvnWc
 wNCR1K6mNbUPFzKmd5X25vht3DYliztArghNcWJY5Nr1oqaxYTwpM8DirFDYByKcO77zsJKM9i6
 ki9hS/l7pS9MCwL9Dh6lsoHzdW2YpWxPp+ouTFWvIle3oM/PLZ9y3y2STqb2Z2jnuBq+wpQXCcY
 Ki3S1Z+bt4pJdaO6q3sQaVGFTcXC+FLJAPC7IQEf5I/VdD089PTcaW2g+v1Yiw==
X-Received: by 2002:a05:600c:4505:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49e61a03b32mr6466385e9.13.1789066696688; 
 Thu, 10 Sep 2026 11:58:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm424818f8f.20.2026.09.10.11.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:58:16 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 18:58:14 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
X-Gerrit-Change-Number: 1903
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1903?usp=email>
X-Gerrit-Commit: 440c2a864a19eafe9affd31f95fbd546d1b0e8f9
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 18:58:14 +0000
In-Reply-To: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
References: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkk0MzUxZmM0OTkxODhiN2QwY2RiY2I0ZjA1MzFlOWYxNTdlOTQ4YzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcbadb0d1cc2884be41f63e77003a727e9cea8ec-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4jyZ-0002sd-Dy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: Remove
 management argument to functions that do not need it
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
Content-Type: multipart/mixed; boundary="===============2731565115008172735=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2731565115008172735==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nBI0SCmos9c="; charset=UTF-8

--nBI0SCmos9c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1903?usp=3Demail )

Change subject: management: Remov=
e management argument to functions that do not need it
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4351fc499188b7d0cdbcb4=
f0531e9f157e948c5e
Gerrit-Change-Number: 1903
Gerrit-PatchSet: 2
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 10 Sep 2026 18:58:14=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--nBI0SCmos9c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">change 1903=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4351=
fc499188b7d0cdbcb4f0531e9f157e948c5e </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1903 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 10 Sep 2026 18:=
58:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--nBI0SCmos9c=--


--===============2731565115008172735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2731565115008172735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2731565115008172735==--

