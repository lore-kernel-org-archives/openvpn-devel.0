Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392F606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YDD0+kt2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Frpbb/o/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TFR2AOAp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PwLofF4t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zDf1F+EVuljUgbjXly0wgfPfbCckQFswjIqI/kAQi/k=; b=YDD0+kt2QkEo6UrNL3oOhNVPra
	iEA7u2ZxyaGCCQxUCRL4jGRYnopIN9+/ZndS6io4T+qLlU2akRzVoIcHf0id32d5uZoru+yvaWWuF
	UpVAcKz+jKYI2JT+XtZ8R0jaaSs6PPesm5L95MIlXs+zicdhfAJQqjHCRiSDTLRD5JUU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJb1-000000006FM-2tn0;
	Tue, 17 Nov 2026 13:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTJah-000000006F2-0roa
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eKe3XhZVC3YlPwO46zwm8BUQddW0VUg8s5m+WVrio+Q=; b=Frpbb/o/u50YVabzLDPvv0OE5a
 f1j2tddjZojC0hEtcKDBqZBzxZoKT5xfAYHGX+robCvRQ0uNoHMIhDhcJxvDssM7IM5R/HXXrunil
 JH62apQD7sQA49rylobKUh2xEjrYkquc9xZUZV+K/JMeCIKyNnN/f9Duxua4ur4ZSw4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eKe3XhZVC3YlPwO46zwm8BUQddW0VUg8s5m+WVrio+Q=; b=TFR2AOApe2M7vZfphURv20bVLW
 +Wxy8sknAkmTIovqdOt8fuH8aXfhJJmAAl1g7QqIOlh3C8xD3V4ufoEN5Y0aHGqsd5aHUBR5qBmrF
 axW9PUXFvOR3y1vcSPJHkQ1BQajn+QexXBRGbX/8IcdPzGWIHBLWdzD8vvxwBTYrq96U=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTJac-000000002tU-3jVq for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:16 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1959951f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794923468; x=1795528268; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eKe3XhZVC3YlPwO46zwm8BUQddW0VUg8s5m+WVrio+Q=;
 b=PwLofF4tqjc4L5adWI9iaBcLr7t/O1kDfKHY1J8oUKRBwKX6qJwhrtAgxP1cn9MCZ0
 qjiNefOTLLGfNFZNkXNkzYrx6gMQzUaAOWOCCBPRu58Qmyr4b8DQCacbRgjjJ6pVMJbc
 W8Ti/iw2NhBPlOFGR+hTQEkRrUHMwDzL2lCdmvLxcPyfZGag4nawNAq5/GyRup2xgknM
 88EiEe0zjX53SiktrkskZVpeFlTfYPjJew1Fbq7+PnN6/5tdRwjt5lnj9EHkN3dTLgAw
 GtHxDpY3WAHkmiogzMOEg47A/STBdZ6f0K4BiMBv0NBJNamenvxh4upHBlodMny3Y7Sb
 rUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794923468; x=1795528268;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eKe3XhZVC3YlPwO46zwm8BUQddW0VUg8s5m+WVrio+Q=;
 b=kqbrYfLL5nhOhlmgUyVbjcRTmAc5LSIaNQu/4tT1muHIsMhTq1dQ/2XkPvSS9VBhFj
 G6qnZbtp84/RYEWttBrYxwjpxdx5bLUfkagRDz2qNK4WpbxfXE7/fTbUiPjc5+Potmgn
 5VitMMBLhHGiYymrxbrpREBwGfDS/krYslhr1cIfEnkLJjrdLDkaDaruVWeJBw4Hu2fM
 uHeC6iYKmqNlehHWGo+wrDZ8bR+MKCi7d1+z/100F79WNC7ip6yu7n+Lsl7Q59BtbHKE
 IPdeHcAR0hGP3Z83nynMuu/NVHuMenhUdbj7hlZAvgnlwIaHoKJu5/IjOpLmlTJkywtf
 YdUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGNjTTh1HACSOLdT4tNou8QnP4km5EaL4gC13/J3zjY2xaKqsrFd98fZ2bnTMo3op1Iz+s2eb+AsNZuffH5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8WHlpFJ2ZsUX2dKJFWxOt+GH12lwOcjIXqhkxWbVtvCR7gOVQA
 doBnfdZKkdYWdjrU+Roi/sN1r3er/jvriEzmwv7iVg7cRnlgsQomUZXIIcMHj9tqL+nfEWdtZt1
 5hGC0Xp44CMKzbzuh/1DNM0gG2uCukdrcge8iq35XnV5d5wvAdmqsHyC9FbjB9Fx1JPK5
