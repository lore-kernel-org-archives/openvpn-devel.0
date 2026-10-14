Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB93CC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VA+g2C5nmk6WxOzqVIA6JmhSPF05qU+rJc8sZNtel3Y=; b=aFoju0vjZDWazvJyn1KCzjfXqu
	t7V7hKwYjRtUAv9omJ66lmcSciJsNvPPjaChIifPkOO6uTGNzi+XQXT7le0DZIYoWoZh1+50v9C1X
	Ua598JHhMKXTDo9dlbpoEWNRsBKm7HemjIyO9XtCYjH3L+vfKcfolE4TtEZaWSFCLj+4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGymb-0000qx-KW;
	Wed, 14 Oct 2026 13:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGyma-0000qq-NQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BrfYnwoNPkFE9as5M2hb/zvwwEW+Ku78HCNJebDJTZA=; b=eOTEr6VHD+ner6+zlNuwKdljjJ
 UZLs+99xWqc/TagsNcb+7Z6CYHnAIwPE1feuL2owqoygMisfCrJ77Euk8zYiGqr6aqWn4z4cVn60e
 e3OPlkt097CDg9eJ8KHhm4pEL/Iz5DFfG2FAwdBqdDIQMPGLSdfiz/QnngQx+WqL3na8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BrfYnwoNPkFE9as5M2hb/zvwwEW+Ku78HCNJebDJTZA=; b=W
 Ke5ou5oO6KYZ9PRJdnuv4Qw2HZ2jC4jbhVQ+Mpul2uC4BydAJDR4ahHU1XUZ0lqEoSXmdwFrgCSTu
 QM8fIWiTnbITso/y/czUz6pwnRJsFeP8eNGWw7abgk+QqYSeu82mgRWgXhGsHBox+oCNXEzRudqDU
 bCzPpxqG2if2qrx0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGymW-0001qF-0h for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:12:36 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so32892435e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791983545; x=1792588345; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BrfYnwoNPkFE9as5M2hb/zvwwEW+Ku78HCNJebDJTZA=;
 b=eHGiJ8mFOXsoGG8PewJ6lmgMBpAbeDOqWOoSd7F96P6B9Z0xs/I1fbL/heAyL9Xl0d
 wksYrKeFJ/iavq6vuUOCf4KvOuUdAQp4mmMCcix17H44XIIPDegue+H80mirn96/NzN4
 lI1leciuXv7JwgtN0pSoBZ/kSUTzxv/SXAOuXZ+H4T/tubGHLI7yRQlvK+h+HJl6U/qs
 33jbrBGi6Xp3DpksQoJkILLOIJvXL7xCItUJyzduNTAcvPEz0oX3DyEq2E/1DF8hvSD0
 XyiRx82zlmyMOIhWtombdq1MqqZXlOH4fO0gvJhdk4fPRng1AIA6ScnuC7RQSVRypN1D
 lwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791983545; x=1792588345;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BrfYnwoNPkFE9as5M2hb/zvwwEW+Ku78HCNJebDJTZA=;
 b=vgSC7RfLmld8HileqNHdfzc73lXZD6HvFuFtTgdwHnnNKEBcmDxT54Qyyqb3AU/Lud
 YjXWMdtw3GThwM3uDDmjn9D0FWZUb0x6bYHoqM69v1gSdnTxC7dQ/+Qns5gLuqT7QUB5
 zxG5cFPLPx7tp2j7LjcSIXPTRWQu35r4g2T2Ij/hxQMr5hx4WTjJgBQFue4tEkHxjhhH
 fvbqz8kNWbwzabQmMx0S2MJJ88mFRUmHNVgBZQUuaQnvMUtwIcZ2oTJoCuY3txjh535S
 X+hexS22Wgv+TGGL3ufA7tXHp9+3cq/WLkC/CL0StS6VIldo/NDG+C/orP4fcdhcHXMb
 bpaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4LY5LLjuyNMqI65HLupRFk50tYG4N65yMFOfhxEgMjf65LhrZp9NhgPcziyor9lrk0jIxno2ySXLc8kJz@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVQvC9JVXXoRNXj27SD48Ll5lLu4aSdGUi8mrPDS0vd6qAQiJq
 5c4ageMUnd/Qd/+Bp8A2wlv2SSlck43Fm2hYTJRIVnurJvmvU5bNlaGaRqX7KZEgltrIBwiz8Lr
 SnCGPW3xxUD5Z0yp2gphnvjjatK6NvTAAnUMfUpW4WXpKwYNUmHvCwC9tHH8iy+3tKTCV0fzyhj
 vNW4WknQ==
