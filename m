Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AD606A33A
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BmIfOOLo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MrqcuJQc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZkzW21Kz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hStuPCbA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2fRxavVcXia2Bsp0v9RZzTLeGwGLITX3zflohM55gMM=; b=BmIfOOLoMtpb7GQO5KQSemGfNZ
	3dmA2bHVKKRyi9E+PzoNniNe9C74av9E8Kwf1DCwodL4VaUr/YrFuVJxjPS4cXTjsGyTiEUJaYYXv
	wFxMAzq0sCpj7AfND8U5LG586fatDHMAhxkFswO3Kw8yMHUUDR7HT2+4dhVYq1jRZgVo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiq0-000000007Ju-2yU1;
	Wed, 18 Nov 2026 16:48:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTipy-000000007Je-3SJf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a6Wi41hoNQtDw76RzZfg5PuXLyndqUorCYr3KE0rSn8=; b=MrqcuJQcaCrvxW35JkwScrfnmq
 MLew1ilwbZlRMRWomN7QUqYexqdlAcWvjQw/3c1ooOpP32HGsklcs9EqKPSpE1ozSPIHfVGrBP5dV
 b8K+W7QLTZNUcs5rB4T3VdDELXjBnyAt67pE5swhFyguNC7bQ7jr7oUkCBQ+24Y/TIPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a6Wi41hoNQtDw76RzZfg5PuXLyndqUorCYr3KE0rSn8=; b=ZkzW21KziY5qzAHhJ6o2VZAJiz
 HYGhoozFVwwEOdPo0MPjWM+qDRyz3KpGG6rRlEHRbPhlqY7+GWW6xecOO5/0lQtoYOMNKJJ9HYNo0
 YivdgWEoPbULIzMEWZ9q8JiTvhltvdVO2Moqq7q3f1YSUniTU3AEje2k47cxmtmuojPM=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTipx-000000004X4-0Iwb for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:48:46 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso11070915e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795020518; x=1795625318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a6Wi41hoNQtDw76RzZfg5PuXLyndqUorCYr3KE0rSn8=;
 b=hStuPCbAUSAyrevSAEv3lCXuKuR31kU5RTjtLuuDDiSCXnbBJ7sZl3qgeOdBAaq+ie
 9AATs7MOI9R5Ee6bygTxNlzSAPeVR1/smQh36pL6ILfUt/FDqfF9jXJGUcU77o3ew28D
 M8nleGzUDcjbHLWYTcDPEldMXoOLuD0ir205glMnY5w7TZ4a5/4LjcU9Fj/+RWpCx4cf
 4NDKK96pYNJXnWmlTIQwGi9oGKOx+4xYA8NSRyljxxTv+qNXFS3AMtXslSmwKg+Fazm1
 Druax2u0+WoLaU2yB/n9jqycKxii9uLUwagfVdcesYQNrK/ISyA++Lu2/PN9fOV8KPae
 Mp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020518; x=1795625318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a6Wi41hoNQtDw76RzZfg5PuXLyndqUorCYr3KE0rSn8=;
 b=UlBH8HFHsc/i8Z+0b1Riqn+KMlpHz0pUqGqTysI/4De+S7Jix+pPN/bG2f8vV996Gz
 +HOmfvOf4MVDguETXAnuLMj8Lv5TcHTewcFMyXt7SzuQm9IPVerx0u4VakS6lP1c/17W
 h1SQODV1FywmdFReoE3RQ2H5MsSfTc4quihpkDMRB7vbR46cXgVY7kCU9bfZ+wfFVOZy
 8pgOajKmEW/5yIMonVSQ606aFk1Uz1fldcxMxgkNJqSExfuPJEn2fG+PdEYwDI2XuVtm
 UxNUBYMoNh5L9TKvdBhKzfH5rOfMxJwjBl3CaCGtVrxcwU0my3Ws9ebIhaNb+U4zD3BI
 s4rg==
