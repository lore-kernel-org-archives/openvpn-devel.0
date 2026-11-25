Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9C606A323
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AcTVLl0y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=URN216bw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ImWB3/DY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GBo83M8o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dZZ4A3BBUvL+ifta3upcPp+QnzmVLa1DY9VkGKq7vfA=; b=AcTVLl0yg3SpVlM3uOlQ3b8XPB
	WAj7kpcwUzZHCvxalk6lbJitevOAeTfRcRuBJWJLnD5KO0z5I7H7lIkr09oI7GUXrYnGDU5Ihp0Zo
	EjKuQxNRknetwS9hhND94vDcb8ywMr2VRJmV5uHfbcFVr2GXKmCSKr6+5BXJELbNdoug=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWAyl-000000004vL-0aLu;
	Wed, 25 Nov 2026 11:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWAyk-000000004vF-24Md
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WLAlEo9AcVouo/8w1hkmcUUqTCEpq2qVUHbIz0cuVdM=; b=URN216bwGMbmVkS31WfeT42fPW
 2zGyNLGXqzb6iewh99H3W8s+Mzi9wlLUnkltJkQviT4f8BGdTKgrLmPV6BTzb5laE5Stj43NhrBrC
 TU5qqKBAJ4Dz/JgGcRKcCr3kRthjm3MDZOtm3HiFB8zR2MP6457ocbqgxvE7hBbbYBsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WLAlEo9AcVouo/8w1hkmcUUqTCEpq2qVUHbIz0cuVdM=; b=ImWB3/DYojytSDAV/cpn8Adh2b
 jIwXpfI2U44OFyaN/BSKD8Nf9c34Ca8updwzXsvorCWYeOoNlWNSjJH8NVabzggjdwkCRoAiM8OoE
 ar6EBosX2Mu++ajszh3A1itt6loy4ImHDZ+xv8h6md/I2cUy9nnFInAX6Wmen/WcvX5I=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWAyi-000000005wW-3wbl for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:15:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so57693395e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795605350; x=1796210150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WLAlEo9AcVouo/8w1hkmcUUqTCEpq2qVUHbIz0cuVdM=;
 b=GBo83M8oHLWIUUcKJwpQb+uKs9swbzBSp7otGfuDjnrZetY9h512FdcpCc4fTO1Nov
 MJRmbq9lzx7zpk6BOPiaE+sUElFmi6dlD1c0PK0NvSv52jdCD6ROLPC4eTG64yJJ8Qld
 Ok7FgbojWCFyFGy3n9U35dq+WcpWiOeObHH2pTTLF3Iy5bdbumodje3nj+XzrVIidQJQ
 Eso3MdJ7dtVVP/Jr0cAVo3Tmfp7+lULjBPP6L/txx318xBnCKSbsvIjKwqGWTgZDhZk8
 i9/QTpAhgvOR49ClA3l9k/EMoGqG+uitMwGFpDGk8zg9808AHMkO/Msn/W8B0vXgYfu9
 6AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605350; x=1796210150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WLAlEo9AcVouo/8w1hkmcUUqTCEpq2qVUHbIz0cuVdM=;
 b=gKi7hqLAlNnXGkQV0/BAEqh43pR4PEQYyYbEMwA0CUQvxWtmwfn5FY37iMfEo6Pq5A
 Ne7HGBHPAiACQ3Dvv6gyymT9SKXRG8XfF7ZMZ3S+RlgIKNjkARldmQFz+ZAOR4E7ZrMc
 10zzHn1xxLFARSW1vapOm6kuQso6dFDBBOxY6c+lyimNeNEE8ebDsXkHkyal5ILqLBWW
 mZm7fToMdYuUJ+HDuAhFfrZA96L67ZCJAcO+2awPtaIV5EFPWYlzW23RzNXA9VNLnyMY
 RjUFHtO3ZAYVznnK9QG9Dz1lGn2uwVghyjx4Q8GQRKnqmECTfe2rBF2Zv6EZ8N6RHOYD
 QcXA==
X-Forwarded-Encrypted: i=1;
 AL+hErGQ2tDRrwqioqX4fEMjjeM0rfWZbh2LGsQvr9aHg/SKyuce4T5FWCpiYLpEnDTf0ns9KE7+nGItzgYD04n4@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+i9OjxeV03SNFK0dF4OrCI1lo/9AxiXMnyff2k2OkMhN2KBB41
 vrg6t8biSayMcI0Ba3/mdLLdI2CodOyZ5X2d99ai5LwqBgBeVCFs7DvcJUMl9JkaWo8HUIu7osv
 wNln8YjDew+ppdI5iyIuHJgk/sQxg9g1dG1CjSXdD9sCBKdCJheK3ZoKm9bACAeBDFYMG