X-Gm-Gg: AYBFou1HkM7BzpVh7rF53twi1WhDOantA9G05rull4alvnif3ZVvjRn3P90kz1s649I
 Ph9GedYc5Y/T1fyvnSPM8kp7MjM1YFQAGu9lRZPId9hLKPxCM+pB/WqH9yX7N1gUjOu1NaXqqI+
 lJPeiP5GE4IhxcblocnSczy52F9SOjad8pBmhK/IwC0c9Ekme6Tf9pWqbOj83uF8b9JdYF/gmm4
 pONVmOdQr71m6tU9zhXNrvtwVG7ZZ5qSSctmMBjsZLcYazrnhgaSJ+hYuyrnbtW8GhJMQF49dBT
 9SEO2u2+mCoq2EVpWMcxouY1mOhN9rzClKMXvhS+Y58PPTlUlW1SSX0wnMAKYUVDCHF02l/JGcZ
 WB2pacAYff2RyZImEqtNpyGL09SCP6vKEqSRuNVVYcAhYfo5chw6BpKtEtVLST7GZf/Geg6ILnG
 231TGOgh0OhkirzFZ3Gxbgzelbqo8FlHwRKH8hbi8EEKuvv7t97N2DdZ7CAqfTg4Cs5lKTAh2jp
 jLM8PM6pJtmaA9byj+pKjFpUaMrQuLmZMow9ykTvfxtpMMAtO+QuD3ykkDTsgiVfIhyOBp9/5PZ
 tRt39f9PA09nT0Zl49pIVUW4XOhQ87o5049bmDGe/iLotVcI/zPwGLWWz/vdbH0XOFLmI80=
X-Received: by 2002:a05:600c:3e05:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a18e4cdbd0mr293822175e9.25.1791983545379; 
 Wed, 14 Oct 2026 06:12:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b4836858sm47000005e9.5.2026.10.14.06.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:12:24 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 13:12:23 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351
X-Gerrit-Change-Number: 1988
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1988?usp=email>
X-Gerrit-Commit: 831e15c489240f4f6abdea1868e5650ad95369f7
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 13:12:23 +0000
In-Reply-To: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
References: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTUxOTQ4MDAwLkljZjAwNGRkZGRiOWIzYTVmYmZhMGY0YzYxNzljMjdiYzFkMzA2MzUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e837e3c40472f22537dea13f834550f66cb2bc61-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGymW-0001qF-0h
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.7]: Convert
 Changes.rst to Markdown (2.7)
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2992952036391158229=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2992952036391158229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3mHe+WHSg+0="; charset=UTF-8

--3mHe+WHSg+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail )

Change=
 subject: Convert Changes=2Erst to Markdown (2=2E7)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Icf004ddddb9b3a5f=
bfa0f4c6179c27bc1d306351
Gerrit-Change-Number: 1988
Gerrit-PatchSet: 2
Gerr=
it-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Wed, 14 Oct 2026 13:12:23 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--3mHe+WHSg+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=
=3Demail">change 1988</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1988?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1988 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 13:12:23 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--3mHe+WHSg+0=--


--===============2992952036391158229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2992952036391158229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2992952036391158229==--

