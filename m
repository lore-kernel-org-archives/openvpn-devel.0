Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C04C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plwUrnGRiRwQneuo6GTjAbNo1/6zfPAbMVD0LbSJQh8=; b=T1GQK+j65UBo+/xuEzLEhKhjTt
	kYtOFDQpnrTLca5zeFflBOSfhIlHMdG9ehfDlF6/q0yaAKzDmG+6daeYym8lrPN0XtR29FLh1uCHu
	JKZIGT4sU4H9wQNEpRRtSoPJaVbWCVaCt1lFQq1LoQb6eUiDxG0eQ0Azr+jc6N4rDZ2A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZWM-0000sg-3G;
	Thu, 13 Aug 2026 17:47:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuZWL-0000sa-7F
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0MyL/dtiIZJYiszH/7Suk28s60Pc3RnPPTbAoo48Ee0=; b=iFvi5VQJrvg6fX+z3cJ2Yo1DD1
 e56UC0EMyNhIsXMfcpqRTMbHq7jqU7KjQHuKUyPoWsRU+cHPX29kFkZSLiFtDXgNNS3kjf2tV38Eq
 K5dCNO/irzNNGbYYmqYc9KaLg3l8067Omm27z287wgYYGetojlj8kVTB6GDIsrxO5tuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0MyL/dtiIZJYiszH/7Suk28s60Pc3RnPPTbAoo48Ee0=; b=W
 uRl2a8UEJxHVsP002M10vuD6RgzwHdUCpkzCBKBc1CkjbMYXlH6FjobWKaAtZP9CRMwobtguqvRdU
 7p6zLTW6UC8asK7R8JogXDDXYL2RBY0eLtIAmbooQGy3CuSXx+oC+bGu3TnFNSHr1M5lkcoPG8IBx
 bIaCM2xkTFUwB9Lg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuZWG-0006fy-1A for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:47:10 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so1643405e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786643221; x=1787248021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0MyL/dtiIZJYiszH/7Suk28s60Pc3RnPPTbAoo48Ee0=;
 b=BD+Xb96eBY4o7fF9j43xyKuTxAJqw0uTOsfF9eIYfI4ON7kzZM5njW/4HxMtffedDi
 WN2a//6xXcn1PWLXOYyrZX8dq/0plsg/Gi1iGDgKU4w6IgGgB7zoZD261AA+987oMSsn
 oSn3iLJNQu2QF7cyrGnpDvEH0syGV+uBqhrtS0tvMFNT/WIZvMaw7MOdFGBPhSYEDxPE
 WI51Fh7RnJ/maq/C1NOKgEpJM/OX7xDsdG78SQYA57smcMW4Vk22HffKZ5392RHbbXqX
 UHtddMNIHQUPS9tDiOYUmr+88i1FfQhFALquINg+xy/8HGF4TJOJBxcQbE7gX8f8fTPE
 O2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786643221; x=1787248021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0MyL/dtiIZJYiszH/7Suk28s60Pc3RnPPTbAoo48Ee0=;
 b=hCDiueYeH7m5IaTs93d4UQxGJgs1bePiE+jcLIAAabtIZCIpxgqlpRHoxiln9oSIPs
 6ktjqeGjJG5sGzY9E6nTrNg/SVd29xrRh0MfyXj4VSih2RteXGueYHUlZWgVEQQpw/4H
 GJ4qIGfHnepnuZ+7bdAO4Ed7Jg/bfC+DUSqsKut4fhBdi771hyF9fw2fHBigZ9SRxWUX
 Mb7IEejG8WLfRoMrw69SGnkjwyKWQHInnbsMI2PbMGu5XiRFNA9eliqrSsHfzUVBRT7v
 gzxWXl1MCFdNXBaID/pLLj5zSBOWdnPqZmySL6hXced5fKv8Zw5mHGR8eNJyPSiYMIPe
 Of9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rol1kAhPrmvmM3x7zhX+j/DSBI7zmRqobSuJBbxEE590trtx4BwFcRFQXE0cqbeNrHYioeoRlgD//piKPDU@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy66Ikh2V2cg+y0/jthzmvSNU9labS0N906XrCrJQlQuopS/dGJ
 ddAvaYI0Yqt1BITD+f2o+KfY6cvW+4NWFa7M7CRAVU2HoK6aokfUwWI3y8/X+NK50dovxMiVBSG
 Chha1nBoU7+kCZay2Vyr7U45E20w704WIz81lTRPMr6hQDCtvZzWwOee6eGEVl+f5o3jM
X-Gm-Gg: AR+sD13xYkLUpcC0rEGqb/RP3mj5bW6AkMSNpsXVDHWsRkFdoBep6+xcrJCPzaVkFba
 7ATChwbDVpr9HSgJ4jx7Tdt6weChyaXtkDIh5qPsE5eAFgk9DZP2lAgzqvAu4rNJgap8uNWHwch
 bumm5G7whBf7AYSHj1wEPZcRRwRhvhT4znv7/Cr65xgDzQ39hM5sG4L05mCkRw7IyjwGNQulTnu
 kRLy7SE3FITJ9VCLXWrojD5KioSYAV5r6DemWbIQrS31i/n5RNOD4sLsAZyTDgSBk98+bztQFyp
 eUwqoUOLGFHCCgwbbzYrMw6zr8pE4U0TESyvckYh644QHrt+TnDw7AVSlGqEL/JqBK8OIFsesH1
 f3sMSwaG1KIIJprckbhChyFOC9wCB8rF2acLMCSei8xsFqezmAdGLkqmnQn2crgbaWd8tCh2PFO
 5Y5UpHNvuK041KdleZobH+zog+dZvQQNHtXcn6qNEf8/FfVBn7oSdx82Uf+XUvrDU+pQcKA8cui
 1UE5ry7ywJscYV8M6jwjgbHRuB4TcgbaOFsLN78XCAHBqxastv1FLvKsnARU27bV/zKzJ2VfAaK
 g2Qlx+CSYWR3uAwLF68UkRPiYsy9s+POBpJC+QQaShbxmpgT8KZQ4M7Vidg2lw==
X-Received: by 2002:a05:600c:6b72:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-4998795f96bmr1635015e9.11.1786643221479; 
 Thu, 13 Aug 2026 10:47:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b62437sm81669915e9.12.2026.08.13.10.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:47:01 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 17:46:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
X-Gerrit-Change-Number: 1775
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1775?usp=email>
X-Gerrit-Commit: e11ca5b9f660fa09fd1d2873d90938b260caac3c
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 17:46:59 +0000
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkkwOWFkMGQ5YmFhYTczNTFlZWNiNWFhZmRiNWM2ZTdiNDdjZjdjOTA5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e75c9810ee2ea625390ad286d0a854d26486eb9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuZWG-0006fy-1A
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Move string
 utility functions to buffer
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
Content-Type: multipart/mixed; boundary="===============2861664986614055751=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2861664986614055751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AOIf0TGJzA8="; charset=UTF-8

--AOIf0TGJzA8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1775?usp=3Demail )

Change subject: options: Move str=
ing utility functions to buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
Gerri=
t-Change-Number: 1775
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Thu, 13 Aug 2026 17:46:59 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--AOIf0TGJzA8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">change 1775=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09ad=
0d9baaa7351eecb5aafdb5c6e7b47cf7c909 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1775 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 17:=
46:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--AOIf0TGJzA8=--


--===============2861664986614055751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2861664986614055751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2861664986614055751==--

