Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C83606A327
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H7J31opG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k5ncw3mN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=boLdZqa0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WdlsRZ6v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nsk+02eXjlOnVlpNTRpb4S6iupGNfwuq//Goo71Mcq4=; b=H7J31opGeKTt5dwf56Z0L3vbYy
	+nx+Mo+lRODpuz05FNiGC7iLhcUJ43MX79aQ4G2xojMpHkXocOzTBXD8oFlCbtUx3WSyPIiiEEkdM
	olTqFyU3q2G2rvRQz+veyuqqrckEuTeBXyAK7LRsbRGFzLIXkSq+TIabwb2Ro4/lI+H8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSehc-000000004Tg-1AxT;
	Sun, 15 Nov 2026 18:11:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSeha-000000004Ta-3ORe
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lAvDkD23kxkuTBoDYeJ0gYNnK5vpHQ06TCud0K6McaA=; b=k5ncw3mNhAHEuHJh9cKKFPHqFE
 9X3YJdKsbeWsXYJlECgoTiQTW6IMbsczr28WQxfHlq+LVvM9lEZj8AvgUEgI+JJW1UP3m6HDnrSRi
 ZFmnQOuBUX7w5MZiqjDW6SyOr9uabqt9Rv9SxHum5fk7dbZ85c+0HQhTWO0QjIIMFSxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lAvDkD23kxkuTBoDYeJ0gYNnK5vpHQ06TCud0K6McaA=; b=boLdZqa0O9TQBJiEhBiZWOXnPg
 ASjiZ44Ww0h766S9d1wBwfu2CaVFPmYyRQVfSDwBCDUqxAbBgMSzwkJqgSct0TXfOWGIUDlnpRCl0
 rcQXc1T72RY1WQwQJ7b/A4szSR+Xt5MIa7oQLF/0tis4GUIKU/D/eu/sGCGxZXu6d+Gg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSehZ-0000000059R-13qe for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:42 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34989335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794766295; x=1795371095; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lAvDkD23kxkuTBoDYeJ0gYNnK5vpHQ06TCud0K6McaA=;
 b=WdlsRZ6vyp+6ik//bebb+N+rYwzXazFDHCB07Scr5g9nB8nrCivt6lRmU0KCoCqCSL
 uriwwFmXEYdD+der/62xqvfEld8HeC39XseosFdKMxczEYYEOE/PePpVw8EJPz6PHVWS
 2h/LJB/jyrGFEIgKoFObKx/ScJtBSncc3tKNgpCgl4RImuqD5rVvxJjLa5pe4SJYEkJn
 9xAdh1a1qQo9vxZa9rfUzsNoIm+TAYgL0igCWL4HpIL8+xuk9RTQlXNcmc2hUCWIJsFl
 TehDaTj7Lm2h5uXY4JdDXpWZQmgAJnJlpLHM8U+REM4ES5yvq+xMz86SBlwea4WgDTTb
 L1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766295; x=1795371095;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lAvDkD23kxkuTBoDYeJ0gYNnK5vpHQ06TCud0K6McaA=;
 b=1MWUnXGw/JaWQxNwt1Z0YtWYNN/5mCknELBJuh/GX9NuElYvqgmQYmXA1ZX7RAx7aD
 FZgTVmaedk8qivkrheZpzHibEzb+9Of2nTP8NXl3HmHk1IXrYRl0xfoJpdK3DVD9o8Iq
 KOmFlPSRpbxgs5a1ttU01bxu8kNlSw4TaC9AtS8Y4ZFXbK7Ti13hbNyzNcwCNqZoF0nT
 04bCAwOyTOLdb4A5yLI8Fn1zyzi9xR7/fJo+PjrsF46mzOz69WiTf9rhsJG3Inudjd4i
 wEq5+hyHbh1suckpasiiBbb2Rs6gmM9lfSzSAbN6RjJfd4lV6ZqZIAJCLhHXq0fmbI6V
 BmlA==
X-Gm-Message-State: APuU4Z8fWE4z8n4mMp/FEFa4kTj7/SLQX43WJxBYRpTdPeY0GJTsNZbS
 a3CIPX4SMIVmYt44mXZe5KqTdifvTgTiQBV4jYBwAEUfXkhAhdr3setnxkgaKKOlPlxJJsC/RgJ
 iXS+7fjNBHWsTCF9uHBhD0a6aQPD0T7XlBmcybdz+SmGIV44eUTtwwxWAQLNldUr+07JM
