Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F99606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GFIFAkhE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ToG919c5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lR4GhU9q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eGIJe1Yo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=1cX6GLNEyNDo904hmwl/C8upfQmn+CGhJlMVoeCECV8=; b=GFIFAkhEgusSbTU+eM/n2Di2eI
	h/2bFlJoFte1JwOXe8KcR+YcGNzPoqLGy608ot2r2xDhqtBI4MzGlQZeiOeC0n4eNl3aXxNLpYMAd
	hiHStFzmkvaeLjgM+5c2vjxD6VhKUwSc0/W6zpsf/E9+be8D/U0Ccir+ODUdMADQwf1U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTbK5-000000008VS-08va;
	Wed, 18 Nov 2026 08:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTbK3-000000008VM-3W3j
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9akXXUZ5tOlWD8xWNZ1iEcoeLltNTTyesXZhBChZAGE=; b=ToG919c53MxfGJXm935tn1l9xT
 TdSt8Y56JUmmCeZzRtPPfRZqUo8OI3HHmpAE1ZOgTvDBrQlXjwqJf7+3+voilFAwbLwOSpAwFvt/3
 8pq0VcxthOzn0Kkr286uP40hwE7+a5aLQ5w5s4vOZniXbFCrq/OBSBFURotC0V/ha2ro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9akXXUZ5tOlWD8xWNZ1iEcoeLltNTTyesXZhBChZAGE=; b=lR4GhU9qW+JLnKyl2Z6yj+XJIs
 nefmSQmfh9w9R61c/kAGd9ESO+LkxX2IngoMqe53QdpshMWrcmg6M0cZcWkxSW7UXDswe+lGG+7B0
 O0/4f2zDEwaDW3SA1OxDx2Vw+ISstGs0svcwY0s8M2I+8pdK9eiUGSJ7OmMgOdojc0tQ=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTbJz-000000002Dq-36iY for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:47:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so530149f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794991629; x=1795596429; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9akXXUZ5tOlWD8xWNZ1iEcoeLltNTTyesXZhBChZAGE=;
 b=eGIJe1Yozf1+zFlGVVKPJTTdZ7Gpqol3jzoFSyHiWonzAu9ZDSKDDduuKTN5xMWhoQ
 HkuZOAI63sTkWsj1fxUDBpDMrLZf0QFsV+l0Btg8fGAQBHzN3t7/e7MJk8b/bu9oUk4w
 ik//SSSkgiQPdfZj+svsGmEpdUQEyuU0UV8ykS2zov/urco+kdiUDWyq5HYg48za/+6+
 4YPeP/0zHKKmCRaEPQnYAoPs9sZ1i8g4A3g3veIwkc8kLr+wjRLOAAa6Pd2HN0JqHzXB
 ohRu6ZmBuyjdcgpTi419SM95AcwATygjwejB+iPte+jbp4urSVV+LvpE60OUGNkosbp+
 x1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794991629; x=1795596429;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9akXXUZ5tOlWD8xWNZ1iEcoeLltNTTyesXZhBChZAGE=;
 b=SzIuinRB4S4pfM4ITjo3zfXKfdI4FN7VpLqzbJDxmKYmFanzTfULJNARpOU++Mq4/z
 OT45vvi3gqj2wRPwFiEoUaoi6ZJBdeYmX8AW569mXOJA9lzHZ9yjfhcenjwhH5RmgEXg
 Q2ddauTKoUOvpipq/7C3GVdK0rsBuTQoQgvvnwAmpPtBfUEuf38seRdeztC0BeqQQjTk
 EabcwJDsfmXLfRIidGmi2rzdM6rsHcifABxoyWJqC9PugkbJ6WnB2YY1QNT1VBjjCDD8
 5NUs6yPa/YJQMnKw3A5CaDhBguipzs0mYH+OHSMRDNw8yT4LRj7vuE6CJgS55CsWqG+a
 blMg==
X-Gm-Message-State: APuU4Z/6+WgrEWEq+FtHxWORy5CK+EE/kgEvPvhT4vn83b0q4r7SsZjO
 kHirtPqtaXGUjZfERyOd7DAYT8wahSuuKVEMrEktccdHKXEhCa/9RFvGIHgW3lKHdjfSEP/KIRV
 K9nErU4ZwNTx4Dm+sso0ZuroukOT6OACyCc5RjkNRMlg5sjvc+W2AFMNkbKWn5Sugpb5s
