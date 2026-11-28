Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2355606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lOjxHFSX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CERgUrpn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JrnEU0wL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LIG5CSXJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=auQLvbCjRzr2WljFKm3Vu8IYTd+tadfb8xEbPMf/ko0=; b=lOjxHFSXDSxooGv1aK01XjswLX
	1NgeXKd54XUz0R7JWpI7NTqxwgEKbzzUTDjSs5Lh0RKv+arURJAEuV0f+qkLWYG5BvPtjXj0m+3Xv
	a+w8tsGK6u0xupFzLoSVnNm4+7P6ByS2YBO8/yqyFN1c2S2rO+wFM/BXjSO+XKH2jEuA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6l1-000000003yk-2L8p;
	Sat, 28 Nov 2026 00:57:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6l0-000000003ye-0yq9
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tt6OwPXiXs2IxMSDToDjV1W7GUPnzjkLdu4zWNp4J1Q=; b=CERgUrpnpOLNoEl0Q3UCzu4V+1
 rxbFPfuATqQwsFVw7wRaFr7VnxNv29RLxiLGVVhx2vykTGSt1g1kczO2qFLV5ebTm1AbTE+5zh2Jc
 eEKcGJFIeHnk9VWs+Kbfbc3ciRCVEutq6UmxSoDZX9zOkDjflugPRFj+28RJ2pf8kyWE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tt6OwPXiXs2IxMSDToDjV1W7GUPnzjkLdu4zWNp4J1Q=; b=JrnEU0wLm0zbZJJAqyk3ICTsKs
 B2ovUSTC7uoWMUrWNYGtIQk+1DebtiVCmDx7vmgMW5TeZBDSkneJenxClrHgxHtRL8hVSOgHwbrY7
 C0SrSC9ajOI0KZm/qEXB0FlHMK/UhgT/l6kSGrTfdOr9Wek+kwO6ryC1omkb83AsQKcQ=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6kz-000000001Gw-1lD9 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so74282305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 16:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795827451; x=1796432251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tt6OwPXiXs2IxMSDToDjV1W7GUPnzjkLdu4zWNp4J1Q=;
 b=LIG5CSXJAQpJ3tkJp9SAvvN5MQCMx2n12lMb+AKk2I7zKMg5vqnC+1+r7EbKqToSCL
 bME9WyPThN2h5oqMDyci6ZDvxvAkU402qgZ2BNhT6qg4bvWGovq6V6ed7kKoM+Zxzh5r
 otCEwjZCagK1B1cNiM4PDaC3/rWYPU4Qw3d7e7fH4MVBKXQNCv1391LxspNS7KhlSyao
 lpUff1bgnz1NH/PBWsR8apz4Z8dMzW+hUOerx3OZ/TkelxZ+YuLSf8P0KmH2lb7oqy0H
 uRvRVDUYusxgNYgXjShCfyAzt8DbTeRHDA9jATZROxnTXYAdJiIkhfLVAEjTYjJG04wO
 +0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795827451; x=1796432251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tt6OwPXiXs2IxMSDToDjV1W7GUPnzjkLdu4zWNp4J1Q=;
 b=aisbGXNjxV6N5meiqDZ4dtg8t3HceQW3CJUGV9B964WHlCHAyq9KsUwWQqaboK6ekv
 gwECICVoqlG6K6sh91U7WPaJ+gpnHN/+41tGGeMhfDrLI5SZgUYJyHl0BN2pvqAOgH1V
 GBbWPz2K6+m+921S9CjQrIHFuhY6plLCOynHV39P2QyDYGAOiG7nVB92PkhgOO/IOnrn
 sM8JAQ87FB1QWbNc34Qyv48r0wsUvsbwSV4uxuAmMyBQFI4AYAIZXXOsZdVuXd2cZqHq
 3JCcNaULW7WiWPb8IT8qs0xmgXrhXDICdLxgNsmwBhvK+jMnvVLiZspkkyUYo5v3wGRW
 BYew==
