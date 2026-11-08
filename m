Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F15606A321
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nKI7atfb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HrPqCKjO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MtKHlLnJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TU3mVJvY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=7CAu4QN3dfQFqLlyXA5n8DYNS2xugVmgRMwXGTSgSw4=; b=nKI7atfb2fv3Zqz/sFDsMa3L8z
	r5EEPjWIkMGnEZ7Q/1DsA7hqMBGRuhlJg01YHHxBJMjL9rDmiqsg62XPYcY1qviGZjV0aijd44tDv
	2SxC3d1ujdR2z0IeanuaNlQs0/s26C+JmbuYaZgm4eXIVcq9fkQM/Fu52M1kqYefd1RI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ1Xx-000000007Wt-3Baq;
	Sun, 08 Nov 2026 11:58:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ1Xw-000000007Wn-2zPv
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 11:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rAtIWbMDXqcL3Kg7YRX7ddWHq01eggyaeWUJVnCTx1U=; b=HrPqCKjOeBNUUc0mLaOTzVlo5g
 z3m4+9gbN4aYKpqAB4f6tXn0cXIQUVUJM3KGRPOXT9AQh/eJU46+/Bt3Wt1QGktYy7G9ONydgJXnO
 H7k50YseqqNJ7pAF/RQ1CNbNjRtpJdRSlSvkO9gnTSdteCtS/kU0dWV9WDU4LefCWVLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rAtIWbMDXqcL3Kg7YRX7ddWHq01eggyaeWUJVnCTx1U=; b=MtKHlLnJ5CPcGA9LgAPYTWZrml
 U06+Ik9+Or30qHDaoBeaz/7hC6TPmuOyEsZ3u4RSmnqx0mnuzfkBNz5B8NS9JTSznxf8LyA5cXqx5
 kZFx3V64P2wGKV3M/zf/ZFUE1OWcx+qdzyMsMDT+0GDuEUR8qmWIQZJARIEkcA3VWmXQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ1Xv-000000005aK-0f7E for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 11:58:52 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so47445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794139124; x=1794743924; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rAtIWbMDXqcL3Kg7YRX7ddWHq01eggyaeWUJVnCTx1U=;
 b=TU3mVJvYalx1fxnUzaKVDIXF2COu8MOxx8FJN2nViChETh9pRCw76kfqumtLptaFJf
 bSv+xyddtZe0/2L2cWhI6CMbvNd1nCSqmEtCX+fZB5wPTSVJCI5Bab8Fy6ZWTYzmWQDq
 XtbPzBtVXAjDooXlhMIorM53Gc2NhoaZd2RiMkktYWLmTLVoX2dhbIAYVNHSaPm8N7zU
 M1od5t7J3od3YGxtREuqZx1njGwjSYIOV4CTmm4y9DJeJbJsXEz3HTLpvXFjRM+f3aMO
 8XiFObHYVlXv4PhXoCPjFPYSq/CKYBmnbYRYMt06jyigPX/32e/XKxF46PBO00wPlBqO
 77GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794139124; x=1794743924;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rAtIWbMDXqcL3Kg7YRX7ddWHq01eggyaeWUJVnCTx1U=;
 b=nELu6y3KSU+XmFQVmNQTwab77fkW0dNdB0H/SjGC2PG90Us8/3YNdPo0yM3OAhwalD
 oMrF9mhZ/ApuXfWaFkbHQI1Gf5k5oWSzofAXBdlj+2X28gYR3IhXs+0jmiyLPIKQ/bUE
 0TP0SWErtH3jP5ze7EdhjmoPF6QK3ZVPJbpBhpoDWIFhLE7X0/t7Mkiv6lTaUnlRQIf1
 3rTEPZzYWoATMFMHuEjwuNMIaRANfmHFclRPZO6PlYan2FlVCKIUnVfEoXWLvU2aeaOF
 XMAyuhOud6+5Bno+5oQIZxmTMtnewGa+7yOUKEJLm7PPIyxydRnjXTQ+Eza9Pgp7nWT5
 lXyw==
X-Gm-Message-State: APuU4Z92T59LwTYitiqaOBMIlFo5BqTpyuQbrFveUuP+lDNWC2JAcpzx
 1TuRPGSCYET3ew2gVU99rBJKd23oAyJOVw75xhH205hw8xd9577k5ft4+WU7nARh+7MBkh3Lq5V
 sqPyZglB/Axqd4UITFdZIgkgDPLeZWqkI0qVG2IVDfc6AitifBbtXMcj5d6YlmM8jkR56WQU7CU
 2QOVls0Q==
