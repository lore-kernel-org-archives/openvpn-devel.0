Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF4DC56205
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lHgbN/Jt7iLEZhvx59pRgTiUKQGWuoGZs2ZJewNw9o=; b=WS81yrVw7GsNJEBjotqBFVOMMv
	Ql7dtXypeFTg7PHyjfExkiU6ogi5wwsnlHuv8BVo+78e113mW+PCiE58P+0+kz6gANWwUm0hCJzdz
	hBk/3UESTm92k9CRHfWQy4SAskkJ4H2eartcKPw47MJGU1X/uogWngAxWLjTG+Nhbjq0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws00Q-0003H8-KO;
	Thu, 06 Aug 2026 15:27:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ws00P-0003Gz-Su
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=08EI+bpVczvKYKGSeT9ICcxBhVV32Y2AW4joBARy2jQ=; b=VGu/3VMUx7vPrePETPRZIKtjBv
 SyPkdff8KZbMGZHz9Us71m+ez3Z/kd8htkVPrUFTOk5FAayHYiYNv/KNuiVOLdeWenjpKgcxgYkz9
 dKwhA9So3dYOb0fLCpMsP+Ebp5ATHCc7pVbc+raLlURGOkPiOgYxzsiLpq7spAkrBbNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=08EI+bpVczvKYKGSeT9ICcxBhVV32Y2AW4joBARy2jQ=; b=K
 fLp/gNDUcPdhxqUbR1TnGu298wCzTUSfHEUwOg7AIa39O9yS1aTtv4dPusHrNrmdx4WJT84lb3sHT
 mm3kC7XZXdK9pSfbdjCoAiJH4iPx3xVAnbA38w3I2TbnoKeehRqV3UtkYJ9O7aCnbI9tEFhRVLBml
 dmdBPwBnbsmFB3W8=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ws00O-0007Wu-Tk for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:27:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so19584795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786030050; x=1786634850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=08EI+bpVczvKYKGSeT9ICcxBhVV32Y2AW4joBARy2jQ=;
 b=PWsgF7Aa2q/vDB9VzFw7EqW03s6pqjRDVe9V4zSbdUGYtIsnGFyZGZiqoY6Mb2bsrW
 uUuofAmMhDMFbaFaM+1qj5cR9YdvbUayFLU6EQrAVbdwhFf8Z/7Lo1PawmWytrFTHsG+
 5W1QzoP+xWxCXcByYlhoMUFMts3FOKq1SqOdexPwbQ2kvMwfDjC9+kwIoZ+aRg9ATZmC
 egqyHxGh0I56de5hWnn2wNhYtTc0f52c7qlBVH1951hwh9L9ni2CgzHnF+zjMYTUpnk6
 WzVDzegfdUyv5LYk79i0Iq0rWWjlXC2/t5NlNx71mYAeFEbhVLctQlT6THIUVhkHNwRP
 Wv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786030050; x=1786634850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=08EI+bpVczvKYKGSeT9ICcxBhVV32Y2AW4joBARy2jQ=;
 b=HcMxMwtG1z+vwTubZ6zX+LFLxqqrU9ynjkVO4EeFLptAf1dHI/6HX0IrLDzonBCSy1
 mnJtdfHrPRbnoeSX64vwPhQb86ia5sIuw40tm9aGYmYn6vTAGaXTmlKYDPj5dlqRKwvB
 N8qX/ItfW6sSafcxJz0Uirg70LLsv3bjEZb4yrs7tRJxU6rcXUU1lvbQzFjx35PaR5bO
 ArlqgzpQTbZkJtyNh01ubJj81uU+dQ47wbvE0KiHqe58+4G4nxyn4llpd5cc8U1tbEhv
 bGI2lvOIPSf9GMg1y5f7FYrcNBgVOEC5uNBqxtM/qG3rrQsSULhiOUwqqvXgoiYAAFaM
 EFfQ==
X-Gm-Message-State: AOJu0YytAap487C9p6mrsfYdnN5kN3PHwZB5SMieBcfzMNCNdMkf0VnC
 IKLuaR35IXvaosFEK3xUEXsNO+hQxXbNCmc5V568tbcHHiz4sPYqi2iqlieRr/da2g7pMrpB0i2
 xw53+MftttuXG4njJQnLxG+ENbFqAo8jzV9+CDl6xQnKmAqmY6jfy+mbgI5EbxIzL/ZJW
X-Gm-Gg: AR+sD12HzoeOJZtvvTcCcYvP14pCVPlo+C5f1iXx+z4049hvpYwTDgcu40ZDDBggpBZ
 /3UDu2Xg/bUTkJjX1/IXs5RUeO3VX9lsKBX57926fHflTolCOtcQWLQ1L1JK/NkiiVZqynxFmhZ
 5NaUeIboH4P+P/Bkzf2Bu+OJTX1Ph76tPgq/9VBi6YupoAXl2IfdiOV4uBm/P7dOdlLrYDjsA6u
 Vd4f32sub4GufReOkdGs0WplRiYnZgVdRFmrGNepMEUsQq/lyXeI04m5HNj53OFwTtBXUXhaaQe
 9wq14+ss8eL6ZAKvu+j+dAuTEe9vsGo/XeRRv7e0U9TO94TFtOub4hnHK+CNcJKN4iYbdPWNuqm
 KFW5hFOss7cSdP9EoYYY3aAgbc+Nsys4OKmk+ppnTvYr2gmIVGUxa2smrfY5g8LtsUdmTvdCAze
 T7+vv3pGtQgkTJVK0vCZq0MzJz73eSf628EEQMZQOij4QXbAK+3N2Seucymzv0YXhV7F/pQyDcZ
 qV89PQ+zlAzUfOcnV43OQiVKnCZu4ZpoTJnsyolBs116g8pE+aKNJ3bQfzQPOrx2FUBoQc11dka
 W3A9PTYob6UqqA3ntbZYlNhkB4g7/kZZe0IeD1/2FqPWCjj1ChmSI2Ri0bnd+w==
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id
 5b1f17b1804b1-4994e7d21fdmr190194805e9.16.1786030049929; 
 Thu, 06 Aug 2026 08:27:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18086sm7551692f8f.22.2026.08.06.08.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:27:29 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 15:27:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: b65e19e081d86b0929dc82dc48b0e71816167f73
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 15:27:27 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4375e78f356d71de42add2bd49940a0d828fe78c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ws00O-0007Wu-Tk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6086619344120199997=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6086619344120199997==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2Pjz5MFnPVY="; charset=UTF-8

--2Pjz5MFnPVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 5: Code-Review-1

(1 comment)

File tests/unit_tes=
ts/openvpn/test_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/co=
mment/e84c4be3_665c03b1?usp=3Demail :
PS5, Line 522:     rand_bytes(key, si=
zeof(key));
You missed one=2E As apparently did I in my last review since I=
 flagged two and you fixed two=2E But there were three



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6f=
c3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Thu, 06 Aug 2026 15:27:27 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--2Pjz5MFnPVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1827/comment/e84c4be3_665c03b1?usp=3Demail">Patch Set #5, Line 5=
22:</a> <code style=3D"font-family:monospace,monospace">    rand_bytes(key,=
 sizeof(key));</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">You missed one=2E As apparently did I in my last =
review since I flagged two and you fixed two=2E But there were three</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6=
fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Aug 2026 15:=
27:27 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--2Pjz5MFnPVY=--


--===============6086619344120199997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6086619344120199997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6086619344120199997==--

