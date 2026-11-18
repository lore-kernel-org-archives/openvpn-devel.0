Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98222606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=khgcm4YO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UMgTd5yM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hswJMHwY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K/NyXSZI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rwgIMsomnCErJGOEUQy7ZoT7s24mckPnyckB4be9nLU=; b=khgcm4YOm1T2L7UUEbWJnVcJQT
	9zovX7GBJfoBWD/R1cXdElghpP6gzgvBX2d7rJO5X178t5Z58VNe7/I4h/7hQ8A1aYEchiCdRGFmL
	lVEtA9RgEWEIztXhib5RV0w0evRhwrDRu9gyHs86ZoNGhVy0XRIFhi0bGwVOzkML10gU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTkS6-00000000739-1eP8;
	Wed, 18 Nov 2026 18:32:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTkS4-0000000072p-2QyP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gKj/4JwREzzadcocHzo10DINnuETRW7JD5cXzwXJfYI=; b=UMgTd5yMuM749wLhfCmAFn55Wc
 usrFpA0ZGy/0F37g/izSDVu79WUBBhaptRvOPFxXjvEQMuNZHWigMP5FrxXI20X6CQmCCjArpqtGL
 hN8bONbTC9paLB+oOAmAgNzsrYjP9uIoiHrw3Qm+8soFbCvFuBJJOtem6dvOfCa46Rsw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gKj/4JwREzzadcocHzo10DINnuETRW7JD5cXzwXJfYI=; b=hswJMHwYlB5enX3xaP2bw5F6I+
 y1eLd4RbtpS+xiBey4p7/e/WrmeDI5/ic+sAm0WoXo+sfnxBXRBxr1v+mBnPRHOvC5Gs5Ddo6yHUH
 KlT7y5JJz36eXqUqw+oMqMotWlLR0LSNXKeDPlO+c/zSlWwDBwkv+EzYUyc46EfMqL4U=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTkS2-000000007Cs-3e03 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:32:12 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so11385295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795026724; x=1795631524; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gKj/4JwREzzadcocHzo10DINnuETRW7JD5cXzwXJfYI=;
 b=K/NyXSZI2w8qsldbd5x1cWayMxTy18Zhvcq54DnqOTsfTtLKED+2eRsCPIPMFyoFfm
 UDZ94Xje+cdLKcu+PW47GJCTNp97ezhTl922MUUb7bQZhSv1QWC+P4MUJJnvEbAtDRoi
 zdIfza4gHkD3gf1n8nT8S4HIwnPHb17Llgoex0jv1VMAi2e3Cw/Y+Trz813H3qJi7B8b
 Y3njhFWuE9d0OHaFkz1Y+Df5YVlvGZQE/GhGGkauB4QY50yS6J+5u012+8WF26RYjsGn
 43+ehp0D2MY+lAXupB+Yzk9IX7wJgNVB9okELlaZkGJJDEKxqZknlJDtVxy1wg3agUFw
 BQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795026724; x=1795631524;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gKj/4JwREzzadcocHzo10DINnuETRW7JD5cXzwXJfYI=;
 b=KgMsBLz9TsnXq2wFOgAaU+QMMKBa6ueHCVI0V2D4fUlKuU2tUC3V6NGq1qX3xI9LY9
 0Yn9IpjHA09DJCbUATJR6XeD4GqMcdosYFw6QEgAp1oCdjUrG13qGxzqq4frNo3WNTt1
 xSQXWscqHzlL1ZubD+CZkcW2SQuW8g1V4/K3qq7jCmD3xEbf8g9aibBT190HL2Yd6hCa
 YT/USsS0vLM625snRCAwAtbDV+0ABbWmiyL+/7dGzvEsfZoxCAwmhpCRU3kjzjF091It
 SXyQJAa2/02nowZc0BVlV9lHsIK/9HXxJJCpD2SSYx6EvIFYBYaNOmHY9QB6L63DQobB
 nNcw==
X-Gm-Message-State: APuU4Z+5d5zm2DVA7hvsiRW3QK1g27EyCnlTwCfdDPHj6lomhgB0Y1MX
 fljbTRWwZXWf0CUwulpqoI+sWToqwYSGHH6tefOFtpHb8KEJFp6VatN4RwgedR/yuYxukZTrXvf
 sMgrnyYBOpf0ro2YM5+NaHk7yNOMIjdRvpE/swn1IJTmtqxTAAoH19wuaYPV22I6CPbLa/aUKg3
 NBM6UQiA==
