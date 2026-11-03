Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7322606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m+i6CZrh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hcCIDnRD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EA5kNqqh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CmQDpab9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kjyEptjQp+oxVht1x9kQ19E5w5GOcBt2lMxdQ9Qt3S0=; b=m+i6CZrhcx34nX/1dXTNxuNV1U
	0xm9jvm4WGz1Jp3TH33CsNPJLlsah+31iaGd2N+MVC4e4htY1DRHWklY/o0UznyaNxtj+q/VoMEPV
	jMpDxQJjQx3fy0ym3/7BNjprUUaCvF+BPtlc+BG4ziJxnpI6D+AOyhVJ1WQeTw+hUVik=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOIEb-000000004mY-2Zb9;
	Tue, 03 Nov 2026 17:23:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOIEa-000000004mO-2kjo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yf6C7ZB7uEOjzxZFXy+riztNFGRq1nDQHFMRszAT41Q=; b=hcCIDnRDcfU0OF1ik2IVycaOkO
 M1aAtjWyCVQDN9K5SUyvcE0+MLxGjD8dnzXttrtZGvNUAoV4UYEfJEHQdErIc9QJfKVe+BSfd4vZt
 nh6JvdoV8So0/tKAA0z+2nOAG2k9hEGC+VgAgW/+eUUxWkuYl7a30EuwRpgNfnlxVZCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yf6C7ZB7uEOjzxZFXy+riztNFGRq1nDQHFMRszAT41Q=; b=EA5kNqqhTcz9fhMNBbJE7JRoch
 fnUnZVSn1hqtx5nsLdG9ScZfW016BUJWjDmDtxNqhuYx2A6gueq96VeThwbx4pPOoXZhcZtGDWrVj
 byEjl7ruEYWUDkJDvGnH80w567K2CtX6bYwuperkIO3zxNq7aFdB3ps4za/NswwMuI1Q=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOIEY-0000000017Q-3nTl for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:44 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso44685705e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793726616; x=1794331416; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yf6C7ZB7uEOjzxZFXy+riztNFGRq1nDQHFMRszAT41Q=;
 b=CmQDpab9ymj/kKApFboFeP0W4emwm5sR6NNytbEIFYf8EQadH7yYaXr7heoTXItkf8
 PDdx+kwALyVZR+Jd5dgXHdCAowXUaB3GtDkVFaFg+TrlCqBCOQg0eegLGL1ZoUIko5z7
 NeNRUNoqq0j2oLkWEoV36bAL0bHNAhghE7AsPGmN3OO3scaT32pUnQOFswiqtcmclk9h
 JFE6HThxmYqiG187HXnasy4Ue7RdWu/Xr94j4GV2JH38UASeNdOMrjG671YslUw7P8w4
 LvFEJJ5TBykpFAy4ZzAolxYIn62qc/5MZnrlE1DWB3SEqSKKZwC34GP/a2n/FYzo4pjm
 4Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726616; x=1794331416;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yf6C7ZB7uEOjzxZFXy+riztNFGRq1nDQHFMRszAT41Q=;
 b=mwop7yiqALltg4CALSmXXaWMv/h8Eg0Z2LTqbHTEcp5kSE7tF8gJsP9n0rHC+2q/kr
 hvVf5pHPXM2hF9nySP2mj6zzbafx6xz4o8Te/jnOm8JvJKtDzkoWVEN3lUPn2IvvYDtJ
 sWUStbyXLHP2gXPz7QmM+EYnyRbluiL9XE+wT9e2JY2IFs/5C1FRen75yXzkWoDovd1p
 jeEaPBpizjNnL/+gCrUwY+DsT3xtKFxnM7xwlhWDmohnfshFKZYfWjzsDrNWBRE4nde+
 5WalpHpr1dpwF+kAGhsxB8o3nP1aDSrMxjT/r1AmPeW/IzVM5aPUb7pQW+20cdniXDnO
 fl1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCsyLjX2fLsAKgQKxDlfGCWoMwv7C5sIAAOXBuK5fV7L8mDyx1yI1533DD2HPyPS9FjvHS0lJeou8emTD3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ksT6LWt31QNURv9L3360Y7CObenxmzZjEf/mqya0WjR472BML
 nMsAxPQ9TMPkZfQf5guAi0yn3i19PM1C/r4kDK/arzZVAmrGol6Uy6LrU5Kz4oRdvaOh+Pyk/lc
 T+Zddsgp2paYUSKLIaFivVBIKI29tWkUqsw9ftzd8b3WUJ7JwY5vFzaw43r7SUO7/SlMe
