Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA360A2602
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TnEEEbrI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i3bZiqw3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZWdHUCOf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JT2dBUDZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MAVznUsHmAhqGx7SfBMzEor3qMAB4ybdqLlJzFrwjEk=; b=TnEEEbrIy3KZFrvEBPTlfeCISq
	Vodd5Gz8/mw7ddA0/kybwUI/5v06eM6wntpIX3CXyXbnkg61UqxB2WvbiuCZrDg2OX9UWJOUOEk2i
	EyZdyWX+jXtA3rBKphta83PTlW5xMFtEO2XzrtPTzFXuAVAmflfpoeug3xMqphiSeTXw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThTq-000000005Jo-2OHY;
	Wed, 18 Nov 2026 15:21:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThTp-000000005Jh-1XOX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gla6iiMY1qRymCen3sBTYIwvZSVCniw3HEGJCpiM6wE=; b=i3bZiqw3S0/OFd6pwz+yY8qxtg
 6OS92w8RKpVmmajoyP1lz4LLq34WevYzjFptsKq6Pz9jnyfHeVvNMemcuVg0atu3+9tFmMfw0Jvp1
 BsjjH82ptgqErtg3r24+O6DPX5wseEP8l5VKyB4qhDi9d+W13cjnt39CkcAjBUQJQr8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gla6iiMY1qRymCen3sBTYIwvZSVCniw3HEGJCpiM6wE=; b=ZWdHUCOfzV6w1RQEoWQ53ziSWn
 z5Z1YAibvexpz4TdsDJ6+qfuAWuNN0yny8ypfC1xpswnjmtynZdzPooeOcF05cbtgF/q/E4pDfSDS
 7FNgyMKKPki2sYI/0gN3a6ojjvkdlF+ExrZPOFPRYcwMi+8yyBnv7Iw0pwG1aNVOrpn8=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThTo-000000004Bf-1Z9e for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:21:49 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so406187f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015302; x=1795620102; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gla6iiMY1qRymCen3sBTYIwvZSVCniw3HEGJCpiM6wE=;
 b=JT2dBUDZkkp5o27zUZVpPTTDw6UUYTOFGC9NYHB1aK3fsha1MV4xeO2+V0rT4hbNX6
 sw1TQaQNDyvgfNJAsykYF1RXWKqn1OwKm91/Np7NFX0CGZqZNgJDlzqa0a5LkjrIoH9/
 3rz7hn+2lylLBbNa2Xj92LjsTg6JX06x9BOdlRTgpjL/jbstzf/L6DsapB9kih8c8+X+
 zDfz6CsIUf95bmjFUDoHzeNqTC4VayKHll2kJxDATgBjZIO73rvjtYrH2LM/wvBdmD87
 x5iYRo63u9yHsAESoOdmZRLC9Oi8msb7B/nqNZbJkMxY/j2g0hhOyRdeOtRVsiH0OYXf
 /8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015302; x=1795620102;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gla6iiMY1qRymCen3sBTYIwvZSVCniw3HEGJCpiM6wE=;
 b=HiWMDGveJAMuOlETXvJL3zj7/dkYJxPqSwWk2XONW2UvYlTLog2yY7zV1ZV4wU0PEl
 crFdNIrYHjVTzvqt3QIijlwV37/vuf+0DuNw0qUEtPVhU4/CV0OzBm1WOPOUPKpQr8v7
 V0SsTYsVpP2A+qiCPibiXHsHLq9UxauHmRk7i8BogX54B7ViDrQuzTDLviceZtBXljSP
 +mgJyq+RVT+Y7idbfvYvEvRJwZsuEoe1YthREGqI+wo5ihdt47nThelgligl7KWpcaXD
 51xkG8d46jS3EV3QVSmBVwRAAhK0sM5fqFU9zSi3yT784MZ6cSZTEQfEIuSnkg0IRQIY
 nrlg==
X-Gm-Message-State: APuU4Z/H1hyxQm5aDXPK+bS9GqRGwBKhvfCfQG8CdJoVvWIVkI86YcoH
 Aj1gSOdIW9bCKixmZ0SSpKtNjTsm2IAp2VrhmPwKJyMQhvDnNf6ETPAwYXaySf1g42ATL34ganK
 rMBLSbKh87NcOdIbVeI1WbhBCNNDXBK3T/wgQj5rj2Bre4zrOm8pboBMk6Uc06JctL2jk
