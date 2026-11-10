Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F52606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nRM8cC3K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d49eFWt9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kPB4ri3S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K8BpJHLy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uckrjFXMLT3BofQyVRunEnqh5cJH8ApG27/26AmzuXk=; b=nRM8cC3K6+H8ea8TXElZl0RG+r
	1WaUyGDACT8JbbTkCyiEoDAbGDz9MoH+83XmyQHnr9rrk4IptpSjRnyVaMW2EwtdkmGNwxM5iagfw
	fanZ+ZrW+OKRw0x8JfJ/pqPXoRbPahDCDbdCX8eyzN6UJYODMAskP2mDjMGLoiOKiHWE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjyH-000000005cr-18DO;
	Tue, 10 Nov 2026 11:25:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjyF-000000005cR-47ib
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HnlyLSncA9HY06t3TX+kkatN5gHigG5NM042YB23dhg=; b=d49eFWt96rxDZCzLV4207Gywza
 /0vJR/OaiOetxJjCb4JgwjRDJGxULhmYymCIqGW3iSMQ30KCEFoSPHWiIHWUQN0ciVaxSoBO0IQwy
 DT5qNBItppI3qcB9Jd23rPxEE3bOAD6qA07zKazT0C6vmWIIJ6RHvkGADZcCpFa+8RHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HnlyLSncA9HY06t3TX+kkatN5gHigG5NM042YB23dhg=; b=kPB4ri3SGG7UJ9i/4GFSkhxuPc
 7FdtCXo5vFrJrrjk6TAzPmfnqKjPZrZ+JbCEPuwPOxYb5zzZBj2G580nGsG9OD6kKzsAZmTv0T7LG
 8ISEuVUVG5C02rXDUZNc4ijUGOcVSgwop4sKL8ed0LUZ1f+zAo9YHKDU8poqySjHKWs8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjxl-000000004FM-1OYX for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:24:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so15961525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794309863; x=1794914663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HnlyLSncA9HY06t3TX+kkatN5gHigG5NM042YB23dhg=;
 b=K8BpJHLy049T8qBjIDeUjbXA+ycagPUXK1H3uaGpE/XVaQ7gZosBvz2VPnGzNlEhwk
 TV0ZeuSsATUzncJvsQ58nJuuc5lYTIe7ro4C4xiUaawxK0jmRK8BMiiZvTxNs5Sr+ImL
 V2CpI2MF9vN9Rn65vQVH6YpEZGAClkadaJ5TevWu9NQa0TaovgFjCmGxsQNmxpZD9AHJ
 epNM3B48UPHFb1rheSMVViYT5fDN7QajDFBHkSRRdwtnDHYM1okLyi6XphA4nGiB4CjZ
 GmsJE3KeO/YUtQgKkxX1mcwL+GUaq66dKmToywcrrWSb/jVSs8NuCeMBCyb++iABY7hu
 QIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309863; x=1794914663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HnlyLSncA9HY06t3TX+kkatN5gHigG5NM042YB23dhg=;
 b=uUsHw/1D3V7byHkeU/q3wzL9+EcvEZSNil0Q3acKzEa27rJh2dQIJ7TYtb/li0kBfQ
 UR3+Rrv4tGBIvTRPGqykXci6u0v/j4Ef6iRJDXTpQC297TI45ZJT9FINrMCWOJYCpeIV
 ayr57PXqL978exe4oEhBvpgpWK0HaAMjF0x1tvCeuZjPrJL4GKiTgDXTuq4AFK8YXDgD
 aIcdpK+CTETnvlZT4lOGZbmKGciAChm4yn3QEdmPnNkklUSltGK/8HQiJsRhrZk+uiGl
 1flCbTD/8Xdt+EqMdfykMlpctqDuimYwqOXqNBdzsGPap+6HANoIMtvXo6nS4PYhPA0G
 vTBA==
X-Gm-Message-State: APuU4Z8rlDFcb+wZ1DBd715g6kGRs52Rulr7dmRiyez6vnEc/QdQcvMl
 WmAyzh6yensaO8OS3Qpbe9zl+EbH3UIhfdHJHfXc+7tUJqfm0GetZE3xLN3nwGFv/1clzuahUGG
 IFWy2HAvlhWw5cxy6qbt1eoUFPqPemOqj4lMoq2Tjn1g+J6+2IhxnsX7OCKvZ15/t1/R5Nlc7jO
 pUsDE7Gw==
