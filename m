Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E8C982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4eTJ4AHwR4nYks7+Js/DmCyh8DKF50cAFYItGydl9Qo=; b=a31xSo5bjALHJqR6iXU7wHRLQ6
	nLEoBkFBAV7R5Bi1X5egxvMsEKvEWRoHdgVhzGNPgU0Yc1WPVVDbimP2aCW8z3mC65woQqYXeXqz0
	hpINGOsTl00sDJPoUHRGtv40HxDYDONPhJ0jLIgFnKSM5tvV+qS9fGNAtpDKYoaG+2iM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90Jr-0004Ta-24;
	Tue, 22 Sep 2026 13:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90Jq-0004TR-Cn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tySDGHD77wMMCAcNglPduwP/4NWagg8MRJajmpoc5FY=; b=hjo2edrH1DyJykrI+peAzFM4IF
 I1ju4xu2g6FnlIb6MQpDygZ5B+l2U9v00V/3ldh0aK6RbS0Wrcv/rc3gCwrMB6OafmbiVGHM1qZ4y
 sADHqndog5vWqdZE2Yo6yjjZ99ZLjZxk48Gzzy9zqAXxjjPMkjOkTbBdpE50XrSp/gMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tySDGHD77wMMCAcNglPduwP/4NWagg8MRJajmpoc5FY=; b=l
 lIQjUzO0bR9A5TApWs9k6/40H6gXCUS+ngXL0LSZxtSbtSTATGS3BtmwsecJ2iuoxPLg63B8JepCM
 70jrsef2zjcIqpHeYcaFiMksAzCqPqwzyLJVIQesnhLRtKZ02beBi700hV9S916WVN4B11yIxrgOr
 oftFp6rFBS5jn8g8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90Jo-0000j8-IL for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:13:59 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so21611405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082830; x=1790687630; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tySDGHD77wMMCAcNglPduwP/4NWagg8MRJajmpoc5FY=;
 b=edM4/qsWztXvRADPbsETEVAy4CXM+ERTB8Q3xtcKqPYgph+cQTXLUArHbf7R2XkSjj
 nbQ9lGUFwLztkH1mVGomqpQApjLotRB4n1FWbX/P9SBi43FW61au1TTgTxDkxq/4Q7iN
 wAdwlPMoPeD+Q4aqZwtIg45eMScTYQGQ+PCSm44x9IUFJhG/rvVc7YW3UWkzYLYbdNaM
 v6lPUDEffMPMPOQJsMj+gqltIjwDfE/JJxgb+3yoSv6R6bOvKpig2kOfVhpgY6pkVFjc
 AH5aPu3r3/iad6ElsrRLFeBA9Vq0Dm2OmUyolsH54D6s2cn3oqliaO4Bnfq8XnzWUMh/
 2+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082830; x=1790687630;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tySDGHD77wMMCAcNglPduwP/4NWagg8MRJajmpoc5FY=;
 b=R7q4iv8glE9dEG6Nd6VmHHvRAEWRocvKCiMCnH3TrZI9xpGnx0ZRGnwfq9kWpIyfwi
 isg3Wz+4x+5fLCCIBA3z8ckkhvUYVEhFQOF2xs7w3X1/ZaZlN9D+ZW4zMpCX8g3fzfai
 12GtOpHSwsuSwa0fG8jaXorWIKFEUDgYnFJAwVk971f6jJTe9gVW6/F7KjYsSBO92HPR
 cTnYNUUTnEwOdQTWK2pbHCP7uA23tLTlYcSfIog+RsOgdLCiWxaiC579kLR22Y6FHlI2
 H2yM23S3pez3tbq8mD5thp37H3Q971ttOvr/NNJrFMrOsUGB600zPRah9NEu/Y0Q+7n2
 WKtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhkeQILLqLte517iTM4TPNAIcfW2GaYGys7EozWMXDmk5uDoav4ijug46ZkhfFN+H8Cnv3v5NCMTWWlmsd@lists.sourceforge.net
