Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF256606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZS4rAHyN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JeHQ03/G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cZK4khvX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W14HTbNn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HlQpEpN0PinUMEFOLhDABRW1uJwM4KEnSLCgJIwieNs=; b=ZS4rAHyNeUtMCis/FV1BdIrw4D
	b/bvK0V8ktnYbvapGllr7eniGOlVIjnkjpB5TV48QPDEUzzQeWgKpSqHh0m/vbcMoKjFA/agYEApB
	FfwQZosOFjzucQSWEsPzhBAXPUPK2RRzQ5H0MfJvMPWk+eAfQ1vVqBPqcew/k3C67Fgg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQYA-000000006YN-1gLj;
	Mon, 23 Nov 2026 09:41:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVQY8-000000006YH-2LwV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZvDxh4vqQLoXTioEA2ifVv42E4kEBugnAT0cWNsRy7o=; b=JeHQ03/GitDsIOqtAECdYSppKB
 SxdSEZSLK++mcrbvMKYhLlCK8Lnk5iie9IMimIXovQUs64k8Ds/I8c4GiKvDozeNmcd33so5MosJ9
 rwwcMf6VezBNuHBYnUSjE5zjAnyWPWHhmhGJM8liEQ+QNDiLG1c6bE8lnnZbC/qNWMFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZvDxh4vqQLoXTioEA2ifVv42E4kEBugnAT0cWNsRy7o=; b=cZK4khvXC2x3yYaSH8kGq4de0A
 /V4LQh/ZOKH/8w4r8tVTrHa6dK/LduB2NLl2KBWw5unfGssXLrCUeuVvWoZxoush4fqrfDvSRKDE3
 zGnZRVkEVLXJmZECI29ksSDqML0Ezlbx0UY0l74f8h7sNUxdQMOBnZC3+oty11E+7BQA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVQY7-000000003YF-1bln for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:41:24 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so23346685e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795426877; x=1796031677; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZvDxh4vqQLoXTioEA2ifVv42E4kEBugnAT0cWNsRy7o=;
 b=W14HTbNnEHWQiP1EObJ7WYB8TT85z9WWu32ZXiMXt6NurRMLppHLMZbU++6KwGM6Nf
 Qjxa9o7DyU8DkmV9MpGuzkSruB3+4suU9EJaNG8srOxQYsvYnpKgVexeyHiFHgo+wpBK
 5Rlb6jzv4jdf746WWWWNNMSPD2TI0E6LkPerkLl4qxxMjTdKc/oDHpbVcjwl+E+919cn
 GbS4X439n/9zLmMWAmeCCrO+O7zSGvssbzMFqaWlr5+jmOy7SSzwZ+ktWAyOjor7BF9D
 xU8ExLK9ZJSVNFfa3BNBg2UC8vCl/DuTg5NOobjv2q4ousXdCfv6OVklxI+00e5gjWn2
 vvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426877; x=1796031677;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZvDxh4vqQLoXTioEA2ifVv42E4kEBugnAT0cWNsRy7o=;
 b=NzR5ybI6Sfup+gUasA9zF5QlT/Fg9ApH89XpG7tTND9eX+rZgYwKhYAPuiYqMEMQMD
 tz+LDekSm9s5zSty2oLeCRpj38lITWFBBNVTyHzngNMCUB4nbXQVoUmtuMyHaGrIkqGT
 0/CRx6jnNd3XpuQ4r9VNdOx5ZAM/8E9ikDln0S4TzoC6IZvqDNp2v1aywCt1G5ThS2mM
 NV2eGF13MgMbuReGiC4ZKalJVK08ENruMeAUx3zicHnt+Fr3evELkcW9Ko5cM18QelQI
 OsNhLeQCTvYwYHe2Mt4fnvvjhmEPqT1hRXw9romvgG23oaXxNly8n/c8fuRRUzOTd6cV
 DUbA==
X-Forwarded-Encrypted: i=1;
 AL+hErFludUuEows6Fb80pn2w0LA4TiMTS3DYgYZfuG14g3Ranc24DiIBVa3tEtiYhV14K5alW+i55N1sGLV4BGK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9LLMzdjW4L3NEJxywSL8VYlsWEvplEt3fmrzEfpufxSbhHMIGG
 c85N3n5LtKdezoB98WndtEa1G80o0w2sCD/3XbVXke5oZUiNTpyi1piETRWMUC0VG25FstM6mYH
 Ghk2cqYdVa42KqGRTypHAmWb0K9vP5jF1dqlPlbfBRwS3drp4FwcRePcif8na99x4H5ry42rstN
 JzCWldVA==
