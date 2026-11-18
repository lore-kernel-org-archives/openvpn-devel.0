Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24D606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OQoIEqud;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G2CN38XS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e7uulAZL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V159R/Wu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l7E+0kbIY6gomSVTO/Yj9xM7EAltUxQU4ChAl+9b/yE=; b=OQoIEqud6s6ahnbveQZCp2DQEl
	QhU7hM9Oc5YMygu7WrwR069ngQwP2bRtVaeZrPc825SMyHH6r8hGTnrEXaSmkNqFvb9ffrew1PiO4
	srS/qrIqaRuuntw2A9SyDYAK9M8P7upqmzAxVF+5rk8FKwRet6PFWm6c5K1X0yPzP4f0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTj94-000000007my-024I;
	Wed, 18 Nov 2026 17:08:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTj91-000000007mp-1JzO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:08:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TJbMVPdTz1lohwvh+zWmlTu13iGslrAyqRjC+Okjm4=; b=G2CN38XShQlk3wpq3c843nqrp6
 b1cDKEwktchHd8KtU8AR4PZNaXVDj21eI2BfN96lfWZBViEzC+rrpRSaUx9b/FAZe3L6OK1M8sg6a
 POaEnLYgw38tWkGXD0kql7WmOTIIcUznxKz698b2eY7hUXJh5Go5caKPG6IFRmZvaa54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TJbMVPdTz1lohwvh+zWmlTu13iGslrAyqRjC+Okjm4=; b=e7uulAZLH/5JgDr2aeoyAVcis6
 9v3eYEhhAEzMEpx2MbecVmVknwDHIGOvM4gPnoSvejzAuFTHk90WuEQ5w+rfunazYPI6ADccGevvl
 kwXcyafoPmlg6/fNqoFE4T5fqclQO2HibGflxirI6FovIksbH0uNl0xU1ULWDe/pIctg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTj8x-0000000051G-0Uf5 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:08:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so7395695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021696; x=1795626496; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TJbMVPdTz1lohwvh+zWmlTu13iGslrAyqRjC+Okjm4=;
 b=V159R/WuNKmmO+rF1SRB5ur/kBcATf/8oJOm0vMCGx/ouoRpm43hrfBE0tQxoswC6K
 HvQztqzNH7+Vbn0ZI1OuJHd7SPzBxSEAvkMCeWQrCEGLaPrxJSWpZf5QqJrpbhN/1Lo+
 6FDZ10AgXK3ob5asmGuiXzCNrAwADACecI+5yIuKMqqdtYo/7mMCpN5rK3LTYvnv7L/l
 74LwZawmUVgPy4ZjDR5bDzWhkJ+G3wGdU/+hjng+M+Ed2UD2pj3trNn3gsqyXE/t4rlq
 q1NzKtPGEDiqS9Zbj+A7iOU237CPSxVe2PN3WeLE4QQsEmfIG3cCK08m6CTBmsAX/GjX
 /m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021696; x=1795626496;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4TJbMVPdTz1lohwvh+zWmlTu13iGslrAyqRjC+Okjm4=;
 b=l4sHVEwQt9stJKMpIV4Nz1iWEMoA32U4EebCGB50rK9JGM5kP56iRgafvz4e4JBHMh
 3FaCyRG8PCwoOSKqidLuYCpORyhf/A40OnK7T+rv4DS+O/tbRmEY6miJO9Ja0E96a94L
 kZhboljY5DvviY87XQlvrPidPdLhS26Z/1HAc8lohkwRTlGSJ7cnN21IMAKeYen5GYn0
 8MqoJXtXkmjsLvOILPIpvy0o2TeARQYqykc9dZIA6FhYt0LYrGMh4oeNXxe1l/AyaLpv
 rWjrhqTnRKhD/KyQKpMNo2XxpG4ebIb1RxRNkyMPHvyQXdriTqlcJmk8GuusdmND0VJ7
 4sAw==
X-Gm-Message-State: APuU4Z+Y4JdFQ06/uTPQtjginixBqTM0OxrswLMOQ9ktb0ZC5k07TAjK
 2a03rNn3oQ6MiA5DVBLUyWslp9Jei6tBBz/vKCQMZSoe2NBDcSDvuNdDUgM8NxM3/EIy65Mr6OW
 cobSRUdaVVIaOQvJqWHQQTDAG5Z2NQdJHxRKwOqLW4qR7fDU8XlbXtCG4s8DvCFIVQT1Z
X-Gm-Gg: AYBFou15hqxXEtzHFRdHZTxLzKf7KdK0n5MRDA08X1+fgH7ZRzuBOI4v0B9fA4ojXF1
 dg1XDziSHmXgKO9HPF9EiQ5NS49hit9ufvzhr21yrPKLEyQthx7Guh8VARXAAQOWX1iwsfrH+ZV
 pGnwU0Tkc4gN1Dkg+fU7/Gp127ciZ+a46V8hkVe5rLVMoHsJ/n4+Q2OjzNb3JuUSy7L2DqA/69g
 eYZsLNr9639mNa7a+ENlzfJjqmFnpS9CQAl5UPu20VrojV8jCdvALgsWDjTsUGJQZ83DY1Gdfe1
 uJHVWBy6MP+Cg0749ikddMKmZ5jxdsAMmlZWZzpRhUHoScV/zX2Jwo3cUNDYbVacST05En0nAI6
 /Q0QBHEyqcyISE6Sgd3CuM+EG7oJei8ZzoF6bQ1jFmN8RPlGPpfEkZIAccwNJD0Rgnac7xuCiUi
 6jVYR+PkbYuPx3P9Ii0u0JW8Y60BrbJwQCu1tOpVEKSzRn3jMgv9ee/TAcHI3NfxcWptB//whSS
 aCBnpj4qhOHrhy8B4mLKsbAnSGnP46IwVMkuC4i/WL4Q7JtFGt/e4dW1zwjOmsaZZGW4FqhWVYu
 +PE8nGwzQsUuGF1ltCfNnA3rqrVhBV1mJ4As8pso6uIRvUXfDpq+tYcKW3V4BaYnOi7U8utqfmG
 dLhCV4VmJss03oluP3lJRzjsVs3bEaaHAsDtpmODDAYJNTb9yXcubeytFY1qdvOgQi/duecoxel
 gXj/SyqMxu2XDIw2o=
X-Received: by 2002:a05:600c:3ac5:b0:4bb:7347:d5c0 with SMTP id
 5b1f17b1804b1-4bb7da0f906mr63875925e9.9.1795021696209; 
 Wed, 18 Nov 2026 09:08:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb83101f1esm4876245e9.0.2026.11.18.09.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:08:15 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:08:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 7804ba8b301e89c1727251a5ee3bf3f4ad5f55e7
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <773257ecf15feb5fd38f7bb48794592b6743d7c5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTj8x-0000000051G-0Uf5
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7499091733340764063=="
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7499091733340764063==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T+cwZoB2MzI="; charset=UTF-8

--T+cwZoB2MzI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, R=C4=83zvan Cojocaru, Steffan Karger=2E

Hello Antonio Quart=
ulli, Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru, Steffan Karger=
, 

I'd like you to reexamine a change=2E Please visit

    https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail

