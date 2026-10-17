Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DFFCCF2CC
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nrRHxguZupyKwAktv+FlP6DkIEY5vj1g9GYPMfmMnjg=; b=BSSARP+4zV/MH+150QSTFXkgXS
	bwrgoUDq57468M1Prn/tsWAez6z298dqxx3CT1pstJHsQujFmXm8u1RO7IOmE+mxPB17BPqqx06bO
	Yq/NI1oHvJlp9ibU4mjrXhcU75r648Gu2aw6d1qzJ1l5Adhk02LHI6nBgPUs9t1R54uI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIEF7-00079Q-LD;
	Sat, 17 Oct 2026 23:55:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIEF6-00079I-KC
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZXX7EralPG9YRdQ73MJld6H9xA2CTiz1HnZno0OjNtI=; b=RVSWyRVyI3Apx/XypS4oZp2DCl
 3KsB37C8qQtvYGr0X1ormWHs5vpIqdqfdp+UvWU2W2w7FqGiYHGObxvWRqyU5dN0kdNCi8+c1ZNS8
 hpIVWy2Vb/epk1WxR9XSAttFFC37DmhaSMH4ThktExFOoWAthrYDnh20V3GxrTf/1Rfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZXX7EralPG9YRdQ73MJld6H9xA2CTiz1HnZno0OjNtI=; b=U
 djrbhDsSLqv8aRdJiAMHzVGBsK4LAoRiFrsXbzIrFra4NMa3C96PavOIN7MK2tWvK+kthLUSAKRpB
 TEQI43SJKRMf6EP5jDfiKYpwzpHaJxKkSrndKTNBGrdnxvdsUYzaDL2cCsEftW/eWK703qIZW6G74
 CRaqCnqB4DpWjAnQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIEF3-0006nX-DT for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:10 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so764295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792281303; x=1792886103; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZXX7EralPG9YRdQ73MJld6H9xA2CTiz1HnZno0OjNtI=;
 b=Zj2UP3aLkC8VINJMbiVkMsCpec3eDefGYPG0/ok5vM5kisqj/dQjHXxa++kCF/HCDw
 t5qmED5YXXFaxRNzHH+Daqqs2a186onZK00k3OpTecy31UfuHEDgLAqzBu7STc3ll6AQ
 g0Wq08nZjyXi/sMGEPaDJ+RCEYiJgFkWTfri2mjwL4OnZ8XWy1esZtnsozRxCIHDhVxz
 GXmCUWQ03UP1FgdeaEGGVjNGOejhla9wECQ9w0HOlsTCRnUCKHvML07G7TDdn/J9Hu3W
 hT0NFiGaOWLTAB6qNLHR2YetlwfaQ9aXRoeFh8ugX9P6Lm1vHGIVpz21X8/AAYp7Ipb7
 lwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792281303; x=1792886103;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZXX7EralPG9YRdQ73MJld6H9xA2CTiz1HnZno0OjNtI=;
 b=vszQGxx+QP3e2hnvrU8gPCZ7N11afWI4FmMCLl+SW8SX/drbOQRe5W8uvHcDQzx6vi
 cn2Z448y1Kh+2YCK1xAgGLQu/iP9k6Ap5MzLYjnpIRYAR5w7YxlnJw6hYM+h9/nbCzZ4
 UNhHex1Ye0cXO9EcfmV10gYn/HkmeGpb6R/9+Ak2R491lWyknQ7GnjUF0ZdS5n8It5b2
 kM1aZQxif4RaC0PREo0qDj9vGMEHgelAPc4nwqcsFhzKK1vktylxjnF90vpYOJ+4YQZT
 tTQrOPXz/dLmC/pJg//bGjcLQiw+3JdPTEXV29dEz9zMT6DtgHwTFerKGVcyx8x1qpBD
 ml2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxSRJnToJAjqf2tthTvJEr8McjESXzQNj56bg+I0nytI92T7x9nqxipYNAN51RMvH6pYxVBxRRpQtvB1WU@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIvo0gptwOkHo0wOgi8+T0cEJBrbOpCTBTHHURSC9llUy27iB1j
 /jJrqOEvS2FWnAta818VOXWSVAHZa/IFHDyJWGJo95ToHB0jFI1UDYQ1HqWQc5aYx2MommbhwsK
 w3UVmXyJtgxDIC0QyjQvuKS8oS0Gwi51gZXmH2GYahPTQIQaE4Omcx4Xz7UnAY2+Hk7xsc65l9v
 Ahmj6ZjQ==
