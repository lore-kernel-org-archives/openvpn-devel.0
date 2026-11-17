Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AB606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d/CKqne/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NfZOXqCs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JQxJMsAC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IIMM4yDM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=+hd0zd2noEv+LfIYgcHlg5SrJVkfax5B8qZ8chaPCqA=; b=d/CKqne/hXriioHRRHhz03YFAF
	wPxrUHIA+iBYoUv1MdV5RDBtAHJDyIedJB7VoMUXcsuhxrCmZa+5EEsTgL35/8OK87DgFQ/YcseAH
	FyvMM4MjbQ6fPBCmukZP4Udqms60EiqJcXE1Xusok8fdr2VZiJHFkPjONghqRMfJYeno=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTERR-000000004E7-1sRf;
	Tue, 17 Nov 2026 08:21:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTERP-000000004Dn-0Lne
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YUCUd1Svitu5bTPElYWRxUo7iEnr5l5otxejNDd2Xpw=; b=NfZOXqCsYw6ZjDbeGQsxz8+kVn
 vZXtRc8vgJAasodO13Bg0f9+Wd9V+EmSal8kxgO5TEZGjMdCvYN3+BJGSZoKODIPwIBLvWMTlg2dL
 4JYOKBdnDmy8A/HDYrdppCNS0DrKj/vs8oJY/JCXVoBpRuzmiIKhXJMvYzZJ7HGJVYws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YUCUd1Svitu5bTPElYWRxUo7iEnr5l5otxejNDd2Xpw=; b=JQxJMsACieRVozDhdSc6KBbR0P
 fZFCgHaXaNxJuVUbJOkPZYKXCzhA3SytPF+hrBEChG0+8G2efNw4SINms0we+Zy7gAAVXat3PXCH+
 Fqq/qa3C79lWd6x82J10JWv84WHzuaa5GP3YCDlTRk3OAxxcura9JcMr1g1AdQnsdIWI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTERN-0000000011F-1n1k for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:21:23 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so51880045e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794903675; x=1795508475; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YUCUd1Svitu5bTPElYWRxUo7iEnr5l5otxejNDd2Xpw=;
 b=IIMM4yDMBfIF/N8ScG5/Up0AkEV4xuatASUbU+Xw2keZWtF70xEioBZOWHMIKHNAaD
 qZXKaySQdmpMPkHKFgusfpyTWyZViLLMrYDKMi41utJBmiKhSir6N2tWhr0dBGWuom3t
 t+ES/GRvpZCkrWo6l/jgJ4c+If9RKZueSNYNG2PNtZ/JrDpAkH4QcU+3SUQtxOCrPiky
 hfjpYnDE1y3RjUp4fQjjvf6pCcB+1u6O+OL6hN+LfE0Yobt2ocHqxZILwdKet94X8WvQ
 CyICglq39pWg0JyEeyqg07YOcphCgcTpADtK3pAUHiogs/1qfqUBrSpW3nGYMGT45f29
 U7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794903675; x=1795508475;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUCUd1Svitu5bTPElYWRxUo7iEnr5l5otxejNDd2Xpw=;
 b=TvMm+V3+jXnuMkcZKQ24XgbeWivpUt0r6xKItARcdx9ywjph9W2c2vlOxvxSqA2PoU
 wl6jQ8j3+moDN81bMLpcxmTYYR9BqZ2AxyxgyVVlBIupDjmSPLzLiXqkMkPzdFY7uAEq
 SQUu0Dn58/7oig2j7O6+sECZsGi6hU2ChRS/h5zij1zExxTTZefCwi1SMkPyc7igu6sB
 evck+DukrxKXdts97NtKsfkPeC3VIXbTulQzE9vtgrqzXKVXj7QPxko8uzc6mamYD8t9
 VV2VJkxlFY21Q109WZltdpAAJzGqoh3NDWUDqW/3IhkRw2qVjk8d7uZEbjkdHlUrufnq
 dDfw==