X-Gm-Gg: AZFdTZeDcg1NgwdUim8CR9BpMX8WSNw+CjLjClSUl/2pqfwUXcPmmTazAGyaWnb+2Hk
 fGimpoZPfJpK5R/+vYN3xoqOt7PXayUVIcv23tthxvWIQC/0sF1cMdiiRcAbKXyrJ8lt99lm0La
 Gr0Wm/k5H3UBGgonOH+e1PAidXpGG4r+M2lyFhdFtBDUHvfUZoTZ7P2eKmSpPxNr4p/Fz14Dyn+
 dV4dy8y9LizR9Yvi0xeMVY8T6AxfYkjlzl14VYUzkugFAIjgExLknKjTYVCgg1bxYVJLsYK0khS
 slf9tlkwH1E9k0Fd1UHTtiDFDxMT068j/KCq83dQ2l5RF1hdjZd+2WufXENk7qYJH1k1Mh2XIvU
 ywzMHFXf+2KJYsEqsJy+wM87i5OhGMCWEQAvoTG6yhsDYH0xfMYtN+N/7dfX2tBOojpUPGC/t7n
 c/JqlNeZ5OioiBynWLgtK+F3Gw6D7fI82b92QJfx8/NHQdvKBx6cDeXz1orqqiFKVCfZ2I8jtAD
 +Og7tB83KtHY1k36AAwlHi5s47UJa9X9rUa6MOFajOZlqtBD7+Y52omvDIUFxc9dJwG+OBjAU2W
 XKWJ5zIci1i6+hV2b3i8AXJDmne7Brpe5SAMVARJk1l47ur4JxtiJXUJ7K928l0GvLPbYLA2yPG
 ShSRskNId3vIiSj9lkriGZ/8lv53WjkCmiG3n2lQGvjwU27YMHFiTqTrq/3HtKLvIMtqRmMasBD
 3slkqgmA71KS5hSK8=
X-Received: by 2002:a05:6000:4903:b0:48e:3697:708d with SMTP id
 ffacd0b85a97d-4a63a1e0624mr6310229f8f.12.1795015301530; 
 Wed, 18 Nov 2026 07:21:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560ab64sm5082426f8f.25.2026.11.18.07.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:21:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:21:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 6421b734a7d736295fc7220ab74ddca22632790f
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00ce57a4c50fa845168788a6e03f9ba6ad0a5bb5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xThTo-000000004Bf-1Z9e
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5305404478275113758=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5305404478275113758==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TWpkAq1Me9k="; charset=UTF-8

--TWpkAq1Me9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2217?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Frank Licht=
enheld


Change subject: ssl_verify: use check_for_client_reason() in tls_a=
uthentication_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl_verify: use check_for_client_reason() in tls_authentication_=
status()

tls_authentication_status() open-coded check_for_client_reason() =
for
the plugin and script auth status=2E Call the helper instead=2E
key_sta=
te_check_auth_failed_message_file() had no other caller, so
fold it into th=
e helper=2E

Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_verify=
=2Ec
1 file changed, 10 insertions(+), 39 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/2217/2

diff --git a/sr=
c/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 8641d15=2E=2Ef3=
3a59c 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=
=2Ec
@@ -1037,24 +1037,22 @@
 }
 
 /**
- * Checks if the auth failed reason=
 file has any content and if yes it will
- * be returned as string allocate=
d in gc to the caller=2E
- */
-static char *
-key_state_check_auth_failed_m=
essage_file(const struct auth_deferred_status *ads,
-                      =
                   struct gc_arena *gc)
+ * Check if the script/plugin left=
 a message in the auth failed message
+ * file and relay it to the user */
=
+static void
+check_for_client_reason(struct tls_multi *multi, const struct=
 auth_deferred_status *ads)
 {
-    char *ret =3D NULL;
     if (ads->auth_=
failed_reason_file)
     {
-        struct buffer reason =3D buffer_read_fr=
om_file(ads->auth_failed_reason_file, gc);
+        struct gc_arena gc =3D =
gc_new();
+        struct buffer reason =3D buffer_read_from_file(ads->auth=
_failed_reason_file, &gc);
 
         if (BLEN(&reason))
         {
-      =
      ret =3D BSTR(&reason);
+            auth_set_client_reason(multi, BST=
R(&reason));
         }
+        gc_free(&gc);
     }
-    return ret;
 }
 =

 
@@ -1221,21 +1219,9 @@
 #endif
     if (failed_auth)
     {
-        str=
uct gc_arena gc =3D gc_new();
         const struct key_state *ks =3D get_p=
rimary_key(multi);
-        const char *plugin_message =3D
-            key=
_state_check_auth_failed_message_file(&ks->plugin_auth, &gc);
-        cons=
t char *script_message =3D
-            key_state_check_auth_failed_message=
_file(&ks->script_auth, &gc);
-
-        if (plugin_message)
-        {
-  =
          auth_set_client_reason(multi, plugin_message);
-        }
-      =
  if (script_message)
-        {
-            auth_set_client_reason(multi,=
 script_message);
-        }
+        check_for_client_reason(multi, &ks->p=
lugin_auth);
+        check_for_client_reason(multi, &ks->script_auth);
 
 =
        /* We have at least one session that failed authentication=2E There=

          * might be still another session with valid keys=2E
@@ -1243,7 +=
1229,6 @@
          * with the other session (and we actually did that in e=
arlier
          * version, this behaviour is really strange from a user (a=
dmin)
          * experience */
-        gc_free(&gc);
         return TLS_=
AUTHENTICATION_FAILED;
     }
     else if (success)
