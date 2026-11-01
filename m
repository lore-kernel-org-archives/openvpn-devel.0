Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4013606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h7HAIhSv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A0fCilvc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bTAcHJQ2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VOTxx5Jb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=As4C/V35Z1NVh9UPrI2gBMMM+BcXlJoptm9z6j+3Cr8=; b=h7HAIhSv8qdGYhswAxsp5fGsJW
	u+7shA1pBQAawNDUQC6KiWVGiMSx7vQ33uCFkz2xgmxmGoKBDlawfZPHt+TPuWyarV9ppUwoKYxcb
	hvj6ap+TkMKPHupCH//tXlpTut3OKkL8up5PD+DJcfR3vszJuM8AHrH8/a/oF/jVkIOY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNTyF-000000007aJ-1Wgs;
	Sun, 01 Nov 2026 11:43:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNTyE-000000007aC-1ZF2
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jrzVMeZ2eLk6wiAi1/uS1gbDMCRA6rjrYE8b8aRMnlo=; b=A0fCilvclo49rq1rtEc/BKyBHk
 5XxFMkQAE+h+dtBpPbib2DxbFX8VSLllhFz3jnqaZOito9+cI9xOrIKgnZr0jEN+dZcdxbiyTj+t6
 Ocb8c3APYt86rEdSYMOgkiKjMTh/4u8/HcEM0Zb1n44TdCbsqeHXfSd8AUA8xzWnNNBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jrzVMeZ2eLk6wiAi1/uS1gbDMCRA6rjrYE8b8aRMnlo=; b=bTAcHJQ2JkhQBCPXIVKBzz8xZs
 Ib0OaohwjyLb7kCQPxCArho6rWiwErci8GNFmU81XfBEC71QcrYgiIlwnI7mgef2My+noODsK4C3Z
 9Vz7kg4YuJrkpAdOLX9sbjP6BRitCJruoBkls6k7QVUEKaieaOK3opUtmdqyC0CCDN5Q=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNTyD-000000001xe-2b3K for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:43:30 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so1548114f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 03:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793533403; x=1794138203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jrzVMeZ2eLk6wiAi1/uS1gbDMCRA6rjrYE8b8aRMnlo=;
 b=VOTxx5JbfmGNooXd4A5i+toASk0BvwzjaTdY8CqEgQmcUiUyATsaM30TVqNhDSd3/Y
 432V0YqdoLBC98ht1SoJWRKlTBpzBMKZAugg3CfjfnVZnZGIMeYHzeqfWeYuwRsHUgg5
 /DNRno9q7TLaMQTSM1wLD1YDG30Q3QeIhr6ETGUYishwe3pv276pYgWqBWoDp1wt3t7r
 JgOgxmo93q5DHaa+/wKmmF5B98+kpbh46JZtzHTDGSzoFB28I9odrHmtdCTXsFPOId14
 RA8OB0eg/iKw62HcmhqcJq4cAj3mAOfGKJV/8W1+NI4PiLZlFLsKmjT9lQEtDWpYtqj2
 veYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793533403; x=1794138203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jrzVMeZ2eLk6wiAi1/uS1gbDMCRA6rjrYE8b8aRMnlo=;
 b=gkE3mGKzXHJfaqSxAFG2bVSZN3Qjr0lZ5dknY2KaChd7aDDsDMt8+AxXsE4d6bBjPb
 ETDZmGnBnmqLm9b/TnRC5u54vok/3gjfbiltSIIv+Ziq8zv912OvRMKydqav4m+1PqFn
 7kKO811JtbTsXtPEABPg+CLXElppWqMcbOBC54Pgb0lcyAX0tx0V3Ych/8bnPEdGMx18
 /CN2D0mLDCiwZLuWcD9/6mYqXeCq+UcZ4dIt/gPu8cuvIJ2TjyNCVuT/SAUBTHvw9uhj
 7LdXu0JZ99hrK8ot9IYOD9VEQ98s5Pipb9Kn7cMHaCy/6pAU1S5eEaEyIZUiRcBdlhjN
 PgJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWXf38ehAn79kPcBdP3N4iNQCLHQ+ab4tX+VcEPRfKVOpOTl3JSHtJrN8xbgrFtd89q4NtVIO6K6D6GeG8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8hBOYpBGYLH0HWcaOAS4pxGbdVdEnkAm0CSwzYrnVTcBJ1Laz0
 U9SW/bNsZVw66kkLOAlqVCQ5os2zxwYAanEltRguYHz0WZzD7STlz0MfniQlz0yCSIcrk5PRalL
 wYluL91bcvphblm/K5Y1G5Wxe11RcUHIeS/6e3P0L59vhZpbQltmr0ZFfWzqpFG1FMOK4
X-Gm-Gg: AYBFou0J1EZAPjrAzSeUCTVcMKd8PAyLM4OZtXu3jdEqqRoU6r0jxwdPz7Jc3tcLP4W
 Emr2hELShC+HeKaO5kFDGjdaSSMk4Kb/t6UulHiInJN+tZaH34Xj1zCdMhyW9ONkKZvmZ6TJwKo
 RE5/f6bpTS5XKGESNEOlnGvwdj0fvZVhUgP+Ta3cXTqS1sipnY4UJep8Cq0pYUM2cuiECdAFG2V
 jf77mgfT9Lb7GMU/hdcUnaK9dSaYmAlerJ5nKX9MyCIkqk0gUhA6i/TDrMNTpG1BkzlVYml11Iz
 1FCoFEFJJImmn2GxVpeACinwPIvhkxTpUn6Lu3QkJQIyD0xVurIiFcoZhJ3rmSg7T43nT4DBl9+
 yDsLyZQ2/rR4bxyJk+UwvbnTQtd2HJYwXvW1hxFhokl4b7ufZWajFcIqEG32eoZnwqAzHZBoF8X
 kh+35Pj60dXuXcUDzfF8Sxxj769O+WZeaQDTh+HnRarZQ8wrgJ1nKUchYprFtYLrj8kYSymFbh3
 G75SzJDW14aS3OhiC1EV4GUZZxSGhDqhr2vSC2x3dqVGNStwH0+OLvJaHpB/dv8ZATOoBfbkNgR
 30BYZPL5lwP08/WwlswhypHKK5zAxpUQlrT+/C4SkppTRBV9p47jELgPoIHCyA3ffsVhPsh+1ho
 7jwqErBzm1tCTOh2irv35maeusOXh/v81uWwvF1olxw+MKsJ0KuF/E62xJKDp9rGa0xDwbcj2pL
 WfmlvCYvRPBzEqbg==
