Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E9BC55160
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5oweohoDXL+zyriFc+O2EZkKQAyk7BPT5FhpodLgx0g=; b=LNCKW/Sr+qV/GVcH7xjMDlU1Qa
	85d2kt3rvgHm1I0SvNaG1PCWwbmPnBvrropIn3SanYarMFZOTwnSiHnzqmxm1ZaMYYDZktYVmLX29
	EhGkY8iAV+LTxjKMjoE6EHniz00Nxj6WdOqAyZpaZ3WqSPhbzysObkALrO6VU2vtZkH0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPTV-0000tq-6g;
	Thu, 30 Jul 2026 12:02:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPTT-0000td-Sg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OHU6LHB/SnIt7BDKgcKVe5ezslakYNlCsd2Rqkl88o4=; b=l3HmOR7CWEgFZ2j3lYcP9FAy2x
 GXP9+z2D7xiDKJjIesZjCqcyYQBX8RhHcm2UKrYShjPJzBRsphXnsNKMrkvyTs2hprp10kRz+xDgz
 8J9SLuCZG2kNBfFZN0yNdM03ZPypo/QYLi2g2Z5IUd9dAYPpElp1LHAb+neRYZvRHRYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OHU6LHB/SnIt7BDKgcKVe5ezslakYNlCsd2Rqkl88o4=; b=T
 TAmIct1gckEq7JafrixwVaJh2raE8SeiQmTcQ7o+yQucwq34+dMmmK/S6sK/JUtZITq2js/pHBXt6
 Bq1QOH/PKNERIWzjIErHPJfEW8qrAwNuInH7pRjTQ4yj3ORrmT/sRv5iVH7Tq1U5I0S3pmUQa3n/j
 SlrjQ1k2FSm1fnQ8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPTT-0008OD-1f for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:02:56 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1871818f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785412937; x=1786017737; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OHU6LHB/SnIt7BDKgcKVe5ezslakYNlCsd2Rqkl88o4=;
 b=PsJlrlOdluZgfIWhewt84hBM2SeLFEtWmC89404QlKRkR4W9eD1tIHuCsXYdTtXN1E
 LPApeJ9Z9WDEZ3Eh43nPTjVwoWSyE6HbnqVVNI2UcOrOp7+wYYW40ILMURUtYyVvfelM
 bHbQzZg6gCLOLNgDfb+Vz2ECZoMmN1C96uQglmwfcHbtd74Dtw66IUUeGwg+xZZgIorB
 rG7Htt4U5YnMA5HEAPvC2wmwAyqDJtpRBXjlvQa1os+BFyZ/psaKahghhO52gzFjJwAO
 TGhk9Z8VA8tNsAjOcf9i+l4aEzZk3uQ8dkB31ICMCD5M/a8zfnyHtmaDhH51xa2tmcL/
 rxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785412937; x=1786017737;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OHU6LHB/SnIt7BDKgcKVe5ezslakYNlCsd2Rqkl88o4=;
 b=J3M83OPcyIqNTRzgwwrfwI78Ees0mMkPQQhq8DhyVeieDRZr7HFBJS9uBlcHJiwCsh
 hu3BLECp5ZHyBF9mrTQ3zHDBvYd0Kx2hwwc2rpRpywKRpCg4N99CaaXHtC30AS9cPz01
 dvmxaJxAtSMhA8w1yxY21Zm1kydYMDQu7h+DenQQ9STH/6vQrqC+mcDTD5AdgCM/15hF
 fG3JwXGDOakJKjzngtQCDOuy4EUKVY3TaqFZuzmt0WbqWfSFLRaxrUTolmlNySbCU/AH
 NgFpjBkHDNbwTXqOkKoIPQmKJ7W/tniN2tFjRpK7xV+jpsefR6ZMR+2+NPmIRrQb+EIo
 Dmnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAiFknulGSRGKlGq9M7YmYbUDyjrCmeVKQbPQt+Td9+b7Hy2vf6znyyIl+/f3OWqx82i1hDDbC8po5ksTh@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxriu+gC/CgrRhuRp02EZs+vRK9mwbG7fkrrXdVlEVWOe/uFcfX
 0t+KceyK+qFxALFTBZ3JKCjRFmHo3Z3uVW8yxvJKd3b1jTdD8a0BIiwTFO2xWqTQBhHxXrW9eAb
 kObldkJIByG8aW2hgS9EGl9hGRrLvRlqhbPgguDdd/B+hAJ+Rfrqd0CU0afsZO4vY0x6plxu3tz
 QaBNE8jg==
