Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E59C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xMb7XeYpWZ2UrIeQjSDUJJhirTbT3oO8Ue+sIuFpb0=; b=YMuleUSwPfSwmxG28dDJJ/1jtb
	Xzi2ZLB4Dgg4bEDF1NPmPWWtjiUziVQ91ui3CjPsvGoPxJ30MlXfYuHHZJGFLraWA1Ov2E4toCo5U
	uJfcLg2jmEqXoR4ZCRv1Q3lHlxGKxuvzTpXPJix3gGptTRcYTI+dALzsFBsjLOmm1/RY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1jor-0001ew-Ij;
	Wed, 02 Sep 2026 12:11:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1joU-0001dI-UU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KFVc2R81F1emYBUHkkHxtvnvfPH/8DMa5tUSCEyVQPQ=; b=RXi9mYzn+vu/UEFFOaseBGW1Un
 WSCt/9YuiYkQIVZ/X4FTNXerdm5P7zR5cRLA5z/5rCB9nQfVpVy4RzxpgA8zZs50m7fOnOZ7d2KKe
 TNEQpGav30yre5Zn5ycP8WZRlXqrmpdawSlsR9dzDK+C2Zogha9ehDBqwXpDQtz3ljMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KFVc2R81F1emYBUHkkHxtvnvfPH/8DMa5tUSCEyVQPQ=; b=b
 8LM21Pc4rd+Sf9zKhHWoGlQGDrDknc8dteo+xhzvX0BpRnGPMxAUtbwOHy3d9Y3PpojqA4H7yLG2O
 g1pCq5LLQhFqHpB2nnAqv7cdZfM5Y7xoVaPEvLXXwKFJs/2nTHdY476i6RJRcKVrfgJd/wrgaLHPO
 Q5IOXjFo5yMV25a0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1joL-0000Pv-J2 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:11:27 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so706087f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788351079; x=1788955879; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KFVc2R81F1emYBUHkkHxtvnvfPH/8DMa5tUSCEyVQPQ=;
 b=XRVGUyTLxHEHF75tqTpeO5ZjW23rH3Nzy3czULoapQZeRulL7frMhiSNW1MmvQe25D
 x9lD0oE+YUXI9Glh07xSBOzGFcvPZ5R5fmIB1mAlAqcmsw0DDKY9Oe4dlWYAmG4qkJBt
 Pi5r5eb47/wiGVpN8GYW2Yn40K/Gv3WL/qqcRMrc2z/G/d9GV5tNDk5sU9Q4cIKgXzEo
 ncffttYWAAemuzk1u5JSQzOqX7el3qHw7T9ZfDOtrScmSAsCh2H1iToavB+A87Jywypa
 sVt7BWWjr56rAHRo5lMHqEBUjw+QbTiQWsRJjF2yQtu+OaFveX0sUsuINvGhGXbF2e+Y
 NGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788351079; x=1788955879;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KFVc2R81F1emYBUHkkHxtvnvfPH/8DMa5tUSCEyVQPQ=;
 b=lD/0jvg/7koRsEpo62wbvcwELf1c7rfpCum53lkzDyPFQvpu8jpRJO0gte8UuO6KMO
 dumTeDatiOiQGVHndF7jQb2NBNrt4Hcl77Wp8lcSkfF0tWPzlyeTUUH291wBOdwsngHR
 yO9KNiPhhICqpoClPZW+Kqa1i9mD3afFuPHpSbj11CtiktQPbYUPlT1Fh3Uz1icVOQS0
 scSGDHKBkRiZWCT7FL+2SbyvDc6Tl14lGhQqDlhzOJELGuPCezHTsLZNaYcR1ZSfAB1N
 PwjNhP1sMuLldW+R8xEhve305m35FTIYcWYwxlTe5G708oBots8WqTyIEzx6ajefwynU
 bihA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhDG7awyUtrX1Jf5WiJL3RqmFiyhZ9ap9vXd9brP6WtSxh5/aVmoLrjZ9ORRXxO17GlEOQloja7QyRYAH6@lists.sourceforge.net
