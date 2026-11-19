Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC5606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PPvFzmST;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K07ABXDT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KhHCWxLQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tgo3+9um
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Sijd1eJivQWk23JvENw+ZynB+UQhKXGFY/jI/C1M4BU=; b=PPvFzmSTtllCFY5XEc3HERMmpz
	qtH6qdJkKOqV7gi03E0KG3D92/MLCGeBwWmzcfe/geWkqhEHexuHixKjm6yy/xtZ3T5WSOROB3OtP
	IVFMqzTFpeNKLjenzCXnWtXIShS+ZEzokyO5Rj+WkMo4ApU4Df3cb7OC1uZN2go5lNW0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU9uT-000000001hf-3lSM;
	Thu, 19 Nov 2026 21:43:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU9uR-000000001hY-2UKD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lmsWQ4AbufXas9fBEViBIgq54vPRjoaIstXZJFYAUEU=; b=K07ABXDTZNxjG/NF8qhOVlISsG
 6E89fOK0NwouSFGl+uUzJBlP8ZCyCMANiLNeJWQe3x9wfDDWIXbvPcqkztopzf6WDR33UYUeh4txP
 qZOA2VZrBU3mXXSm5P3CUX/Lpxsrv6spzV1dXwclwoUEb+d0jBorD7TMhNpoc/D6ns9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lmsWQ4AbufXas9fBEViBIgq54vPRjoaIstXZJFYAUEU=; b=KhHCWxLQeDvPQ1TmIF5MGorp2y
 mbEQhqcKLYYfeQfcZjSissCi2KpAW0SWlaDVuSVp64DycuVpmtdLJ7rBQ2tVtHbXbz3aQIBMEM3I1
 sB7D1RWqJyYD3+J9/ACJIPF6Mtn2dY/M/077MioBGt+YjvDxSoICFpgNlTKWe8CdY46Y=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU9uQ-000000004n8-31SY for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:43:11 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso1805195e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795124584; x=1795729384; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lmsWQ4AbufXas9fBEViBIgq54vPRjoaIstXZJFYAUEU=;
 b=Tgo3+9um/UXkdpuZE3xmYoGjO3cn9ySlgiH3y9dsLKGTSPf76SVrXIgkxP6FbJKGjq
 k0lemH/g8a1Obapo7mkntTsRVoNASKwZjl9cOor1QUoELb/C41mt0b3HxVtNCTK6mSyo
 p/spVhZPjeSWaXgAsH080Hc5UclwmWF7XYccZrFSiCfEBVG4lyXisBmFr8Pz6iPtp1JB
 LL0HNatWbicspdsjY/cLyOv0+5nZ8BfDJKovrWPXuFPGzgMKmKi8wJzARXK0669lT3p6
 Bi7ZfPTmakgGnt6tuKO2ELYbGDM+xJ2n7SanJKWXXijy+zDLr8N+KUlhErlPUKowblbt
 KZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124584; x=1795729384;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lmsWQ4AbufXas9fBEViBIgq54vPRjoaIstXZJFYAUEU=;
 b=xA2C8xnLFlDC+tBbkRvT83I+oil/1eiBQqbyOgXEEGVds+pRsZQ/HBFX0l3RU1z1xL
 zXGd1rbbKWmu85ec4mvdAUQd4naK3EpGzoVUjmQ5roVJ/NuyVr1g1guZtdNYP5hKPenx
 JUqLMLC+DYnYZXG8TXGJxyspPyanEy2bhG/50IpgZjraSNjnhgQ4OqomEYH2rbRZUyjZ
 GMO9azsdRhgcG0q09K42SGDZFIp3AA8A/2EL55DaY0IoLvENUBhfYliipvNQmxm1TK2v
 V1vP0XLe5tSLO5cdo8c52wgCRtZV5C2hOuq6iGqmJTNgxB7DOqEQBS6TuaIYyQm/PpUs
 ++Cg==