X-Gm-Gg: AYBFou2Rkb7y4PnJNIUr5s/jaZ/6QBbVqmqfNUgoRhmH6bYZvV60cPX6wPmoLdDphG4
 NtqjnjnkOlJJlSNd7FnyJxTBtZy9N7d41uY5a/PdaLFNeMT/+sQdtxkquLn12bK9IJ/Sd9PtG8O
 C8yxfyqQcrbbYadiVj6PoI3PKfpePG9e/Ivh6lyvUUxIeepGun50mk8I5CXpJVjrYOGYARkOoG3
 NKcdzPuFGdfRMzBCDq5NHXgwU2VEn1N4b8Wg6M895rh4T/TERPYurQEHVIF5MgqYMdFnXCH/Mps
 sD6Co2UZjuKTH9OPNhhvPTUc4nPrAc9xvIvICHsg5DYhcETMFbDZCnCx99B7NxIAls6KP8ypHSU
 aC6372LeLvvHhSAyefEp3PGuLXG0ZeMOOIiIPVm2vdkhvl11qJxgKqK6c94OimGuWlTwjcpSoYK
 b6wt7HXxhv2ogWNK5sYbebdAUEr8LXvISJtwt3uVqTLUKb38oqYAug14k+JnNTT8+CExO+yHNrf
 VGa5m6lz2qm5uUjAj5wavdxLCatYXf2SJN6rVBeAzFybiC7ZLntkyRo+AKNrWxCaaukgw+mXBq4
 g92VR+18guyFRgQgtit3Yj999ldzhVKT+i3Hady4bKFVG5iAm8u+K8Z3RKmFUIe1QY2YAj3RLt0
 icf5Krg+6So6Q0RCYOzQX6QC80mo/By/ge1w6KPtA4vX63bWkAhvOqBtKP90ZfqWrVYLl6L8a6g
 AgYkyKOlcM5H9K8MA=
X-Received: by 2002:a7b:c395:0:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4ba0761c465mr8580305e9.5.1794309862198; 
 Tue, 10 Nov 2026 03:24:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm87755765e9.0.2026.11.10.03.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:24:21 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:24:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: f339a5edaaffaed82865b0ac2029c8e34a8655a6
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3585dcbf7cf81d87efe8f5f87915c5c5183ac5f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjxl-000000004FM-1OYX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5395887847486621681=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5395887847486621681==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wzgjbPqHBEs="; charset=UTF-8

--wzgjbPqHBEs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2157?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various trivial -Wsign=
-conversion fixes

* Continue BLEN -> BLENZ replacement
* Remove some unnee=
ded casts
* Some trivial type fixes

Change-Id: I02f8df01f8f33cb9cd04cd844d=
1f1893688f51e8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
-=
--
M src/openvpn/acc=2Ec
M src/openvpn/auth_token=2Ec
M src/openvpn/base64=
=2Eh
M src/openvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openv=
pn/crypto=2Eh
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/manage=2Ec
M src=
/openvpn/ssl_mbedtls=2Ec
9 files changed, 34 insertions(+), 53 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/21=
57/2

diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index e21891d=
=2E=2Eb8d7c3d 100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@=
 -148,11 +148,6 @@
     return parse_acc_message_flags(flags, err_reason, g=
c);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void=

 receive_acc_message(struct context *c, const struct buffer *buffer)
 {
@@=
 -236,15 +231,10 @@
     msg(D_PUSH_ERRORS, "WARNING: Received malformed cu=
stom app control channel "
                        "message (%s): %s",
    =
     err_reason,
-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc))=
;
+        format_hex(CBPTR(buffer), BLENZ(buffer), 80, &gc));
     gc_free=
(&gc);
 }
 
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC dia=
gnostic pop
-#endif
-
 bool
 send_acc_message(struct context *c,
          =
        struct tls_multi *multi,
diff --git a/src/openvpn/auth_token=2Ec b/=
src/openvpn/auth_token=2Ec
index 211af90=2E=2Eb69092c 100644
--- a/src/open=
vpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,11 +36,6 @@
  * =
padding */
 static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is n=
ot a multiple of 3");
 
-#if defined(__GNUC__) || defined(__clang__)
-#prag=
ma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
=
-#endif
-
 bool
 is_auth_token(const char *password)
 {
@@ -67,7 +62,7 @@
 =
        return;
     }
 
-    int auth_token_state_flags =3D session->key[K=
S_PRIMARY]=2Eauth_token_state_flags;
+    unsigned int auth_token_state_fla=
gs =3D session->key[KS_PRIMARY]=2Eauth_token_state_flags;
 
     const char=
 *state;
 
@@ -188,7 +183,7 @@
 {
     struct gc_arena gc =3D gc_new();
 
-=
    int64_t timestamp =3D htonll((uint64_t)now);
+    int64_t timestamp =3D=
 (int64_t)htonll((uint64_t)now);
     int64_t initial_timestamp =3D timesta=
mp;
 
     hmac_ctx_t *ctx =3D multi->opt=2Eauth_token_key=2Ehmac;
@@ -273,=
7 +268,7 @@
         alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64out=
put) + 1, &gc);
 
     ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, =
