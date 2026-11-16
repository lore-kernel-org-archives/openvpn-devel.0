Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F8606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m7Ka2tmO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UaC0F7b8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d1ymvl54;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KBpoxHmf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j+cz4bVCHv9oUqwU9PhmJJyaCJdYGLYV8c23K/SRmcU=; b=m7Ka2tmO3rQiBuSw9wNi/RmfLN
	doWOckc/L57mFmkMFQqsTC/iF/E6Yrat54Uan8dtDZAoekrpkqSf/TjUpWaQD1Rt0cPq9UOnbqXt9
	RarnjIRvkbCu+An/Zb4ZqTJBxvTVQpgcISphyAsyUWGBAOz76vH3QUnPTYW8jsKMlXn0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSsYD-000000005hf-0MLF;
	Mon, 16 Nov 2026 08:58:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSsXk-000000005gE-1GCF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QrmHPvNKnqOdvNDQT7Qirzjcjkn6ithiPPHFjexG5p8=; b=UaC0F7b8I80MnEsAa7y5x5ZQrM
 NBIeXNsQDv2eDhnoEHfNPtLlvs9YWTzkrr3u//3g8RrUhjN4s1ZYbCROS77gR1e7TgxirIMkZkZ65
 Lqq2lJJzpAeA9kGptAbrpY8XSFUnYDZDUJzcuxDS6Um0DP3S4SbLI52Y0NiZkBfv7Twk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QrmHPvNKnqOdvNDQT7Qirzjcjkn6ithiPPHFjexG5p8=; b=d1ymvl54npMgzdjclgQXPTvK52
 gtzNT0BynCzRJp7ryxjbjM0wp7z6koT+9c48KCAA3AOMF3aj0OhFkPYTUjEWb8eK80dvuKcdTVEjj
 yyhsovOHmu73jJSNoq5FvSYX9h1kTYfFXnw/cBlTJA7xeAMb6jMf+O1fUTrMBO8hTWj0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSsXj-0000000061z-1SHB for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:58:28 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so1231549f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794819501; x=1795424301; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QrmHPvNKnqOdvNDQT7Qirzjcjkn6ithiPPHFjexG5p8=;
 b=KBpoxHmfMCyeqbJQIz2d1PZ4fLUJgMsfck3kYEUc0/vCbWlPtIjVL/Tn0TiAPC1bsi
 EEtg37RKKNL7Er1tOZp4mPYcia8i8njWuLmtf9EpzFRd5rlDR40d5blkCk364/tbrF+R
 SUfhJocvWDxgLuV9HyglmC1xBUL9ejQJUKeu3ttgN6PdqtmIJVE7KLGn525P4ucA8dYS
 DcSUsLGGIVKWlSAPvYEryTWgDjoG81YDCg6sR5LHnwSim8S6RjhyoBfaXNLenh6T0LyU
 scUarI0iTGvA/zqXyGbIyQaLpVowr7EOpoP1UzfugmFu+uePZyCuKW8AwEClX012yu9b
 9l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819501; x=1795424301;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QrmHPvNKnqOdvNDQT7Qirzjcjkn6ithiPPHFjexG5p8=;
 b=HRy2SCPBes9KoN4HDD7Wq4XaYXjgVfnvum1bU71vduPAQIL8IWgKCFbjr0FqjTbgbh
 U61sqTdryXrCovbc5jXHhAZVtN5aVTGW0Rz+Pg9L31Wu548m3ICYXcK8A3aCqOlRoRIf
 rSkZB6rmXx0rNmQV3LJxa+lQvkj8CxCNV4Ae40rPP9z1UhcY3VryauwwkNNrnsBhA4Tw
 6/N5t44IW7xONjk09yEG3PeoZfOAm4olhawvpAY4zv5D0BkM6uIng7TEBFGMUNVcW1+y
 jARG85rIup+0GmmNq5K+eyvxLQc75oSLG/GX4RXYEAlVJwO2gdTob79MMN5ts3BoQH3m
 k3TA==
X-Forwarded-Encrypted: i=1;
 AL+hErFSeqsdrvCZNGTelGOSjgXN0A5G4Az3Sw4N8R7+0ja4IWDmAMo8Kd3U5J4x2OdiumSJnbOAnqKdSL/x35pw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8xwBbIQaczP/09CEcER+MBw86ZrT0XwSmEUx5u+bWAlQ/xmEww
 X92MDssq+m0zwt2kmY9Tm/8IH+yiUSBxXZ5gu9/+acqv5/VgjGv96ENEiKQqzXQMcH43pXx9aIG
 Vee4TEnheouDX6cbWH+1Jgq8+9RLrYvtw2MBHVqK0ymJfTPtIkAeqb9nLJf82XpZKIckYglZJ4O
 4eguqNvQ==
