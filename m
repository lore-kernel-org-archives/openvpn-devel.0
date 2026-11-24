Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363A606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jV8V880/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GELXS0aE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i1r24Atf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e8jSuyzp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ISRsQyLXvvgW4C05tLXjDTaMi07XnI4b2eikFsNHh+A=; b=jV8V880/OgwlWEsYE3B+M/kgUK
	ubJpm5IkwrCwpNwOGJG0p2ie70Jf1pcC8TEU4fR6Z53D4w6Z7aJpKSGfzKkrGG1VtlFi0TEmuzpaK
	MZcH8XdcV2tErjiGNPy5BEywYjIZFWt1FhDGHRaz+NtpunlCpQCFnkyVx5i+1bCE8kXU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpO6-000000001s2-08U1;
	Tue, 24 Nov 2026 12:12:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpO4-000000001ru-2do2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vGQv3oCs6YfntK49kmdT30JkbUjINUhyd8UqN91gdgQ=; b=GELXS0aE/7hKCnGqnrqbJS1A8L
 Gk33KNgSFe0oUCPBJ+72TsvO9QV2L6kJ/zdlbRGXn9/jaaDPARGRDEj+Rd/vyFcgIm65Mq3XhAHxx
 v5l0RAqM6P4LrHvm65UW4dXh4OnsHOa8PHkXMimqy2jpPlL9Dc5WXhpTnlg76OAsAxYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vGQv3oCs6YfntK49kmdT30JkbUjINUhyd8UqN91gdgQ=; b=i1r24AtfvADYmR4wBpPMmQcYWl
 2Qi/lwVMq1z/UgzMQYFjoq0HhAR7s48BLHiqA4gDWiwv/D4UEvmqLXG8FG8aAxeRvGL4pisw72003
 HS39KGefaX911WIZLiOBxjYaaNRqGHHvDhnnXFLw/yNFgSvfz9YQRCvfqtmoOs+ubSmc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpO0-000000001Uu-2NEX for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:12:40 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so34220745e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795522350; x=1796127150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vGQv3oCs6YfntK49kmdT30JkbUjINUhyd8UqN91gdgQ=;
 b=e8jSuyzpTaryTcf5f/ETQrwLzVsUJVNFYiSLxYbGlYISLEKu7hrVz/LVgu83ZXBbXX
 WiNcLQRrydWRYsZ6tFQuJKYHEOdw2xMn+bUAsOGu2VDd+E4kqGYldoKTVihMeibiOKOW
 8x6QCNw193S97bLWzLec4BBcVo6E2E3IkZ/Icnnfvyx6uizVBRtWw22JafxGW0g8aWnL
 COAyNJksUd0l/dVtBBNK8eKms2yLK96tjdEu+LXZs/fwlVihMsZo85Aj0ptLGCLSJo+C
 TDOFkAOx7ySQ4hNACoRAwVgfTo1gmqBro23Y+8BhimiOHwr8K9vd+z67HnTsPnQMT9M/
 2IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522350; x=1796127150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vGQv3oCs6YfntK49kmdT30JkbUjINUhyd8UqN91gdgQ=;
 b=SJHWBhhQycmoabT663b+jVA+vVxDu12k35PI0oSY7y44eBCCVD14OK6NF89B6OZZLQ
 2C8Sn8G4A/3x/0tcLIHEX3CezvfYcBVbc182Lsk0pmS6v7k2/4fgxfj9OKKdbF+HEkLm
 +bN6D8kASbkutYsU/gXUjtqxJwRTFXXUNevnPCplRyRpuj+Lc2v/rPQZ0zREX7VZ/r/2
 wl04c2wrfbEa+6a1UIRcAcTwqk754tElAibED1cvgSLt3QrRW+MqIJbcGQR5SI7C4iU/
 uqzcPco4gOL7QTCZe9QQyop9yVkAgz4tI/fBdl2bof1aH22wUlEkbaBaqiA8SbOxz5W2
 4n4g==
X-Gm-Message-State: APuU4Z8FOOX32yMaa/iM1VUiugE21HL0sc9EK8Uf439GD+pSsS0sKQtq
 l/MVIlSSnzi05/E8m7aV2m9BOMpaHDG5PKkbEurrWWaVMDBYpWej7wKKIzCqvdorjncj0ySYmzC
 HBBuip5Z8JWjxSjsjuEWACi9S7YffMno2vutXc3GknM7TGfpH974uyNFi+F6cMTnDcexu