X-Gm-Message-State: AFuF++l4smTTy+9qyC7twt/1r5/NQpEGreg8DQviHcCsggWLgr1w0J5o
 9ckSiw0UCw3EpOqEVrkzYLzv2TN0wZ10QZX7hEHi/dsZUdzEL3XT6ngMOIKfe1rORqRKUPnTgDb
 0w1E7rTjXsQfIA+FFTCvZIOlNO85+hNYrSaT7Wn8BXD5PmNTcg+TMzKuNbY8UyIesrbiq
X-Gm-Gg: AYBFou1hgIC0C4GF34lCaWRww3sRa+Bud8S1kEYI/ibAct9bussPL3c2ok5f1LperTN
 qtKWOaBnEoVgYMYTdRTFPyHaapskJsF+Bt97Ai+UUtv6bU2T5gH/4z70EWqDqPWsI9il5/35V5k
 kVpLNW4tRTSsgoRE6s9S0AjgfLMVlCOntak0/zZ3q0ZPJ9co1eXIjLULFdTzArWaezcrCNLN6Mr
 DmteAy0sKAX+7rET5eHgfuZFj0LOWdzH8DoYSap3G7pCGCUzMUiFqPm5BYFxSqG2uEVK1bSTEpT
 Gqj4rYm4P8Bfmb5jInFkfoBvuNkRzQBD0zMro4ZgI2XEPr/a1Z9IOKFBmGsXxe5ZFtUu2nhE5FQ
 VGKWmCcvBYgkgfo9So8wZfiCCaCuD5+fRPCQ0pUj1Q6qroKSeC2HiHj0F6bhj8WlwnHTd9rYW64
 M+qG9J3FWb6XOhI4HPuUQVZjNe6jviZdW94nLE2uxD0g04xc8mMwKoCLHp6risXEoFidGt99bgN
 eZsNGsU6vdJxMTm54Nzc0WMwIKFgOsdm0gVbkdhEeMl98UPgU1y5HucA8AZL4JNhFQjIYnXqO96
 SibrMlBo7aKJKIOKuTERvdy0ugdq5v9ZNaPq0pdwN/lDVCLEDdvFWk8WtHYoXg==
X-Received: by 2002:a05:6000:18a9:b0:482:f724:f4ba with SMTP id
 ffacd0b85a97d-484913c37dcmr7718933f8f.19.1788351078809; 
 Wed, 02 Sep 2026 05:11:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7315bsm6198428f8f.7.2026.09.02.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:11:18 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 12:11:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
X-Gerrit-Change-Number: 1891
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1891?usp=email>
X-Gerrit-Commit: 8de20c8c1408935ebb47b395edb637de4e6818e9
X-Gerrit-Comment-Date: Wed, 2 Sep 2026 12:11:16 +0000
In-Reply-To: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
References: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkk2ODQyOWRlYjM5YzBiYWUzMzVkNDZhNDE3MDk3M2ExNGM2NDRjY2Y5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2b8efcc06f412c0377b5258ef2b34e9d40d4fb1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1joL-0000Pv-J2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: quote
 arguments that cmd.exe would reinterpret
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4532436016555324735=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4532436016555324735==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RlM9Dcp9xAM="; charset=UTF-8

--RlM9Dcp9xAM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

d12fk has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1891?usp=3Demail )

Change subject: win32: quote arguments that cmd=
=2Eexe would reinterpret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
Gerrit-Chan=
ge-Number: 1891
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Da=
te: Wed, 02 Sep 2026 12:11:16 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--RlM9Dcp9xAM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail">change 1891</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I68429deb=
39c0bae335d46a4170973a14c644ccf9 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1891 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk =
&lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 02 Sep 2026 12:11:16 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--RlM9Dcp9xAM=--


--===============4532436016555324735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4532436016555324735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4532436016555324735==--