X-Gm-Gg: AYBFou1MpwqPdHN6Nudfi5najTQAn7OjF+oAOXMPU7Z2qQSw5/k6mtW4RxUvRFDFWas
 7VRisiETU8OXMHDR33sJ60DLhdTXZpMz62m6oGrES9mvrjLgCmQRSweUYqgKbGC34SBEjCKWgbI
 G0h7K4Nvzo2Jz7fHAqWMe4EPVohutDl6rzKA2Gr0rRJDNUcmueOCLVCuXVVdebUZoF7xIJyMyQA
 gKVeJEa89wr6HUajXaP6MZu9S9tnRw78Trt8G1/UNhQwhwNchdCVvOzJwOmci7YfqGBp3H/ciYQ
 cTvenBAXZPC7HgvEXqflVzkxW7OgB/iPx66gLJhtDOhAJxaAjZ5qdDUR1ZJiV2RVfJEOXsI+fRt
 vN1qSnP7VWrMVjOQ9AnCMh25N4ujX8sbOJL4bQy9EVHMm0Oe5w+s6RVcMBzRBuslfEOPtF3l14E
 9/LXFQ/9vzaPAQb36aE1RkjRphVjWg95raxOVdgE4zZixhE+bUM8AtOpUUjm7mK/klFfL3BtKbv
 2Aqr5Y/SwDFMaEP3lMjGW0NJNR2+Swl4O31YIL8COxwN6h8PBRXrloVOH2dT+pMbAvyCKUnFgyk
 eysofIJgVL3lztDxsfLDVb7+24E45eSBHxwrtEHtDOh0lQt1ySEplUKD9miFsz8/HKh6+OukGFj
 lTHS9Eo0fACoTc9Y5ySxFYQI4URUgoo/YDigrkOtKmeMTTZNx29sYe++OTPT26G5+TNekwh5yuD
 mNU6n0UsbdhCpqJg==
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4ac17e10ac3mr329035615e9.19.1793726616234; 
 Tue, 03 Nov 2026 09:23:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm114249695e9.3.2026.11.03.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:23:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:23:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
X-Gerrit-Change-Number: 2098
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2098?usp=email>
X-Gerrit-Commit: 32b071e67433ea69781d5af3023ac65e533171d7
In-Reply-To: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2NjE4MDAwLkllNmMxZmE2NjM5NzhlZWRjYTIzOTFmMTI1MDEyOWJjNDY3MzhmYWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4a6813e4f33a726e3cb2d5952f1b283e7e10e5d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOIEY-0000000017Q-3nTl
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7860725063501933312=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7860725063501933312==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bGKorcLv1xQ="; charset=UTF-8

--bGKorcLv1xQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2098?usp=3Demail )

Change subject: Remove unused local variabl=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove unu=
sed local variables

- tls_session_generate_dynamic_tls_crypt_key(): kds
- =
socks_proxy_recv_char(): reads fd_set
- verify_cert_call_command(): gc
- ma=
n_dispatch_command(): gc, the unused nparms parameter and the
  done label,=
 which only served gc_free()

Change-Id: Ie6c1fa663978eedca2391f1250129bc46=
738faa0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2098
Message-Id: <20261103123306=2E3866-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261103123306=
=2E3866-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
M src/openvpn/socks=2Ec
M src/ope=
nvpn/ssl_verify=2Ec
M src/openvpn/tls_crypt=2Ec
4 files changed, 2 insertio=
ns(+), 18 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec
index 987af2da=2E=2E58f63e6 100644
--- a/src/openvpn/manage=2E=
c
+++ b/src/openvpn/manage=2Ec
@@ -1532,16 +1532,12 @@
 }
 
 static void
