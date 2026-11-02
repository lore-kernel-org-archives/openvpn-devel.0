Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA382606A32D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cXdD2TsL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iZ8QJcRQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lQcVY1kW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C2WqtvEr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=39dzlaK+hDC/E5Wj7YgaYZ1u4lB4G/wl47zU+XfDWgA=; b=cXdD2TsLqgmnoKJn5YMH3qZC63
	GYAm4QQIRCkEP8GiLdD02PQDIvq5nj2syP6XVzAaYKAPjq1qZSVqlEEkM0L7NaYFhnewm7HCQ/05H
	iAuVSMswznAZ3B7XiPapF9SmHtWtJCZFVc2VQe1bXnjzdGyrVWyLHHWhatRuleMuuM0w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq6W-000000003Q9-17B9;
	Mon, 02 Nov 2026 11:21:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq6V-000000003Q0-1TK3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2HRxeQksNbOWuKJRlmX8YxmENHIN2xIOqHL+hnOXET4=; b=iZ8QJcRQ4tsfp6Y132CZN1wFj6
 n+soa4nOsQLkny34jhbgIVulRUQcDTNCP/WrJltaaBHJfwIin6vDj5PUhJDLue7GsEWNSeYeuuJXH
 zZIHrYLkTm+MK3o8mjxqSk9X+2aSbjV5DkpSrWt88+F/vGuHJc9I24cKppx+DTCBTt6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2HRxeQksNbOWuKJRlmX8YxmENHIN2xIOqHL+hnOXET4=; b=lQcVY1kWK5pVMRKfnXwOz3aSra
 iuy84shz8OjYTMbco+a615l8BXYVg0k/5J1CVtCc0vb1Qo/n7/Vy3MO6g/hmJAf3a3ebWXL0+8j61
 cUFfVt9kB3JtxlHR9CmGhju1yjxuzBIYaoYUUxJeVxGTKB9+bHJNVlO/jOWp27QiSy0Y=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq6S-000000004ew-36gu for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:21:31 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so2569229f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618482; x=1794223282; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2HRxeQksNbOWuKJRlmX8YxmENHIN2xIOqHL+hnOXET4=;
 b=C2WqtvEraGn2eLy4vtOTcRC4hrjX3FMLez9UjrSfd932PEHl+FOwR6El6xoU1VPvhU
 9V4aujxzyBEvT+MAEWmNldQXoxEVjmtmZ2SPgfvGEc0UE9+VmfdPlQEnuPk9Ys9ibdDq
 i4dwKyCPWepMetBQiAKVMX4PuLA6TBFMleNww9VyxGirmSaJjlQ1m06lfSwxEzLu0JVG
 SzvZ0Rn01zLyBu1ZP43aI2RIYk8a1shUAE/okgdUg82Nd1Apd7odcgJVZW5wOSMzGCbt
 EuY2TZe12RYmYAE1rBpz5JCGheD0cvdrfE4k5E2w/hccGoW/LP5AgQJ54uhoYMNJxMHw
 OGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618482; x=1794223282;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2HRxeQksNbOWuKJRlmX8YxmENHIN2xIOqHL+hnOXET4=;
 b=REqWyyuTWJVeW1Dpg21o5ONc5mC2Ri5/aEaAtyJZCROtnhhi7qe++j/HwlFM9URKr6
 /oIqGKlGU3XbxcNXwbxHgR7Khs/naHpz+aRcy3gsvQB+pYPHjZblHonrY+6Sps9/Q2FY
 I8P5AKTUl2F7atkSGd2dfcvEoGUeksE+gfNyAe0qyZn7zoDvNtBgNfg/P9ZoYDk1OQ+T
 hf2VxKM0gMD9eHNzUu3I3Chr/8viVSG6sXalPv7F9pEyXRNWh2D5HcBLrM9fT+u9W+gb
 S2OSNIHKZLzgEsQOEFF2LgPD2D+SnbC+V8kgs8TFXnBsa0ZC/i+9LFGNA4+Yy1u1Ccy6
 S+4w==
X-Gm-Message-State: APuU4Z9d7W3CVh0NCi3SnvyQwJ614GmURrDpe2jy7Yd7xpperUGcyrwO
 ulKw97hG2xuXvI4zPyF7HQPhIO1jDQE9WmquTfjZfk/tEzQHgAHpaX4y36JIpDbuB3j92bzIxWN
 URo6lAsCfwVAQqMVXg4VizHsZy2qwC4QLXHB3E9ciZ7EiGY9aA3Yk7iDuuqi3wmNICQZ1Z+kiXq
 Nj87PhSQ==
X-Gm-Gg: AYBFou1NF2L8vBKTLr+dsWHb/BKoPTwrAnnUBT3CuVJlLYTh9787yZzGbNp3nd34lL8
 VSsmp4k1YplPQHQC35LrlLCch9sAa6MW1ft2xlqMjQSN7Vl4LHozvIQEGSFv96Ap2HroRselkxE
 rfKjlfUvWn4M8cdxRfe4HbGDl4vWURPKPEpXS1fBCQN1vAXCCU4SCVELqiu2nKwES8otJNgKv6w
 n3vFTY3o9UkD+V4zKOdDFnm/eUbJP/g5UcS57KU4+STleLt6dhvoJ5RZVWd+S5ZKD99d1skgfLp
 ijq6WKTz6p3zwL91SsCFPsvUZiULXfGNy1OrDGdUeI9A6O+S5G53pXtgF8maCdCRn1NgntI5kw6
 TGC7Z4rfYaa7D1X66REps1yKPisyvcSQiIbb1TdbcXogsgxGpzqIQAG/k1z6yj+7b1O+Uc9RJHv
 uXQHPdGqJ8iMEj+Zv6fp4OgnlG9QRHKior6st8UHG2yRo8G2GXUvEpaeyGx1XUw4p932aDV4p2x
 j42S4UQjnkzkpimEaZSIp59cQIDW9sQREn2xPcC0MhHwFzt8naQhxCwQQ5D9PhxMSk+EPm+tfHI
 3Fh5F0o10RQFGTG4P9n/Xb2UL11PQjureHSespEPnNiuZKXzsyUA7xsp029B81a9mVXLrDDT3hU
 8TSgUwb3C/g21uleQZg3J0+fnnf8XoSzJERmH7ORZHXNCjzdJZfX7M2XdmzAVKCcs09oBnRAcYM
 bpb3oJs06UThUnUQ==
