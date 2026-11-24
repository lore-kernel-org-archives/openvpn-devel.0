Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA41606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MMsqCWAg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P/FHewqj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RiTkUqzw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W7VzzY/s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=JlXFHlkOTiDZcdlLGScumLmGwMAAVQRbahFObAitDfE=; b=MMsqCWAgMXxT9C8r1kSXaoT1um
	mNmHAv6ccc7x+6APf5Sxa5m5+3uvH1j2uBwH5HeiY0h5nJy37zNGkILZsxCvO3zA4N7/CVpQm6FOP
	fzgWm8zIy4I2H3zVz+g7+klQpxUMnR9U/i2E+G34nrWCvcL5Q33qCK1qmfsDm/fYvNB0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVnhP-000000007zr-0Y91;
	Tue, 24 Nov 2026 10:24:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVnhO-000000007zk-0Pkv
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aHozdJxuo8j2jImZ6YU4f9bixPYXxcdGZ/RmAiyAOV0=; b=P/FHewqjEzXriJEHdXM1WqcuF9
 w4ogJb6q0OARuAEjD38+OmrDZs8W3H/5dDnI0WAteeYC1hgPXzSHBx2sLXECj1aoTOW7kyJ9TCoE2
 qatpEVc5u+y1dUsM3JH03lS3sRQWcKtl8uYoG0xDvTI868OgQ4HSfv6b+qHBqZZLzkEE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aHozdJxuo8j2jImZ6YU4f9bixPYXxcdGZ/RmAiyAOV0=; b=RiTkUqzwa9UoDFu0Swo8kFOBPB
 RDN1vGy7qUay69jin+43yAAMILBB8xsieq3kFFSJDon8v88DAIyuwHUhYRzHHORdvqQl5MaNocxz/
 EgwQqFuW2dDV7ekM6jKLVZ/mbNx0yqpDdvU8S1qINyK4pMMM6LRYsoHL/rnWYzyYSoFE=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVnhM-000000006so-0ACt for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:24:30 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so2329636f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795515861; x=1796120661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aHozdJxuo8j2jImZ6YU4f9bixPYXxcdGZ/RmAiyAOV0=;
 b=W7VzzY/s5LOF7ixxFhc0rlp2CreJaoNft2J3Jquyxi5ETu5r21YPEdcC3jUruz7SLL
 aIwjncwN+NqAym4S9BY1+etskNzxxFyncA8pq7/rKpR2uDDaQSulIXHJzkQJMtosHcR7
 8SGwMul2TROUJS6bi1WWo2tOQJohC+SKqF55qIXDLVqL4Cxshjl5muMuN/L0voUow62P
 f2S531e/rtRxoWSUefDj/XQ+hW8n1NuNYz9QfJ5FUQvNzgnAlN2QtLu+tSVQRTGHaGz2
 fLQjkjQ2NjlX3L8C9bWW72z86TRCGRZaDprowhUuENYTZ6cQQ/kpk1KBMvlk8RAIeCvs
 moBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515861; x=1796120661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHozdJxuo8j2jImZ6YU4f9bixPYXxcdGZ/RmAiyAOV0=;
 b=PiX/GALBQXMRqcrmFQpyVUZL6zdhNo0jjakN3gRwi53jGY64Gzmo5hWsg50xU305eA
 1qthTrCUnuTgw/vP86/yEZA2QHWfRMYeMtGd6wg3KSneKzt3O3gd4j33ZhR1EJrFlOjd
 ++pyjnC7xR0cx7gw2JMwgWNZ7yYn2EmH9nHBHGLmIdKjn/eaQcLEPQ6PvHe2GEZg5UI3
 NnahQp1zXJmoimPe1V7/61ZKtiXLY9RCRZVgltxuZ3S3sNyPQgyVV3Rkm66HrByb4Rxt
 rAtv9LMRU1scBa0j+GzDowZS70QlBCN6rARs7BH4CuAvKo3zXAZ2esDIY6T0CQXLR8r+
 R5FA==
X-Gm-Message-State: APuU4Z9XjsvguthDOyk5sW57y/y+JTjAbRwqjFQONLM3HoSIsqMDiNkm
 FqjKVQQMaBWS+kc3DXSS7P/KNncKB7jgIfktfmgH2NERS4PyniRZSVuI1e7V5XeF9Cq0ompHQa6
 1ZyHov5oWVaIdZAIYGzH5VcXbRuVgd0UZPnEmEYCfclgPq8xM6s+3ingd/cxnpkr/9x5BDQDlHW
 30JOvalQ==
