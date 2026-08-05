Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46615C55838
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=dm1Bk+9aOa1TBBKmoZ2ahfkX+T7BmLqkRSYDHoIymks=; b=MF1ZkycD0sRzWj
	lVlAVqCtOjn9roWq6G9g2YUX8D0+wfTvgGuk44BI8tZC3y7obcksfNPZfR4EGJ63T4tLJ+OTTcv4J
	A+ohxZm242iVsyzJL4dSqaUwxfrhs9ljZtgbSvFNBePOJ6t+9cqbV/6YXNBFo0VeTg4Ez5ncERjj4
	SI8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrQPy-0005i3-ED;
	Wed, 05 Aug 2026 01:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrQPx-0005hv-Id
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qne5z9lEm2Jy5z3ivNpNgFAnRirOvf5dtDg4MBmNmGo=; b=PyoAsYvBPOnF9RGuR1HbJ483Kz
 5QdMx85JlzEliyeqvY8VRwOa1We7EmUF0oAaNmCIjK7pOcsw/s/c9x3U7o+QqB2ZuMXAQBo9c0jt9
 Sdm7mQn+y1SYRcnl5lBfu+JMzrnBi4IdF+JAdEewHGsTxGYqeRev8PF+CdaxrcxtPsYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qne5z9lEm2Jy5z3ivNpNgFAnRirOvf5dtDg4MBmNmGo=; b=C
 wVGjdjrpNKZB8W2ZFIfZ2XqC/LhcDCKWoI9ENfBfEcZbymFlUZySJi/OD3SXVbZ4onpvvbDRkwSfd
 fRSJ3+d4cHGATby5RuTkcmkxHBLilQfAT3Q9i0Vxw0xPBwoQdafxV8fGQO7bj6vy38KqztGYtq1EL
 odiGf4fp86ugeSBY=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrQPw-0005u2-Ql for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:27:35 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso229728f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 04 Aug 2026 18:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785893247; x=1786498047; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qne5z9lEm2Jy5z3ivNpNgFAnRirOvf5dtDg4MBmNmGo=;
 b=LlMoV4C4ZrKeIHfWkK1uR1UOFnUq4sKz1Ryhx2vmzkqcI9dEJCmA8H5XxOdzUi6cFV
 IPKcYmaUfhFzzXJYB/CPK7xewJKB4HU57qYqL4uT30R9LzrebDCsBPIXSOmIk1Rw+LRN
 JST5YkyeQz2chMmaiamFqaCusI7WDq/g7FQm3oVtAwnZdDOGpJKmeFetkAGmMnNdKhjW
 V0vnLm8gzhJZirvNVpcF3BfaxPBjM1gb+NGgZsRdKQCvUG9imJW5PTnt/Eeaw3+/lY21
 6GoB7n81lSHoRUgg+Er24AIYf4KWOWzVf312ssSa0pEkdEkYmjLiekisZb4I0LT4wEFf
 MHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785893247; x=1786498047;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qne5z9lEm2Jy5z3ivNpNgFAnRirOvf5dtDg4MBmNmGo=;
 b=VZIqVw9WoAkJgDhR4J6U1hTdmNYfwE4Q/19Y2V9u88hNMVHruerQuhe7Ax82/p017z
 3K1fLefv4ABImaxlz2XrCrmJ7qxMWpRJRb9C/PNcOHLu/sTpGweELYEatdtP+Xa2k2sh
 blDHOolwCBDRlwDeVjq+eOA8MsRhJiIZOkHHqUaRvZ4oAm3isgDpDy1jCuAplE3bvKRA
 BUbzlYGL2YqRAJkZtxUwFll6DRLjHxEnFgsy09APZRocxwTNw4vngTFwbEX3PJFqnx1o
 Tnxx13AQ6g1sn/z+ihYz22/BK+l5eaZvSS80+/EFuIIPo3CtxZuN3426Bxy5SRL8At/W
 W9oA==
X-Gm-Message-State: AOJu0YyiWnRb2JOZcmpEPMvH8gQap+iDNSd37Wp92vGMHpznZ3QWVKsn
 5q2k1JuxMpWVYg7Xbp+p/AtK1BXVZN2GNRN0oBn7+jhsjiWvmyScRc417RP71Y1e+F6WhH+dRqY
 kJYZGE5+8JaI3N016YXkwstOGZqfz+tW2aIX1ZQj0qjItast1XDqyUeViWuZ270/9h3xMVA0PDy
 p3D7Xh1g==
