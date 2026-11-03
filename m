Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3E606D815
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WzfdnWdH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dK4fPbHi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D4+vishi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=I2WKGTnz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2uie+Co3SEhOITnTyHIsOvFHJ1ZaiZANC6Hyqyn0K+8=; b=WzfdnWdH/PwhKkqGeOLvXn+NfP
	q/FhGOpu+PFKPWign1HhUg4RSRbnu2RS0ptl1P+WyLy9WQ2l6OgFw1kGquExByPkKZ6n19e8iNzV1
	wuo7NLBVbqP1oA/geTZBohW8fWvWcnmEwwGibbAT6wHt622Pz26HCIGfyJxp6rqtU6+8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOAzk-000000005cR-1h1n;
	Tue, 03 Nov 2026 09:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOAzi-000000005cC-3X5Z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UcwBmNBu42UUdo7yQzolPo/zIjc/w8w5JZhwAUy0ZGw=; b=dK4fPbHiO/rWE5DZIsmFUbFFn1
 WqL+MHCcRqg/c78fIYlsmjlTLE8H4H3qvs9JJGeHAp9iBWT+oq0oqew7SMw3Xe0GSyKFkBQlZLLfn
 N2jRKk7BTvV2s1VUCeG8H6eO5K5JleUcp/9JOfPFv9CSm8j9ZqsF9NroVcvgASbI4P6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UcwBmNBu42UUdo7yQzolPo/zIjc/w8w5JZhwAUy0ZGw=; b=D4+vishif83DZqi8AK95X7WD4D
 SHAOsPCUn165buDALXr8fyyFkgvhrtKRz8iXO3ayMyIxbqRKe+HyrT7qIdQBSq1SA7hhdJarelv/W
 D+mDpwurk8c0R7gZbYx+vH6+PUCH4R0EzsQtW+vziutQtWy+//tCcSCxhQA/7paUbQnE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOAzh-000000006ym-0zqQ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:39:54 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so31553565e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793698787; x=1794303587; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UcwBmNBu42UUdo7yQzolPo/zIjc/w8w5JZhwAUy0ZGw=;
 b=I2WKGTnzzHAJUjyPBOet0nK/EMl2SE5M9JPN5VVV6c/VCX6D1+zlRlS8ylrBZ3LNzI
 iRl+zawX7MZ4AEOony/DfsL9cdZv3V/YLOP5bU0IRV4KHhiTV3Wk/c1RgKLQehfAG6h9
 kQ6Rcd4FdHnXmqHPMrsKXedm8mwHiuGzRVQ+gmugZBrP0rclUbzBNvqsIyhlMENe4KxY
 CNGQIyx05+PBtH/WeywAR84JEs+uPELz0Mq0wPjdkp5wDzfNrT98ZHznfu4hboUEohCV
 smydXD4mYB988dWalfSOy8hGJjZ/i5OtsxY2gusQUBJVsn5MIyuPmARQwAAbBZ0VjBB8
 yEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793698787; x=1794303587;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UcwBmNBu42UUdo7yQzolPo/zIjc/w8w5JZhwAUy0ZGw=;
 b=TakbCHsTzyAlMEXK8KhkS2rWSeKU2i8Zo7KOpjr9GLg6kPr50YPa2orrYaE5EH4Tbt
 ldgUVcQ4lVwmzJ6Lx8fvluaTa0zb9gjWoaUL2njRNngFCoyb9wAKkw+dBLmWHeqSKZdX
 N11scntUuBCPlvEzM2rq9IKPTwGdz2bKow3zMILN3gf8UDXPZQgIX/oqRCCsGV0+KwAx
 r208UjtH6fiFPoJIwSZmC9ssR9lqYk6ljSZYtnAKrPxmnI93vVgq7erxmZba1l7IpfAF
 7zRW5zvvMCcybTPR3EQRls3RlRE8W+BJMZxP4NTtqOp+MMZYNoLAl9GqanAsS/ZbwtHY
 +5pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5qrevQLC8AWgHUO0XERn4UV9KXd470se+gtJ4TaXpS7VE+JtG6StHRNmYU1C6gzyECSFWyH7kPzVVT3W2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ecd7X/+aTZvtYH1Cfb4Y0N5oAGKpJ/HN8XbXshmpGUyS8MaxV
 iQke9hNR4GzVXemckXoGn0DPbkYpZgpttVKolvdROWSe3MN1MglcmluoOr/Ylq0DZXIEE/KVy09
 ZLyxaDAXS1AdjZU5vsQCKWBKj7isv0bmhAshm0YVO+6nm5dUFVRYviLJ2XJGWp+O2lWTL
X-Gm-Gg: AYBFou0UqhFoS6YCx9w6wiVmOzJ9nMHExtyksZx6IARcC+/qP84nU2GK1L+HEuHLxve
 EIASCfx9jR8A79uK0dbHosj6vfgWMelzIS8S/FlpO2MKCX6LLgIybUdiwYWwu0IK+B3wvfoVnzV
 xiRHjO5sbVq76UMyU86JfVpBKqXvWwX2OcnSQ3VvW59pHnCvQGceHbggJkJzouzbeAeqvxzzojK
 k47KW3HNFQFAwaDlrGIts6e33Pjb8lIJmBwJ9yucAA6ZhaqIdlT8LpUIc0o+ipC0CiZhud4DZaI
 fXOOD+zxrXatkV7KqMmCmDgRVypwGmyfRk0WueKAnq67jTsA79MfGwXjdX+xW2zIQ+cKBBIUZ6/
 I6OtAIqj7Ir6urmEXwyVznOVG4yttBOCe083Tj+MCeq9XuG/cCtpXg5hccn5X3VNpKWOUsHJipz
 4Z92dfaTl2j4GsZX3Kdyoc7cDOMa6YAdPYjpSgCS+B9luFRxvxoHJzJtNXw0r9J7e+JhO8rHR2d
 NekO3a1JXDFSkYBqdBfdfqThRtoQVoPjLJVt/EUUufRjnILRuQl8aCOa424fGd4dubHY1gHyLK/
 AyPMJrISkJmQC/X6tWzA7BOGO6beiUTvi2ay/n0zmZdPYbBidvbxfX943Qyr576KVnuzwC9R7TC
 20dHh1wR5p0EPqYoGT9ZeROaq0mMqmms/t7/KPdztjhxF0VAuTvsc7DUQ6u+/WGCVbP/Eq+DheE
 9Kou/U9QW6fBXk1Q==
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4ac18b7dcdbmr286772635e9.19.1793698786542; 
 Tue, 03 Nov 2026 01:39:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm42657935e9.15.2026.11.03.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:39:46 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 09:39:45 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: be5e142bdaa1060f0fe42dc8f882a913d8a4e378
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 09:39:45 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c0c7fba93efd29a37e473b609bf4f1354cec656-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOAzh-000000006ym-0zqQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6596047606978656457=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6596047606978656457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pymialDHEAc="; charset=UTF-8

--pymialDHEAc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Gerrit-Change-Number: 20=
46
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 09:39:45 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--pymialDHEAc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2046 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 09:3=
9:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--pymialDHEAc=--


--===============6596047606978656457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6596047606978656457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6596047606978656457==--