X-Gm-Gg: AZFdTZeo+52X4+ucOh2XURdrokW5I2w1GoNhqJ5SAH201W8GIoGFAeBXy0SbfR8RZS+
 H1myqDSekurcz8QcLQ9TymFK3pqPEUzAw3SWB61HL+SJPJ/KyDZCpEXfLpxQi0YedKXWIWIUe3Q
 Z3C4wweUFRlSt+i0lgKgn/35Gca4nRQSsefEmDufzzEa3gpc0sAaHsX7+bKWIlLo+KYCyCEK13W
 3uyYxRdLOxHvl1WzjvMMg3Q9a85GWQC2SXqeJ8g6IZQuknPDc9kFT//ZtbWNPLyl39vHPpdM1BJ
 OCWhSIWyTd/GM6L04YKTqgZaPpE3vH5eQrL4p6G+Hf+dpz5VnISsSBF9qZdqdjqAe8mLzHRk8vu
 7aEXY12ye2rXoeb1p+w+p+kxJoSOsTJnOd7dGr/5FyjiUqA+P9VMyo3usfFdGAYVTjrvBZmJ3gC
 nAfEpCDO1Hmg22rchUkolCbUBYviWpLblynuOqz+6qz87hVu9AsbPLMKkv9ztJDBAIPftDkdSv0
 F0BWSVU/5AFP2ExovHTpdKNJomp19NmAb9z6TNXrNx6S4Q196cqSD4GHa6aMjV3NGVWIVn8pQ8M
 s1E3srznr4WzlDpGahhDRi1ab8ik1v/hqn4H9BAFoMkxq9aNo7ZUz/uniS5HQHmeoZ8X6nE3+IB
 UBpHimHSlW6k97I4IJCzqwiatxw1f0OuSvNllUb9SZLqzZftILWt+4AzHZtZaaC05WOqbQMR7kv
 4Un5bGQxbGF6hDkCM=
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:31fa with SMTP id
 ffacd0b85a97d-4a64f35323dmr3601088f8f.3.1794991628960; 
 Wed, 18 Nov 2026 00:47:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560b5f1sm3549419f8f.21.2026.11.18.00.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:47:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 08:47:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 86b4a70d6fe72b7bfdde90600c8601f0a4b76b3d
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2f11f7e6c0e42112ad365012a8d581936086040-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTbJz-000000002Dq-36iY
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8030241195796761236=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8030241195796761236==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n6B7PTkNG9U="; charset=UTF-8

--n6B7PTkNG9U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2217?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: use check_for_client_reason() in tls_authenti=
cation_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_verify: use check_for_client_reason() in tls_authentication_status=
()

tls_authentication_status() open-coded check_for_client_reason() for
th=
e plugin and script auth status=2E Move the helper up and call it=2E

Chang=
e-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Signed-off-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_verify=2Ec
1 file changed=
, 17 insertions(+), 29 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/17/2217/1

diff --git a/src/openvpn/ssl_veri=
fy=2Ec b/src/openvpn/ssl_verify=2Ec
index 8641d15=2E=2Ef121f0f 100644
--- a=
/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1159,6 +11=
59,21 @@
 static time_t cache_intervals[] =3D { 0, 0, 0, 0, 0, 1, 1, 2, 2, =
4, 8 };
 
 /**
+ * Check if the script/plugin left a message in the auth fa=
iled message
+ * file and relay it to the user */
+static void
+check_for_c=
lient_reason(struct tls_multi *multi, const struct auth_deferred_status *st=
atus)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *msg =3D key=
_state_check_auth_failed_message_file(status, &gc);
+    if (msg)
+    {
+ =
       auth_set_client_reason(multi, msg);
+    }
+    gc_free(&gc);
+}
+
+=
/**
  * uses cache_intervals times to determine if we should update the
  *=
 cache=2E
  */
@@ -1221,21 +1236,9 @@
 #endif
     if (failed_auth)
     {
=
-        struct gc_arena gc =3D gc_new();
         const struct key_state *=
ks =3D get_primary_key(multi);
-        const char *plugin_message =3D
-   =
         key_state_check_auth_failed_message_file(&ks->plugin_auth, &gc);
-=
        const char *script_message =3D
-            key_state_check_auth_fa=
iled_message_file(&ks->script_auth, &gc);
-
-        if (plugin_message)
- =
       {
-            auth_set_client_reason(multi, plugin_message);
-     =
   }
-        if (script_message)
-        {
-            auth_set_client_r=
eason(multi, script_message);
-        }
+        check_for_client_reason(m=
ulti, &ks->plugin_auth);
+        check_for_client_reason(multi, &ks->scrip=
t_auth);
 
         /* We have at least one session that failed authenticat=
ion=2E There
          * might be still another session with valid keys=2E
=
@@ -1243,7 +1246,6 @@
          * with the other session (and we actually d=
id that in earlier
          * version, this behaviour is really strange fr=
om a user (admin)
          * experience */
-        gc_free(&gc);
        =
 return TLS_AUTHENTICATION_FAILED;
     }
     else if (success)
