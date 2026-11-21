Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660C606A32C
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LQP1i+V8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MIvOa42P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M/10mjo/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K/xOVuqn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0doy0jt8yiJECgoAZPGTu2Bx4x2DLVZ5d5OXdSzbB+8=; b=LQP1i+V8k9LjtYm/VeT/cmL30f
	aSKp6ud3UKXbkHHJjy8kuTo3rhEIv7L3CNptZYiLEpVDo97Dm1egxztT47u4a4q0328BFH6uJiYy+
	+nQNoEUpseAEA062Mxi0deLFZjVdrPJ+rMVb+S0TfE7ChFKtvUr9g33FPUO/dkvjr/lw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUmzf-000000005mp-2lpM;
	Sat, 21 Nov 2026 15:27:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUmze-000000005mc-1crc
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 15:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jGV65Y/JJDmza7Hsbe18kSGCUf5DgQzAeu5RGrjRITA=; b=MIvOa42P3XqQU9bFsqwPRfcZBT
 pjy1JXrWRbiZhhXwYVmiCNNzNn1rD0d9htZ5FcdaRnUW7rOrvwxbWeQFJKgsOwmRRRBaanC8hd7iq
 DKPDb4+YAgV4ox/CwJ5vx9M0Uq9T91Ls/OEw+iEohJjx0QkFhknuQOy3Llf/NS1/vMHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jGV65Y/JJDmza7Hsbe18kSGCUf5DgQzAeu5RGrjRITA=; b=M/10mjo/tmgPV/g9e8jwUpbJf3
 uhq/jOV3CHGko9kVNWKyHf3tlOg8pZ3Um1JIjQb64paOIIExs/MMsN1VEek+y4lu/3oh+c2Q6UMYS
 gKQZroeM4LgAGoRfuymilau8qxeWJj4iYAKi32ESVtn2cnhIBuELJ1F+uFzqlmDMYQv4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUmzd-000000000g8-0zhG for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 15:27:10 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so17052425e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795274823; x=1795879623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jGV65Y/JJDmza7Hsbe18kSGCUf5DgQzAeu5RGrjRITA=;
 b=K/xOVuqnGTgKROKKJ22EkxIhH6vOKIUH+9n283cjl0BdvmkGbztiRD5baFjczTP6Aa
 l3uFoeqWNU3GhH/Po0dtQq7Zk/6NKUsL5T/8kgvCQKUBdAgJUAIHZOH8R4/8wcsiUBTH
 rbRHI8bAgsXjP8x08YiLcKS3P/4BbdKwkj/uGkGyTj1cYc6UddZm1oJt/41+IWeaMiO3
 IaRS1A60cB9LKWwLFbUQqYrVv54TAnz7zXUvJdlqVPJOumPUeBd27l7FgHh0Cjeuuogw
 TvXLgJZUOzlCtFziJ8/LFuc6p3l/zdGszIGLHlAZWTnp/mlxHB8b2X6qgjMCHVafzpct
 waLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795274823; x=1795879623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jGV65Y/JJDmza7Hsbe18kSGCUf5DgQzAeu5RGrjRITA=;
 b=XQeLCXNVZv+Evz1Yvqf0DbkDVY/4xvVz4OqSvlKnnxD1eSCovShRfBk86D7hghXwOe
 hCI5mo1urIsVhr5Tm27y+kZTzm+eu1WSGLBzv+/hJT335jNOC+8s9JF46g6WBkFC7JAC
 SRB7F75BvbYGteWbV7Zmj5pXdur7LJZ29iNyoS483JBGj9ShRvdQsTAif33CLr0kz4eB
 Qjmj1ua9h+gp/TBRprSUFYLyALIj7bTe0dtRnwKlrWFoPe4pDkgRVnrraCwitm2M8Wgs
 xJWAZMCh6ZPUY4xoDDweGrBxD3fCdqdDJfe41sAtO6UWE4+QUGe/4HM2MWo0+VQt20L6
 B9dQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHV7UNUyT88R+8kPe9PXbBJ4PVoBsvfzQ9WjKkaheNn35334uNG5eYX++EWyXNmomDS+sIR8y1q3y5vVqVX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+YDmKYL4hyyjltGVDaJit7hKlAF674xohQXcpKmMaIJ4qGtKa
 wywKky21dDre4NMeql7EJCM32ZYSz4G/qRFTa9u8Thgv0zV8zaoIdOrtM8lFVXpCSUMQ9PUmCde
 8nw9idhpwSewGYcwip6P1336qmG28DEZdBEhyuOfxJYZxqtXNv5/V3BIF7wX5wJ1gkh0S