X-Gm-Gg: AR+sD12/3STbeqQaggZ/GEPmh2ZybGXhcOSUXydJYQT09x3TSxou5qVtDdDmnev+Kd/
 dIT9oWU7ARdPA9xADcBFiqSjh9g4L3iI1PszxbJt8GRN1A06Tzu6GBvkvuOW7Itg2yVYmuj+WqZ
 d41xCnsSPPdQr8x5mKMQZLGzWAbjq4hqwvq49om2zo/QT/2HAuJr/EfVlpKwIqDCd/U7eYQKXGv
 kXFeQxdfk95UXDKIRgP7pOsle2no2Wbm+Ky46LS6G0oJIBW42v+mVi5dHHYG+etGH0YGvE2voIU
 5IHockPnFthUOvTgRFtl/XWQujTWgUVMNnI18Thggw+Y4MyEyPA14ac8IBN0U32P9+h7C+tjrmn
 iGR8diqW5ki6q4MtmuI8yK6Y1JwEOY2iYJn+kn4gC/KjJM7b3axzjPF/MRDtRBceVbMjCBPKViI
 usmOMhvkxnsLu5rZAZqvrDakeo7XZZun8MeXepxuzL3JqawLRvQ4fY5gQ9V5ArGYoGOtZAOocxx
 NJiHNWcrfMukQm9uXWipo34uHAoXAQwWlxwfqfJEkXphK9VLoy3NHL7gqO222OS7rSn7zrS3rKV
 lLQ1KWfkGWil/pFe/pzsWKzOSZYQoNEyPrZqEHLz4gR6VVzg0rs=
X-Received: by 2002:a05:6000:18c5:b0:47e:8e8a:43f5 with SMTP id
 ffacd0b85a97d-47fec5220a2mr3828616f8f.20.1785893246560; 
 Tue, 04 Aug 2026 18:27:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfe5d7csm4725254f8f.15.2026.08.04.18.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 18:27:26 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 01:27:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 9f0e71a3741abae86ab67bd74d7530db76e1d604
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c56e635e901405fa293031394494161281ec21ec-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrQPw-0005u2-Ql
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5940101102372667505=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5940101102372667505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pqR8kvoE/iU="; charset=UTF-8

--pqR8kvoE/iU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1835?usp=3Demail

to review the following change=2E


Chang=
e subject: dco: do not exit the process when installing a DCO key fails
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: do not exit=
 the process when installing a DCO key fails

When the DCO peer is gone fro=
m the kernel while userspace still believes
it exists, dco_new_key() fails =
with ENOENT and init_key_contexts() calls
msg(M_FATAL, =2E=2E=2E)=2E On a s=
erver this terminates the whole daemon and
disconnects every other client, =
even though only a single peer is
affected=2E

Make init_key_contexts() ret=
urn a bool and propagate the failure through
generate_key_expansion(), whic=
h already has an error path that wipes the
generated key material=2E Record=
 the condition in tls_multi so that
dco_update_keys() reports the mismatch =
and the existing
check_dco_key_status() caller restarts only the affected c=
onnection,
which re-creates the DCO peer from scratch=2E

Note that commit =
ea3bb67e2b1e ("dco: make key state desync recoverable")
does not cover this=
 case, as both of its hunks are conditional on the
key installation having =
succeeded=2E

