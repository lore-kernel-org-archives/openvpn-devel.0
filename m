Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA1C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4FLAl6Hent0l0sDVzEG9IBn2Q7TVx5TPg5pl5GjDk0=; b=CRW7t5qqzeL97lIlOdi8Xg65Ok
	PlqovFzWuIhtNs9zB3OwXAlo1pwt7rWyx5VutiHWfv1m7AOg95plES/7xyAs6evcdL7leSTSbl0eU
	Trqyd5VY7Gn/hI7wJa5rSL8hbUMrCHXBEU+eY0ui0059WpcucwAgi76V+CmI6Cm+Qy5c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmaYe-0001TK-E9;
	Wed, 22 Jul 2026 17:16:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmaYc-0001T7-Td
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a0Csld6pmcIU1tUEbQAVJRlA5yDYrPl/5d8dsF76HWw=; b=hIjWelxE3nr9b/xfltwq25qnQr
 cCyWMdck8GnBrDQ7imj16KFIIYZSdcMVXuk651/2dKSBJAnruiRqt0FCVNiCUrzrUom6itq5u0AYs
 382M3Xqi6g7sWGqzetq6Ej2THzn/BvCk8WtGaWQPmss/a6zm0Tr7ysEaUxSTG4PSIQt0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a0Csld6pmcIU1tUEbQAVJRlA5yDYrPl/5d8dsF76HWw=; b=e
 otbdQWXXzrzeYgWWoTJ9Lu4MkRV9C1yxwARjah3MPvbJvwzktCk959+mznRruGWPRxpf7nxmV6X9/
 CBNUb/2q3cNwLRWGsgRbkzmwqtoN37NoMZE2X00RVsWUuOu94W71Cn92ibEFEaiLhWe7Lx+m0rIJQ
 LDeHyKPUQ4D7/GV0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmaYc-0004q5-A1 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:16:35 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso32042445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784740583; x=1785345383; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a0Csld6pmcIU1tUEbQAVJRlA5yDYrPl/5d8dsF76HWw=;
 b=IuPZ/06TA+b4mkekRI08xVd2sN5vz7uknpSAq5mgfUGnIuMroW8LBRIDsk41IYgcPc
 ZeepH1cMSYwEWD9Du8ISAZoX3swEbzVMFv5TrfwW0Sm4xv0rVAS27taA/9tNZGIrLf3C
 ly2SA8nWsuelHTeRS53/WoHLd5f7esvX0ALrwi88Rpt47Wbr1i24bhDpOixjauSv2xNm
 LjJJRLxCvpMsyo8McLAQHpL2kZlTvCWlnMou7u/TNG90ILOdO1MkqQ6oLYXJXKuz13WL
 r2+Td35C6Bgsz+AMbUEYilYV/VywluE4T+3x6+lFf4goEs6I2A5d/Nspf/7/G3lGMMkA
 S9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784740583; x=1785345383;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a0Csld6pmcIU1tUEbQAVJRlA5yDYrPl/5d8dsF76HWw=;
 b=i7loXI2qd8YS36WaWNORzICaSWt1DydIAvvABZ6imCNs4hXee4qUmMheiULla7bq6f
 kYi1v2CpA7z0z97v46PNws2IAPkR71VVu871q/BK0rk2dn6dzPevDcT7fgxy3yyesbMd
 q/wSgWbKjlMMLYGUln4MCAzM0bCQ+YvUKQ2cvLCoF8IJzoNQJlnUpo42hO8wenDUfzZB
 f+n+zE6yZlsr/1URtjU7RXWODGN8ocANuPnLVlj/IJuTIMBOcuwm7o5+XwNQfKtPsLKs
 6PU2TYkxI0WC8/bzlufaz+U9ldRIAuN/+jLNJDY3uQ7Q9DIty7lYnZ4+V+BcE0Td80sv
 t4rA==
X-Gm-Message-State: AOJu0YyihTierX+NY3CeSqMlZDt3Ebl5vMHaGm8qBQ0OtJjAglYpofmK
 FFkaSN9s/k+wgHV8V1PbeGGfMgOBAGz9Y30pPll4gvzBtZv1BAVJeNsHVaLqQm4b2b5myOgEF0D
 wPRvZw7MSufLxbwtvDjtGrCxiPOLnp9VSWN5/PQ+m+wqx0JghnSVra6Unr3fi0QTk/Frhim9QTE
 jDY9ht6g==