X-Forwarded-Encrypted: i=1;
 AL+hErFe8KvHSnXX2up/ihYQjJzxeA/wIUFLMxn0tEvy3RD/HYp93JROiqeAdg0MMJ8vi+vjsrcpOu5ZcA6bTA1D@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9OF4fYJqSF3kWeYh6KxOeGkJBZgxZNO+f63NtbpECDWUrd0+uw
 XnN7sJePFuV0KM1HlpJLH2ESnWsPFe75u097eBBogZtcX6ifz6ZBGW87DyVbhJiB1fV7s5lAiJo
 m8edEKck5DD+xOC/Sb4n67RxGfWrOOYqRY/6cyO8hwU8rJSpJ/aYwEAGVfg4zI307iDKl
X-Gm-Gg: AYBFou017IA0G4WDnvPNA96j2KE5e2LwEFjHsJyEGPxxrELmpVOm7pNT/9nTlRCqRxJ
 VFEg1DAxaRSAfEo5lu5s5qy87h59sQrsu+5zBF+LXdL5Meg+IqwH//rXyNfxm5izJHm0fpfY/m2
 j+GJloQv0Dw2tyckPHI1VpxquIZ84gy4KF0sjWx7tVf+pWo7GwXZ/+JOMhJHxnScpJcf2SThv5o
 3BkxOPgFT5GCpDJxa85N9J23Jh0c3l+UqbRHtGGTcwRncVhi4O9fpBzgvPBH8v+5TvG+jymzsri
 COihatw1XwSwBRYIevZ5UEyI6TfAaRgQp5Gc6xiGaczA7ylNqUZMzCPBvAfruixe7bX0OVdgTv0
 1hFcE7r5xNFNsHftW1arvHe3PZ8qNhGsd04b++rvDPVS8n2GrqKQWRGYcnK12gsbW+vDwPqRGbx
 YOvN5VCbexNoYwzR0n2VREFKmw3GeVhuB404Y0Np7dNAGXPN/4dZvtMcrNnBDurRYKO/4JPoBlt
 /0K4JbSse18x7mmfNLYQGXAIEXGM5N9FASRect6UNUjtCLCLMsa7z8kRr/WV/LRXwh6Fx3d9mr0
 odoWK8aBaiq8sA2BRjrsu2RbYV0iOKeQbayzEGfGgieruX43sQ56gM+xV+IPASNoeZfJdBiIJXS
 1frCIg+G5PY8MMlk49Nz5azyTvFSi95RbICc705nxhS0skPHm5gVTlxcwJFFBINxvEyi/bUSHtl
 Musq+GeuI0+VXHGVk=
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id
 5b1f17b1804b1-4bb7da28927mr70003395e9.26.1795020518342; 
 Wed, 18 Nov 2026 08:48:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8324c811sm1305195e9.2.2026.11.18.08.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:48:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:48:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 5a1090cb382ecdf4f80d611cc42553934488cce2
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 16:48:36 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e319395729ef66b019d772c7deeadd82dd99f348-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTipx-000000004X4-0Iwb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4451696820825747269=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4451696820825747269==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gfbhWxjOWBY="; charset=UTF-8

--gfbhWxjOWBY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail )

Cha=
nge subject: dhcp: locate the UDP header via the IP header length
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comm=
ent)

File src/openvpn/dhcp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2209/comment/1ad2e11d_e400ab5f?usp=3Demail :
PS1, Line 160:     const str=
uct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);
> Are =
there potential issues with unaligned access here?
No=2E The structs are al=
l `#pragma pack(1)`, so member accesses are unaligned-safe=2E The UDP offse=
t (IHL * 4) also keeps the old 20-byte offset's alignment=2E



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd7=
84153367e4fd
Gerrit-Change-Number: 2209
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 18=
 Nov 2026 16:48:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--gfbhWxjOWBY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dhcp=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/1ad2e11d_e400ab5f?usp=3Demail">Pa=
tch Set #1, Line 160:</a> <code style=3D"font-family:monospace,monospace"> =
   const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ip=
buf);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Are there potential issues with unaligned acces=
s here?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">No=2E The structs are all `#pragma pack(1)`, so me=
mber accesses are unaligned-safe=2E The UDP offset (IHL * 4) also keeps the=
 old 20-byte offset&#39;s alignment=2E</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail=
">change 2209</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
209?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2209 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 18 Nov 2026 16:48:36 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--gfbhWxjOWBY=--


--===============4451696820825747269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4451696820825747269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4451696820825747269==--