X-Gm-Gg: AZFdTZc/WcZwKGdhf7uTRBWSuGK1eB/dMW6GA5Hcj7PoyMcOSwEt6vliJ/k6cNTZhdu
 wqb/2kQcGzNmIhiIA6CnEKfSgDMIxvMk6m2ah6ic2r6c/biv2c+8ObpfX7rLsQwVkxHTdg9CiuT
 JWZH5JIe5YtuujSiE621npqrMlSuusqLuGE7Ky1FbRM7Lg0XCqiXE7oHO634jChgq/oGFKb8lcM
 C1XlF8AKk0fpNtm+FtpYrDkMs7SthrwIsn07hQELDbxaTC4RWRIiUVJ9RdypMub4lzP+H+eS3EJ
 HHPjdtjOCt6iyvcW1Aqc6VIu+3Yf34F37I5S6x6QVMVkS/Ta64MnWhruxY3Edadij0CTCz7UPe+
 ZZirR2TGuhXd930f0eo8tCNp8i03Cv7iACKp1W6J5oZnaENaKwoRqn6tw61gibLyAQ4yz6JcTWz
 EBLpqc3i6R87v4M8HGD/fa7oFUNwz79oAgeFy6Ms4upe9sSROT6x0KGO0LpTniiZRNuPDXEWTfV
 3XrTyqVElifRaxVc4NhYLnYSKiaejIg4LSlKvutIdflDIXwbVwtNflupJkAWcl7Ei+TKEiD6D99
 sF1WGnoEYjFLVg+bnyxp9QPUWUTqv2O8fz/FeHBbZe+2Ui0zuezebGilFoWQHujhjtgMebB6tQX
 FM97nmnygUZzlTgVxc9BJvvADNgUPqhW2xV06kELBzemzPkZsaZNDCnwrJjfiEBK9c0++krTfBV
 m6fF3h+aOLVK7kclY=
X-Received: by 2002:a05:600d:18:b0:4bb:9001:1aa with SMTP id
 5b1f17b1804b1-4bb900102b8mr188658285e9.10.1795522349880; 
 Tue, 24 Nov 2026 04:12:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c43563esm28795641f8f.57.2026.11.24.04.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:12:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:12:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
X-Gerrit-Change-Number: 2232
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2232?usp=email>
X-Gerrit-Commit: 57d1b12289b169fe049b96decedd41fc1b308577
In-Reply-To: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwOTk0MDAwLkk0OWJjMWZlMGIyYzJhNzFmMmYzNzQ5MWExYjQ0ZDRjYWNjOGE3MDZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2239388537c10e31b65e3a31511fb66c1bbeb5b6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpO0-000000001Uu-2NEX
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7463882937975065659=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7463882937975065659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G51LOn/+fX4="; charset=UTF-8

--G51LOn/+fX4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2232?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: merge the tw=
o multiline flatten helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

manage: merge the two multiline flatten helpers

managemen=
t_query_multiline_flatten_newline() differed only in the
aggregate length a=
nd separator; pass those as parameters instead=2E

Change-Id: I49bc1fe0b2c2=
a71f2f37491a1b44d4cacc8a706b
Signed-off-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232
Message-Id: <20261123134829=
=2E31554-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41820=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file chang=
ed, 7 insertions(+), 36 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/32/2232/3

diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index d63d53b=2E=2Eaddd6f2 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3881,45 +3881,17 @@
 }
 =

 static char *
-/* returns allocated base64 signature */
-management_query=
_multiline_flatten_newline(struct management *man, const char *b64_data,
- =
                                          const char *prompt, const char *c=
md, int *state,
-                                           struct buffer_l=
ist **input)
-{
-    int ok;
-    char *result =3D NULL;
-
-    ok =3D mana=
gement_query_multiline(man, b64_data, prompt, cmd, state);
-    if (ok && b=
uffer_list_defined(*input))
-    {
-        buffer_list_aggregate_separator=
(*input, 10000, "\n");
-        const struct buffer *buf =3D buffer_list_pe=
ek(*input);
-        if (buf && BLEN(buf) > 0)
-        {
-            resu=
lt =3D (char *)malloc(BLENZ(buf) + 1);
-            check_malloc_return(res=
ult);
-            memcpy(result, buf->data, BLENZ(buf));
-            resu=
lt[BLEN(buf)] =3D '\0';
-        }
-    }
-
-    buffer_list_free(*input);
=
-    *input =3D NULL;
-
-    return result;
-}
-
-static char *
-/* returns=
 allocated base64 signature */
+/* returns allocated, flattened multiline i=
nput */
 management_query_multiline_flatten(struct management *man, const c=
har *b64_data, const char *prompt,
-                                   cons=
t char *cmd, int *state, struct buffer_list **input)
+                     =
              const char *cmd, int *state, struct buffer_list **input,
+   =
                                const size_t max_len, const char *sep)
 {
 =
    char *result =3D NULL;
 
     const int ok =3D management_query_multili=
ne(man, b64_data, prompt, cmd, state);
     if (ok && buffer_list_defined(*=
input))
     {
-        buffer_list_aggregate(*input, 2048);
+        buffe=
r_list_aggregate_separator(*input, max_len, sep);
         const struct buf=
fer *buf =3D buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
 =
        {
@@ -3958,7 +3930,7 @@
     }
     char *ret =3D management_query_=
multiline_flatten(man, (char *)buf_bptr(&buf_data), prompt, desc,
         =
                                           &man->connection=2Eext_key_state=
,
-                                                   &man->connection=2Eex=
t_key_input);
+                                                   &man->con=
nection=2Eext_key_input, 2048, "");
     free_buf(&buf_data);
     return r=
et;
 }