Github: fixes OpenVPN/openvpn#542
Change-Id: I564edc6e0cc179c=
2b8b5ddef5e80838949fe9fcd
Signed-off-by: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=
_common=2Eh
3 files changed, 38 insertions(+), 3 deletions(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/1835/1

diff --=
git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 2584368=2E=2Eb66f697 =
100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -132,6 +132,1=
8 @@
 bool
 dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 {=

+    /* installing a key has failed earlier, therefore userspace and kerne=
l
+     * disagree about this peer and no key operation can be trusted anym=
ore=2E
+     * Report the mismatch so that the caller restarts the connecti=
on
+     */
+    if (multi->dco_desync)
+    {
+        msg(D_DCO, "DCO key=
 state mismatch: installing a key has failed earlier "
+                   =
"(peer_id=3D%d, dco_keys_installed=3D%d)",
+            multi->dco_peer_id,=
 multi->dco_keys_installed);
+        return false;
+    }
+
     /* this f=
unction checks if keys have to be swapped or erased, therefore it
      * c=
an't do much if we don't have any key installed
      */
diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2E08ca306 100644
--- =
a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1373,7 +1373,7 @@
     =
secure_memzero(&e1_recv, sizeof(e1_recv));
 }
 
-static void
+static bool
 =
init_key_contexts(struct key_state *ks, struct tls_multi *multi, const stru=
ct key_type *key_type,
                   bool server, struct key2 *key2, b=
ool dco_enabled)
 {
@@ -1392,7 +1392,18 @@
         int ret =3D init_key_dc=
o_bi(multi, ks, key2, key_direction, key_type->cipher, server);
         if=
 (ret < 0)
         {
-            msg(M_FATAL, "Impossible to install key =
material in DCO: %s", strerror(-ret));
+            /* This normally means =
the DCO peer is gone from the kernel while
+             * userspace still =
believes it exists=2E Do not take the whole
+             * process down ov=
er a single peer: flag the desync so that
+             * dco_update_keys()=
 can ask for this connection to be restarted,
+             * which re-crea=
tes the peer from scratch */
+            msg(M_WARN,
+                "Imp=
ossible to install key material in DCO: %s=2E The underlying "
+           =
     "DCO peer may have been deleted from the kernel without "
+           =
     "notifying userspace=2E Restarting the session",
+                stre=
rror(-ret));
+            multi->dco_desync =3D true;
+            return f=
alse;
         }
 
         /* encrypt/decrypt context are unused with DCO =
*/
@@ -1415,6 +1426,8 @@
     {
         init_key_ctx_bi(key, key2, key_dir=
ection, key_type, "Data Channel");
     }
+
+    return true;
 }
 
 static =
bool
@@ -1524,7 +1537,11 @@
         }
     }
 
-    init_key_contexts(ks, =
multi, &session->opt->key_type, server, &key2, session->opt->dco_enabled);
=
+    if (!init_key_contexts(ks, multi, &session->opt->key_type, server, &ke=
y2,
+                           session->opt->dco_enabled))
+    {
+       =
 goto exit;
+    }
     ret =3D true;
 
 exit:
diff --git a/src/openvpn/ssl=
_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c90242=2E=2E9c180a3 100644
=
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -713,6=
 +713,12 @@
     /* Only used when DCO is used to remember how many keys we=
 installed
      * for this session */
     int dco_keys_installed;
+    /*=
 Set when installing a key in DCO failed, which means userspace and
+     *=
 kernel disagree about the state of this peer (i=2Ee=2E the kernel peer is
=
+     * gone while we still believe it exists)=2E The session cannot recove=
r on
+     * its own, so \c dco_update_keys() reports the mismatch and lets=
 the
+     * caller restart the connection */
+    bool dco_desync;
     /*=
*
      * This is the handle that DCO uses to identify this session with th=
e
      * kernel=2E

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1835?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerri=
t-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>

--pqR8kvoE/iU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o: do not exit the process when installing a DCO key fails<br><br>When the =
DCO peer is gone from the kernel while userspace still believes<br>it exist=
s, dco_new_key() fails with ENOENT and init_key_contexts() calls<br>msg(M_F=
ATAL, =2E=2E=2E)=2E On a server this terminates the whole daemon and<br>dis=
connects every other client, even though only a single peer is<br>affected=
=2E<br><br>Make init_key_contexts() return a bool and propagate the failure=
 through<br>generate_key_expansion(), which already has an error path that =
wipes the<br>generated key material=2E Record the condition in tls_multi so=
 that<br>dco_update_keys() reports the mismatch and the existing<br>check_d=
co_key_status() caller restarts only the affected connection,<br>which re-c=
reates the DCO peer from scratch=2E<br><br>Note that commit ea3bb67e2b1e (&=
quot;dco: make key state desync recoverable&quot;)<br>does not cover this c=
ase, as both of its hunks are conditional on the<br>key installation having=
 succeeded=2E<br><br>Github: fixes OpenVPN/openvpn#542<br>Change-Id: I564ed=
c6e0cc179c2b8b5ddef5e80838949fe9fcd<br>Signed-off-by: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openv=
pn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>3 files changed, 38 insertion=
s(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/35/1835/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 2584368=2E=2Eb66f=
697 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/=
src/openvpn/dco=2Ec</span><br><span>@@ -132,6 +132,18 @@</span><br><span> b=
ool</span><br><span> dco_update_keys(dco_context_t *dco, struct tls_multi *=
multi)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* installing a key has failed earlier, therefore userspace and k=
ernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * disagre=
e about this peer and no key operation can be trusted anymore=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * Report the mismatch so =
that the caller restarts the connection</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (multi-&gt;dco_desync)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_DCO, &quot;DCO key state mismatch: installing a key has f=
ailed earlier &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   &quot;(peer_id=3D%d, dco_keys_installed=3D%d)&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;=
dco_peer_id, multi-&gt;dco_keys_installed);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     /* this function checks if keys have to b=
e swapped or erased, therefore it</span><br><span>      * can&#39;t do much=
 if we don&#39;t have any key installed</span><br><span>      */</span><br>=
