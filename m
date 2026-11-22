Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AF606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F7DEqpsb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S/nr9P+f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PIUW7oLx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IwDPfgIQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pVGaPEVJwb/xXpDQVau3cA48NSqRgE/N+GwTI0/WnpA=; b=F7DEqpsbiLreX5iOBDVMzBZcEY
	COL5x0WGkYmj7HrOxGCRJF7YxXOf9nIhNIFsYxp+3t+Bf4DdHasNiN4Pt6dayb8+0retF/KndP4Pq
	u8xDscbwwzC/EPSs6vjhtjwYGGQf4cCkQvZlZuTVEe8nHOlPbCM0E40LWCFnzqtEauHA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5Z1-000000007IM-3r1M;
	Sun, 22 Nov 2026 11:16:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5Z1-000000007IG-0Yqx
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JJ/8LT/MB7fennH4ieFtE/KBW3oK9SLrUgb9G9MVnLM=; b=S/nr9P+fNSlxv1M7KKzlUvPLTo
 06xFths+E+CxCdq5Rj3YYgh+aEdnOq9Ih37bfyCcJuMUD0EHu8tWDTqC03RGv1km9tn30vl2fvnvk
 H28i8Jn2jZlCMR2QI5cfYiqmFdwwAXtUDCqpKqwKdOvy1F3vmBWXBMN9SPqR0qtcZE8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JJ/8LT/MB7fennH4ieFtE/KBW3oK9SLrUgb9G9MVnLM=; b=PIUW7oLx8g0pfmzqKLgOE45+Ym
 H5RAhDFRhxxmI5m/UvSecu85AjsN7EzrdOQhHWYnkry//U0GAL0y5blTH9MWU/LGeLOCdwQUpSJ/q
 6sRAsEEkfQQyS3UmdFsuxUcUeVkyGa6axgbgSVp/B0tol99Zd/JIPxej3sSVc3QsulUw=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5Z0-0000000085Y-24mJ for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:16:55 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so22047035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795346208; x=1795951008; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JJ/8LT/MB7fennH4ieFtE/KBW3oK9SLrUgb9G9MVnLM=;
 b=IwDPfgIQFKpsfQSPJg9fdqC4HKf52z7/wLev/R1k2DNnh8Nsg/M/xQh/GvRYNxTn1Z
 wFPn/Rmt9LiUFPR8P9lLLpr8jZPgoXvXcw9P22WNGXFptQBI5p/6sb3sYz6+8Q6va3su
 8QfBMdv32Dq491uvT5lUa0dOPy+XuTLIr+U674gtntVyG3F4vOQen16AUJbQJlVNirMS
 rkAoA5jSOXgRJZ2ySIQb1Bp4SU1Gx5KJBRgzxK6TKYWvuAGM0uDJgaf5t0Nzbe8YJw9h
 QoSHkGrWrGRA0dLVsyoZsWTaN3lzRg6yQ7jU4Sb/+H+ISKjJdcNF0uUITfcqiyCsjCRk
 ixSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795346208; x=1795951008;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JJ/8LT/MB7fennH4ieFtE/KBW3oK9SLrUgb9G9MVnLM=;
 b=FYivwXylTXneFz2A/oRsjZUL5QqhueuGX3Gv0b0OUna+r24iJ2STYqa2Q70I3HxHYX
 LsvHH4mWUhXExPEeNMjpGoR+zhPskKXOmjQlAzEfIqSRXchZqMtjnaIqYkKRr3PbkNzF
 dxiLhBRn8Xkk7UEK8rY2VQneVLuFz2yOefH5C46E4qlldDPnEvrqxO22aAAk+DrjC5iK
 edCWQhXKe5W1LhXPeQ+wzpUgsc3Yc8OaEbXDVkbQBhpDMS3ZQLt9E30z8bw+fO8MqAHj
 /yYsKVrCxmYrO9SAMUIFfYsgWrJ+Y/DLHKmlnaXwIre/OwEL4K6tb5BbUaGDOv5djYwZ
 4YEw==
X-Forwarded-Encrypted: i=1;
 AL+hErFMzQrHZG9VBZebaVjde1oLF5nukmATVEm8XKmSQwuQb5NBsKVbjxBsurh1Le17kD1tDdDGdUN1YIKYLtnh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+hZyKF9grBCcE0rcW3RBHS9LU9IOtXvFF1XomxKDbkbxMgpI9P
 K7pH9Ga030gUIG0sY8NLtli4hHQ3ZUDYmK4CN/gfcUdJvBPReTLzzI2BtZ6+ZlDPdupT9gwwAd0
 jTlM/aWrxusc6DQqzGjdttD7R3LkwEH8PzQwhxegXZWYOKZgu5g1DqQKtFVFHhvwv9gm4
