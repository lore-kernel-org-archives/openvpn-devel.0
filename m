Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587A606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CWUjfBek;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B7XRdXEI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mNujNNd4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VhATbXJv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wyHlP/6UolUl0dzvnk0MT3lu0ycbwDdU/vlYHu4dnxM=; b=CWUjfBekIsq3qVTZkL/wNe76kR
	gHUNyf+2caK94OEEGEVwooFtz6GvZx0QZ/d64pz7Y7WfAVJ7q+EXOfYSq/hZozEQmlGfca8GfVhV0
	hnRRUq8ES2buxUBMXoqubnUW+4/07a044H8JdVnl+hRP8w72xMuqFMSl2tmeGuFZF/dE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOtWH-000000008G0-0qFt;
	Thu, 05 Nov 2026 09:12:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOtWG-000000008Fr-376D
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1f2Wj9+VSMg5gW+8OHyL8akHxpekRrgDmx3NlaB5ns=; b=B7XRdXEIJCPqwXhYWSl2kDAT+D
 JGCbfQ4Xmjx2TSU5o5P5KSfMtH+7qMRi9xd3FW4dnXxtezQf4MqMhLJgG3wyBUr0+2ANcqvU2aka7
 fPSWz5TigtRDrFTJqAwi94xhQVx6tl7im8W4PCMZc4++vHazLNwaZ78gkOXKV/ujOW+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1f2Wj9+VSMg5gW+8OHyL8akHxpekRrgDmx3NlaB5ns=; b=mNujNNd4Y2nWQn55accnk+0a5L
 HE9z6Rb6nIBRzJMEW2pSAFumFlCCtPkJaFxAEjorJ97yJGHpdFzjkKL7hhzOtG+ZSa8ccDAFqcxPH
 gqaAx9g0EFwoXUN/xwkcMMXTwuY53lTherDo4ZUAhi/B3ydsQ8/Khtl8+Eg831Y/duHA=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOtWF-000000002Iv-3MqL for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:12:28 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso14876905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793869941; x=1794474741; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a1f2Wj9+VSMg5gW+8OHyL8akHxpekRrgDmx3NlaB5ns=;
 b=VhATbXJv2fysZj+G2oiPNqhtJ8NcVj0aUKE/nd35tdoGo6ElcfFjriWM3pkWoT3L0Z
 dkoAs+gYbfxv/a5fEJhWlb5pKhsqFyym/SsBkpVqCwkiq4zCeiExNifbJEtt8OebqAtb
 Z+/8ebjRLsHf9+Go19FchcyimY6bnVku9WQxFREFzkLR4Fjl8c7J5665nWxgQXnx7j+Z
 AoOZdpYUjgzbXXmoQtBT+qmhB7PLUijLBMB4N0U+dihsjdMHGImzu0+J48YuQGjA7oNe
 Mrrx8v2cQewl2KtsZWn8R+CqNKlBsUe+zPQ6UetCKNolyJgdEaN8g1E7e44co1PmeFx9
 HFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869941; x=1794474741;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a1f2Wj9+VSMg5gW+8OHyL8akHxpekRrgDmx3NlaB5ns=;
 b=Njx74ogP+4kQni2sm0CsPEwt0zxR5o7EEtVrYZY2bfCTQT/xmGNUi1qaahfnhYQ8Eo
 fBWhDhZ57HDE21Wwc/zC/S4K2ZA9zTNrMdlhLy1Dj9ssvKH2A7WBPBU+TBm+6sIOBNE0
 fm1SfzDf7gGK3wfyHMpZXeixCmiky6T/gXGRYa/uDxoPcYE3d0pvL9q0n0PwWK1fusne
 nuSwltJwuJ7ioNlT7tj6nMyApGCbR6DQLTc3iWJL/SZXO/Qcoed9wPVDQmFclfsPedwd
 bJZ2n+JKVtHYSazrE/lRcvdeWfSKudvzn6pLj94zOFH0LpWHaVAHm1vJ4uRlOtTgaiUb
 xRYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4EKQqfVgQ9Tnk7q8UhTHGRSFEp/h1DSqDn2JliSv6tkdVnto+BMNfRwojupRBTxo6gGjNS04BsN7LNZqI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/XUSLgSoJevEPq0OgVE9yJkD3gW6vEVBMKORyX13Cqx5s48qT2
 KH7bkieQv5jxm8JFxGK/C40B7uqZaN8xwas7cF8U4gYBoy0OsjjcFaKXX0wa8aDX7rPrZpBw9cc
 GQtJPwIzNVJWWl5gKSh7rWSgm2Gv8inT2vE68ZiefFoACCtt3vrjg7IfwTVlSYGqHv4SSQXyUlV
 wJPN4+UQ==