<span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><spa=
n>index ccd8264=2E=2E08ca306 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1373,7 +=
1373,7 @@</span><br><span>     secure_memzero(&amp;e1_recv, sizeof(e1_recv)=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span> init_key_contexts(struct key_state *=
ks, struct tls_multi *multi, const struct key_type *key_type,</span><br><sp=
an>                   bool server, struct key2 *key2, bool dco_enabled)</sp=
an><br><span> {</span><br><span>@@ -1392,7 +1392,18 @@</span><br><span>    =
     int ret =3D init_key_dco_bi(multi, ks, key2, key_direction, key_type-&=
gt;cipher, server);</span><br><span>         if (ret &lt; 0)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(M_FATAL, &quot;Impossible to install key material in DCO: %s&quot;, =
strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* This normally means the DCO peer is gone from the kernel while<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * users=
pace still believes it exists=2E Do not take the whole</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             * process down over a singl=
e peer: flag the desync so that</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * dco_update_keys() can ask for this connection to=
 be restarted,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        * which re-creates the peer from scratch */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;Impossible to i=
nstall key material in DCO: %s=2E The underlying &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;DCO peer may have=
 been deleted from the kernel without &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;notifying userspace=2E Resta=
rting the session&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                strerror(-ret));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            multi-&gt;dco_desync =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><b=
r><span>         }</span><br><span> </span><br><span>         /* encrypt/de=
crypt context are unused with DCO */</span><br><span>@@ -1415,6 +1426,8 @@<=
/span><br><span>     {</span><br><span>         init_key_ctx_bi(key, key2, =
key_direction, key_type, &quot;Data Channel&quot;);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }</sp=
an><br><span> </span><br><span> static bool</span><br><span>@@ -1524,7 +153=
7,11 @@</span><br><span>         }</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_contexts=
(ks, multi, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2, session-&=
gt;opt-&gt;dco_enabled);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!init_key_contexts(ks, multi, &amp;session-&gt;opt-&gt;key_typ=
e, server, &amp;key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                           session-&gt;opt-&gt;dco_enabled))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto exit;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span>     ret =3D true;</span>=
<br><span> </span><br><span> exit:</span><br><span>diff --git a/src/openvpn=
/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9c90242=
=2E=2E9c180a3 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span=
><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -713,6 +713,=
12 @@</span><br><span>     /* Only used when DCO is used to remember how ma=
ny keys we installed</span><br><span>      * for this session */</span><br>=
<span>     int dco_keys_installed;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Set when installing a key in DCO failed, which means =
userspace and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 kernel disagree about the state of this peer (i=2Ee=2E the kernel peer is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gone while we=
 still believe it exists)=2E The session cannot recover on</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * its own, so \c dco_update_key=
s() reports the mismatch and lets the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * caller restart the connection */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool dco_desync;</span><br><span>=
     /**</span><br><span>      * This is the handle that DCO uses to identi=
fy this session with the</span><br><span>      * kernel=2E</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1835?usp=3Demail">change 1835</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949f=
e9fcd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1835 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--pqR8kvoE/iU=--


--===============5940101102372667505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5940101102372667505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5940101102372667505==--

