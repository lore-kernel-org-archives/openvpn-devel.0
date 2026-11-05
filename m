Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD760606A32F
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VOmOHnBN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BBAqFes/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bs70sCSW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dzvdKe4A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f6T8lWqcFafEXn7n54tadDMEvBkRI78C5/KY6QeWpT4=; b=VOmOHnBN3c/pxZQsqha/NTlQsP
	GXC6BqVicCQAjmAmCdgu5qLGAHmskxtKUGyi9/ZsnbCzhSgB4WozyuXmYjHCYQepONgBeLqkFD3k2
	suKTNxAJ4jBtgY0LEYesfKDwnG7GMmVX9AuqbTto5115Ew65Ucnd3+T4iBjjB9+xdl8A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0fs-000000005Nh-3Bqj;
	Thu, 05 Nov 2026 16:50:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0fr-000000005NS-17NR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xo+VNAWsSHWjI6UYemBlaDPI0KCIc6U1z4VF8UGZylg=; b=BBAqFes/grKN2FJyOhxahw2Njg
 F//kC5WoUHxBSxqeFtYkh+3aaUNqLNpb3uyyt1H9PGSJSf9qxVhHdeF4QU1ST4PBFRveui3bskFh3
 0fOr8HQ4D2LxElvRyyZBBzI2381g2qI7bxYw9XKTBpK6h3QI9fnfzLia9HtjNM20hDrI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xo+VNAWsSHWjI6UYemBlaDPI0KCIc6U1z4VF8UGZylg=; b=bs70sCSWQg6x28Z4GSLZnvqOib
 +I/yuhZ6pFFGij7l1zuLNRHTfGjvcz6tKijat2FojGMTS3vMnSFX/zlTWyZa4wJZgnxQZ5xU4rO9p
 vJfKIquto3vtndOJRV8yk2DsE7tRFtk5ffM9wn8y5okmyiCd6FNZNXPU81MuUchZLbaY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0fp-0000000078L-2Z9o for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:51 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so20592665e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793897443; x=1794502243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xo+VNAWsSHWjI6UYemBlaDPI0KCIc6U1z4VF8UGZylg=;
 b=dzvdKe4AZL8C7eqsL/Ld3vm/ec/IdJpqTv1rHMzkKhz1dqMrGA9bzCpeAYH6Izt79Z
 KWDwZ0ZIo+Z/ZMDYe/wXyCoV4U3uL9ZYYvRlo7lUb/pC1H9zlcIfihqI3v8igFUaRuBw
 Y50NxpYR4bdnQv4B3WkH0v208VwTOajPeib2H6qqNnDFsnSQVbHld/OTYnykI+hO455N
 uNQ1+TqKX33Lp6giKNH6y1VYDkfnpNq0x0TY3/6Cr+Myw+BRLrvY6hoMXJln3Gsv/PyU
 E2VLyOPNRZ40ZSIvhgIzdXSsNDsE5bVQMva7DTeBTChaLeI6D/HJJCNTVQb+U0ukknQQ
 CTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897443; x=1794502243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xo+VNAWsSHWjI6UYemBlaDPI0KCIc6U1z4VF8UGZylg=;
 b=VfMyXpRWF0LZQP9Rm/KB3yfSiM3Sl02XSBBrEECJJhzgKYmsSD6RIAxX5kG8Q9xjH0
 VpHfqJ0uLymUHUxEvOpVv2XRwybJeg4VrnpOETlsEZnE26LoEzI9tnQMgdJvbwOB9Hc7
 YlvMcMiYXniTDaA6WYeYgBziYSo5lmiEddyteeEPxvo4AtKcFoMMgXuTzqPctWgQBtaS
 RNE9ktPEM7QsVlZoEeaBXcVb5KVJHF8SNTI4AJisFsNrWCr1nmpv6WRx+9RxeMyis735
 6iJqlSsv7k5qz3xJ7zwko69KyEFfFyAlWBHtPGjqb9xjpDOLauDGpaLhuCzvkyBRLzhN
 gDTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCVg02Lf87eCJ9k/pP7au5hqHQnhVEFn+DD13sp7Rz7s0TXy8PUA6oahJpc9eQ3XGz8lai+fZPROPZdCLM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+9BddROueWdyMjgMZCUdAZFOUgaHWpCU1NZAsx9qjHu8HN7pYP
 Q1M7XjjFfi7pkILuo+8rmT8hLU0FcadxSvSs1PDSvobqyxA39djm4C8ib+FPfNnN4sT8DCJy2f7
 7sztPNg0t+ogD3WGbhFod+fCjsxWk03JO4vgSdL8bgIRb40KhuJwc0ksYU1Ype3CnZRV8
