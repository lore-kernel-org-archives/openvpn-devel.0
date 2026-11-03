Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB455606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f5n4iJkt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZJeE+vgL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ichX4yd2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ADcF4CfU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CYPnABAQAmE4Ek1m2WR0Bz7vXUcvAuMRQGTo/eklBYU=; b=f5n4iJkteWIBRcAw8KtaWtwTqL
	WAdoy2Hze29ljCoVtrsxbg8EjoS+XUJBVjPHpLBqyZmRIy/Wl8y7Dm7Iv32Xo7OC797x7R0xo1G/z
	PdKkJYv1hI5a1RTIJhp0gvrhiJSLS9+lKbG39wGKrmqtozCTrj4yxfb3mCPo2Xtjj5p4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODeT-000000003Ut-1DNq;
	Tue, 03 Nov 2026 12:30:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODeS-000000003Un-0nxG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QYEHdyxva5H7Bfprjm+GnUp9HOxMZwoaaZrLwCNlXPI=; b=ZJeE+vgLALHJ+stxLfRT9kgP90
 TKkHol7qdpXOi84jeVLlc2VrU1cm+nNe/2LTqqHJzbpXJzGLC5KVLlC78Pp0CgMfz+lhA6KQmQ9um
 PbTl7H964INL6C4HTJay6P6hmk6R54+8mQHTED/N6U74teDcdIB4HNPuFK8kAaehE3kA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QYEHdyxva5H7Bfprjm+GnUp9HOxMZwoaaZrLwCNlXPI=; b=ichX4yd2QmfqiXHq4uNRQmqh/k
 D3arDu8tmS0Sij3z8uQJ+fqhO3eHTqM03q9OJ5LgxwHuzV+mPzAzrdpHJB2ja2kIGeK6YftmnEAGZ
 XeGCw3HKPyMfvy834Z+suMDeDe7atCCdknZOn52opYxBp5me1M/gulFJ+be/8n4EJg7Y=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODeQ-000000003TQ-2F69 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:30:07 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2081743f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793709000; x=1794313800; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QYEHdyxva5H7Bfprjm+GnUp9HOxMZwoaaZrLwCNlXPI=;
 b=ADcF4CfUm29XBrNtVidBAwa6DX0GFQrwO4AEn1OIJEpfiSPD4Gt243Vh2RQmaZRaOI
 q+e2jGVxelavc2WDOVdNoyFER4IlVxgMUomG2OuatJUZMGC2dgpYOUsRF0jo2zrBgPPi
 hJaAsKhNdPRbpcLNRkAdSUdo5TDRXCvtpta898YUJhLy7/7ilRzZ+iCUS9WLbPomXq29
 v5iA+7wjBNDy5zAXsF9qwqbXq3jEA+ecagxhVrNdRoku5mt9l+xE/Cw6Vjo4CN4NyDED
 e2anv0cwFFCtxSYz+wMVCILB6EpuQADT+WzPimHz2Q52XiJ6O+DrXWv4JXUL7bUc1ol8
 2Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709000; x=1794313800;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QYEHdyxva5H7Bfprjm+GnUp9HOxMZwoaaZrLwCNlXPI=;
 b=VM1T2QN0vnnabjTbliabZpBtcGwTEghQ1HPdsuTEiuIUBJwI7suof85xzBI2200ekC
 K4N8+aWue2FxwZb57WsIE9WvXxHKoXIwV0qgq2loAMeQJRLYqyhT/OiqQW+clxE1XS7F
 XdDXSujG8eVZhDXtE3Hd+jEpyWI58T4ONzjSOaa/W9+ckSGj1cR15mHtINFOdDSs5bBy
 D8Yd07XI3ZVHL0+r6xpBZRB42+L/qnauzEXIJ9luvCiIzb1SUdMEa/Yqu1DGq0F1eAe+
 qU5oHH3gkue2KbY5oLvy319NlA1SXmCAecChJsFWPZFrH3V+sS5fMR0On+dlarAuoTm7
 c3Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBKXtVj/CcseL4icP/Yn1xcVAo6/b0WuhMClBQ9uZVlPnwpxPbhiTTzFIzxSvZK8AcN+MeZw4zaOUoqQJy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/gKX7dwEWP3cEhiu3v6Fgyk2jFzTtpkaMzZm4ZlIOC7e1N7ug6
 WMk7bb0ugHogfYAo/7FlYF04u/PTcwqc4dDTJSWS1WqLWFWx9EANZH/GXul2It4oudnhHyNw+XT
 YBt++RS+9hRqnjSkhptMtZULp5oZh+iT22EzgqrYcLAlBkXo+hzjTcsr/S31qhw33UuHl