strlen(SESSION_ID_PREFIX)));
-    ASSERT(buf_write(&session_token, b64outpu=
t, (int)strlen(b64output)));
+    ASSERT(buf_write(&session_token, b64outpu=
t, strlen(b64output)));
     ASSERT(buf_write_u8(&session_token, 0));
 
   =
  free(b64output);
@@ -296,10 +291,6 @@
     gc_free(&gc);
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 st=
atic bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, con=
st char *username)
 {
diff --git a/src/openvpn/base64=2Eh b/src/openvpn/bas=
e64=2Eh
index be7aa64=2E=2E800e569 100644
--- a/src/openvpn/base64=2Eh
+++ =
b/src/openvpn/base64=2Eh
@@ -35,7 +35,7 @@
 #define _BASE64_H_
 
 /** Compu=
te resulting base64 length=2E  6 bits per byte, padded to 4 bytes=2E */
-#d=
efine OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3)=
 & ~3)
+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length)=
 / 6) + 3) & ~3u)
 
 /** Compute the maximal number of bytes encoded in a b=
ase64 string=2E */
 #define OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((=
base64_length / 4) * 3)
diff --git a/src/openvpn/console_builtin=2Ec b/src/=
openvpn/console_builtin=2Ec
index dc71d12=2E=2E0353ade 100644
--- a/src/ope=
nvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -234,7 +2=
34,7 @@
     if (!echo && (tcgetattr(fileno(fp), &tty_tmp) =3D=3D 0))
     =
{
         tty_save =3D tty_tmp;
-        tty_tmp=2Ec_lflag &=3D ~(ECHO | E=
CHOE | ECHOK | ECHONL | ISIG);
+        tty_tmp=2Ec_lflag &=3D ~(unsigned i=
nt)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
         restore_tty =3D (tcseta=
ttr(fileno(fp), TCSAFLUSH, &tty_tmp) =3D=3D 0);
     }
 
diff --git a/src/o=
penvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 88c2c52=2E=2Effdf8c4 10064=
4
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -139,7 +139,=
7 @@
         ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }
 
-    dmsg=
(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80,=
 &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf=
), BLENZ(buf), 80, &gc));
 
     /* Buffer overflow check */
     if (!buf_=
safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
@@ -1=
51,7 +151,7 @@
 
     /* For AEAD ciphers, authenticate Additional Data, in=
cluding opcode */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work)=
, BLEN(&work)));
-    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(B=
PTR(&work), BLEN(&work), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT AD:=
 %s", format_hex(BPTR(&work), BLENZ(&work), 0, &gc));
 
     if (!use_epoch=
_data_format)
     {
@@ -170,8 +170,8 @@
 
     /* update number of plainte=
xt blocks encrypted=2E Use the (x + (n-1))/n trick
      * to round up the =
result to the number of blocks used */
-    const int blocksize =3D AEAD_LI=
MIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN=
(&work) + (blocksize - 1)) / blocksize;
+    const unsigned int blocksize =
=3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks=
 +=3D (BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     /* if the tag is=
 at end the end, allocate it now */
     if (use_epoch_data_format)
@@ -186=
,7 +186,7 @@
 
     *buf =3D work;
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT T=
O: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONT=
ENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     =
gc_free(&gc);
     return;
@@ -257,13 +257,13 @@
             ASSERT(buf_wr=
ite(&work, iv_buf, iv_size));
             dmsg(D_PACKET_CONTENT, "ENCRYPT =
IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
-            dmsg(D_PACKET=
_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+=
            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf)=
, BLENZ(buf), 80, &gc));
 
             /* cipher_ctx was already initializ=
ed with key & keylen */
             ASSERT(cipher_ctx_reset(ctx->cipher, i=
v_buf));
 
             /* Buffer overflow check */
-            if (!buf_s=
afe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            if =
(!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
       =
      {
                 msg(D_CRYPT_ERRORS,
                     "ENCRYPT:=
 buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%=
u",
@@ -317,7 +317,7 @@
 
         *buf =3D work;
 
-        dmsg(D_PACKET_=
CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
=
+        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), B=
LENZ(&work), 80, &gc));
     }
 
     gc_free(&gc);
@@ -460,7 +460,7 @@
   =
  ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
 
-    dmsg(D_PACKET_CONT=
ENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    d=
msg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf),=
 80, &gc));
 
     ASSERT(ad_start >=3D buf->data && ad_start <=3D BPTR(buf=
));
 
