Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C200606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NR0GC4X2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D9Dm5gul;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eGg8RkWz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cilOFYyS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IJ4F+He9wucovYq0M8qmET62X07GgPR261LEfIyyfCE=; b=NR0GC4X2ArRO+eP5aY9jglXhWp
	OxApaw/zvpvcWgAtU++qycmLoyWj7qCdn4eBkLAefEHm9govtg97SQC3F48LTnw3eRxOeqYP84pIh
	30Y5OU3ZV42GVZcQewGtxSs8vWHKKioLRf00ZMCHnfUXKAypa62gBczLaYbJXnRCSTBw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUIBB-000000000Fj-3LzS;
	Fri, 20 Nov 2026 06:33:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUIBB-000000000FV-1ZcG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VeV+VWNsX4/bsVWFNNGOViBll6zVIZ8eUxwaaimP1cg=; b=D9Dm5guluxpnWMZTKoZbX0LpEm
 Q5v+6DyNGZXErflq+BY8h2oG6B+z6Eh443B7c5vgzwcyHpPFqrbr0sjcq0U8Yf7BK4NfcBx70Z2rm
 AiUPcSZ528/XuVpCn4dW//bdaO2mukXMcMUJzDEiTOMW9aHTwxbN4/8Q9va2br3/3Tos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VeV+VWNsX4/bsVWFNNGOViBll6zVIZ8eUxwaaimP1cg=; b=eGg8RkWziPepRUUOQ8CDvIv5hl
 0z5iOfAjr9Jqdq/NjFujUpMzJc0kL9c4wpp7bzkIUJ/9vgnOKBUffeJSbTWoXwPKtFjR+igyFooxq
 ULjL2mgv9DA51jTD1dp8rIiEmlOfIGMpHeHYDNbB1wX2RnmKJSctr950IQLCJax9bJWY=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUIBA-000000005RW-1rH1 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:33:01 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so334972f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795156374; x=1795761174; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VeV+VWNsX4/bsVWFNNGOViBll6zVIZ8eUxwaaimP1cg=;
 b=cilOFYySvRB9taN0Kp36Om3c/Tt/U1/WzjA1zGEHS9IGmSYM+nOVgjQIqoAHSoRDHy
 o9yxEwD1Nc9cCk4rptczKFh9N1ERg4Dh2x8wsQ+cIVtlI0AmbSXCdcMFFDpOSg/b0ZPQ
 qjzrsQNa6mdYcut+GAXXh7uEyBr+eShBCQhpeGpKXDgIwZCbylsuQZBibN5gXFyTIrhn
 3CV0z7XNPsoU88UKhOjB5LyqWr9SrPtHSviYpJrlva1NvFmbLkWbIZuAzEylnhcOp6+1
 tgOzg6yLCxsqoh1x9Vfg7p9TADD2HcfxyR3K6oUmdY4s0q52B5NTeCBZxC8CNX3atKhy
 FkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156374; x=1795761174;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VeV+VWNsX4/bsVWFNNGOViBll6zVIZ8eUxwaaimP1cg=;
 b=uvEfz79tP9BHTQ6THsGTYe+zEFF5GiY9RRBpyAUzvvWbBVv/H2QUDulu3di+c9rzsz
 cR8E+kZwL22t0SX1OwwU7ItOJpH3AKhbpCmrBbCC9DEryU8pQz4b31SuA+kAnRz4orc1
 e17qy5ooYCjfQywbyeePwDnOUMNf90u5lyxKclF3/AQHMcs35OfQFT78+DJcXKf2yr9/
 zuYfqJ9Dh/4//e88i13ZZQHtND/tR+4tj3ERjnIW9XQIl7+W87HMp0KE8Ru+6rzBdr20
 qrsSGGzM/rZIRn4GdravSfq9KL01zjjpawVDebP7d8K+B0iZsRFnnnwTlh2PFE3jr0Cz
 0Wdw==
X-Forwarded-Encrypted: i=1;
 AL+hErEjoMbkOKNje4nJYduQp2HpamAbCtPz8T1UB12HLYb2yuDnAIFwg7nsKyB2X3PS1mpRzysz1BHBv9UdJ/J1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Dt0SoIebfddHNMICcTEyHTGvULEmM5uVHTV+pdEjhT4Q4e6VQ
 UytatNHtXi7HyvcWN5KHZw5Qoj/ZxFsr19Y8LwMPBIfN0Iu7gJAP1rjRQ9E9NzTgbsFHvdBO0Iy
 rlLwcwrAKVbuMrjPaAEldh8DLdM5jnK6ROckUpr7tf6/uzcTvnAqcyUfmOiFDJidW41T35c3q/j
 OkuvCFzQ==