X-Gm-Gg: AYBFou1S+4YMKnVv4oN5c+6aQb65KzHSQUYnrXTqEHJr9g3YGYBGmC6zyKp2QbN0CEH
 ZB14/JlXCzoMjeDpvz3owN7oqPn3sukOsIcpvOglDFh/yIhwEU+Hh9mgm4mE/lNryeBGGKhN8Cd
 p0gpCSfvD4smUvgVfpZAS17Vag+HLvarl0nedvOfb0RbKsNRBNtMHTPbG9iLyaBs/tmlW2grDqU
 YngJeXk72MiSTdGBwamnIKvkOB5/uB7K2b1EuEHdJt+taDcvp7cXht01sXJ7dKuzoBDwv8PMKuZ
 +kC5FK5cZBZBG+v72fE8IQ43mvl+5dV2uC/47Gl8bxk+jHRNdwiGpcn661dWV4UbcYwqDeRrFGh
 h+vkgcqeXHbcyK6H0ecfWeoMK9RLkn3+Vsxz/v4Ayta5tiBt/z82tMEmegBWifE9dOhoJ5gIZKZ
 0sgNw8h1tWCY9pLSixl2ESXX0IvX78EUEAaGCcg++3+va2nsLU4/yz2OS1YbBEgwZss68vTqcQt
 9SgC3b3GCR7rL0F8kABvzPSNXU7xPxfIMyONCib/zFSHFBMTFBmIawm9V2sOzNSa+6jOjmSkcEG
 1WscbId7VhZawCVBVbAQKTnUlhi7GekMREB8p24aiGFEfevGXI86E8FzD8uSXiffxeXa0sUdwXT
 VCwMe8jXjJR23H5wQhONXQWOr+OSTPbS6PRbVhSc2z2iy4r2tMzS2G6ze64HXXf3Jw+5k4PWlmB
 GgaXDWW8ck0iZ27w==
X-Received: by 2002:a05:6000:2f83:b0:48e:203e:84f0 with SMTP id
 ffacd0b85a97d-48e6e2ff7d3mr26068849f8f.24.1793708999831; 
 Tue, 03 Nov 2026 04:29:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm31621393f8f.53.2026.11.03.04.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:29:58 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:29:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b
X-Gerrit-Change-Number: 2104
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2104?usp=email>
X-Gerrit-Commit: 2e4286ed1029e47637279a5fb585c1a3e6fa96cc
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:29:57 +0000
In-Reply-To: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
References: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA0MzY4MDAwLkk4OGVhNzBlODhjM2VjMTMzMjYxMjEwZTA0MDRmMzI0YmJmMDI1ZDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a04fa43ec2dd7bed3d7adcd8e57b0c5bf125a1df-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODeQ-000000003TQ-2F69
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proxy: free
 proxy_authenticate in http_proxy_close()
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
Content-Type: multipart/mixed; boundary="===============1250952510051232880=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1250952510051232880==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b0tjwR4HTgY="; charset=UTF-8

--b0tjwR4HTgY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail )

Cha=
nge subject: proxy: free proxy_authenticate in http_proxy_close()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88ea70e88c3=
ec133261210e0404f324bbf025d9b
Gerrit-Change-Number: 2104
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Tue, 03 Nov 2026 12:29:57 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--b0tjwR4HTgY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?=
usp=3Demail">change 2104</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2104?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2104 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 12:29:57 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--b0tjwR4HTgY=--


--===============1250952510051232880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1250952510051232880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1250952510051232880==--