@@ -558,10 +558,10 @@
     }
 
     dmsg(D_PACKET_CONTENT, "DECRYPT M=
AC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-    dmsg(D_PACKET_CONTENT=
, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    dmsg(=
D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, =
&gc));
 
     /* Buffer overflow check (should never fail) */
-    if (!buf=
_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_=
safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
     {
      =
   CRYPT_ERROR("potential buffer overflow");
     }
@@ -585,7 +585,7 @@
   =
  }
     ASSERT(buf_inc_len(&work, outlen));
 
-    dmsg(D_PACKET_CONTENT, =
"DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+    dmsg=
(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), =
80, &gc));
 
     if (!crypto_check_replay(opt, &pin, epoch, error_prefix, =
&gc))
     {
@@ -594,8 +594,8 @@
 
     /* update number of plaintext block=
s decrypted=2E Use the (x + (n-1))/n trick
      * to round up the result t=
o the number of blocks used=2E */
-    const int blocksize =3D AEAD_LIMIT_B=
LOCKSIZE;
-    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&wor=
k) + (blocksize - 1)) / blocksize;
+    const unsigned int blocksize =3D AE=
AD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D =
(BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     *buf =3D work;
 
@@ -6=
31,7 +631,7 @@
         struct packet_id_net pin;
         bool have_pin =
=3D false;
 
-        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex=
(BPTR(buf), BLEN(buf), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "DECRYPT =
FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
         /* Verif=
y the HMAC */
         if (ctx->hmac)
@@ -694,7 +694,7 @@
             }
 
=
             /* Buffer overflow check (should never happen) */
-           =
 if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    =
        if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher=
)))
             {
                 CRYPT_ERROR("packet too big to decrypt"=
);
             }
@@ -713,7 +713,7 @@
             }
             ASSERT(bu=
f_inc_len(&work, outlen));
 
-            dmsg(D_PACKET_CONTENT, "DECRYPT T=
O: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+            dmsg(D=
_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80=
, &gc));
 
             /* Get packet ID from plaintext buffer or IV, depen=
ding on cipher mode */
             {
@@ -855,7 +855,7 @@
 crypto_max_overh=
ead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPE=
NVPN_MAX_CIPHER_BLOCK_SIZE
-           + max_int(OPENVPN_MAX_HMAC_SIZE, OPE=
NVPN_AEAD_TAG_LENGTH);
+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVP=
N_AEAD_TAG_LENGTH);
 }
 
 static void
@@ -1366,7 +1366,7 @@
         size_t=
 buf_size =3D strlen(file) + 1;
         ASSERT(buf_size <=3D INT_MAX);
   =
      size =3D (int)buf_size;