to look at the new patch set=
 (#3)=2E

The following approvals got outdated and were removed:
Code-Revie=
w+1 by R=C4=83zvan Cojocaru


Change subject: Keep the outgoing control pac=
ket in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Keep the outgoing control packet in a buffer owned b=
y tls_multi

tls_multi_process() returns the outgoing control packet in to_=
link=2E
Until now to_link pointed into memory owned by a session or key sta=
te:
the reliable send buffer, ks->ack_write_buf, or the tls_wrap or
tls_wra=
p_reneg work buffer=2E  When that session or key state was freed
or reset b=
efore the packet was written to the link, to_link was left
pointing to free=
d memory=2E  This caused CVE-2023-46850, CVE-2026-40215,
CVE-2026-12996, CV=
E-2026-13117 and CVE-2026-84471=2E

The fixes so far added check_session_bu=
f_not_used() and
check_keystate_buf_not_used(), which compare to_link again=
st a list of
the buffers of a session or key state before it is freed and d=
rop the
packet on a match=2E  This only works as long as the list names eve=
ry
buffer a packet can end up in and every caller that frees a session or
k=
ey state passes to_link down: key_state_soft_reset() is called without
it f=
rom tls_pre_decrypt() and tls_session_soft_reset()=2E

Fix the ownership in=
stead=2E  write_control_auth() now copies the
finished packet into a buffer=
 the caller owns, and tls_multi_process()
returns it in multi->to_link_buf,=
 which lives as long as the tls_multi,
like multi->to_link_addr already doe=
s for the address=2E  Freeing or
moving sessions and key states no longer a=
ffects a pending packet, so
the checks and the to_link parameters of key_st=
ate_free(),
tls_session_free(), move_session(), reset_session() and
key_sta=
te_soft_reset() are removed=2E  A packet that is pending when its
session i=
s freed is now sent instead of dropped; the peer handles it
like any late p=
acket of that session=2E

The copy costs one memcpy of a control channel pa=
cket=2E  The new unit
test checks that the packet written by write_control_=
auth() stays
intact and valid after the buffers it was built from are overw=
ritten,
with no wrapping, tls-auth and tls-crypt=2E

Change-Id: I379c36e155=
7178d22d3ee27cd6ed51b5c3a2e793
Signed-off-by: Alejandro Pacheco <alepacheco=
99@gmail=2Ecom>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M sr=
c/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/=
test_pkt=2Ec
5 files changed, 178 insertions(+), 147 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2002/3

diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index e06659a=2E=2Ec811e=
84 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -98,14 +98=
,6 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
-/* forward decle=
ration since tls_process needs this function prototype */
-static void
-che=
ck_session_buf_not_used(struct buffer *to_link, struct tls_session *session=
);
-
-static void
-check_keystate_buf_not_used(struct buffer *to_link, cons=
t struct key_state *ks);
-
-
 /**
  * Limit the reneg_bytes value when usin=
g a small-block (<128 bytes) cipher=2E
  *
@@ -918,15 +910,10 @@
  *       =
                cleaned up=2E
  * @param clear        - Whether the memory =
allocated for the \a ks object
  *                       should be overwrit=
ten with 0s=2E
- *
- * @param to_link      - if not NULL, check that the bu=
ffer does not contain
- *                       any pointer to one of the i=
nternal structs of ks
  */
 static void
-key_state_free(struct key_state *k=
s, bool clear, struct buffer *to_link)
+key_state_free(struct key_state *ks=
, bool clear)
 {
-    check_keystate_buf_not_used(to_link, ks);
-
     ks->=
state =3D S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1075,14 +106=
2,10 @@
  *                       object should be overwritten with 0s=2E T=
his
  *                       implicitly sets many states to 0/false,
  *  =
                     e=2Eg=2E the validity of the keys in the structure
- *=
 @param to_link      - if not NULL, check that the buffer does not contain
=
- *                       any pointer to one of the internal structs of ks
=
- *
  */
 static void
-tls_session_free(struct tls_session *session, bool c=
lear, struct buffer *to_link)
+tls_session_free(struct tls_session *session=
, bool clear)
 {
-    check_session_buf_not_used(to_link, session);
     tl=
s_wrap_free(&session->tls_wrap);
     tls_wrap_free(&session->tls_wrap_rene=
g);
 
@@ -1091,7 +1074,7 @@
         /* we don't need clear=3Dtrue for this=
 call since
          * the structs are part of session and get cleared
   =
       * as part of session */
-        key_state_free(&session->key[i], fa=
lse, to_link);
+        key_state_free(&session->key[i], false);
     }
 
 =
    free(session->common_name);
@@ -1110,16 +1093,14 @@
 
 
 static void
-m=
ove_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
- =
            struct buffer *to_link)
+move_session(struct tls_multi *multi, =
int dest, int src, bool reinit_src)
 {
-    check_session_buf_not_used(to_l=
ink, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: =
dest=3D%s src=3D%s reinit_src=3D%d",
         session_index_name(dest), ses=
sion_index_name(src), reinit_src);
     ASSERT(src !=3D dest);
     ASSERT(=
src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-=
    tls_session_free(&multi->session[dest], false, to_link);
+    tls_sessi=
on_free(&multi->session[dest], false);
     multi->session[dest] =3D multi-=
>session[src];
 
     if (reinit_src)
@@ -1135,9 +1116,9 @@
 }
 
 static vo=
id
-reset_session(struct tls_multi *multi, struct tls_session *session, str=
uct buffer *to_link)
+reset_session(struct tls_multi *multi, struct tls_ses=
sion *session)
 {
-    tls_session_free(session, false, to_link);
+    tls_=
session_free(session, false);
     tls_session_init(multi, session);
 }
 
@=
@ -1211,6 +1192,8 @@
 tls_multi_init_finalize(struct tls_multi *multi, int =
tls_mtu)
 {
     tls_init_control_channel_frame_parameters(&multi->opt=2Efr=
ame, tls_mtu);
+    multi->to_link_buf =3D alloc_buf((size_t)BUF_SIZE(&mult=
i->opt=2Eframe));
+
     /* initialize the active and untrusted sessions */=

 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
@@ -1303,9 +12=
86,11 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
     {
-        tls_ses=
sion_free(&multi->session[i], false, NULL);
+        tls_session_free(&mult=
i->session[i], false);
     }
 
+    free_buf(&multi->to_link_buf);
+
     =
if (clear)
     {
         secure_memzero(multi, sizeof(*multi));
@@ -1841,=
13 +1826,13 @@
  * active key=2E
  */
 static void
-key_state_soft_reset(st=
ruct tls_session *session, struct buffer *to_link)
+key_state_soft_reset(st=
ruct tls_session *session)
 {
     struct key_state *ks =3D &session->key[K=
S_PRIMARY];        /* primary key */
     struct key_state *ks_lame =3D &se=
ssion->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die =3D now + =
session->opt->transition_window;    /* remaining lifetime of old key */
-  =
  key_state_free(ks_lame, false, to_link);
+    key_state_free(ks_lame, fal=
se);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@ -1858,7 =
+1843,7 @@
 void
 tls_session_soft_reset(struct tls_multi *tls_multi)
 {
- =
   key_state_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
+    key_sta=
te_soft_reset(&tls_multi->session[TM_ACTIVE]);
 }
 
 /*
@@ -2941,18 +2926,1=
5 @@
 
         const struct buffer *buf =3D reliable_send(ks->send_reliabl=
e, &opcode);
         ASSERT(buf);
-        struct buffer b =3D *buf;
     =
    INCR_SENT;
 
-        write_control_auth(session, ks, &b, to_link_addr,=
 opcode, CONTROL_SEND_ACK_MAX, true);
-        *to_link =3D b;
+        wri=
te_control_auth(session, ks, buf, &multi->to_link_buf, to_link_addr, opcode=
,
+                           CONTROL_SEND_ACK_MAX, true);
+        *to_lin=
k =3D multi->to_link_buf;
         dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP")=
;
 
-        /* This changed the state of the outgoing buffer=2E In order t=
o avoid
-         * running this function again/further and invalidating th=
e key_state
-         * buffer and accessing the buffer that is now in to_l=
ink after it being
-         * freed for a potential error, we shortcircuit=
 exiting of the outer
-         * process here=2E */
+        /* This chang=
ed the state of the outgoing buffer=2E Stop this
+         * processing pas=
s so that the event loop can send the packet=2E */
         return false;
 =
    }
 
@@ -3192,13 +3174,13 @@
             session->opt->aead_usage_limit=
,
             ks->crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks=
 + ks->n_packets,
             session->opt->aead_usage_limit);
-        ke=
y_state_soft_reset(session, to_link);
+        key_state_soft_reset(session=
);
     }
 
     /* Kill lame duck key transition_window seconds after prim=
ary key negotiation */
     if (lame_duck_must_die(session, wakeup))
     {=

-        key_state_free(ks_lame, true, to_link);
+        key_state_free(k=
s_lame, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expi=
ring key");
     }
 
@@ -3247,8 +3229,9 @@
         {
             struct b=
uffer buf =3D ks->ack_write_buf;
             ASSERT(buf_init(&buf, multi->=
opt=2Eframe=2Ebuf=2Eheadroom));
-            write_control_auth(session, ks=
, &buf, to_link_addr, P_ACK_V1, RELIABLE_ACK_SIZE, false);
-            *to=
_link =3D buf;
+            write_control_auth(session, ks, &buf, &multi->t=
o_link_buf, to_link_addr, P_ACK_V1,
+                               RELIABL=
E_ACK_SIZE, false);
+            *to_link =3D multi->to_link_buf;
         =
    dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
         }
     }
@@ -32=
91,98 +3274,6 @@
     return false;
 }
 
-static void
-check_keystate_buf_n=
ot_used(struct buffer *to_link, const struct key_state *ks)
-{
-    if (ks-=
>state =3D=3D S_UNDEF || !to_link || !to_link->data)
-    {
-        return=
;
-    }
-
-    const uint8_t *dataptr =3D to_link->data;
-
-    /* we don'=
t expect send_reliable to be NULL when state is
-     * not S_UNDEF, but pe=
ople have reported crashes nonetheless,
-     * therefore we better catch t=
his event, report and exit=2E
-     */
-    if (!ks->send_reliable)
-    {
=
-        msg(M_FATAL,
-            "ERROR: ks=2Esend_reliable (key-id %d), =
is NULL "
-            "while key state is %s=2E Exiting=2E",
-            =
ks->key_id, state_name(ks->state));
-    }
-
-    for (int j =3D 0; j < ks-=
>send_reliable->size; j++)
-    {
-        if (ks->send_reliable->array[j]=
=2Ebuf=2Edata =3D=3D dataptr)
-        {
-            msg(M_INFO,
-        =
        "Warning buffer of freed TLS session is still in"
-                =
" use (key-id %d, ks=2Esend_reliable->array[%d])",
-                ks->key=
_id, j);
-
-            goto used;
-        }
-    }
-
-    if (ks->ack_wri=
te_buf=2Edata =3D=3D dataptr)
-    {
-        msg(M_INFO, "Warning buffer o=
f freed TLS session is still in use "
-                    "(ks=2Eack_write=
_buf, key-id %d)",
-            ks->key_id);
-
-        goto used;
-    }
-=
    return;
-
-used:
-    to_link->len =3D 0;
-    to_link->data =3D 0;
-}
=
-
-/**
- * This is a safe guard function to double check that a buffer from=
 a session is
- * not used in a session to avoid a use after free=2E
- *
- =
* @param to_link
- * @param session
- */
-static void
-check_session_buf_no=
t_used(struct buffer *to_link, struct tls_session *session)
-{
-    if (!to=
_link || !to_link->data)
-    {
-        return;
-    }
-    const uint8_t =
*dataptr =3D to_link->data;
-
-    /* Checks buffers in tls_wrap */
-    if=
 (session->tls_wrap=2Ework=2Edata =3D=3D dataptr)
-    {
-        msg(M_INF=
O, "Warning buffer of freed TLS session is "
-                    "still in=
 use (tls_wrap=2Ework=2Edata)");
-        goto used;
-    }
-    if (sessio=
n->tls_wrap_reneg=2Ework=2Edata =3D=3D dataptr)
-    {
-        msg(M_INFO,=
 "Warning buffer of freed TLS session is "
-                    "still in u=
se (tls_wrap_reneg=2Ework=2Edata)");
-        goto used;
-    }
-
-    for =
(int i =3D 0; i < KS_SIZE; i++)
-    {
-        const struct key_state *ks =
=3D &session->key[i];
-        check_keystate_buf_not_used(to_link, ks);
- =
   }
-    return;
-
-used:
-    to_link->len =3D 0;
-    to_link->data =3D =
0;
-    /* for debugging, you can add an ASSERT(0); here to trigger an abor=
t */
-}
 /*
  * Called by the top-level event loop=2E
  *
@@ -3471,11 +3362=
,11 @@
                 if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D S_GEN=
ERATED_KEYS
                     && !multi->opt=2Esingle_session)
         =
        {
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE,=
 true, to_link);
+                    move_session(multi, TM_LAME_DUCK, TM_=
ACTIVE, true);
                 }
                 else
                 {
=
-                    reset_session(multi, session, to_link);
+             =
       reset_session(multi, session);
                 }
             }
   =
      }
@@ -3538,7 +3429,7 @@
      */
     if (lame_duck_must_die(&multi->=
session[TM_LAME_DUCK], wakeup))
     {
-        tls_session_free(&multi->se=
ssion[TM_LAME_DUCK], true, to_link);
+        tls_session_free(&multi->sess=
ion[TM_LAME_DUCK], true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_pro=
cess: killed expiring key");
     }
 
@@ -3553,7 +3444,7 @@
      */
     i=
f (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))=

     {
-        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);=

+        move_session(multi, TM_ACTIVE, TM_INITIAL, true);
         tas =
=3D tls_authentication_status(multi);
         msg(D_TLS_DEBUG_LOW,
       =
      "TLS: tls_multi_process: initial untrusted "
@@ -4038,7 +3929,7 @@
  =
               goto done;
             }
 
-            key_state_soft_rese=
t(session, NULL);
+            key_state_soft_reset(session);
 
           =
  dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s"=
, i,
                  session_id_print(&sid, &gc));
diff --git a/src/openv=
pn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 436770b=2E=2Ecf22be5 1=
00644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ =
-635,6 +635,14 @@
      */
     struct link_socket_actual to_link_addr;
 
+=
    /**
+     * Holds the outgoing control packet returned by tls_multi_pro=
cess=2E
+     * It belongs to the tls_multi and not to a session or key sta=
te, so
+     * it stays valid when these are freed or moved before the pack=
et is
+     * written to the link=2E
+     */
+    struct buffer to_link_bu=
f;
+
     int n_sessions; /**< Number of sessions negotiated thus
         =
             *   far=2E */
     enum multi_status multi_state;
diff --git a=
/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index dad58c3=2E=2Ef843d=
af 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -1=
69,10 +169,14 @@
 }
 
 void
