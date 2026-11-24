Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0C606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C0vMRB9P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e/WJrGKJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=biUZLXCj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Weox2cY4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iL8bGS214QTd8fxY69QYOtk9LITu/UCyonGMOZSfZtA=; b=C0vMRB9PdGREOCnZIJhzs1tn2P
	3F+0at1D1MbOPh5qrT25U/F75GoWpw88v9K/ryxscGgfqXElIqNmb9ncTLiGX1/npZI6viQVpnxa7
	14dxCOgjh5Uy+seF8pcyns6LNyJ2xMKnRnDimqYqXtWUPRxZRQJx7N/p+PsqOrsib0wE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpO4-000000006Ls-0nFr;
	Tue, 24 Nov 2026 12:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpO3-000000006Lg-1QP2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSYxsjWenRcJD6ZmrFCEu+0n2nNvvSb4pW6/ZPOpsZA=; b=e/WJrGKJAPprZI7KbwflOuh+0u
 Q/A144lFxlJreLDdYg5CY3r0EvBTuOUpFzgrBOTlT8GLacQhNcuFKd4UesJjLmnysrypOhGcItjMR
 WRRzUzCNFrK3H6RvYCgDUiWISHKRZ/SqoiDCb1MyVL+fFvSl3ts3tWARwrdCTZ6AHZ2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSYxsjWenRcJD6ZmrFCEu+0n2nNvvSb4pW6/ZPOpsZA=; b=biUZLXCjcz5L7w0pe8Uk63tzXO
 gXYjLzQjtInKdbwPzHPQbG0qB8QSPli9sC0EA//qU1GSFlMquA21wpt58eG/21B/+fUwAigkM1oEB
 F0eED8NRDWQ5HbScYiSopS0bNQrLIac7AR4TkrJFr7FEY+Qc9k+C7Gw+ibJ/cEMY6o5s=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpO1-000000001Uv-1hII for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:12:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so43499495e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795522351; x=1796127151; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uSYxsjWenRcJD6ZmrFCEu+0n2nNvvSb4pW6/ZPOpsZA=;
 b=Weox2cY4PLdqCqv/EeBbVTOUukdcwvZZ+ORqpR4P6p/xg4DYYYw9WSbU+kz1WkAzy0
 rtlXcuSJiPtybjCE85nj1UZnqybJi6reWJvqBuWf608od3ziKiibqDMrxyekhKzKAyrq
 ww1vzEQcFe509/oQRRo0qEtQpzT2iAyQrNxCj+RhU02GlpZ34hCG0uoWOv95XdS2ctMO
 220f5yI9uZQ2liEy4gZZConSMDfi2YPo4itq9kx6NfY1BcMuym/fs/s6Lf0USreuTIOj
 DpOWvcGE7l/GCpa0vQaPiXsV2zk9yObKok5AONqCs57KE2QXphPQAU1o9A7w70dsCHs9
 rsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522351; x=1796127151;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uSYxsjWenRcJD6ZmrFCEu+0n2nNvvSb4pW6/ZPOpsZA=;
 b=k4aQITIU6Jk4/mO2JoS22jGSTibKzSWaIu+Paq+kuCyQ1jAFejGVkZCwdP2IYnf03e
 AuESEtFHhG6FHcj3nGZCEPzOmVHXQFwShIhaWbnCwcQpHpJJQOiBuLP1mQHb3T6Yd8yC
 2jaxTEtVXEBFqyXw19J9c+lTUdsns5MJAz/nVwOSY20cvi3YQ3GoIe2iw4PA0PXJV06o
 BbDGv/iw3eCOVEdbQqH7S56FGNt5eF9Ck1UlusKzk/2YaHXWreJTOlvQdHMiEfxqbMAW
 lRfpLSW3JbDpOpqNy2Ab1BrievAXXxNtYywBSInMqRVB2QFzkQCRIC2hQi21eW/sHxcJ
 hkkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgSBD+p2B3qYi19fXYWgdIs46BjddwyBiTWuJyjoDiY4ZVGH38SP22BWmCc5mgI2SRquvc/vjG+wKYDzjV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ZP2g6s60XHENRPvtbvq7RHK1Z3jkxVlGyZ7dBVXxSOtzfF7/k
 h9nVVfEzgLSXaRlXZAakmpr22OA+N/EiC1UUa5nDJ5/Nw7tBQu6eheQBkYr9O2EAJJRKcrgg3Wa
 57oF7HvqXv0eiePLUdi/HoAiSxBTfmvXx92p/+Rpvp/vcKHISQu2YvmhxSRMLMqpIvHi1X3XyR1
 vXX6FJDA==