X-Gm-Gg: AYBFou24II6potB2hEDTmtNRJL+lF9YpyqwDIrDRfeC8/Tm3v2DXL8r9XXFw2Ks+kio
 +GzGPPMiFBmYaBkccOcCVCUTV/RVjCpSRHMmDLPtiylLT+hRiaEtWNNUfPCMOraSlKvZEGdDWmP
 oaIJsBMyKoy2UTADD0YYxwj1AtplfzWeTVicz9thR1QgQmFrUzbtZOhXCtDvrWlmIO4JHl0eHXU
 vhTeaKbADVRZbcPZvTEgHs3C2jUQiiXmMfA72HGn0r1aOkt76UfVDhh9WzaGsOBJQKmZK34Txoh
 o1FoURB1DQ/+Uo9/aRUDiZLtEymSHFxhAlNW2oYiivg8nM9ftI6wGh9QhNb1Xn+/J8EcriTdfpB
 FTFYW4Sn4ldWGmCvImY7wjtlbNQL/0PnmbWvOKdt8LSIjPLMaFmh0z1uS1lcZmYGsp/bhmpFFKo
 sBYXFAPELX7fdaLb1AR5eq6xqqyC4aeBDwmvu0JtDKgP5mXY0SjdEIAXjkM5GPjKxFUbPdcvwQk
 yutZ6yF0LTpvVshE0VOOrahBH1dByVcWmDOsTwuJVZeCfj4jCqooLTIxkmikxK2X78axKDjSFxh
 wCCB+bflTxPJiPHKlwiMNHHNl2hF265QBDQLiToF3E1MLHYfUvtEIqJchQpg4YiMy8374j1pd1p
 iZNq4Pye7nTJ5eNQk5RZ7vNdg/WXt4Ea+WR7C/cWG1LmqmBOSEJwOhVML4d/lnBE4FOvZAZJnLA
 6dhm7AIQbnBrgUow==
X-Received: by 2002:a05:600c:8b21:b0:4a2:150f:1613 with SMTP id
 5b1f17b1804b1-4b960d9aff8mr23951065e9.7.1794139124307; 
 Sun, 08 Nov 2026 03:58:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b96cd012e1sm44517935e9.8.2026.11.08.03.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 03:58:44 -0800 (PST)
X-Google-Original-From: "Alexandre Laroche (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 11:58:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 3eba815527c82563ce47b123e60207b0a2b9aeef
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94fc681296ec5c2d386088aa16c65954adea1bc2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ1Xv-000000005aK-0f7E
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
From: "Alexandre Laroche \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Alexandre Laroche \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8657368628759256429=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8657368628759256429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fBd15bNZIpE="; charset=UTF-8

--fBd15bNZIpE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2155?usp=3Demail

to review the following change=2E
=


Change subject: Check the result of unchecked allocations in the server
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check the res=
ult of unchecked allocations in the server

Several allocations were used w=
ithout a NULL check, so a failed
allocation crashed the server on a NULL po=
inter instead of stopping
with "Out of Memory" like the rest of the code:

=
- multi_init(): calloc() of m->instances; the server started and then
  cra=
shed in multi_assign_peer_id() on the first client
- generate_auth_token(),=
 verify_user_pass(): strdup() of auth tokens;
  generate_auth_token() then =
called strdup(NULL)
- override_locked_username(): strdup() of the override =
username; the
  strlcpy() from locked_username then crashed (with --auth-ge=
n-token)
- backend_x509_get_serial_hex(): malloc() of the serial buffer, wh=
ich
  BN_bn2binpad() then wrote to

Use string_alloc(=2E=2E=2E, NULL) inste=
ad of strdup(), and add
check_malloc_return() after the calloc() and malloc=
()=2E

GitHub: closes OpenVPN/openvpn#1142

Assisted-by: Claude Code:claude=
-opus-5-5
Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Signed-off-b=
y: Alexandre Laroche <larochealexandre@hotmail=2Ecom>
---
A src/openvpn/=2E=
dirstamp
M src/openvpn/auth_token=2Ec
M src/openvpn/multi=2Ec
M src/openvpn=
/ssl_verify=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
5 files changed, 7 ins=
ertions(+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/55/2155/1

diff --git a/src/openvpn/=2Edirstamp b/src=
/openvpn/=2Edirstamp
new file mode 100644
index 0000000=2E=2Ee69de29
--- /d=
ev/null
+++ b/src/openvpn/=2Edirstamp
diff --git a/src/openvpn/auth_token=
=2Ec b/src/openvpn/auth_token=2Ec
index 84558af=2E=2E10c656e 100644
--- a/s=
rc/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -275,7 +275,7=
 @@
 
     /* free the auth-token if defined, we will replace it with a new=
 one */
     free(multi->auth_token);
-    multi->auth_token =3D strdup((ch=
ar *)BPTR(&session_token));
+    multi->auth_token =3D string_alloc((char *=
)BPTR(&session_token), NULL);
 
     dmsg(D_SHOW_KEYS, "Generated token for=
 client: %s (%s)", multi->auth_token, up->username);
 
@@ -285,7 +285,7 @@
=
          * Save the initial auth token to continue using the same session =
ID
          * and timestamp in updates
          */
-        multi->auth_t=
oken_initial =3D strdup(multi->auth_token);
+        multi->auth_token_init=
ial =3D string_alloc(multi->auth_token, NULL);
     }
 
     gc_free(&gc);
=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3f514d6=2E=
=2E662fc9d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -395,6 +395,7 @@
     m->max_clients =3D t->options=2Emax_clients;
 
    =
 m->instances =3D calloc(m->max_clients, sizeof(struct multi_instance *));
=
+    check_malloc_return(m->instances);
 
     m->top=2Ec2=2Eevent_set =3D =
t->c2=2Eevent_set;
 
@@ -2653,7 +2654,7 @@
         }
 
         multi->loc=