X-Gm-Gg: AR+sD10u23z4KVfpBI6a5QRvxFc6FeaNm77V+8A+LKEdwBHL0fOPTpjSW2RLDxHIDF2
 3voYkN4YTqz+7dxq8iRR4FIcTT4ZJWxSxwtUIj9nwyX5emYmcDc81XOaTTilsJsIX3gs+jb+kEe
 OrvaWTuhKxoDlZ8LfQ1HMyaGHaczD2AHwwOQR2lXEiIo864CVdiKPW0pa5sSaN+Bx29QvNLuZvs
 8GS85vVzwDVahxqHxhD+o6MH6iJebUM/QU5xWOEu3zkdJlLKP/0nL0IMVp3jsNsD+c5h+SMrFNX
 vogZdLntCEsWJ44i2ZNJOaDBRIasHCguN7+dO4W+zv0ECNN4cgyeKrJzrpUb9Fz1syeI9O2kaKi
 +jaYR1MriQjhROWrqauDnYGxr3d4PA+wMZNYh4KnIYcW10fRGmJnZ1BpbcXj4+4//IKDpmJ5h5/
 OsrYBYsy1oF9k4h2W398EzzVs3T4Ryf+qDV2llHfPncQGPa0j0Cp4XIf6xwS+shsu0zhD2u7IEp
 tf/cuNo0CmZM129l5V3pqZzzTydOM+edRKDaHiJ997it/WfST/5SZE3o+qkpotNfhk6DKYbSDFL
 0QNOc2+OTOgFHR0sclfilmPYCzKqQCWb7cJYc5JGjleGNh0zBhQjsj/WN88oag==
X-Received: by 2002:a05:6000:2c12:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-47fc81f619emr3415035f8f.35.1785412936830; 
 Thu, 30 Jul 2026 05:02:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fcb9cb612sm656156f8f.20.2026.07.30.05.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:02:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:02:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 57d144c62e424eff54ae345a8d8cf7408c1948f4
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 12:02:14 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <431cebb5bb67d2af8f2fcdf73639d30cdb4c33ac-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPTT-0008OD-1f
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in hamc cookie approach
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8492158797137417338=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8492158797137417338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vbKY5hRj0Fk="; charset=UTF-8

--vbKY5hRj0Fk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in hamc cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(3 comments)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/02ddaf25_c1974c19?usp=3Demail :
P=
S1, Line 7: Replace SHA256 with SIPHASH24 in hamc cookie approach
> "hmac"
=
Done


File src/openvpn/ssl_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1827/comment/03e63c76_056f1882?usp=3Demail :
PS1, Line 458:     /* ens=
ure out input is large enough */
> "our"
Done


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1827/comment/321fe484_41c054de?usp=3Demail :
PS1, Line 481: =
    /* add session id of client */
> obsolete comment? or missing code?
No=
=2E Actually I accidentially removed hasing the client sid=2E Thanks for no=
ticing=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
827?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178=
ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet=
: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Thu, 30 Jul 2026 12:02:14 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <fran=
k@lichtenheld=2Ecom>

--vbKY5hRj0Fk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/02dd=
af25_c1974c19?usp=3Demail">Patch Set #1, Line 7:</a> <code style=3D"font-fa=
mily:monospace,monospace">Replace SHA256 with SIPHASH24 in hamc cookie appr=
oach</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;hmac&quot;</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/03e63c76_056f1882?usp=3Dema=
il">Patch Set #1, Line 458:</a> <code style=3D"font-family:monospace,monosp=
ace">    /* ensure out input is large enough */</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot=
;our&quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1827/comment/321fe484_41c054de?usp=3Demail">Patch Se=
t #1, Line 481:</a> <code style=3D"font-family:monospace,monospace">    /* =
add session id of client */</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">obsolete comment? or miss=
ing code?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">No=2E Actually I accidentially removed hasing th=
e client sid=2E Thanks for noticing=2E</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail"=
>change 1827</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1827 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Thu, 30 Jul 2026 12:02:14 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--vbKY5hRj0Fk=--


--===============8492158797137417338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8492158797137417338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8492158797137417338==--