X-Forwarded-Encrypted: i=1;
 AL+hErG/f/jPFEqZN/egvAj/MWyXM6XPUj3LmudWGM4ceJOHGiJ2GeTKI5nbqTEDymbFOtljH/fYoHm3iGqUSCqF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9m4S+/WjEkbMmUWHJew+Oqw8PMYPwLQDY6jhxUFWOvN28JqmcY
 XBU2VvALU0clEl4Ynw+KJo41DbLQknFnrmHkOCADFwG9pVOFatfRUwSx2PCt7AYJNGw8nF4Ut4m
 y5jV+C2t/wg70N5yHxypjG1yhqg56PK9yraq5HKQs5f+39LngCCjc/3ngXlWajYEdjcIkif8jTR
 L17B7tbg==
X-Gm-Gg: AZFdTZcc+XUq33DpSX5WBQe+LKw5i6BHlL2ePZrNBD2o0qcwhh/uVy3i0hJ4kiGgw88
 5xpxntkhsJkkjYirkX6eqYjHJ2ZVJdTOoantsx73agijFxalzSUmQZyEGpq9soVlJ7UUeuafWln
 6EdSVN8wrbj9K0+h8tYUgxdRTqWvTJV24R3qDVv6HrGzfGyOEvdrixEAJZPKoaL4fRiMEi4mN3u
 sAVI1pd7PLqtWyWDRtugWtSy//+VYB4JFEOFEs9w6JRnyZJVsfRa+aiSgzhnpbZb0RKcp/8+mCl
 Augxxe1WaKhbM4lyhLhLA4+hohpJl5knPeZ21o7c7z2rWP/Mv2ZXFBoDfFEDBHPIOE0QkeyjAYV
 1WbACOK3qr+iSv6uwilELYBCNaKvcj3SrFQlDhZfLlhP+x4IpT1tER9I7dtxk+gU1Oguu4dIuX7
 Sv8ilz+Ysd3i/b+wkIndIzgFsVZmKEqM/DHe9x59pk65CXpbZ7lk1DYNX2wOfa/oAUlC5MLlbfv
 dBIyrE/vvz78H38L3UdExskWR4xVuuTP6sVl4agNTSomjvK7H5YKrglFbVoHMHBC4QXdcyU1CTA
 NHRzDYPxQKeKIhc71VQ8lCWfuuGkcm+9BtWTqN8rqMSEXwn9LCAg0Hy+reP5DWQdDvXhPovHCIY
 isKil3mQLg1F8ZH9+0c5++k/I4IbqEvpOv4iPxDhHAJLhwq7tERg2LEp9CZM4KEGFpRRpEhWO7j
 1Q2I0DgtRwFrJRrG4=
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb88785d24mr516086435e9.0.1795827450708; 
 Fri, 27 Nov 2026 16:57:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm977647065e9.0.2026.11.27.16.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 16:57:30 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 00:57:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:28 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3abc78a7d7ff30d24ff74fefcb0cec1154f2a67-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xX6kz-000000001Gw-1lD9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8415369690894927747=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8415369690894927747==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e2P0g2/CNpI="; charset=UTF-8

--e2P0g2/CNpI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Deri Haerudi has pos=
ted comments on this change by Deri Haerudi=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: dns-scripts: parse d=
ns_vars_file as data instead of sourcing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

Superseded by Heiko's stack =
+/2347=2E=2E+/2349; please don't merge =E2=80=94 will abandon once the stac=
k lands=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2341?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e=
4e32aeb806d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchS=
et: 3
Gerrit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Sat, 28 Nov 2026 00:57:28 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: No

--e2P0g2/CNpI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Deri Haerudi has posted comme=
nts on this change by Deri Haerudi=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Superseded by Heiko&#39;s stack +=
/2347=2E=2E+/2349; please don&#39;t merge =E2=80=94 will abandon once the s=
tack lands=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
341?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding:=
 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4=
371 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:28 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--e2P0g2/CNpI=--


--===============8415369690894927747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8415369690894927747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8415369690894927747==--