X-Gm-Message-State: APuU4Z9IkC9DEIp+0MUfi9fT2/Q5x9W4l+MgFMEGoUCKbG/FzOBXpfBq
 zxSg29P/kugfzNoSTSOipW6L+hdKnG5bbpyZ3oqGGU2l0H44ZVnchwNbUbQPqQs5pThgyPHaGhp
 Mp05Kr1hw7AGsIcBjBzAhrN7FlnjHxx7+m6oAEuu1qa/+m0tnd9SbZNkpoGv4LWlmvzm7gB7DlG
 70/FuhEg==
X-Gm-Gg: AYBFou1mpuLxPGDpD90KLCK/r/YrVw+pLPANcJINyuqU64oAxZyxwTwaK2x1N+DEisX
 Jmk8xNeaESucYq+ZY1tzIw7rfynm3FAyqGCSNGzpSsZ6GOpPCwyPa5984j9BEtrTIanPwknIg68
 geSm4wI1U7J0p+Pw8SBr8e4UNbjOcoY+ebPFaM4sEdu8OBvqXntdmEDkcTv9z36xn0x770tVw9w
 0ZPK9Uewxxc9WiubgBoT8c8iKcYKecEGN2BlIpJL+JqbN1rdf++umpCwA/XlLYHhHyvsNKKuEWM
 5KEcLGok28tod89+WPAqC/qpj1Pf6co6gTsCvL91Kx0+WtvuAk3Sh3KWwR3AjQZ2KjpHpD4GE7F
 HzlhyXzuVRi4tX+jlYb5M2JFwnhDd93YNbREWFSNdXaTUsLsGA0m4OePJZM5HLzS3maf06/iqCk
 FA1FUYUJDolHMdtHiVFkxch/IxwCLhmBDvEL/0sabB5yaOPp2mJYE0nOlO/6LSoo/ROoSpZs2V0
 fZzn2wDW+DXLkbMOVAGGMEqe5zYE6wdakJ54mp2bFIQKiABrQXMPEtCFmt1A7honRfxKtyDjMGr
 5XZDooDaOswhOYnBoqz07jzQcfUn/EIGYJZ83Q0yfHKp29QDSVbcU311pBiEgRicuajAkO2v/T4
 ACq9/1aeYBUizlaWe7WwE+/59ViVIgmvpXvn9wwJ8GcPJDacjgN6P+94Hi+iILJlTOqyrXklsGR
 mzXK8XM3P51GY3GL0s/fpLNfTKknWgeSqorZc0
X-Received: by 2002:a05:600c:548b:b0:4bb:7033:de79 with SMTP id
 5b1f17b1804b1-4bb7033dff4mr118396825e9.35.1794903674705; 
 Tue, 17 Nov 2026 00:21:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d615sm27082315f8f.56.2026.11.17.00.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:21:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 08:21:14 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
X-Gerrit-Change-Number: 2206
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2206?usp=email>
X-Gerrit-Commit: f74f47ab777c3445ea77428def79dacc8c53dfdb
References: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzNjcyMDAwLkk5ZDliNjU4YTAwZjk1ZmZkY2QwZGI5YWJkMGQ4OTA3NjE4OTI1NzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88d64ae2fdce8f5327b8d88be4a58563092f403f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTERN-0000000011F-1n1k
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Wipe auth token and
 PEM key copies before freeing them
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
Content-Type: multipart/mixed; boundary="===============1889027332240374852=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1889027332240374852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MY0BaJupmpY="; charset=UTF-8

--MY0BaJupmpY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2206?usp=3Demail

to review the following change=2E
=


Change subject: Wipe auth token and PEM key copies before freeing them
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Wipe auth tok=
en and PEM key copies before freeing them

generate_auth_token() freed the =
previous token and its intermediate copies
without wiping them, unlike wipe=
_auth_token()=2E crypto_pem_decode() in the
mbed TLS backend freed its copy=
 of the PEM key text the same way=2E

Change-Id: I9d9b658a00f95ffdcd0db9abd=
0d8907618925746
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
=
M src/openvpn/auth_token=2Ec
M src/openvpn/crypto_mbedtls=2Ec
2 files chang=
ed, 9 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/06/2206/1

