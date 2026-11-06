Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F9606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SIVhmY5t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m+az/O72;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KrD9M+Lb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WuGWMrAb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=imW/onLR0W+hjJnrDmfhBAI3Rdxy9s1XXzX6EjxIcuY=; b=SIVhmY5tEh86PMJr0DF7/zQXfX
	RHtKCMdodSU4yLC/FqjFNGzirWg5CqJB85BZ+eIkRkXEJbTGOVyZzWlIGYB/1poMNpKRk2ALD8dLQ
	Ox7MK6q7ZwapHw6amEVodX8cdddvYzya7GjXnnxHuwwlUfQIemxktCD2zFyL/v1Ldmcg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPIgz-00000000216-1OdB;
	Fri, 06 Nov 2026 12:05:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPIgy-0000000020u-0D8g
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ChDuXKXn7oxJrngE9NyzKdno72asRiX98UpQK24mNRo=; b=m+az/O72V4myaVmGSOmUk2b/Z7
 W1IRMG1VXN8hiCwxmrrhpifastmaYNJL1F7HRsrPAVvnF45MjR8NirbY5qGDh1pVxXSvDcJTf+vhm
 BS5E9/Eg5n5+K7WVUtdrWgKnNhhDdG+rR8PFOd8Gzhdw4xSFBlzOTRO5EclFjgXmBp3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ChDuXKXn7oxJrngE9NyzKdno72asRiX98UpQK24mNRo=; b=KrD9M+LbnTsQIkBb7DqLuyiFYE
 HAOAdHnYiStzdtHAL4/kXW1uAE74jPTRZ8+yjRl0rT0LiM/IoEVGCgLIBq2kl92fJw70ztXulR/C3
 /b89KZwXg/LaqFim/yrWVuQaOVJqsRV+DzD+NVxP5w1yDQr8TVeDy54tx3LtpzCCCqQo=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPIgw-000000004ki-48N3 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:05:11 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so4654385e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793966704; x=1794571504; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ChDuXKXn7oxJrngE9NyzKdno72asRiX98UpQK24mNRo=;
 b=WuGWMrAbnz7qailBy/UGEVhSepd2ZH+Hrz1+c5baGwcuonfnp4yFUWZjXiIr74ogMm
 cmkRLsv5NLvPgOWuta2v7OAnF5mJ3w0p4jjcXmXHx47+YH4V9/7vrRyEQZnU9Wk+5ypu
 oesS0Xkl8FPMdhDFECQ6SPgpqe8fuOhLjyOQt341fUt8soaB0EcwpMQ4IQhok0MJuPgl
 ZPlba4InSHbKk7/mbwFbIcRou7oeBXHjxV9IQ28IF4cCVRbGEZrWl9Lk3cYIvwIJ1i8o
 XgJXZgCpnOkDuC4kD+rPcdqstQnN2B1pmMld0OgdheBhvuGNIq/feTUToMVO6dQvaqrm
 19EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793966704; x=1794571504;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ChDuXKXn7oxJrngE9NyzKdno72asRiX98UpQK24mNRo=;
 b=JemvTEUc23BCYSnSiLEf+EmEMav4/Bv/MzJHlV0soAx1uELA8U73vjBbQstj2hf32z
 nOeR0v3YedSKDeENdx0FfdV1179gLa7Hol2Rs+VbrB4UeSyfe3xKDM3M0isFxKSsBZKf
 d5ueENGuqpzqqexAUg3xhS3uRZe6ejgXomvJ4ku2xy0l9Jr98TkU+ruDb3N9uAshREkK
 /FJiQ6t6b7JuTEO/l68qgX+jnTcx9GiH0TvqAe2yRthm/JJTMh4WVuGbxVL5A4ArYI7o
 VsaoMyym+F9VJaxZpC+AudzZkjgyJbPFGZ7xDtRIgbseTnwLtp4nzZuBtUoZJjT4Sfwk
 Ur5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZCQVLXY8rErsUVU7/RNjZvHsUKT19pmnE8az4R70phHOg8u0AiPtXZPOe0LkL8c1LYChSWzAi6UExjgG9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9iSjYHa1kDcqnMCum15TTCuWgIqtsqtp2wRUtltACjU2ExC1Qn
 GPuNjckaKAbjjEfcDbu4Hweh0lhnfT6vcWXpmu1/9JlkkrhfM1KhLr4Mc8u48AFNBkSBJuDFGRl
 7Q5e//O9DtMYI6ouYXko6ex4pR0LP4ZEil+JYwAlog/QnAMub6uHXPv5laO5aMUNjnKZn
