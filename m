Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C12606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BltzdHhK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gSiBW2UY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SZERMRd4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NgHGCSiQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=jdPX38lVdLUyXRHrM6Ju1a2SRJZUb0WpW208E45rqLg=; b=BltzdHhKlZAz1adNsrDRXW3KnE
	M0hxHnXzNpdEPsFgBzKMeUGTDwR6uFKBCIWoBjaXjX9PPVM++/3xjMd28YGGzxhyEKhFw3/FalBCa
	Wnk41oB1w/1BM9PRMklctyXuZxNaPEuHzY1gz7tfLLwP37rcay5pckFPusjB22/F92EY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLplg-00000000306-0BZI;
	Tue, 27 Oct 2026 22:35:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLplZ-000000002zx-2OTj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 22:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EJetm1G4OtSXvseAk+ebSVLvuhSqfoJeQkfDNO2OnwY=; b=gSiBW2UYfDCF8sT15WBo013P34
 1afXCEuY+ShuZkMVbGvS9aysNTEM5WmfMGXYQO7NL2XZSJoIVPmTM5CvmTFEi0Ih/hUl931kDYEu9
 Dj2sQD/5EhYRqTGGynd/WMEgAKRQyBoBoyOabKruB8HFCWBvkDpZa/5vhjOTqb4af0T4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EJetm1G4OtSXvseAk+ebSVLvuhSqfoJeQkfDNO2OnwY=; b=SZERMRd45KLiExDP4yG1Z4IdPe
 nTYWrHtPc7Q11MXRjDZv2vyRm/vVXZ1Fdnrx8B10t1wM45GwJiVG/oBdabS/PU6wPu7ODD56eowNu
 JmY7NbG7iAbM75dwl7lqvs1msdQzegcdGSSvbYzji758vOqZxxej6jDaN8LiwL/sCMOE=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLplY-0000000056U-0hyL for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 22:35:37 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so2898445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793140529; x=1793745329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EJetm1G4OtSXvseAk+ebSVLvuhSqfoJeQkfDNO2OnwY=;
 b=NgHGCSiQC79/tBiCfSLNLJwo9uQqr2Y+YFktlS+dDZZsU+tGz2NFir495Fbn4etfoK
 JrX7GveOFn+AzegCdiRsdsh/VT9tiJGeOkrOKaDhUrKu7odaGNnsPMK8Fvnp6+fmSe0n
 a5p7TSdkKSLVrj1QdG8fncQPFPXuk6tIhNCjWydyAPTWKMQrYQpvhkFqornrtGWQ4okU
 YBMKUu7PwL/Ks74SrcwXb6+n6PD+v/WwmlRtno7N+EA4XHq8JwhpiiJE5aorZHTeMuhB
 uO4CI7ki+Poqe141xJJlR/5TwpjxE4B3TLNChrev3nJoBecGVOT5SBePYJHDDKHWkT/f
 f8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793140529; x=1793745329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJetm1G4OtSXvseAk+ebSVLvuhSqfoJeQkfDNO2OnwY=;
 b=n3lmDjt76crz0FJgxwKdDdkeC3Eg28komh+Vm8qovoyVUdqFBXE/8OBKGwYUhIu4QK
 9s5WEMLNtZn925H0kApsLsmVykjlL7Er0FjDsYT2Pk9OfvfPoKtP/cZdBuUhkKdYxYe4
 mskVdL0y4XSY/DNVwvgy0HHA9p0MXLwpN13Z8X9mH9M/1wSTvilXqxnDH/MfQCBnKCGP
 C02qN7LXvKuOT97+pUTAH+/jD3g7WtvPi1BOU4ulH7xQT3mVTtMc1yesKc7G0vf8rVql
 4sTGMQ9VMuXQeWjAlAhQm2H/o7rMTq5HfHqFuko1xtd1Q28GkYJSDYmN2s8beAmY8VCm
 4PIw==