-write_control_auth(struct tls_session *session=
, struct key_state *ks, struct buffer *buf,
-                   struct link=
_socket_actual **to_link_addr, int opcode, int max_ack,
-                  =
 bool prepend_ack)
+write_control_auth(struct tls_session *session, struct =
key_state *ks, const struct buffer *payload,
+                   struct buf=
fer *out, struct link_socket_actual **to_link_addr, int opcode,
+          =
         int max_ack, bool prepend_ack)
 {
+    /* Work on a copy so that t=
ls_wrap_control can point it at another
+     * buffer without modifying th=
e caller's buffer */
+    struct buffer buf =3D *payload;
+
     ASSERT(ks-=
>key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0=
 && opcode <=3D P_LAST_OPCODE);
     uint8_t header =3D (uint8_t)(ks->key_i=
d | (opcode << P_OPCODE_SHIFT));
@@ -187,14 +191,20 @@
     }
 
     ASSERT=
(link_socket_actual_defined(&ks->remote_addr));
-    ASSERT(reliable_ack_wr=
ite(ks->rec_ack, ks->lru_acks, buf, &ks->session_id_remote, max_ack,
+    A=
SSERT(reliable_ack_write(ks->rec_ack, ks->lru_acks, &buf, &ks->session_id_r=
emote, max_ack,
                               prepend_ack));
 
     msg(D_=
TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
 
-    tls_wr=
ap_control(tls_session_get_tls_wrap(session, ks->key_id), header, buf,
+   =
 tls_wrap_control(tls_session_get_tls_wrap(session, ks->key_id), header, &b=
uf,
                      &session->session_id);
 
+    /* buf now points i=
nto memory owned by ks or session (the payload's
+     * buffer or the tls_=
wrap work buffer)=2E  Either can be freed before
+     * the packet is writ=
ten to the link, so copy the packet to out=2E */
+    ASSERT(buf_init(out, =
buf=2Eoffset));
+    ASSERT(buf_copy(out, &buf));
+
     *to_link_addr =3D =
&ks->remote_addr;
 }
 
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/s=
sl_pkt=2Eh
index 218c6bb=2E=2Ef04fea84 100644
--- a/src/openvpn/ssl_pkt=2Eh=

+++ b/src/openvpn/ssl_pkt=2Eh
@@ -185,10 +185,29 @@
 bool check_session_hm=
ac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_soc=
kaddr *from,
                                    const uint8_t *key, int ha=
ndwindow, bool pkt_is_ack);
 
-/*
- * Write a control channel authenticatio=
n record=2E
+/**
+ * Write a control channel packet: add the ACKs, the opco=
de and session id
+ * header and the tls-auth/tls-crypt wrapping to \c payl=
oad=2E
+ *
+ * @param session           the TLS session the packet belongs =
to
+ * @param ks                the key state the packet belongs to
+ * @pa=
ram payload           the packet payload=2E Its data is left
+ *           =
               unchanged, but the space around it in its
+ *               =
           buffer is used to build the packet=2E
+ * @param out            =
   buffer the finished packet is written to, at
+ *                        =
  the offset it was built at=2E It must be owned
+ *                       =
   by the caller, not share memory with \c payload
+ *                     =
     or the tls_wrap work buffers, and have room for
+ *                   =
       the packet at that offset (a buffer of
+ *                          =
BUF_SIZE() of the session's frame does)=2E
+ * @param to_link_addr      set=
 to the address the packet is sent to
+ * @param opcode            opcode o=
f the packet
+ * @param max_ack           maximum number of ACKs to add
+ *=
 @param prepend_ack       add the ACKs in front of the payload instead
+ * =
                         of writing them into it
  */
-void write_control_a=
uth(struct tls_session *session, struct key_state *ks, struct buffer *buf,
=
+void write_control_auth(struct tls_session *session, struct key_state *ks,=

+                        const struct buffer *payload, struct buffer *out,=

                         struct link_socket_actual **to_link_addr, int opc=
ode, int max_ack,
                         bool prepend_ack);
 
diff --git =
a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec
index f34bd41=2E=2E36dec3f 100644
--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -783,6 +783,108 @@
 =
    free_tas(&tas);
 }
 
+/* write_control_auth() writes the finished packe=
t to the out buffer of the
+ * caller, so the packet stays valid when the b=
uffers of the session and key
+ * state are reused or freed before it is se=
nt=2E */
+static void
+check_write_control_auth_out_buf(struct tls_wrap_ctx=
 *wrap, struct tls_wrap_ctx *peer_wrap)
+{
+    struct tls_options opt =3D =
{ 0 };
+    opt=2Eserver =3D true;
+
+    struct tls_session session =3D { =
0 };
+    session=2Eopt =3D &opt;
+    session=2Etls_wrap =3D *wrap;
+    s=
ession=2Esession_id =3D (struct session_id){ { 1, 2, 3, 4, 5, 6, 7, 8 } };
=
+
+    struct reliable_ack rec_ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 7=
 } };
+    struct reliable_ack lru_acks =3D { 0 };
+    struct key_state ks=
 =3D { 0 };
+    ks=2Erec_ack =3D &rec_ack;
+    ks=2Elru_acks =3D &lru_ack=
s;
+    ks=2Esession_id_remote =3D (struct session_id){ { 8, 7, 6, 5, 4, 3,=
 2, 1 } };
+    ks=2Eremote_addr=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET=
;
+    ks=2Eremote_addr=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(0=
x01020304);
+
+    const uint8_t data[] =3D "control channel payload";
+   =
 struct buffer payload =3D alloc_buf(1600);
+    struct buffer out =3D allo=
c_buf(1600);
+
+    /* a control packet with the ACK in front of its payloa=
d, as sent from
+     * the reliability layer, and a dedicated ACK packet *=
/
+    for (int i =3D 0; i < 2; i++)
+    {
+        const bool dedicated_a=
ck =3D (i =3D=3D 1);
+        const size_t len =3D dedicated_ack ? 0 : size=
of(data);
+
+        assert_true(buf_init(&payload, 200));
+        assert_=
true(buf_write(&payload, data, len));
+
+        struct link_socket_actual =
*to_link_addr =3D NULL;
+        write_control_auth(&session, &ks, &payload=
, &out, &to_link_addr,
+                           dedicated_ack ? P_ACK_V1=
 : P_CONTROL_V1, RELIABLE_ACK_SIZE,
+                           !dedicated_=
ack);
+
+        assert_ptr_equal(to_link_addr, &ks=2Eremote_addr);
+      =
  assert_int_equal(BLEN(&payload), len);
+        assert_memory_equal(BPTR(=
&payload), data, len);
+        assert_true(BLENZ(&out) > len);
+
+        =
/* the packet is still intact after the session buffers are overwritten */
=
+        memset(payload=2Edata, 0x55, (size_t)payload=2Ecapacity);
+       =
 if (session=2Etls_wrap=2Ework=2Edata)
+        {
+            memset(sessi=
on=2Etls_wrap=2Ework=2Edata, 0x55, (size_t)session=2Etls_wrap=2Ework=2Ecapa=
city);
+        }
+
+        struct link_socket_actual from =3D { 0 };
+   =
     assert_true(read_control_auth(&out, peer_wrap, &from, &opt));
+
+     =
   struct reliable_ack ack;
+        struct session_id sid;
+        assert=
_true(reliable_ack_parse(&out, &ack, &sid));
+        assert_int_equal(ack=
=2Elen, 1);
+        assert_int_equal(ack=2Epacket_id[0], 7);
+        asse=
rt_memory_equal(&sid, &ks=2Esession_id_remote, SID_SIZE);
+        assert_i=
nt_equal(BLEN(&out), len);
+        assert_memory_equal(BPTR(&out), data, l=
en);
+    }
+
+    free_buf(&out);
+    free_buf(&payload);
+}
+
+static vo=
id
+test_write_control_auth_out_buf(void **ut_state)
+{
+    now =3D 0x2244=
6688;
+
+    struct tls_wrap_ctx none =3D { =2Emode =3D TLS_WRAP_NONE };
+ =
   check_write_control_auth_out_buf(&none, &none);
+
+    struct tls_auth_s=
tandalone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);
+    struct =
tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);
+  =
  packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST"=
