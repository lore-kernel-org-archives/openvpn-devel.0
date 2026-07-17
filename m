Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E7EC4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/7I98bBgyEgstUCNHMgSRhzxiUPSUXtU4D23UL0r4s=; b=RiPpzVbbFK6GtcGsZ4me3qdVkT
	2B631U/oiWn96g6MRFKHoxu5b4PNRMphWC1aIDsq36DzxmGk4JH08tG6BNorTaVhz7WnYN9v/NMBx
	kR3pXaG+2o1aGaQBb/Sw5nSyfB0fvhMOZRVKtfhSUrV0ab150zjV13ZCj2wS3Lf1ql8s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjzH-0003Sw-W9;
	Fri, 17 Jul 2026 14:56:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjzG-0003Sq-If
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aW7upTCzN2dzkPYtThZ78In5AKSs91YvZJNzwLCedv8=; b=iK1C7pnV3auj47IheF+zYd1B7U
 r8hfgQxHMvulBBPIR0SoCMGbbRQlhu8olshL9ASWkC8s3pWSSMFQtwmDsA2f51ETmD4Giv+DO7UiZ
 9RvVvhKtfA3u7xiXBAT/gEYDKYsg/ywZeW6u89lXZBnELzxwEj7QPF8n77N0onuNTg0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aW7upTCzN2dzkPYtThZ78In5AKSs91YvZJNzwLCedv8=; b=U
 DksulWIKQjyVWr3jzZyUg1sctn+D+i0WKNHjE/oja7QlNqwaEZ7iMF0Dbo+cxritP9sRYnH/ODCUx
 k7wUGBArwOjyGO7NRf/jOaWNcddmSy6lkaOHqTy39chNsqVqwOYCNynqnVqfLZJCGnltg9W7LxD02
 ZtwTHgG+KOxa6Kzw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjzE-0006Hp-V2 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:56:26 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4953ddae026so21577795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784300178; x=1784904978; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aW7upTCzN2dzkPYtThZ78In5AKSs91YvZJNzwLCedv8=;
 b=NqZA3qi662CSvnSi4IT987pW2w+sf/0GpaTYXfQj+AY++U5oAXdWAWJVL9VR2YUUxL
 214AkMTcLdPCJg4Uh+76MuzjxAVmXY63sFOLiSn9/NwYIBjVgxZJTIenhYX1VMbyGPUU
 CvfEffBxl96iihftaOeduFWgAKiXW/kYDHllY0ZFxF/PGQCnQs0/vD2UsmxX0x7DzJE4
 lmBf8w8z+u8iw/kCmp8OgzrRIKMCSPR5u8DGU6fqbxU8ozRkeed5Xr+aJ+kMiSm4DT/D
 8ASgc6GfvXXgFMqEjjXnMEiOCj/44FzAfdcEpIOVKeSYI7/FWWNjl0pswCjutkpUq5Bs
 +3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784300178; x=1784904978;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aW7upTCzN2dzkPYtThZ78In5AKSs91YvZJNzwLCedv8=;
 b=F7BwAHm+QaReFuK7rQRMAs6YDcM9+jxKb/pCz8+kt351CdaVdhLtSh5AM5GbmI8sCb
 DORjPYbtFzAamY6zI63PFj0tofY9iTZWyn2DAWVNQHZF7WAm9I+rMCySRWaCpU+WQuLm
 ws5jhI5EFAOVKSuAKB7u5Ju8CbcZYmSF/A0az8GFFzqoR8Gx90NUL1nL3Qb25gn+gX+r
 5vjhuhyq2lngpvcMbZo7HiGMnWSp3q2qOxH2eAiDHoaMDmENhE+GniOAbwa4RQDIGWRQ
 56ifM8wpIY0MRBogzLykHyyV0I4tecHwSrxLiF5T1AGV6QrAybsfgrFpYArvt56Bo0rz
 VGNw==
X-Gm-Message-State: AOJu0YyOlGqSZhhCsLBU7CR4cosjsON2Yr1SUFJJQ9ovIkWm0HglHfY4
 LcL5Ak2bweObBdVg9LBdg3LGg1M7xf2j/9T5R3A3yEIdTXM6SuHLo3WDJbEf/zBDNAE44K85/4K
 mLlYTxwdv2iLt7zjOfl4lQSpIa79Vzxn1GhcaM7SS5ri/IsmNM2eOIsTAiagb4fga4BdG