X-Gm-Gg: AYBFou0Llmde/elK2MB/0oDDNNtjQLcRWa/o4d/4lBRYc/mdi8zF3orEGT1N+ACeZg9
 ItkG4Kbo8/c40Lso2KaM/BXuDWEscMMKhtLnyjvcELgw5crQKrPgUlVfMB3xaKnFgfcmTZM9naU
 pQe0b1q8lkm38N9FTeBWPE8fC077Qg1BEZERfPB0L9vqXvKKlT+B7kiClnhjbHeiu/qhFmwAwfP
 lKtEiUf9VUNmUJfT/jQl0sDgxsNkyXfI3uBjZE2peN7lhpzaVcmP95MVHWUckLaQr2eb1MP1sD/
 YaBylhwrwARi6wfwaUMPBx17Nqo2KvSUnxBq8hl/l4/C10Lg3dd2le9mx3ZJ1c//8tg15R3M+CI
 bo54ToJjkQ2i8HWoTfJBSVkzWwdGRX+j+UVugN/sHn/IbOG+YACWYdg9GMZae9eSEQpCzMwpkAh
 oFGQPMey6LPJQtOz4Pg9ep2eLSwr0wVXNrkhoVpyN58gZm9IRDS3lF+ApoeXguN3dsH6aCHWsuZ
 PWwaY3mlxBkVDbnbTMkaU7rUtkADItYukXmO/TCUIYJftALwwjHsgrAl54PTIndaqLFEhOpAB7Z
 tKcCPhdcDalBUy9juUHIQX3iTO2O4ohpljjtZi9v9qoUfIpFRRTGK4h5HBlHHbEBS4RnLiq+I8/
 mgZd8DYzKQ5lU1EuYig9rzfDgErcz2LCBofkwbsCP3RLmEC0IdVqePA8jtGqyfFzVmg6/EmWOWO
 1rDvG+44Su3PH+lAk=
X-Received: by 2002:a05:600c:1d97:b0:4b0:c1ae:829 with SMTP id
 5b1f17b1804b1-4bb7da581a9mr73171725e9.30.1795026723969; 
 Wed, 18 Nov 2026 10:32:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d4f5b87sm57489395e9.2.2026.11.18.10.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:32:03 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 18:32:02 +0000
To: Ralf Lici <ralf@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 33
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 01e8763b95e4ad83bb9903fc6803f7b5ed7ea855
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdaa0de91ef4b1a88b98fc0788e42a0273769a99-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTkS2-000000007Cs-3e03
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, gert@greenie.muc.de
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0856610595394543354=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0856610595394543354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IoyNYe93gSU="; charset=UTF-8

--IoyNYe93gSU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Lev Stipa=
kov, Ralf Lici, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Gert Doering, =
Ralf Lici, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Pl=
ease visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail=


to look at the new patch set (#33)=2E

The following approvals got outdat=
ed and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru, Code-Review-1 b=
y Gert Doering

The change is no longer submittable: Code-Review and checks=
~ChecksSubmitRule are unsatisfied now=2E


Change subject: init: Extract in=
it_tls_wrap_ctx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Extract init_tls_wrap_ctx() contro=
l-channel wrap helper

Factor the tls-auth/tls-crypt wrapping-context setup=
 out of
do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, an=
d
expose it in init=2Eh together with do_init_tls_wrap_key(), which now
tak=
es the connection entry to read its keys from instead of using
options=2Ece=
=2E Both call sites pass &c->options=2Ece, so there is no behavior
change=
=2E

A planned server-probe feature will use the helper to build the wrappi=
ng
context before a connection exists, so that a probe can be wrapped with
=
tls-auth/tls-crypt like any other control packet=2E

Change-Id: I7d8546da9e=
f06c2226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files changed, 75 i=
nsertions(+), 36 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/49/1749/33

diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec
index e1052c5=2E=2E0a76263 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3004,13 +3004,13 @@
 /*
  * Initialize =
the tls-auth/crypt key context
  */
-static void
-do_init_tls_wrap_key(stru=
ct context *c)
+void
+do_init_tls_wrap_key(struct context *c, const struct =
connection_entry *ce)
 {
     const struct options *options =3D &c->options=
;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (options->=
ce=2Etls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* Initiali=
ze key_type for tls-auth with auth only */
         CLEAR(c->c1=2Eks=2Etls_=
auth_key_type);
@@ -3025,33 +3025,31 @@
         }
 
         crypto_read_o=
penvpn_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_wrap_key,
-  =
                              options->ce=2Etls_auth_file, options->ce=2Etl=
s_auth_file_inline,
-                                options->ce=2Ekey_dire=
ction, "Control Channel Authentication",
-                                "=
tls-auth", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+                         =
       ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_direction,
+   =
                             "Control Channel Authentication", "tls-auth",
=
+                                &c->c1=2Eks=2Eoriginal_wrap_keydata);
    =
 }
 
     /* TLS handshake encryption+authentication (--tls-crypt) */
