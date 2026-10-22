Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B36606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DK9HksbS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XvfF9cpi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lFfjJVuQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RbYp0Tpp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Rqj3J57+MMFV9cx/EO+bieyAPCZv1pd0HqZt/sJEjw=; b=DK9HksbSMg24FjwQ2iS25VXEKn
	XfmUW/L8e4HckPBCuUHeJKKLfn39+nGgCHwQgbvE1a0Rvj5vDuDIGTrGbpGheUJLq4xVVHLlxVnJX
	kks0roxq0Ub6mSmNtsBf017bUyPx7mrXqjVhEeXbS2FT2twAzQo0+pa7EzdQXsp+1m6M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJsEA-000000005sz-0WeT;
	Thu, 22 Oct 2026 12:49:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJsE9-000000005sb-2Gvp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/GYx23vtOFLbFh9mC86iZAMsiksO5efSQm7efbeEGY=; b=XvfF9cpizKuF8cOxdsOF4tUdYU
 PHVIiKreBHB3O5WNniwsHejNT0vuETxVyhydck5khTVsGf+mPuheplIlzhFQsvTZoM7XXfyDjeH+8
 z0hDs+g0roJqjVNgaDDSU9dwm7kFRF/ZLuOcqCxw4pjKbWxxDLx7rzXKk03lkAJlHM6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/GYx23vtOFLbFh9mC86iZAMsiksO5efSQm7efbeEGY=; b=lFfjJVuQWkFSyGdBqVDtVf4PKd
 OdABuBVaczUlCEhYosqbgiUtnL4JDgbt1NnrFGmsaUs9pxMNkkNhloCaCXkAawwwcdUi8H0i98aLI
 /igEVA1aqOHmwdsrVqvcBDeBSd8OY5u0jBi9bGNmh+LtIn+WXltW3hzL/YMxXBm1GchQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJsE7-000000001B7-3ESp for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:49:01 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a209a7fd1bso2758325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792673333; x=1793278133; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q/GYx23vtOFLbFh9mC86iZAMsiksO5efSQm7efbeEGY=;
 b=RbYp0TppzoCugdfllrJq2UWM7M9MCC+GkQB2HrzZ/7bL6Va35l0M829ZPwv/s5oZeK
 4Bl2kxJzRSlzoV5jQAgMaOl/ZqT5oB6BxqSc3NmIGRQfYBiV4itNR0Y2RHwAdOjRebxZ
 fwFlVEwU84/DTjNUaaztrfSQl4JHg0LTZGMhGGThE23CG/AJWo42x5z6FOAzNzKLt5l0
 rDX9ZKBYEguZYzGdLhRCqVAma18P8G2hRzvfXmUZ0IYTZYeMA5o8iyThVqhMin5xuHR0
 Nw42GAxN2zI0vkgn/ONv94iLS9JFvgeVqVWsWsbKQZPSOq7qCRl+1IugL1PBTfhjDH5L
 AAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673333; x=1793278133;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q/GYx23vtOFLbFh9mC86iZAMsiksO5efSQm7efbeEGY=;
 b=JNqdJfzcyhsGVyeikCrJ38T9MmlIAuZeUnTuy7Lu78zVip8YOMD2J40CDyNDIoTBWH
 D0zfjdCL1hNtZ8tUUqbh2xV6lG4jpnHObVPhJ4kUwG4Eylkb6+uLRClG3k+nIO0o6p5X
 55eZWVU7DMdxZUgZlfXVdGQcZthWJNq8fTO7w77bESWMlkTkqcxJtunrA0ErEKeCqSYJ
 Ievfnc+BjzMM4Q4zStO8xXZoVwptBH4mvlZoOgLIT6iWOZ4BtsAc9jiX3LibnaP1sBwI
 tGqNkNlQnsY9n+M/T/pcyEP32PCGucYCwvUKdRTHT+ZYGWnd5euD5T37Gxz5vn/9v/e+
 wZ0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnUVI3wdi6gItRGyHAlJeETYZ8nrGRAa/Ccfu6BXOlu0ofkRPyFuCjktr6Ly4/VTD5iu+Robo/zCqI5Hpj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK2wSERtJjPfU6ip6K/MEoytI+VOMFgE2+x31XseCGGuUIdmkzd
 9A9k0RR6b9n62IhW/8l+zKXEOdeh9oLpU5aoZjxQZt7eO4n8IGuulY74TCH825m4N5dA9ueMg8x
 78J0CGFydHLkuADbNjWqhnjeEaDKPR2Dc1N+c6dV1FY2C6zoNsH+Rd8vvQko4jSbArmTP