X-Gm-Gg: AZFdTZec28MkqbVibEYCTpq7VFT/ccUzbOGHpnpirXT6IPD4ADW1GtLsVek5/buUnDW
 qt/ePs0PNSv0rl6Spk8LHByKNAHBh+XH8KrHH/1IR5EB5Z/a7X5IwLXijRkHhH9MvJQY3mKnVK5
 HyVOKutisv9/20dZ340E8UvYrfvD0zxuvIjbxq+BRuFUiLlyoHTMFZpgjuKCQd8Q/UevZB0vbcl
 zuf1N1D+JPXG2Sj0g9I2UuIarnX90TkhKx1Xkd7+hTDY5CBAj6zvYsTfjDMDv2jEnFWTMdRaDSi
 3Efu5BMYmXU+2uPy97pxwMDvCiUrFviVZxUkTpO44+va8L33Ir/6m5TM9KFZPx88ywNmyGplAdz
 jQtlLchRZUZKSSP3zIjdIcEkfQ4Yw2plI8c3p0Bee6tRZ4Ac/VZ2qY2njhU9r7LiEdojy9NjY93
 HkBW/O7+pywPGKo6IzNTMEW4xbQZ77/PyiOnaDu8MdnP3mVp4qmIXUPjwoKVrj9dm4NN8/yunJt
 BfUG0K9D3KmXH3dRzKTc8v0ILQrUmJ617Gu59J5q0Sz3Wt8UOw9U0DFjdD7uxOuXHre3JNYYvst
 8Kh5dNBvvN/Q3svCORyoWvSPNhgQA/UEH/RBD4J1eGlz9R8AvIcRHx03iIAh8gNmwjueQ2EUFHo
 ocQRAd6Y25pBHUc/nrzMmDRXkF6rfB0IzBnAfh2GGMMu3eXngKrMN66q03R5+PQt+xoIik0JVAr
 kbHipu0qUNJi48mjrq6H47crWbGLf0towFsQQy
X-Received: by 2002:a05:6000:1885:b0:499:d9a9:5158 with SMTP id
 ffacd0b85a97d-49c727d1e47mr28262975f8f.31.1794923467883; 
 Tue, 17 Nov 2026 05:51:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe373casm27596853f8f.30.2026.11.17.05.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:51:07 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 13:51:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
X-Gerrit-Change-Number: 2190
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2190?usp=email>
X-Gerrit-Commit: 08f9865d6df33b9e4f253edf3a4152ca1cbdb803
In-Reply-To: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
References: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI4MDgyMDAwLkk2MDRmZGZmOWMwYTdjYmJkZGZkMDI1YTcyZTZmMTlhOTZiYjUxNzUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f52a91d19918e99e48eed184f5295614623d0518-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTJac-000000002tU-3jVq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: drop
 redundant epoch assignments
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
Content-Type: multipart/mixed; boundary="===============5784914539941710828=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5784914539941710828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ppz36YF4mk="; charset=UTF-8

--1ppz36YF4mk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2190?usp=3Demail )

Change subject: crypto: drop redundant epoc=
h assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


crypto: drop redundant epoch assignments

init_key_ctx() already sets ctx=
->epoch from the key parameters=2E

Change-Id: I604fdff9c0a7cbbddfd025a72e6=
f19a96bb51753
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2190
Message-Id: <20261116173725=2E24585-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg41475=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
1 file changed, 0 insertio=
ns(+), 2 deletions(-)




diff --git a/src/openvpn/crypto=2Ec b/src/openvpn=
/crypto=2Ec
index 8b4cc3b=2E=2Ea92269d 100644
--- a/src/openvpn/crypto=2Ec
=
+++ b/src/openvpn/crypto=2Ec
@@ -1040,7 +1040,6 @@
     snprintf(log_prefix=
, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_para=
ms, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ct=
x, key_params);
-    ctx->epoch =3D key_params->epoch;
 }
 
 void
@@ -1052,=
7 +1051,6 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", n=
ame);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix=
);
     key_ctx_update_implicit_iv(ctx, key_params);
-    ctx->epoch =3D ke=
y_params->epoch;
 }
 
 void

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2190?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
Gerrit-Change-Number: 219=
0
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--1ppz36YF4mk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2190?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto: drop redundant epoch assig=
nments<br><br>init_key_ctx() already sets ctx-&gt;epoch from the key parame=
ters=2E<br><br>Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2190<br>Message-Id: &lt;20261116173725=2E24585=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41475=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec=
<br>1 file changed, 0 insertions(+), 2 deletions(-)<br><br></pre>
<pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>inde=
x 8b4cc3b=2E=2Ea92269d 100644</span><br><span>--- a/src/openvpn/crypto=2Ec<=
/span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1040,7 +10=
40,6 @@</span><br><span>     snprintf(log_prefix, sizeof(log_prefix), &quot=
;Outgoing %s&quot;, name);</span><br><span>     init_key_ctx(ctx, key_param=
s, kt, OPENVPN_OP_ENCRYPT, log_prefix);</span><br><span>     key_ctx_update=
_implicit_iv(ctx, key_params);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ctx-&gt;epoch =3D key_params-&gt;epoch;</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span>@@ -1052,7 +1051,6 @@<=
/span><br><span>     snprintf(log_prefix, sizeof(log_prefix), &quot;Incomin=
g %s&quot;, name);</span><br><span>     init_key_ctx(ctx, key_params, kt, O=
PENVPN_OP_DECRYPT, log_prefix);</span><br><span>     key_ctx_update_implici=
t_iv(ctx, key_params);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ctx-&gt;epoch =3D key_params-&gt;epoch;</span><br><span> }</span><br><=
span> </span><br><span> void</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail">change 2190</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I604fdf=
f9c0a7cbbddfd025a72e6f19a96bb51753 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2190 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--1ppz36YF4mk=--


--===============5784914539941710828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5784914539941710828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5784914539941710828==--

