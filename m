Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2659606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A5B1RIoF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eyAD/yOz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Arq4OV2g;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Npa6lVQm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+TTuY7VugvOwkYcZvFQ8X2XvUc1BcvUnurKZFHulRVE=; b=A5B1RIoFM7luVXdc67dqnmqFka
	T0XbQsJg1c0XdbX/28qSDK9fClY9LZR0vrk8CHLAY3t+uclDzunXKjBvw31hXVfahSSJym61UOkeQ
	iCM+LZNlGK2KyCxgfr/dhpvEFMM7enXwaXR8pQEMcCVcgc1fbt0JCNNs6fCz83VV50Ng=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQYB-0000000011h-2nkR;
	Mon, 23 Nov 2026 09:41:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVQY9-0000000011a-4Bi5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPUXsciQbqhpKS+1J0VK+k9QNmuOAR3cb6GorOr0hkU=; b=eyAD/yOzQNdWbqnh4lU9Z3QG3D
 XGrjdBuIiYc4nHZZYs3Y+FN1klKqSE8jZRJsuaX41nePwU82/BLLufDeW5fOKZm/dAGebBXjQRl4l
 rFv1fw7DqoAK+DSo8p6Uqs7+GhsNsOYRSEbH/iXqpBXTK3w4uNh6GHQZ/+/FJQhq3Qtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPUXsciQbqhpKS+1J0VK+k9QNmuOAR3cb6GorOr0hkU=; b=Arq4OV2ghLLXxMfLwSpI4Ehchf
 HjUHgnwYxhOcPdog8JHDAKMgU4mGwuhSCypAdcaIzOvhoyCeqbOMnuK81iJO8W4pzgZ47WiB5jkv6
 TaIQ7DyucYL7Sioy8Zhvv/kg5EfMmUSocVUW9PwVm/9CqTNAxIQTbhYLFNi0s1ScXaOI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVQY6-000000003YB-2tNc for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:41:25 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so27709775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 01:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795426876; x=1796031676; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JPUXsciQbqhpKS+1J0VK+k9QNmuOAR3cb6GorOr0hkU=;
 b=Npa6lVQmK+1pLAaiVr+SB5SU1JRkJMTRh4Cj4GXwMXuQoRHIZNyQWKNJi83YCF/AIU
 tVhNmpYCPpM0kQQnhbXCa9GVeyP2tjN6hljEl3+Ts4Q6sCyNi3DKx0VqK1s7osHkMkep
 k75Gone573AeYp3QjsxNY0+EZihnowWOIzOQv1gJq7ZHZXY2rVkveCisn6SSQzJimHP+
 nMQ51uDpqDALpu6gXjGJ22sCjPwS7E+j6NOnvJ/t20ngkxuMd80uzIIsftVM2EWVUzRs
 iYJxRtstOOiuRgqeoOiii0thVtfc54XuUX/SqH+LAvyup2ARvtxVlLe/d1kxkqnjsVaH
 R5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426876; x=1796031676;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JPUXsciQbqhpKS+1J0VK+k9QNmuOAR3cb6GorOr0hkU=;
 b=v0b+pHj4zEzqRgCUVIe6JSpNlesCYbp9vzGfKzeqSUui3Yec8RlSbUwi0KBwlk0cI7
 rpFRrKmFi26ljo+63bM7COt64p57M+tt58KcIXJbrxhu0nlcQ6Bs/D/Eh8WEe4ieb9Sd
 50GcjIlbeu98HK7Ki0+DLuVwvBq7WkN0m+a5ZojToTVmtNJlze2Y7NPUswY7EUPEHwb4
 SX0T6ONA6Myge6hhrDZkD4fiQbkLD+mqMCmGqaFagI8df8KWS2+kCgsJWSl4rnWOEx6r
 SjFo5oa6OhlHakI+qeMHnnPFLFgUypxCd7bvCiOCy4i/ug8OXkbl685ql9YrOR5E2EPL
 ipYw==
X-Gm-Message-State: APuU4Z9CwqYEjfOwKGBeGq+FszI62us1ONN/Dn3isj5rOwyor7GA8uMg
 0MdcQeRphshmT7SgJugYu/gB0mZJW7NbsU1DvSgjWvJddIHY+0pJhoUzRJTE/FIxKjJ7sDYT29k
 +wndT666U3gdPHdSvVZrhRmlNUiLDdOg8WRV8MN1AtkaCZv3z22u1RogTGnSapIwcd732