X-Gm-Gg: AZFdTZdCHgY640gbB9zHByLNVZv9VZgl/fs/NbRzEorQprG8CnHF5oaveU0olteXtde
 YjhA8/epKqbYPmLC8rmZMyjL1MsI6WIIcXD0tAkDeuBFksx2iEwID7SPts9zchkXZhQh5KnpGJW
 UK72pn4CTC/r/otW490ttIctkOt1kVPJgcMN065Krjco8VZTpqzAh/0XpQQ2BseZGcMAOFHvBzJ
 cjqOT7h6j7Ra4oFQxRXoJ1X04dXFjMzldweCbYnKzTct2BhU04f81QhOXz2G3uxSmdChMuUvhHI
 HVcjqeI5qJp/61gMWDSqElz2JF9R1bm46oNTiXHMFPQIzTUob+thus7DqssSKHdvqX7qEi1kNlT
 enysk/wDO+zV9+Xfj5VY31PKdc0kbN/b9gON1m2ZvpoAs3EHsz367gGXyASt81T77nUJNgnEUR0
 gmnJys8gb4N/+Z2pn7MkzfltYxiEhexm5qtBMQ7COLrfUPuWzbsq2CMThY6dkpwD2HnqGEd0nLO
 DFOkfmirzDMTk6d+b8OPGTkBKEy5te4MKI7CYTBajO3aw7mMKGrBIU99dE0gRTRgh9kJ/C390d3
 cjRDifUzhrTyJO/J8pBHSgdLy9iCipAICFDZ757xEZutW2pBIhAAHDFNzdmeRQP7/x7GVHxIBt1
 72ibxN0DLZpaSY1x8AdlwctUfY7Fe70QgkoVT0ZyxGzJXSczlpP+ntP8NYX9M9PxfatkvOQiVKy
 9VmRbHFWbhxglpPCiS
X-Received: by 2002:a05:6000:47d4:b0:493:8c32:94 with SMTP id
 ffacd0b85a97d-4abb400ae31mr2278893f8f.38.1795156373724; 
 Thu, 19 Nov 2026 22:32:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm3801003f8f.36.2026.11.19.22.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:32:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:32:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: 217bf69bddb093c8126a65d3da5fceb48177a3a1
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 06:32:51 +0000
In-Reply-To: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <553d9eae3b2f07cb3704533ddbf4a0e0c40e88be-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUIBA-000000005RW-1rH1
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3070229920831761141=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3070229920831761141==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wgoRgbo58JQ="; charset=UTF-8

--wgoRgbo58JQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail )

Change=
 subject: route: use the net_ API for routes on FreeBSD and DragonFly
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(=
5 comments)

File src/openvpn/networking_freebsd=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2154/comment/64a05c03_4ec5ee1f?usp=3Demail :
PS4, Li=
ne 29:     /* FIXME -- add on-link support: iface is ignored when gw is set=
 */
> I'd just leave out that comment (even if we've had in in the route=2E=
c implementation "forever")=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2154/comment/a513b2c6_0d065641?usp=3Demail :
PS4, Line 4=
4: #endif
> I'd just leave that out=2E [=E2=80=A6]
Done


https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2154/comment/7af2a430_4be8e566?usp=3Demail :
PS4,=
 Line 89: #if defined(TARGET_FREEBSD)
> indeed, the DragonFly manpages do n=
ot mention anything about FIB support=2E [=E2=80=A6]
Done


File src/openvp=
n/route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/d349a=
162_231a9698?usp=3Demail :
PS4, Line 116: #endif
> Not sure I understand th=
is part=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
54/comment/d33e567a_5c2677aa?usp=3Demail :
PS4, Line 1504:                 =
                   ROUTE_TABLE_ID(r->table_id), metric);
> no magic macros =
here, please - if a backend does not want to use the `r->table_id`, it's fr=
ee to ign [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2154?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Gerrit-Change-Number:=
 2154
Gerrit-PatchSet: 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit-Comment-Date: Fri, 20 Nov 2026 06:32:51 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doering <gert@gre=
enie=2Emuc=2Ede>

--wgoRgbo58JQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">View=
 Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_freeb=
sd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154/comment/64a05c03_4ec5ee1f?usp=3D=
email">Patch Set #4, Line 29:</a> <code style=3D"font-family:monospace,mono=
space">    /* FIXME -- add on-link support: iface is ignored when gw is set=
 */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">I&#39;d just leave out that comment (even if we&#=
39;ve had in in the route=2Ec implementation &quot;forever&quot;)=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2154/comment/a513b2c6_0d065641?usp=3Demail">Patch Set =
#4, Line 44:</a> <code style=3D"font-family:monospace,monospace">#endif</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">I&#39;d just leave that out=2E [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2154/comment/7af2a430_4be8e566?usp=3Demail">Patch Set #4, Line 89:</a> <cod=
e style=3D"font-family:monospace,monospace">#if defined(TARGET_FREEBSD)</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">indeed, the DragonFly manpages do not mention anything a=
bout FIB support=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2154/comment/d349a162_231a9698?usp=3Demail">Patch Set=
 #4, Line 116:</a> <code style=3D"font-family:monospace,monospace">#endif</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Not sure I understand this part=2E [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2154/comment/d33e567a_5c2677aa?usp=3Demail">Patch Set #4, Line 1504:<=
/a> <code style=3D"font-family:monospace,monospace">                       =
            ROUTE_TABLE_ID(r-&gt;table_id), metric);</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
no magic macros here, please - if a backend does not want to use the `r-&gt=
;table_id`, it&#39;s free to ign [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2154?usp=3Demail">change 2154</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cd=
bd6885 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2154 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 06:32:51 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>

</body></html>
--wgoRgbo58JQ=--


--===============3070229920831761141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3070229920831761141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3070229920831761141==--