-    =
if (options->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
     {
     =
    tls_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_w=
rap_keydata,
-                           options->ce=2Etls_crypt_file, opti=
ons->ce=2Etls_crypt_file_inline,
-                           options->tls_s=
erver);
+                           ce->tls_crypt_file, ce->tls_crypt_file_=
inline, options->tls_server);
     }
 
     /* tls-crypt with client-specif=
ic keys (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v2_file)
+    =
if (ce->tls_crypt_v2_file)
     {
         if (options->tls_server)
       =
  {
             tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etls_crypt_v2_se=
rver_key, true,
-                                         options->ce=2Etls=
_crypt_v2_file,
-                                         options->ce=2Etls=
_crypt_v2_file_inline);
+                                         ce->tls_c=
rypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
         else
     =
    {
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2Etls_wrap_key,=
 &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                                    =
     &c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v2_file,
-    =
                                     options->ce=2Etls_crypt_v2_file_inline=
);
+                                         &c->c1=2Eks=2Etls_crypt_v2_wkc=
, ce->tls_crypt_v2_file,
+                                         ce->tls_=
crypt_v2_file_inline);
         }
         /* We have to ensure that the lo=
aded tls-crypt key is small enough
          * to fit into the initial hard=
 reset v3 packet */
@@ -3060,18 +3058,44 @@
         /* empty ACK/message i=
d, tls-crypt, Opcode, UDP, ipv6 */
         int required_size =3D 5 + wkc_l=
en + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_size > =
c->options=2Ece=2Etls_mtu)
+        if (required_size > ce->tls_mtu)
      =
   {
             msg(M_WARN,
                 "ERROR: tls-crypt-v2 client =
key too large to work with "
                 "requested --max-packet-size =
%d, requires at least "
                 "--max-packet-size %d=2E Packets w=
ill ignore requested "
                 "maximum packet size",
-           =
     c->options=2Ece=2Etls_mtu, required_size);
+                ce->tls_mt=
u, required_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(struct t=
ls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,
=
+                  const struct key_schedule *ks)
+{
+    CLEAR(*tls_wrap);=

+
+    /* TLS handshake authentication (--tls-auth) */
+    if (ce->tls_au=
th_file)
+    {
+        tls_wrap->mode =3D TLS_WRAP_AUTH;
+    }
+
+    /*=
 TLS handshake encryption (--tls-crypt) */
+    if (ce->tls_crypt_file || (=
ce->tls_crypt_v2_file && tls_client))
+    {
+        tls_wrap->mode =3D TL=
S_WRAP_CRYPT;
+    }
+
+    if (tls_wrap->mode =3D=3D TLS_WRAP_AUTH || tls_=
wrap->mode =3D=3D TLS_WRAP_CRYPT)
+    {
+        tls_wrap->opt=2Ekey_ctx_b=
i =3D ks->tls_wrap_key;
+        tls_wrap->opt=2Eflags |=3D CO_PACKET_ID_LO=
NG_FORM;
+        tls_wrap->original_wrap_keydata =3D ks->original_wrap_key=
data;
+    }
+}
+
 /*
  * Initialize the persistent component of OpenVPN's =
TLS mode,
  * which is preserved across SIGUSR1 resets=2E
@@ -3143,7 +3167,=
7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, options->au=
thname, warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
-   =
     do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=
=2Ece);
 
         /* initialise auth-token crypto support */
         if (=
c->options=2Eauth_token_generate)
@@ -3168,7 +3192,7 @@
          * tls-aut=
h/crypt key can be configured per connection block, therefore
          * w=
e must reload it as it may have changed
          */
-        do_init_tls_w=
rap_key(c);
+        do_init_tls_wrap_key(c, &c->options=2Ece);
     }
 }
 =