X-Forwarded-Encrypted: i=1;
 AL+hErF2GIGMZOJTjc6/PekT/xM8efBFYB7aTF9av6PxLRF0if+5KdV6r2US9pAMeIQtamn1HgEVFXs5wrNkgAo4@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/kXMCHpVGRoJnsFXSu7UC89tQkQzq8VM9ASpbIjsut5TjHfiY8
 houEJndQ+OWl4nZ3Ziddj6hPRGf0WUkU2uLB2Il+zh2esiakLbVLlw1QwDPGRJGnGoEymry7JPO
 dSeiAdHsJkZrBkgeTZHd06Q4bnta4muM6FHZMx8/SsyNPn0Wapn/TzataZkSlsni2UXJhtr7/20
 /dKQehMw==
X-Gm-Gg: AYBFou0MAzFV8ccpj1MWLmt8r9TH+uU2+o5eVRS9gxcBzTPa1ggwzp03p2lttjDAXEb
 J2Zd0VaFJslUbr8VHilWJo2iszTJI146QjIjpyAUcIhZmZONnZ+HLEEE5pct7pLY2/IHLZttW3D
 Pn6nU2TVGvH+sLnQP7fQS61lxgAC9oSwVGfzI0ceAOqLYkaT/9/Y2bJ4sUi0nd+y95heSFJGxGk
 37DFW5cau9TnsgvyIK8Omc8nugdZwf5V7c7UzLT+80LHRYe6DvYZXpuG1XypCQDHbrliRcJYW1k
 fvjdAGKZPnnRtjHuFnx8XesuYn65zn2jJRz65qnQntBvbsUPNm5DPiIjRXN7BcT3AFHnhq/E6CQ
 B5hNEH+IfZsbR/W/E3kbj3OJvIb9ooMIh2eOYstgkPdjmuNB0u+idAp5gIZylo/BVpr7Grv3e+B
 ZOGTyr0oWrxRsVvbZLlHqXY7WrmTIqxF5JURCnCjBeq3tGg/Ad1I2FnHIToeiLBP+hIzlPwzuMa
 DfEi1ZFwj5yZkOJ7pWWx7G/i1m4tESWrGjK4kxmIi0foO6gu3mj03PQYxK1DzVKdJhwsBATNL6Q
 nVAKFTh65mGJ8xOr0x/EofL26XoUwD1aQsmQFtTojQOWg0c8c/vTK1CSsNsdP4DUWCjIpA4dA9n
 FNDoG4iDi88CHcD8h3oxUChY0AizdP9e/xIivTsLKxj2UiAAd4d+QprjAb7cD5+/KHDHkwQW1so
 6Bj1gza9SbH8XSqZI=
X-Received: by 2002:a05:600c:530e:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4bb887fe8f1mr21061355e9.10.1795124583889; 
 Thu, 19 Nov 2026 13:43:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm23246855e9.0.2026.11.19.13.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:43:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 21:43:01 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: e7f0d9fd92574b853fe3fb9212e6ed8bb6fe491f
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 21:43:01 +0000
In-Reply-To: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a1287d2f5e7df2b4e4e2b61c4804038a8ed3482a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU9uQ-000000004n8-31SY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: use the net_
 API for routes on FreeBSD and DragonFly
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
Content-Type: multipart/mixed; boundary="===============7247027238444601606=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7247027238444601606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fBlZlt4Cx0I="; charset=UTF-8

--fBlZlt4Cx0I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail )

Change=
 subject: route: use the net_ API for routes on FreeBSD and DragonFly
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Co=
de-Review-1

(5 comments)

File src/openvpn/networking_freebsd=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/9b003d8e_f22588ac?usp=3De=
mail :
PS4, Line 29:     /* FIXME -- add on-link support: iface is ignored =
when gw is set */
I'd just leave out that comment (even if we've had in in =
the route=2Ec implementation "forever")=2E  "Gateway and Interface" is some=
thing we must have for `fe80::` next-hops in IPv6, but I haven't seen a wor=
king use-case for IPv4=2E  So this is not something that acutely needs to y=
ell `FIXME! FIXME!`=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/co=
mment/dc3f5ed7_d62ee3d8?usp=3Demail :
PS4, Line 44: #endif
I'd just leave t=
hat out=2E  It never worked, and we have a patch for FreeBSD 16 with workin=
g metrics in the queue (Github)=2E


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2154/comment/1aeaa548_645455a3?usp=3Demail :
PS4, Line 89: #if defined=
(TARGET_FREEBSD)
indeed, the DragonFly manpages do not mention anything abo=
ut FIB support=2E

