Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBD606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FZsBAlgI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=djU2c1GA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YGk/6ZE/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LGXpdvB2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I63QYUP35dFi3UB4p2VfXHqBM1L4DZO7fZ2E6umSk40=; b=FZsBAlgINMoN/Fr4uhUf72TeFx
	Gs5AbmVr27ArFKZxuSzWlWdTzge+Qp7ilkOpQneiYR6skXUPCzEu2bj/IYlFYWsEcx7ZiKqeZ5VIt
	+C/Akm/+Cu9kcJ3G7Tu3dqkhOcMW5NENDmT2Jy610CrMBPrZpAY0YInFeXUr/QxKHMSk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0ka-000000000YA-0yeG;
	Mon, 16 Nov 2026 17:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0kY-000000000Y3-1Q74
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aiT4ZsEuGC2M3HV6JObctNtdYz6j+jlhKNbUU5hMDi4=; b=djU2c1GAL5DdqFO5ugGSuDUwKH
 6Y+Yg7odboOgba3opL9sNVUEvWPvRNB9es9VXXr879g6iD0fWL5krX6RVn7Cun2BJng+njb6usVF3
 CSzHaV11RQCobtSTfwRJMJEJvPWHlDdJjFYCc427GUaLkHRsAYx6vjW5La7hDI/JL6H8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aiT4ZsEuGC2M3HV6JObctNtdYz6j+jlhKNbUU5hMDi4=; b=YGk/6ZE/zPxfdVWhNq+smJFsnh
 UNHJnMKfT0D59MuhiVPq2QaUfaFy9d8TmQEwOYVMglWf6tA6wU6LVVHPyXK7qakW7VzbQxopVRC5Y
 3HQ/t6+/A3R80Ka2AfpnUuYf9sIXGmIR3yNOOl4MpShooHDxwiaLthM2EgAReXILFUcU=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0kW-000000005D4-2xAc for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:44:14 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so3998260f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794851046; x=1795455846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aiT4ZsEuGC2M3HV6JObctNtdYz6j+jlhKNbUU5hMDi4=;
 b=LGXpdvB2N810Cnovbhu0ciVCQ4uGQgbsbyqrIeuPREnIG7pMrSy1/YxfnIFeknvifk
 kO99YgYB+8/Fe8Dsztyc5E7E5QikS+oVhKo+f1I+ObbvAd9JJYJ9s08GL4cOeWbogQzA
 UR+26JTBDhWnI20ThQpg4ZGQ6y/y7m3UD0FW8mIEVftNHT8C1TfGdx/WR7fVKx5vXj+i
 c8+bEyaxAo15xukKJIta0s2t+Lc3ksurFYhm/M3XohMzn5EGQp3ShceNQunQVgETR2uN
 6N7sjqkENHtNhvBUTwKAwjH1W8F1fn6FLuQ5uIkxZORf2jPHykgdgbdMVWteyzMJ3mTo
 46/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794851046; x=1795455846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aiT4ZsEuGC2M3HV6JObctNtdYz6j+jlhKNbUU5hMDi4=;
 b=kju4SCb1CPT3Ep4dnM347jVdw1sE0XngOq2zqmVfVVPA95xTP3rPxs5nOaCereMWNu
 fJkyTqMsXh+LX+7NT5BR4Spfj8BXZRUVorS5k9MJqqF8TqU+DE1QhorQJ6v1EO7Q9x6E
 2lcnd3r4ijj5i1tFRNJgljJP2hT48maMsmJQd/6HZtEFYH/LNQ4jPdeydHqrx5eZe+cP
 gXwmgX8ELvtjG/bDDW4TQFR1YZWgDJ4THddGUBoceQ8GWxs2SR6/aBRKsxKVY6/PXqlP
 N/W2tBmEzruDTxCz0dxG+bLYvprrChWZePA3iYq9u55I4lGQkEOxvN9PjMSAyKYst7Zg
 ANMQ==
