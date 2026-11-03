Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48C606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IqC06u9p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MknbMWjo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bMcypX0o;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g0+jlzlA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X5FAzM2+u5y8T+mfrh9Nl7ybLGkMI2Ie/whg34JJW60=; b=IqC06u9ppb12qL7FXmIcIvec+D
	RrSzh/ak8CoAyj8kLe8mn4rG5VgS9jn51+zQh545GvURfX9QPpXrS++ypbM+29UN/xEeY97ClUDtj
	wGvwzLIUo/4VdVOrmLMPS3tRibfVbmNXzzt+yHxLHm+JU2NSdf35FPhrlEeWNcp5fLqA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO8NL-000000001m6-2Dwe;
	Tue, 03 Nov 2026 06:52:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO8NJ-000000001ly-2uzU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:52:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccVMhf1IevZZW2sV+JwJ1BAMQtseqArm3TOndjqTyCc=; b=MknbMWjoeT7x8Qs7bqDd/ltore
 BThlDvfNv0oS3eSQIh7RNAINZck0cxU0217BpgqMBNpN1vX0/hwBqP6M9WuBJ0nhfPbkJ/jbyOxIV
 83SLz7DeaUdPAj6B3ptE9aBRpq38u3JzCPhs1+45VZTY9a/Hkv8FSLBBChENk/pkAUEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccVMhf1IevZZW2sV+JwJ1BAMQtseqArm3TOndjqTyCc=; b=bMcypX0o2hgmLV6B8nd3ZCw9pb
 myh48kNnBdeZ6jK2hzlJTPNq0vHMtGz+dIKgPevoumVmmZP3eKbZtFYZOixlRZ1uhRTeNObgkCYP9
 +C4990VTmJgNMPKPsl2Lwn5vT6elLEOZku5ntTXs5cADNemXGE60IxDq3fnMp/D2yER0=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO8NH-000000001YN-2qgA for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:52:05 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso37869505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 22:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793688717; x=1794293517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ccVMhf1IevZZW2sV+JwJ1BAMQtseqArm3TOndjqTyCc=;
 b=g0+jlzlA8SAbtUcROU92HE+VzbRyLn6xifxJGiyd71z9nzGP8rKRbUgsOF/TG0NLFN
 TvRiGWdmGGzGPBMbFrSoCVEUpsdIBt8ZEF0SFMQYlp3DurleijlyLpQ/Jt1xoNOMnZgv
 3uRWayMIMxkpRt5MqgZmw3jI8sCuEGagPVfjuQu98l45CZsdMnaepF3PJ0HCYlbmd+PQ
 aof+53/2cqM3bFp0sDfadpuaBHDxRrnW6wrTzablBapm9yE632/QsqXzyW3EOwU2nyDQ
 4WqjT+83WasuhP5c4EtNHPybMg5qv2ZuinFoCnnNz23+cZ6Q0QpHZpvh+QXj3mLKupaV
 sQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793688717; x=1794293517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ccVMhf1IevZZW2sV+JwJ1BAMQtseqArm3TOndjqTyCc=;
 b=k2GHgf9liQrW8A6jMfc+znFyLihNrFA7LIBO1PrNHCfdJzDdh/uzhl2Uev3PI/qur8
 bLOfAq1eqyOh5AV2el2ZNtJGIgOojBxScUCY5r1zaZGboNPpjbRkvYgdopOTCoiHQTUT
 djToNPAZuw2rgxEIDz/c1C323WJDODNbcS81vnfi3dG/aRejqODXk2VHtXtJRtXshbDp
 Z6+74sEe6yz8cdVEj6SQalaiKUzuBj/vRPVQ8wm7Des+AlGN0wEvXNEcUBV43G6kUxCD
 wCTs2C6qWo60NPxFFDkERyUpY9aLSHiMaFc4nhprJIqRGWODHkrEcIp8BoWJl2h20H76
 pKpw==
X-Gm-Message-State: APuU4Z/aDlUrt87sabRddCsYo+dX0VJYGQtNvKtMmlKkHjoggjO/3HuV
 cyq2Gqk3dRciL1h2jARyd2NxVIlszXxE/aBxPRInkKm+3u2jKmIL4jd2IcsEG9Cj6jSf6NS1C1j
 EiPSMxM6B0f1jBTWuuhkBiem0REGbLEWn/B+lN0A9aHh/TxJyZjNkAc1bP4BWTZ0ZSE3dO/9CCK
 C2YVA2lQ==