X-Gm-Gg: AYBFou3lmotD7Je5f1a7fxfAP7IhFbiuHDLHjWmSg0xKkjyw7p62Ng9fGsMjrTmC0R/
 BoqNmBWIS5z/XDI16dtEbSX3kDKza7VQt+ZbcXwNO5OnXL66tRY4PyCHsEjrjDN/nkAo1jVLJ5X
 DlaYgRIXNhFCy57lQ8ULrKACKD9sPu2J3gnmLkPWW7meSGwigbqLtWoaw3btxHSlkO4NnlWw3/O
 8A03y+Tske0oW/z7R2kE5F7msyPy6gkhPhbnNmy+TRtWkkxwY/9uH/yDzoMijV3qLepg/O/g34H
 6R8NyYkQnRiHnWetq0gW1S1ILzG5vrpmciY41BVr7pwbvtba5ZG/Xs3Z8JI14qTpo3ls8o6ruZJ
 HommptoAwTFaXoTlJQu0wRzSvT9nuhLn7/JT6JddlTLnHUfCUbEvTGZ+99vNtX4ETjauoJrqezI
 EimiqcpVIY4nawOHHSKyJ/+CqttGW1/mCtv1pMxcLm8YaFt6HhWYr/J1tw9oyAFAecYYUoBV5Y2
 7WimtYEe+KGYvabJurDQoXHZjH3tLd9NzVbMnvjV9my6JcmdeLSAEdGZx6W7rDF1eNQHdHydMWs
 1BclswsCWbPuvqu695gwqRcRUMPHTF4FnVo1CAk35bOTz5tQzK22h4OBQsHKVzkf3apNerSPF9A
 oCVFbOVoNBsTjuT8BIgSWXmwFRW1o4EeJymvVZL9Q5cRwDF8eMBRtZvKrydRsTbI=
X-Received: by 2002:a05:600c:3546:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4a20e0c2b7amr3027875e9.16.1792673333029; 
 Thu, 22 Oct 2026 05:48:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e258358c1sm12574661f8f.43.2026.10.22.05.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:48:52 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 12:48:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
X-Gerrit-Change-Number: 2028
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2028?usp=email>
X-Gerrit-Commit: 7c0460a0682aeec8dac618cb8bb053a6d90b8a5b
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 12:48:49 +0000
In-Reply-To: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjY3ODAyMDAwLkkyMGQzNjdkZDgyNTFiZjM5ODU2YWU1MjFmMzgwY2ZkYzhkZjY0MTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2472885d3c42e953ee32b4975f0d4113ce74541c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJsE7-000000001B7-3ESp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Call
 AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5426277888447096467=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5426277888447096467==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PXdwyvgIK6k="; charset=UTF-8

--PXdwyvgIK6k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Frank Lichte=
nheld has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail )

Change subject: c=
onfigure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20d367dd8251bf398=
56ae521f380cfdc8df64177
Gerrit-Change-Number: 2028
Gerrit-PatchSet: 1
Gerri=
t-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Comment-Date: Thu, 22 Oct 2026 12:48:49 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--PXdwyvgIK6k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Frank Lichtenheld has=
 posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set =
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail">c=
hange 2028</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I20d367dd8251bf39856ae521f380cfdc8df64177 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2028 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, =
22 Oct 2026 12:48:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--PXdwyvgIK6k=--


--===============5426277888447096467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5426277888447096467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5426277888447096467==--

