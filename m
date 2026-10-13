Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC389CC6B03
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+z5fCTo/RzGITeHAbT2XRWKcur2gHDs4y4GuA5yPsCc=; b=BadhsFD6q1ExWLWePhpyk+60WF
	RwzTIuTxldH9j0x6POu2DWZoo6eqx92rCsysWZk4ZcYePZ8OrY5OvAVHhrsmxOCF6WSkGefcr7Rd9
	a43voe+RJROA0ClRyVLQ/vMu+t0AJPcIyI8jAhzSQ8XxAxVmpMEQPA8b4cCs4PpQAtc0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGa3X-0000eN-My;
	Tue, 13 Oct 2026 10:48:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGa3W-0000eG-It
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vgItcelqIaWQdpYmZwMQAVVavY5QSwxu2q7yOyfCXjU=; b=CJ4sUWsac+Sk8RUI2oylxsiio6
 xzouvWTIx5KkHGoykkkKQDH9UxjeIY0jKM/57fhx/KuYAMwaq/K4//TtWoG7x3lOQlrE+e3qQm3AE
 7aPQc20fVCnJKDQUbPygQvnxGoHOg8B/sAtAyHlrQphJufU+He0h8iyul8qAuVqI9as8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vgItcelqIaWQdpYmZwMQAVVavY5QSwxu2q7yOyfCXjU=; b=d
 yj6RPaIbVltqM9Odjsy4Ij+itSq8J36BFPneiZaclY+8jNJrrhKJIwWz7E1Xy4uqXndbaarn788Jq
 lS1j0wAL/vc3wvsKVGE2zvizJ+EyCc4dvD/zUB+MnFeAGIA60l1tn6+0jgV9fMOQXdGZ/XwET9Uub
 XCNbOZeGbiu2kdiY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGa3U-0008Ei-Th for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:48:26 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1af482519so3025355e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791888498; x=1792493298; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vgItcelqIaWQdpYmZwMQAVVavY5QSwxu2q7yOyfCXjU=;
 b=HmM/iuWx8AYl6kHwLUWxaCWFLtWG3ioFc2Yn1RTTfLNg4U1Mut61SMaBEkHSfweeAu
 D86qJQSyw6UXfRXucuLMK6doZYuQVDXDTPR8aYoYMh7Ba+FbAbK4Az0roqFp8//VVfJD
 OVtNVlgdlKq0cbLcSX+1YlPeJl4hQsaVauiRA7cIB5eluvn/rq3h2w1/WAdx6TSHBM3w
 KkC9DiWbKBc/H4YUFsVFe8mTc81yU4S+OQu1CBSxVlU7EGui88w1x8ciT0/8qn//D1BJ
 jH1nuPSBb9hHVmuPwy7YcCKXhY1kMZTcJX3y9d1e+8i0w11ge0ba19Y3g7gJyIq1rvIR
 ImtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888498; x=1792493298;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vgItcelqIaWQdpYmZwMQAVVavY5QSwxu2q7yOyfCXjU=;
 b=BYjvNICh5+R5fVcvwFAbaCarnIat35OfjD0KeZZj2ck+MKQqU8aEv4V4agtcDYG/ig
 Vim5gX+Qhahao1ZvhnnQGc5x8y6HO/BkhknL24RZLpW3nzB4pzaGJ0rnXEcCb48k0eSV
 ptqZdE0p3QGY6NUMYpZjpEwMbydNrmc/3fkSiMQa/se/UJ2vZa8Nbr+ZnP/U+zvr08lb
 5i4AI8j7KkqAu1MC0X15OgiTb5V94DqlbW4Hu6R9gYbLChFbvq/0hpukG0lyQf9P1oD2
 W6MSaY+w5LgUd8MAcuFMlh0RbFcBoZzrFHFuQhDJLbkY6Rxpr8lVzqMWBJtVNc/mttvT
 vSuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbLRtQ6XB1EWNp7cpvcDCbJipwDhjUX9M2lYlubbm6wxBKlVWerMpevY8KMmTsPw7XPy9YZXegn2zZrJ2Y@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIJuaPkRmqWOe4LI7YavN+T8t3YqkAfqkSL0U9Wd7RV77C7hQCK
 +ELCXy/bFLx46V+0HKDF13rusOn/0y5kaKUEPqM+VvnzfyW+9WjBmAISMOkr/7XcQwkKmHJMs86
 3s3t9+M27IWgMi5S0ivKdUG1C/jhb/ShfBVMDa8kWZcUNBUjGgBb2Iay0X/WqR2ycteL4
X-Gm-Gg: AYBFou1hFx8NG2pJ3XwByCw2i7466f7Y5HNHAYbTONpoHavxKOVrr5/0aG++XQ6VtX+
 /B2bqrz7BkJUvgfNaVWOS+YSoXe8ogSO5CoKGrqHYMJVi3vsx9kpmQdkBaodUnxQzYw24msgsaK
 zVpoRetbREsfwN4nEASRRNpikccY9KbU7TPSqVTOqhbb8jHo03bGc8WHaFFFVOcULGDOB8wyBsj
 jyH/F5RC9A4CNCuLrTmma88h3pqqzq6ShHyvuJOQ0sHoaRONosOH627KEO8esIKO80CkVhKjY0q
 IrOXghduReUpF+T6vvDzydt74XZ14Nt2XbzPksknqmFSU2D8j6P1trNgoz8MXpEAiFt3HwF0ZQu
 1KesA8m8oFwBC1mUfsXkdf7lpHwkx6kUdXcp8BA8o4MKEe81Jv5S4EkIlTiHZu/tJNK17jINWkf
 cPl9m6qpuBO5R03618N9OqOy7obSh+WK5ACC9OXdB4zVrFwG8/V32u3yahLEG03BIIJR49Kz/nN
 HaS5Vry6+nv0j2weAu1pB9eqh8LMEp9LFhCOnYD7M4zmV+ibx2XI6ng1/VenoCqEw8n61gqYKML
 DI4WApRHJWyr7gstiW8nI2DJGuR2Zs6Ici9rvjajrIiFQymD7NwUS9c7Xj5D
X-Received: by 2002:a05:600c:3512:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a18e4913c3mr205446585e9.8.1791888498005; 
 Tue, 13 Oct 2026 03:48:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm498076385e9.0.2026.10.13.03.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:48:17 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 10:48:16 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Tue, 13 Oct 2026 10:48:16 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40da3c24d452366c9e17c7c2692c0b23c3670a34-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGa3U-0008Ei-Th
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1316111839180541763=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1316111839180541763==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="12ZfCVrhzeU="; charset=UTF-8

--12ZfCVrhzeU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: -Code-Review


-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c9=
4099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: 1
Gerrit-Owner: Ralf Li=
ci <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 13 Oct 2026 10:48:16 +000=
0
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--12ZfCVrhzeU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 1991</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97c=
55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1991 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: An=
tonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 13 Oct 202=
6 10:48:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--12ZfCVrhzeU=--


--===============1316111839180541763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1316111839180541763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1316111839180541763==--