X-Gm-Gg: AZFdTZdQ3t1BXXtClvBf5Goxc9eM0XqfFjJGGOSY07STHy4ewYa6HGPVu82v/xyqFtQ
 yldp8AqgPY9zzMcSMaR5EXRRA3lKAS6MjW8qoJVYtj2Eu3vjRk+pIb3Y52iccbAOkIZ9cPzQQUz
 +yFuZtwClw4wI7ocVOONIY7fVgW+MEiCsbermGX9jTIrWfwP2WKwxnxJ26FkTtVYBsSoXp7Vsdn
 DzZKG56YaI6GBKa1zXpsycMnjJsbiCe09dAL2hbQs9iXFF1WRUsV5vD6w2Tj2ehF1g75WsQ9DC4
 ep++QM6YwO9s9+oVuzu511BTdZugp1vNOKXz900v92aCMjNdufrdg9GeyXQygg2IhQihsdhUu+F
 4cBUHyesCLs4obuyexcq9TjYk3DyccMa5ioYbY9o/3JsOq01nHMhKb/BX+cdmOts1hjYS2ck9yX
 pu69wbl7soKBuI/MRT5Gz8tF2BV+ZDvs63MeVir7XI3QDBxUX7d5b5WQNvLN2o0wucinIQIwif/
 auwVTcZ0wWENCm+ov6CngR+sHxZSsehMHKSuw2IxhrbeV166qX7Rku/u4yiOWNDvW1+XnUVwGar
 YEIHJDWx+hMl6UTj9pwwIFEhhsPihpPou5QiAJuLiuBnQc5n5Cc+vqmtgEnG05OyurW1kITrZFZ
 gE7pdJ/kcmc+DSrzf/8fplFn/Vn1Cby7aznVIuKqd7bXT9grfRtSukKwAVXL4SAUUoLi/lLdcA/
 JZodSy1lwtQlr4Too=
X-Received: by 2002:a05:6000:4024:b0:4b7:7db4:2cd8 with SMTP id
 ffacd0b85a97d-4b77db42cf7mr2270005f8f.35.1795515861144; 
 Tue, 24 Nov 2026 02:24:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm19715602f8f.15.2026.11.24.02.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:24:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 10:24:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
X-Gerrit-Change-Number: 2334
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2334?usp=email>
X-Gerrit-Commit: 4ebe13d009fa7f686916f282322458a4203d1bce
References: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLkllOTAyZGJjNDVlNGFjYTBjNzJiYzRiNGU4Y2MxZTE3ZDI5YjQ3YWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8fc8ffb558b5d5297f98e7a9f5f8292875e70da5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVnhM-000000006so-0ACt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make the
 options mode an enum
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
Content-Type: multipart/mixed; boundary="===============7490158395870996709=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7490158395870996709==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UJzSnkmMV8g="; charset=UTF-8

--UJzSnkmMV8g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2334?usp=3Demail

to review the following change=2E
=


Change subject: options: make the options mode an enum
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: make the options mode =
an enum

Turn the MODE_* defines into enum options_mode and use it for the =
mode
fields and parameters=2E With both modes being distinct enum types,
-W=
enum-compare catches comparing a context mode against an options
mode=2E

C=
hange-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
Signed-off-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/dco=2Ec
M src/openvpn/opt=
ions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ssl_common=2Eh
4 files cha=
nged, 11 insertions(+), 7 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/34/2334/1

diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec
index fdee465=2E=2E3c85c11 100644
--- a/src/open=
vpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool=

-dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel,=
 int mode)