@@ -3349,24 +3373,8 @@
         to=2Eekm_size =3D 0;
     }
 
-    /* TLS =
handshake authentication (--tls-auth) */
-    if (options->ce=2Etls_auth_fi=
le)
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;
-    }
-
-    /=
* TLS handshake encryption (--tls-crypt) */
-    if (options->ce=2Etls_cryp=
t_file || (options->ce=2Etls_crypt_v2_file && options->tls_client))
-    {
=
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }
-
-    if (to=2Etl=
s_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_=
CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Eks=2Etl=
s_wrap_key;
-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FOR=
M;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eoriginal=
_wrap_keydata;
-    }
+    /* Control-channel wrapping (--tls-auth / --tls-=
crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &c->options=2Ece, options-=
>tls_client, &c->c1=2Eks);
 
     if (options->ce=2Etls_crypt_v2_file)
    =
 {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index c486158=
=2E=2Ed028280 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
=
@@ -73,6 +73,37 @@
 
 void do_test_crypto(struct context *o);
 
+/**
+ * @b=
rief Load the tls-auth/tls-crypt(-v2) key material into c->c1=2Eks=2E
+ *
+=
 * Reads the key from the file configured on connection entry ce (--tls-aut=
h,
+ * --tls-crypt or --tls-crypt-v2); a no-op when none of them is set=2E =
May be
+ * called more than once (the key can be configured per connection =
block, so it
+ * is reloaded for each connection)=2E
+ *
+ * @param c  The =
context whose c1=2Eks key schedule is populated=2E
+ * @param ce The connec=
tion entry whose tls-wrap key file is loaded=2E
+ */
+void do_init_tls_wrap=
_key(struct context *c, const struct connection_entry *ce);
+
+/**
+ * @bri=
ef Configure a control-channel wrapping context from a connection entry
+ *=
        and previously loaded tls-wrap key material=2E
+ *
+ * Sets tls_wra=
p to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / client=
 --tls-crypt-v2) and installs the key context, or
+ * leaves it in TLS_WRAP=
_NONE when neither is configured=2E The key material must
+ * already have =
been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics
+ * (the =
wrapped client key and the server key) are left to the caller=2E
+ *
+ * @p=
aram tls_wrap   The wrapping context to configure=2E
+ * @param ce         =
The connection entry selecting the wrapping mode=2E
+ * @param tls_client W=
hether this is a TLS client (selects tls-crypt-v2 mode)=2E
+ * @param ks   =
      Key schedule holding the loaded tls-wrap key material=2E
+ */
+void i=
nit_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_ent=
ry *ce,
+                       bool tls_client, const struct key_schedule =
*ks);
+
 void context_gc_free(struct context *c);
 
 bool do_up(struct cont=
ext *c, bool pulled_options, uint64_t option_types_found);

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f955=
0d24894c61
Gerrit-Change-Number: 1749
Gerrit-PatchSet: 33
Gerrit-Owner: Lev=
 Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ec=
om>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greeni=
e=2Emuc=2Ede>

--IoyNYe93gSU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Lev Stipakov, Ralf Lici, =
R=C4=83zvan Cojocaru=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #33=
</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1749?usp=3Demail">View Change</a></p><p>The following approval=
s got outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru, Cod=
e-Review-1 by Gert Doering</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
init: Extract init_tls_wrap_ctx() control-channel wrap helper<br><br>Factor=
 the tls-auth/tls-crypt wrapping-context setup out of<br>do_init_crypto_tls=
() into a reusable init_tls_wrap_ctx() helper, and<br>expose it in init=2Eh=
 together with do_init_tls_wrap_key(), which now<br>takes the connection en=