-m=
an_dispatch_command(struct management *man, struct status_output *so, const=
 char **p,
-                     const int nparms)
+man_dispatch_command(st=
ruct management *man, struct status_output *so, const char **p)
 {
-    str=
uct gc_arena gc =3D gc_new();
-
     ASSERT(p[0]);
     if (streq(p[0], "ex=
it") || streq(p[0], "quit"))
     {
         man->connection=2Ehalt =3D tru=
e;
-        goto done;
     }
     else if (streq(p[0], "help"))
     {
@@ =
-1906,9 +1902,6 @@
     {
         msg(M_CLIENT, "ERROR: unknown command [%=
s], enter 'help' for more options", p[0]);
     }
-
-done:
-    gc_free(&gc=
);
 }
 
 #ifdef _WIN32
@@ -2315,7 +2308,7 @@
 
         if (nparms > 0)
   =
      {
-            man_dispatch_command(man, so, (const char **)parms, np=
arms);
+            man_dispatch_command(man, so, (const char **)parms);
  =
       }
     }
 
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2E=
c
index cab9af6=2E=2Ea8c9fd3 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/o=
penvpn/socks=2Ec
@@ -86,10 +86,6 @@
                       const struct eve=
nt_timeout *server_poll_timeout,
                       volatile int *signa=
l_received)
 {
-    fd_set reads;
-    FD_ZERO(&reads);
-    openvpn_fd_set=
(sd, &reads);
-
     struct timeval tv;
     tv=2Etv_sec =3D get_server_pol=
l_remaining_time(server_poll_timeout);
     tv=2Etv_usec =3D 0;
diff --git =
a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 7baa4fc=2E=
=2E0cdec1e 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_ve=
rify=2Ec
@@ -515,7 +515,6 @@
                          char *subject)
 {
  =
   int ret;
-    struct gc_arena gc =3D gc_new();
     struct argv argv =3D=
 argv_new();
 
     setenv_str(es, "script_type", "tls-verify");
@@ -526,7 =
+525,6 @@
     argv_msg_prefix(D_TLS_DEBUG, &argv, "TLS: executing verify c=
ommand");
     ret =3D openvpn_run_script(&argv, es, 0, "--tls-verify scrip=
t");
 
-    gc_free(&gc);
     argv_free(&argv);
 
     if (ret)
diff --git=
 a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c7975=2E=
=2E447262c 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_cry=
pt=2Ec
@@ -121,9 +121,6 @@
 
     const int key_direction =3D session->opt-=
>server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
-    struct key_d=
irection_state kds;
-    key_direction_state_init(&kds, key_direction);
-
 =
    struct key_type kt =3D tls_crypt_kt();
 
     init_key_ctx_bi(&session-=
>tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &rengokeys, key_direction, &kt,

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250=
129bc46738faa0
Gerrit-Change-Number: 2098
Gerrit-PatchSet: 3
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--bGKorcLv1xQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2098?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove unused local variables<br><=
br>- tls_session_generate_dynamic_tls_crypt_key(): kds<br>- socks_proxy_rec=
v_char(): reads fd_set<br>- verify_cert_call_command(): gc<br>- man_dispatc=
h_command(): gc, the unused nparms parameter and the<br>  done label, which=
 only served gc_free()<br><br>Change-Id: Ie6c1fa663978eedca2391f1250129bc46=
738faa0<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098<br>Message-Id: &lt;20261103=
123306=2E3866-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=
=2Eorg/openvpn-devel/20261103123306=2E3866-1-gert@greenie=2Emuc=2Ede<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/op=
envpn/manage=2Ec<br>M src/openvpn/socks=2Ec<br>M src/openvpn/ssl_verify=2Ec=
<br>M src/openvpn/tls_crypt=2Ec<br>4 files changed, 2 insertions(+), 18 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec</span><br><span>index 987af2da=2E=2E58f63e6 100644</span><br><=
span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -1532,16 +1532,12 @@</span><br><span> }</span><br><=
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
>@@ -1906,9 +1902,6 @@</span><br><span>     {</span><br><span>         msg(=
M_CLIENT, &quot;ERROR: unknown command [%s], enter &#39;help&#39; for more =
options&quot;, p[0]);</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&a=
mp;gc);</span><br><span> }</span><br><span> </span><br><span> #ifdef _WIN32=
</span><br><span>@@ -2315,7 +2308,7 @@</span><br><span> </span><br><span>  =
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
><span>index 7baa4fc=2E=2E0cdec1e 100644</span><br><span>--- a/src/openvpn/=
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
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ie6c1fa663978eedca2391f1250129bc46738faa0 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2098 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--bGKorcLv1xQ=--


--===============7860725063501933312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7860725063501933312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7860725063501933312==--

