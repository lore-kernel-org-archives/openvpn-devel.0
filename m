Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B7C624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q86mUHQ/KuJVOIfe2IUr3EwZhCba66Ec7ofnns2Bg38=; b=enxMKYr6Oh6NUCW3pTRGV2o9CX
	siqc6/M+SKI0VVdjJO3yL7VGqaGygYLikIbEPCAiSGHQBdkxRoQn6s5ewBVw0CircoFyq1oBILz1L
	V9p6VNOkJxQMC9eBSkkMXEqXCpTl4W7BPAIizue4TvdvfE7bLFQOTYXnfV9nHOwZj6gA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2TNd-0003MX-43;
	Fri, 04 Sep 2026 12:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2TNR-0003MK-7H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 12:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zcLEc+UESZN+WOqv991p+p7IdKiMD3RuHnZB8twfGqc=; b=Q1S5zbPrr4ou68mhApU5KLWs3u
 0Jcwva8bP/HszlW3w4P9BbrG72v3nw4bDZkR7QSF6LVy40k40A3qKBgTFRZgiAa2PpZ2HfRCUlhJa
 gDmUjTmH41ZyUDA/VF+xfHg0OHWKoy4y17YDWg/uixhxfmlqXpgTYHaLBH4vNYn9Ybl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zcLEc+UESZN+WOqv991p+p7IdKiMD3RuHnZB8twfGqc=; b=h
 ErVCW+1XZVaaYUjU/ZIn/EK25M24bePOIrLRp4LqfpeZIndRYV6yOa+03526L+7JKXxMd1bd1uYP7
 q+fPJSiz9nhwlNvH017FexKxRMffEC9Yjxqht3rP/PAAA+QSrN4V0ww1QYGO1sgz6qZcUT4vtlDv9
 /BM7np+aq1Y1jSjY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2TNQ-0005y6-4l for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 12:50:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so10672805e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788526233; x=1789131033; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zcLEc+UESZN+WOqv991p+p7IdKiMD3RuHnZB8twfGqc=;
 b=OKjgB3+/U4sObJ2iz+zKjt3Cb3BeHbSwbamqmNOSqU5P3XXV4K74a2VuVled/C3hDa
 9GyDG8bH8iSf4y5XV5SWYWmeL9o9CSTSWVkgoisIwEaOUWoPvFJlRzRA75ZMByZICt4X
 7cXN3Qp+mg5kgwT/op9OqNB8LtUDfo6eJtjJ2NHdtxAK0SZJ54tgqKvvwIB9xb2entgE
 tIMA4tnhWq49gUWiDh7cyHyR0DSFyLrmNgduQjIQpXC47c38AkAqfI5v92/S/IcBB6ga
 QAX5snk2g24ywRwOSWPeMnTJYIrxC29AUWxoRhG95ljXhrYX9L5KyApAIe5SniyNndpI
 tRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526233; x=1789131033;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zcLEc+UESZN+WOqv991p+p7IdKiMD3RuHnZB8twfGqc=;
 b=GfVX3UCq5ySpD0g7yjxa9PPysXz6VyPkNYBhJ8ZjK/CCOgopEesZNTGMmNT36pYBwj
 VDrfCGJDRP5uBRgFYjlLIxBh0oihpAUWBU5YjtGIpoCSDOpgvBOjLWy/l1JSMd6LX4F9
 9nCCg8H5ocTQfH4ZtDFdE2sb+jm5jCHoO859YYePgdidHkmOv9LcltiUTEutYxLhlEg4
 iS7YRlPLHxvWp/tdGj4JnubdX+9zci4AfyIeMWFO5BIkM1BFtpfRM/HlBTUBc+Q3IOuv
 f84N722tedKm8J2WBNmVFgaBVka634qU1okgL4XWZS1t4/xMoDl9sXxe9zFVVVuMQnY6
 It8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByqjStQrBhjn/zVQVmRQlD6kYGvvCpDXTu7ZWdKsN/ga6z7+bAj+ZMU72UEHb+dCBxapq2MBqAjyyErwb+s@lists.sourceforge.net
X-Gm-Message-State: AFuF++n58lae8tD1DnKlTpWGRQIwK+IHoLKxi1w8PWdlsjC55YzAfO2r
 BKK4xkuoH1sP8zrpEG7NWtIEytimYJboxwKuOT1Io7cIoYTFacN0qBVcS2YVBL91Bz9lXafv/f+
 +Lb+huWFy3/HcvWXaOlG3rGJ8dk91bJXgac6ME8lbrQ/SBRbWywC6a+shB5fIpGX0Dze6dpSZRN
 WLuwTdaQ==
X-Gm-Gg: AYBFou1BYTXK6Ku4z+HYz08cN3KqtPGnTE+KOdynV8oh7EskWtW4e9ZK/mdE/c4DkTy
 lds/2vLjyvnGOKA6fQbZWap3ppENcmFZOx7ZQh0zcUu1//nrEzkX80xUICzOqqwITQTXIp1fKco
 edIMBHODeSvtxnFUsS7tf2q2XfFFtQSBjSa3PBgkRkc2XEWXKzk+5ufqFVYaTxShuglWIgQNnke
 00EO4ClpPbn9xzEW3Zpl/Hx5og5EvdDvL9+xRl6ip3zkxDmbY7r6o5mvjGY6wMhCidMnSOWeSUA
 CdhzewTStAmvYQnA1wxFPiG2SA0bgnwnZpFgQc2UrYcpg80hMsmnBVKLPXZAFyoNVgwccHezw/7
 4cv45v76WIREl0m/Kawu6mPBcotM/sVHCAd/++aQXlhhEnyvvG+0u48766nYQC5IzFRwSsBXfN5
 mL49n+8wXnKon0VGuAvqkn/+ZsWbxuQHhdpjyoQ6GMw+DeWzjCZ2CVWrphKmtpz9Vxkic20dMkT
 UadchpgmK2YsYJSPn5KM2fvFcypc2+SGVSLy6GPI9HKFfqhiKP5fYXI5jTWeiGLScRUnXFNoYPY
 1BdH3LW5To+dFLnlfPjT04a2NWksEFejg/Xk/i54k9hHeC/QxXg=
X-Received: by 2002:a05:600c:4e90:b0:49c:f3dd:e166 with SMTP id
 5b1f17b1804b1-49cf826ca60mr52850575e9.13.1788526233406; 
 Fri, 04 Sep 2026 05:50:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm196901965e9.1.2026.09.04.05.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:50:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 12:50:31 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: 975dc2e0f0e17a301c8728f6c135be339f7a9196
X-Gerrit-Comment-Date: Fri, 4 Sep 2026 12:50:31 +0000
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0cb61aaa2f4c94352b699358fb00de71fa09f3c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2TNQ-0005y6-4l
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: add unit
 tests for ACK and backoff DoS hardening
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4945393030091346752=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4945393030091346752==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U2CprVQnuTo="; charset=UTF-8

--U2CprVQnuTo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, stipa=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1894?usp=3Demail )

Change subject: reliable: add unit tests=
 for ACK and backoff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
Ge=
rrit-Change-Number: 1894
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Comment-Date: Fri, 04 Sep 2026 12:50:31 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--U2CprVQnuTo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, stipa=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">change 1894=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6a=
d247614fb204a279b73e98f8c4704e16da2a </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1894 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri=
, 04 Sep 2026 12:50:31 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--U2CprVQnuTo=--


--===============4945393030091346752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4945393030091346752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4945393030091346752==--

