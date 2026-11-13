Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4C606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bGeWMt3y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QA12BBXt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RM/d1IiA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K1tBtuuq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2kWx2dcvJ2Lygi1D/r+DZgKcnSs2uKVmKA3wSuwMUmE=; b=bGeWMt3yOx7roxkrGZDNBDS20X
	mujmmLyFGHQp+AxSnjcQTMV70172gGQd7FfQwgwUlJnSMAnVfEif0X1up/LUK+S/8C8jaXpnGHhs0
	pXD+x7tO+rpxxfBC46rRj+RVeu5YZPOI79TvpnmLWU1SSMCv+k1zw0fDqjmPvRvh89oY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuiB-000000003FP-1nyE;
	Fri, 13 Nov 2026 17:05:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRui9-000000003FH-3YMZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8qCZ7VNWUh6Va5depvAWEaevtLnDYW81s4XjHfD3MM=; b=QA12BBXtk8k1V3zUYqoxNcBROz
 Ga/jFE6+Kc2boR9HySpiZsTlqYspgfeF4HBzAbrDUr0DZuwZ3TddSMdxqB7rjNq7L1e0Jy+mxMsBj
 dGvYaNQJ7TO7RjoMg8y+5aKFW0hK7A2WAU5JWqJcNYKYUPesYRsKiXuJd7tuCDnENjag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8qCZ7VNWUh6Va5depvAWEaevtLnDYW81s4XjHfD3MM=; b=RM/d1IiAZeokMiOcCYA3UbF8KY
 TnfPBUz/DTTASS1nzZLA4Qyg36dFY0XfMqz6xMOU2lEk/V/fA7Oh7rfrnQ2VQqTBMe+VqUa8jVXgH
 7FQKfyzQlWxdmfV39f8Q9pPPgnufcIByI5bwIM51Z0MVg99eJEH/pjouLzRqCc1iTX8M=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRui7-000000007SV-43IB for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:05:13 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so7828885e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 09:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794589505; x=1795194305; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8qCZ7VNWUh6Va5depvAWEaevtLnDYW81s4XjHfD3MM=;
 b=K1tBtuuqE+rpbcQyR7RTTC9AHByH/bezBNuz7hl/sbGFJHRG0Qd6i6rvv+LvZ3pv0e
 yyRXYTh6fGTNdgA6enkV7RrCgYlO/jgFYYhRnAscQAjbb1Jl+9TzifateC307/jZF++D
 LT5CrQdtAp27Xp97JznDJTvS1hrq/z/9ELVCAgRHE61lPmedIzxMOWMPoPhuDhq3j8qk
 S1MX8IgK6XTl9up/tcwC9W7zoSgbVckl1uLRZA507+KteR2UpWbTbn/wSGI+SpSYOxNJ
 z3rREEjuN3PZ2M75poNSfWR2kJwPwtkEy3P4JTCzDjHjEUUU//G6DCbWwmQ+mkBpCjcM
 iRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589505; x=1795194305;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q8qCZ7VNWUh6Va5depvAWEaevtLnDYW81s4XjHfD3MM=;
 b=DJyFEMdHWKzswuQtFRa9Z00to09QtN+SIK8BsJl96utIm4un8kw7pPFoHpTSn3+uiu
 Nm2EW4PDJLgEMgjgLMGe/wVxImRoigJPcwFYJz+A/2lACLzADb3OYdYRJFNIQHY3FSb2
 32tZGWMh2q/drVb9GWwSh/82i2EJEn8EOmtfSMTkojXxDI6iZ+ZVmeoBOt/daAo8jFAR
 SZB+1S6BvfdJvV+nEpg7Z5vxdfmVyte+Ugugb0mkwpsbeSnkOw1Lj0pN2AcPafTWEvLg
 OpKAMXJvP/9WfZ2KmyCyAUtc/p/TedYsZmxixMpSYoLte0mqJua0zSxdZS88l8Xv2tRt
 Mm1A==
X-Forwarded-Encrypted: i=1;
 AL+hErHcMU7ti845YN2Y3lCn3grDTdLHfc/atHt+QwE8qWY0y7Ch4CsPxtcOZxm153jTWZDVzKq8z7A4pV7qj+cK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ihUtZsBcnET6SSrZda/GiKHxYRnJ19icOCPhKANu0AwzqjUKz
 5wKaBGDpZ1mu/gXGF8f41lcxv8ulIVKbNDd9GspPkn9UpS6HoLQv8Tiig/7qdml4mFMP+Grpsks
 u+YV5Atiz8Ot9Q0Flas9Lde/NdQgg44qxJZeskGYHmF0DqbsPDet5BQx50eHA81NSlCgb