X-Gm-Gg: AYBFou2ItZp0wXfCqNJuH0n5IZOeLvoG+Z2dPxUt5F3Fry3ZR+vavqmIzgszms+7SM0
 SNemq60PnY5yE2BqwcSIF2Db1FO4kkKzVCl4OFmd12Kze1s8CqbtKbU0+XFFERaZ+QKmjfXNtdw
 3ZFuFy0Jg8BwyJU85ItPETf/+7M5zq3zikmJ9rV7A9g/crs0KbXYi+PWsxhcA4fvGwliEPUEEIc
 yvcckQGY672GhAjjNQD5J41fZHwT7dJs88aluzBSP2l4RylmFablEdsTggz0DV5hCW7lmVj7uHt
 w2f2WvCSMKdIcTBp6WfYS+UukLhuJRW4H+IT05BGXNn+bEezdBphhzh4rMEDcIsBYCddCIW2Ct3
 5wtod5h5MCTTu9Uu531+kYbhWuOKwRBxX7Yojj/yxT+XqjAhfh6bz5/Jr4Vaz08OYpZngKr7Yeq
 uDuN+QW+al6Il+POF2vghWqLgwR8WyoeMLzXOL8d0qatuKUMm4FT2Op5xpOMXAGph/mcgrPy8oR
 izm1jA1gZy5aBclIiS34P2u7lN/tIVwmfT0d0bmzZehld1UOnoJi8WB5ISYvpFw415WYg6SZwW/
 GL/AvkR839Ssdl6+LRfitJQvwKRUFpXTdDSe9Ac3Ng19fTiYjYhnHdQqR8I6bRnHrvA29agXK76
 Y2eXNmDWIvCA9MWmhNmULLSLiSNC/MpLOZU7SmT9nq4lt3mfckZN/n6F76haeCcdEJr/T9xo2e0
 OwZ++zYVylf+iwaw==
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4ac17e10ac3mr288842925e9.19.1793688716930; 
 Mon, 02 Nov 2026 22:51:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7706516sm211442495e9.0.2026.11.02.22.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:51:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 06:51:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
X-Gerrit-Change-Number: 2098
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2098?usp=email>
X-Gerrit-Commit: 4d5e235ada21144164aa2feebd0a54d5f8e5c798
In-Reply-To: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2NjE4MDAwLkllNmMxZmE2NjM5NzhlZWRjYTIzOTFmMTI1MDEyOWJjNDY3MzhmYWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e116119873818b68c4ba7870597fb3cce011f49-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO8NH-000000001YN-2qgA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused local
 variables
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
Content-Type: multipart/mixed; boundary="===============8040254522771838174=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8040254522771838174==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eC1hAxY2tNM="; charset=UTF-8

--eC1hAxY2tNM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2098?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Remove unused local variables
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove unused local variables

- t=
ls_session_generate_dynamic_tls_crypt_key(): kds
- socks_proxy_recv_char():=
 reads fd_set
- verify_cert_call_command(): gc
- man_dispatch_command(): gc=
, the unused nparms parameter and the
  done label, which only served gc_fr=
ee()

Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=2Ec
M src/o=
penvpn/socks=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/tls_crypt=2Ec
4=
 files changed, 2 insertions(+), 18 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2098/2

diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 16864c8=2E=2E102f96e 100644
=
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1478,16 +1478=
,12 @@
 }
 
 static void
-man_dispatch_command(struct management *man, stru=
ct status_output *so, const char **p,
-                     const int nparm=
s)
+man_dispatch_command(struct management *man, struct status_output *so, =
const char **p)
 {
-    struct gc_arena gc =3D gc_new();
-
     ASSERT(p[0]=
);
     if (streq(p[0], "exit") || streq(p[0], "quit"))
     {
         man=
->connection=2Ehalt =3D true;
-        goto done;
     }
     else if (stre=
q(p[0], "help"))
     {
@@ -1841,9 +1837,6 @@
     {
         msg(M_CLIENT,=
 "ERROR: unknown command [%s], enter 'help' for more options", p[0]);
     =
}
-
-done:
-    gc_free(&gc);
 }
 
 #ifdef _WIN32
@@ -2250,7 +2243,7 @@
 
 =
        if (nparms > 0)
         {
-            man_dispatch_command(man, s=
o, (const char **)parms, nparms);
+            man_dispatch_command(man, so=
, (const char **)parms);
         }
     }
 
