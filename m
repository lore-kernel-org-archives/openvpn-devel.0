Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0DCC531CA
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vEVg6hgCeii+8i2hcjO1uGXYoEjiiWS4+u05ZOuKh3s=; b=kOneeoCbj3PuBHYY4x0vsWekDF
	4oqCxY01QU57O9JoRmC0GHHd3U/BFIA7eChdd3PkJY4RyoJwxCOcciP4pJgRwSW3espmI7zsB8nmQ
	f7yorAESGwC2WkhQxu4R0YhP6qQGdaOKcCY0xqZRqwYf5CghjGuXL4Nb1i4Mj2IJ09do=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmsDs-00061H-4D;
	Thu, 23 Jul 2026 12:08:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmsDd-00060x-C3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7gwAZGIS9aIrl2Mq4dvd3fuN7VHH3et3VakbSu0d31w=; b=nRNrWcQy6pBTEs6bwkbbCsq+cB
 fL8GubBTBSGPz4E/0heVUcGYRuWQV++rEPXfr0ORUd5j9KHxtGGsI3fPC3BR6DWrgINqnzMgBhGJC
 LF1lWaHMjdaoTDIGvKK4IFXPfKakGHAq4Sy6PuUtQYc2vtIWi16rkPwc/YakuhxaUg/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7gwAZGIS9aIrl2Mq4dvd3fuN7VHH3et3VakbSu0d31w=; b=a
 +KGJhbOVoO0wQYS5XDH0uoP5YsH5hVZBNVITOitPCjSmVma2zARuUIWP4hqdN0x2lGoA2pQ+3IcxE
 PO+x3wwm+4weEPnEt+q/aphx5J5clunl7mPXEFOIVGa++m2TC2VQNhn7+uKYUlKZ8qF93PnFRSJ+O
 BL3992dToNb36gDg=;
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmsDc-0002IQ-23 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:08:01 +0000
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39c7ce122c7so4249941fa.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784808474; x=1785413274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7gwAZGIS9aIrl2Mq4dvd3fuN7VHH3et3VakbSu0d31w=;
 b=YQ3Cl+LtdyzUgrJXEKANAEsEGgUlED2mNGCNquLRKFStq6VHNiUBSgWknjbz7TkRFQ
 x+mEKuZ3PirjmqqYmOj6OtOmHG1i98GmYhEpQxEViacgr8p5vq5vEnLc8YsLJT1IT3tn
 DFjLH01v5VS2MfCfhfIi/ZrIPeeEjWOgptR9W743tVwneMDNWRrpVPsNAuMs8xpUxBxL
 TJZlRnCo3rkjQFZSDP4Amiqxb1snwGrA4kZguTL0T5ggIUjz6+ivYFd8FuXnldQo3Ltm
 Ay+RDOBpP23F2YoWdoIQLC5WAUCYqdX7yOv05u9SxHfxwJPXQo5gZp9z3+1vw51FI202
 /8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784808474; x=1785413274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7gwAZGIS9aIrl2Mq4dvd3fuN7VHH3et3VakbSu0d31w=;
 b=aRG20eXAD66jigPZ0AdrL18ypsindRd/a942y+P9R0wXBd6pkXZuo3fNQxKqYyuv95
 YgfA/NflXyc26iPcGTBSr2guTPqQ/e7YT8WZWDllIwjp6lhwFVtg0/MtZdhVilvP8r18
 T/meROvHwCBZIkCkuA618u+BNos9qZeESHe7+ulwTeeefJ1a7+4AA1Y2uK9aHaBENEas
 9BhR8EV/zRa5AwHmL/JmnKUPFm7XOZkXXico3BmZdl1vXPWRvrNfFXYMs6MuomrC27M+
 /We2He8xwUi9wq7COBH6mGp8+IDzqOnbQ8h7s4N1Y3EAM3FUlhr2W2WD4i+o8yoaH6WD
 PI5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqutK+ni5+8/W7YAP3Su7AjpKLBgOsIQNCLkC4ez/NgBd4h9DISuMYtFV6kBCMLRAjpnneJAqs3oo9y4/5t@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxRms5NMOr8sUUCJsu4X+W210dWjugI50kn8xq8qIFHO0FL5vGo
 nlKxz8Vl+z5T/n2PBWG8zYq9Uwp+EaoAaUUVW4SW6MsA5vn8aRNJDrhPjvTW2W4Onc9iQjkJJAj
 a259EQzxl7B3t2CmcHEiyXymvoWgBZbTK9BXxzf55F3um6jXsSVgkXUf5BY8yoX/cyB9lkfxD3c
 nnf1SoZA==