-        buf_set_read(&in, (const uint8_t *)f=
ile, size);
+        buf_set_read(&in, (const uint8_t *)file, buf_size);
  =
   }
     else /* 'file' is a filename which refers to a file containing th=
e ascii key */
     {
@@ -1535,7 +1535,7 @@
     struct buffer out =3D allo=
c_buf_gc(2048, &gc);
 
     /* how to format the ascii file representation =
of key */
-    const int bytes_per_line =3D 16;
+    const size_t bytes_per=
_line =3D 16;
 
     /* write header */
     buf_printf(&out, "#\n# %d bit =
OpenVPN static key\n#\n", nbits);
diff --git a/src/openvpn/crypto=2Eh b/src=
/openvpn/crypto=2Eh
index dbe0802=2E=2Efd632be 100644
--- a/src/openvpn/cry=
pto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -760,12 +760,12 @@
  * to read=2E
 =
 */
 static inline bool
-aead_usage_limit_reached(const uint64_t limit, con=
st struct key_ctx *key_ctx, int64_t higest_pid)
+aead_usage_limit_reached(c=
onst uint64_t limit, const struct key_ctx *key_ctx, uint64_t higest_pid)
 {=

     /* This is the  q + s <=3D  p^(1/2) * 2^(129/2) - 1 calculation where=

      * q is the number of protected messages (highest_pid)
      * s Tota=
l plaintext length in all messages (in blocks) */
-    return (limit > 0 &&=
 key_ctx->plaintext_blocks + (uint64_t)higest_pid > limit);
+    return (li=
mit > 0 && key_ctx->plaintext_blocks + higest_pid > limit);
 }
 
 #endif /*=
 CRYPTO_H */
diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto=
_epoch=2Ec
index 312cf6f=2E=2E243b5a2 100644
--- a/src/openvpn/crypto_epoch=
=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -98,7 +98,7 @@
     const uint8_=
t *label_prefix =3D (const uint8_t *)("ovpn ");
     uint8_t prefix_len =3D=
 5;
 
-    size_t hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + c=
ontext_len;
+    size_t hkdf_label_len =3D 2u + prefix_len + 1u + label_len=
 + 1u + context_len;
     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_la=
bel_len, &gc);
 
     buf_write_u16(&hkdf_label, (uint16_t)out_len);
diff -=
-git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 4809532=2E=2E1=
760c90 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ =
-2758,7 +2758,7 @@
             else
             {
                 int st=
atus;
-                int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN=
_ON_SIGNAL | GETADDR_FATAL;
+                unsigned int resolve_flags =3D=
 GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
 
              =
   if (!(flags & MF_CONNECT_AS_CLIENT))
                 {
@@ -4001,11 +400=
1,11 @@
         desc =3D "rsa-sign";
     }
 
-    buf_write(&buf_data, b6=
4_data, (int)strlen(b64_data));
+    buf_write(&buf_data, b64_data, strlen(=
b64_data));
     if (man->connection=2Eclient_version >=3D MCV_PKSIGN_ALG)
=
     {
-        buf_write(&buf_data, ",", (int)strlen(","));
-        buf_w=
rite(&buf_data, algorithm, (int)strlen(algorithm));
+        buf_write(&buf=
_data, ",", strlen(","));
+        buf_write(&buf_data, algorithm, strlen(a=
lgorithm));
     }
     char *ret =3D management_query_multiline_flatten(ma=
n, (char *)buf_bptr(&buf_data), prompt, desc,
                             =
                       &man->connection=2Eext_key_state,
diff --git a/src/o=
penvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index cbc3118=2E=2Ef4e=
142b 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=
=2Ec
@@ -1119,7 +1119,7 @@
         return 0;
     }
 
-    retval =3D endl=
ess_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
+    retval =3D endle=
ss_buf_write(&ks->bio_ctx->in, BPTR(buf), BLENZ(buf));
 
     if (retval < =
0)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
57?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8=
df01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-Patc=
hSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>

--wzgjbPqHBEs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Various trivial -Wsign-conversion fixes<br><br>* Continue BLEN -&gt;=
 BLENZ replacement<br>* Remove some unneeded casts<br>* Some trivial type f=
ixes<br><br>Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/o=
penvpn/acc=2Ec<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/base64=2Eh<=
br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/o=
penvpn/crypto=2Eh<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/manage=
=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>9 files changed, 34 insertions(+),=
 53 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/57/2157/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index e21891d=2E=2Eb8d7c3d =
100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span>+++ b/src/=
openvpn/acc=2Ec</span><br><span>@@ -148,11 +148,6 @@</span><br><span>     r=
eturn parse_acc_message_flags(flags, err_reason, gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversio=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span>=
<br><span> receive_acc_message(struct context *c, const struct buffer *buff=
er)</span><br><span> {</span><br><span>@@ -236,15 +231,10 @@</span><br><spa=
n>     msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app cont=
rol channel &quot;</span><br><span>                        &quot;message (%=
s): %s&quot;,</span><br><span>         err_reason,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        format_hex(CBPTR(buffer), BLEN(buffer)=
, 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     format_hex(CBPTR(buffer), BLENZ(buffer), 80, &amp;gc));</span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> sen=
d_acc_message(struct context *c,</span><br><span>                  struct t=
ls_multi *multi,</span><br><span>diff --git a/src/openvpn/auth_token=2Ec b/=
src/openvpn/auth_token=2Ec</span><br><span>index 211af90=2E=2Eb69092c 10064=
4</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/sr=
c/openvpn/auth_token=2Ec</span><br><span>@@ -36,11 +36,6 @@</span><br><span=
>  * padding */</span><br><span> static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0,=
 &quot;TOKEN_DATA_LEN is not a multiple of 3&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> is_auth_t=
oken(const char *password)</span><br><span> {</span><br><span>@@ -67,7 +62,=
7 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int auth_token=
_state_flags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_state_flags;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int auth_to=
ken_state_flags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_state_flags;</=
span><br><span> </span><br><span>     const char *state;</span><br><span> <=
/span><br><span>@@ -188,7 +183,7 @@</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int64_t timestamp =3D htonll((uint64_t)=
now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t ti=
mestamp =3D (int64_t)htonll((uint64_t)now);</span><br><span>     int64_t in=
itial_timestamp =3D timestamp;</span><br><span> </span><br><span>     hmac_=
ctx_t *ctx =3D multi-&gt;opt=2Eauth_token_key=2Ehmac;</span><br><span>@@ -2=
73,7 +268,7 @@</span><br><span>         alloc_buf_gc(strlen(SESSION_ID_PREF=
IX) + strlen(b64output) + 1, &amp;gc);</span><br><span> </span><br><span>  =
   ASSERT(buf_write(&amp;session_token, SESSION_ID_PREFIX, strlen(SESSION_I=
D_PREFIX)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(buf_write(&amp;session_token, b64output, (int)strlen(b64output)));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_write(&amp;=
session_token, b64output, strlen(b64output)));</span><br><span>     ASSERT(=
buf_write_u8(&amp;session_token, 0));</span><br><span> </span><br><span>   =
  free(b64output);</span><br><span>@@ -296,10 +291,6 @@</span><br><span>   =
  gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static boo=
l</span><br><span> check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64deco=
ded, const char *username)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/base64=2Eh b/src/openvpn/base64=2Eh</span><br><span>index be7aa=
64=2E=2E800e569 100644</span><br><span>--- a/src/openvpn/base64=2Eh</span><=
br><span>+++ b/src/openvpn/base64=2Eh</span><br><span>@@ -35,7 +35,7 @@</sp=
an><br><span> #define _BASE64_H_</span><br><span> </span><br><span> /** Com=
pute resulting base64 length=2E  6 bits per byte, padded to 4 bytes=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_BASE64_=
LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) &amp; ~3)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_BASE64_LENGTH(=
binary_length) ((((8 * binary_length) / 6) + 3) &amp; ~3u)</span><br><span>=
 </span><br><span> /** Compute the maximal number of bytes encoded in a bas=
e64 string=2E */</span><br><span> #define OPENVPN_BASE64_DECODED_LENGTH(bas=
e64_length) ((base64_length / 4) * 3)</span><br><span>diff --git a/src/open=
vpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>i=
ndex dc71d12=2E=2E0353ade 100644</span><br><span>--- a/src/openvpn/console_=
builtin=2Ec</span><br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br=
><span>@@ -234,7 +234,7 @@</span><br><span>     if (!echo &amp;&amp; (tcget=
attr(fileno(fp), &amp;tty_tmp) =3D=3D 0))</span><br><span>     {</span><br>=
<span>         tty_save =3D tty_tmp;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        tty_tmp=2Ec_lflag &amp;=3D ~(ECHO | ECHOE | ECHOK | =
ECHONL | ISIG);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tty_tmp=2Ec_lflag &amp;=3D ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHON=
L | ISIG);</span><br><span>         restore_tty =3D (tcsetattr(fileno(fp), =
TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</span><br><span>     }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec</span><br><span>index 88c2c52=2E=2Effdf8c4 100644</span><br><span>--- =
a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span=
><br><span>@@ -139,7 +139,7 @@</span><br><span>         ASSERT(cipher_ctx_r=
eset(ctx-&gt;cipher, iv));</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &q=
uot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_C=
ONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80,=
 &amp;gc));</span><br><span> </span><br><span>     /* Buffer overflow check=
 */</span><br><span>     if (!buf_safe(&amp;work, buf-&gt;len + mac_len + c=
ipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>@@ -151,7 +151,7 @@<=
/span><br><span> </span><br><span>     /* For AEAD ciphers, authenticate Ad=
ditional Data, including opcode */</span><br><span>     ASSERT(cipher_ctx_u=
pdate_ad(ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work)));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENC=
RYPT AD: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET=
_CONTENT, &quot;ENCRYPT AD: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&am=
p;work), 0, &amp;gc));</span><br><span> </span><br><span>     if (!use_epoc=
h_data_format)</span><br><span>     {</span><br><span>@@ -170,8 +170,8 @@</=
span><br><span> </span><br><span>     /* update number of plaintext blocks =
encrypted=2E Use the (x + (n-1))/n trick</span><br><span>      * to round u=
p the result to the number of blocks used */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;key_ctx_bi=
=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1)) / bl=
ocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
nsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi=2Eencrypt=2Eplaintext_bl=
ocks +=3D (BLENZ(&amp;work) + (blocksize - 1)) / blocksize;</span><br><span=
> </span><br><span>     /* if the tag is at end the end, allocate it now */=
</span><br><span>     if (use_epoch_data_format)</span><br><span>@@ -186,7 =
+186,7 @@</span><br><span> </span><br><span>     *buf =3D work;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACK=
ET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dms=
g(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(buf), BLENZ=
(buf), 80, &amp;gc));</span><br><span> </span><br><span>     gc_free(&amp;g=
c);</span><br><span>     return;</span><br><span>@@ -257,13 +257,13 @@</spa=
n><br><span>             ASSERT(buf_write(&amp;work, iv_buf, iv_size));</sp=
an><br><span>             dmsg(D_PACKET_CONTENT, &quot;ENCRYPT IV: %s&quot;=
, format_hex(iv_buf, iv_size, 0, &amp;gc));</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, =
&quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dmsg(=
D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ=
(buf), 80, &amp;gc));</span><br><span> </span><br><span>             /* cip=
her_ctx was already initialized with key &amp; keylen */</span><br><span>  =
           ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv_buf));</span><br><spa=