X-Gm-Gg: AYBFou0GH5yqarHFr+suuqobd4fa7LpXfNKAdTHJ54ImcyTQwMEI4bLKmkdDcolevPc
 X9yv483fM2ZLIqhydHpmgELF3ICXAw+mKZyaDEaMbbAymDqWLT9/Sydz084HwJRXJOc5VrQcPEr
 rh4ak3khbjTOEAcx3m7jlbmvA5OffSiwvBYLqw5u2C5Ea/6P5omAgzIneWMs9fLf+tEVlTtE9nv
 lk5AI3SGyrEqj8B3zmobh9gvbi6juCvZ+tRTIkiUslRs7Acsor3BFgzAshNXHvbKJWY7YZqyACI
 QhlYdu+o8JsGQFpOBFsUdEDSCCdZj7RRXaxB641pkY4MsPy8IqlAeALV/1/kKE8TkdsvOVqvgpc
 BMSz1/+UMa+KzNYILESw/NQD+GjpkyzSnaWpdsB8SXMlhRFKHw2qAqlBV6yZEWnLZOobIyfejP2
 bkNt716PWQbH8HO5aQhsOLGpwnslrh1witM/iLWmim8TzaNcwBExQBvEOdReRW9HiyAT3az7l6T
 8O4hlFL7cLTokIRtN6hHx1JBBtNjvIYNO1BhsgJbATuxunUeP327ovBGpuI9cT1Qw51hyYUaiQx
 fAYKi964y/eqLc3cIxdeZjlVSLwQQs25KZlXBwJoKCDY1a2qhpy6XHIySwFYrJl+REY5RaEOgSL
 b+ncwK26JdqnZ5L/2C0LK047GAhDWgju2GNPW/aPv5c9hAXvk5KuBM8veh1BASnvaY8JDxJ3luE
 gSLKd9LZPK5QhLBw==
X-Received: by 2002:a05:600c:19cf:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4b6de789199mr39632705e9.11.1793966704050; 
 Fri, 06 Nov 2026 04:05:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7701bfasm3408438f8f.40.2026.11.06.04.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:05:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 12:05:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 6082437e8d6fdfa1415ddd74f57c8e4897a78ade
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 12:05:01 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <568b45cbdfce1b44c231113aa9a5309b768d9ceb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPIgw-000000004ki-48N3
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Max Fillinger <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============2891599594946392812=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2891599594946392812==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uo//xx2he+s="; charset=UTF-8

--uo//xx2he+s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

R=C4=83zvan Cojocaru has posted comments on this change by Ar=
ne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail )=


Change subject: Implement initial packet reflection protection using bloo=
m filter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 12: Code-Review-1

(7 comments)

File src/openvpn/bloom=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/fe47543f_a0eb31b6?usp=3Dema=
il :
PS12, Line 140:     data =3D data & ~(BLOOM_FILTER_BITS_MASK << bitoff=
set);
UBSan flags that this is treated as an `int` shifted by `28`=2E Fixed=
 by casting the mask to `bloom_counter_t` (same at line 142 below)=2E


htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/70807cd3_2b7f2b7d?usp=3D=
email :
PS12, Line 155:     size_t bloomfilter_bytes =3D bloom_get_filter_b=
yte_count(size);
ASan reports a heap-buffer-overflow with `bloom_create(1, =
1)`=2E


File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/30/comment/21ea9489_7a201d0d?usp=3Demail :
PS12, Line 339: 
The only =
change in this file seems to be only clang-format churn=2E Please remove th=
is file from the commit=2E


File src/openvpn/ovpn_dco_linux=2Eh:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/7381dc7a_4d4cf28c?usp=3Demail=
 :