ked_original_username =3D multi->locked_username;
-        multi->locked_us=
ername =3D strdup(options->override_username);
+        multi->locked_usern=
ame =3D string_alloc(options->override_username, NULL);
 
         /* Overr=
ide also the common name if username should be set as common
          * na=
me */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
=
index 0cdec1e=2E=2E9b3f86d 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/sr=
c/openvpn/ssl_verify=2Ec
@@ -1658,7 +1658,7 @@
          * using the same s=
ession ID and initial timestamp in new tokens */
         if (!multi->auth_=
token_initial && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK))
       =
  {
-            multi->auth_token_initial =3D strdup(up->password);
+     =
       multi->auth_token_initial =3D string_alloc(up->password, NULL);
    =
     }
 
         if (session->opt->auth_token_call_auth)
@@ -1777,7 +1777,=
7 @@
             if (!multi->auth_token && (ks->auth_token_state_flags & A=
UTH_TOKEN_HMAC_OK)
                 && !(ks->auth_token_state_flags & AUTH_=
TOKEN_EXPIRED))
             {
-                multi->auth_token =3D strdu=
p(up->password);
+                multi->auth_token =3D string_alloc(up->pa=
ssword, NULL);
             }
 
             /*
diff --git a/src/openvpn/ss=
l_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index 0c36cf2=2E=
=2E3f9f702 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvp=
n/ssl_verify_openssl=2Ec
@@ -324,6 +324,7 @@
     BIGNUM *bn_serial =3D ASN=
1_INTEGER_to_BN(asn1_i, NULL);
     int len_serial =3D BN_num_bytes(bn_seri=
al);
     unsigned char *buf =3D malloc(len_serial);
+    check_malloc_retu=
rn(buf);
     BN_bn2binpad(bn_serial, buf, len_serial);
 
     char *ret =
=3D format_hex_ex(buf, len_serial, 0, 1, ":", gc);

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429=

Gerrit-Change-Number: 2155
Gerrit-PatchSet: 1
Gerrit-Owner: Alexandre Laro=
che
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--fBd15bNZIpE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Alexandre Laroche would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Check the result of unchecked allocations in the server<br=
><br>Several allocations were used without a NULL check, so a failed<br>all=
ocation crashed the server on a NULL pointer instead of stopping<br>with &q=
uot;Out of Memory&quot; like the rest of the code:<br><br>- multi_init(): c=
alloc() of m-&gt;instances; the server started and then<br>  crashed in mul=
ti_assign_peer_id() on the first client<br>- generate_auth_token(), verify_=
user_pass(): strdup() of auth tokens;<br>  generate_auth_token() then calle=
d strdup(NULL)<br>- override_locked_username(): strdup() of the override us=
ername; the<br>  strlcpy() from locked_username then crashed (with --auth-g=
en-token)<br>- backend_x509_get_serial_hex(): malloc() of the serial buffer=
, which<br>  BN_bn2binpad() then wrote to<br><br>Use string_alloc(=2E=2E=2E=
, NULL) instead of strdup(), and add<br>check_malloc_return() after the cal=
loc() and malloc()=2E<br><br>GitHub: closes OpenVPN/openvpn#1142<br><br>Ass=
isted-by: Claude Code:claude-opus-5-5<br>Change-Id: I603321ae6893dbdb054dea=
e5a9bff5e52cbb7429<br>Signed-off-by: Alexandre Laroche &lt;larochealexandre=
@hotmail=2Ecom&gt;<br>---<br>A src/openvpn/=2Edirstamp<br>M src/openvpn/aut=
h_token=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M=
 src/openvpn/ssl_verify_openssl=2Ec<br>5 files changed, 7 insertions(+), 5 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/55/2155/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
=2Edirstamp b/src/openvpn/=2Edirstamp</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Ee69de29</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/src/openvpn/=2Edirstamp</span><br><span>diff --git a/sr=
c/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index=
 84558af=2E=2E10c656e 100644</span><br><span>--- a/src/openvpn/auth_token=
=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -2=
75,7 +275,7 @@</span><br><span> </span><br><span>     /* free the auth-toke=
n if defined, we will replace it with a new one */</span><br><span>     fre=
e(multi-&gt;auth_token);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    multi-&gt;auth_token =3D strdup((char *)BPTR(&amp;session_token));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;auth_to=
ken =3D string_alloc((char *)BPTR(&amp;session_token), NULL);</span><br><sp=
an> </span><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated token for clien=
t: %s (%s)&quot;, multi-&gt;auth_token, up-&gt;username);</span><br><span> =
</span><br><span>@@ -285,7 +285,7 @@</span><br><span>          * Save the i=
nitial auth token to continue using the same session ID</span><br><span>   =
       * and timestamp in updates</span><br><span>          */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;auth_token_initi=
