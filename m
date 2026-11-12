Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10642606A327
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QlruUPOo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dQRrk6ig;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WQMH5x3K;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jr/J6acu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H5HNJALPGrS4fro8QUwpyd1jbYoe1NggnkIDtkIqZm8=; b=QlruUPOoZXHh0tSAHJTp02bNCK
	QWK+8CGwVBr9CpUeeO17mERpgPKo9MPrZ9HHv4x4iCwu9Xj9v+4X/uBX28h5abj8n0ky+xOaARw6y
	N6KddgYrdsj7rQZ3PfdKRg09em9yeMQUgIvsI+6kFlScPFKwUfq0znqMK8lHM//jYFms=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZul-000000000C2-39mp;
	Thu, 12 Nov 2026 18:52:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZuk-000000000Bu-1FAS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wKCCFmzlfZvsO6Hz/NRC9wnhQweW5ucUp77bkzRTwfg=; b=dQRrk6igrES6HJoKbNOKSj/wah
 I8qoV6W9ToSOgG1DPN0RUT/Z+w2xg54d9rbZhDOiFeYy0eMSD/bkWT6cMtE6KBbA1fqMPGYyJZScJ
 5+sBR8xNLIPteERyxYzdDY+dC34g3nDiKAO8ONbM3EGKCFFYkdMglpX2uPkimV208PkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wKCCFmzlfZvsO6Hz/NRC9wnhQweW5ucUp77bkzRTwfg=; b=WQMH5x3KP+jLNsFyDnyroLfI10
 2hK0mV+/i4sDsBvSEhUaoxfK2q6BxVqplGWuwvRmPYDdyS+0QaHSEgrlJ3rpxOwjeZYrpqyXDZ1+n
 EjJ+BEUCdFsxVwiSEbMZkt19KkdT2ufh4fBP35zGltjDcQ/PbbrGnJ9uNzRLN599AwUk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZui-000000005lp-3Qo3 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:52:50 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so69447f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794509562; x=1795114362; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wKCCFmzlfZvsO6Hz/NRC9wnhQweW5ucUp77bkzRTwfg=;
 b=Jr/J6acumhYorngXaAD7Zz2JFXz5uYak39gqWeL+4EoIszCrMCXi+pDydow+3AI5xO
 NRpHn7ZI9IhJ+eKhWAwzbSeukLKzkdyh/s5wIXaozOhxRfhDZqzWDIo/3YR8HKwlWg1R
 bkSsKsty8gh6URRppoESIRRoAMG7OVsKxu/WBon8bjkbm+WpDzEBkxhlm+v73T25G827
 Gp6InpM2A2f4Zvs3Dyg3Qcr7B6I583i4RrgU5ZrIwuYmM/P9zuzEXDhDoL3zmyUDIhon
 X5lQuAkgQ1z+6V2tTCr67NJGQnmiLKmEPiC6p4+GiXkLJ/wc2Xx9Dag5Uw7m6dtAwM6o
 eC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794509562; x=1795114362;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wKCCFmzlfZvsO6Hz/NRC9wnhQweW5ucUp77bkzRTwfg=;
 b=lGFWJqOw/NowRzaApje0Qo+npNCi+c0BUYn8o6tMq4ur7r6DYxhe8vZ5xvCCWurg/p
 3mFl1M3MzbxLN/orvcdKkMB0BQHTUCPmjapUZqDa0zw2yKj3CnJrorLwDFzgwrpMT43h
 aupLWWXDTfDmlnr3Bv/zaoWxrVdJKtxtnyLv5yvc6Trjy6qcTxT7rUdG7kQCbSVi8RV3
 HtEzxQP1xB3iU6fST0XPshD2Rdzy8DrB4DMSuvfJeKOBwG7fK1XhdzD+DLlTS0wPiU6t
 Waorl1U+WUR66FXqZUyi/+1/jIhMnkhzsJZDKeJ9XinjxOtnN46ov0n4oYqHKI5u+img
 Hnhg==
X-Gm-Message-State: APuU4Z/tQvIdjARTydT2a8RuD9+z4RwarGAmRGaeIJXLmkF15P1Q2rEy
 W7+5Tw6JH3PIoSb8udheZOfYSrSTfdY7vVa8RgpNRgvzkz42oyHgYUpIfiQMUAdwx49V+WUPKJF
 TZap0tDltUX3rhUf9qws3wlk7KXj99jtfZ86REUHwAd5MwAjAaFiCl/0JJqWZecuT+TMz
X-Gm-Gg: AYBFou0QnhJfuLUXebnl7AofCnIJau7W/KxKSTswG0ruTDFsIsWYz+RhqZgorrmh1lI
 nF/OGdP29UbaVeKe+ifHv6MGjIW3dQylTeriSwu1kBOl0yoIFqXxR5z15f5m6EnUnwuMM8a9N5e
 rOjf8yB7KMRCYPDp81R0SUH445pJOAV1U3dd+/WZp9Q1opIayrT2W4hF4khPYHGoPB2PiU07yf8
 opgY1Id/6QJjsKF2iyNML6MD6Q2mYGwFIxPm9oAbwtbF15wAr7MULnzyAGYR3D3aPKHkjlQwYvj
 E/S2TNxdISbfIXeHBxSP+wQLTMWtjwgO6cp3uhXzGvOaqevrHtvZC5mv1WAgVA2t6UMj0eMUPA9
 W1Nzt2q2p6m1MkjCblSBBJa6viEjYYFPLPx5NS04J9fzESbcZg3ueuYaVjqjouTohb5yolheNZh
 fykIyhGB2phgbD5Ade5cPogWtRbv29JDqdhJDPx96rH7ijLhRJJ+Pw0kUEcYgYlRxuq0fNBtk5U
 yF1LelClRg6zG/4UTi0th2TQV7dPCqYKylhTyUh1BhU3LXMWYhgO3SZavZ0bgsBcOp9+OQCaiU8
 GyforBrEO/CQxknuORRHjClX7gKJGc/uexfWw6fjT4aXV2BC5QQs0su3j5DpiaitZ70zTRt9vR5
 0CS7b6Amhn27guC0OYWZO394Jr0HiO/rKSLV06M8sheFf2mWSMQ3hqpuq1/FaACZLvzNmC0Aa4N
 CQaa4SlTXUTlJMLYM=
