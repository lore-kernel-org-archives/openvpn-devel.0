Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CB606A32F
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T0hRD78G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SEbj8WGx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LuLBAliy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hDt1vEta
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7BNbk31BNtyh5scj3dTbiWFLGX60qToXu8xPew/Y81w=; b=T0hRD78G8nAaRTZY33BUZN0qB+
	vhIolaZ25k83mNstgrGMPbLoDH7nLCMXeNS3VGuW1bS7ZxTwB7Q+/BgpxO5RgcuhjfR4rZCU/8ZhJ
	mlgiU3WBC1IL/4odg5unhsvhNcJj2322HLw11OSpkEba+sxdRADPk6M0MptmvK8mZQUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcxL-000000000Do-3178;
	Wed, 04 Nov 2026 15:31:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcxJ-000000000Df-3Orp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BRQ2zcS7n+I7cGjWszbej83CFtpzh6W6nV9hdlBI+7Y=; b=SEbj8WGxdnrdHg6shpVqmXC0ha
 OLVDkWIFAM/SqxAi++J0dvK+fQZxGn0KNZ9ArCqkgHmz2bV6OJ1RwrrG9WpJwA5QsrLjA1nhQggM3
 /ugQ40GlKFjR0u2v4dVtKlf1mx056nWbGSbZ4vGvQQErWqIe0eUKZiNAdR5oidh80MFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BRQ2zcS7n+I7cGjWszbej83CFtpzh6W6nV9hdlBI+7Y=; b=LuLBAliyUvpAEvvuaOzRfdNXkH
 z7EIztItZoMXbcU80s2YML5ZeWyFO8e0MLsAxAbIITd9Bc4h1VEkoy3kLqkZZ717QVRSu9/gq0vFF
 mQByjOxRe0agtROuMBgdKLaqymwIQkq+oiktcRpCKfcgj2ogn0dB8IeHjrAwZk792Uxk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcxG-000000004gk-2fvV for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:31:17 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so691336f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793806268; x=1794411068; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BRQ2zcS7n+I7cGjWszbej83CFtpzh6W6nV9hdlBI+7Y=;
 b=hDt1vEtaKyrjPsm/QEHYf7ieKu7RNDWEmpOuQUxuSTFvKnXFeuRRtiZacKSZFWjV8z
 71Nndxea/24NjKg1oCBu2esEqHJdyMQHpN6dnikb+udw2gDqDNocVn6gEbf+30TcXgW+
 CQD40hoFx/bMVRdpcs5DHzeAE+McO2+QKwMPQZkGgBy4vbqAIFkWZXl4nOQdZasocHg9
 VRu3gEM25na5+dXqGDfuE0MK/CahrFn3bYMdyVxdJrQCjp6+JTVUMHq87f948+IonyV9
 PbbKLIxVCY3FMI+o6RHCJPWfM1vmDUT/sSFu1RcTgDGm738zQ1bEsIkiBWmk5yWiOMtC
 IJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793806268; x=1794411068;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BRQ2zcS7n+I7cGjWszbej83CFtpzh6W6nV9hdlBI+7Y=;
 b=ck+iR7UXznl5FXPe38hfXJ9pUyDYQ3nwztkCUtqUv69eXxU4tODAfr9hQXSMw6GomK
 mwu1gRlMv2MurMH6Xbuor9Lksd7vCIJWLJyVnCeBZrZrGxyRl/0l9RIN++awPvLyMrqX
 i+S6l7WPyV0qk9s2PlsaBlCO1jOc/O7tPjrdoNqVAiv1dcmc8pQwt58NAeFHdg9cekcQ
 24curlYWoHI6DqDSf2eSB68Av8IxvzRm3GZ1zdL/4yqDYQFEE4e7oQ+DaA80CrOkd9h7
 sMhbHnZC8Hj6VdmfSZm8AD/3NudenyVy6u99cPzY29K5iJnhsZgTM1SLKQGizTaFUNMt
 N15A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpD3+n/jgjytcXTTuTogcHyRRxHYsv304FevC5KM5iAOBuGzvTosV4b4wpg9umsSPRAz9eBiOmyet9iEGI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/AnySfpGzcuk0ddyRWz6QRWgowk9aFBNRRiNwggxCNHimkLgcC
 wgrEZ6tvqwFtR71g9tDjUuDq3JT5NFhOUWy9IUhOQ71tUXskkOB9dDDdzHnLVwjD6RBIiBek6L7
 PodDGWv8kf+cOyzyUxxsw+ece4k/dyA4Gt1anA4oMDe38KxiuliRuA04MFXaHqYHlwVTQ