X-Gm-Gg: AZFdTZcWtO3RKrL2cFKJWncE4FTtoUl39BdKQJHoUpaQGUX10CQQZ8XIWmt5jtwQSwc
 LaQCIxSTIxn67Xg+Ut0mQZQhz+PuSO72Y+5RyM3u2grjZ1TDt7GzO8RLHGR2SHbfB6AYUVuZVDx
 /kHpX+jiUPv+CtmUKZmnB6/l3L89v/lKIZtF4YdESCM71/vW2bmZ8c2AUkUizeXMJPq+CeuR7so
 RXC7WlRsMqsIbbckCbqlJZmUjqK2E7Wpnw/AwXFesqCQiUQY8OButBZlKfJao3uU/kVLglCZ9Zy
 wbEbYFwiINbAlRa72Z/YEY2Hm+KxXpInGOjzv9NJC2VpgLL3bsMw8LV5vUanBeX20Bq53KS0nZz
 +XmZ6dGds4E3s//9RkWMrQ5nq0ubq1Z9QDlHE7wLS673Q/ky/MrONNhROKQo1PTaQQIjRqoAUem
 R6/xfb2yskAosNamBtoNsFwne1rkkxMtcjEuKRVS1vtBBQk/avbaQho6isE9CqvFIHdMi25zRgd
 T1E85yxrGhFDjMxaduoxNPNdwVXYl/CKKBdhxHwdAavobPHwF5F4p0nR5zCRIrIqafEQ9XPztpl
 TeVtOYNTcJ2oD7lp+JzScivjKp628GiqJCwZtQONoh+1AMoxEwhHl3zA1gpiAL3StrdoXVE4V3W
 GJQj2xciDNgVYFukrB4CZOpctXvh2ky8u+PqLaBOw9sfYfAjgn4eltYi8TY0n+/lnWs6MwOS8ZU
 qDdFpp65odOsGxCWUJ
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id
 5b1f17b1804b1-4bb88810b22mr349340355e9.17.1795605349617; 
 Wed, 25 Nov 2026 03:15:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm293936585e9.4.2026.11.25.03.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:15:49 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 11:15:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 11:15:48 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea579e971f2560259401e95b0b88b8e2310d8cc5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWAyi-000000005wW-3wbl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5338870920485058999=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5338870920485058999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Um9dwv53R4A="; charset=UTF-8

--Um9dwv53R4A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Deri Haerudi has posted comments on this change by Deri Haerudi=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: =
dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

Patch S=
et 3: error message on an unreadable vars file, your deny-list
for dev, and=
 the search domain loop as suggested=2E The commit message now
describes th=
e dev check and the change to the search line=2E

Tested with dash and bash=
 (reader and sed calls also with busybox sh and
busybox sed): the sed e/r/w=
 dev values that now get past the reader are
inert in the dns-down sed call=
s; dev values with a leading `-`, a `%`,
a `` or `=2E=2E` are rejected; tun=
0, eth0=2E100, wg0, utun3, tun/0, _vpn, vpn+1 and
tun@corp round-trip dns-u=
p/dns-down; apart from the search line, the
resolv=2Econf contents and the =
resolvectl/resolvconf arguments are
unchanged=2E


-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
Ge=
rrit-Change-Number: 2341
Gerrit-PatchSet: 3
Gerrit-Owner: Deri Haerudi <abc=
deryscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov=
 2026 11:15:48 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--Um9dwv53R4A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Deri Ha=
erudi has posted comments on this change by Deri Haerudi=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Patch Set 3=
: error message on an unreadable vars file, your deny-list<br>for dev, and =
the search domain loop as suggested=2E The commit message now<br>describes =
the dev check and the change to the search line=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Tested with dash and=
 bash (reader and sed calls also with busybox sh and<br>busybox sed): the s=
ed e/r/w dev values that now get past the reader are<br>inert in the dns-do=
wn sed calls; dev values with a leading `-`, a `%`,<br>a `` or `=2E=2E` are=
 rejected; tun0, eth0=2E100, wg0, utun3, tun/0, _vpn, vpn+1 and<br>tun@corp=
 round-trip dns-up/dns-down; apart from the search line, the<br>resolv=2Eco=
nf contents and the resolvectl/resolvconf arguments are<br>unchanged=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=
=3Demail">change 2341</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 11:15:48 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Um9dwv53R4A=--


--===============5338870920485058999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5338870920485058999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5338870920485058999==--

