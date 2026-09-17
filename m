Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09731C982D8
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8+vIlAQc2CYdiztYyeSWb+k+drOCFNL4AfTL7gXPDY=; b=BO3Tf4KrcABdu/elmCzXBJU0Uc
	7+Z/YXkNjPOVcTYBlbFfILBo+KFlCx4zXUsoKbGUm6vwjcwWjHP9HlAdPSA6sbXD2TsPyislPSPfQ
	wDpqWnqO+jaSE4Xt9XHvZt1odzd7WnYRbDny+v4rxlWC8zD17wCGI8kjMWDdInNmGj2g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7CuM-0000HN-5c;
	Thu, 17 Sep 2026 14:16:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7CuE-0000HA-3Z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T7vcDKpyCekXIkHcmdvhGhp4QwiXIBPHNaBR6qImzps=; b=LjASkAwskH9BWG4KyeF6p4H1DW
 ot++zaMoDavXwAIGPyIAGLVTLCzQ+O7k1gkxTJoX2S9Zl18HweocQFyVppouA4hxiCX51wHMfFTTS
 VCgElTBNWro+xK4yzQx/YcGW8oc0WJQ0033r87UoRFW7Au/s8Izc0TkieqNPWkZX+in0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T7vcDKpyCekXIkHcmdvhGhp4QwiXIBPHNaBR6qImzps=; b=Z
 yy1QAgw/Q402KjBp1xs+Sh20gLRHEFfOF8gAXKUyj3+oddDf0gBuuZjgi0r99D8AwtaQsrYBp2lsh
 VGc0LHkLhJPGbfIWDfX0bfr+FrvIHHU3pVgDBWolHT+ooeJpnzqbS2ZOmmQ9loZfEhThHBtR2X3O5
 RmMgp4LDn78QPiQ0=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7CuD-0000sq-Bm for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:16:06 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so554253f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789654559; x=1790259359; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T7vcDKpyCekXIkHcmdvhGhp4QwiXIBPHNaBR6qImzps=;
 b=adR9EA0fp79VgSe/zJc0Kp9OCHNyKoTUMvDlMRmZ5u7onlTHHsFknj6AnAe89iOp2e
 UFH1U+ytRpkMpbaZI/N9HPSEc6abmJ9GF3at19roj+g8SGyunpFV73Qx7+xRj3FpVfLU
 uuxAljSvCS+PZCn0y4lDbYI7EXQj74k11URn/8R3xhuHfLAo6F9Yzthn5A90U1/NnJT5
 qN+hQquPJxgIusZifejKbPCaWfutBHdCmFUSGeNdScOfMQEC6GuJVdjhJRR8vHgl04aP
 xy/4DzJJLS7Ly+hq+df2JvW5lITVNVZWIE0ZARS5KFEST6JxWXvo768QIQBzRR7YAb+m
 ntjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789654559; x=1790259359;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T7vcDKpyCekXIkHcmdvhGhp4QwiXIBPHNaBR6qImzps=;
 b=FeAEdwkGQgsGGIHJ9H1CtcMJRiMeV/QVWORoE31yEnX4zoMiFqLAKV0YXgqa0sevu3
 IuCU3I0pr8XZbqBOGuZRRx1j70pw21xyqkrQMCKP1zpoblOhWJG27SoaH9x/BK+CL+5H
 FTo+X9Imf5SADTIfOoUxSBllCuMCwI6YmYDn9vvN9OuYZmS0EGlcrYU1n1AWtngW42o1
 j/gFt2Tpv/2mUdcza4avt+8Sl2E6geOHhA6DP/9Kphybvw2a+7jdqhRVihDxWHvTrVnG
 09AVI+T8RTvjD/lY37WYcfcANc0AovEkkmR9TnW1bF7GQEayRMMuxwOy9KV1Od8n5rK9
 L7uA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjEd7tWmE2Jz+qW0bff6abgOWtvFXxwqfL/7CYc/O7SqGgLCPu8vxMsigv/wd1q1FEl/Z2Wa7tgS5PH12Y@lists.sourceforge.net
