Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290BC5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfb+KxCmYsKP9FI2ps++BG7TXFqLgN73mVKDsFRIbu0=; b=MfAWS+bczAJ6uEpLZSooDWC7FY
	D7cp5RXFf4BlqSjEGlQwvIvC6bUATzrdjgxWf9EkwOIUeWoigqrFXI9jU0g2JzpgHYRXlugKXu6U2
	stqD4fvVJFrCwQNjOQONjo56b1Tyc9NxxSIcdc8xxBZda1vws7SJl4SZoUYjaSFxxtJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupOK-0003i5-VV;
	Fri, 14 Aug 2026 10:44:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupOJ-0003hx-1p
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eYUOoaFy5VT7ZEqtRmqjCUkX5ClOZcAICeeVYkUUrh0=; b=AIm6Zt5vk90tTEvByciP/xd9k6
 Fj5QaBrkKcecQqXw9/CzL9UNPYQ/qOyK7IQxVRpXziQoN3tCboN9zu1SOB9c2s3J9jParKQN/MOcC
 OFuaSJN/MvDPAKV4PCfpz/8zkvAOP0Q285qg+r6ckEkOqZ9Dj6J8+ilT0Osl/CqPDojU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eYUOoaFy5VT7ZEqtRmqjCUkX5ClOZcAICeeVYkUUrh0=; b=Y
 hWW3RC3RDCsd2i3qwcTw0hoR4NK7lEAIBcmyglWIMaqMQPzRFqYegeIDPpaG1RVF9UCTUNLJKrIQI
 m/Wv40EkmTgDC01FrVyD1akwWBfa/zz4oEsZUbtlzgHy4Hri7dTTsGljWIb5cbegAF5W7SpcY4rA9
 psC8Oj32mbyetkes=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupOI-00022i-9S for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:43:59 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49987fb18c0so3194135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786704232; x=1787309032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eYUOoaFy5VT7ZEqtRmqjCUkX5ClOZcAICeeVYkUUrh0=;
 b=dJqBsbdOwJbgFp8vUk9atBFybwBULX1MZ0U33vD4gKDEJgI0tascniG0OvVJ+IJis7
 ZXbldJM+4JLPWTDNq2ED3yOgPv9yCNf1QHKNLZ6PYCAg+S/S0ynrVhMTVk37PS9cwRuV
 CqLmdHtQcc46Q0KAA+FqsjZFgh6qJIUN7rJkSOHyMp4e/B7ZBaGUVUir3MFIj7PPLjV9
 zXvS/RUBy0CC+0eWhrVjKBq4H1VIcqSeoIoJpcsDkVvZE9nAUkivmDKArph/lUahYMev
 xDwxeZrARrtLRlEzvvPD7uQC0ACjRaWPAb/LGOW/Vwt7G5oxqEuVx2kddP4LvNT/ew/U
 FX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786704232; x=1787309032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eYUOoaFy5VT7ZEqtRmqjCUkX5ClOZcAICeeVYkUUrh0=;
 b=O6wHtkZgIA7033Bwuq3e0yVtnrSqzsp5EAlwd6chPsrCvjou2mGP0BhNwUisNDnD24
 iY9igv3tPptLovbFTiv7Tb5T2eLtF8PlY80o3HXr+5t5hevB8soKNbuKQi6RFCEykthC
 gbq5s6yMVgLdv8aZC4+qqfmqpOFrQvq9qD5ysmFjkwQ6w/jSMF8nHNOj58sYPkJxp6uH
 GYJDcAb0Z0bMUtiM3xPbXNrL3i/6muymW0BmLwBGgbL+TAQv26FGqCD0TyAvdDrLASrH
 xUto6e8l3WcOJdefqdjuXdPhespcF53XuvfIwKjZf76jU+2sBc5FgoKPvE7qbs8KolP1
 YrWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNnvh8XNaNRWgpGsTYbpMrMLIkEGjhQzzwMRW6EfbqAafRLnQW78i+cK4qBxaKsWC23GHOhLLhLEhjDgNE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy9U+0GrfV3MHRblLUnV+RxUDVvnRF0UIw820mQreoQBBFLsXnb
 +Xi1eUhfoRKXP5D0D0GasGxfWyCBQ4GL1eL8Sfzqm5m34MbQMX7qNU0Uhd7bcOsLVxq5KxYl7Yv
 TdXW4fA9rs2yAhnPkV0J8PGOMqKlOAT21sLTjUb5+jZrsgvRPW5OI+swTrnMpS0DQ4F2DLYcxco
 OhiTcWuw==
X-Gm-Gg: AR+sD11Vmk6rzpTt3ZJqw1/SS82E8hjCFr82Oif1BBFeO0IRvuy0GPYeSLpusZ+F30a
 /h5GWL/+MtVMTj3ob73sAHUPofG2mPhzDhiEn3NbbvPCCzB6Ftc7JFRkg5CsOTzZa4u9IvJBHjV
 z5jnVR0hMWaMfplddbXAG4tFM0wUnRrwPhK4xa9RIQIPjtKA1ZI1LgSIgKQYx/vGuQQAz5Ny8Gc
 QkomX5IFdka6V/9PkpoWhwL4CAF0SiwAYiP6rPmQ8eFAl0IoGlPhg6xxsTquoqLvocW1ee5jREO
 WPk13RVARIczuee8V1+NzN4vWJZblPodZHEZn662rVbGpPhZ7bBGXdlCmFdK46J43S1jbwM+06W
 +jFgnjKRoqVOXg8niYugp7NgVwOh0OfYlCzt6+nqkBXBPekjeUApZsS7EyKMvCyyGHyaVgrIZ7J
 3G9L2fsHqe1ROEPNKXosNQ0FH59/5BsBM0ln+w2ZA3iQiBjquuy0ZORk3hiSntA2DTJKJTrZWHn
 1iV2L1/0I82mNvM+5lhVt/yhe6nb5vX7DxSwNfhQhXKj1n3rPxgQM/FnVgi0BKnkoHb9J3XHKZJ
 btyy7wr5SZJf61RWx/TcxSKRkwmx2J9jV2rN9DP45CJoKihxEyw18x1G/IKw7Q==
X-Received: by 2002:a05:600c:37cd:b0:499:8596:3ba9 with SMTP id
 5b1f17b1804b1-499879c279cmr72522875e9.18.1786704231627; 
 Fri, 14 Aug 2026 03:43:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm39788765e9.1.2026.08.14.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:43:51 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:43:47 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: a1d68d185aa9baeb1ce250df029c103074f336a3
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:43:47 +0000
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93c5ceb46ad3576e55613aeef49c5902ccfa513e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupOI-00022i-9S
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6691757953041328947=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6691757953041328947==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7A7qhS/u84Q="; charset=UTF-8

--7A7qhS/u84Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail )

Change subject: Remove ins=
tances of constVariable/constVariablePointer cppcheck warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 11: Code-Revie=
w+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c=
26a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 11
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-D=
ate: Fri, 14 Aug 2026 10:43:47 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--7A7qhS/u84Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">cha=
nge 1661</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1661 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Fri, 14 Aug 2026 10:43:47 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--7A7qhS/u84Q=--


--===============6691757953041328947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6691757953041328947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6691757953041328947==--

