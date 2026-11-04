Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AED606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fcuQpRzo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BaIYs2oN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e1/V60U3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T0gAyVP4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3nKL97c8/xM2AGcY3kxzFbwJT6iaBlyOH+yzu+KqtQo=; b=fcuQpRzoS+Ejnm1fL5IK+d9Yya
	v69w01l+V3jk8RwpFT856aS3HVFkCxOEvv39AHsKf5yYT99piybLNaHpfUxxa18YSiJqCw0U+OKvg
	6MULLYP2kLCgdbK4gZx0A1bmgdZtlouO8yjoMK+KBuRWn8X3Uxf7HAluZkVuREWKfHa0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xObVl-000000003EY-3w5l;
	Wed, 04 Nov 2026 13:58:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xObVk-000000003EQ-1Pb5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZsAvL7EiM5lkJ/jEVWijf/lKyzqJ1prTWA2SPMSuSGc=; b=BaIYs2oN6WkIEGmSy/C+UCO8fB
 1znW6Tt9MPlKKCVKjJaatDOE3XfEIV7tDu4zdSe6vzqWZ8NF0rUS7YlSCAPT8biSlPHSJqbmR6eSN
 16oKNB/Xc/Mb/zWlbcAWrNmFT4ZvQOn+NYaeeZwEXT9IlzN4J+jnG9g+3kB0CP8laWq8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZsAvL7EiM5lkJ/jEVWijf/lKyzqJ1prTWA2SPMSuSGc=; b=e1/V60U3TZ3yCLJh7PmRP2GE+l
 Zt+k03AIIr7b5gr2n2+g8Xwxs76GlR3gQrlDbXIaxv0ZvZSPe7/r410rsv1wTkXhRkaYmYDxGfsCj
 w2gmn27tqG+6fk/1se4CFNuHy+GrN58ln7e0NIV2aoWPxRCLeCnQjgjygnrqU59jWFnw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObVj-000000002Kp-1rv7 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:58:44 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so6893895e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793800717; x=1794405517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZsAvL7EiM5lkJ/jEVWijf/lKyzqJ1prTWA2SPMSuSGc=;
 b=T0gAyVP4zuYSDO08/GBEyrHnySYUuzlsqshPuDZojxnmHFbsVedOFXTkvYqXtxm2Ol
 xQRDTGkTQrglDcerUotx5NmjlervBt4veZLermnFeU1UWar42+uZf34RguC99ZY80709
 99BLeEwVwH2jzvQv1KHp1uukVVG7OGgbYnpMAI2hLkqzQ36dvAlg7Jo09xqk6moA5M0P
 YDNhh7Q2t2hoa/YhoNufcn1o0ryCSPSY9OrKt9sA50+bccnyVbSsoazKrQntPIsnluDD
 GZe4GSy+9xx2xKZd46Hp29CwnbeFLxLg5XnbJ8nzTHQpp3Nj1BCcfzUMjqJWlKQWAha9
 Mi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793800717; x=1794405517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZsAvL7EiM5lkJ/jEVWijf/lKyzqJ1prTWA2SPMSuSGc=;
 b=K+npzI6QnsRp90WeVeVTKvRvAQX8TwKp5fA5THBeGmo+B2fpKhp46/09HiRWP+oYoy
 akPypnMYuyg4qYFj32/OK+jfEmpLfwzbe7iV1V1jVaV62iBR/MSplF6llmQR6mU3l+Bq
 aJVXXFThZQX5TsT6R6Pdl5hwWe9WxL2L9d2TxXqvlWNLgszdMU8/46t+aD1PU5lJ6W97
 j7oKoYL4MnOaSTUBGe/xnLlUesCj6rXOn1rRpE+F3+DYB+vNFR1yTWzebwRPCfxnGFLT
 nIz9It+tJpd4xjNouruE8HyUcS1dvlRJPvZ8XuptUjDxQhGcy/uWcb7zOS904pbKP6FF
 aEKA==
X-Gm-Message-State: APuU4Z/yJCsyZOCZNN6KQt+pPzvSyu09EtYHiN1aVkcJQ4uEbQzOqZq5
 yFS8ybx32zN836If1UKkUtcKgn4k0zcMUTaBei0bkH4nsOwgaRn/Vg0sspd8o4JZU1jgGfdxAUH
 jDu5ZyC5JG2Fe9rEgw/FFre/fGIbLNhD0+KlnMA5w+TmtNuF/bAcfg21+m2JRMVd7NvZCqlL4oN
 vUjU4MRg==