X-Gm-Message-State: APuU4Z9pIkOT08UNUYnsHwdL+Ub7uUZ+3jx/7ndfnO7Yer+D3J9APfL4
 fNZTeVxJnipcefeWKWOO6aHuDZfjFZyL7SHCNpOVo/pMptEjUvNKLDrxJn6PC5kP4aGHS4I+bpC
 TV0SqNRyQpTi8Ak7BX7phBXBaKoDf+ZOSUt7VTm42+6pVe5rJfl1ctY7sGJoC32XrmgAF
X-Gm-Gg: AZFdTZe4ohQ72LsHMHI9lDn3REZC/GLBmj7bQ5BkrzpebNLHDwJoPXLiSvytGyXOaOB
 3qPkAxDgN+AeGgh7epgmG1A+1ztmsgZIv/lu6NlvQARpt0rsfDf5NDDfPtp+tIy665vREu7kwHY
 ByWiVxMnb9015RfaDnC8GOEIJfWsJxK35YOk8O+oejRMlZl8MVDWZ3aF36SbSVQySh6D+QUGF4T
 gR9EmNmgCGebVc0GKk1keDfeK2/u19OydhpoTNI/vy6WMUyn/445eF8oKENuWpaXk7xIsS2xWmP
 2+aNA6eDCQfQjcyByK/Vw4s4JZd1+bf3qx4sOXEMlf7KbP/AG9euN8sINlljyeUGMAzQLmg1DZD
 PZ94ABy3/aiaSHdlksdCxbuUh0Mb0IXi7dYOSR5UfsXtT1lGJnWiysTAeSCMPWnNi94BnQnw6bn
 9gcQlu9eul2JbW2jMnglndcghVcy+aLGJBvox3jVDl7FKM2R9tnA1f5OOXCRnMjLHx682zuzsRM
 /vUcDms7jfyAw7dFPVYSgbucpkU9opWh8X6tqrzuhB3lNSz3H1D1MT5j2Mf0Iok0XjHgJjCpRbx
 JWQMrJsL0P6/p+D0DHVdp3XfBO394Rq0W2t3eMJewRMOab2pWsK4n+0IQuL2BqWFgKW8GIY3M8r
 gaLeGJXERmxgBDhPUmWMzpVKVJEWyzB0ZDDg31zeqLDnNh4PiRFqQn62LzdOEXPhN5yRiq3V7S0
 ekuw4X9wK2KPV1Fwo=
X-Received: by 2002:a05:6000:25ec:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-49c725e5749mr24604673f8f.29.1794851045868; 
 Mon, 16 Nov 2026 09:44:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm22367381f8f.21.2026.11.16.09.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:44:05 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:44:04 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
X-Gerrit-Change-Number: 2199
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2199?usp=email>
X-Gerrit-Commit: 7d46ff17248908acf906134ee1e03ded831634a6
In-Reply-To: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
References: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLklmNzlkNDM1NmI1ZGE4MmMyODQ0Y2Q5ZThjNTlhMGZjNDFhZWZmM2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68e359d642abddb0ce260c1980a85c53bb122066-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0kW-000000005D4-2xAc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Switch
 get_num_elements to size_t
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
Content-Type: multipart/mixed; boundary="===============6575651342406012457=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6575651342406012457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XXKBgo3Jy3k="; charset=UTF-8

--XXKBgo3Jy3k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
199?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: ssl_util: Switch get=
_num_elements to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl_util: Switch get_num_elements to size_t

ALLOC_ARRAY already=
 wants size_t=2E

Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2199
Message-Id: <20261116145745=2E8299-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41458=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/ope=
nvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
4 files changed, 6 insertions(=
+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/99/2199/3

diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/ope=
nvpn/ssl_mbedtls=2Ec
index 43bb0ff=2E=2Edc9f527 100644
--- a/src/openvpn/ss=
l_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -199,11 +199,6 @@
      =
   ciphers);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC=
 diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endi=