X-Gm-Gg: AfdE7ckcrrf8F63mViGrDO1uZR52GwKcuTjgA3Sd1PF9EZ/lBSBy7f/My7cDkH6cUo/
 4Y2QlrtXffXCTRa2wuoyk2uai5j0QgOtT8wJ2LiNisoKDna3LPi4jSsdguCTwqsG/1iJZXxp1yC
 YzDI/aADB+15OpHBvj2mvBbuwswK4wgBbloKfL8jbP3Ht1VmMiw8TyIKTlAR1PQIaBGZ5kMhysJ
 iSkTfWHrXJopY7GL+/4kzfVl6l5GtO09fhJJXdVcYbzCTeZt+qJ/3q0MItbS63SiM/ZOm6b7MLX
 dxzd7u8o51Ag2uYMyse3MdRRh77pjEe5n/4/jNaOyWHWe2GC/zOHhGOh2AvJ3cjCjnZLXyGYaJh
 SdYMhly57pvpfhJIxL66zKYL+GlxEVzwTzOWF8X7d2SAFzSlnNHFveaE6F7Hfpu3mLh8vMsZaGQ
 0dax6eSYMISoc5/T7vs/k3roFBFSBlh9kKMOb6VTkjeQevSocGjKtV98mmuMlalOgIFCzB96jwi
 3R3ct8hbXTy6Ubdjz3wwn3IVG8RDu2RkX1CH2gwbGddKssfkV0qndDseipkV/ZJ4IYk
X-Received: by 2002:a05:600c:b8d:b0:493:a613:56b2 with SMTP id
 5b1f17b1804b1-4954a3d0d5fmr37594445e9.8.1784300178196; 
 Fri, 17 Jul 2026 07:56:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b893dsm51355055e9.8.2026.07.17.07.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:56:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:56:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: d25ee55822a9d23aaa20648ed86b0d14607f3e0e
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:56:16 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b63bad86cb5ecec06b08cf9bf25a523350ef7ff0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjzE-0006Hp-V2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
Content-Type: multipart/mixed; boundary="===============7674870688433085137=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7674870688433085137==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z9PDMGkARMY="; charset=UTF-8

--Z9PDMGkARMY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 17: Code-Review-2

(3 comments)

File src/openv=
pn/siphash_openssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comme=
nt/82eb4c8f_745f931e?usp=3Demail :
PS17, Line 27: #include "config-msvc=2Eh=
"
This shows how old this patch is: config-msvc is gone for years, please r=
emove the reference=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comme=
nt/c865d631_0d7e7379?usp=3Demail :
PS17, Line 32: #include "siphash=2Eh"
th=
ese includes could move below the enable check


File tests/unit_tests/open=
vpn/test_crypto=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/=
507c0a42_1dbfd977?usp=3Demail :
PS17, Line 960:         cmocka_unit_test_pr=
estate_setup_teardown(crypto_test_epoch_edge,
Removes this test=2E Conflict=
 resolution error?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
9aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-Pat=
chSet: 17
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 14:56:16 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--Z9PDMGkARMY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 17:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash_openssl=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/31/comment/82eb4c8f_745f931e?usp=3Demail">Patch Set #17, Line 27:</a> =
<code style=3D"font-family:monospace,monospace">#include &quot;config-msvc=
=2Eh&quot;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">This shows how old this patch is: config-msvc is gone=
 for years, please remove the reference=2E</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/c865d631_0d7e7379?usp=3Demail">=
Patch Set #17, Line 32:</a> <code style=3D"font-family:monospace,monospace"=
>#include &quot;siphash=2Eh&quot;</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">these includes could move belo=
w the enable check</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File tests/unit_tests/openvpn/test_crypto=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/31/comment/507c0a42_1dbfd977?usp=3Demail">Patch Set #17, Line 960:</a> <=
code style=3D"font-family:monospace,monospace">        cmocka_unit_test_pre=
state_setup_teardown(crypto_test_epoch_edge,</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Removes this test=
=2E Conflict resolution error?</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa2=
7caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
17 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Fri, 17 Jul 2026 14:56:16 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--Z9PDMGkARMY=--


--===============7674870688433085137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7674870688433085137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7674870688433085137==--