X-Gm-Gg: AYBFou280+3lnyIv0bPjaydQ1WwEhIrUNuHq8ZWRe7UahaZRLxwUHuLLbxxosJddE0F
 jpeq46k+gzwWVpsku184VsBZ+NrxVJFoW3BnKehqeNNZYM+7azJLgNwuaXrbNbLuAPRBQx0p8mX
 XBAnZiccujl+HoWo+hWozyQQ2bVNvNObyGxpH4XSVQBsOf47kW2f7wC1CPQZS8vgb1KBqNJZv7w
 TPDd50iaQQ1huW3JVDhhl1ASCFrQGwQ4qjrXS/5SZbPGqoK3fZi9+6PWcVIh6uKRWN9vXkUzZET
 FQ6k0eS9CjOCRwMkIafnZ5Jmi6YN/plIWZna57L9YTpT5FWrxZPP0QV4v55qXaLV9OXJs4WLOuR
 5N32WYuB/CpuTyeVq4K7OTctJc2vNamNnlJhOZRfJpAHiXoq09N4wJZRi/NVos2+HT0onIEmA5n
 Q4TxHPm2DFMt5sWatnhxcXrIvpyUvJwg8vNvn/067+IB9tcBw6tiC/azxIQVvxz+ZulSfoPhULk
 5O2KKoXKg87aJAFjXNOOy4sT3gkuAj+GvyMlZuZR2IG+cWiXiClP5n66qOewJDPXfigU3rZS8eP
 4+y485zu1bpdU9c/37KoAXs9ivchWAWyY3H7YgRscByxkuLDiAx82K72rnuoM1QMIUO5pCy9qiw
 mMewlRZ0wGL0oc1dlqtE9YbJ0wn8drK6S2Ei2g/9dX1oB3vjckAck7LdE6LJpeAzac8hVLcWOl7
 G674Tox6hwwBPd/6hbXtgmDemznazMtD+iakM=
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4ac182dcb6fmr426503025e9.13.1793897442873; 
 Thu, 05 Nov 2026 08:50:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm128443245e9.3.2026.11.05.08.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:50:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 16:50:42 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
X-Gerrit-Change-Number: 2075
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2075?usp=email>
X-Gerrit-Commit: da6659452a34b5c94b20f55cbeb96b9ba70885ad
In-Reply-To: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
References: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzMyMDAwLkk0ZDM1ZjU0NDAyNDYwYzU4NjZhZWJhMjYyMTZhYzFiMmQyZjhlYmRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f97c0dc7538ee66e12f1fca3101d301720226c3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0fp-0000000078L-2Z9o
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: Wipe the key
 source material in key_state_free()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7970004408811186645=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7970004408811186645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AWRxNde9I/Q="; charset=UTF-8

--AWRxNde9I/Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2075?usp=3Demail )

Change subject: ssl: Wipe the key source ma=
terial in key_state_free()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

ssl: Wipe the key source material in key_state_free()

ks->ke=
y_src holds the pre_master and random values that the peers
exchange in key=
 method 2=2E It is wiped after the data channel keys have
been generated an=
d on the error paths of key_method_2_read() and
key_method_2_write()=2E Whe=
n a key state is freed before the keys are
generated, for example because a=
n --auth-user-pass-verify script or a
client-connect script rejects the cli=
ent, key_state_free() frees it
with plain free() and the key material stays=
 in freed memory, on the
server and on the client=2E

Wipe it with secure_m=
emzero() before freeing it=2E

Assisted-by: Claude Code:claude-opus-5-5
Cha=
nge-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
Signed-off-by: Hansaem Wi=
 <hansaemw@gmail=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075
Message-Id: <202611=
05093720=2E11781-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40746=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file =
changed, 4 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index b701c0a=2E=2E420daef 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -930,6 +930,10 @@
 
     free(ks->=
rec_ack);
     free(ks->lru_acks);
+    if (ks->key_src)
+    {
+        se=
cure_memzero(ks->key_src, sizeof(*ks->key_src));
+    }
     free(ks->key_s=
rc);
 
     packet_id_free(&ks->crypto_options=2Epacket_id);

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d=
2f8ebdc
Gerrit-Change-Number: 2075
Gerrit-PatchSet: 2
Gerrit-Owner: Hansaem=
 Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AWRxNde9I/Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2075?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: Wipe the key source material =
in key_state_free()<br><br>ks-&gt;key_src holds the pre_master and random v=
alues that the peers<br>exchange in key method 2=2E It is wiped after the d=
ata channel keys have<br>been generated and on the error paths of key_metho=
d_2_read() and<br>key_method_2_write()=2E When a key state is freed before =
the keys are<br>generated, for example because an --auth-user-pass-verify s=
cript or a<br>client-connect script rejects the client, key_state_free() fr=
ees it<br>with plain free() and the key material stays in freed memory, on =
the<br>server and on the client=2E<br><br>Wipe it with secure_memzero() bef=
ore freeing it=2E<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change=
-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc<br>Signed-off-by: Hansaem Wi=
 &lt;hansaemw@gmail=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karge=
r=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075<b=
r>Message-Id: &lt;20261105093720=2E11781-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40746=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 4 insertions(+), 0=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec</span><br><span>index b701c0a=2E=2E420daef 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span=
><br><span>@@ -930,6 +930,10 @@</span><br><span> </span><br><span>     free=
(ks-&gt;rec_ack);</span><br><span>     free(ks-&gt;lru_acks);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;key_src)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(ks-&gt;key_src, si=
zeof(*ks-&gt;key_src));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     free(ks-&gt;key_src);</span><br><span> </spa=
n><br><span>     packet_id_free(&amp;ks-&gt;crypto_options=2Epacket_id);</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2075?usp=3Demail">change 2075</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2075?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8e=
bdc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2075 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan K=
arger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--AWRxNde9I/Q=--


--===============7970004408811186645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7970004408811186645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7970004408811186645==--