, 0);
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "=
UNITTEST", 0);
+    reset_packet_id_send(&tas_client=2Etls_wrap=2Eopt=2Epac=
ket_id=2Esend);
+    check_write_control_auth_out_buf(&tas_client=2Etls_wra=
p, &tas_server=2Etls_wrap);
+    packet_id_free(&tas_client=2Etls_wrap=2Eop=
t=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_i=
d);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+
+    tas_clie=
nt =3D init_tas_crypt(false);
+    tas_server =3D init_tas_crypt(true);
+  =
  packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST"=
, 0);
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "=
UNITTEST", 0);
+    reset_packet_id_send(&tas_client=2Etls_wrap=2Eopt=2Epac=
ket_id=2Esend);
+    check_write_control_auth_out_buf(&tas_client=2Etls_wra=
p, &tas_server=2Etls_wrap);
+    packet_id_free(&tas_client=2Etls_wrap=2Eop=
t=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_i=
d);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
 static vo=
id
 test_extract_control_message(void **ut_state)
 {
@@ -835,6 +937,7 @@
  =
       cmocka_unit_test(test_generate_reset_packet_resend_wkc),
         cm=
ocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_t=
est(test_wkc_not_appended_without_key),
+        cmocka_unit_test(test_writ=
e_control_auth_out_buf),
         cmocka_unit_test(test_extract_control_mes=
sage),
         cmocka_unit_test(test_tlv_write_u16_wire_format),
         =
cmocka_unit_test(test_tlv_header_roundtrip),

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Ge=
rrit-Change-Number: 2002
Gerrit-PatchSet: 3
Gerrit-Owner: Alejandro <alepac=
heco99@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <s=
teffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
G=
errit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attent=
ion: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@licht=
enheld=2Ecom>

--T+cwZoB2MzI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, R=
=C4=83zvan Cojocaru, Steffan Karger=2E </p>
<p>Alejandro <strong>uploaded p=
atch set #3</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan Co=
jocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Keep the outgoing control packet in a buffer owned =
by tls_multi<br><br>tls_multi_process() returns the outgoing control packet=
 in to_link=2E<br>Until now to_link pointed into memory owned by a session =
or key state:<br>the reliable send buffer, ks-&gt;ack_write_buf, or the tls=
_wrap or<br>tls_wrap_reneg work buffer=2E  When that session or key state w=
as freed<br>or reset before the packet was written to the link, to_link was=
 left<br>pointing to freed memory=2E  This caused CVE-2023-46850, CVE-2026-=
40215,<br>CVE-2026-12996, CVE-2026-13117 and CVE-2026-84471=2E<br><br>The f=
ixes so far added check_session_buf_not_used() and<br>check_keystate_buf_no=
t_used(), which compare to_link against a list of<br>the buffers of a sessi=
on or key state before it is freed and drop the<br>packet on a match=2E  Th=
is only works as long as the list names every<br>buffer a packet can end up=
 in and every caller that frees a session or<br>key state passes to_link do=
wn: key_state_soft_reset() is called without<br>it from tls_pre_decrypt() a=
nd tls_session_soft_reset()=2E<br><br>Fix the ownership instead=2E  write_c=
ontrol_auth() now copies the<br>finished packet into a buffer the caller ow=
ns, and tls_multi_process()<br>returns it in multi-&gt;to_link_buf, which l=
ives as long as the tls_multi,<br>like multi-&gt;to_link_addr already does =
for the address=2E  Freeing or<br>moving sessions and key states no longer =
affects a pending packet, so<br>the checks and the to_link parameters of ke=
y_state_free(),<br>tls_session_free(), move_session(), reset_session() and<=
br>key_state_soft_reset() are removed=2E  A packet that is pending when its=
<br>session is freed is now sent instead of dropped; the peer handles it<br=
>like any late packet of that session=2E<br><br>The copy costs one memcpy o=
f a control channel packet=2E  The new unit<br>test checks that the packet =
written by write_control_auth() stays<br>intact and valid after the buffers=
 it was built from are overwritten,<br>with no wrapping, tls-auth and tls-c=
rypt=2E<br><br>Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793<br>Sign=
ed-off-by: Alejandro Pacheco &lt;alepacheco99@gmail=2Ecom&gt;<br>---<br>M s=
rc/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_pkt=
=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2E=
c<br>5 files changed, 178 insertions(+), 147 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
02/2002/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</s=
pan><br><span>index e06659a=2E=2Ec811e84 100644</span><br><span>--- a/src/o=
penvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@=
 -98,14 +98,6 @@</span><br><span> </span><br><span> #endif /* ifdef MEASURE=
_TLS_HANDSHAKE_STATS */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* forward decleration since tls_process needs this fun=
ction prototype */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session=
_buf_not_used(struct buffer *to_link, struct tls_session *session);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-check_keystate_buf_not_used(struct buffer *to_link, const st=
ruct key_state *ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**<=
/span><br><span>  * Limit the reneg_bytes value when using a small-block (&=
lt;128 bytes) cipher=2E</span><br><span>  *</span><br><span>@@ -918,15 +910=
,10 @@</span><br><span>  *                       cleaned up=2E</span><br><s=
pan>  * @param clear        - Whether the memory allocated for the \a ks ob=
ject</span><br><span>  *                       should be overwritten with 0=
s=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param to_link      - if not NULL=
, check that the buffer does not contain</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *                       any pointer to one of the inter=
nal structs of ks</span><br><span>  */</span><br><span> static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_sta=
te *ks, bool clear, struct buffer *to_link)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+key_state_free(struct key_state *ks, bool clear)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
heck_keystate_buf_not_used(to_link, ks);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><b=
r><span> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</spa=
n><br><span>@@ -1075,14 +1062,10 @@</span><br><span>  *                    =
   object should be overwritten with 0s=2E This</span><br><span>  *        =
               implicitly sets many states to 0/false,</span><br><span>  * =
                      e=2Eg=2E the validity of the keys in the structure</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param to_link      -=
 if not NULL, check that the buffer does not contain</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *                       any pointer to one=
 of the internal structs of ks</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span>  */</span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-tls_session_free(struct tls_session=
 *session, bool clear, struct buffer *to_link)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+tls_session_free(struct tls_session *session, bo=
ol clear)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    check_session_buf_not_used(to_link, session);</span><br><span>  =
   tls_wrap_free(&amp;session-&gt;tls_wrap);</span><br><span>     tls_wrap_=
free(&amp;session-&gt;tls_wrap_reneg);</span><br><span> </span><br><span>@@=
 -1091,7 +1074,7 @@</span><br><span>         /* we don&#39;t need clear=3Dt=
rue for this call since</span><br><span>          * the structs are part of=
 session and get cleared</span><br><span>          * as part of session */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free=
(&amp;session-&gt;key[i], false, to_link);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        key_state_free(&amp;session-&gt;key[i], fals=
e);</span><br><span>     }</span><br><span> </span><br><span>     free(sess=
ion-&gt;common_name);</span><br><span>@@ -1110,16 +1093,14 @@</span><br><sp=
an> </span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-move_session(struct tls_multi *multi, int d=
est, int src, bool reinit_src,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             struct buffer *to_link)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+move_session(struct tls_multi *multi, int dest, i=
nt src, bool reinit_src)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    check_session_buf_not_used(to_link, &amp;multi-&g=
t;session[dest]);</span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move=
_session: dest=3D%s src=3D%s reinit_src=3D%d&quot;,</span><br><span>       =
  session_index_name(dest), session_index_name(src), reinit_src);</span><br=