X-Gm-Gg: AZFdTZdXThuk375W4JqywyTyvkA/3CzVrnaDQH5L9mjoyVZGqgZ2exHBwUv1h6v0U58
 pNwoIIS8SKnYNobrBT6xYE8kqL+mSlpFKu4BXwtojNDHyY/1kramLA2u8s6BPTsv18pNzgCeo1B
 OGZ/ks5QD1JGyXNFiIqO0ZHsKm8JYpbkAehTjBYW7aHDdrEeaXdRpf3oJQac8dlFchaCTwZOhua
 lGRIwCziPZRszceRgl2/tLO7/7OZxKvHNVmY9WbKRAIIY7vZ20k5Z0Nt3BjXmOCQ024xXgwx+TI
 beVj2mRU+tGGluOrZ8mOoorH4kvuyjHGw4PXSiDc//KCBD/uBaTtQ+nKCEZjlYHZM0fgmyr6W2y
 wt3HSZeafqjw4gKfSCO4UFudRGUA1UNfWddqpYwYXE633Bl3KifCzlQmW+EHwbf7fdsTbKLz3s2
 IiD5Xy0WE8m2Kmktt9j8xxiDIR91zdlRqqIF8d7SBhTaLupDVGKwxpxpX0noj7hxGCTKMOO12YF
 twWlmfEYTzpzpbicV3LcC6JBVtImRa+3kCG0fbu6uwNcJbNNOpob7irZjKPsU4cJ7UQzHIyx/Dz
 yc/agUIjr8H46vQgMLvakB/8khPMR7x1QNc+dm5swYNEOtUOI3AwRnER6ay+xarNxLBh984Urg1
 kE5Gs+iq45wP9/lelKi9E2NR0Gd7COwvbhO0Kslk7UYjVug715XGm8OjW4tPJIhDjqGwP0HpFCy
 kKc2RwC/rB3Y4bElebxiPzy03bLMSri3kbXHrlvw==
X-Received: by 2002:a05:600c:6749:b0:4bb:8508:7fb3 with SMTP id
 5b1f17b1804b1-4bb8881c3b3mr136310475e9.11.1795274822423; 
 Sat, 21 Nov 2026 07:27:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm253681385e9.13.2026.11.21.07.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 07:27:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 15:27:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: e212b83177d7b3503a280ac35f39e1d5a264b0be
X-Gerrit-Comment-Date: Sat, 21 Nov 2026 15:27:00 +0000
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac86ec37d49fefb32ecd49b7e7fa5e62add91557-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUmzd-000000000g8-0zhG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2727908926552146416=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2727908926552146416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BagkLYrUDGI="; charset=UTF-8

--BagkLYrUDGI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail )

Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=
 Code-Review-1

(3 comments)

File src/openvpn/networking_freebsd=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/bff1b1ff_7b3e3426?usp=
=3Demail :
PS2, Line 111:     return net_route_v4("delete", dst, prefixlen,=
 gw, iface, table, metric);
> Yes, AFAICT it's necessary=2E
Indeed=2E  So `=
delete` it is=2E=2E=2E


File src/openvpn/networking_freebsd=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/4724bd2e_03c38e21?usp=3Dema=
il :
PS5, Line 32:         argv_printf_cat(&argv, "%s", inet_ntop(AF_INET, =
&_gw, buf2, sizeof(buf2)));
when we're here and reworking things to make th=
em more nice, let's do another step

- make this a local `in_addr_t _gw =3D=
 ntohl(*gw)`
- get rid of `buf2` - this was only needed because two string-=
generating functions were used in the same `argv_printf()`, which no longer=
 is the case

and consequently

- `in_addr_t _dst =3D ntohl(*dst*)`


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/6a272e4d_918ca7a6?usp=3D=
email :
PS5, Line 74:         argv_printf_cat(&argv, "%s", inet_ntop(AF_INE=
T6, gw, buf2, sizeof(buf2)));
same thing here for `buf2`=2E=2E=2E



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e6043178935fdd05e6ea78c4=
11dac5decb7ac64
Gerrit-Change-Number: 2153
Gerrit-PatchSet: 5
Gerrit-Owner:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: S=
at, 21 Nov 2026 15:27:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Y=
es
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Commen=
t-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--BagkLYrUDGI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 5:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">=
View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_f=
reebsd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/bff1b1ff_7b3e3426?us=
p=3Demail">Patch Set #2, Line 111:</a> <code style=3D"font-family:monospace=
,monospace">    return net_route_v4(&quot;delete&quot;, dst, prefixlen, gw,=
 iface, table, metric);</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Yes, AFAICT it&#39;s necessar=
y=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Indeed=2E  So `delete` it is=2E=2E=2E</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_free=
bsd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/4724bd2e_03c38e21?usp=
=3Demail">Patch Set #5, Line 32:</a> <code style=3D"font-family:monospace,m=
onospace">        argv_printf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_I=
NET, &amp;_gw, buf2, sizeof(buf2)));</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">when we&#39;re here and rew=
orking things to make them more nice, let&#39;s do another step</p><ul clas=
s=3D"blocks"><li>make this a local `in_addr_t _gw =3D ntohl(*gw)`</li><li>g=
et rid of `buf2` - this was only needed because two string-generating funct=
ions were used in the same `argv_printf()`, which no longer is the case</li=
></ul><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">and consequently</p><ul class=3D"blocks"><li>`in_addr_t _dst =3D nto=
hl(*dst*)`</li></ul></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2153/comment/6a272e4d_918ca7a6?usp=3Demail">Patch Set #5, Line 74:<=
/a> <code style=3D"font-family:monospace,monospace">        argv_printf_cat=
(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">same thing here for `buf2`=2E=2E=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=
=3Demail">change 2153</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2153?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2153 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 21 Nov 2026 15:27:00 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>

</body></html>
--BagkLYrUDGI=--


--===============2727908926552146416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2727908926552146416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2727908926552146416==--