X-Gm-Gg: AYBFou2hDXFAW+4qkw3C3FvFu0m2Z0wus9Mb4kr0JCOmlF41/r3M7UcRkGRnlgJPShO
 mvcc7ffN8s5nnRwnSnWzdRLHite6BQTlNLaJfaQL/sz9duzTwrOokvJSg6S9uYS4i5JcZqTwKN5
 IPbctlh6lIxA0+tPfxQUnYTQLRGIXu/Ukw2GEiji6/bzIt5kHuqqDrnO4ygGWeuSaW/FSD89cza
 9AQz4RU5TieXOP0PuTkpyzjkcqm7b+o0j5yLa3X4E8jHxBxYh0N9B0RA6dZR2Uu9mVG5gi3Mtgq
 1BecPYJxiurzw6EujQviC6g1vby4g43R+jnn1OZt5Eu+PUPNhq2Uu3DPk4Olzfy4XevdMYyx+/u
 /k6UgXYpdA7NoTO/0snZjmssLpIhIL5IcJdjOdVReDEeE+iYfQ/T574KzOVIptraLB9kgSZM61w
 hK5fuLGUh4100+91NWra0007rTBKpdlOXqc4xjsoIwOenVnnrShOA5nDzeEBduKcY1y+HTzk7Xv
 o4SF2V4GuHI/Sc6h/Kt3s7pJXo1pug3GStp0hayt6ld1UsiErCqA1R6MZBcBbDcfUTZeZ9fGcwi
 Zkvlx9Iw0oiMAQ532AxxuthsEkV93QQI+YbWD/QBuTUMp8dQXL280ZiDMUGS
X-Received: by 2002:a5d:6b4c:0:b0:487:baa:aa6b with SMTP id
 ffacd0b85a97d-48e07fb1f63mr4627104f8f.43.1792281302768; 
 Sat, 17 Oct 2026 16:55:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a64sm14614214f8f.6.2026.10.17.16.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 16:55:02 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 23:55:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: fc49f663551fb86d63e86367665e7d351e08ca4e
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 23:55:00 +0000
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5f16bbbf3f2b3dc624b16a9e630dfb9e0f9b977a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIEF3-0006nX-DT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0209391773766479335=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0209391773766479335==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="10MGNakirUU="; charset=UTF-8

--10MGNakirUU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail )

Change subject: push: push=
 route-gateway(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

Changes since PS3: only rebased=
 on top of the 1783/1786 changes=2E The man page paragraph describing the p=
ushed route-gateway / route-ipv6-gateway and the (not pushed) host route to=
 the server's VPN IP moved here from 1783, where it described behaviour thi=
s patch introduces=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1787?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Number: 1787
Ge=
rrit-PatchSet: 5
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 17 Oct 2026 23:55:00 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: No

--10MGNakirUU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Antonio Quartulli=2E</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Changes since PS3: only=
 rebased on top of the 1783/1786 changes=2E The man page paragraph describi=
ng the pushed route-gateway / route-ipv6-gateway and the (not pushed) host =
route to the server&#39;s VPN IP moved here from 1783, where it described b=
ehaviour this patch introduces=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1787?usp=3Demail">View Change</a></p><ul style=3D"list-s=
tyle: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">change 1787</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c0ff48fb019ac7c2d1=
d981b7b7e4578ff5dce48 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 23:55:00 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--10MGNakirUU=--


--===============0209391773766479335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0209391773766479335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0209391773766479335==--