X-Received: by 2002:a05:6000:2911:b0:48d:f730:bda8 with SMTP id
 ffacd0b85a97d-48e6e50b1b8mr22635785f8f.50.1793618481977; 
 Mon, 02 Nov 2026 03:21:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7815fsm20008301f8f.22.2026.11.02.03.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:21:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:21:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
X-Gerrit-Change-Number: 2083
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2083?usp=email>
X-Gerrit-Commit: 30b20ffbe71b4d293ecb48c0e3b3551137beef75
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NDc5MDAwLkllMGY5MDJhZTVhYThlNTQ5Zjc2ZjJjZjMyZmFjZGE0M2VhYzE4OTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03d6310415805a8038e62289050c1001e79163c0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNq6S-000000004ew-36gu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: append
 cipher final output at buffer end
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3850260199752348751=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3850260199752348751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O3ATLALMIyA="; charset=UTF-8

--O3ATLALMIyA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2083?usp=3Demail

to review the following change=2E
=


Change subject: tls_crypt: append cipher final output at buffer end
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls_crypt: appen=
d cipher final output at buffer end

tls_crypt_wrap() and tls_crypt_unwrap(=
) passed BPTR(dst) to
cipher_ctx_final(), which would overwrite the start o=
f dst if final
produced output=2E Use BEND(dst), as the tls-crypt-v2 code d=
oes=2E
No functional change with AES-256-CTR, whose final produces 0 bytes=
=2E

Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/tls_crypt=2Ec
1 fil=
e changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/83/2083/1

diff --git a/src/openvpn/t=
ls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c7975=2E=2Ed015004 100644
=
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -191,7 +=
191,7 @@
         int outlen =3D 0;
         ASSERT(cipher_ctx_update(ctx->=
cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         ASSERT(buf_in=
c_len(dst, outlen));
-        ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst=
), &outlen));
+        ASSERT(cipher_ctx_final(ctx->cipher, BEND(dst), &out=
len));
         ASSERT(buf_inc_len(dst, outlen));
     }
 
@@ -247,7 +247,7=
 @@
             CRYPT_ERROR("cipher update failed");
         }
         A=
SSERT(buf_inc_len(dst, outlen));
-        if (!cipher_ctx_final(ctx->cipher=
, BPTR(dst), &outlen))
+        if (!cipher_ctx_final(ctx->cipher, BEND(dst=
), &outlen))
         {
             CRYPT_ERROR("cipher final failed");
  =
       }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0f902a=
e5aa8e549f76f2cf32facda43eac18915
Gerrit-Change-Number: 2083
Gerrit-PatchSe=
t: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>

--O3ATLALMIyA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tls_crypt: append cipher final output at buffer end<br>=
<br>tls_crypt_wrap() and tls_crypt_unwrap() passed BPTR(dst) to<br>cipher_c=
tx_final(), which would overwrite the start of dst if final<br>produced out=
put=2E Use BEND(dst), as the tls-crypt-v2 code does=2E<br>No functional cha=
nge with AES-256-CTR, whose final produces 0 bytes=2E<br><br>Change-Id: Ie0=
f902ae5aa8e549f76f2cf32facda43eac18915<br>Signed-off-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<br>1 file=
 changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/2083/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span>=
<br><span>index 23c7975=2E=2Ed015004 100644</span><br><span>--- a/src/openv=
pn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br>=
<span>@@ -191,7 +191,7 @@</span><br><span>         int outlen =3D 0;</span>=
<br><span>         ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(dst), &amp=
;outlen, CBPTR(src), BLEN(src)));</span><br><span>         ASSERT(buf_inc_l=
en(dst, outlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ASSERT(cipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx=
_final(ctx-&gt;cipher, BEND(dst), &amp;outlen));</span><br><span>         A=
SSERT(buf_inc_len(dst, outlen));</span><br><span>     }</span><br><span> </=
span><br><span>@@ -247,7 +247,7 @@</span><br><span>             CRYPT_ERROR=
(&quot;cipher update failed&quot;);</span><br><span>         }</span><br><s=
pan>         ASSERT(buf_inc_len(dst, outlen));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!cipher_ctx_final(ctx-&gt;cipher, BPTR=
(dst), &amp;outlen))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!cipher_ctx_final(ctx-&gt;cipher, BEND(dst), &amp;outlen))</sp=
an><br><span>         {</span><br><span>             CRYPT_ERROR(&quot;ciph=
er final failed&quot;);</span><br><span>         }</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3D=
email">change 2083</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2083?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2083 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--O3ATLALMIyA=--


--===============3850260199752348751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3850260199752348751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3850260199752348751==--