X-Gm-Gg: AZFdTZd4J3rExdFLOtpl1EJOEl0UGP7+S+VfnwHx2zWemRgQulYkJUsHlEqYczFM1jb
 1mk2qIfhEm61paKnebSI1cSs8ot6SD18cvAsKKedoE+SuF8q4Jcz8LMlSuK9cXgivcRhtEru8OG
 wjbi6FzZ3sZek/vhCY3GbqFuMHjOGlN0toEC4SRclNCEHMYGz6xUq49ImYDpy0MXHSKpeoDXg16
 yzMnDz4Flwn0/a2C5I+uM6IkiGbNqOmj3lbE32aWq3v4Jvha4FSnf6JKLZi6x+ej9oSBOkZRDeE
 n8yipY80n7+64CQin12MCnJ6rtjaECTHDp7xv5oBlhisJRCIt8rdCIoHzGYnaBv+fjibk/ROJD2
 T0p9ckTDhnPJA+C3okwrlPNvAs10wbOFBFawFeXkQOFGl2Ky9wLb9oeFLqNNQtlkGCXZ2C4+Nxy
 bxuR+8irZ2r8p7a538j9GtjJCzYa+ggGNroemE1wxZVnyh57Nhk4yiIjoJUKGFDrvG07sDXDrEQ
 aSmDgwWv1C4hYXZ3u3lSloj5on0G+ByiVclSBfBpg5O3SJFnZY/0MZdfC6hALYXHXqKKwusPbEw
 ZoXo+ToVEKVS6vLO7QG8NVao3g6mO8KoU8FyOFzmYbE/5+n0NNkuEV/l1ayc0Pw7nRROtiXKRr0
 NFv8kwWzp8pnbtgITP07skMG1fi9SRd++9+v3I9T7MoiDnDJnQ1mG0PCkS/M5/47gJSbCRir62K
 IYPxF5gRn7wr0AVZc=
X-Received: by 2002:a05:600c:6708:b0:4ba:7e6:53d6 with SMTP id
 5b1f17b1804b1-4bb88940848mr197541075e9.33.1795426876617; 
 Mon, 23 Nov 2026 01:41:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm20393544f8f.40.2026.11.23.01.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:41:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 09:41:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 755401bd9da814ac73c94abe8f6343b863abbffa
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a59552a645ef4ef6c8290667c3fa9020031566d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVQY7-000000003YF-1bln
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
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
Content-Type: multipart/mixed; boundary="===============8700382986822593170=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8700382986822593170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aIB2erD5jGg="; charset=UTF-8

--aIB2erD5jGg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2217?usp=3Demail )

Change subject: ssl_verify: use check_for_c=
lient_reason() in tls_authentication_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: use check_for_client_reason(=
) in tls_authentication_status()

tls_authentication_status() open-coded ch=
eck_for_client_reason() for
the plugin and script auth status=2E Call the h=
elper instead=2E
key_state_check_auth_failed_message_file() had no other ca=
ller, so
fold it into the helper=2E

Change-Id: Ia48c1efc9a687383a1dc87edd4=
9d8ba3eb5a87ad
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2217
Message-Id: <20261118162932=2E22639-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg41626=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=2Ec
1 file changed, 10 ins=
ertions(+), 39 deletions(-)




diff --git a/src/openvpn/ssl_verify=2Ec b/s=
rc/openvpn/ssl_verify=2Ec
index 75cda97=2E=2E2f81968 100644
--- a/src/openv=
pn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1037,24 +1037,22 @@
=
 }
 
 /**
- * Checks if the auth failed reason file has any content and if =
yes it will
- * be returned as string allocated in gc to the caller=2E
- */=

-static char *
-key_state_check_auth_failed_message_file(const struct auth=
_deferred_status *ads,
-                                         struct gc_=
arena *gc)
+ * Check if the script/plugin left a message in the auth failed=
 message
+ * file and relay it to the user */
+static void
+check_for_clien=
t_reason(struct tls_multi *multi, const struct auth_deferred_status *ads)
 =
{
-    char *ret =3D NULL;
     if (ads->auth_failed_reason_file)
     {
- =
       struct buffer reason =3D buffer_read_from_file(ads->auth_failed_reas=
on_file, gc);
+        struct gc_arena gc =3D gc_new();
+        struct buf=
fer reason =3D buffer_read_from_file(ads->auth_failed_reason_file, &gc);
 
=
         if (BLEN(&reason))
         {
-            ret =3D BSTR(&reason);
=
+            auth_set_client_reason(multi, BSTR(&reason));
         }
+    =
    gc_free(&gc);
     }
-    return ret;
 }
 
 
@@ -1221,21 +1219,9 @@
 #e=
ndif
     if (failed_auth)
     {
-        struct gc_arena gc =3D gc_new();=

         const struct key_state *ks =3D get_primary_key(multi);
-        c=
onst char *plugin_message =3D
-            key_state_check_auth_failed_mess=
age_file(&ks->plugin_auth, &gc);
-        const char *script_message =3D
- =
           key_state_check_auth_failed_message_file(&ks->script_auth, &gc);=

-
-        if (plugin_message)
-        {
-            auth_set_client_rea=
son(multi, plugin_message);
-        }
-        if (script_message)
-      =
  {
-            auth_set_client_reason(multi, script_message);
-        }
=
+        check_for_client_reason(multi, &ks->plugin_auth);
+        check_f=
or_client_reason(multi, &ks->script_auth);
 
         /* We have at least o=
ne session that failed authentication=2E There
          * might be still a=
nother session with valid keys=2E
@@ -1243,7 +1229,6 @@
          * with th=
e other session (and we actually did that in earlier
          * version, t=
his behaviour is really strange from a user (admin)
          * experience =
*/
-        gc_free(&gc);
         return TLS_AUTHENTICATION_FAILED;
     }=

     else if (success)