X-Gm-Gg: AZFdTZfVHS3bVDelXap7nlyDAIAulluywI1olLImTjo69uHMD0Fz4BYMqKzlDIw95Sj
 YkrqKC46radIxuLtUOTIV+DTP+T9Jh1nusECQHuteD3XXSqQOMihQeFGN62bfOVHGxNyqo+arxn
 Wn6sT+ZflbVq8LuF8toy5iNbdYF6GYhmK3qIF9oLd2JbuawKfBQU8MYwhXbGQ+f6fguBNw2KWq2
 US50t0fta2+HwhAnNZKyPTOuw6JySNhl3dcHseGSVWSjoE9RhbqCdprgbci5c5OgoSZk3CXoDB2
 3cTp9/4bhEXxwr6llje1bZ1PmZa23St0qYubBexR0R7Ibw6D6o1/89OrHbvd/QrVO6T5lqqgKfx
 /51m+OWhgglHbahgdgvXsA6X3swgAkd97z6TNQnI9lxR/PPx8e/HxiIlp6r6VCxvx8Ut5XuUNVg
 KuCtK5jQ5740arjPYdW2CPjzsToDv6h5KF6KGVuTA89es7BRbEOM39b0s7IkMJ0dcqKBQtjUw9w
 d2Y9IhfxVhgaP0A+YlhYXpIdxgPztFkH+cDiLpJbWr8NWiZbTfEpuGOWZWV9VHAVKqd5Hd7G5pR
 gsnBz+NxYw89rz8DaJ9Rp39eGCS/WxyKcTXn4iWq1rpQXiNu2HIAvMuv+hEjSmvJNkscXhWDfAt
 FxCR0I5YgoLkawRP30hVeMn10WIQvMU4NyMwf/4EUGkr6hMUyzIWiDy63KCQg65Th4d2O3QhcV4
 OJq74tczay+ZTPTLyl8cwTlfC3MNv28/l5TEX/
X-Received: by 2002:a05:6000:490e:b0:492:bd2f:bdeb with SMTP id
 ffacd0b85a97d-49b022b3bb0mr28302142f8f.17.1794819500562; 
 Mon, 16 Nov 2026 00:58:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c77393700sm20429587f8f.18.2026.11.16.00.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:58:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:58:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
X-Gerrit-Change-Number: 2131
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2131?usp=email>
X-Gerrit-Commit: a9256f3631896b1678fd67695a7490161039c962
In-Reply-To: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk1NzQxMDAwLklmOTAzZGM1ODIzODU4MGVjMDY4MGYyZDRjOTA4YjFmOTQ5YTI3NDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5b5b02df45b6c958009bec31e8bff9b76582d34-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSsXj-0000000061z-1SHB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5829905653709113816=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5829905653709113816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9UntSfqrZLE="; charset=UTF-8

--9UntSfqrZLE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2131?usp=3Demail )

Change subject: route: use setenv_int_i()/s=
etenv_str_i() for indexed route env variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: use setenv_int_i()/setenv_str_i()=
 for indexed route env variables

setenv_route() and setenv_route_ipv6() bu=
ilt the route_metric_N and
route_ipv6_*_N names by hand=2E Use the env_set =
helpers instead=2E The
resulting variable names are unchanged=2E

Change-Id=
: If903dc58238580ec0680f2d4c908b1f949a27469
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131
Message-Id: =
<20261104124750=2E18302-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40712=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/route=2E=
c
1 file changed, 4 insertions(+), 15 deletions(-)




diff --git a/src/ope=
nvpn/route=2Ec b/src/openvpn/route=2Ec
index 4cbba06=2E=2E9086529 100644
--=
- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -1322,7 +1322,6 @@=

 static void
 setenv_route(struct env_set *es, const struct route_ipv4 *r,=
 int i)
 {
-    struct gc_arena gc =3D gc_new();
     if (r->flags & RT_DEF=
INED)
     {
         setenv_route_addr(es, "network", r->network, i);
@@ -=
1331,12 +1330,9 @@
 
         if (r->flags & RT_METRIC_DEFINED)
         {
=
-            struct buffer name =3D alloc_buf_gc(256, &gc);
-            bu=
f_printf(&name, "route_metric_%d", i);
-            setenv_int(es, BSTR(&na=
me), r->metric);
+            setenv_int_i(es, "route_metric", r->metric, i=
);
         }
     }
-    gc_free(&gc);
 }
 
 void