X-Gm-Gg: AZFdTZdSzfG5UTeSx0BdSjegR/pHc3S79JaLDXZZzHz0zivW4+jtAkiwvq4a9WaZjgU
 FzzbUtmc6SPYgAN0tH5aQEa+HNN1BnGtwbdrGGH2seFfYoUl+v/ZJh52fJsCNiX/uurnwWuWecu
 FPJiV239nAsUH/dERG7f29Iu+/GDxdUtDbgXivfWEEoL8FasPsbkxdpmH42TyQx58SgtkY0/UFa
 Q8c69a5RT/659VgSs0WV4HboFpsaPSz/OmoZaMJn3FnF6NNUR2De+z9hmsn3sWuku3EEgmaOlao
 TlP69FgwHEP2VCUYmFw2IvjIW53Bsq3Iv42hRmqPKJFOaxUcrAJ7Ui3fNm7qfyVdpVVFNODdZAl
 xci9FgzYgzOIpqCuw71ImeLhFUJjhZK2ErV6D9AZpN3SSRRWOTtZAgR3xidiGG7rZF5e8zY6RqF
 ZV3n2s1KfOy1sxxSRAei2aYd4q9r+ouj/yG8om/c72QEm7d9IENR/ZEnks0WyN3xieTXJ5RxtNV
 QTicr73vQaU/EEO8QGUFTKY9e1e6tQ1mdpCB/qyo+sRKqE16KrvOXCTbRx/Xdzb+aVujU+iijwZ
 IbucqKiMXv6mpkYAvg22yVuiJfgUx7pX3cK+4pLbJL69XuOg0PwnsVmcQgL5nYe7qbSt5wJjtRl
 u1nTv05jjnS4oBxzG7fVdp6r+c8k9XcDSZSRtdN5bMlmEkDLvI9UCrbW5EuU9gyvWdroh3/e4Fy
 9IjhZ9HjMBFczn9Ho=
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr291702325e9.10.1795522350621; 
 Tue, 24 Nov 2026 04:12:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm392957715e9.12.2026.11.24.04.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:12:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:12:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
X-Gerrit-Change-Number: 2232
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2232?usp=email>
X-Gerrit-Commit: 57d1b12289b169fe049b96decedd41fc1b308577
In-Reply-To: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwOTk0MDAwLkk0OWJjMWZlMGIyYzJhNzFmMmYzNzQ5MWExYjQ0ZDRjYWNjOGE3MDZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2239388537c10e31b65e3a31511fb66c1bbeb5b6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpO1-000000001Uv-1hII
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: merge the
 two multiline flatten helpers
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
Content-Type: multipart/mixed; boundary="===============1343703967167018980=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1343703967167018980==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7UGKqewfuvc="; charset=UTF-8

--7UGKqewfuvc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2232?usp=3Demail )

Change subject: manage: merge the two multi=
line flatten helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

manage: merge the two multiline flatten helpers

management_query_m=
ultiline_flatten_newline() differed only in the
aggregate length and separa=
tor; pass those as parameters instead=2E

Change-Id: I49bc1fe0b2c2a71f2f374=
91a1b44d4cacc8a706b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2232
Message-Id: <20261123134829=2E31554-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41820=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 7 ins=
ertions(+), 36 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src/o=
penvpn/manage=2Ec
index d63d53b=2E=2Eaddd6f2 100644
--- a/src/openvpn/manag=
e=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3881,45 +3881,17 @@
 }
 
 static cha=
r *
-/* returns allocated base64 signature */
-management_query_multiline_f=
latten_newline(struct management *man, const char *b64_data,
-             =
                              const char *prompt, const char *cmd, int *sta=
te,
-                                           struct buffer_list **input)=

-{
-    int ok;
-    char *result =3D NULL;
-
-    ok =3D management_query=
_multiline(man, b64_data, prompt, cmd, state);
-    if (ok && buffer_list_d=
efined(*input))
-    {
-        buffer_list_aggregate_separator(*input, 100=
00, "\n");
-        const struct buffer *buf =3D buffer_list_peek(*input);
=
-        if (buf && BLEN(buf) > 0)
-        {
-            result =3D (char=
 *)malloc(BLENZ(buf) + 1);
-            check_malloc_return(result);
-     =
       memcpy(result, buf->data, BLENZ(buf));
-            result[BLEN(buf)=
] =3D '\0';
-        }
-    }
-
-    buffer_list_free(*input);
-    *input =
=3D NULL;
-
-    return result;
-}
-
-static char *
-/* returns allocated b=
ase64 signature */
+/* returns allocated, flattened multiline input */
 man=
agement_query_multiline_flatten(struct management *man, const char *b64_dat=
a, const char *prompt,
-                                   const char *cmd,=
 int *state, struct buffer_list **input)
+                                 =
  const char *cmd, int *state, struct buffer_list **input,
+               =
                    const size_t max_len, const char *sep)
 {
     char *re=
sult =3D NULL;
 
     const int ok =3D management_query_multiline(man, b64_=
data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
    =
 {
-        buffer_list_aggregate(*input, 2048);
+        buffer_list_aggre=
gate_separator(*input, max_len, sep);
         const struct buffer *buf =3D=
 buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
@@=
 -3958,7 +3930,7 @@
     }
     char *ret =3D management_query_multiline_fl=
atten(man, (char *)buf_bptr(&buf_data), prompt, desc,
                     =
                               &man->connection=2Eext_key_state,
-         =
                                          &man->connection=2Eext_key_input)=
;
+                                                   &man->connection=2Eex=
t_key_input, 2048, "");
     free_buf(&buf_data);
     return ret;
 }