X-Gm-Gg: AR+sD118QHYWPCsQfnFT4VV7jxlMYaVBnD9igzrM5dSunzgd2/FAOtRAcjzKoGP91OM
 IipRTg7zgQmbLw3MhU9/i5HZjMoEfOvV6KfVyFbToOHXZCRLGv3hcrFSpV18kHkCviGo4gpVkP7
 XODttVfwj0ER9hn0k22dfMCYKPKR8LxOkBM8/bpZ0YRLqaa8a4widdGrkfZaRM6yynJPfUxC3rZ
 YFDJ+Z1c3FLKgj0vjuzMVpBn4E6naGvwiuw7/2RSdHPq6PvInv3I7VhuZlA9epiNP1H4erXalG5
 Qh7IqGU7VoJefd5bdgoe1q+F0zDHOJneWGjh+hN2f0ytUf6u2XfH/ArAu7G+7z7jEwAT/SlsnEg
 MppqCHrWF/KK7y3Va3bAO2lleJACTcxWuBkoabaQC08nUWSqRxOOvmSv+L0jIcHm26jyToNZgs+
 LoaUIy+MjMwSLUnZskBf/bZ3Hg30ZzahK6TkmMRjhrp3HxYa3IqhfQy+OSiHlbS5S9rAav5rh4B
 YwgMHasSBI+Ms5wB3MUr1RAgbVma6rDrT7C3lpTHek12ezhIS4UPfwpaRNyw+1dRy7B
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4954a3ee98emr288418765e9.3.1784740582497; 
 Wed, 22 Jul 2026 10:16:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm174297445e9.11.2026.07.22.10.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:16:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 17:16:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 1ecf48732b06b461ef608e4f3509d49b8bdc6317
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 17:16:20 +0000
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2f8ad5a277a404553952c66ee97b976b00706e8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmaYc-0004q5-A1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2614263585077610983=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2614263585077610983==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="szBtbmN8Li0="; charset=UTF-8

--szBtbmN8Li0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1800?usp=3Demail )

Change subject: Allow extracing other integers from =
peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(2 comments)

File src/openvpn/ssl=
_util=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/31f4551d=
_4a808ee6?usp=3Demail :
PS3, Line 97:         if (r =3D=3D 1 && proto > 0)
=
> this looks like a highly complicated way to do  [=E2=80=A6]
Done


http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/96cf7976_194c65b5?usp=3Dem=
ail :
PS3, Line 116:     }
> why not use `peer_info_extract_uint()` with `M=
AX_PEER_ID` as "default if unset" value?  done, reduce [=E2=80=A6]
because =
it needs %x instead of %d to parse=2E I added peer_info_extract_int to stil=
l be able to unify the code paths=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1800?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
Gerrit-Change-N=
umber: 1800
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 22 Jul 2026 17:16:20 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2=
 <gert@greenie=2Emuc=2Ede>

--szBtbmN8Li0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><p>2 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/ssl_util=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/co=
mment/31f4551d_4a808ee6?usp=3Demail">Patch Set #3, Line 97:</a> <code style=
=3D"font-family:monospace,monospace">        if (r =3D=3D 1 &amp;&amp; prot=
o &gt; 0)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">this looks like a highly complicated way to=
 do  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/96cf7976_194c65b5?usp=3Demail">Pa=
tch Set #3, Line 116:</a> <code style=3D"font-family:monospace,monospace"> =
   }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">why not use `peer_info_extract_uint()` with `MAX=
_PEER_ID` as &quot;default if unset&quot; value?  done, reduce [=E2=80=A6]<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">because it needs %x instead of %d to parse=2E I added peer=
_info_extract_int to still be able to unify the code paths=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1800?usp=3Demail">change 1800</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1800 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 17:16:20 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html=
>
--szBtbmN8Li0=--


--===============2614263585077610983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2614263585077610983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2614263585077610983==--