n> </span><br><span>             /* Buffer overflow check */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_safe(&amp;work,=
 buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (!buf_safe(&amp;work, BLE=
NZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>         =
    {</span><br><span>                 msg(D_CRYPT_ERRORS,</span><br><span>=
                     &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=
=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,</span><br><span>@@ -317,7 +31=
7,7 @@</span><br><span> </span><br><span>         *buf =3D work;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D=
_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BL=
EN(&amp;work), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format=
_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><span>    =
 }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span=
>@@ -460,7 +460,7 @@</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</span=
><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYP=
T FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &q=
uot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc))=
;</span><br><span> </span><br><span>     ASSERT(ad_start &gt;=3D buf-&gt;da=
ta &amp;&amp; ad_start &lt;=3D BPTR(buf));</span><br><span> </span><br><spa=
n>@@ -558,10 +558,10 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(t=
ag_ptr, tag_size, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_h=
ex(BPTR(buf), BLEN(buf), 0, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;,=
 format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));</span><br><span> </span><b=
r><span>     /* Buffer overflow check (should never fail) */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt=
;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!buf_safe(&amp;work, BLENZ(buf) + cipher=
_ctx_block_size(ctx-&gt;cipher)))</span><br><span>     {</span><br><span>  =
       CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><br><span>=
     }</span><br><span>@@ -585,7 +585,7 @@</span><br><span>     }</span><br=