X-Gm-Message-State: AFq9FYIUBNmi1BZ2vQ5IVe0v0DYCONwR+PNYIwcwzIwBSaj4CMt0tqn6
 up5+Org/Bb3CYNuJtqsvv9NDen8gX2Rv6B58g9JgPVgbvagfp2wqvjgywef8bmkCUTAcg/qOToT
 4H01HqcsJPHUiL1juFfhhnVwrC8MeVtjvmTPPGOItDDntGVS+TSLgItiESBY/lJKfqoy2NXRzwN
 ILMZICuw==
X-Gm-Gg: AYBFou2cv6PVunNWl8JtXFaH+AYywzauEnMMf6o+VlgCoa+Fm9n8CoCQ82BCC0eSmyB
 paQfF+n6czTDM22OB3jOYDV9KcfJ7q7oIb45Ci/+Qci+nUJn1oxoUbA+lnJPeIqxX/m6oBGT6S1
 UJ9YyKXp5J4CQ++IYv9fJBgcJ+V4TMJDTKUue0nvkfCf6LSsyy9oDQCN/aJr+ywkSzA6Z3mHviQ
 Ef6BsnUbbMcV9e79j0x121HF5wUTopR3lQMbKF8PvqFDmvV4KTcSGdX8o4vTRk1AiM0L4ZIL5bk
 BWJqdmA9Rn8Wqwk9OOVblJwAUEsNd0M+xA575LgoygXPP/wGzcmNY69ikCZY7lCMuSsYuRi2TzP
 8QRe+ISeDt4nLu/GRn7o8nDWaGMbdUmszin0kOMzVcfBgB4XODoEYehESWTcqz4HnWYudZc8CPZ
 VwXh4gClPyyzaaid0LoqQw6xBPKzSUEzzvwcdlZWXl0fpPKfoLTbHDQuhD+nT9wYqNdYVN0coEA
 dWEe1O/FFOakGknH1kGAieb+iSAPSpypC3HV2slojeJu9ZPEkjB1PL2O/13xw/xmXy31kgejrGc
 rsZ6ycEbDzPVmA1JpJrKr2d2mpcU6N4PwgXe8z7GDp6xLYBn7/GSt+W3MIINCBMAD/IouCIg8uY
 iUzaaYAhG9k8OKlDX4N3xXkfFOzlimDZvud6Vsu08eDPPn7daJFWULTq7RIcHL18=
X-Received: by 2002:a05:600c:154d:b0:4a3:5a42:b2a4 with SMTP id
 5b1f17b1804b1-4a96720266bmr7241545e9.12.1793140529365; 
 Tue, 27 Oct 2026 15:35:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f150fsm1958825e9.10.2026.10.27.15.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 15:35:29 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 22:35:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2579c0643fa0b26df29d63af306d9ef10f74b3b3
X-Gerrit-Change-Number: 2057
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2057?usp=email>
X-Gerrit-Commit: a944df4b7b7cad12448be238d91f0748b7b24389
References: <gerrit.1793140526000.I2579c0643fa0b26df29d63af306d9ef10f74b3b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTQwNTI2MDAwLkkyNTc5YzA2NDNmYTBiMjZkZjI5ZDYzYWYzMDZkOWVmMTBmNzRiM2IzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2cb7cc17b21bca18e7174470de65839ead032031-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLplY-0000000056U-0hyL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: p2p: don't let new
 sessions reset the ping-restart timer
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6734405268030093570=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6734405268030093570==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ya9zu3gzIgA="; charset=UTF-8

--Ya9zu3gzIgA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2057?usp=3Demail

to review the following change=2E
=


Change subject: p2p: don't let new sessions reset the ping-restart timer
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

p2p: don't le=
t new sessions reset the ping-restart timer

Any control packet resets the =
ping-restart timer, including a hard reset
that starts a new session=2E Wit=
hout tls-auth/tls-crypt such a packet can
come from anybody, so a dead tunn=
el that keeps receiving stray hard
resets (e=2Eg=2E from a scanner) never r=
estarts=2E

Once a session is established, only reset the timer for control=
 packets
of that session=2E