X-Gm-Gg: AZFdTZd09N8VvfuZeWZiu8mnm8ryob75eF9LAjWw5z3OvW0WpRBD3+/AGmCIfZ+Tep7
 ksn67GhM1bD52Jd4n4UXsvHhck9uZr8/JmTm9/UKcECnCmGU0HBQxGzb1fdpkFtFZdY/Qa6W7Kr
 WiX92vnEVG0rKBtV1ASUqKxqF++zk0xCmE1K1ii/uVfEaUo5RqPSzpYWLmed32xP5Xikihw/cU9
 R6oYlY/QQAtMc7e44Yxku93Zj0wnzHGO7Eu3bTwLTWLJXIkH/2dS6sSpPg7XPB14HJ9ellGgXxx
 DuYhDcwKNRQ56Iv+4D8KBPeiomcXTN3cwmXoO9KgHi70ZPfpmD4O+bCmxEqjVxZW61hmCFGEphK
 TUB4YK0hZYvmXnSFg/ThywK9OuiSFtEEs3lfPJBIk8wIHrLKKegqzUSphpudfsSFkxo9nihpX4e
 zz5gsW38AixS/i3VkrlfqfREBSyawuq+q4DjPzrG2nPC/1XzrpUv+kFxMSy9pP4GIF1oVFYOvgd
 1ZCEBiz0AF0N8hsQe7EU4uqfPBiNQaMc4Pkopqn5iG6K0xRP+AjRV7P9ZMaB50cdPiUh/k2pXTw
 Ve0nmJXq3hBRjMIKCIh5U+4RzpZXw//KksTHcM3LkRf8vD3JTNTekHbSbQ4HH2uWtDDeeOUCoKO
 3e3U2jKEnc41JNt4ChDKCwEYT9ffWgedSu4kNsa9lgyvkhxdcInLPd3PC/hvz54wWTUUGG5pMIp
 Bzp/plNuBHvZW8MVAt
X-Received: by 2002:a05:600c:1993:b0:4bb:8711:fcb9 with SMTP id
 5b1f17b1804b1-4bb88941bcemr207957245e9.33.1795426875823; 
 Mon, 23 Nov 2026 01:41:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad644140b5sm18000705f8f.17.2026.11.23.01.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:41:15 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 09:41:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 755401bd9da814ac73c94abe8f6343b863abbffa
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a59552a645ef4ef6c8290667c3fa9020031566d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVQY6-000000003YB-2tNc
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3398648955852464325=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3398648955852464325==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kemHrfMI5aQ="; charset=UTF-8

--kemHrfMI5aQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2217?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_verify: use chec=
k_for_client_reason() in tls_authentication_status()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: use check_for_client_r=
eason() in tls_authentication_status()

tls_authentication_status() open-co=
ded check_for_client_reason() for
the plugin and script auth status=2E Call=
 the helper instead=2E
key_state_check_auth_failed_message_file() had no ot=
her caller, so
fold it into the helper=2E

Change-Id: Ia48c1efc9a687383a1dc=
87edd49d8ba3eb5a87ad
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217
Message-Id: <20261118162932=2E22639=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg41626=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=2Ec
1 file changed, =
10 insertions(+), 39 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/17/2217/3

diff --git a/src/openvpn/ssl_verify=
=2Ec b/src/openvpn/ssl_verify=2Ec
index 75cda97=2E=2E2f81968 100644
--- a/s=
rc/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1037,24 +103=
7,22 @@
 }
 
 /**
- * Checks if the auth failed reason file has any content=
 and if yes it will
- * be returned as string allocated in gc to the caller=
=2E
- */
-static char *
-key_state_check_auth_failed_message_file(const str=
uct auth_deferred_status *ads,
-                                         st=
ruct gc_arena *gc)
+ * Check if the script/plugin left a message in the aut=
h failed message
+ * file and relay it to the user */
+static void
+check_f=
or_client_reason(struct tls_multi *multi, const struct auth_deferred_status=
 *ads)
 {
-    char *ret =3D NULL;
     if (ads->auth_failed_reason_file)
 =
    {
-        struct buffer reason =3D buffer_read_from_file(ads->auth_fai=
led_reason_file, gc);
+        struct gc_arena gc =3D gc_new();
+        st=
ruct buffer reason =3D buffer_read_from_file(ads->auth_failed_reason_file, =
&gc);
 
         if (BLEN(&reason))
         {
-            ret =3D BSTR(&r=
eason);
+            auth_set_client_reason(multi, BSTR(&reason));
        =
 }
+        gc_free(&gc);
     }
-    return ret;
 }
 
 
@@ -1221,21 +1219,=
9 @@
 #endif
     if (failed_auth)
     {
-        struct gc_arena gc =3D g=
c_new();
         const struct key_state *ks =3D get_primary_key(multi);
- =
       const char *plugin_message =3D
-            key_state_check_auth_fai=
led_message_file(&ks->plugin_auth, &gc);
-        const char *script_messag=
e =3D
-            key_state_check_auth_failed_message_file(&ks->script_aut=
h, &gc);
-
-        if (plugin_message)
-        {
-            auth_set_cl=
ient_reason(multi, plugin_message);
-        }
-        if (script_message)=

-        {
-            auth_set_client_reason(multi, script_message);
-  =
      }
+        check_for_client_reason(multi, &ks->plugin_auth);
+       =
 check_for_client_reason(multi, &ks->script_auth);
 
         /* We have at=
 least one session that failed authentication=2E There
          * might be=
 still another session with valid keys=2E
@@ -1243,7 +1229,6 @@
          *=
 with the other session (and we actually did that in earlier
          * ve=
rsion, this behaviour is really strange from a user (admin)
          * exp=
erience */
-        gc_free(&gc);
         return TLS_AUTHENTICATION_FAILED=
;
     }
     else if (success)