X-Gm-Gg: AYBFou3VMs7S7U/tgeGew57uMVgrrk8sY7qjNMH42/YKxyaieu5KYcjTwtcIPJKZIpa
 d4H3EoAJY9JEHNsjsAvci3IowV173jwZH6AVli4Jo+VXhzesqTDo0UxcYbfGiYNXJQXIbXt9W6e
 jQ0Zw5Dnut+Ulxyqk9XGNFArEOvxIwQ8gWyzw/cJ+zvT1J5p18DPlKhn0G4yb08IgUvOkHKZUJl
 cYDdDtduNphsE9ylXQzzCKjPjUhknWNhABNT4fJEp8hYHwQ0Fi+fb0DRrsj+XHpQ+Vj/GV1C/yB
 ZyJ14z52p8f0vwlDCgYzR32AMp6mXU3JUfp9oPBitHAR1qrAnWuMg637ZCjak8CMUHCpZinjGdD
 ubQIPVrY7PK771/kP1dzSBS1fVL9NwZmN8ofm4EcwPIsHeecyUY4sAGiEL+83J9HJnSAYUQ65+f
 qXfrhQI9rNnBKep71L6LYCGUibe20WQPcdu/LJcTTwo5DdOQGGMiQHGHi9STIgz1h/77DDCrh3b
 c/XgZMgzIHg5x/ZlNdf4g7VV3AErM+6r95Sk3n+i+9JVh+qwAFfGsJaWurgUHSdv4tuiL2YkJ0T
 x+TUCA5wLGELGkzkO33maMthFBfen+DnTZPXgaozzXvicJpbiyApbB+X8iCV2o2997qGy14sjY1
 zUY2a0zo1q9dtsb95FRyUPaBE+aXbZhXOw1L7MV6nDVtYzTuvBx7JAVhfwgSZ3/x2/Ve/E2KxS8
 +AZe1V0745MY+d9YM=
X-Received: by 2002:a05:600c:2d2:b0:4af:c210:5b3f with SMTP id
 5b1f17b1804b1-4bb55a63720mr49521845e9.24.1794589505102; 
 Fri, 13 Nov 2026 09:05:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c0e31sm5368304f8f.19.2026.11.13.09.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:05:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 17:05:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
X-Gerrit-Change-Number: 2160
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2160?usp=email>
X-Gerrit-Commit: 26bb86bb2ccbc6280c159db19597e02e19e684fb
In-Reply-To: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwOTk2MDAwLklkZjM3OGJiNWFmMGIyYjRlOGQ3NDZlMjUyMTU5Yjc1NmU5NmMzN2ZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3315489d81f55f301fc594d905baeebc3731f1a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRui7-000000007SV-43IB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 free the domains in UndoDnsSearchDomains()
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6822904683324548666=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6822904683324548666==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HrhkvCxzDGI="; charset=UTF-8

--HrhkvCxzDGI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2160?usp=3Demail )

Change subject: openvpnserv: always free th=
e domains in UndoDnsSearchDomains()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

openvpnserv: always free the domains in UndoDnsSearc=
hDomains()

The domains string was only freed when the search list key coul=
d be
opened=2E Free it unconditionally, as the caller frees the undo data
r=
ight after=2E

Broken since ae90cbad ("dns: support multiple domains withou=
t DHCP")=2E

Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Antonio Quartulli <=
antonio@mandelbit=2Ecom>
Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160
Message-Id: <=
20261112063912=2E24551-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41182=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/inter=
active=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 5d=
2abeb=2E=2Eda86e85 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/o=
penvpnserv/interactive=2Ec
@@ -1754,10 +1754,10 @@
         RemoveDnsSearch=
Domains(dns_searchlist_key, undo_data->domains);
         RegCloseKey(dns_s=
earchlist_key);
         ApplyDnsSettings(gpol);
-
-        free(undo_data-=
>domains);
-        undo_data->domains =3D NULL;
     }
+
+    free(undo_da=
ta->domains);
+    undo_data->domains =3D NULL;
 }
 
 /**

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c=
37fb
Gerrit-Change-Number: 2160
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HrhkvCxzDGI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2160?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: always free the domai=
ns in UndoDnsSearchDomains()<br><br>The domains string was only freed when =
the search list key could be<br>opened=2E Free it unconditionally, as the c=
aller frees the undo data<br>right after=2E<br><br>Broken since ae90cbad (&=
quot;dns: support multiple domains without DHCP&quot;)=2E<br><br>Change-Id:=
 Idf378bb5af0b2b4e8d746e252159b756e96c37fb<br>Signed-off-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160<br>Mes=
sage-Id: &lt;20261112063912=2E24551-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
41182=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 3 insertion=
s(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interact=
ive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 5d2abeb=2E=
=2Eda86e85 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -1754=
,10 +1754,10 @@</span><br><span>         RemoveDnsSearchDomains(dns_searchl=
ist_key, undo_data-&gt;domains);</span><br><span>         RegCloseKey(dns_s=
earchlist_key);</span><br><span>         ApplyDnsSettings(gpol);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        free(undo_data-&gt;domains);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        undo_data-&gt;domains =3D NULL=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(undo_=
data-&gt;domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   undo_data-&gt;domains =3D NULL;</span><br><span> }</span><br><span> </sp=
an><br><span> /**</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail">change 2160</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idf378bb5af0b2b4e8=
d746e252159b756e96c37fb </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2160 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--HrhkvCxzDGI=--


--===============6822904683324548666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6822904683324548666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6822904683324548666==--