X-Gm-Gg: AYBFou2p7zHICTVqAhLzN5A4jTmI6pH4vNWHRVWhyIAtcW78gArnGFhiDI8eQPpa1sX
 4HcudV+GzCsjhABHlabeQeuMKzwuBgXPWNt1mOmc0U6T7Vg66imFzsdu8CbnPejK0EVp92jevzP
 MjEzFnwm1m2KgRRti70zMVbcCFNlw5BTiZurp8v/YsTSwEEyPD5YdXkMgFhTJPjW+j1pcVkDWEH
 k7xQ0fXtHnCYd0o45l0S4ag7fUtgktvRD7IekWkkSYnnAHQVcOW+9MFw/QVO3exnOiMM2ELolik
 m1q95DL/rdmGZoiDiFV+Djn/ERw5Anpqej0fsYr5vVAV+qL3hsM6S0SffafObNtaQhPETlV26Ay
 NTaNiQnequmbGJ4rQSbPpvOYp8IOxGQgLzBUkPCU4wUZ3w1z7hF1t3qVw4frOcepMEVsf7HJe2i
 z+WJWCDVt/AyiFJFjNna3uVhODMQyIHbYIjS6yfCnXsrRYtIW1xjJtcw1v4pR+hfu0ySjpwnqS0
 R4ebMazQcrEWZh550jdAEqiRDV/La0Ku/R/mofmmRBMfGixcOtQYj5bQZl/iU3bHItTcvV/0ZI2
 8TUgIXhuNdE7CF+WRpUC2Jnm7B0TQcNvJEWpu2S28fZdCCMDAfQxuG68M2uWrJ4JFnNgK4rLuQQ
 C3k9M9T+cKrffj5Qu81Z73cY8ecWdoGwh5dyFxa582AWPlI332Fh6DkHjqenljbWWoDOl0w6CcI
 cErwlyn1ANRw+Bwg==
X-Received: by 2002:a5d:584d:0:b0:488:8525:4979 with SMTP id
 ffacd0b85a97d-48e6e50b5f4mr34694706f8f.45.1793806267811; 
 Wed, 04 Nov 2026 07:31:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm4381649f8f.49.2026.11.04.07.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:31:07 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:31:04 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 07c096a514de967e7fda4329f129d42478f3ac58
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:31:04 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <845ab513b554a05919ff58a301d77d4af2bf4277-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcxG-000000004gk-2fvV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0426829515811886991=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0426829515811886991==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E04qv+2+m7g="; charset=UTF-8

--E04qv+2+m7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov=2E

Ralf L=
ici has posted comments on this change by Lev Stipakov=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail )

Change subject: socket: Le=
t an optional UDP socket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Review+1


-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a72aaede53ef9e863f=
e96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet: 12
Gerrit-Owner=
: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:31:04 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--E04qv+2+m7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov=2E </p>
<p>Ralf Lici has p=
osted comments on this change by Lev Stipakov=2E</p><p>Patch set 12:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 191=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
4e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Wed, 04 Nov 2026 15:31:04 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--E04qv+2+m7g=--


--===============0426829515811886991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0426829515811886991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0426829515811886991==--