@@ -1305,2=
0 +1307,6 @@
  * this is the place to start=2E
  **************************=
************************************************* */
 
-/**
- * Check if th=
e script/plugin left a message in the auth failed message
- * file and rela=
y it to the user */
-static void
-check_for_client_reason(struct tls_multi =
*multi, const struct auth_deferred_status *status)
-{
-    struct gc_arena =
gc =3D gc_new();
-    const char *msg =3D key_state_check_auth_failed_messa=
ge_file(status, &gc);
-    if (msg)
-    {
-        auth_set_client_reason(=
multi, msg);
-    }
-    gc_free(&gc);
-}
 /*
  * Verify the user name and =
password using a script
  */

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2217?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Gerrit-Change-Numbe=
r: 2217
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--n6B7PTkNG9U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: use check_for_client_reason() in tls_authen=
tication_status()<br><br>tls_authentication_status() open-coded check_for_c=
lient_reason() for<br>the plugin and script auth status=2E Move the helper =
up and call it=2E<br><br>Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87=
ad<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<b=
r>M src/openvpn/ssl_verify=2Ec<br>1 file changed, 17 insertions(+), 29 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/17/2217/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ve=
rify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 8641d15=2E=2Ef1=
21f0f 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><sp=
an>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1159,6 +1159,21 @@<=
/span><br><span> static time_t cache_intervals[] =3D { 0, 0, 0, 0, 0, 1, 1,=
 2, 2, 4, 8 };</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Check if the script/plugin left a mess=
age in the auth failed message</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * file and relay it to the user */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_for_client_reason(struct tls_multi *multi, const s=
truct auth_deferred_status *status)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *msg =3D key_state_check_auth_failed_message_=
file(status, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_c=
lient_reason(multi, msg);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * uses cache_interv=
als times to determine if we should update the</span><br><span>  * cache=2E=
</span><br><span>  */</span><br><span>@@ -1221,21 +1236,9 @@</span><br><spa=
n> #endif</span><br><span>     if (failed_auth)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc=
 =3D gc_new();</span><br><span>         const struct key_state *ks =3D get_=
primary_key(multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      const char *plugin_message =3D</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            key_state_check_auth_failed_message_file(&amp;ks=
-&gt;plugin_auth, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        const char *script_message =3D</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            key_state_check_auth_failed_message_file=
(&amp;ks-&gt;script_auth, &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (plugin_message)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a=
uth_set_client_reason(multi, plugin_message);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (script_message)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            auth_set_client_reason(multi, script_message);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        check_for_client_reason(multi, &a=
mp;ks-&gt;plugin_auth);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        check_for_client_reason(multi, &amp;ks-&gt;script_auth);</span>=
<br><span> </span><br><span>         /* We have at least one session that f=
ailed authentication=2E There</span><br><span>          * might be still an=
other session with valid keys=2E</span><br><span>@@ -1243,7 +1246,6 @@</spa=
n><br><span>          * with the other session (and we actually did that in=
 earlier</span><br><span>          * version, this behaviour is really stra=
nge from a user (admin)</span><br><span>          * experience */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span=
><br><span>         return TLS_AUTHENTICATION_FAILED;</span><br><span>     =
}</span><br><span>     else if (success)</span><br><span>@@ -1305,20 +1307,=
6 @@</span><br><span>  * this is the place to start=2E</span><br><span>  **=
************************************************************************* *=
/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check if the scri=
pt/plugin left a message in the auth failed message</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * file and relay it to the user */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-check_for_client_reason(struct tls_mult=
i *multi, const struct auth_deferred_status *status)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *msg =3D key_state_check_auth_fai=
led_message_file(status, &amp;gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (msg)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        auth=
_set_client_reason(multi, msg);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span> /*</span><br><span>  * Verify the user name and password using=
 a script</span><br><span>  */</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail">change 2217</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia=
48c1efc9a687383a1dc87edd49d8ba3eb5a87ad </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2217 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--n6B7PTkNG9U=--


--===============8030241195796761236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8030241195796761236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8030241195796761236==--