X-Gm-Gg: AYBFou1kzUJWK7VGrEsTfBHTFT8tJLY/gpSLHmsOl5MoOxdBA4Bd6XeKqXzpX8dLRzt
 f2EF2aF2FroRy9A/GfC+WB+sGhwKEwdyDBZEMDO+/q2poS/lhvcmY9IYYM0kzC3kVNHpW/+iiTw
 fSABHKSBebavPptxfz9FYkbI7oSCkb2uusZIX2t8OYYHcKRgvIB8T1QJzUT4+jmFMgRLhEKBs7c
 RHUSX2mZwMewyBHNdGC4CfuKy2idmsWV6Xqsa6n+DhyRQKjbaxJlufI9AsUA7voD3quVkQbrzV3
 ePxiltQH0/2Y9fJ81HmxZuX/BcpRFqzAIsfCA15lDgO8SegR8ts6j4aENgn41mzyeuwAqkowFv3
 FHKiJL1bOfBUX/06Ci1dzzkZ4YVNY8oeWYqm/HvscqOSkTQhLROrbZ2c4YC2UzTtTVqJHphs1fN
 jNhLFkMFGedG6lkbeLkDIOurGbdh8MA4jGpfxiL54DEeEtd+MjUJAU9Fq1ncmDcLPAEkTEHXRdL
 SEf18OMsGazyyMSnPiEtD4cjoT5GyCMXKuZGmbnJT930ZQhFip1bZdEW1NYJbmtwmxjwpVTduUP
 irrRziZgxbl/EzoWCTVR+0uxNERBSi34Bzv5UiFE1NMR3GOBcw2rTzctTXiHOi3wNc7fPgtVpqv
 rbmUvqUxM1QqQ6F4yrYBdIesTZ90J1W9jlMVsYAbVRX/ZRi0w28FG3tu/bJrBUK4Bf/Uo2Aj7+A
 l7p5IbPEFw/kTB/w==
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4ac1737c51dmr397293975e9.5.1793869940369; 
 Thu, 05 Nov 2026 01:12:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f02386bsm47354725e9.7.2026.11.05.01.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:12:19 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 09:12:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 2eab5e0e8841fc61017933bfe62d7386c7f3de94
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 09:12:17 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0024c4cbdc35a31f159e098d3c5dd87b838b0f6a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOtWF-000000002Iv-3MqL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0770697083398508819=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0770697083398508819==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tmOSXE5986o="; charset=UTF-8

--tmOSXE5986o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Name of user not set=
 #1000061 has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

(1 comment)

=
File sample/management/acc_dpc1_server_demo=2Epy:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1860/comment/4db1b10d_d36aa385?usp=3Demail :
PS6, Line 6=
8:         print(f"Received DPC1 message: {acc_message!r}")
should be logge=
r



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a=
25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 7
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of us=
er not set #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2=
026 09:12:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--tmOSXE5986o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000061=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_server_demo=2Ep=
y:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/4db1b10d_d36aa385?usp=3Demail=
">Patch Set #6, Line 68:</a> <code style=3D"font-family:monospace,monospace=
">        print(f&quot;Received DPC1 message: {acc_message!r}&quot;)</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">should be logger</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2028=
9737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: N=
ame of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC:=
 Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 05 Nov 2026 09:12:17 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>

</body></html>
--tmOSXE5986o=--


--===============0770697083398508819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0770697083398508819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0770697083398508819==--