+dco_check_option_ce(const struct connection_entry *ce, msglvl_t=
 msglevel, enum options_mode mode)
 {
     if (ce->fragment)
     {
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 2068393=2E=2E=
f9ff0c4 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -2309,7 +2309,7 @@
 }
 
 static void
-options_postprocess_mutate_le(cons=
t struct connection_entry *ce, struct local_entry *le, int mode)
+options_p=
ostprocess_mutate_le(const struct connection_entry *ce, struct local_entry =
*le, enum options_mode mode)
 {
     /* use the global port if none is spec=
ified */
     if (!le->port)
diff --git a/src/openvpn/options=2Eh b/src/ope=
nvpn/options=2Eh
index b390ebc=2E=2E0112c5f 100644
--- a/src/openvpn/option=
s=2Eh
+++ b/src/openvpn/options=2Eh
@@ -252,6 +252,13 @@
     struct verify=
_hash_list *next;
 };
 
+/** Major mode */
+enum options_mode
+{
+    MODE_=
POINT_TO_POINT,
+    MODE_SERVER,
+};
+
 /* Command line options */
 struct=
 options
 {
@@ -260,10 +267,7 @@
     /* first config file */
     const ch=
ar *config;
 
-    /* major mode */
-#define MODE_POINT_TO_POINT 0
-#define=
 MODE_SERVER         1
-    int mode;
+    enum options_mode mode;
 
     /=
* enable forward compatibility for post-2=2E1 features */
     bool forward=
_compatible;
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_comm=
on=2Eh
index cfe3fea=2E=2Efe333a3 100644
--- a/src/openvpn/ssl_common=2Eh
+=
++ b/src/openvpn/ssl_common=2Eh
@@ -324,7 +324,7 @@
 
     /* from command =
line */
     bool single_session;
-    int mode;
+    enum options_mode mod=
e;
     bool pull;
     /**
      * The detail of info we push in peer info=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie902dbc45e4aca0=
c72bc4b4e8cc1e17d29b47aa1
Gerrit-Change-Number: 2334
Gerrit-PatchSet: 1
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--UJzSnkmMV8g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: make the options mode an enum<br><br>Turn the =
MODE_* defines into enum options_mode and use it for the mode<br>fields and=
 parameters=2E With both modes being distinct enum types,<br>-Wenum-compare=
 catches comparing a context mode against an options<br>mode=2E<br><br>Chan=
ge-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1<br>Signed-off-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M =
src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/ssl_c=
ommon=2Eh<br>4 files changed, 11 insertions(+), 7 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/34/2334/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec</span><br><span>index fdee465=2E=2E3c85c11 100644</span><br><span>--- =
a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><=
span>@@ -255,7 +255,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_ch=
eck_option_ce(const struct connection_entry *ce, msglvl_t msglevel, int mod=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_option_=
ce(const struct connection_entry *ce, msglvl_t msglevel, enum options_mode =
mode)</span><br><span> {</span><br><span>     if (ce-&gt;fragment)</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index 2068393=2E=2Ef9ff0c4 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -2309,7 +2309,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-options_postprocess_mutate_le(const struct connection_ent=
ry *ce, struct local_entry *le, int mode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+options_postprocess_mutate_le(const struct connection=
_entry *ce, struct local_entry *le, enum options_mode mode)</span><br><span=
> {</span><br><span>     /* use the global port if none is specified */</sp=
an><br><span>     if (!le-&gt;port)</span><br><span>diff --git a/src/openvp=
n/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index b390ebc=2E=2E=
0112c5f 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><spa=
n>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -252,6 +252,13 @@</span>=
<br><span>     struct verify_hash_list *next;</span><br><span> };</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Major m=
ode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum options_=
mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    MODE_POINT_TO_POINT,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    MODE_SERVER,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /* Command line options */</sp=
an><br><span> struct options</span><br><span> {</span><br><span>@@ -260,10 =
+267,7 @@</span><br><span>     /* first config file */</span><br><span>    =
 const char *config;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* major mode */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define MODE_POINT_TO_POINT 0</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define MODE_SERVER         1</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int mode;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    enum options_mode mode;</span><br><span> </sp=
an><br><span>     /* enable forward compatibility for post-2=2E1 features *=
/</span><br><span>     bool forward_compatible;</span><br><span>diff --git =
a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>i=
ndex cfe3fea=2E=2Efe333a3 100644</span><br><span>--- a/src/openvpn/ssl_comm=
on=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ =
-324,7 +324,7 @@</span><br><span> </span><br><span>     /* from command lin=
e */</span><br><span>     bool single_session;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int mode;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    enum options_mode mode;</span><br><span>     bool pu=
ll;</span><br><span>     /**</span><br><span>      * The detail of info we =
push in peer info</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail">change 2334</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie902dbc45e4aca=
0c72bc4b4e8cc1e17d29b47aa1 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2334 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--UJzSnkmMV8g=--


--===============7490158395870996709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7490158395870996709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7490158395870996709==--