@@ -1305,20 +1290,6 @@
  * this is the plac=
e to start=2E
  ***********************************************************=
**************** */
 
-/**
- * Check if the script/plugin left a message in=
 the auth failed message
- * file and relay it to the user */
-static void
=
-check_for_client_reason(struct tls_multi *multi, const struct auth_deferre=
d_status *status)
-{
-    struct gc_arena gc =3D gc_new();
-    const char =
*msg =3D key_state_check_auth_failed_message_file(status, &gc);
-    if (ms=
g)
-    {
-        auth_set_client_reason(multi, msg);
-    }
-    gc_free(=
&gc);
-}
 /*
  * Verify the user name and password using a script
  */

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia48c1efc9a687383a1=
dc87edd49d8ba3eb5a87ad
Gerrit-Change-Number: 2217
Gerrit-PatchSet: 3
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--kemHrfMI5aQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2217?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_verify: use check_for_client_reason() in tls_authentication_status(=
)<br><br>tls_authentication_status() open-coded check_for_client_reason() f=
or<br>the plugin and script auth status=2E Call the helper instead=2E<br>ke=
y_state_check_auth_failed_message_file() had no other caller, so<br>fold it=
 into the helper=2E<br><br>Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a=
87ad<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217<br>Message-Id: &lt;20261118162=
932=2E22639-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41626=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/ssl_verify=2Ec<br>1 file changed, 10 insertions(+), 39 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/17/2217/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/=
openvpn/ssl_verify=2Ec</span><br><span>index 75cda97=2E=2E2f81968 100644</s=
pan><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_verify=2Ec</span><br><span>@@ -1037,24 +1037,22 @@</span><br><spa=
n> }</span><br><span> </span><br><span> /**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Checks if the auth failed reason file has any cont=
ent and if yes it will</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * be returned as string allocated in gc to the caller=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static char *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-key_state_check_auth_failed_message_file(const struct auth_defer=
red_status *ads,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                    struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Check if the script/plugin left a m=
essage in the auth failed message</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * file and relay it to the user */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_for_client_reason(struct tls_multi *multi, cons=
t struct auth_deferred_status *ads)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</span><br><span>  =
   if (ads-&gt;auth_failed_reason_file)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct buffer reason =3D b=
uffer_read_from_file(ads-&gt;auth_failed_reason_file, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer reason =3D buffer_read_from_file(ads-&gt;auth_failed_reason_file, &a=
mp;gc);</span><br><span> </span><br><span>         if (BLEN(&amp;reason))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            ret =3D BSTR(&amp;reason);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            auth_set_client_reason(multi, BSTR(&amp;=
reason));</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span=
> }</span><br><span> </span><br><span> </span><br><span>@@ -1221,21 +1219,9=
 @@</span><br><span> #endif</span><br><span>     if (failed_auth)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct gc_arena gc =3D gc_new();</span><br><span>         const struct key_=
state *ks =3D get_primary_key(multi);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const char *plugin_message =3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            key_state_check_auth_failed_me=
ssage_file(&amp;ks-&gt;plugin_auth, &amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        const char *script_message =3D</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            key_state_check_auth_f=
ailed_message_file(&amp;ks-&gt;script_auth, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (plugin_message)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            auth_set_client_reason(multi, plugin_message);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (script_message)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            auth_set_client_reason(multi, script_=
message);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        check_for_clie=
nt_reason(multi, &amp;ks-&gt;plugin_auth);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        check_for_client_reason(multi, &amp;ks-&gt;s=
cript_auth);</span><br><span> </span><br><span>         /* We have at least=
 one session that failed authentication=2E There</span><br><span>          =
* might be still another session with valid keys=2E</span><br><span>@@ -124=
3,7 +1229,6 @@</span><br><span>          * with the other session (and we a=
ctually did that in earlier</span><br><span>          * version, this behav=
iour is really strange from a user (admin)</span><br><span>          * expe=
rience */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_f=
ree(&amp;gc);</span><br><span>         return TLS_AUTHENTICATION_FAILED;</s=
pan><br><span>     }</span><br><span>     else if (success)</span><br><span=
>@@ -1305,20 +1290,6 @@</span><br><span>  * this is the place to start=2E</=
span><br><span>  **********************************************************=
***************** */</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Check if the script/plugin left a message in the auth failed message</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * file and relay it to th=
e user */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_for_client_reaso=
n(struct tls_multi *multi, const struct auth_deferred_status *status)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const char *msg =3D key_stat=
e_check_auth_failed_message_file(status, &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (msg)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        auth_set_client_reason(multi, msg);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span> /*</span><br><span>  * Verify the user name an=
d password using a script</span><br><span>  */</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demai=
l">change 2217</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2217?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2217 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--kemHrfMI5aQ=--


--===============3398648955852464325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3398648955852464325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3398648955852464325==--

