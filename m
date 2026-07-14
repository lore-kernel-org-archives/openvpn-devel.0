Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB7C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ld04Sh+tKD/JQ8Hu8cdVxOJtGcz41u+MeQW529RneGw=; b=MP15gp6ifzkfeKUETUFcXNoK+6
	w4lrq5X+sWFPnue8EXD55e5Q4Pg5BKulwy813g9vk7P+mvJyC8uoLsTRiRUVeYY6L1MGObPD9gPJ2
	x6ol3AX1p9zP4yItPq98pr+Oa2LDg5ddjgvXw6mEe7oox7q+NNsANUHCbareuvPAteqM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjc20-0000QP-Dt;
	Tue, 14 Jul 2026 12:14:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjc1z-0000QG-Mi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ioQ8mxbbtKlRkfsdA2VK59/ltYWFe3++fPu6mQdbXS8=; b=X6mRQ0ESzmYslWPuXbVhu8jDgT
 5e3K4wsYVvxSjDkfxpqbeC95tyVnSckJhP2trdmNS+zmh3dnWx3vQFhnofHXLbbJaqehbymsUXpiZ
 ZtEDDU0yTMBLd9lJZjbDI5QR6cLmLvwp3eoDcbyXpXCm+nKaXkQB37ECmZNvVt/YvyWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ioQ8mxbbtKlRkfsdA2VK59/ltYWFe3++fPu6mQdbXS8=; b=P
 SU7lv/+Fu4aIzipKk9fM5Om2qV4pjRfkBmEpwwD/b7RIkhBkZ7MEYUCipybGkdXEnBpjofYGwlZ2h
 mWfZROlOU5pC5w8WG2bRpQMTjSjLmd4493ZDVAnz1aO1RzDOOX7c4RJpopt/iwHRyyPwodO+BOKMs
 hk0daP4hErZgdRLA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjc1w-00081I-Lo for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:14:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso5152605e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784031266; x=1784636066; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ioQ8mxbbtKlRkfsdA2VK59/ltYWFe3++fPu6mQdbXS8=;
 b=c0ums6nVPFX9qtxRw9WYiJUZB6/LCi7PnYlMSSXKNrwmszuh3O+chE9gdNbYaeF+FU
 DtQUWaP6yfrjrthu1TQfv7ZdYqdsD/wsTJtC5cvdZcXvDe8PlTLIiEltTWFijvHqFoXc
 cGfnxY18zJm5Zi+hKbelloux6ykXnLsMB2/KI1eFSP/sjIMW/Zi5IlD7bG8Jvqra/xeD
 A51z52YclEgpjgNOqjVwoddtQ2HvrTf6H63Y+9zCpykAAH2bGwWddu18n4ApujeHj88X
 fz6aNGEABg/tckpnLdF0SpFCH7d2lxoeNHpeLiizyK8lgh9utWQErspASErcZQ8GHodE
 Mx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031266; x=1784636066;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ioQ8mxbbtKlRkfsdA2VK59/ltYWFe3++fPu6mQdbXS8=;
 b=p30/DvWPvsuxMfwsfdcy/a5CSaTEmEy99s3VS4O6MTlO8RFdBsVqwKg12BvA8XRSsM
 7XsiUdfEFKHlPUgRinkZwamW6o76inOuoYI3Ud5ezBjyUli5dZAJ5vBmRlB5J1s7Lim5
 QLdmPEy17ryaqNaj94xO4X2RtgOQ8/SLYm5rNkK3i+n7sL4CKzi06FIXIli++jTdayYM
 yAQxDtAXT/r5UPV44BNG/Q2AmzOCStzglaILEdBibnYonOnYxNooXRjVS2uwGaJkNgrM
 7Otusf4eRpmgbBQt6OQzZ4aSbGeE8FWwOffYBhJDBF/S/CMWv9uwNyY9F/Kjk9lCoPPR
 xxBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6nY/CVlG30Pmr/xAT0axclIeDq/+qtLj4dPsSy7JgL5EvUEbEdij28KIz4KfjHKzLde+/Ik0O0VTAGlds@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwrPBg20XDxlQYmcOJteqw/W3LqpZgz1c4NW2zw7get8YBbBLA+
 CUjpA4zbpIeP+8F0x87CK05OdoNpppFUExEr0DftUESE3dyz805/NGmxUr1uvGz7QzR+hf1x07m
 ulPVweOFk01jhD8s3Q+bKEMGfVAIr9QjSoZPonJGjuJUuwOpB1ePcObaAqs3FeicStyhxaO0exS
 vLVu15RQ==