><span>     ASSERT(src !=3D dest);</span><br><span>     ASSERT(src &gt;=3D =
0 &amp;&amp; src &lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt;=3D 0 =
&amp;&amp; dest &lt; TM_SIZE);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    tls_session_free(&amp;multi-&gt;session[dest], false, to_link)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_fr=
ee(&amp;multi-&gt;session[dest], false);</span><br><span>     multi-&gt;ses=
sion[dest] =3D multi-&gt;session[src];</span><br><span> </span><br><span>  =
   if (reinit_src)</span><br><span>@@ -1135,9 +1116,9 @@</span><br><span> }=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-reset_session(struct tls_multi *multi, struct tls=
_session *session, struct buffer *to_link)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+reset_session(struct tls_multi *multi, struct tls_se=
ssion *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    tls_session_free(session, false, to_link);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(session, false=
);</span><br><span>     tls_session_init(multi, session);</span><br><span> =
}</span><br><span> </span><br><span>@@ -1211,6 +1192,8 @@</span><br><span> =
tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)</span><br><sp=
an> {</span><br><span>     tls_init_control_channel_frame_parameters(&amp;m=
ulti-&gt;opt=2Eframe, tls_mtu);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi-&gt;to_link_buf =3D alloc_buf((size_t)BUF_SIZE(&amp;m=
ulti-&gt;opt=2Eframe));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     /* initialize the active and untrusted sessions *=
/</span><br><span> </span><br><span>     tls_session_init(multi, &amp;multi=
-&gt;session[TM_ACTIVE]);</span><br><span>@@ -1303,9 +1286,11 @@</span><br>=
<span> </span><br><span>     for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  tls_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi=
-&gt;session[i], false);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;multi-&gt;t=
o_link_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (clear)</span><br><span>     {</span><br><span>         s=
ecure_memzero(multi, sizeof(*multi));</span><br><span>@@ -1841,13 +1826,13 =
@@</span><br><span>  * active key=2E</span><br><span>  */</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_=
soft_reset(struct tls_session *session, struct buffer *to_link)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls=
_session *session)</span><br><span> {</span><br><span>     struct key_state=
 *ks =3D &amp;session-&gt;key[KS_PRIMARY];        /* primary key */</span><=
br><span>     struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DU=
CK]; /* retiring key */</span><br><span> </span><br><span>     ks-&gt;must_=
die =3D now + session-&gt;opt-&gt;transition_window;    /* remaining lifeti=
me of old key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    k=
ey_state_free(ks_lame, false, to_link);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    key_state_free(ks_lame, false);</span><br><span>   =
  *ks_lame =3D *ks;</span><br><span> </span><br><span>     key_state_init(s=
ession, ks);</span><br><span>@@ -1858,7 +1843,7 @@</span><br><span> void</s=
pan><br><span> tls_session_soft_reset(struct tls_multi *tls_multi)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_sta=
te_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_reset(&amp;tls_m=
ulti-&gt;session[TM_ACTIVE]);</span><br><span> }</span><br><span> </span><b=
r><span> /*</span><br><span>@@ -2941,18 +2926,15 @@</span><br><span> </span=
><br><span>         const struct buffer *buf =3D reliable_send(ks-&gt;send_=
reliable, &amp;opcode);</span><br><span>         ASSERT(buf);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct buffer b =3D *buf;</=
span><br><span>         INCR_SENT;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        write_control_auth(session, ks, &am=
p;b, to_link_addr, opcode, CONTROL_SEND_ACK_MAX, true);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        *to_link =3D b;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        write_control_auth(session, k=
s, buf, &amp;multi-&gt;to_link_buf, to_link_addr, opcode,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           CONTROL_SE=
ND_ACK_MAX, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *to_link =3D multi-&gt;to_link_buf;</span><br><span>         dmsg(D_=
TLS_DEBUG, &quot;Reliable -&gt; TCP/UDP&quot;);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /* This changed the sta=
te of the outgoing buffer=2E In order to avoid</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * running this function again/further and=
 invalidating the key_state</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * buffer and accessing the buffer that is now in to_link aft=
er it being</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 freed for a potential error, we shortcircuit exiting of the outer</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         * process here=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This chan=
ged the state of the outgoing buffer=2E Stop this</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * processing pass so that the event =
loop can send the packet=2E */</span><br><span>         return false;</span=
><br><span>     }</span><br><span> </span><br><span>@@ -3192,13 +3174,13 @@=
</span><br><span>             session-&gt;opt-&gt;aead_usage_limit,</span><=
br><span>             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaint=
ext_blocks + ks-&gt;n_packets,</span><br><span>             session-&gt;opt=
-&gt;aead_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        key_state_soft_reset(session, to_link);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        key_state_soft_reset(session);</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Kill lame duck k=
ey transition_window seconds after primary key negotiation */</span><br><sp=
an>     if (lame_duck_must_die(session, wakeup))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks=
_lame, true, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        key_state_free(ks_lame, true);</span><br><span>         msg(D_TL=
S_DEBUG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br>=
<span>     }</span><br><span> </span><br><span>@@ -3247,8 +3229,9 @@</span>=
<br><span>         {</span><br><span>             struct buffer buf =3D ks-=
&gt;ack_write_buf;</span><br><span>             ASSERT(buf_init(&amp;buf, m=
ulti-&gt;opt=2Eframe=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            write_control_auth(session, ks, &amp;buf, to=
_link_addr, P_ACK_V1, RELIABLE_ACK_SIZE, false);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            *to_link =3D buf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            write_control_auth(session=
, ks, &amp;buf, &amp;multi-&gt;to_link_buf, to_link_addr, P_ACK_V1,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
    RELIABLE_ACK_SIZE, false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            *to_link =3D multi-&gt;to_link_buf;</span><br><span>=
             dmsg(D_TLS_DEBUG, &quot;Dedicated ACK -&gt; TCP/UDP&quot;);</s=
pan><br><span>         }</span><br><span>     }</span><br><span>@@ -3291,98=
 +3274,6 @@</span><br><span>     return false;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_keystate_buf_not_=
used(struct buffer *to_link, const struct key_state *ks)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-=
&gt;data)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* we don&#39;t expect send_reliable to be NULL when state i=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * not S_UNDEF, =
but people have reported crashes nonetheless,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * therefore we better catch this event, report=
 and exit=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ks-&gt;send_re=
liable)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;ERROR: ks=2Es=
end_reliable (key-id %d), is NULL &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;while key state is %s=2E Exiting=2E&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ks-&g=
t;key_id, state_name(ks-&gt;state));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int j =3D 0; =
j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D data=
ptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Warni=
ng buffer of freed TLS session is still in&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                &quot; use (key-id %d, ks=2Esend=
_reliable-&gt;array[%d])&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                ks-&gt;key_id, j);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            goto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (ks-&gt;ack_write_buf=2Edata =3D=3D dat=
aptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warnin=
g buffer of freed TLS session is still in use &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;(ks=2Eack_write_b=
uf, key-id %d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            ks-&gt;key_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto us=
ed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-used:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    t=
o_link-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    to_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * This is a safe guard function to double check that=
 a buffer from a session is</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * not used in a session to avoid a use after free=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param to_link</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param session</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session_buf=
_not_used(struct buffer *to_link, struct tls_session *session)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!to_link || !to_link-&gt;data)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* Checks buffers in tls_wrap */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D data=
ptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warning=
 buffer of freed TLS session is &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    &quot;still in use (tls_wrap=2Ework=2E=
data)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
goto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (session-&gt;tls_wra=
p_reneg=2Ework=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_INFO, &quot;Warning buffer of freed TLS session is &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot=
;still in use (tls_wrap_reneg=2Ework=2Edata)&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        goto used;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        check_keystate_buf_not_used(=
to_link, ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-used:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    to_link-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    to_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* for debugging, you can add an ASSERT(0); here to trig=
ger an abort */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span> /*</span><br><span>  * Called by the top-level event loop=2E</=
span><br><span>  *</span><br><span>@@ -3471,11 +3362,11 @@</span><br><span>=
                 if (i =3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=
=3D S_GENERATED_KEYS</span><br><span>                     &amp;&amp; !multi=
-&gt;opt=2Esingle_session)</span><br><span>                 {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    move_session(mu=
lti, TM_LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    move_session(multi, TM_LAME_D=
UCK, TM_ACTIVE, true);</span><br><span>                 }</span><br><span> =
                else</span><br><span>                 {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    reset_session(multi, =
session, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   reset_session(multi, session);</span><br><span>         =
        }</span><br><span>             }</span><br><span>         }</span><=
br><span>@@ -3538,7 +3429,7 @@</span><br><span>      */</span><br><span>   =
  if (lame_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tls_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true, to_link)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_sessio=
n_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span>       =
  msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring key&qu=
ot;);</span><br><span>     }</span><br><span> </span><br><span>@@ -3553,7 +=
3444,7 @@</span><br><span>      */</span><br><span>     if (TLS_AUTHENTICAT=
ED(multi, &amp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
ove_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        move_session(multi, TM_ACTIVE=
, TM_INITIAL, true);</span><br><span>         tas =3D tls_authentication_st=
atus(multi);</span><br><span>         msg(D_TLS_DEBUG_LOW,</span><br><span>=
             &quot;TLS: tls_multi_process: initial untrusted &quot;</span><=
br><span>@@ -4038,7 +3929,7 @@</span><br><span>                 goto done;<=
/span><br><span>             }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            key_state_soft_reset(session, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            key_sta=
te_soft_reset(session);</span><br><span> </span><br><span>             dmsg=
(D_TLS_DEBUG, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&q=
uot;, i,</span><br><span>                  session_id_print(&amp;sid, &amp;=
gc));</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn=
/ssl_common=2Eh</span><br><span>index 436770b=2E=2Ecf22be5 100644</span><br=
><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/s=
sl_common=2Eh</span><br><span>@@ -635,6 +635,14 @@</span><br><span>      */=
</span><br><span>     struct link_socket_actual to_link_addr;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * Holds the outgoing c=
ontrol packet returned by tls_multi_process=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * It belongs to the tls_multi and not to a =
session or key state, so</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * it stays valid when these are freed or moved before the packet =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * written to=
 the link=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t=
o_link_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     int n_sessions; /**&lt; Number of sessions negotiated thus</s=
pan><br><span>                      *   far=2E */</span><br><span>     enum=
 multi_status multi_state;</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index dad58c3=2E=2Ef843daf 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_pkt=2Ec</span><br><span>@@ -169,10 +169,14 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-write_control_auth(struct tls_session *session, stru=
ct key_state *ks, struct buffer *buf,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                   struct link_socket_actual **to_link_addr=
, int opcode, int max_ack,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                   bool prepend_ack)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+write_control_auth(struct tls_session *session, struc=
t key_state *ks, const struct buffer *payload,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   struct buffer *out, struct li=
nk_socket_actual **to_link_addr, int opcode,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                   int max_ack, bool prepend_ack)<=
/span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Work on a copy so that tls_wrap_control can point it at another</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffer without mod=
ifying the caller&#39;s buffer */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer buf =3D *payload;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(ks-&gt;key_id &g=
t;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span>  =
   ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span>=
<br><span>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt=
; P_OPCODE_SHIFT));</span><br><span>@@ -187,14 +191,20 @@</span><br><span> =
    }</span><br><span> </span><br><span>     ASSERT(link_socket_actual_defi=
ned(&amp;ks-&gt;remote_addr));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(reliable_ack_write(ks-&gt;rec_ack, ks-&gt;lru_acks, buf=
, &amp;ks-&gt;session_id_remote, max_ack,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(reliable_ack_write(ks-&gt;rec_ack, ks-&gt;=
lru_acks, &amp;buf, &amp;ks-&gt;session_id_remote, max_ack,</span><br><span=
>                               prepend_ack));</span><br><span> </span><br>=
<span>     msg(D_TLS_DEBUG, &quot;%s(): %s&quot;, __func__, packet_opcode_n=
ame(opcode));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    tls_wrap_control(tls_session_get_tls_wrap(session, ks-&gt;key=
_id), header, buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tls_wrap_control(tls_session_get_tls_wrap(session, ks-&gt;key_id), heade=
r, &amp;buf,</span><br><span>                      &amp;session-&gt;session=
_id);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* buf now points into memory owned by ks or session (the payload&#=
39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffer o=
r the tls_wrap work buffer)=2E  Either can be freed before</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * the packet is written to the =
link, so copy the packet to out=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(buf_init(out, buf=2Eoffset));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_copy(out, &amp;buf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   *to_link_addr =3D &amp;ks-&gt;remote_addr;</span><br><span> }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/=
ssl_pkt=2Eh</span><br><span>index 218c6bb=2E=2Ef04fea84 100644</span><br><s=
pan>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>@@ -185,10 +185,29 @@</span><br><span> bool check_sess=
ion_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openv=
pn_sockaddr *from,</span><br><span>                                    cons=
t uint8_t *key, int handwindow, bool pkt_is_ack);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Write a control channel authentication record=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Write a control channel packe=
t: add the ACKs, the opcode and session id</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * header and the tls-auth/tls-crypt wrapping to \c =
payload=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param session         =
  the TLS session the packet belongs to</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param ks                the key state the packet be=
longs to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p=
ayload           the packet payload=2E Its data is left</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                          unchanged, =
but the space around it in its</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *                          buffer is used to build the packet=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param out   =
            buffer the finished packet is written to, at</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *                          the offset=
 it was built at=2E It must be owned</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                          by the caller, not share memor=
y with \c payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
                          or the tls_wrap work buffers, and have room for</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                   =
       the packet at that offset (a buffer of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *                          BUF_SIZE() of the ses=
sion&#39;s frame does)=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param to_link_addr      set to the address the packet is sent to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opcode    =
        opcode of the packet</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param max_ack           maximum number of ACKs to add</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param prepend_ack       =
add the ACKs in front of the payload instead</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *                          of writing them into i=
t</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void write_control_auth(struct tls_session *session, struct key_state *ks,=
 struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void write_control_auth(struct tls_session *session, struct key_state *ks,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     const struct buffer *payload, struct buffer *out,</span><br><span>    =
                     struct link_socket_actual **to_link_addr, int opcode, =
int max_ack,</span><br><span>                         bool prepend_ack);</s=
pan><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index f34bd=
41=2E=2E36dec3f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><=
br><span>@@ -783,6 +783,108 @@</span><br><span>     free_tas(&amp;tas);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* write_control_auth() writes the finished packet to the out=
 buffer of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ca=
ller, so the packet stays valid when the buffers of the session and key</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * state are reused or =
freed before it is sent=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_write_control_auth_out_buf(struct tls_wrap_ctx *wrap, struct tls_wr=
ap_ctx *peer_wrap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_opti=
ons opt =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   opt=2Eserver =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tl=
s_session session =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    session=2Eopt =3D &amp;opt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    session=2Etls_wrap =3D *wrap;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    session=2Esession_id =3D (struct ses=
sion_id){ { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct reliable_ack rec_ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 7 }=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct relia=
ble_ack lru_acks =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct key_state ks =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ks=2Erec_ack =3D &amp;rec_ack;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ks=2Elru_acks =3D &amp;lru_acks;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks=2Esession_id_=
remote =3D (struct session_id){ { 8, 7, 6, 5, 4, 3, 2, 1 } };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ks=2Eremote_addr=2Edest=2Eadd=
r=2Esa=2Esa_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ks=2Eremote_addr=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =
=3D htonl(0x01020304);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_=
t data[] =3D &quot;control channel payload&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(1600)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
out =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a contr=
ol packet with the ACK in front of its payload, as sent from</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * the reliability layer, and =
a dedicated ACK packet */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int i =3D 0; i &lt; 2; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        const bool dedicated_ack =3D (i =3D=3D 1);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const size_t len =3D dedica=
ted_ack ? 0 : sizeof(data);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_true(buf_init(&amp;payload, 200));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(buf_write(&amp;payload, data, len));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct link_socket_actual *to_=
link_addr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        write_control_auth(&amp;session, &amp;ks, &amp;payload, &amp;out, &=
amp;to_link_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                         dedicated_ack ? P_ACK_V1 : P_CONTROL_V1, RELIABLE_=
ACK_SIZE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 !dedicated_ack);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_ptr_equal(to_link_addr, &amp;ks=2Eremote_addr);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(&amp;pa=
yload), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  assert_memory_equal(BPTR(&amp;payload), data, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(BLENZ(&amp;out) &gt; =
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* the packet is still in=
tact after the session buffers are overwritten */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memset(payload=2Edata, 0x55, (size_t)=
payload=2Ecapacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (session=2Etls_wrap=2Ework=2Edata)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            memset(session=2Etls_wrap=2Ework=2Edata, 0x55,=
 (size_t)session=2Etls_wrap=2Ework=2Ecapacity);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct link_socket_actual from =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        assert_true(read_control_auth(&amp;out=
, peer_wrap, &amp;from, &amp;opt));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct reliable_ack ack;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct session_id sid;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_true(reliable_ack_parse(&amp;out, &amp;=
ack, &amp;sid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     assert_int_equal(ack=2Elen, 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        assert_int_equal(ack=2Epacket_id[0], 7);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(&=
amp;sid, &amp;ks=2Esession_id_remote, SID_SIZE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(&amp;out), len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memo=
ry_equal(BPTR(&amp;out), data, len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&am=
p;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf=
(&amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_write_control_auth_out_buf(void **ut_state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct tls_wrap_ctx none =3D { =2Emode =3D TLS_WR=
AP_NONE };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check=
_write_control_auth_out_buf(&amp;none, &amp;none);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY=
_DIRECTION_INVERSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTION_=
NORMAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_=
id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&=
quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packe=
t_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTES=
T&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=
et_packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_write_control=
_auth_out_buf(&amp;tas_client=2Etls_wrap, &amp;tas_server=2Etls_wrap);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;=
tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=
=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree_tas(&amp;tas_client);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    free_tas(&amp;tas_server);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  tas_client =3D init_tas_crypt(false);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tas_server =3D init_tas_crypt(true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=
=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_serv=
er=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;=
tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    check_write_control_auth_out_buf(&amp;tas_=
client=2Etls_wrap, &amp;tas_server=2Etls_wrap);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=
=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp=
;tas_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 void</span><br><span> test_extract_control_message(void **ut_state)</span>=
<br><span> {</span><br><span>@@ -835,6 +937,7 @@</span><br><span>         c=
mocka_unit_test(test_generate_reset_packet_resend_wkc),</span><br><span>   =
      cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><br><spa=
n>         cmocka_unit_test(test_wkc_not_appended_without_key),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_w=
rite_control_auth_out_buf),</span><br><span>         cmocka_unit_test(test_=
extract_control_message),</span><br><span>         cmocka_unit_test(test_tl=
v_write_u16_wire_format),</span><br><span>         cmocka_unit_test(test_tl=
v_header_roundtrip),</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c36e155=
7178d22d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepacheco99=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Stef=
fan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--T+cwZoB2MzI=--


--===============7499091733340764063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7499091733340764063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7499091733340764063==--