diff --git a/src/openvpn/socks=
=2Ec b/src/openvpn/socks=2Ec
index cab9af6=2E=2Ea8c9fd3 100644
--- a/src/op=
envpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -86,10 +86,6 @@
            =
           const struct event_timeout *server_poll_timeout,
               =
        volatile int *signal_received)
 {
-    fd_set reads;
-    FD_ZERO(&=
reads);
-    openvpn_fd_set(sd, &reads);
-
     struct timeval tv;
     tv=
=2Etv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
     tv=
=2Etv_usec =3D 0;
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl=
_verify=2Ec
index 73e3696=2E=2E167e659 100644
--- a/src/openvpn/ssl_verify=
=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -515,7 +515,6 @@
                 =
         char *subject)
 {
     int ret;
-    struct gc_arena gc =3D gc_new=
();
     struct argv argv =3D argv_new();
 
     setenv_str(es, "script_typ=
e", "tls-verify");
@@ -526,7 +525,6 @@
     argv_msg_prefix(D_TLS_DEBUG, &a=
rgv, "TLS: executing verify command");
     ret =3D openvpn_run_script(&arg=
v, es, 0, "--tls-verify script");
 
-    gc_free(&gc);
     argv_free(&argv=
);
 
     if (ret)
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls=
_crypt=2Ec
index 23c7975=2E=2E447262c 100644
--- a/src/openvpn/tls_crypt=2E=
c
+++ b/src/openvpn/tls_crypt=2Ec
@@ -121,9 +121,6 @@
 
     const int key_=
direction =3D session->opt->server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_I=
NVERSE;
 
-    struct key_direction_state kds;
-    key_direction_state_ini=
t(&kds, key_direction);
-
     struct key_type kt =3D tls_crypt_kt();
 
   =
  init_key_ctx_bi(&session->tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &rengokeys, =
key_direction, &kt,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2098?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
Gerrit-Change-Number: 2098
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--eC1hAxY2tNM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Remove unused local variables<br><br>- tls_session_generate_dynam=
ic_tls_crypt_key(): kds<br>- socks_proxy_recv_char(): reads fd_set<br>- ver=
ify_cert_call_command(): gc<br>- man_dispatch_command(): gc, the unused npa=
rms parameter and the<br>  done label, which only served gc_free()<br><br>C=
hange-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0<br>Signed-off-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec=
<br>M src/openvpn/socks=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvp=
n/tls_crypt=2Ec<br>4 files changed, 2 insertions(+), 18 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/98/2098/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index 16864c8=2E=2E102f96e 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -1478,16 +1478,12 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-man_dispatch_command(struct management *man, struct status_ou=
tput *so, const char **p,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                     const int nparms)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+man_dispatch_command(struct management *man, struct =
status_output *so, const char **p)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT=
(p[0]);</span><br><span>     if (streq(p[0], &quot;exit&quot;) || streq(p[0=
], &quot;quit&quot;))</span><br><span>     {</span><br><span>         man-&=
gt;connection=2Ehalt =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        goto done;</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;help&quot;))</span><br><span>     {</span><br><span=
>@@ -1841,9 +1837,6 @@</span><br><span>     {</span><br><span>         msg(=
M_CLIENT, &quot;ERROR: unknown command [%s], enter &#39;help&#39; for more =
options&quot;, p[0]);</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&a=
mp;gc);</span><br><span> }</span><br><span> </span><br><span> #ifdef _WIN32=
</span><br><span>@@ -2250,7 +2243,7 @@</span><br><span> </span><br><span>  =
       if (nparms &gt; 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            man_dispatch_command(man, so, (=
const char **)parms, nparms);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            man_dispatch_command(man, so, (const char **)parms);<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><=
br><span>index cab9af6=2E=2Ea8c9fd3 100644</span><br><span>--- a/src/openvp=
n/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ =
-86,10 +86,6 @@</span><br><span>                       const struct event_t=
imeout *server_poll_timeout,</span><br><span>                       volatil=
e int *signal_received)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    fd_set reads;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    FD_ZERO(&amp;reads);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    openvpn_fd_set(sd, &amp;reads);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct timeval tv;<=
/span><br><span>     tv=2Etv_sec =3D get_server_poll_remaining_time(server_=
poll_timeout);</span><br><span>     tv=2Etv_usec =3D 0;</span><br><span>dif=
f --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br=
><span>index 73e3696=2E=2E167e659 100644</span><br><span>--- a/src/openvpn/=
ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><=
span>@@ -515,7 +515,6 @@</span><br><span>                          char *su=
bject)</span><br><span> {</span><br><span>     int ret;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</spa=
n><br><span>     struct argv argv =3D argv_new();</span><br><span> </span><=
br><span>     setenv_str(es, &quot;script_type&quot;, &quot;tls-verify&quot=
;);</span><br><span>@@ -526,7 +525,6 @@</span><br><span>     argv_msg_prefi=
x(D_TLS_DEBUG, &amp;argv, &quot;TLS: executing verify command&quot;);</span=
><br><span>     ret =3D openvpn_run_script(&amp;argv, es, 0, &quot;--tls-ve=
rify script&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>     argv_free(&amp;a=
rgv);</span><br><span> </span><br><span>     if (ret)</span><br><span>diff =
--git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><sp=
an>index 23c7975=2E=2E447262c 100644</span><br><span>--- a/src/openvpn/tls_=
crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@=
@ -121,9 +121,6 @@</span><br><span> </span><br><span>     const int key_dir=
ection =3D session-&gt;opt-&gt;server ? KEY_DIRECTION_NORMAL : KEY_DIRECTIO=
N_INVERSE;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct key_direction_state kds;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    key_direction_state_init(&amp;kds, key_direction);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 struct key_type kt =3D tls_crypt_kt();</span><br><span> </span><br><span> =
    init_key_ctx_bi(&amp;session-&gt;tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &am=
p;rengokeys, key_direction, &amp;kt,</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail">change =
2098</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2098 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></htm=
l>
--eC1hAxY2tNM=--


--===============8040254522771838174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8040254522771838174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8040254522771838174==--