X-Gm-Gg: AYBFou1Dc6T756wwjz2yk1MaMg+yVip24jjD/FcHwzrZl+CHQ0pI3EWu/yrNbUgsyQy
 jvQlXTtfR6Yzy4w2o9wacROoJaG+DNjs5lCwkDrcjbiZWt+LdHMuNnKLHanGE5CmgzMcyI5QpE9
 /5Pz4ieKghmbLgAQxV5Qrexi1yRvc6ETfb2y9/wJDqkhAKlel9eGPe66VW8QQiSKwE/ebuQvBfn
 JLRF02iwSPrxuNHzczVxydRiXy0bvq8iPr2lun82TpcS8q97icm0hsx/v1obkaahKtCdo7vlKPX
 0BLSYzv8FqdFe/O1hCGwdgciRjcOUn3CgavBH7wCCOslKW1J9Eskc+irhax6hp2k+QmRVHnUr+v
 wuAKwixQUqavPqAXQ2TXhyiHzBOFGmvhJsTAWJQj1D/68omYDvD4PnBywT1UninVcEB+6Yf+XPR
 vSXI5gjR1aFbjmiPAK2NEOpl+wnrLnxJdVdAjhDFOzy+NK8BBU9o0ViZrREXdMUF5YYLsBd8onT
 pPmNTSFazcydxVqPCG2yY6CMXjp2ed7scsy4klRJP53wCiWiDaiQ4ZQR2qWGeIgmZ7oC03ERDT3
 ZY6qr957qRBgaidQMfoZ5OeSt0LPxHg3bbR9rrAvJDFhusNU2OQzzRl1O9ft66AX+biL2QsPxyD
 8wr4uo7sGVBy9YvxtAkYkpWM12+m1SKyuwzs09uj01e3aZZbqy+KBRom1Cn3Fytf1g16unEGzAi
 c/1XLnYzYgQuLIBSw=
X-Received: by 2002:a05:600c:698d:b0:4bb:5de1:e92c with SMTP id
 5b1f17b1804b1-4bb5de1f262mr124178965e9.26.1794766294346; 
 Sun, 15 Nov 2026 10:11:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb65ce005bsm146560155e9.14.2026.11.15.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:11:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 18:11:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: df3f9099bd16670a0a8a8571b4a7c9143c150d83
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9023fe1f4de053492f784bf13532ac7e3609d02c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSehZ-0000000059R-13qe
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6293596826078528373=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6293596826078528373==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UkvdxclzzF4="; charset=UTF-8

--UkvdxclzzF4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Alexandre Laroche=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
155?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Check the result of =
unchecked allocations in the server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Check the result of unchecked allocations in the ser=
ver

Several allocations were used without a NULL check, so a failed
alloca=
tion crashed the server on a NULL pointer instead of stopping
with "Out of =
Memory" like the rest of the code:

- multi_init(): calloc() of m->instance=
s; the server started and then
  crashed in multi_assign_peer_id() on the f=
irst client
- generate_auth_token(), verify_user_pass(): strdup() of auth t=
okens;
  generate_auth_token() then called strdup(NULL)
- override_locked_u=
sername(): strdup() of the override username; the
  strlcpy() from locked_u=
sername then crashed (with --auth-gen-token)
- backend_x509_get_serial_hex(=
): malloc() of the serial buffer, which
  BN_bn2binpad() then wrote to

Use=
 string_alloc(=2E=2E=2E, NULL) instead of strdup(), add
check_malloc_return=
() after the calloc(), and allocate the serial
buffer with gc_malloc(), whi=
ch also copes with a zero serial number
(BN_num_bytes() is 0 there, and mal=
loc(0) may return NULL)=2E

GitHub: closes OpenVPN/openvpn#1142

Assisted-b=
y: Claude Code:claude-opus-5-5
Change-Id: I603321ae6893dbdb054deae5a9bff5e5=
2cbb7429
Signed-off-by: Alexandre Laroche <larochealexandre@hotmail=2Ecom>
=
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2155
Message-Id: <20261115134718=2E22576-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg41355=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
4 fi=
les changed, 7 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/55/2155/3

diff --git a/src/openvpn/=
auth_token=2Ec b/src/openvpn/auth_token=2Ec
index b69092c=2E=2E703a0b2 1006=
44
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -27=
5,7 +275,7 @@
 
     /* free the auth-token if defined, we will replace it =
with a new one */
     free(multi->auth_token);
-    multi->auth_token =3D =
strdup((char *)BPTR(&session_token));
+    multi->auth_token =3D string_all=
oc((char *)BPTR(&session_token), NULL);
 
     dmsg(D_SHOW_KEYS, "Generated=
 token for client: %s (%s)", multi->auth_token, up->username);
 
@@ -285,7 =
+285,7 @@
          * Save the initial auth token to continue using the sam=
e session ID
          * and timestamp in updates
          */
-        mul=
ti->auth_token_initial =3D strdup(multi->auth_token);
+        multi->auth_=
token_initial =3D string_alloc(multi->auth_token, NULL);
     }
 
     gc_f=
