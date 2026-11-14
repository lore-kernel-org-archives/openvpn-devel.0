Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E6606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YUeXlyYV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kvn9m8ZL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lycS/rtY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TfardawS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=62pKNiGt1+lVsT8CS5PHol4KKkUcR34/49jBy/Kl588=; b=YUeXlyYV33OXHb/xMbAWWokaXI
	0qDexS/eP6EZnGX/CC9eMs3dWvbklA5dJaqJYMqOD1TTKhbyZvwBWv3nUM63NKW4z8H8WiHGSQzUX
	DGWfN728BlnFyWahKvUOVdi5P3XUpcETSiIiOdyQeCatYWya8hMNEyD7alFEMJFxQQ7c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGmM-000000004ga-24ks;
	Sat, 14 Nov 2026 16:39:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGmK-000000004gD-0R9w
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h6GRM7c9LXtwXeTbQwJt5wD1FqVImpCBKRX4gR2urSQ=; b=Kvn9m8ZLonj/mk1SDOgoCFZ1VN
 xOz6IrkiDlWoAvefnbT1T0mLPaXksbCXPlwOH8SVyo4MxFBs61WyJVeYAjG7MQGdOrEvLWFCnAZYR
 RTcf0wVd3uFXFguDWPaXF03rDfzLTGI89QHUn/PzS65t4e7kvBXXrjGPRK5AExDvDbww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h6GRM7c9LXtwXeTbQwJt5wD1FqVImpCBKRX4gR2urSQ=; b=lycS/rtYsUjSHaMWJSzCTocUk7
 2QMJoExYCmMboSECn6zy1SvotMGWZF7Sxcs53Hf+G2gnz+bHxcDiZm8YE8hdA0NSE4Q+4VooBSohN
 2kpIJA0B6ea7HYaE8ahBfdW9SKBae4SeAjiu4bebYveVd8787jPmTBwZHT3TEbZY4QpI=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGmI-000000001tO-3yAS for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:38:59 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so31635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794674332; x=1795279132; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h6GRM7c9LXtwXeTbQwJt5wD1FqVImpCBKRX4gR2urSQ=;
 b=TfardawSswfxS0zzKDYaQIfVr7bvYwUX6evhHwY056oJZycjMqp70Do1PcbDcPpwGv
 jSKv+t3yHuzPuLlnhBLxwWz2MvexrOs6D9KMEZ7ZDBuapPafzWeXHB6v+OtgVfCvhbgS
 dlahTMjD8uPCGBP+ztz+3FRKREr5EQMNz/eFGurGMsMkAOmyz9dveTlf6a4Ex3/mAjbY
 laIkFcMBrgF65obvguRQMcRmnu7eCl01U7I8GXov9Imr6tNILzh2C5fkGE3hmG8JAer6
 rrd4SCVYK+sflCBYmXHA8m7EONXCE72yPJuU9//ONGA7YgTCpobJDxV8suyyojAIw7po
 uBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794674332; x=1795279132;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h6GRM7c9LXtwXeTbQwJt5wD1FqVImpCBKRX4gR2urSQ=;
 b=Y4Nu7lzrdC+jkUhVWuuD2l97jy8HqVHp2rRuc6U/M0xPWM3RcZJ+Pne4ZD8dL4JQ0F
 0sjiyUEQQKUc1jVBqX6Yk+lxybjLh37ci2MTDgezC3sCNGc/iLw7bw+W6p4qSCO1acZ7
 Crpkr75srrOZ41SMJnW6CuWIra23+T3vRYDfiLH2QR8BbjHyYFyl/qTKbUl9YTNE1dMb
 4KqyImv9O3s4fVSSlU+Hvdt9Fvz/mQnUMpvcJVOVbNWkjZ8P8Z7NNxaYHFLkrDBQMq0+
 mMQ6nhysWg/7vgMRsGHZjzxCmojeBsxtzWN4G0AYWJKVhVLAVWKVnLwpoGtvKIaTpiOv
 1bKA==
X-Gm-Message-State: APuU4Z9e5sWWrP4ZuTQXOEdLyIOtSXzPxL9Ju4en8+LiuAJSkSzVTnN8
 HNp7Dp3rYP/ZiByvb879pnPA4tAdegmN+1s5q18kLulRrSSYi3N2k4v4fsF9e6Dt1gOx5gmKsMN
 YIWSpR0PYO6cSS7AhKdKx1v/atrnm8+CQ1JmpUkEvRFmpQXuDDEso/dBaZxJyCfDNloho