Let's add a comment here - `/* multiple fib support is n=
ot available on DragonFly */` or so (and also to the other one for IPv4)


=
File src/openvpn/route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
4/comment/d1a3d85d_caaed14b?usp=3Demail :
PS4, Line 116: #endif
Not sure I =
understand this part=2E  If we do not want to expose `--route-table` on a g=
iven platform, r->table_id will be 0 anyway (because it cannot be configure=
d)

Much better to add FreeBSD support while at it ;-) - so I'd remove this=
 macro completely, and add FreeBSD support to config=2Ec and the man page (=
mentioning that "route table ID" translates to "fib" on FreeBSD)=2E


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/051a384e_6ab3f185?usp=3D=
email :
PS4, Line 1504:                                    ROUTE_TABLE_ID(r=
->table_id), metric);
no magic macros here, please - if a backend does not =
want to use the `r->table_id`, it's free to ignore it=2E



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cd=
bd6885
Gerrit-Change-Number: 2154
Gerrit-PatchSet: 4
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov =
2026 21:43:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fBlZlt4Cx0I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 4:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">=
View Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_f=
reebsd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/9b003d8e_f22588ac?us=
p=3Demail">Patch Set #4, Line 29:</a> <code style=3D"font-family:monospace,=
monospace">    /* FIXME -- add on-link support: iface is ignored when gw is=
 set */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">I&#39;d just leave out that comment (even if we&#39;ve h=
ad in in the route=2Ec implementation &quot;forever&quot;)=2E  &quot;Gatewa=
y and Interface&quot; is something we must have for `fe80::` next-hops in I=
Pv6, but I haven&#39;t seen a working use-case for IPv4=2E  So this is not =
something that acutely needs to yell `FIXME! FIXME!`=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/dc3f5ed7_d62e=
e3d8?usp=3Demail">Patch Set #4, Line 44:</a> <code style=3D"font-family:mon=
ospace,monospace">#endif</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I&#39;d just leave that out=2E  It neve=
r worked, and we have a patch for FreeBSD 16 with working metrics in the qu=
eue (Github)=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2154/comment/1aeaa548_645455a3?usp=3Demail">Patch Set #4, Line 89:</=
a> <code style=3D"font-family:monospace,monospace">#if defined(TARGET_FREEB=
SD)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">indeed, the DragonFly manpages do not mention anything about=
 FIB support=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Let&#39;s add a comment here - `/* multiple fib support=
 is not available on DragonFly */` or so (and also to the other one for IPv=
4)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/route=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/d1a3d85d_caaed14b?=
usp=3Demail">Patch Set #4, Line 116:</a> <code style=3D"font-family:monospa=
ce,monospace">#endif</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Not sure I understand this part=2E  If we d=
o not want to expose `--route-table` on a given platform, r-&gt;table_id wi=
ll be 0 anyway (because it cannot be configured)</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Much better to add Fre=
eBSD support while at it ;-) - so I&#39;d remove this macro completely, and=
 add FreeBSD support to config=2Ec and the man page (mentioning that &quot;=
route table ID&quot; translates to &quot;fib&quot; on FreeBSD)=2E</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/051a3=
84e_6ab3f185?usp=3Demail">Patch Set #4, Line 1504:</a> <code style=3D"font-=
family:monospace,monospace">                                   ROUTE_TABLE_=
ID(r-&gt;table_id), metric);</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">no magic macros here, please - if a=
 backend does not want to use the `r-&gt;table_id`, it&#39;s free to ignore=
 it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">change 2154</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I601454a511c9aac4f37=
d8629b1692266cdbd6885 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2154 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov=
 2026 21:43:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--fBlZlt4Cx0I=--


--===============7247027238444601606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7247027238444601606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7247027238444601606==--