try to read its keys from instead of using<br>options=2Ece=2E Both call sit=
es pass &amp;c-&gt;options=2Ece, so there is no behavior<br>change=2E<br><b=
r>A planned server-probe feature will use the helper to build the wrapping<=
br>context before a connection exists, so that a probe can be wrapped with<=
br>tls-auth/tls-crypt like any other control packet=2E<br><br>Change-Id: I7=
d8546da9ef06c2226ea77e461f9550d24894c61<br>Signed-off-by: Lev Stipakov &lt;=
lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/ini=
t=2Eh<br>2 files changed, 75 insertions(+), 36 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/49/1749/33</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index e1052c5=2E=2E0a76263 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -3004,13 +3004,13 @@</span><br><span> /*</span><br><span>  * Init=
ialize the tls-auth/crypt key context</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-do_init_tls_wrap_key(struct context *c)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_init_tls_wrap_key(struct context *c, c=
onst struct connection_entry *ce)</span><br><span> {</span><br><span>     c=
onst struct options *options =3D &amp;c-&gt;options;</span><br><span> </spa=
n><br><span>     /* TLS handshake authentication (--tls-auth) */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_aut=
h_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&=
gt;tls_auth_file)</span><br><span>     {</span><br><span>         /* Initia=
lize key_type for tls-auth with auth only */</span><br><span>         CLEAR=
(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><span>@@ -3025,33 +3025,31 @=
@</span><br><span>         }</span><br><span> </span><br><span>         cry=
pto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etls_auth_key_type, &amp;c-&gt;c1=
=2Eks=2Etls_wrap_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                options-&gt;ce=2Etls_auth_file, options-&gt=
;ce=2Etls_auth_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                options-&gt;ce=2Ekey_direction, &quot=
;Control Channel Authentication&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                &quot;tls-auth&quot;, &amp=
;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                ce-&gt;tls_auth_file, =
ce-&gt;tls_auth_file_inline, ce-&gt;key_direction,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                &quot;Contro=
l Channel Authentication&quot;, &quot;tls-auth&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &amp;c-&g=
t;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span>     }</span><br><span>=
 </span><br><span>     /* TLS handshake encryption+authentication (--tls-cr=
ypt) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (option=
s-&gt;ce=2Etls_crypt_file)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ce-&gt;tls_crypt_file)</span><br><span>     {</span><br><spa=
n>         tls_crypt_init_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-&gt=
;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                           options-&gt;ce=2Etls_crypt_file, opt=
ions-&gt;ce=2Etls_crypt_file_inline,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                           options-&gt;tls_server);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           c=
e-&gt;tls_crypt_file, ce-&gt;tls_crypt_file_inline, options-&gt;tls_server)=
;</span><br><span>     }</span><br><span> </span><br><span>     /* tls-cryp=
t with client-specific keys (--tls-crypt-v2) */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_v2_file)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_=
v2_file)</span><br><span>     {</span><br><span>         if (options-&gt;tl=
s_server)</span><br><span>         {</span><br><span>             tls_crypt=
_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_server_key, true,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                options-&gt;ce=2Etls_crypt_v2_file,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                         op=
tions-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         ce-&gt;tls_c=
rypt_v2_file, ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }<=
/span><br><span>         else</span><br><span>         {</span><br><span>  =
           tls_crypt_v2_init_client_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, =
&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                         &amp;c-&gt;c=
1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Etls_crypt_v2_file,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
       options-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                         &am=
p;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tls_crypt_v2_file,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
        ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }</span>=
<br><span>         /* We have to ensure that the loaded tls-crypt key is sm=
all enough</span><br><span>          * to fit into the initial hard reset v=
3 packet */</span><br><span>@@ -3060,18 +3058,44 @@</span><br><span>       =
  /* empty ACK/message id, tls-crypt, Opcode, UDP, ipv6 */</span><br><span>=
         int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead() + 1 +=
 8 + 40;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (required_size &gt; c-&gt;options=2Ece=2Etls_mtu)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (required_size &gt=
; ce-&gt;tls_mtu)</span><br><span>         {</span><br><span>             m=
sg(M_WARN,</span><br><span>                 &quot;ERROR: tls-crypt-v2 clien=
t key too large to work with &quot;</span><br><span>                 &quot;=
requested --max-packet-size %d, requires at least &quot;</span><br><span>  =
               &quot;--max-packet-size %d=2E Packets will ignore requested =
&quot;</span><br><span>                 &quot;maximum packet size&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;op=
tions=2Ece=2Etls_mtu, required_size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                ce-&gt;tls_mtu, required_size);</span><br=
><span>         }</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+init_tls_wrap_ctx(struct tls_wra=
p_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  const st=
ruct key_schedule *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*tls_=
wrap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake authenticat=
ion (--tls-auth) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ce-&gt;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_wrap-&gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS h=
andshake encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file=
 &amp;&amp; tls_client))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