X-Gm-Gg: AYBFou0QIjmfUMHZJqSnTNqJnSEYWmG96GmyXuhO1BccLJDhz93F+fmv/brcxWGrw77
 I60rSE4apayd1oOPOHFj5JKIDR5LESgGPKwDnJPZE9mQLSTxhrQWwarX7a+rd1kcqGYGXCTQ7Rl
 qDO0ckPgICpHn7Mc59DX2VNHWKfU4gBn4aQx7dwUkIDKx3WCsHrdVYgXF2fEjoxtkxGU099WbXX
 N5cLI82FakKIdfMEzhwTZotC2gg7ML2nRolb6iwpa3/oBEUSHGfHbIHn7y19fRzA1rJmTuVvt0c
 xxPb7nR1FOib/++/EfQSOVyXqegHSYeXPYFWL0WYIgGhi0Rli3ScFeYtBZAD4mhGy/yqwjaOb3p
 pmdfvFHuoQmQItBfHOuK02kHO2XMoImHuTTHO+b06mzq43t8WgYudbtphXfXrfZosRYBtV6AnAn
 9PZaHBYh42eHc5ZhxlUrENWui+y75pYfEfHL5tkjxjQeiG2wzc8SHXk/ApZsv7P/MV2IBnrshQH
 RpRHDDAXGS0CSn7qSdvO2BkdYYH0mBnRIKbi9H0OQvjpP9MHX+gMefQaJUjHl9XP3ZPFdrIz21h
 QzT1w8EhDejZK9IURvHyz3gs+T+eT0jL5AuxxX6K+T/MXGyml0K5lnRCyoFrqoPeEZqzH+N+sIb
 G9NQtj8ktehq+Gx/69yk2c+HYCun9WstGW3/OWMTYBs7FFExCQ2MCfmYPMJaEMJtyG5wMzsS61d
 kK/glIIAZrVhPNU/Q=
X-Received: by 2002:a05:600c:46d5:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb55a82b16mr128298145e9.16.1794674332085; 
 Sat, 14 Nov 2026 08:38:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb666a3ca1sm52708845e9.9.2026.11.14.08.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:38:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:38:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
X-Gerrit-Change-Number: 2132
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2132?usp=email>
X-Gerrit-Commit: cb1a5c6bf7043a5c330b15679fa6fe22090ee3d0
In-Reply-To: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
References: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAwNzE1MDAwLkliMzNjZTIzNDQ4OTU5NjczYWZmZGZkNDYyYjRjMmNmYTlhMDE1ZjU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa6a0ffe376862517c5f675e8bb69180f23eb361-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGmI-000000001tO-3yAS
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7358757492174495449=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7358757492174495449==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hG9zak0x2Ng="; charset=UTF-8

--hG9zak0x2Ng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2132?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: push_util: use strin=
g_alloc() instead of a local gc_strdup()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

push_util: use string_alloc() instead of a loc=
al gc_strdup()

gc_strdup() duplicated string_alloc() for its only caller=
=2E While here,
fix the typos in the message_splitter() comment=2E

Change-=
Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
Signed-off-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132
Message-Id=
: <20261104174327=2E15221-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40715=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push_u=
til=2Ec
1 file changed, 3 insertions(+), 12 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2132/2

diff --git a/=
src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 34cb26c=2E=2E0c=
27575 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2E=
c
@@ -78,17 +78,8 @@
     return buf;
 }
 
-static char *
-gc_strdup(const =
char *src, struct gc_arena *gc)
-{
-    char *ret =3D gc_malloc((strlen(src=
) + 1) * sizeof(char), true, gc);
-
-    strcpy(ret, src);
-    return ret;=

-}
-
-/* It split the messagge (if necessary) and fill msgs with the messa=
ge chunks=2E
- * Return `false` on failure an `true` on success=2E
+/* Spli=
t the message (if necessary) and fill msgs with the message chunks=2E
+ * R=
eturn `false` on failure and `true` on success=2E
  */
 static bool
 messag=
e_splitter(const char *s, struct buffer_list *msgs, struct gc_arena *gc, co=
nst size_t safe_cap)
@@ -98,7 +89,7 @@
         return false;
     }
 
-   =
 char *str =3D gc_strdup(s, gc);
+    char *str =3D string_alloc(s, gc);
 
=
     while (*str)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2132?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
Gerrit-Change-Number: 2=
132
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--hG9zak0x2Ng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2132?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">push_util: use string_alloc() instead of a local gc_strdup()<br><br>gc_=
strdup() duplicated string_alloc() for its only caller=2E While here,<br>fi=
x the typos in the message_splitter() comment=2E<br><br>Change-Id: Ib33ce23=
448959673affdfd462b4c2cfa9a015f55<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132<b=
r>Message-Id: &lt;20261104174327=2E15221-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40715=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/push_util=2Ec<br>1 file changed, 3 insertions=
(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/32/2132/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 34cb2=
6c=2E=2E0c27575 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</spa=
n><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -78,17 +78,8=
 @@</span><br><span>     return buf;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static char *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-gc_strdup(const char *src, stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D gc_mall=
oc((strlen(src) + 1) * sizeof(char), true, gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    strcpy(ret, src);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* It split the messagge (if necessary) an=
d fill msgs with the message chunks=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Return `false` on failure an `true` on success=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Split the message (if =
necessary) and fill msgs with the message chunks=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return `false` on failure and `true` o=
n success=2E</span><br><span>  */</span><br><span> static bool</span><br><s=
pan> message_splitter(const char *s, struct buffer_list *msgs, struct gc_ar=
ena *gc, const size_t safe_cap)</span><br><span>@@ -98,7 +89,7 @@</span><br=
><span>         return false;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *str =3D gc_strdu=
p(s, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
str =3D string_alloc(s, gc);</span><br><span> </span><br><span>     while (=
*str)</span><br><span>     {</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Demail">change 2132</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
33ce23448959673affdfd462b4c2cfa9a015f55 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2132 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--hG9zak0x2Ng=--


--===============7358757492174495449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7358757492174495449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7358757492174495449==--