@@ -3971,10 +3943,9 @@
     buf_write(&buf_prompt, prompt_1, strlen(=
prompt_1));
     buf_write(&buf_prompt, cert_name, strlen(cert_name) + 1); =
/* +1 for \0 */
 
-    char *result;
-    result =3D management_query_multi=
line_flatten_newline(
+    char *result =3D management_query_multiline_flat=
ten(
         man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man=
->connection=2Eext_cert_state,
-        &man->connection=2Eext_cert_input);=

+        &man->connection=2Eext_cert_input, 10000, "\n");
     free_buf(&b=
uf_prompt);
     return result;
 }

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2232?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
Gerrit-Change=
-Number: 2232
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--G51LOn/+fX4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2232?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: merge the two multiline flatten helpers<br><br>management_query=
_multiline_flatten_newline() differed only in the<br>aggregate length and s=
eparator; pass those as parameters instead=2E<br><br>Change-Id: I49bc1fe0b2=
c2a71f2f37491a1b44d4cacc8a706b<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232<br>M=
essage-Id: &lt;20261123134829=2E31554-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41820=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 7 insertions(+), 3=
6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/32/2232/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index d63d53b=2E=2Ead=
dd6f2 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+=
++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3881,45 +3881,17 @@</span><=
br><span> }</span><br><span> </span><br><span> static char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/* returns allocated base64 signatur=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_query_=
multiline_flatten_newline(struct management *man, const char *b64_data,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                  const char *prompt, const char *cmd, int *state,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
             struct buffer_list **input)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int ok;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *r=
esult =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ok =3D management_query=
_multiline(man, b64_data, prompt, cmd, state);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (ok &amp;&amp; buffer_list_defined(*input))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        buffer_list_aggregate_separat=
or(*input, 10000, &quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const struct buffer *buf =3D buffer_list_peek(*input);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf &amp;=
&amp; BLEN(buf) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            check_malloc_return(result);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            memcpy(result, buf-&g=
t;data, BLENZ(buf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           result[BLEN(buf)] =3D &#39;\0&#39;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buffer_list_free(*in=
put);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *input =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return result;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* returns allo=
cated base64 signature */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* returns allocated, flattened multiline input */</span><br><span> m=
anagement_query_multiline_flatten(struct management *man, const char *b64_d=
ata, const char *prompt,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                   const char *cmd, int *state, struct b=
uffer_list **input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   const char *cmd, int *state, struct buff=
er_list **input,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                const size_t max_len, const char *sep)</spa=
n><br><span> {</span><br><span>     char *result =3D NULL;</span><br><span>=
 </span><br><span>     const int ok =3D management_query_multiline(man, b64=
_data, prompt, cmd, state);</span><br><span>     if (ok &amp;&amp; buffer_l=
ist_defined(*input))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buffer_list_aggregate(*input, 2048);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        buffer_list_aggregat=
e_separator(*input, max_len, sep);</span><br><span>         const struct bu=
ffer *buf =3D buffer_list_peek(*input);</span><br><span>         if (buf &a=
mp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</span><br><span>@@ -3=
958,7 +3930,7 @@</span><br><span>     }</span><br><span>     char *ret =3D =
management_query_multiline_flatten(man, (char *)buf_bptr(&amp;buf_data), pr=
ompt, desc,</span><br><span>                                               =
     &amp;man-&gt;connection=2Eext_key_state,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                                   =
&amp;man-&gt;connection=2Eext_key_input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                                   &a=
mp;man-&gt;connection=2Eext_key_input, 2048, &quot;&quot;);</span><br><span=
>     free_buf(&amp;buf_data);</span><br><span>     return ret;</span><br><=
span> }</span><br><span>@@ -3971,10 +3943,9 @@</span><br><span>     buf_wri=
te(&amp;buf_prompt, prompt_1, strlen(prompt_1));</span><br><span>     buf_w=
rite(&amp;buf_prompt, cert_name, strlen(cert_name) + 1); /* +1 for \0 */</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ch=
ar *result;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    result=
 =3D management_query_multiline_flatten_newline(</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *result =3D management_query_multilin=
e_flatten(</span><br><span>         man, NULL, (char *)buf_bptr(&amp;buf_pr=
ompt), &quot;certificate&quot;, &amp;man-&gt;connection=2Eext_cert_state,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;man-&gt;co=
nnection=2Eext_cert_input);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &amp;man-&gt;connection=2Eext_cert_input, 10000, &quot;\n&q=
uot;);</span><br><span>     free_buf(&amp;buf_prompt);</span><br><span>    =
 return result;</span><br><span> }</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail">change 22=
32</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2232 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--G51LOn/+fX4=--


--===============7463882937975065659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7463882937975065659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7463882937975065659==--

