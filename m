Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D75C982CD
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PG0Gf7/R5hzi6eCenCMi7d0JLVw+jcZ1v0hZdRE1uic=; b=PCx9QAfHnnX6QDmYGSCGI7x1wK
	32NQY2jI91ey+Ef67xzWRgf0fUfFhOk15y7ziyfnQTkHeRtiBnXdy1PUHjKk2ZTQ453D2sBHLShxv
	XfESN2uZefEu5+Jc5VRhHT6atCC8Xx1fFijGeNTjh9d4o0d6tBgBc9L8OdY1HWLNQ/kc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rrZ-0004NM-RF;
	Wed, 16 Sep 2026 15:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rrT-0004NA-JM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MzB/zQ5kvQTTJVhukalit7zi6jjtlxcdUnZFmO0eq9c=; b=isb1nj4fNkyPdH3X9FdX867H+Y
 Pc3hAx1w3Fh5R0z4N8GnltgEE30jAxSXcT8LKO0dmHHBB0Eb+wpjZT/irG2w1tUTlS93WL/fugOn8
 sBN/p3jSAHx4vaioZ87hrt9KlTLqu6ZCOI0KOiczqoeoFlfdb1eWA1Ep/2mgvVqHRZI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MzB/zQ5kvQTTJVhukalit7zi6jjtlxcdUnZFmO0eq9c=; b=W
 w7MUFnewDY2CY2ys+qwvGj4JnW+lFIKS8Z9fWf8J1uu5E3AzbCvqNu7g6nUJc7jrSbqu3SOqXHjlc
 aoEYf7TUWMVogS3l1JLq/UukF4c16PajUsUhzGmDWfZ/LNX8nsSPG9Q9SionPavAiuiH55romCqlG
 v5lB+P4HDlA+mAEU=;
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rrT-0000Or-1I for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:47:52 +0000
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b76694fb7aso1976653e87.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789573664; x=1790178464; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MzB/zQ5kvQTTJVhukalit7zi6jjtlxcdUnZFmO0eq9c=;
 b=cB/k7yRs9Yfjmz+DaNVMY/VNwdx4EwHQw3Bb5AGDuoFxD/P+KC6RFG4UF+ZExOJCoP
 3zshE7eNSgjOeqzvIUf03s62DhW88dmkud21s+xQeR3GCWIe2C9gTzoi5tgpR6vjhPTB
 can+Jkj8W5/GxxUyeGRPDeDSvA85mxKkbWQ48bPDp/Bn/fzDVwq9oVyU0XTIdAfODfQe
 Fuk7+UbzwPcEZJ7r9gGejD+1AZ7JCdlfUSt/gIou9HSTgjPHRJOsPlfXjS8ZOM4jpqks
 sGMKCxHMV0XzttYUqM6E7GE4L10vafaMfZ6YBss96VJgBfZVZPYTOwJSJFmO7RqJdDZW
 ligA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573664; x=1790178464;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MzB/zQ5kvQTTJVhukalit7zi6jjtlxcdUnZFmO0eq9c=;
 b=nuwK93akiI5gD87nlBirK6fLD4WyjgT0vinsizVIBQYYnoLvgRLBT1l7jaJSWtu574
 SSiRmNNKNRb69rb0DKIeY+excZiynjW6xrBMXODRZkqTxlYF1nMH4xp6bNEkS/JA7hGy
 BE4ZTr8BGgSh9iBk6FzFF6BOiQ2K7P23GGswQpjjfQ3WoPcrSRZ4XOA0uAbzKl7cNbVW
 BRAot68jOC9bIrurn40z7oniy85J9ioVq2Hqu8Teb5TvPxRe9CZif8djGwfhoIy3V/l1
 /E3IPGlnnfNto8d5UCKHIaUmphSiS67yRJ8x8fDJgbCGQ3fdQBzyb2LlCfNp7rTzGvHw
 ggmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1QGq+zyPuVqpVqJPWybA5zKeO4qdBWgSVCE7blw/8MT8fjpB/zEXKIGepyM7nXgxGsg4no0WIiI49Xcqd@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1gOkM4bZVSedoziIE+ukaQchIcOygg3l93g2phEjE0+m/lQYY
 dHUUZPcVG8zJdJnzHMTwIi2ddmoTchAaBeLT6HkxZcBAnu3GCgKgmt3YGjGVkNYTBoUGujUcIUO
 9jzPOccZCfcnwCwF3Vu2bP+lg1r0XG3TaI9+WKLKwvQrZzkxEULAp/OoK8tFf83HTX9dPOFk2yr
 nVu2FJIg==
X-Gm-Gg: AYBFou2osxJ0cv/6Zj8QTLm1vloRLHFRAMs8MoY24q+1rFw354Msk1ZmefQRqo3MpR1
 RrB80NKQ2EVQ+Mk6Q16kH+wAu28zKtfRI3n3Dc49D5mz0qC+WGnIvLocaThhBP7UxKl8azzreFy
 JyvRSuriY3BpTjSTKRWc7XsLzsgNnVmSKL888jg0FBwyO5bM6O4GyhAWCVe/Ofn28y9dVgM2IcF
 AlILuTX0PTwp6W3EgxyxlGEJFHzZ2wWPzHijIyl8ms1bradGKPe0AQXGPhmLpuE7EFwy8j1bf6U
 i25OWtCtMoHpHNDmX8A8UDeqKTJsnMOI2dnrkQ/gVnD71Cyc634yog93pT3o93XfI9O/4o7O09d
 g2JCeb7z3MuGA6dl0U+rV3QeQ4uGhRrvrydQOe+6rXxOZ2NHSl0JIdW/VUqO6V/DCQ9ihUjoYAq
 UHsB5onRWUXyKk+u6vXZcef2ZxIsUlHC33btH8oqJHALnILV6DWS0IT3AuacfWH4XUYbJYLpvfY
 v0tKJ59ICKOA0ne3bEjSz/1eDWMV7A9Z0ERSUnU7AGPCgBxQLBOOTkTEbmCvB6vN34C/gjrUk4e
 OekKmggVK8Yn1afcNm4Q5BvmJ03EsKo8gcOLApZYT8ADSVYQn4O+QRLpvHkF2A==
X-Received: by 2002:a17:907:1c08:b0:c25:f7dc:2d6 with SMTP id
 a640c23a62f3a-c29c8bdaed9mr660342666b.23.1789567387796; 
 Wed, 16 Sep 2026 07:03:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de68fafdsm149537766b.63.2026.09.16.07.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:03:07 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 14:03:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 7b3fc92556d90c37f743d98ba1b7744caacaaae2
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 14:03:06 +0000
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6326e568b9d56be2da08acca7cbc0608cd81acad-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rrT-0000Or-1I
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2962996703195422272=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2962996703195422272==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4oWdSK7PA2o="; charset=UTF-8

--4oWdSK7PA2o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1882?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Check whether addresses are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1


-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07b373851175d865abdb1513f=
90655b3fa31d5fa
Gerrit-Change-Number: 1882
Gerrit-PatchSet: 1
Gerrit-Owner:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerri=
t-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Wed, 16 Sep 2026 14:03:06 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--4oWdSK7PA2o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">change 1882=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07b3=
73851175d865abdb1513f90655b3fa31d5fa </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1882 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Sep=
 2026 14:03:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--4oWdSK7PA2o=--


--===============2962996703195422272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2962996703195422272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2962996703195422272==--