X-Gm-Gg: AfdE7cm2ZlKCppkB8bf/ngEsLQq4qNqxkdFmxgJfKN9soijZVieroFwp8tE+ArMhOql
 um5/tPoCsaF3fROki/qzPZ/NvjV2qFbwKPD8p8XpnW+DrCrW2N5hJdg0wsW6RDoHbwKXbwg9SX3
 m2FyIVtNj9YSswoF5vazMcrDE+yVCntIPR9WthLfbhn7CQa3DG9wK6teOUB0r5DpCDM6p8vhCWg
 ErZu4uts+op1dleRe3blsM0/yfbIe6GqfRJQW5gEw70pd5+18V6BZCKLsAd4/oubBN/rrCk/MJO
 WAVTSwHF2HaVqVVRuuE5bY6tVeVp2EBENYy7hmJ2Z4Ap7JOdlEsYK/E+aCWSF8Iwj6LsBWY18G8
 Cfuv/5a8yseq603TyNUMpKMhhfBHTuQWJoDkMcNQkVAgkLHpG1uh6sBbtvTzwvDI6Q1pgk4lC75
 +BXIbYwGHCJMSXeJtcd8yKNMGUD4UWFcLBuLzbVnXUZBfuDxt4i4JiPO0gXdtnmENFI5+e61Hbs
 9n//V5b1JyOhDz7jr1scHFVF2WEyWYwsk7yt09bchz/Oezt0NPDT8jTYhJytTNN8thI2ri6+oSW
 1KM=
X-Received: by 2002:a05:600d:6401:10b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-493f88c71fcmr97345105e9.14.1784031265856; 
 Tue, 14 Jul 2026 05:14:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a33a926sm63999065e9.15.2026.07.14.05.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:14:25 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:14:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 02696a6a2bd8999aa0d98b52d9eeaa314fc4843d
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 12:14:24 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0733560950788e5360d27500e9c0c3b53946ecfb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjc1w-00081I-Lo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============6903212768911344134=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6903212768911344134==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SlA6VXHE8Z0="; charset=UTF-8

--SlA6VXHE8Z0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/d3c8bcaa_da0242e4?usp=3Demail :=

PS2, Line 298:         const uint64_t hv =3D hash_value(hash, &real);
> Ye=
s, why do we recompute that in multi_get_instance_udp_real and handle_conne=
ction_attempt?
Because the one in handle_connection_attempt will be removed=
/replaced by the per SID hash lookup with the follow up patch and this felt=
 like the cleaner approach for the code



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Chang=
e-Number: 1725
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 14 Jul =
2026 12:14:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: fli=
chtenheld <frank@lichtenheld=2Ecom>

--SlA6VXHE8Z0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/co=
mment/d3c8bcaa_da0242e4?usp=3Demail">Patch Set #2, Line 298:</a> <code styl=
e=3D"font-family:monospace,monospace">        const uint64_t hv =3D hash_va=
lue(hash, &amp;real);</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Yes, why do we recompute that i=
n multi_get_instance_udp_real and handle_connection_attempt?</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Because the one in handle_connection_attempt will be removed/replaced by=
 the per SID hash lookup with the follow up patch and this felt like the cl=
eaner approach for the code</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 172=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37a=
de55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Tue, 14 Jul 2026 12:14:24 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--SlA6VXHE8Z0=--


--===============6903212768911344134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6903212768911344134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6903212768911344134==--