><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, =
&quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 80=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dms=
g(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work),=
 BLENZ(&amp;work), 80, &amp;gc));</span><br><span> </span><br><span>     if=
 (!crypto_check_replay(opt, &amp;pin, epoch, error_prefix, &amp;gc))</span>=
<br><span>     {</span><br><span>@@ -594,8 +594,8 @@</span><br><span> </spa=
n><br><span>     /* update number of plaintext blocks decrypted=2E Use the =
(x + (n-1))/n trick</span><br><span>      * to round up the result to the n=
umber of blocks used=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;key_ctx_bi=2Edecrypt=2Eplainte=
xt_blocks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocksize;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int blocksiz=
e =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    opt-&gt;key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLENZ(&am=
p;work) + (blocksize - 1)) / blocksize;</span><br><span> </span><br><span> =
    *buf =3D work;</span><br><span> </span><br><span>@@ -631,7 +631,7 @@</s=
pan><br><span>         struct packet_id_net pin;</span><br><span>         b=
ool have_pin =3D false;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&q=
uot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PACKET_CONTENT, &quot;DECR=
YPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span>=
<br><span> </span><br><span>         /* Verify the HMAC */</span><br><span>=
         if (ctx-&gt;hmac)</span><br><span>@@ -694,7 +694,7 @@</span><br><s=
pan>             }</span><br><span> </span><br><span>             /* Buffer=
 overflow check (should never happen) */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (!buf_safe(&amp;work, buf-&gt;len + ciphe=
r_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx=
_block_size(ctx-&gt;cipher)))</span><br><span>             {</span><br><spa=
n>                 CRYPT_ERROR(&quot;packet too big to decrypt&quot;);</spa=
n><br><span>             }</span><br><span>@@ -713,7 +713,7 @@</span><br><s=
pan>             }</span><br><span>             ASSERT(buf_inc_len(&amp;wor=
k, outlen));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, for=
mat_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_PACKET_CONTENT, &qu=
ot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, =
&amp;gc));</span><br><span> </span><br><span>             /* Get packet ID =
from plaintext buffer or IV, depending on cipher mode */</span><br><span>  =
           {</span><br><span>@@ -855,7 +855,7 @@</span><br><span> crypto_ma=
x_overhead(void)</span><br><span> {</span><br><span>     return packet_id_s=
ize(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-           + max_int(OPENVPN_MA=
X_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEA=
D_TAG_LENGTH);</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span>@@ -1366,7 +1366,7 @@</span><br><span>         size_t=
 buf_size =3D strlen(file) + 1;</span><br><span>         ASSERT(buf_size &l=
t;=3D INT_MAX);</span><br><span>         size =3D (int)buf_size;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        buf_set_read(&amp;in, (c=
onst uint8_t *)file, size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        buf_set_read(&amp;in, (const uint8_t *)file, buf_size);</sp=
an><br><span>     }</span><br><span>     else /* &#39;file&#39; is a filena=
me which refers to a file containing the ascii key */</span><br><span>     =
{</span><br><span>@@ -1535,7 +1535,7 @@</span><br><span>     struct buffer =
out =3D alloc_buf_gc(2048, &amp;gc);</span><br><span> </span><br><span>    =
 /* how to format the ascii file representation of key */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int bytes_per_line =3D 16;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t bytes=
_per_line =3D 16;</span><br><span> </span><br><span>     /* write header */=
</span><br><span>     buf_printf(&amp;out, &quot;#\n# %d bit OpenVPN static=
 key\n#\n&quot;, nbits);</span><br><span>diff --git a/src/openvpn/crypto=2E=
h b/src/openvpn/crypto=2Eh</span><br><span>index dbe0802=2E=2Efd632be 10064=
4</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/op=
envpn/crypto=2Eh</span><br><span>@@ -760,12 +760,12 @@</span><br><span>  * =
to read=2E</span><br><span>  */</span><br><span> static inline bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-aead_usage_limit_reached(cons=
t uint64_t limit, const struct key_ctx *key_ctx, int64_t higest_pid)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+aead_usage_limit_reached(c=
onst uint64_t limit, const struct key_ctx *key_ctx, uint64_t higest_pid)</s=
pan><br><span> {</span><br><span>     /* This is the  q + s &lt;=3D  p^(1/2=
) * 2^(129/2) - 1 calculation where</span><br><span>      * q is the number=
 of protected messages (highest_pid)</span><br><span>      * s Total plaint=
ext length in all messages (in blocks) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return (limit &gt; 0 &amp;&amp; key_ctx-&gt;plainte=
xt_blocks + (uint64_t)higest_pid &gt; limit);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (limit &gt; 0 &amp;&amp; key_ctx-&gt;p=
laintext_blocks + higest_pid &gt; limit);</span><br><span> }</span><br><spa=
n> </span><br><span> #endif /* CRYPTO_H */</span><br><span>diff --git a/src=
/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>in=
dex 312cf6f=2E=2E243b5a2 100644</span><br><span>--- a/src/openvpn/crypto_ep=
och=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>=
@@ -98,7 +98,7 @@</span><br><span>     const uint8_t *label_prefix =3D (con=
st uint8_t *)(&quot;ovpn &quot;);</span><br><span>     uint8_t prefix_len =
=3D 5;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    size_t hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + conte=
xt_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t h=
kdf_label_len =3D 2u + prefix_len + 1u + label_len + 1u + context_len;</spa=
n><br><span>     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, =
&amp;gc);</span><br><span> </span><br><span>     buf_write_u16(&amp;hkdf_la=
bel, (uint16_t)out_len);</span><br><span>diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec</span><br><span>index 4809532=2E=2E1760c90 10064=
4</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/op=
envpn/manage=2Ec</span><br><span>@@ -2758,7 +2758,7 @@</span><br><span>    =
         else</span><br><span>             {</span><br><span>              =
   int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | G=
ETADDR_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          unsigned int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_=
SIGNAL | GETADDR_FATAL;</span><br><span> </span><br><span>                 =
if (!(flags &amp; MF_CONNECT_AS_CLIENT))</span><br><span>                 {=
</span><br><span>@@ -4001,11 +4001,11 @@</span><br><span>         desc =3D =
&quot;rsa-sign&quot;;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf_data, b64_d=
ata, (int)strlen(b64_data));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_write(&amp;buf_data, b64_data, strlen(b64_data));</span><b=
r><span>     if (man-&gt;connection=2Eclient_version &gt;=3D MCV_PKSIGN_ALG=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        buf_write(&amp;buf_data, &quot;,&quot;, (int)strlen(&quot;,&quot=
;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write=
(&amp;buf_data, algorithm, (int)strlen(algorithm));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;buf_data, &quot;,&=
quot;, strlen(&quot;,&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_write(&amp;buf_data, algorithm, strlen(algorithm));<=
/span><br><span>     }</span><br><span>     char *ret =3D management_query_=
multiline_flatten(man, (char *)buf_bptr(&amp;buf_data), prompt, desc,</span=
><br><span>                                                    &amp;man-&gt=
;connection=2Eext_key_state,</span><br><span>diff --git a/src/openvpn/ssl_m=
bedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index cbc3118=2E=
=2Ef4e142b 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1119,7 +1119=
,7 @@</span><br><span>         return 0;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D =
endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf), buf-&gt;len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    retval =3D endless_b=
uf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf), BLENZ(buf));</span><br><spa=
n> </span><br><span>     if (retval &lt; 0)</span><br><span>     {</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2157?usp=3Demail">change 2157</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f5=
1e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2157 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--wzgjbPqHBEs=--


--===============5395887847486621681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5395887847486621681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5395887847486621681==--