Change-Id: I2579c0643fa0b26df29d63af306d9ef10f=
74b3b3
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src=
/openvpn/forward=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
3 files ch=
anged, 18 insertions(+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/57/2057/1

diff --git a/src/openvpn/forw=
ard=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2Eca5f052 100644
--- a/s=
rc/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1088,12 +1088,14 @=
@
              * will load crypto_options with the correct encryption key
=
              * and return false=2E
              */
-            if (tls_p=
re_decrypt(c->c2=2Etls_multi, &c->c2=2Efrom, &c->c2=2Ebuf, &co, floated, &a=
d_start))
+            bool from_peer;
+            if (tls_pre_decrypt(c->=
c2=2Etls_multi, &c->c2=2Efrom, &c->c2=2Ebuf, &co, floated, &ad_start,
+    =
                            &from_peer))
             {
                 in=
terval_action(&c->c2=2Etmp_int);
 
-                /* reset packet receive=
d timer if TLS packet */
-                if (c->options=2Eping_rec_timeout=
)
+                /* reset packet received timer if TLS packet from our pe=
er */
+                if (c->options=2Eping_rec_timeout && from_peer)
    =
             {
                     event_timeout_reset(&c->c2=2Eping_rec_i=
nterval);
                 }
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec
index 086a6fc=2E=2E924de74 100644
--- a/src/openvpn/ssl=2Ec
+++ b/=
src/openvpn/ssl=2Ec
@@ -3754,8 +3754,11 @@
 
 bool
 tls_pre_decrypt(struct =
tls_multi *multi, const struct link_socket_actual *from, struct buffer *buf=
,
-                struct crypto_options **opt, bool floated, const uint8_t=
 **ad_start)
+                struct crypto_options **opt, bool floated, co=
nst uint8_t **ad_start,
+                bool *from_peer)
 {
+    *from_pee=
r =3D false;
+
     if (buf->len <=3D 0)
     {
         buf->len =3D 0;
@@=
 -4006,6 +4009,10 @@
     /* Let our caller know we processed a control cha=
nnel packet */
     ret =3D true;
 
+    /* Once a session is established, =
only its packets show that the peer is
+     * alive: a new session can be =
started by anybody */
+    *from_peer =3D (i =3D=3D TM_ACTIVE || multi->mul=
ti_state < CAS_CONNECT_DONE);
+
     /*
      * Set our remote address and =
remote session_id
      */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/s=
sl=2Eh
index 76c3610=2E=2E0a4ed4c 100644
--- a/src/openvpn/ssl=2Eh
+++ b/sr=
c/openvpn/ssl=2Eh
@@ -291,6 +291,10 @@
  * @param[in] floated   Set whether=
 the peer is allowed to have floated=2E
  * @param[out] ad_start Returns a =
pointer to the start of the authenticated data
  *     of this packet
+ * @=
param[out] from_peer Set to true if the packet is a control channel packet
=
+ *     from our established peer (or if there is none yet)=2E A packet tha=
t
+ *     starts a new, not yet authenticated session can come from anybody=
 and
+ *     does not show that the peer is alive=2E
  *
  * @return
  * @l=
i True if the packet is a control channel packet that has been
@@ -300,7 +3=
04,7 @@
  */
 bool tls_pre_decrypt(struct tls_multi *multi, const struct li=
nk_socket_actual *from,
                      struct buffer *buf, struct cr=
ypto_options **opt, bool floated,
-                     const uint8_t **ad_=
start);
+                     const uint8_t **ad_start, bool *from_peer);
 =

 
 /**********************************************************************=
****/

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2057?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2579c0643f=
a0b26df29d63af306d9ef10f74b3b3
Gerrit-Change-Number: 2057
Gerrit-PatchSet: =
1
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--Ya9zu3gzIgA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2057?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">p2p: don&#39;t let new sessions reset the ping-restart tim=
er<br><br>Any control packet resets the ping-restart timer, including a har=
d reset<br>that starts a new session=2E Without tls-auth/tls-crypt such a p=
acket can<br>come from anybody, so a dead tunnel that keeps receiving stray=
 hard<br>resets (e=2Eg=2E from a scanner) never restarts=2E<br><br>Once a s=
ession is established, only reset the timer for control packets<br>of that =
session=2E<br><br>Change-Id: I2579c0643fa0b26df29d63af306d9ef10f74b3b3<br>S=
igned-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M=
 src/openvpn/forward=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<=
br>3 files changed, 18 insertions(+), 5 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/20=
57/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=
</span><br><span>index 681210d=2E=2Eca5f052 100644</span><br><span>--- a/sr=
c/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><=
br><span>@@ -1088,12 +1088,14 @@</span><br><span>              * will load =
crypto_options with the correct encryption key</span><br><span>            =
  * and return false=2E</span><br><span>              */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (tls_pre_decrypt(c-&gt;c2=
=2Etls_multi, &amp;c-&gt;c2=2Efrom, &amp;c-&gt;c2=2Ebuf, &amp;co, floated, =
&amp;ad_start))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        bool from_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (tls_pre_decrypt(c-&gt;c2=2Etls_multi, &amp;c-&gt;c2=2Ef=
rom, &amp;c-&gt;c2=2Ebuf, &amp;co, floated, &amp;ad_start,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                &amp=
;from_peer))</span><br><span>             {</span><br><span>               =
  interval_action(&amp;c-&gt;c2=2Etmp_int);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                /* reset packet rec=
eived timer if TLS packet */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (c-&gt;options=2Eping_rec_timeout)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* reset packet re=
ceived timer if TLS packet from our peer */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                if (c-&gt;options=2Eping_rec_timeou=
t &amp;&amp; from_peer)</span><br><span>                 {</span><br><span>=
                     event_timeout_reset(&amp;c-&gt;c2=2Eping_rec_interval)=
;</span><br><span>                 }</span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E924de74=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -3754,8 +3754,11 @@</span><br><span> </=
span><br><span> bool</span><br><span> tls_pre_decrypt(struct tls_multi *mul=
ti, const struct link_socket_actual *from, struct buffer *buf,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                struct crypto_opti=
ons **opt, bool floated, const uint8_t **ad_start)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                struct crypto_options **opt,=
 bool floated, const uint8_t **ad_start,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                bool *from_peer)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *from_peer =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     if (buf-&gt;len &lt;=3D 0)</span><br><span>     {</span><br><span>   =
      buf-&gt;len =3D 0;</span><br><span>@@ -4006,6 +4009,10 @@</span><br><=
span>     /* Let our caller know we processed a control channel packet */</=
span><br><span>     ret =3D true;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Once a session is established, onl=
y its packets show that the peer is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * alive: a new session can be started by anybody */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *from_peer =3D (i =
=3D=3D TM_ACTIVE || multi-&gt;multi_state &lt; CAS_CONNECT_DONE);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</spa=
n><br><span>      * Set our remote address and remote session_id</span><br>=
<span>      */</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openv=
pn/ssl=2Eh</span><br><span>index 76c3610=2E=2E0a4ed4c 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span=
><br><span>@@ -291,6 +291,10 @@</span><br><span>  * @param[in] floated   Se=
t whether the peer is allowed to have floated=2E</span><br><span>  * @param=
[out] ad_start Returns a pointer to the start of the authenticated data</sp=
an><br><span>  *     of this packet</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param[out] from_peer Set to true if the packet is a con=
trol channel packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *     from our established peer (or if there is none yet)=2E A packet that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     starts a new=
, not yet authenticated session can come from anybody and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *     does not show that the peer is=
 alive=2E</span><br><span>  *</span><br><span>  * @return</span><br><span> =
 * @li True if the packet is a control channel packet that has been</span><=
br><span>@@ -300,7 +304,7 @@</span><br><span>  */</span><br><span> bool tls=
_pre_decrypt(struct tls_multi *multi, const struct link_socket_actual *from=
,</span><br><span>                      struct buffer *buf, struct crypto_o=
ptions **opt, bool floated,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                     const uint8_t **ad_start);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     const uint8_t **ad_s=
tart, bool *from_peer);</span><br><span> </span><br><span> </span><br><span=
> /************************************************************************=
**/</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2057?usp=3Demail">change 2057</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2057?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I2579c0643fa0b26df29d63af30=
6d9ef10f74b3b3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 20=
57 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--Ya9zu3gzIgA=--


--===============6734405268030093570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6734405268030093570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6734405268030093570==--