@@ -1305,20 +1290,6 @@
  * this is the place to sta=
rt=2E
  *******************************************************************=
******** */
 
-/**
- * Check if the script/plugin left a message in the aut=
h failed message
- * file and relay it to the user */
-static void
-check_f=
or_client_reason(struct tls_multi *multi, const struct auth_deferred_status=
 *status)
-{
-    struct gc_arena gc =3D gc_new();
-    const char *msg =3D=
 key_state_check_auth_failed_message_file(status, &gc);
-    if (msg)
-    =
{
-        auth_set_client_reason(multi, msg);
-    }
-    gc_free(&gc);
-}=

 /*
  * Verify the user name and password using a script
  */

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8=
ba3eb5a87ad
Gerrit-Change-Number: 2217
Gerrit-PatchSet: 3
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--aIB2erD5jGg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2217?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_verify: use check_for_client_r=
eason() in tls_authentication_status()<br><br>tls_authentication_status() o=
pen-coded check_for_client_reason() for<br>the plugin and script auth statu=
s=2E Call the helper instead=2E<br>key_state_check_auth_failed_message_file=
() had no other caller, so<br>fold it into the helper=2E<br><br>Change-Id: =
Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2217<br>Message-Id: &lt;20261118162932=2E22639-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41626=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file changed, 1=
0 insertions(+), 39 deletions(-)<br><br></pre>
<pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 75cda97=
=2E=2E2f81968 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1037,24 +10=
37,22 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Checks if the auth failed r=
eason file has any content and if yes it will</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * be returned as string allocated in gc to the cal=
ler=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-key_state_check_auth_failed_message_file(=
const struct auth_deferred_status *ads,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                         struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the=
 script/plugin left a message in the auth failed message</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * file and relay it to the user */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+check_for_client_reason(struct=
 tls_multi *multi, const struct auth_deferred_status *ads)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D N=
ULL;</span><br><span>     if (ads-&gt;auth_failed_reason_file)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        str=
uct buffer reason =3D buffer_read_from_file(ads-&gt;auth_failed_reason_file=
, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct buffer reason =3D buffer_read_from_file(ads-&gt;auth=
_failed_reason_file, &amp;gc);</span><br><span> </span><br><span>         i=
f (BLEN(&amp;reason))</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ret =3D BSTR(&amp;reason);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            auth_set_client_r=
eason(multi, BSTR(&amp;reason));</span><br><span>         }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span> }</span><br><span> </span><br><span> </span><br><s=
pan>@@ -1221,21 +1219,9 @@</span><br><span> #endif</span><br><span>     if =
(failed_auth)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span>   =
      const struct key_state *ks =3D get_primary_key(multi);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        const char *plugin_message =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            key_st=
ate_check_auth_failed_message_file(&amp;ks-&gt;plugin_auth, &amp;gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *script_=
message =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  key_state_check_auth_failed_message_file(&amp;ks-&gt;script_auth, &amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (plugin_message)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            auth_set_client_reason(multi, plug=
in_message);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (script_me=
ssage)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            auth_set_client=
_reason(multi, script_message);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        check_for_client_reason(multi, &amp;ks-&gt;plugin_auth);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        check_for_client_reaso=
n(multi, &amp;ks-&gt;script_auth);</span><br><span> </span><br><span>      =
   /* We have at least one session that failed authentication=2E There</spa=
n><br><span>          * might be still another session with valid keys=2E</=
span><br><span>@@ -1243,7 +1229,6 @@</span><br><span>          * with the o=
ther session (and we actually did that in earlier</span><br><span>         =
 * version, this behaviour is really strange from a user (admin)</span><br>=
<span>          * experience */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        gc_free(&amp;gc);</span><br><span>         return TLS_AUT=
HENTICATION_FAILED;</span><br><span>     }</span><br><span>     else if (su=
ccess)</span><br><span>@@ -1305,20 +1290,6 @@</span><br><span>  * this is t=
he place to start=2E</span><br><span>  ************************************=
*************************************** */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Check if the script/plugin left a message in the au=
th failed message</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * f=
ile and relay it to the user */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
check_for_client_reason(struct tls_multi *multi, const struct auth_deferred=
_status *status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t char *msg =3D key_state_check_auth_failed_message_file(status, &amp;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        auth_set_client_reason(multi, msg);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> /*</span><br><span>  *=
 Verify the user name and password using a script</span><br><span>  */</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2217?usp=3Demail">change 2217</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2217?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a8=
7ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2217 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--aIB2erD5jGg=--


--===============8700382986822593170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8700382986822593170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8700382986822593170==--