ree(&gc);
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index =
0890480=2E=2Eca650ec 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/m=
ulti=2Ec
@@ -400,6 +400,7 @@
     m->max_clients =3D t->options=2Emax_clien=
ts;
 
     m->instances =3D calloc(m->max_clients, sizeof(struct multi_inst=
ance *));
+    check_malloc_return(m->instances);
 
     m->top=2Ec2=2Eeven=
t_set =3D t->c2=2Eevent_set;
 
@@ -2623,7 +2624,7 @@
         }
 
         =
multi->locked_original_username =3D multi->locked_username;
-        multi-=
>locked_username =3D strdup(options->override_username);
+        multi->lo=
cked_username =3D string_alloc(options->override_username, NULL);
 
       =
  /* Override also the common name if username should be set as common
    =
      * name */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_v=
erify=2Ec
index 6e9ecb5=2E=2E8641d15 100644
--- a/src/openvpn/ssl_verify=2E=
c
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1665,7 +1665,7 @@
          * using =
the same session ID and initial timestamp in new tokens */
         if (!mu=
lti->auth_token_initial && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK=
))
         {
-            multi->auth_token_initial =3D strdup(up->passwor=
d);
+            multi->auth_token_initial =3D string_alloc(up->password, N=
ULL);
         }
 
         if (session->opt->auth_token_call_auth)
@@ -178=
0,7 +1780,7 @@
             if (!multi->auth_token && (ks->auth_token_state=
_flags & AUTH_TOKEN_HMAC_OK)
                 && !(ks->auth_token_state_fla=
gs & AUTH_TOKEN_EXPIRED))
             {
-                multi->auth_token=
 =3D strdup(up->password);
+                multi->auth_token =3D string_al=
loc(up->password, NULL);
             }
 
             /*
diff --git a/src/=
openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index 1=
9339ad=2E=2E731ab3e 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/s=
rc/openvpn/ssl_verify_openssl=2Ec
@@ -328,11 +328,10 @@
     const ASN1_INT=
EGER *asn1_i =3D X509_get_serialNumber(cert);
     BIGNUM *bn_serial =3D AS=
N1_INTEGER_to_BN(asn1_i, NULL);
     int len_serial =3D BN_num_bytes(bn_ser=
ial);
-    unsigned char *buf =3D malloc(len_serial);
+    unsigned char *b=
uf =3D gc_malloc(len_serial, false, gc);
     BN_bn2binpad(bn_serial, buf, =
len_serial);
 
     char *ret =3D format_hex_ex(buf, len_serial, 0, 1, ":",=
 gc);
-    free(buf);
     BN_free(bn_serial);
 
     return ret;

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I603321ae6893dbdb054deae=
5a9bff5e52cbb7429
Gerrit-Change-Number: 2155
Gerrit-PatchSet: 3
Gerrit-Owne=
r: Alexandre Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UkvdxclzzF4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Alex=
andre Laroche=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2155?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Check the result of unchecked allocations in the server<br><br>Several =
allocations were used without a NULL check, so a failed<br>allocation crash=
ed the server on a NULL pointer instead of stopping<br>with &quot;Out of Me=
mory&quot; like the rest of the code:<br><br>- multi_init(): calloc() of m-=
&gt;instances; the server started and then<br>  crashed in multi_assign_pee=
r_id() on the first client<br>- generate_auth_token(), verify_user_pass(): =
strdup() of auth tokens;<br>  generate_auth_token() then called strdup(NULL=
)<br>- override_locked_username(): strdup() of the override username; the<b=
r>  strlcpy() from locked_username then crashed (with --auth-gen-token)<br>=
- backend_x509_get_serial_hex(): malloc() of the serial buffer, which<br>  =
BN_bn2binpad() then wrote to<br><br>Use string_alloc(=2E=2E=2E, NULL) inste=
ad of strdup(), add<br>check_malloc_return() after the calloc(), and alloca=
te the serial<br>buffer with gc_malloc(), which also copes with a zero seri=
al number<br>(BN_num_bytes() is 0 there, and malloc(0) may return NULL)=2E<=
br><br>GitHub: closes OpenVPN/openvpn#1142<br><br>Assisted-by: Claude Code:=
claude-opus-5-5<br>Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429<br>=
Signed-off-by: Alexandre Laroche &lt;larochealexandre@hotmail=2Ecom&gt;<br>=
Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155<br>Message-Id: &lt;202611151347=
18=2E22576-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41355=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
auth_token=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ssl_verify=2Ec<b=
r>M src/openvpn/ssl_verify_openssl=2Ec<br>4 files changed, 7 insertions(+),=
 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/55/2155/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index b69092c=
=2E=2E703a0b2 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span=
><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -275,7 +275,=
7 @@</span><br><span> </span><br><span>     /* free the auth-token if defin=
ed, we will replace it with a new one */</span><br><span>     free(multi-&g=
t;auth_token);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mul=
ti-&gt;auth_token =3D strdup((char *)BPTR(&amp;session_token));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;auth_token =3D st=
ring_alloc((char *)BPTR(&amp;session_token), NULL);</span><br><span> </span=
><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated token for client: %s (%s)=
&quot;, multi-&gt;auth_token, up-&gt;username);</span><br><span> </span><br=
><span>@@ -285,7 +285,7 @@</span><br><span>          * Save the initial aut=
h token to continue using the same session ID</span><br><span>          * a=
nd timestamp in updates</span><br><span>          */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;auth_token_initial =3D st=
rdup(multi-&gt;auth_token);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        multi-&gt;auth_token_initial =3D string_alloc(multi-&gt;aut=
h_token, NULL);</span><br><span>     }</span><br><span> </span><br><span>  =
   gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/multi=2Ec b/s=