X-Gm-Message-State: AFuF++kWAXsaGW8IH0vnv0Z7WEqMohAtfwDR1nRyiNFc3oERxIbpFXws
 OlhMOI0XbpGdr1ezog9gSKe21TJTmU9eqSFjuT1JyZhgj/4tIyjvWglAUmmqNEwqRj/TTKVTgN3
 KdjqAOYLMULdr8G6fz/1dsVDkbQ/RFkkvx675hxFwdfDktFx6jy73qaPrEZNYYUso9Lp0YYozq/
 6gdpQglQ==
X-Gm-Gg: AYBFou2mBEGj+PMFJWSpyYIFEZ3E1+KVtyAkpBu6YulMiCM2D8gqpP0uv10j9R6JWYp
 QwCfdzFUStGQ5y1SDJgS+iAzHZWrQwZGwqCyn85Zme4OG2i1e07q+PKF7KoTmZ7wyxgt1zCe0EK
 MGwGSEUOcgYmTnZf/WVQkt0kPZeNjDvADseaxZSxwG0N1ogiqPRsdf+oDbHQEIHvbk8UimJt1jI
 NhVrjj8Mc2pIe5AdaoApYw4ag7hil1mFrh8GGmAY8I5ruuoD0iOA3q040y+WTVLUXP2cGVJnm1j
 O2Y4UJ8RBf/dRx3zoFGyYWMbza6hIq9PsTAr5SPv5uCz1LtVtakxA5PlAbaQkCUqbuC/D6xdgEU
 THJ7iGx9WL1x9ug/tQxORjumFMgaEFED8AT409hRNBRKDdBqALHQVSznq5fVtsINHNUBwuWgbw5
 jZoPrGdGFCw7Qi5qjTUfrnxesWmJXkYzQX2GfLdknueG2yvRSAtR3Pz1MKWUbWo1gjg9yHqlQpy
 oVaKPVFaBuv2Va1xF5kfYcg/nyo4/whqkFD8hTCRyKjR9NPgF8BExY6hzVwPCadMqc40vksDXSF
 aYZFuw219bDDKfCeVfXk8oed/ZHsqtyIoPxObeK/0lyCTvm+wkRi2YfJBL9EgPGess3IRkv9
X-Received: by 2002:a5d:5d0f:0:b0:487:648:ed8b with SMTP id
 ffacd0b85a97d-4870d04b8c6mr18330180f8f.23.1789654558528; 
 Thu, 17 Sep 2026 07:15:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm17859271f8f.23.2026.09.17.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:15:58 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 14:15:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: 50992348f44b4ee58ee0d9bbd7b21cdceed20a47
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 14:15:56 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <626c7d355c4ccde293c8c478655ced2d47651c7c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7CuD-0000sq-Bm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7760560325493847690=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7760560325493847690==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QPfnNGnINHw="; charset=UTF-8

--QPfnNGnINHw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/=
openvpn/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment=
/13775cb7_2cfb8fd9?usp=3Demail :
PS2, Line 7324:                 /* Android=
 always uses 0=2E0=2E0=2E0/0, so silently ignore the flag */
Do we want to =
ignore it silently, since this is a behavior change?



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
=
Gerrit-Change-Number: 890
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 14:1=
5:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--QPfnNGnINHw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/890/comment/13775cb7_2cfb8fd9?usp=3Demail">Patch Set #2,=
 Line 7324:</a> <code style=3D"font-family:monospace,monospace">           =
     /* Android always uses 0=2E0=2E0=2E0/0, so silently ignore the flag */=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Do we want to ignore it silently, since this is a behavior chan=
ge?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/890?usp=3Demail">change 890</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18=
813d103ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 20=
26 14:15:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body=
></html>
--QPfnNGnINHw=--


--===============7760560325493847690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7760560325493847690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7760560325493847690==--