f
-
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *c=
iphers)
 {
@@ -217,7 +212,7 @@
     ASSERT(NULL !=3D ctx);
 
     /* Get nu=
mber of ciphers */
-    int cipher_count =3D get_num_elements(ciphers, ':')=
;
+    size_t cipher_count =3D get_num_elements(ciphers, ':');
 
     /* Al=
locate an array for them */
     ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, in=
t, cipher_count + 1)
@@ -339,7 +334,7 @@
     struct gc_arena gc =3D gc_new=
();
 
     /* Get number of groups and allocate an array in ctx */
-    int=
 groups_count =3D get_num_elements(groups, ':');
+    size_t groups_count =
=3D get_num_elements(groups, ':');
     ALLOC_ARRAY_CLEAR(ctx->groups, uint=
16_t, groups_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
@@ =
-1194,10 +1189,6 @@
     return 1;
 }
 
-#if defined(__GNUC__) || defined(_=
_clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* ***********************=
***************
  *
  * Information functions
diff --git a/src/openvpn/ssl_=
openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index e190935=2E=2E57ef9f7 100644=

--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -51=
8,11 +518,6 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSION_NUMBER < 0x3000000=
0L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#if defined(__GNUC__) || defined(__c=
lang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
-#endif
-
     struct gc_arena gc =3D gc_new();
     /* This =
method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, grou=
ps)
@@ -533,7 +528,7 @@
      * Also note that the code is wrong in the pre=
sence of OpenSSL3 providers=2E
      */
 
-    int groups_count =3D get_num=
_elements(groups, ':');
+    size_t groups_count =3D get_num_elements(group=
s, ':');
 
     int *glist;
     /* Allocate an array for them */
@@ -569,9=
 +564,6 @@
     }
     gc_free(&gc);
 
-#if defined(__GNUC__) || defined(__=
clang__)
-#pragma GCC diagnostic pop
-#endif
 #else  /* if OPENSSL_VERSION_=
NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups=
))
     {
diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
=
index 337faed=2E=2E6c17fe5 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/=
openvpn/ssl_util=2Ec
@@ -359,14 +359,14 @@
     return NULL;
 }
 