X-Gm-Gg: AZFdTZdgHqLaC7qL6wiE0smjnRrVJlPfIFUpMPNkG0JHuUezlTW17jmX9EqehOSOPWp
 G+S/Pu9FGqEwmmteUvKshHh4ZoO5fec2TvmcAqxVQKSmwYrfuCIZChte8ElLhErVfOOMAdeOCrB
 mRxhvCBII76TXb7LhaetbG28f7nssxH4mOLKuH9zcyNChyI0YnCcu9Tfq8qol0su9qB5ROJrmRr
 B7tUXY/PC6FR7775qnfbrwRH7apJ9AP2O2eGJxj+XIxRBsPU2txm8O08Fhl5iSqn064+Wr5N103
 bkxzDr01OfXxU7U/HBLMC2vQasW68xA2ZTBrSqNeaJhXUBpMKCpRB630lRP4Flr6RLFHGHrue3+
 urmE8O8lrcfs0Z8yHib1E5MUvIf6pnBX5QjcwGLJh3rEhBI6rS9HSuYA3usdqtZMsypEX9++uis
 NsidjgOdPXqwlWXNk4HnbRGXdBBayeEGKMT7UkT8i8JpctLz9Ls8kI871ExnDiiwFQgKcNPUEuK
 gWz7wXdMePhDjmXVUYERzuHmzMNgg7uhp4k8FT2j0BFsszgNedoFNNrKBWvw6aWWNs6Ea+Fgs/h
 ymHCtl+CxmpttGtWzv/aiIimTtKD8yjGAtJiWg9pujXsedlIiMxucdvuREk7KHdFmwJgSLV3Too
 w9VuHhgORgxpu64W9sJyFGatCXKO/jqPmAEiYMu6lNEZ46seSzyRrDI/KJay+TUPH9VWUzXOXaB
 6Gqm3R8x5rjVblzSQ=
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4bb88808263mr194226815e9.14.1795346207735; 
 Sun, 22 Nov 2026 03:16:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm296221585e9.12.2026.11.22.03.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:16:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:16:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
X-Gerrit-Change-Number: 2227
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2227?usp=email>
X-Gerrit-Commit: fb4ef462b3e88579aac06ae13c6144018768d120
In-Reply-To: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
References: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTczMDE3MDAwLkkxZDUxNmIxYWNlZTNlZGMyYTY5YzY3MGQ2MmY0OWUzY2QzNGQ2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d7b62aa0066442be133547ed5fea2064e28a599-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5Z0-0000000085Y-24mJ
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: route:
 initialize the table of block-local routes
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
Content-Type: multipart/mixed; boundary="===============6503933555397031135=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6503933555397031135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jIxp+HldIRc="; charset=UTF-8

--jIxp+HldIRc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2227?usp=3Demail )

Change subject: route: initialize the table=
 of block-local routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

route: initialize the table of block-local routes

add_block_loc=
al_item() allocates the routes without clearing them and
left table_id unse=
t, so the routes went to a garbage table=2E Use 0, the
default table, like =
the other internal routes=2E

Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd=
34d6dc7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2227
Message-Id: <20261121144850=2E26734-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41757=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+), 0 =
deletions(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec=

index 4dfdd5f=2E=2E5b1d012 100644
--- a/src/openvpn/route=2Ec
+++ b/src/op=
envpn/route=2Ec
@@ -557,6 +557,7 @@
         /* split a route into two smal=
ler blocking routes, and direct them to target */
         l2 =3D ((~gatewa=
y->netmask) + 1) >> 1;
         r1->flags =3D RT_DEFINED;
+        r1->tabl=
e_id =3D 0;
         r1->gateway =3D target;
         r1->network =3D gatew=
ay->addr & gateway->netmask;
         r1->netmask =3D ~(l2 - 1);

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I1d516b1acee3edc2a69c67=
0d62f49e3cd34d6dc7
Gerrit-Change-Number: 2227
Gerrit-PatchSet: 2
Gerrit-Own=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--jIxp+HldIRc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2227?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: initialize the table of blo=
ck-local routes<br><br>add_block_local_item() allocates the routes without =
clearing them and<br>left table_id unset, so the routes went to a garbage t=
able=2E Use 0, the<br>default table, like the other internal routes=2E<br><=
br>Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2227<br>Message-Id: &lt;20261121144850=2E26734-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41757=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file change=
d, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 4dfdd5f=2E=2E5b1d0=
12 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b=
/src/openvpn/route=2Ec</span><br><span>@@ -557,6 +557,7 @@</span><br><span>=
         /* split a route into two smaller blocking routes, and direct them=
 to target */</span><br><span>         l2 =3D ((~gateway-&gt;netmask) + 1) =
&gt;&gt; 1;</span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;table_id =3D 0=
;</span><br><span>         r1-&gt;gateway =3D target;</span><br><span>     =
    r1-&gt;network =3D gateway-&gt;addr &amp; gateway-&gt;netmask;</span><b=
r><span>         r1-&gt;netmask =3D ~(l2 - 1);</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demai=
l">change 2227</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2227?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> G=
errit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2227 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--jIxp+HldIRc=--


--===============6503933555397031135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6503933555397031135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6503933555397031135==--