X-Received: by 2002:a05:6000:2283:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-48e7475fea6mr14050235f8f.6.1793533402986; 
 Sun, 01 Nov 2026 03:43:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba5dc2sm13270560f8f.54.2026.11.01.03.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 03:43:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 11:43:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: dd5cb68395e4e2d437ad727e0f2dffa899585158
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbca416fdd71e312200c87051e1316a6c655a68e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNTyD-000000001xe-2b3K
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1319068308918175327=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1319068308918175327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MB07lszBMfw="; charset=UTF-8

--MB07lszBMfw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2067?usp=3Demail )

Change subject: Do not hash real addresses =
of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Do not hash real addresses of TCP connection

With neither status repo=
rt nor max-clients depending on TCP
connections in m->hash anymore, remove =
hashing of TCP
connection=2E

This now allows an obscure corner case of two=
 TCP clients coming
from the same IP and port to different IP or port on th=
e server
but as our operating system can handle this case, we do not have
a=
 problem with that either=2E

This has a small added benefit to keep the nu=
mber of entries in
m->hash a bit smaller=2E

Change-Id: If8ae9cbc971f60800a=
998abf2f97da0384c023f3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2067
Message-Id: <20261030134023=2E19798-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg40322=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 11 insertio=
ns(+), 2 deletions(-)




diff --git a/src/openvpn/multi=2Ec b/src/openvpn/=
multi=2Ec
index 0366c11=2E=2E3f82052 100644
--- a/src/openvpn/multi=2Ec
+++=
 b/src/openvpn/multi=2Ec
@@ -2486,13 +2486,22 @@
 
 /**
  * This sets up th=
e client real address (outer tunnel addr) in the
- * hash map for data chan=
nel packet=2E If the address is already taken
- * this steps fails
+ * hash=
 map for data channel packet lookup for DATA_V1 packets=2E
+ * If the addre=
ss is already taken this steps fails=2E
  */
 static enum client_connect_re=
turn
 multi_client_connect_real_addr(struct multi_context *m, struct multi_=
instance *mi,
                                bool deferred, uint64_t *opti=
on_types_found)
 {
+    if (proto_is_tcp(mi->real=2Eproto))
+    {
+       =
 /* For TCP connection we neither need to be able to map incoming
+        =
 * DATA_V1 packets to the multi_instance nor do we need to ensure
+        =
 * that two TCP connections are not using the same address as the
+        =
 * OS takes care of that=2E */
+        return CC_RET_SUCCEEDED;
+    }
+
 =
    /* If the address is already taken up by another client we fail the new=

      * connection */
     if (!multi_check_dest_addr_allowed(m, mi, &mi->=
real))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If8ae9cbc971f=
60800a998abf2f97da0384c023f3
Gerrit-Change-Number: 2067
Gerrit-PatchSet: 3
=
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--MB07lszBMfw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Do not hash real addresses of TCP =
connection<br><br>With neither status report nor max-clients depending on T=
CP<br>connections in m-&gt;hash anymore, remove hashing of TCP<br>connectio=
n=2E<br><br>This now allows an obscure corner case of two TCP clients comin=
g<br>from the same IP and port to different IP or port on the server<br>but=
 as our operating system can handle this case, we do not have<br>a problem =
with that either=2E<br><br>This has a small added benefit to keep the numbe=
r of entries in<br>m-&gt;hash a bit smaller=2E<br><br>Change-Id: If8ae9cbc9=
71f60800a998abf2f97da0384c023f3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc=
2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067<br>Message-Id=
: &lt;20261030134023=2E19798-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40322=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/multi=2Ec<br>1 file changed, 11 insertions(+), 2 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec</span><br><span>index 0366c11=2E=2E3f82052 100644</span><br><span>-=
-- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</spa=
n><br><span>@@ -2486,13 +2486,22 @@</span><br><span> </span><br><span> /**<=
/span><br><span>  * This sets up the client real address (outer tunnel addr=
) in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hash map f=
or data channel packet=2E If the address is already taken</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * this steps fails</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel packet loo=
kup for DATA_V1 packets=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * If the address is already taken this steps fails=2E</span><br><sp=
an>  */</span><br><span> static enum client_connect_return</span><br><span>=
 multi_client_connect_real_addr(struct multi_context *m, struct multi_insta=
nce *mi,</span><br><span>                                bool deferred, uin=
t64_t *option_types_found)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (proto_is_tcp(mi-&gt;real=2Eproto))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* For TCP connection we neither=
 need to be able to map incoming</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * DATA_V1 packets to the multi_instance nor do we nee=
d to ensure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * that two TCP connections are not using the same address as the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * OS takes care of t=
hat=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     /* If the address is already taken up by another client we fail =
the new</span><br><span>      * connection */</span><br><span>     if (!mul=
ti_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=
=3Demail">change 2067</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2067?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2067 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--MB07lszBMfw=--


--===============1319068308918175327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1319068308918175327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1319068308918175327==--