-int
+siz=
e_t
 get_num_elements(const char *string, char delimiter)
 {
     const siz=
e_t string_len =3D strlen(string);
 
     ASSERT(0 !=3D string_len);
 
-   =
 int element_count =3D 1;
+    size_t element_count =3D 1;
     /* Get numb=
er of ciphers */
     for (size_t i =3D 0; i < string_len; i++)
     {
diff=
 --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 6f9f65b=
=2E=2Edb5e17c 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_u=
til=2Eh
@@ -125,6 +125,6 @@
  * @param delimiter     the delimiter to count=
, typically ':'
  * @return              occrrences of delimiter + 1
  */
-=
int get_num_elements(const char *string, char delimiter);
+size_t get_num_e=
lements(const char *string, char delimiter);
 
 #endif /* ifndef SSL_UTIL_H=
_ */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If79d4356b=
5da82c2844cd9e8c59a0fc41aeff3c0
Gerrit-Change-Number: 2199
Gerrit-PatchSet:=
 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--XXKBgo3Jy3k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2199?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_util: Switch get_num_elements to size_t<br><br>ALLOC_ARRAY already =
wants size_t=2E<br><br>Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ack=
ed-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199<br>Message-Id: &lt;20261116145745=
=2E8299-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg41458=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=
_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_util=2Ec=
<br>M src/openvpn/ssl_util=2Eh<br>4 files changed, 6 insertions(+), 23 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/99/2199/3</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mb=
edtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 43bb0ff=2E=2E=
dc9f527 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -199,11 +199,6 @=
@</span><br><span>         ciphers);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> tls_ct=
x_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)</span><br=
><span> {</span><br><span>@@ -217,7 +212,7 @@</span><br><span>     ASSERT(N=
ULL !=3D ctx);</span><br><span> </span><br><span>     /* Get number of ciph=
ers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cipher_=
count =3D get_num_elements(ciphers, &#39;:&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t cipher_count =3D get_num_elements(=
ciphers, &#39;:&#39;);</span><br><span> </span><br><span>     /* Allocate a=
n array for them */</span><br><span>     ALLOC_ARRAY_CLEAR(ctx-&gt;allowed_=
ciphers, int, cipher_count + 1)</span><br><span>@@ -339,7 +334,7 @@</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br>=
<span>     /* Get number of groups and allocate an array in ctx */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int groups_count =3D get_n=
um_elements(groups, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t groups_count =3D get_num_elements(groups, &#39;:&#=
39;);</span><br><span>     ALLOC_ARRAY_CLEAR(ctx-&gt;groups, uint16_t, grou=
ps_count + 1)</span><br><span> </span><br><span>     /* Parse allowed ciphe=
rs, getting IDs */</span><br><span>@@ -1194,10 +1189,6 @@</span><br><span> =
    return 1;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* *************=
*************************</span><br><span>  *</span><br><span>  * Informati=
on functions</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src=
/openvpn/ssl_openssl=2Ec</span><br><span>index e190935=2E=2E57ef9f7 100644<=
/span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl_openssl=2Ec</span><br><span>@@ -518,11 +518,6 @@</span><br><sp=
an> {</span><br><span>     ASSERT(ctx);</span><br><span> #if OPENSSL_VERSIO=
N_NUMBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_new=
();</span><br><span>     /* This method could be as easy as</span><br><span=
>      *  SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups)</span><br><span>@@ =
-533,7 +528,7 @@</span><br><span>      * Also note that the code is wrong i=
n the presence of OpenSSL3 providers=2E</span><br><span>      */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int groups=
_count =3D get_num_elements(groups, &#39;:&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t groups_count =3D get_num_elements(=
groups, &#39;:&#39;);</span><br><span> </span><br><span>     int *glist;</s=
pan><br><span>     /* Allocate an array for them */</span><br><span>@@ -569=
,9 +564,6 @@</span><br><span>     }</span><br><span>     gc_free(&amp;gc);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span> #else  /* if OPENSSL_VERSION=
_NUMBER &lt; 0x30000000L */</span><br><span>     if (!SSL_CTX_set1_groups_l=
ist(ctx-&gt;ctx, groups))</span><br><span>     {</span><br><span>diff --git=
 a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span>inde=
x 337faed=2E=2E6c17fe5 100644</span><br><span>--- a/src/openvpn/ssl_util=2E=
c</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -359,14=
 +359,14 @@</span><br><span>     return NULL;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span> get_nu=
m_elements(const char *string, char delimiter)</span><br><span> {</span><br=
><span>     const size_t string_len =3D strlen(string);</span><br><span> </=
span><br><span>     ASSERT(0 !=3D string_len);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int element_count =3D 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t element_coun=
t =3D 1;</span><br><span>     /* Get number of ciphers */</span><br><span> =
    for (size_t i =3D 0; i &lt; string_len; i++)</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=
=2Eh</span><br><span>index 6f9f65b=2E=2Edb5e17c 100644</span><br><span>--- =
a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</=
span><br><span>@@ -125,6 +125,6 @@</span><br><span>  * @param delimiter    =
 the delimiter to count, typically &#39;:&#39;</span><br><span>  * @return =
             occrrences of delimiter + 1</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int get_num_elements(const char *st=
ring, char delimiter);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+size_t get_num_elements(const char *string, char delimiter);</span><br><=
span> </span><br><span> #endif /* ifndef SSL_UTIL_H_ */</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?u=
sp=3Demail">change 2199</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2199?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2199 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--XXKBgo3Jy3k=--


--===============6575651342406012457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6575651342406012457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6575651342406012457==--