X-Gm-Message-State: AFuF++lbU4TIjBENoGf5Khzu5fVNFURY1WOEHkOe00C6/MEdEjcznZ/t
 3fSPPoMQy4nYTdmpDSSMUsPqf6oA+jjclv4WqjLj9kNy+auWbj4AKTXUh1sA6HfxLSE2OoEIj5o
 n9b0Xl/zbZAx9CzSzYYIEOIVN9uCKJY/RNigrUVyCDKNQ6BNFwxpgsr8fMsOVj/xwPrk3/UBMLV
 Rpv6L6Ag==
X-Gm-Gg: AYBFou35JjbOFswfGlSop40I4nD7Pw5jTfRS6L7y4LoorSrwkqLCvKcu2irA1ZndfAB
 srgBTRwIVqPWuAhAMjtv5bw/N/6MwyHrY2r4rnpY9UZalCH7zNLIk9kIGkTg/Oo8A3Y0/PX3e4f
 zt0G31gPFUzTICy/uSFIwq9AlhbAGpTzjlZEeIoqVCL4ztSbbqYqqmD8Hi+RRrUC0Si2Cjbkp47
 4A9R9cw+MiEO+Zk7ajGDGm0ha/Lk+aD/ofXQZAG7soG7k0McGmYXdVXNyopUbq9HF7g3ekrFK/s
 CABl3dpK2VSt89eKwsyL1PL7imh8RJNfbE9/AN5SgM462nn9nUYb994kang2LNMde2bUP4eC6lK
 W2xQcuYReyfP6Pw/dc4tzibnI/O06Hh8JOb/vvMVi1ctD+FjNWb/o167s9iCQPDtw+aH3Kuy4Yd
 yGwfrLSYsh1FacQ6FoOxEv7d6ekRFlReuYF6iXYpkIDNmkbjafYhLFJiNC7riDQho8YG8sI5pWE
 f1risflbwyeJ3ktC9IhZEDOE1jZRtA9LyyX2qbSrImlX/I9h3vfrsNo6TImCOCmEY8T+LIHsPlb
 PFvQDkHZ9n6TdV/+wILK9QcnHoxge5uUCfLE+uSzL+JWcRIltxUdKtkpMJoKqnI4pPWKCqQ=
X-Received: by 2002:a05:600c:1c01:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-49fc5753eb2mr248762185e9.22.1790082829839; 
 Tue, 22 Sep 2026 06:13:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaab0497sm61499025e9.3.2026.09.22.06.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:13:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:13:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 614e52beb28c5b08f617841429fc339d5d339e54
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 13:13:46 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c06dad5caaf8e87301e2147fdcc079e905704e61-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90Jo-0000j8-IL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3763702927895350361=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3763702927895350361==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0MeUZKYHI9Q="; charset=UTF-8

--0MeUZKYHI9Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 30:

(1 comment)

File src/openvpn/options=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/7c0497a6_07ba=
f4fc?usp=3Demail :
PS29, Line 486: 'off' stops answering probes altogether
=
> No longer it seems ;) This stale reference appears also in the commit mes=
sage=2E
good catch, fixed=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: =
1752
Gerrit-PatchSet: 30
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lic=
i <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue,=
 22 Sep 2026 13:13:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--0MeUZKYHI9Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa has posted comm=
ents on this change by stipa=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>1 comment:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment=
/7c0497a6_07baf4fc?usp=3Demail">Patch Set #29, Line 486:</a> <code style=3D=
"font-family:monospace,monospace">&#39;off&#39; stops answering probes alto=
gether</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">No longer it seems ;) This stale reference app=
ears also in the commit message=2E</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">good catch, fixed=2E</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85=
a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_=
lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Tue, 22 Sep 2026 13:13:46 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--0MeUZKYHI9Q=--


--===============3763702927895350361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3763702927895350361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3763702927895350361==--