PS12, Line 1: /* SPDX-License-Identifier: ((GPL-2=2E0 WITH Linux-syscall=
-note) OR BSD-3-Clause) */
This whole file seems to be nothing but clang-fo=
rmat churn=2E Please remove it from this commit=2E


File src/openvpn/refle=
ct_filter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/261b4=
f8c_f6735f81?usp=3Demail :
PS12, Line 8:  *  Copyright (C) 2023-2026 OpenVP=
N Inc <sales@openvpn=2Enet>
Why has the year here been changed from 2022?

=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/ecc5e00e_9f7fc8d6?us=
p=3Demail :
PS12, Line 136:     memset(&ret=2Ein6=2Es6_addr[15 - bytes_to_c=
lear], 0x00, bytes_to_clear);
ASan reports a stack-buffer-underflow, where =
with `bytes_to_clear =3D 16`, the memset writes to `s6_addr[-1]`=2E


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/934363fc_a4d36691?usp=3Dem=
ail :
PS12, Line 425:     if (bconf->inet6_tiers || bconf->inet_tiers)
Ther=
e are tests that pass `NULL` for `bconf`, so this would be a `NULL`-derefer=
ence=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a9274cab7=
fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 12=

Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Max Fillinger <max@max-fillinge=
r=2Enet>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 12:05:01 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--uo//xx2he+s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwab=
e=2E</p><p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?us=
p=3Demail">View Change</a></p><p>7 comments:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/b=
loom=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/fe47543f_a0eb31b6?usp=3D=
email">Patch Set #12, Line 140:</a> <code style=3D"font-family:monospace,mo=
nospace">    data =3D data &amp; ~(BLOOM_FILTER_BITS_MASK &lt;&lt; bitoffse=
t);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">UBSan flags that this is treated as an `int` shifted by `28`=
=2E Fixed by casting the mask to `bloom_counter_t` (same at line 142 below)=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/co=
mment/70807cd3_2b7f2b7d?usp=3Demail">Patch Set #12, Line 155:</a> <code sty=
le=3D"font-family:monospace,monospace">    size_t bloomfilter_bytes =3D blo=
om_get_filter_byte_count(size);</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">ASan reports a heap-buffer-overf=
low with `bloom_create(1, 1)`=2E</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
0/comment/21ea9489_7a201d0d?usp=3Demail">Patch Set #12, Line 339:</a> <code=
 style=3D"font-family:monospace,monospace"></code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">The only change in t=
his file seems to be only clang-format churn=2E Please remove this file fro=
m the commit=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/ovpn_dco_linux=2Eh:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/commen=
t/7381dc7a_4d4cf28c?usp=3Demail">Patch Set #12, Line 1:</a> <code style=3D"=
font-family:monospace,monospace">/* SPDX-License-Identifier: ((GPL-2=2E0 WI=
TH Linux-syscall-note) OR BSD-3-Clause) */</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">This whole file seems=
 to be nothing but clang-format churn=2E Please remove it from this commit=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/reflect_filter=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/261b4f8c_f=
6735f81?usp=3Demail">Patch Set #12, Line 8:</a> <code style=3D"font-family:=
monospace,monospace"> *  Copyright (C) 2023-2026 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Why has the year here been changed from 2022?</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/ec=
c5e00e_9f7fc8d6?usp=3Demail">Patch Set #12, Line 136:</a> <code style=3D"fo=
nt-family:monospace,monospace">    memset(&amp;ret=2Ein6=2Es6_addr[15 - byt=
es_to_clear], 0x00, bytes_to_clear);</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">ASan reports a stack-buffer=
-underflow, where with `bytes_to_clear =3D 16`, the memset writes to `s6_ad=
dr[-1]`=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/30/comment/934363fc_a4d36691?usp=3Demail">Patch Set #12, Line 425:</a> =
<code style=3D"font-family:monospace,monospace">    if (bconf-&gt;inet6_tie=
rs || bconf-&gt;inet_tiers)</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">There are tests that pass `NULL` for=
 `bconf`, so this would be a `NULL`-dereference=2E</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?u=
sp=3Demail">change 30</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/30?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:no=
ne"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Fri, 06 Nov 2026 12:05:01 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--uo//xx2he+s=--


--===============2891599594946392812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2891599594946392812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2891599594946392812==--