@@ -1356,22 +1352,15 @@
=
     struct gc_arena gc =3D gc_new();
     if (r6->flags & RT_DEFINED)
    =
 {
-        struct buffer name1 =3D alloc_buf_gc(256, &gc);
         struct=
 buffer val =3D alloc_buf_gc(256, &gc);
-        struct buffer name2 =3D al=
loc_buf_gc(256, &gc);
 
-        buf_printf(&name1, "route_ipv6_network_%d"=
, i);
         buf_printf(&val, "%s/%u", print_in6_addr(r6->network, 0, &gc=
), r6->netbits);
-        setenv_str(es, BSTR(&name1), BSTR(&val));
-
-    =
    buf_printf(&name2, "route_ipv6_gateway_%d", i);
-        setenv_str(es,=
 BSTR(&name2), print_in6_addr(r6->gateway, 0, &gc));
+        setenv_str_i(=
es, "route_ipv6_network", BSTR(&val), i);
+        setenv_str_i(es, "route_=
ipv6_gateway", print_in6_addr(r6->gateway, 0, &gc), i);
 
         if (r6->=
flags & RT_METRIC_DEFINED)
         {
-            struct buffer name3 =3D =
alloc_buf_gc(256, &gc);
-            buf_printf(&name3, "route_ipv6_metric_=
%d", i);
-            setenv_int(es, BSTR(&name3), r6->metric);
+          =
  setenv_int_i(es, "route_ipv6_metric", r6->metric, i);
         }
     }
 =
    gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2131?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If=
903dc58238580ec0680f2d4c908b1f949a27469
Gerrit-Change-Number: 2131
Gerrit-P=
atchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--9UntSfqrZLE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2131?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: use setenv_int_i()/setenv_s=
tr_i() for indexed route env variables<br><br>setenv_route() and setenv_rou=
te_ipv6() built the route_metric_N and<br>route_ipv6_*_N names by hand=2E U=
se the env_set helpers instead=2E The<br>resulting variable names are uncha=
nged=2E<br><br>Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2131<br>Message-Id: &lt;20261104124750=2E18302=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg40712=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<=
br>1 file changed, 4 insertions(+), 15 deletions(-)<br><br></pre>
<pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index =
4cbba06=2E=2E9086529 100644</span><br><span>--- a/src/openvpn/route=2Ec</sp=
an><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1322,7 +1322,6=
 @@</span><br><span> static void</span><br><span> setenv_route(struct env_s=
et *es, const struct route_ipv4 *r, int i)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new()=
;</span><br><span>     if (r-&gt;flags &amp; RT_DEFINED)</span><br><span>  =
   {</span><br><span>         setenv_route_addr(es, &quot;network&quot;, r-=
&gt;network, i);</span><br><span>@@ -1331,12 +1330,9 @@</span><br><span> </=
span><br><span>         if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       struct buffer name =3D alloc_buf_gc(256, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;name, &quot=
;route_metric_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            setenv_int(es, BSTR(&amp;name), r-&gt;metric);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            setenv_int_i(es, &=
quot;route_metric&quot;, r-&gt;metric, i);</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span>@@ -1356,22 +1352,15 @@</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     if (r6-&gt;flags &amp; RT_DEFINED=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct buffer name1 =3D alloc_buf_gc(256, &amp;gc);</span><br><s=
pan>         struct buffer val =3D alloc_buf_gc(256, &amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct buffer name2 =3D al=
loc_buf_gc(256, &amp;gc);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buf_printf(&amp;name1, &quot;route_ipv6_netwo=
rk_%d&quot;, i);</span><br><span>         buf_printf(&amp;val, &quot;%s/%u&=
quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;netbits);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, BSTR(&=
amp;name1), BSTR(&amp;val));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_pr=
intf(&amp;name2, &quot;route_ipv6_gateway_%d&quot;, i);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, BSTR(&amp;name2), =
print_in6_addr(r6-&gt;gateway, 0, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;route_ipv6_network&=
quot;, BSTR(&amp;val), i);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        setenv_str_i(es, &quot;route_ipv6_gateway&quot;, print_in6_a=
ddr(r6-&gt;gateway, 0, &amp;gc), i);</span><br><span> </span><br><span>    =
     if (r6-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct buff=
er name3 =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            buf_printf(&amp;name3, &quot;route_ipv6_metr=
ic_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       setenv_int(es, BSTR(&amp;name3), r6-&gt;metric);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            setenv_int_i(es, &quot;rout=
e_ipv6_metric&quot;, r6-&gt;metric, i);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     gc_free(&amp;gc);</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=
=3Demail">change 2131</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2131?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2131 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--9UntSfqrZLE=--


--===============5829905653709113816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5829905653709113816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5829905653709113816==--