X-Gm-Gg: AYBFou1OEPZiA1mZ3Fmgy5UrHyxqZywILt4oMFw1dwBjU1oF0Gmk6N/ZbqIj3YF1qcH
 8sOArCeyRbaz8Ov6SYrWKaN1M/llI/ndpp40xvo6DEZHtTlEGx66DVk6dbiwhbp0XdFj8J+19d/
 tQFNKqo+qfrLLLoerEOHKDJSbmVCpEuqcZc8brzg6GAUKDlG5/bWqXgz9gqNIyyfbCX7N6Olnv4
 Md54jGuxOola74E3Xaviy5/6Wws4S4TFuwq0upCtr6eKO1xfmwtXKz99cqMotikJDC1XxTkg/ry
 E2mOIOe0E0LuZElb1+zNgL9PpFsaYLCXUKpccls7EZffU0M/IeUNN/zFXCWhbNdezoTXDlNPfAc
 GIIgbGR1vdYVRRlBPJi/b+eUxMVMKxcXs574ueUwkBh86al0dqqO9wUdNBqcMsPpd4rApD21KvJ
 L/jF79i85EzimixbEycSzgO2HLy2kmLAt5ArXDaA9sgS4D3znWyLowNHuNiAF/D/pd+QCbcgkwS
 SR2MSV+Q7khEsq1uas718D25zxKuyw8Nx3D8cPzUeMrrlZuVpVHJUTW5Ay11YTp1+MFhM2HWwbT
 MXwmEsd2Jrf9d2lJyd2pJ8JSO/Gq4c1DOVxMY5r25eK++6R7HwOS8OnCQAwgGGstsMur8N3o84y
 lome4ydtR0zl8WTVWXxK91EPdS1T/Suyz5UpjTAGtqQIM2EYxJ82Qfj3FOpYl1oZleAuDp9U26D
 EtlJTVPosR65Vqbg==
X-Received: by 2002:a05:600c:3547:b0:4a5:cfc:1e95 with SMTP id
 5b1f17b1804b1-4ac182dbb5emr352261605e9.33.1793800716544; 
 Wed, 04 Nov 2026 05:58:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm156807025e9.0.2026.11.04.05.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 05:58:36 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 13:58:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
X-Gerrit-Change-Number: 2132
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2132?usp=email>
X-Gerrit-Commit: c4ce73b3e17a4772502e33ffb40bbfef7266f126
References: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAwNzE1MDAwLkliMzNjZTIzNDQ4OTU5NjczYWZmZGZkNDYyYjRjMmNmYTlhMDE1ZjU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45cd8a4bc1d361f8c8f8e5a5166cc71d1cd48246-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObVj-000000002Kp-1rv7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push_util: use
 string_alloc() instead of a local gc_strdup()
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
Content-Type: multipart/mixed; boundary="===============0902313806271620490=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0902313806271620490==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6P0VnYndINk="; charset=UTF-8

--6P0VnYndINk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2132?usp=3Demail

to review the following change=2E
=


Change subject: push_util: use string_alloc() instead of a local gc_strdu=
p()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push_ut=
il: use string_alloc() instead of a local gc_strdup()

gc_strdup() duplicat=
ed string_alloc() for its only caller=2E While here,
fix the typos in the m=
essage_splitter() comment=2E

Change-Id: Ib33ce23448959673affdfd462b4c2cfa9=
a015f55
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/op=
envpn/push_util=2Ec
1 file changed, 3 insertions(+), 12 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2132/1

=
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 34=
cb26c=2E=2E0c27575 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn=
/push_util=2Ec
@@ -78,17 +78,8 @@
     return buf;
 }
 
-static char *
-gc_=
strdup(const char *src, struct gc_arena *gc)
-{
-    char *ret =3D gc_mallo=
c((strlen(src) + 1) * sizeof(char), true, gc);
-
-    strcpy(ret, src);
-  =
  return ret;
-}
-
-/* It split the messagge (if necessary) and fill msgs w=
ith the message chunks=2E
- * Return `false` on failure an `true` on succes=
s=2E
+/* Split the message (if necessary) and fill msgs with the message ch=
unks=2E
+ * Return `false` on failure and `true` on success=2E
  */
 static=
 bool
 message_splitter(const char *s, struct buffer_list *msgs, struct gc_=
arena *gc, const size_t safe_cap)
@@ -98,7 +89,7 @@
         return false;
=
     }
 
-    char *str =3D gc_strdup(s, gc);
+    char *str =3D string_all=
oc(s, gc);
 
     while (*str)
     {

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2132?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
Gerrit-Chang=
e-Number: 2132
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--6P0VnYndINk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">push_util: use string_alloc() instead of a local gc_str=
dup()<br><br>gc_strdup() duplicated string_alloc() for its only caller=2E W=
hile here,<br>fix the typos in the message_splitter() comment=2E<br><br>Cha=
nge-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55<br>Signed-off-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/push_util=2E=
c<br>1 file changed, 3 insertions(+), 12 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2=
132/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_uti=
l=2Ec</span><br><span>index 34cb26c=2E=2E0c27575 100644</span><br><span>---=
 a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2E=
c</span><br><span>@@ -78,17 +78,8 @@</span><br><span>     return buf;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static char *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-gc_strdup(const char *src, struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char *ret =3D gc_malloc((strlen(src) + 1) * sizeof(char), true,=
 gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    strcpy(ret, src);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* It spl=
it the messagge (if necessary) and fill msgs with the message chunks=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return `false` on fail=
ure an `true` on success=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Split the message (if necessary) and fill msgs with the message =
chunks=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return =
`false` on failure and `true` on success=2E</span><br><span>  */</span><br>=
<span> static bool</span><br><span> message_splitter(const char *s, struct =
buffer_list *msgs, struct gc_arena *gc, const size_t safe_cap)</span><br><s=
pan>@@ -98,7 +89,7 @@</span><br><span>         return false;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    char *str =3D gc_strdup(s, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *str =3D string_alloc(s, gc);</span><br><span=
> </span><br><span>     while (*str)</span><br><span>     {</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
32?usp=3Demail">change 2132</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2132?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2132 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--6P0VnYndINk=--


--===============0902313806271620490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0902313806271620490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0902313806271620490==--