X-Received: by 2002:a05:6000:4a03:b0:48e:f10:ceb8 with SMTP id
 ffacd0b85a97d-49c6fd932fcmr596299f8f.11.1794509561968; 
 Thu, 12 Nov 2026 10:52:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5ff2be55sm780033f8f.28.2026.11.12.10.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:52:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:52:40 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: 95e4fd0f905fea3decfdbdd28caeee901009d250
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75ded473194ef7a56cb0539459fad2f788b7e86d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZui-000000005lp-3Qo3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8692899681939280790=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8692899681939280790==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JZzwtoy833w="; charset=UTF-8

--JZzwtoy833w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by Ralf Lici=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Arne Schwabe


Change subject: tls: reject incoming reneg request =
if primary key is not fully valid
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

tls: reject incoming reneg request if primary key is=
 not fully valid

Incoming P_CONTROL_SOFT_RESET_V1 can arrive while the act=
ive key is not
yet fully valid for renegotiation=2E This includes the windo=
w where we are
still waiting for auth_deferred_expire (derived from handsha=
ke/reneg
timing), as well as cases where deferred or mid-session auth later=

leaves the key non-authenticated even though state is S_GENERATED_KEYS=2E
=

This patch keeps read_control_auth as the first gate, then rejects the
inc=
oming renegotiation requests unless the primary key is KS_AUTH_TRUE
and aut=
h_deferred_expire has passed=2E

The rejected request is not counted as a T=
LS error, since soft TLS
errors trigger an instance restart in TCP mode=2E
=

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: Ralf L=
ici <ralf@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478
Message-Id:=
 <20261110115827=2E1649-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41068=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
=
1 file changed, 15 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1478/7

diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index cdb94ed=2E=2Ed13a0d3 100644
--- a/=
src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3946,6 +3946,21 @@
      =
           goto error;
             }
 
+            /*
+             * Do =
not allow incoming renegotiation unless our primary key is
+             * =
fully authenticated and past the deferred-auth/transition gate=2E
+        =
     */
+            time_t auth_deferred_left =3D ks->auth_deferred_expire=
 - now;
+            if (ks->authenticated !=3D KS_AUTH_TRUE || auth_deferr=
ed_left > 0)
+            {
+                msg(D_TLS_ERRORS,
+           =
         "TLS: refusing premature incoming renegotiation request for key-id=
 %d: "
+                    "auth=3D%s, auth_deferred_expire in %d seconds"=
,
+                    ks->key_id, ks_auth_name(ks->authenticated),
+      =
              auth_deferred_left > 0 ? (int)auth_deferred_left : 0);
+     =
           goto done;
+            }
+
             key_state_soft_reset(se=
ssion, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOF=
T_RESET_V1 s=3D%d sid=3D%s", i,

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Nu=
mber: 1478
Gerrit-PatchSet: 7
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Ant=
onio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--JZzwtoy833w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by Ralf=
 Lici=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">tls: reject i=
ncoming reneg request if primary key is not fully valid<br><br>Incoming P_C=
ONTROL_SOFT_RESET_V1 can arrive while the active key is not<br>yet fully va=
lid for renegotiation=2E This includes the window where we are<br>still wai=
ting for auth_deferred_expire (derived from handshake/reneg<br>timing), as =
well as cases where deferred or mid-session auth later<br>leaves the key no=
n-authenticated even though state is S_GENERATED_KEYS=2E<br><br>This patch =
keeps read_control_auth as the first gate, then rejects the<br>incoming ren=
egotiation requests unless the primary key is KS_AUTH_TRUE<br>and auth_defe=
rred_expire has passed=2E<br><br>The rejected request is not counted as a T=
LS error, since soft TLS<br>errors trigger an instance restart in TCP mode=
=2E<br><br>Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1<br>Signed-o=
ff-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1478<br>Message-Id: &lt;20261110115827=2E1649-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg41068=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed=
, 15 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1478/7</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index cdb=
94ed=2E=2Ed13a0d3 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3946,6 +3946,21 @@</s=
pan><br><span>                 goto error;</span><br><span>             }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * Do not allow incoming renegotiation unless our primary key is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             * fully authe=
nticated and past the deferred-auth/transition gate=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            time_t auth_deferred_left =3D ks=
-&gt;auth_deferred_expire - now;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (ks-&gt;authenticated !=3D KS_AUTH_TRUE || auth=
_deferred_left &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    &quot;TLS: refusing premature incoming reneg=
otiation request for key-id %d: &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    &quot;auth=3D%s, auth_deferred_expir=
e in %d seconds&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    ks-&gt;key_id, ks_auth_name(ks-&gt;authenticated),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    a=
uth_deferred_left &gt; 0 ? (int)auth_deferred_left : 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                goto done;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             key_sta=
te_soft_reset(session, NULL);</span><br><span> </span><br><span>           =
  dmsg(D_TLS_DEBUG, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=
=3D%s&quot;, i,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">change 1478</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I704c560fa23c032=
37d0f8adc30908a617265a5a1 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1478 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>=

<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--JZzwtoy833w=--


--===============8692899681939280790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8692899681939280790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8692899681939280790==--