al =3D strdup(multi-&gt;auth_token);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        multi-&gt;auth_token_initial =3D string_alloc(mult=
i-&gt;auth_token, NULL);</span><br><span>     }</span><br><span> </span><br=
><span>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/mult=
i=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E662fc9d 10=
0644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/=
openvpn/multi=2Ec</span><br><span>@@ -395,6 +395,7 @@</span><br><span>     =
m-&gt;max_clients =3D t-&gt;options=2Emax_clients;</span><br><span> </span>=
<br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(struct =
multi_instance *));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    check_malloc_return(m-&gt;instances);</span><br><span> </span><br><span=
>     m-&gt;top=2Ec2=2Eevent_set =3D t-&gt;c2=2Eevent_set;</span><br><span>=
 </span><br><span>@@ -2653,7 +2654,7 @@</span><br><span>         }</span><b=
r><span> </span><br><span>         multi-&gt;locked_original_username =3D m=
ulti-&gt;locked_username;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        multi-&gt;locked_username =3D strdup(options-&gt;override_usern=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-=
&gt;locked_username =3D string_alloc(options-&gt;override_username, NULL);<=
/span><br><span> </span><br><span>         /* Override also the common name=
 if username should be set as common</span><br><span>          * name */</s=
pan><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_ver=
ify=2Ec</span><br><span>index 0cdec1e=2E=2E9b3f86d 100644</span><br><span>-=
-- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verif=
y=2Ec</span><br><span>@@ -1658,7 +1658,7 @@</span><br><span>          * usi=
ng the same session ID and initial timestamp in new tokens */</span><br><sp=
an>         if (!multi-&gt;auth_token_initial &amp;&amp; (ks-&gt;auth_token=
_state_flags &amp; AUTH_TOKEN_HMAC_OK))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            multi-&gt;auth_tok=
en_initial =3D strdup(up-&gt;password);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi-&gt;auth_token_initial =3D string_all=
oc(up-&gt;password, NULL);</span><br><span>         }</span><br><span> </sp=
an><br><span>         if (session-&gt;opt-&gt;auth_token_call_auth)</span><=
br><span>@@ -1777,7 +1777,7 @@</span><br><span>             if (!multi-&gt;=
auth_token &amp;&amp; (ks-&gt;auth_token_state_flags &amp; AUTH_TOKEN_HMAC_=
OK)</span><br><span>                 &amp;&amp; !(ks-&gt;auth_token_state_f=
lags &amp; AUTH_TOKEN_EXPIRED))</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;auth_tok=
en =3D strdup(up-&gt;password);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                multi-&gt;auth_token =3D string_alloc(up-&gt;pa=
ssword, NULL);</span><br><span>             }</span><br><span> </span><br><=
span>             /*</span><br><span>diff --git a/src/openvpn/ssl_verify_op=
enssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 0c36cf=
2=2E=2E3f9f702 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><sp=
an>@@ -324,6 +324,7 @@</span><br><span>     BIGNUM *bn_serial =3D ASN1_INTE=
GER_to_BN(asn1_i, NULL);</span><br><span>     int len_serial =3D BN_num_byt=
es(bn_serial);</span><br><span>     unsigned char *buf =3D malloc(len_seria=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_malloc=
_return(buf);</span><br><span>     BN_bn2binpad(bn_serial, buf, len_serial)=
;</span><br><span> </span><br><span>     char *ret =3D format_hex_ex(buf, l=
en_serial, 0, 1, &quot;:&quot;, gc);</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail">change =
2155</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Alexandre =
Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--fBd15bNZIpE=--


--===============8657368628759256429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8657368628759256429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8657368628759256429==--