X-Gm-Gg: AR+sD13OVKinOa4oc0O+w/+YTPbRWY33O6FboV7WNDrHaueaC4KB/NDX74AjXrk0A+y
 BDUGxMzQTEVOSD1hPhFa2GEuFHrr88LVQLewSqBiisCVEn1FrG5i1x9fOa03aJxR7dqIEJFPXac
 wa5DxfedT1DIPhxqcCJ6lJ1rcbNoaIZlMG3SNhz1JmKdIbGBxp4rLYjDlTJ3xa+jfxdGMQI5Xcf
 F3bZSdbSzXjuQ5VSnVLTB9ADFzGU/8qxnsrtTDsUFP291Ow2gANzYw5Ku9NwceVnLVByyDxWT5J
 N763cxU5zpL8OUYpIMOSuo69HcDQqUIf/IXujKlft78X0L8LNU5G65fQOaz0LhQnWLvSpDUgWnt
 KMabDMO73XuRIxl5WJT9xgumSmJTS1Yg68e20/Qdr5EsYqlKOccES/vef8tWAwieWSu9HXohh9y
 mV1SvJe/aK6m4Mx6B7ajJWAUKO709mbvkEEd7CoYBoJzh5aRupMI40v8Osn4xUoX8ZBgP0Hib92
 AFYjcxrgdO6Vi6PpV8egnUwr4QHnmr+zs1coFhubf+gvoceLuDcP0M/rLcatWil6HRM
X-Received: by 2002:a05:600c:4f8e:b0:493:f78f:cd70 with SMTP id
 5b1f17b1804b1-49573cfc965mr39129905e9.18.1784808106056; 
 Thu, 23 Jul 2026 05:01:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm93774365e9.4.2026.07.23.05.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:01:45 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 12:01:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: ec9d50c318b67c8836815a0029916cf8e8f43ea5
X-Gerrit-Comment-Date: Thu, 23 Jul 2026 12:01:42 +0000
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7a5ec13246dd1e2fc46ad652d51ca9d4a5aebc9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmsDc-0002IQ-23
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8413372184219307548=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8413372184219307548==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dS6GqvK3TNk="; charset=UTF-8

--dS6GqvK3TNk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS serv=
er and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

Commit Message:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/e1b4623a_476b04f4?usp=
=3Demail :
PS2, Line 14: We later explicitly tell initialise the SSL object=
s to be a server or
> "tell initialise" ?
Done


http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1728/comment/0749af9e_fe6b6537?usp=3Demail :
PS2, Line 26: =
Our mBed TLS code basically does give the SSL contet any personlity
> "mbed=
 TLS"? "context" "personality"
Done


http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1728/comment/aa8cc2c9_f6500e61?usp=3Demail :
PS2, Line 27: of client o=
r server until we the same area where the OpenSSL code
> "until we are in t=
he same area"
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1728?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Gerrit=
-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 23 Jul 2026 12:01:42 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenh=
eld <frank@lichtenheld=2Ecom>

--dS6GqvK3TNk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/e1b4=
623a_476b04f4?usp=3Demail">Patch Set #2, Line 14:</a> <code style=3D"font-f=
amily:monospace,monospace">We later explicitly tell initialise the SSL obje=
cts to be a server or</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">&quot;tell initialise&quot; ?</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1728/comment/0749af9e_fe6b6537?usp=3Demail">Patch Set #2, Line 2=
6:</a> <code style=3D"font-family:monospace,monospace">Our mBed TLS code ba=
sically does give the SSL contet any personlity</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot=
;mbed TLS&quot;? &quot;context&quot; &quot;personality&quot;</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
28/comment/aa8cc2c9_f6500e61?usp=3Demail">Patch Set #2, Line 27:</a> <code =
style=3D"font-family:monospace,monospace">of client or server until we the =
same area where the OpenSSL code</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;until we are i=
n the same area&quot;</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3De=
mail">change 1728</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1728?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1728 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Thu, 23 Jul 2026 12:01:42 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></=
html>
--dS6GqvK3TNk=--


--===============8413372184219307548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8413372184219307548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8413372184219307548==--