ls_wrap-&gt;mode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap=
-&gt;mode =3D=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx=
_bi =3D ks-&gt;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tls_wrap-&gt;opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;ori=
ginal_wrap_keydata =3D ks-&gt;original_wrap_keydata;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /*</span><br><span>  * Initialize the persistent compon=
ent of OpenVPN&#39;s TLS mode,</span><br><span>  * which is preserved acros=
s SIGUSR1 resets=2E</span><br><span>@@ -3143,7 +3167,7 @@</span><br><span> =
        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&g=
t;authname, warn);</span><br><span> </span><br><span>         /* initialize=
 tls-auth/crypt/crypt-v2 key */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        do_init_tls_wrap_key(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=
=2Ece);</span><br><span> </span><br><span>         /* initialise auth-token=
 crypto support */</span><br><span>         if (c-&gt;options=2Eauth_token_=
generate)</span><br><span>@@ -3168,7 +3192,7 @@</span><br><span>          *=
 tls-auth/crypt key can be configured per connection block, therefore</span=
><br><span>          * we must reload it as it may have changed</span><br><=
span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    do_init_tls_wrap_key(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=2Ece);</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -334=
9,24 +3373,8 @@</span><br><span>         to=2Eekm_size =3D 0;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* TLS handshake authentication (--tls-auth) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_auth_file)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Emode =3D TLS_=
WRAP_AUTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* TLS handshake encryption (--tls-crypt) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;c=
e=2Etls_crypt_file || (options-&gt;ce=2Etls_crypt_v2_file &amp;&amp; option=
s-&gt;tls_client))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wr=
ap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=2Etls_wrap=2Emode =
=3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =
=3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wra=
p=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel wrapping (--tls-au=
th / --tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=2Ece, options=
-&gt;tls_client, &amp;c-&gt;c1=2Eks);</span><br><span> </span><br><span>   =
  if (options-&gt;ce=2Etls_crypt_v2_file)</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><s=
pan>index c486158=2E=2Ed028280 100644</span><br><span>--- a/src/openvpn/ini=
t=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -73,6 +=
73,37 @@</span><br><span> </span><br><span> void do_test_crypto(struct cont=
ext *o);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief=
 Load the tls-auth/tls-crypt(-v2) key material into c-&gt;c1=2Eks=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Reads the key from the file configured=
 on connection entry ce (--tls-auth,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * --tls-crypt or --tls-crypt-v2); a no-op when none of th=
em is set=2E May be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * called more than once (the key can be configured per connection block, s=
o it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is reloaded =
for each connection)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c  =
The context whose c1=2Eks key schedule is populated=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param ce The connection entry whose =
tls-wrap key file is loaded=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
do_init_tls_wrap_key(struct context *c, const struct connection_entry *ce);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @brief Configure a control-channel wrapping context=
 from a connection entry</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *        and previously loaded tls-wrap key material=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or =
TLS_WRAP_CRYPT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (-=
-tls-crypt / client --tls-crypt-v2) and installs the key context, or</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * leaves it in TLS_WRAP_N=
ONE when neither is configured=2E The key material must</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * already have been loaded with do_ini=
t_tls_wrap_key()=2E tls-crypt-v2 specifics</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * (the wrapped client key and the server key) are l=
eft to the caller=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tls_wr=
ap   The wrapping context to configure=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param ce         The connection entry selecting t=
he wrapping mode=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param tls_client Whether this is a TLS client (selects tls-crypt-v2 mod=
e)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ks  =
       Key schedule holding the loaded tls-wrap key material=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(struct tls_wrap_ctx *tls=
_wrap, const struct connection_entry *ce,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       bool tls_client, const struct =
key_schedule *ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void context_gc_free(struct context *c);</span><br><span> =
</span><br><span> bool do_up(struct context *c, bool pulled_options, uint64=
_t option_types_found);</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546d=
a9ef06c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
33 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--IoyNYe93gSU=--


--===============0856610595394543354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0856610595394543354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0856610595394543354==--