diff --git a/src/openvpn/auth_toke=
n=2Ec b/src/openvpn/auth_token=2Ec
index 261c7c2=2E=2Ed8e599b 100644
--- a/=
src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -271,10 +271=
,15 @@
     ASSERT(buf_write(&session_token, b64output, strlen(b64output)))=
;
     ASSERT(buf_write_u8(&session_token, 0));
 
+    secure_memzero(b64ou=
tput, strlen(b64output));
     free(b64output);
 
     /* free the auth-tok=
en if defined, we will replace it with a new one */
-    free(multi->auth_t=
oken);
+    if (multi->auth_token)
+    {
+        secure_memzero(multi->au=
th_token, strlen(multi->auth_token));
+        free(multi->auth_token);
+  =
  }
     multi->auth_token =3D string_alloc((char *)BPTR(&session_token), N=
ULL);
 
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)", multi=
->auth_token, up->username);
@@ -288,6 +293,8 @@
         multi->auth_token=
_initial =3D string_alloc(multi->auth_token, NULL);
     }
 
+    buf_clear=
(&token);
+    buf_clear(&session_token);
     gc_free(&gc);
 }
 
diff --gi=
t a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index c=
eaaad4=2E=2E58c1fd2 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/o=
penvpn/crypto_mbedtls=2Ec
@@ -1150,6 +1150,7 @@
     }
 
     mbedtls_pem_f=
ree(&ctx);
+    buf_clear(&input);
     gc_free(&gc);
     return ret;
 }

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9d9b658a00f95ffd=
cd0db9abd0d8907618925746
Gerrit-Change-Number: 2206
Gerrit-PatchSet: 1
Gerr=
it-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--MY0BaJupmpY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Wipe auth token and PEM key copies before freeing them<=
br><br>generate_auth_token() freed the previous token and its intermediate =
copies<br>without wiping them, unlike wipe_auth_token()=2E crypto_pem_decod=
e() in the<br>mbed TLS backend freed its copy of the PEM key text the same =
way=2E<br><br>Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746<br>Signe=
d-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/ope=
nvpn/auth_token=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>2 files changed,=
 9 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/06/2206/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><sp=
an>index 261c7c2=2E=2Ed8e599b 100644</span><br><span>--- a/src/openvpn/auth=
_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span=
>@@ -271,10 +271,15 @@</span><br><span>     ASSERT(buf_write(&amp;session_t=
oken, b64output, strlen(b64output)));</span><br><span>     ASSERT(buf_write=
_u8(&amp;session_token, 0));</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    secure_memzero(b64output, strlen(b64output))=
;</span><br><span>     free(b64output);</span><br><span> </span><br><span> =
    /* free the auth-token if defined, we will replace it with a new one */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(multi-&gt;au=
th_token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
ulti-&gt;auth_token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        secur=
e_memzero(multi-&gt;auth_token, strlen(multi-&gt;auth_token));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt;auth_toke=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     multi-&gt;auth_token =3D string_alloc((char *)BPTR(&amp;session_=
token), NULL);</span><br><span> </span><br><span>     dmsg(D_SHOW_KEYS, &qu=
ot;Generated token for client: %s (%s)&quot;, multi-&gt;auth_token, up-&gt;=
username);</span><br><span>@@ -288,6 +293,8 @@</span><br><span>         mul=
ti-&gt;auth_token_initial =3D string_alloc(multi-&gt;auth_token, NULL);</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_clear(&amp;token);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_clear(&amp;session_token);</span><br><span=
>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=
=2Ec</span><br><span>index ceaaad4=2E=2E58c1fd2 100644</span><br><span>--- =
a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_m=
bedtls=2Ec</span><br><span>@@ -1150,6 +1150,7 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     mbedtls_pem_free(&amp;ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;input);</spa=
n><br><span>     gc_free(&amp;gc);</span><br><span>     return ret;</span><=
br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2206?usp=3Demail">change 2206</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9d9b658a00f95ffdcd0=
db9abd0d8907618925746 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2206 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--MY0BaJupmpY=--


--===============1889027332240374852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1889027332240374852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1889027332240374852==--