@@ -3=
971,10 +3943,9 @@
     buf_write(&buf_prompt, prompt_1, strlen(prompt_1));
=
     buf_write(&buf_prompt, cert_name, strlen(cert_name) + 1); /* +1 for \0=
 */
 
-    char *result;
-    result =3D management_query_multiline_flatten=
_newline(
+    char *result =3D management_query_multiline_flatten(
       =
  man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man->connection=
=2Eext_cert_state,
-        &man->connection=2Eext_cert_input);
+        &m=
an->connection=2Eext_cert_input, 10000, "\n");
     free_buf(&buf_prompt);
=
     return result;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2232?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
Gerrit-Change-Number: 2232
Ger=
rit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--7UGKqewfuvc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2232?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: merge the two multiline fl=
atten helpers<br><br>management_query_multiline_flatten_newline() differed =
only in the<br>aggregate length and separator; pass those as parameters ins=
tead=2E<br><br>Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2232<br>Message-Id: &lt;20261123134829=2E31554=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41820=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec=
<br>1 file changed, 7 insertions(+), 36 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>ind=
ex d63d53b=2E=2Eaddd6f2 100644</span><br><span>--- a/src/openvpn/manage=2Ec=
</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3881,45 +=
3881,17 @@</span><br><span> }</span><br><span> </span><br><span> static cha=
r *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* returns allocat=
ed base64 signature */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-management_query_multiline_flatten_newline(struct management *man, const c=
har *b64_data,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                    const char *prompt, const char *cmd, in=
t *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                               struct buffer_list **input)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int ok;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    char *result =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ok =
=3D management_query_multiline(man, b64_data, prompt, cmd, state);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (ok &amp;&amp; buffer_l=
ist_defined(*input))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buffer_li=
st_aggregate_separator(*input, 10000, &quot;\n&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        const struct buffer *buf =3D buffe=
r_list_peek(*input);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            result =3D (char *)malloc(BLENZ(buf) + 1);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            check_malloc_return(=
result);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
emcpy(result, buf-&gt;data, BLENZ(buf));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            result[BLEN(buf)] =3D &#39;\0&#39;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buffer_list_free(*input);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    *input =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return result;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* returns allocated base64 signature */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* returns allocated, flattened multiline input *=
/</span><br><span> management_query_multiline_flatten(struct management *ma=
n, const char *b64_data, const char *prompt,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                   const char *cmd, =
int *state, struct buffer_list **input)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                   const char *cmd, int=
 *state, struct buffer_list **input,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   const size_t max_len, c=
onst char *sep)</span><br><span> {</span><br><span>     char *result =3D NU=
LL;</span><br><span> </span><br><span>     const int ok =3D management_quer=
y_multiline(man, b64_data, prompt, cmd, state);</span><br><span>     if (ok=
 &amp;&amp; buffer_list_defined(*input))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        buffer_list_aggregate(*in=
put, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buffer_list_aggregate_separator(*input, max_len, sep);</span><br><span>    =
     const struct buffer *buf =3D buffer_list_peek(*input);</span><br><span=
>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</=
span><br><span>@@ -3958,7 +3930,7 @@</span><br><span>     }</span><br><span=
>     char *ret =3D management_query_multiline_flatten(man, (char *)buf_bpt=
r(&amp;buf_data), prompt, desc,</span><br><span>                           =
                         &amp;man-&gt;connection=2Eext_key_state,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
                    &amp;man-&gt;connection=2Eext_key_input);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                  &amp;man-&gt;connection=2Eext_key_input, 2048, &quot;&quo=
t;);</span><br><span>     free_buf(&amp;buf_data);</span><br><span>     ret=
urn ret;</span><br><span> }</span><br><span>@@ -3971,10 +3943,9 @@</span><b=
r><span>     buf_write(&amp;buf_prompt, prompt_1, strlen(prompt_1));</span>=
<br><span>     buf_write(&amp;buf_prompt, cert_name, strlen(cert_name) + 1)=
; /* +1 for \0 */</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char *result;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    result =3D management_query_multiline_flatten_newline(</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *result =3D manag=
ement_query_multiline_flatten(</span><br><span>         man, NULL, (char *)=
buf_bptr(&amp;buf_prompt), &quot;certificate&quot;, &amp;man-&gt;connection=
=2Eext_cert_state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     &amp;man-&gt;connection=2Eext_cert_input);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &amp;man-&gt;connection=2Eext_cert_inpu=
t, 10000, &quot;\n&quot;);</span><br><span>     free_buf(&amp;buf_prompt);<=
/span><br><span>     return result;</span><br><span> }</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?us=
p=3Demail">change 2232</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2232?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2232 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--7UGKqewfuvc=--


--===============1343703967167018980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1343703967167018980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1343703967167018980==--