@@ -1305,20 +1290,6 @@=

  * this is the place to start=2E
  **************************************=
************************************* */
 
-/**
- * Check if the script/plu=
gin left a message in the auth failed message
- * file and relay it to the =
user */
-static void
-check_for_client_reason(struct tls_multi *multi, cons=
t struct auth_deferred_status *status)
-{
-    struct gc_arena gc =3D gc_ne=
w();
-    const char *msg =3D key_state_check_auth_failed_message_file(stat=
us, &gc);
-    if (msg)
-    {
-        auth_set_client_reason(multi, msg);=

-    }
-    gc_free(&gc);
-}
 /*
  * Verify the user name and password usi=
ng a script
  */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2217?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Gerrit-Change-Number: 2217
Gerr=
it-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--TWpkAq1Me9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2217?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
_verify: use check_for_client_reason() in tls_authentication_status()<br><b=
r>tls_authentication_status() open-coded check_for_client_reason() for<br>t=
he plugin and script auth status=2E Call the helper instead=2E<br>key_state=
_check_auth_failed_message_file() had no other caller, so<br>fold it into t=
he helper=2E<br><br>Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad<br=
>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M s=
rc/openvpn/ssl_verify=2Ec<br>1 file changed, 10 insertions(+), 39 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/17/2217/2</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=
=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 8641d15=2E=2Ef33a59=
c 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+=
++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1037,24 +1037,22 @@</sp=
an><br><span> }</span><br><span> </span><br><span> /**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Checks if the auth failed reason file h=
as any content and if yes it will</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * be returned as string allocated in gc to the caller=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-key_state_check_auth_failed_message_file(const stru=
ct auth_deferred_status *ads,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                         struct gc_arena *gc)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the script/pl=
ugin left a message in the auth failed message</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * file and relay it to the user */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_for_client_reason(struct tls_multi=
 *multi, const struct auth_deferred_status *ads)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</span=
><br><span>     if (ads-&gt;auth_failed_reason_file)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer=
 reason =3D buffer_read_from_file(ads-&gt;auth_failed_reason_file, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct buffer reason =3D buffer_read_from_file(ads-&gt;auth_failed_re=
ason_file, &amp;gc);</span><br><span> </span><br><span>         if (BLEN(&a=
mp;reason))</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            ret =3D BSTR(&amp;reason);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            auth_set_client_reason(mult=
i, BSTR(&amp;reason));</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span> }</span><br><span> </span><br><span> </span><br><span>@@ -12=
21,21 +1219,9 @@</span><br><span> #endif</span><br><span>     if (failed_au=
th)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct gc_arena gc =3D gc_new();</span><br><span>         cons=
t struct key_state *ks =3D get_primary_key(multi);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        const char *plugin_message =3D</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            key_state_check_a=
uth_failed_message_file(&amp;ks-&gt;plugin_auth, &amp;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        const char *script_message =3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            key_state=
_check_auth_failed_message_file(&amp;ks-&gt;script_auth, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (plugin_message)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            auth_set_client_reason(multi, plugin_messag=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (script_message)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            auth_set_client_reason(m=
ulti, script_message);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
heck_for_client_reason(multi, &amp;ks-&gt;plugin_auth);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        check_for_client_reason(multi, =
&amp;ks-&gt;script_auth);</span><br><span> </span><br><span>         /* We =
have at least one session that failed authentication=2E There</span><br><sp=
an>          * might be still another session with valid keys=2E</span><br>=
<span>@@ -1243,7 +1229,6 @@</span><br><span>          * with the other sess=
ion (and we actually did that in earlier</span><br><span>          * versio=
n, this behaviour is really strange from a user (admin)</span><br><span>   =
       * experience */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        gc_free(&amp;gc);</span><br><span>         return TLS_AUTHENTICATI=
ON_FAILED;</span><br><span>     }</span><br><span>     else if (success)</s=
pan><br><span>@@ -1305,20 +1290,6 @@</span><br><span>  * this is the place =
to start=2E</span><br><span>  *********************************************=
****************************** */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Check if the script/plugin left a message in the auth fail=
ed message</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * file and=
 relay it to the user */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_f=
or_client_reason(struct tls_multi *multi, const struct auth_deferred_status=
 *status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *m=
sg =3D key_state_check_auth_failed_message_file(status, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        auth_set_client_reason(multi, msg);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span> /*</span><br><span>  * Verify t=
he user name and password using a script</span><br><span>  */</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2217?usp=3Demail">change 2217</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2217?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2217 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--TWpkAq1Me9k=--


--===============5305404478275113758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5305404478275113758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5305404478275113758==--