rc/openvpn/multi=2Ec</span><br><span>index 0890480=2E=2Eca650ec 100644</spa=
n><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/m=
ulti=2Ec</span><br><span>@@ -400,6 +400,7 @@</span><br><span>     m-&gt;max=
_clients =3D t-&gt;options=2Emax_clients;</span><br><span> </span><br><span=
>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(struct multi_ins=
tance *));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check=
_malloc_return(m-&gt;instances);</span><br><span> </span><br><span>     m-&=
gt;top=2Ec2=2Eevent_set =3D t-&gt;c2=2Eevent_set;</span><br><span> </span><=
br><span>@@ -2623,7 +2624,7 @@</span><br><span>         }</span><br><span> =
</span><br><span>         multi-&gt;locked_original_username =3D multi-&gt;=
locked_username;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   multi-&gt;locked_username =3D strdup(options-&gt;override_username);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locke=
d_username =3D string_alloc(options-&gt;override_username, NULL);</span><br=
><span> </span><br><span>         /* Override also the common name if usern=
ame should be set as common</span><br><span>          * name */</span><br><=
span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</=
span><br><span>index 6e9ecb5=2E=2E8641d15 100644</span><br><span>--- a/src/=
openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>@@ -1665,7 +1665,7 @@</span><br><span>          * using the sa=
me session ID and initial timestamp in new tokens */</span><br><span>      =
   if (!multi-&gt;auth_token_initial &amp;&amp; (ks-&gt;auth_token_state_fl=
ags &amp; AUTH_TOKEN_HMAC_OK))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            multi-&gt;auth_token_initia=
l =3D strdup(up-&gt;password);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            multi-&gt;auth_token_initial =3D string_alloc(up-&gt=
;password, NULL);</span><br><span>         }</span><br><span> </span><br><s=
pan>         if (session-&gt;opt-&gt;auth_token_call_auth)</span><br><span>=
@@ -1780,7 +1780,7 @@</span><br><span>             if (!multi-&gt;auth_toke=
n &amp;&amp; (ks-&gt;auth_token_state_flags &amp; AUTH_TOKEN_HMAC_OK)</span=
><br><span>                 &amp;&amp; !(ks-&gt;auth_token_state_flags &amp=
; AUTH_TOKEN_EXPIRED))</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;auth_token =3D st=
rdup(up-&gt;password);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                multi-&gt;auth_token =3D string_alloc(up-&gt;password, N=
ULL);</span><br><span>             }</span><br><span> </span><br><span>    =
         /*</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec=
 b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 19339ad=2E=2E73=
1ab3e 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -328=
,11 +328,10 @@</span><br><span>     const ASN1_INTEGER *asn1_i =3D X509_get=
_serialNumber(cert);</span><br><span>     BIGNUM *bn_serial =3D ASN1_INTEGE=
R_to_BN(asn1_i, NULL);</span><br><span>     int len_serial =3D BN_num_bytes=
(bn_serial);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsig=
ned char *buf =3D malloc(len_serial);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    unsigned char *buf =3D gc_malloc(len_serial, false, g=
c);</span><br><span>     BN_bn2binpad(bn_serial, buf, len_serial);</span><b=
r><span> </span><br><span>     char *ret =3D format_hex_ex(buf, len_serial,=
 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    free(buf);</span><br><span>     BN_free(bn_serial);</span><br><spa=
n> </span><br><span>     return ret;</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail">change =
2155</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Alexandr=
e Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--UkvdxclzzF4=--


--===============6293596826078528373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6293596826078528373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6293596826078528373==--

