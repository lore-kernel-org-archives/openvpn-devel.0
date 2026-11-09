Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B226082BD5
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T5jjst4a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X2UqspCo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MBSdKbj1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=a4Nz7Gf0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hy0fZO/vjifhff5gE0MWmHqbP8BwxESKVnijrvev1lY=; b=T5jjst4aPryqBvoO7IRyb8/Nb2
	mhJi6tZmQcXt5fLH6RcKZ4z54CnT1Eh24tpqfXPJx/92xEGCnBpCvh1elPg7TNWhRfGP8WXDWScZy
	vODRXobeFPo4DGiFQzSQJ/IjKIJyXJff3npuWIeLvQUoZegKXi38NuvAf/dHSKa3D4a4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRYu-000000000GO-0Bfo;
	Mon, 09 Nov 2026 15:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRYs-000000000GI-2CTb
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=31vhbSRo8qDQ5cAVCktC0BSlEQnMMkQrb1SolBrJU/8=; b=X2UqspCofzylyBy3t/IkkobHBU
 bfj/ONV76W/5IDhmKdga4jx7HjfVplH/PydizYKL22oUbo9qfKfRIGbfe8aKUjjKwpohrlellZSvE
 eMxuSj+DyIMI3uaWIf/HFegjQfRWI5rXs6b/LBxsmgfq1a7ClYnIMVKZ92DX6wIQnI98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=31vhbSRo8qDQ5cAVCktC0BSlEQnMMkQrb1SolBrJU/8=; b=MBSdKbj1h1Cus0i4mUN8oZ4Hem
 /XKUaqYaoIvsKXb9iY/9pKf4rvpcAnGHQEssVoJ5sdljSTCrzGlJOZaJ48zhkWt7YmQ9eagbrsb+2
 7HKk/ocqpYCqQZE7vtQL7GxjWZO8jfbr04lkJtkievR2IxXGZH0SiouoZ+FG2ozilBnM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRYm-000000002VE-0hQx for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:45:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so12477315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794239121; x=1794843921; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=31vhbSRo8qDQ5cAVCktC0BSlEQnMMkQrb1SolBrJU/8=;
 b=a4Nz7Gf0nGalYP7m4fYo9ugY9xVYCxTp0Yk1dTjrjSUuNUnYMPq59K6kS595l8Bl6d
 A3h79CFt2TWoL5dU1gMKWetIaCAiApZWQhdSn0IyBluxvR6XFR982qflXT4r7x/CpQwe
 1tiE8obaf6OqKbNFRrzbC7+7ksieC2LeyZODcYy4rZFHkbjxvPso+9lRN3l/2TRCz2Gf
 7AuCrI7Lerp0KyZrkndZsEx7zL6A3p0Mxb2TmBf4jbugYuPPALCdlsGaB2TOKByyLs0R
 XcZ2ko8eEnAOoUbd500EAbJEZFbO7rm0J0rCi7fx8prNA2vY8j/E+onVXBjqwQX2INZP
 9UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239121; x=1794843921;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=31vhbSRo8qDQ5cAVCktC0BSlEQnMMkQrb1SolBrJU/8=;
 b=ETZnKQH5b33KZ2+hKAD1eEw+CbetPZqr2wps0M8l4yKeEPaINyZANrC8qpVldLNVLj
 rmqYpQM7fE2FYPTEW4xq8nomMFgNNpUdm8RxwLWE5FhntVWVU4SiQ0cdzk1XKrbTl1bk
 x0jymuF6/0KXyOyBadj1hd+wsxHiwgR0YCtAKVeuuEfqVlFnzW5d2Ny3/6QBi9X2pGFh
 lkW9qpeEFxyhnrOrm03Jshp8j2lqagcF3y2r/qn78pMrK1x1zgRagPG+pHiZ0CMaJx2I
 iShzvW8pSDnY92lcuSUNtWw88pkjpr+wFzYaPqPMoHgn94bm9hYqm/VVPjjgTWXQZGZA
 HoKA==
X-Gm-Message-State: APuU4Z8f5dj2MLTDycxAAR42KOjuFP4aFKO2UO3lDLMs400AiaNMA9c5
 HEYtKcwl/GZ6ukBrPmjqGcuHcihtSdVDjhSOfQSPFdieh181JZIYPqS5k+mWaeHyl+EOHfBCQ1Z
 auY5auD1NwX0Ec+bdYjuHU3FbbEYgCCqrN+h07I3ru+4GbR9QtztFJHUl9PR5tvWRhLwt8QV+aU
 Ypp00asQ==
X-Gm-Gg: AYBFou0TwVmVKp656f/m11KJtmt2MtH4LHloq5UUs2yEhdxbazz776gMyCKQL2BbxfH
 /9mQaNa/DJzDwRH0aNDc6OAkS7yQEUxxygaXk3zP2P2Tp2zfl5CtJ6Kw9QAtjRpXYpyOfdyn1nP
 JiwEeyJz/JQo0LStuRhST2o3VjpF9F2hfcyvRIJ7B5I3C7Gk8BPIXze1mXXTVdRgZGznGlUYYLh
 J9DRJSMYpB5p0pF2eHFRgTfBHQxRY0sGICHKGWlDHmkW0Rwl1syZhWq+c6dobSQ9Miyo1JTkulf
 Ulyswkw4LwH+F3BHGth/TW6ROxN2Uyqk2KGZcjeynbxFY9RgkLkrCIWT66ee/tGcCDj4o9XYZln
 0uC1R1xFDxZONBOUkmRXRCVmtMVb9wBZA/gjtNYAz7Iduk+fo7C/l9djdvoxkzf/p+O9l99Y7Ib
 kQ12JEGwP19f4WbTCTENbbYcxUeqbFtJ/dv5O3XqbdsNgqLpyT2Guz3No9aQIVlE9wWMyc0gvjp
 87tCwd+shJWcM5AtFvxqS+PPKRKSnLczz0Xdx1wjrKRz5LgsMEt5aAriQwQbTiN0RJCTinViumz
 lm8YbnDiS7azzLIpV4wb37awKAVJ51qU9avdQSadKFCfpE9MhVlMZV0aw9oIE0wgQTrEv8dNWu7
 q1b1NAXhyHc9cZJE1Dl8aERbIMgFW303rCisdb9bdaO6pmWcpaVpKSpQ48+3WN2Y7VIQXhsFX6F
 wTlModwvfhlgf2DQ==
X-Received: by 2002:a05:600c:8712:b0:4a2:150f:1610 with SMTP id
 5b1f17b1804b1-4b963c76bd1mr76415225e9.23.1794239121102; 
 Mon, 09 Nov 2026 07:45:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cb772e1sm281293365e9.0.2026.11.09.07.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:45:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:45:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
X-Gerrit-Change-Number: 2071
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2071?usp=email>
X-Gerrit-Commit: 91bff1b6be151c20e9db180b791b7ccb2765ce95
In-Reply-To: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
References: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk0MTM2MDAwLkk2MWEwZDE1OTYyNTg0YmM0OGNhZTQ1OTA2MmZlYWQwOGRjNDI1YWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81ec6085e964209f2bfa0c4aace19e1d8db6cb4d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRYm-000000002VE-0hQx
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 PACKET_TRUNCATION_CHECK
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5563940278485469613=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5563940278485469613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5o/RqhwhXaY="; charset=UTF-8

--5o/RqhwhXaY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Remove PACKET_TRUNCATION_=
CHECK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
PACKET_TRUNCATION_CHECK

This functionality checks if packets might be trun=
cated by checking
the length of the IPv4 header against the length of the b=
uffer to
see if a packet is truncated=2E

This function has been undocument=
ed and can be only enabled by
manually defining this define=2E

This might =
have been useful in 2005 when this function was added
but currently is rath=
er dead code that can a diagnose a problem
that is extremely rare or has be=
en already been fixed outside of
OpenVPN=2E

Change-Id: I61a0d15962584bc48c=
ae459062fead08dc425aeb
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2071
Message-Id: <20261031190839=2E30023-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg40382=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2E=
c
M src/openvpn/multi=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/proto=2Ec=

M src/openvpn/proto=2Eh
M src/openvpn/sig=2Ec
7 files changed, 89 insertio=
ns(+), 204 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/71/2071/2

diff --git a/src/openvpn/errlevel=2Eh b/src/op=
envpn/errlevel=2Eh
index d79efbb=2E=2Ee52cb65 100644
--- a/src/openvpn/errl=
evel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -49,105 +49,103 @@
  * of output=
=2E
  */
 
-#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages=
 displayed even at --verb 0 (fatal errors only) */
+#define M_VERB0 LOGLEV(=
0, 0, 0)                    /* Messages displayed even at --verb 0 (fatal e=
rrors only) */
 
-#define M_INFO LOGLEV(1, 0, 0)                      /* de=
fault informational messages */
+#define M_INFO LOGLEV(1, 0, 0)            =
         /* default informational messages */
 
-#define D_LINK_ERRORS    L=
OGLEV(1, 1, M_NONFATAL)   /* show link errors from main event loop */
-#def=
ine D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from encrypt=
/decrypt */
-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TL=
S control channel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFAT=
AL)   /* show hostname resolve errors */
-#define D_COMP_ERRORS    LOGLEV(1=
, 5, M_NONFATAL)   /* show compression errors */
-#define D_REPLAY_ERRORS  =
LOGLEV(1, 6, M_NONFATAL)   /* show packet replay errors */
-#define D_STREA=
M_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart =
*/
-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server impo=
rt option errors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /*=
 show multi-client server errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10,=
 M_NONFATAL)  /* show event=2E[ch] errors */
-#define D_PUSH_ERRORS    LOGL=
EV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST  =
  LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
-#define D=
_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
=
-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct ali=
gnments */
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link=
 errors from main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NO=
NFATAL)  /* show errors from encrypt/decrypt */
+#define D_TLS_ERRORS     L=
OGLEV(1, 3, M_NONFATAL)  /* show TLS control channel errors */
+#define D_R=
ESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */
=
+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression err=
ors */
+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet r=
eplay errors */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP =
stream error requiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_=
NONFATAL)  /* show server import option errors */
+#define D_MULTI_ERRORS  =
 LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server errors */
+#define D=
_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] errors */
+#=
define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors =
*/
+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id pe=
rsist errors */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show=
 fragmentation errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL=
) /* show bad struct alignments */
 
-#define D_HANDSHAKE LOGLEV(2, 20, 0) =
               /* show data & control channel handshakes */
-#define D_CLOS=
E     LOGLEV(2, 22, 0)                /* show socket and TUN/TAP close */
-=
#define D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy cont=
rol packets */
-#define D_ARGV      LOGLEV(2, 25, 0)                /* show=
 struct argv errors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)               =
/* show data & control channel handshakes */
+#define D_CLOSE     LOGLEV(2,=
 22, 0)               /* show socket and TUN/TAP close */
+#define D_PROXY =
    LOGLEV(2, 24, 0)               /* show http proxy control packets */
+#=
define D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv error=
s */
 
-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequenc=
y info from tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, =
0)            /* show simulated outage info from gremlin module */
-#define=
 D_GENKEY        LOGLEV(3, 31, 0)            /* print message after key gen=
eration */
-#define D_ROUTE         LOGLEV(3, 0, 0)             /* show rou=
tes added and deleted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32=
, 0)            /* show debugging info from TUN/TAP driver */
-#define D_RE=
START       LOGLEV(3, 33, 0)            /* show certain restart messages */=

-#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull inf=
o */
-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig =
pool info */
-#define D_AUTH          LOGLEV(3, 37, 0)            /* show u=
ser/pass auth info */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)            =
/* show point-to-multipoint low-freq debug info */
-#define D_PLUGIN       =
 LOGLEV(3, 39, 0)            /* show plugin calls */
-#define D_MANAGEMENT =
   LOGLEV(3, 40, 0)            /* show --management info */
-#define D_SCHE=
D_EXIT    LOGLEV(3, 41, 0)            /* show arming of scheduled exit */
-=
#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exc=
eeded messages */
-#define D_OSBUF         LOGLEV(3, 43, 0)            /* s=
how socket/tun/tap buffer sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0=
)            /* messages related to --port-share option */
-#define D_IFCON=
FIG      LOGLEV(3, 0, 0)             /* show ifconfig info (don't mute) */
=
-#define D_DCO           LOGLEV(3, 0, 0)             /* show DCO related me=
ssages */
+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           /* low freque=
ncy info from tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30=
, 0)           /* show simulated outage info from gremlin module */
+#defin=
e D_GENKEY        LOGLEV(3, 31, 0)           /* print message after key gen=
eration */
+#define D_ROUTE         LOGLEV(3, 0, 0)            /* show rout=
es added and deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32,=
 0)           /* show debugging info from TUN/TAP driver */
+#define D_REST=
ART       LOGLEV(3, 33, 0)           /* show certain restart messages */
+#=
define D_PUSH          LOGLEV(3, 34, 0)           /* show push/pull info */=

+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)           /* show ifconfig pool =
info */
+#define D_AUTH          LOGLEV(3, 37, 0)           /* show user/pa=
ss auth info */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show=
 point-to-multipoint low-freq debug info */
+#define D_PLUGIN        LOGLEV=
(3, 39, 0)           /* show plugin calls */
+#define D_MANAGEMENT    LOGLE=
V(3, 40, 0)           /* show --management info */
+#define D_SCHED_EXIT   =
 LOGLEV(3, 41, 0)           /* show arming of scheduled exit */
+#define D_=
ROUTE_QUOTA   LOGLEV(3, 42, 0)           /* show route quota exceeded messa=
ges */
+#define D_OSBUF         LOGLEV(3, 43, 0)           /* show socket/t=
un/tap buffer sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)           =
/* messages related to --port-share option */
+#define D_IFCONFIG      LOGL=
EV(3, 0, 0)            /* show ifconfig info (don't mute) */
+#define D_DCO=
           LOGLEV(3, 0, 0)            /* show DCO related messages */
 
-#d=
efine D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on=
 program initiation */
-#define D_LOW              LOGLEV(4, 52, 0)        =
 /* miscellaneous low-frequency debug info */
-#define D_DHCP_OPT         L=
OGLEV(4, 53, 0)         /* show DHCP options binary string */
-#define D_MB=
UF             LOGLEV(4, 54, 0)         /* mbuf=2E[ch] routines */
-#define=
 D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */
=
-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multi=
point packet drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         =
/* show medium frequency multi messages */
-#define D_X509_ATTR        LOGL=
EV(4, 59, 0)         /* show x509-track attributes on connection */
-#defin=
e D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium frequency init=
 messages */
-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show t=
erse MTU info */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* sh=
ow low-freq packet-id debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(=
4, 64, 0)         /* show medium-freq packet-id debugging info */
-#define =
D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about cipher i=
nit */
+#define D_SHOW_PARMS       LOGLEV(4, 50, 0)        /* show all para=
meters on program initiation */
+#define D_LOW              LOGLEV(4, 52, 0=
)        /* miscellaneous low-frequency debug info */
+#define D_DHCP_OPT  =
       LOGLEV(4, 53, 0)        /* show DHCP options binary string */
+#defi=
ne D_MBUF             LOGLEV(4, 54, 0)        /* mbuf=2E[ch] routines */
+#=
define D_MULTI_DROPPED    LOGLEV(4, 57, 0)        /* show point-to-multipoi=
nt packet drops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)        /* s=
how medium frequency multi messages */
+#define D_X509_ATTR        LOGLEV(4=
, 59, 0)        /* show x509-track attributes on connection */
+#define D_I=
NIT_MEDIUM      LOGLEV(4, 60, 0)        /* show medium frequency init messa=
ges */
+#define D_MTU_INFO         LOGLEV(4, 61, 0)        /* show terse MT=
U info */
+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* show low-f=
req packet-id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0=
)        /* show medium-freq packet-id debugging info */
+#define D_CIPHER_=
INIT      LOGLEV(4, 65, 0)        /* show messages about cipher init */
 
-=
#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to =
stdout for read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                 =
  /* Print 'R' or 'W' to stdout for read/write */
 
-#define D_RTNL        =
  LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level operations */
-#define=
 D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (=
terse) */
-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/=
TAP reads/writes */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /*=
 show TAP-Windows driver debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 6=
9, M_DEBUG)      /* show client NAT debug info */
-#define D_XKEY          =
LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */
-#define D_=
DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debu=
g messages */
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show =
signal related debug messages */
+#define D_RTNL          LOGLEV(6, 68, M_D=
EBUG)     /* show RTNL low level operations */
+#define D_LINK_RW       LOG=
LEV(6, 69, M_DEBUG)     /* show TCP/UDP reads/writes (terse) */
+#define D_=
TUN_RW        LOGLEV(6, 69, M_DEBUG)     /* show TUN/TAP reads/writes */
+#=
define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* show TAP-Windows drive=
r debug info */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show=
 client NAT debug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)  =
   /* show xkey-provider debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 6=
9, M_DEBUG)     /* show DCO related lowlevel debug messages */
+#define D_S=
IGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)     /* show signal related debug messag=
es */
 
-#define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data c=
hannel encryption keys */
-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEB=
UG) /* show data channel key source entropy */
-#define D_REL_LOW          =
  LOGLEV(7, 70, M_DEBUG) /* show low frequency info from reliable layer */
=
-#define D_FRAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragment debug=
ging info */
-#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low fr=
eq win32 I/O debugging info */
-#define D_MTU_DEBUG          LOGLEV(7, 70, =
M_DEBUG) /* show MTU debugging info */
-#define D_MULTI_DEBUG        LOGLEV=
(7, 70, M_DEBUG) /* show medium-freq multi debugging info */
-#define D_MSS=
                LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */
-#define =
D_COMP_LOW           LOGLEV(7, 70, M_DEBUG) /* show adaptive compression st=
ate changes */
-#define D_CONNECTION_LIST    LOGLEV(7, 70, M_DEBUG) /* show=
 <connection> list info */
-#define D_SCRIPT             LOGLEV(7, 70, M_DE=
BUG) /* show parms & env vars passed to scripts */
-#define D_SHOW_NET     =
      LOGLEV(7, 70, M_DEBUG) /* show routing table and adapter list */
-#de=
fine D_ROUTE_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose route=2E[c=
h] output */
-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DEBUG) /* no TLS=
 state for client */
-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /=
* show Win32 semaphore waits (low freq) */
-#define D_SEMAPHORE          LO=
GLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits */
-#define D_TEST_FILE =
         LOGLEV(7, 70, M_DEBUG) /* show test_file() calls */
-#define D_MAN=
AGEMENT_DEBUG   LOGLEV(3, 70, M_DEBUG) /* show --management debug info */
-=
#define D_PLUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show verbose plugin =
calls */
-#define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show socke=
t=2E[ch] debugging info */
-#define D_SHOW_PKCS11        LOGLEV(7, 70, M_DE=
BUG) /* show PKCS#11 actions */
-#define D_ALIGN_DEBUG        LOGLEV(7, 70,=
 M_DEBUG) /* show verbose struct alignment info */
-#define D_PACKET_TRUNC_=
DEBUG LOGLEV(7, 70, M_DEBUG) /* PACKET_TRUNCATION_CHECK verbose */
-#define=
 D_PING               LOGLEV(7, 70, M_DEBUG) /* PING send/receive messages =
*/
-#define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share proxy=
 debug */
-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG) /* show key =
selection for data channel */
-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M=
_DEBUG) /* show parse_line() errors in argv_parse_cmd */
-#define D_CRYPTO_=
DEBUG       LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypto=2Ec ro=
utines */
-#define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show pack=
et-id debugging info */
-#define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG=
) /* show push/pull debugging info */
-#define D_SHOW_OCC           LOGLEV(=
7, 74, M_DEBUG) /* show options compatibility string */
+#define D_SHOW_KEY=
S        LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
+#=
define D_SHOW_KEY_SOURCE  LOGLEV(7, 70, M_DEBUG)  /* show data channel key =
source entropy */
+#define D_REL_LOW          LOGLEV(7, 70, M_DEBUG)  /* sh=
ow low frequency info from reliable layer */
+#define D_FRAG_DEBUG       LO=
GLEV(7, 70, M_DEBUG)  /* show fragment debugging info */
+#define D_WIN32_I=
O_LOW     LOGLEV(7, 70, M_DEBUG)  /* low freq win32 I/O debugging info */
+=
#define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging in=
fo */
+#define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-fr=
eq multi debugging info */
+#define D_MSS              LOGLEV(7, 70, M_DEBU=
G)  /* show MSS adjustments */
+#define D_COMP_LOW         LOGLEV(7, 70, M_=
DEBUG)  /* show adaptive compression state changes */
+#define D_CONNECTION=
_LIST  LOGLEV(7, 70, M_DEBUG)  /* show <connection> list info */
+#define D=
_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed t=
o scripts */
+#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show ro=
uting table and adapter list */
+#define D_ROUTE_DEBUG      LOGLEV(7, 70, M=
_DEBUG)  /* show verbose route=2E[ch] output */
+#define D_TLS_STATE_ERRORS=
 LOGLEV(7, 70, M_DEBUG)  /* no TLS state for client */
+#define D_SEMAPHORE=
_LOW    LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */=

+#define D_SEMAPHORE        LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphor=
e waits */
+#define D_TEST_FILE        LOGLEV(7, 70, M_DEBUG)  /* show test=
_file() calls */
+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  /* sho=
w --management debug info */
+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DE=
BUG)  /* show verbose plugin calls */
+#define D_SOCKET_DEBUG     LOGLEV(7,=
 70, M_DEBUG)  /* show socket=2E[ch] debugging info */
+#define D_SHOW_PKCS=
11      LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */
+#define D_ALIGN=
_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alignment info *=
/
+#define D_PING             LOGLEV(7, 70, M_DEBUG)  /* PING send/receive =
messages */
+#define D_PS_PROXY_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* port sha=
re proxy debug */
+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBUG)  /* sh=
ow key selection for data channel */
+#define D_ARGV_PARSE_CMD   LOGLEV(7, =
70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
+#define D_C=
RYPTO_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto=
=2Ec routines */
+#define D_PID_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* sho=
w packet-id debugging info */
+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_D=
EBUG)  /* show push/pull debugging info */
+#define D_SHOW_OCC         LOGL=
EV(7, 74, M_DEBUG)  /* show options compatibility string */
 
 
 #define D_=
VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN tagging/untaggin=
g debug info */
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec
index eb41d03=2E=2E82cb6c9 100644
--- a/src/openvpn/forward=2Ec
+++ b/=
src/openvpn/forward=2Ec
@@ -1164,12 +1164,6 @@
         }
 #endif
 
-#ifdef=
 PACKET_TRUNCATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2Eb=
uf=2Elen; */
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c->=
c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "P=
OST_DECRYPT", &c->c2=2En_trunc_post_decrypt);
-#endif
-
         /*
       =
   * Set our "official" outgoing address, since
          * if buf=2Elen is=
 non-zero, we know the packet
@@ -1352,11 +1346,6 @@
     }
 #endif /* ifde=
f _WIN32 */
 
-#ifdef PACKET_TRUNCATION_CHECK
-    ipv4_packet_size_verify(=
BPTR(&c->c2=2Ebuf), BLEN(&c->c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-     =
                       "READ_TUN", &c->c2=2En_trunc_tun_read);
-#endif
-
  =
   /* Was TUN/TAP interface stopped? */
     if (tuntap_stop(c->c2=2Ebuf=2E=
len))
     {
@@ -1532,12 +1521,6 @@
         unsigned int flags =3D
       =
      PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLI=
ENT;
         process_ip_header(c, flags, &c->c2=2Ebuf, out_sock);
-
-#ifde=
f PACKET_TRUNCATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2E=
buf=2Elen; */
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c-=
>c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "=
PRE_ENCRYPT", &c->c2=2En_trunc_pre_encrypt);
-#endif
     }
     if (c->c2=
=2Ebuf=2Elen > 0)
     {
@@ -1937,11 +1920,6 @@
 #endif
         dmsg(D_TUN=
_RW, "TUN WRITE [%d]", BLEN(&c->c2=2Eto_tun));
 
-#ifdef PACKET_TRUNCATION_=
CHECK
-        ipv4_packet_size_verify(BPTR(&c->c2=2Eto_tun), BLEN(&c->c2=
=2Eto_tun), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "=
WRITE_TUN", &c->c2=2En_trunc_tun_write);
-#endif
-
 #ifdef _WIN32
         =
size =3D tun_write_win32(c->c1=2Etuntap, &c->c2=2Eto_tun);
 #else
diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 77ebfae=2E=2E03844f=
b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -981,31=
 +981,6 @@
         status_printf(so, "ERROR: bad status format version num=
ber");
     }
 
-#ifdef PACKET_TRUNCATION_CHECK
-    {
-        status_prin=
tf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encryp=
t Trunc,Post-decrypt Trunc");
-        hash_iterator_init(m->hash, &hi);
- =
       while ((he =3D hash_iterator_next(&hi)))
-        {
-            str=
uct gc_arena gc =3D gc_new();
-            const struct multi_instance *mi =
=3D (struct multi_instance *)he->value;
-
-            if (!mi->halt)
-    =
        {
-                status_printf(so,
-                             =
 "ERRORS,%s," counter_format "," counter_format "," counter_format
-       =
                       "," counter_format,
-                              t=
ls_common_name(mi->context=2Ec2=2Etls_multi, false),
-                     =
         m->top=2Ec2=2En_trunc_tun_read, mi->context=2Ec2=2En_trunc_tun_wri=
te,
-                              mi->context=2Ec2=2En_trunc_pre_encrypt,
=
-                              mi->context=2Ec2=2En_trunc_post_decrypt);
- =
           }
-            gc_free(&gc);
-        }
-        hash_iterator_f=
ree(&hi);
-    }
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
-
     status_=
flush(so);
     gc_free(&gc_top);
 
diff --git a/src/openvpn/openvpn=2Eh b/=
src/openvpn/openvpn=2Eh
index cdd02b6=2E=2E970baa9 100644
--- a/src/openvpn=
/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -269,12 +269,6 @@
     counte=
r_type link_read_bytes_auth;
     counter_type link_write_bytes;
     count=
er_type dco_write_bytes;
-#ifdef PACKET_TRUNCATION_CHECK
-    counter_type =
n_trunc_tun_read;
-    counter_type n_trunc_tun_write;
-    counter_type n_=
trunc_pre_encrypt;
-    counter_type n_trunc_post_decrypt;
-#endif
 
     /=
*
      * Timer objects for ping and inactivity
diff --git a/src/openvpn/pr=
oto=2Ec b/src/openvpn/proto=2Ec
index 2cdb147=2E=2Ea2b07df 100644
--- a/src=
/openvpn/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -163,52 +163,3 @@
     /*=
 Take the one's complement of sum */
     return ((uint16_t)~sum);
 }
-
-#i=
fdef PACKET_TRUNCATION_CHECK
-
-void
-ipv4_packet_size_verify(const uint8_t=
 *data, const int size, const int tunnel_type,
-                        con=
st char *prefix, counter_type *errors)
-{
-    if (size > 0)
-    {
-      =
  struct buffer buf;
-
-        buf_set_read(&buf, data, size);
-
-        =
if (is_ipv4(tunnel_type, &buf))
-        {
-            const struct openvp=
n_iphdr *pip;
-            int hlen;
-            int totlen;
-            =
const char *msgstr =3D "PACKET SIZE INFO";
-            msglvl_t msglevel =
=3D D_PACKET_TRUNC_DEBUG;
-
-            if (BLENZ(&buf) < sizeof(struct op=
envpn_iphdr))
-            {
-                return;
-            }
-
-   =
         verify_align_4(&buf);
-            pip =3D (struct openvpn_iphdr *=
)BPTR(&buf);
-
-            hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);=

-            totlen =3D ntohs(pip->tot_len);
-
-            if (BLEN(&buf)=
 !=3D totlen)
-            {
-                msgstr =3D "PACKET TRUNCATION=
 ERROR";
-                msglevel =3D D_PACKET_TRUNC_ERR;
-               =
 if (errors)
-                {
-                    ++(*errors);
-        =
        }
-            }
-
-            msg(msglevel, "%s %s: size=3D%d tot=
len=3D%d hlen=3D%d errcount=3D" counter_format, msgstr,
-                pr=
efix, BLEN(&buf), totlen, hlen, errors ? *errors : (counter_type)0);
-     =
   }
-    }
-}
-
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
diff --git a/s=
rc/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 1665751=2E=2E14f9264 100=
644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -307,11 +307=
,6 @@
 uint16_t ip_checksum(const sa_family_t af, const uint8_t *payload, c=
onst int len_payload,
                      const uint8_t *src_addr, const =
uint8_t *dest_addr, const int proto);
 
-#ifdef PACKET_TRUNCATION_CHECK
-vo=
id ipv4_packet_size_verify(const uint8_t *data, const int size, const int t=
unnel_type,
-                             const char *prefix, counter_type =
*errors);
-
-#endif
 
 #define OPENVPN_8021Q_MIN_VID 1
 #define OPENVPN_802=
1Q_MAX_VID 4094
diff --git a/src/openvpn/sig=2Ec b/src/openvpn/sig=2Ec
inde=
x 81654f9=2E=2E0cdb01a 100644
--- a/src/openvpn/sig=2Ec
+++ b/src/openvpn/s=
ig=2Ec
@@ -504,12 +504,6 @@
         comp_print_stats(c->c2=2Ecomp_context,=
 so);
     }
 #endif
-#ifdef PACKET_TRUNCATION_CHECK
-    status_printf(so,=
 "TUN read truncations," counter_format, c->c2=2En_trunc_tun_read);
-    st=
atus_printf(so, "TUN write truncations," counter_format, c->c2=2En_trunc_tu=
n_write);
-    status_printf(so, "Pre-encrypt truncations," counter_format,=
 c->c2=2En_trunc_pre_encrypt);
-    status_printf(so, "Post-decrypt truncat=
ions," counter_format, c->c2=2En_trunc_post_decrypt);
-#endif
 #ifdef _WIN3=
2
     if (tuntap_defined(c->c1=2Etuntap))
     {

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425ae=
b
Gerrit-Change-Number: 2071
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--5o/RqhwhXaY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/207=
1?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rem=
ove PACKET_TRUNCATION_CHECK<br><br>This functionality checks if packets mig=
ht be truncated by checking<br>the length of the IPv4 header against the le=
ngth of the buffer to<br>see if a packet is truncated=2E<br><br>This functi=
on has been undocumented and can be only enabled by<br>manually defining th=
is define=2E<br><br>This might have been useful in 2005 when this function =
was added<br>but currently is rather dead code that can a diagnose a proble=
m<br>that is extremely rare or has been already been fixed outside of<br>Op=
enVPN=2E<br><br>Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2071<br>Message-Id: &lt;20261031190839=2E30023-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg40382=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/errlevel=2Eh<br>M sr=
c/openvpn/forward=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/openvpn=
=2Eh<br>M src/openvpn/proto=2Ec<br>M src/openvpn/proto=2Eh<br>M src/openvpn=
/sig=2Ec<br>7 files changed, 89 insertions(+), 204 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/71/2071/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn=
/errlevel=2Eh</span><br><span>index d79efbb=2E=2Ee52cb65 100644</span><br><=
span>--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b/src/openvpn/errle=
vel=2Eh</span><br><span>@@ -49,105 +49,103 @@</span><br><span>  * of output=
=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define M_VERB0 LOGLEV(0, 0, 0)                     /*=
 Messages displayed even at --verb 0 (fatal errors only) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define M_VERB0 LOGLEV(0, 0, 0)    =
                /* Messages displayed even at --verb 0 (fatal errors only) =
*/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define M_INFO LOGLEV(1, 0, 0)                      /* default informational=
 messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 M_INFO LOGLEV(1, 0, 0)                     /* default informational messag=
es */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)   /* show link errors f=
rom main event loop */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from en=
crypt/decrypt */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TLS control channel =
errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_RE=
SOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* show hostname resolve errors */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_COMP_ERRORS =
   LOGLEV(1, 5, M_NONFATAL)   /* show compression errors */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_REPLAY_ERRORS  LOGLEV(1, 6,=
 M_NONFATAL)   /* show packet replay errors */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL) =
  /* TCP stream error requiring restart */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /*=
 show server import option errors */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show =
multi-client server errors */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event=
=2E[ch] errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST=
    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_FRAG_ERRORS    LOGLE=
V(1, 13, M_NONFATAL)  /* show fragmentation errors */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NO=
NFATAL)  /* show bad struct alignments */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /*=
 show link errors from main event loop */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)  /*=
 show errors from encrypt/decrypt */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)  /* show=
 TLS control channel errors */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostn=
ame resolve errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression er=
rors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_RE=
PLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay errors */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_STREAM_ERRORS =
 LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error requiring restart */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_IMPORT_ERRORS  LO=
GLEV(1, 8, M_NONFATAL)  /* show server import option errors */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_ERRORS   LOGLEV(=
1, 9, M_NONFATAL)  /* show multi-client server errors */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_EVENT_ERRORS   LOGLEV(1, 10,=
 M_NONFATAL) /* show event=2E[ch] errors */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) =
/* show push/pull errors */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_i=
d persist errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation er=
rors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_AL=
IGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alignments */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 D_HANDSHAKE LOGLEV(2, 20, 0)                /* show data &amp; control cha=
nnel handshakes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_CLOSE     LOGLEV(2, 22, 0)                /* show socket and TUN/TAP=
 close */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PR=
OXY     LOGLEV(2, 24, 0)                /* show http proxy control packets =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ARGV     =
 LOGLEV(2, 25, 0)                /* show struct argv errors */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_HANDSHAKE LOGLEV(2, 20=
, 0)               /* show data &amp; control channel handshakes */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_CLOSE     LOGLEV(=
2, 22, 0)               /* show socket and TUN/TAP close */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define D_PROXY     LOGLEV(2, 24, 0=
)               /* show http proxy control packets */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_ARGV      LOGLEV(2, 25, 0)     =
          /* show struct argv errors */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0=
)            /* low frequency info from tls_session routines */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_GREMLIN       LOGLEV(3,=
 30, 0)            /* show simulated outage info from gremlin module */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_GENKEY        L=
OGLEV(3, 31, 0)            /* print message after key generation */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE         LOGLE=
V(3, 0, 0)             /* show routes added and deleted (don&#39;t mute) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TUNTAP_INFO=
   LOGLEV(3, 32, 0)            /* show debugging info from TUN/TAP driver *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_RESTART   =
    LOGLEV(3, 33, 0)            /* show certain restart messages */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PUSH          LOGLE=
V(3, 34, 0)            /* show push/pull info */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)        =
    /* show ifconfig pool info */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_AUTH          LOGLEV(3, 37, 0)            /* show use=
r/pass auth info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show point-to-multipoi=
nt low-freq debug info */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define D_PLUGIN        LOGLEV(3, 39, 0)            /* show plugin call=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MANAGEM=
ENT    LOGLEV(3, 40, 0)            /* show --management info */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_SCHED_EXIT    LOGLEV(3,=
 41, 0)            /* show arming of scheduled exit */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)  =
          /* show route quota exceeded messages */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_OSBUF         LOGLEV(3, 43, 0)      =
      /* show socket/tun/tap buffer sizes */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define D_PS_PROXY      LOGLEV(3, 44, 0)            =
/* messages related to --port-share option */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_IFCONFIG      LOGLEV(3, 0, 0)            =
 /* show ifconfig info (don&#39;t mute) */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_DCO           LOGLEV(3, 0, 0)             /*=
 show DCO related messages */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           /* low frequen=
cy info from tls_session routines */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_GREMLIN       LOGLEV(3, 30, 0)           /* show=
 simulated outage info from gremlin module */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define D_GENKEY        LOGLEV(3, 31, 0)         =
  /* print message after key generation */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define D_ROUTE         LOGLEV(3, 0, 0)            /=
* show routes added and deleted (don&#39;t mute) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_TUNTAP_INFO   LOGLEV(3, 32, 0) =
          /* show debugging info from TUN/TAP driver */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define D_RESTART       LOGLEV(3, 33, 0=
)           /* show certain restart messages */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define D_PUSH          LOGLEV(3, 34, 0)       =
    /* show push/pull info */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)           /* show ifconf=
ig pool info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_AUTH          LOGLEV(3, 37, 0)           /* show user/pass auth info =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_L=
OW     LOGLEV(3, 38, 0)           /* show point-to-multipoint low-freq debu=
g info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
PLUGIN        LOGLEV(3, 39, 0)           /* show plugin calls */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_MANAGEMENT    LOGLEV=
(3, 40, 0)           /* show --management info */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_SCHED_EXIT    LOGLEV(3, 41, 0)     =
      /* show arming of scheduled exit */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)           /*=
 show route quota exceeded messages */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define D_OSBUF         LOGLEV(3, 43, 0)           /* sh=
ow socket/tun/tap buffer sizes */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_PS_PROXY      LOGLEV(3, 44, 0)           /* message=
s related to --port-share option */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define D_IFCONFIG      LOGLEV(3, 0, 0)            /* show =
ifconfig info (don&#39;t mute) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_DCO           LOGLEV(3, 0, 0)            /* show DC=
O related messages */</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* sh=
ow all parameters on program initiation */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_LOW              LOGLEV(4, 52, 0)         /*=
 miscellaneous low-frequency debug info */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_DHCP_OPT         LOGLEV(4, 53, 0)         /*=
 show DHCP options binary string */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_MBUF             LOGLEV(4, 54, 0)         /* mbuf=
=2E[ch] routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHEC=
K */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_D=
ROPPED    LOGLEV(4, 57, 0)         /* show point-to-multipoint packet drops=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_ME=
DIUM     LOGLEV(4, 58, 0)         /* show medium frequency multi messages *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_X509_ATTR =
       LOGLEV(4, 59, 0)         /* show x509-track attributes on connection=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_INIT_MED=
IUM      LOGLEV(4, 60, 0)         /* show medium frequency init messages */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MTU_INFO   =
      LOGLEV(4, 61, 0)         /* show terse MTU info */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBUG_LOW    LOGLEV(4, 63,=
 0)         /* show low-freq packet-id debugging info */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64,=
 0)         /* show medium-freq packet-id debugging info */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_CIPHER_INIT      LOGLEV(4, =
65, 0)         /* show messages about cipher init */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_PARMS       LOGLEV(4, 50, =
0)        /* show all parameters on program initiation */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_LOW              LOGLEV(4, =
52, 0)        /* miscellaneous low-frequency debug info */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_DHCP_OPT         LOGLEV(4,=
 53, 0)        /* show DHCP options binary string */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_MBUF             LOGLEV(4, 54, =
0)        /* mbuf=2E[ch] routines */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)        /* show=
 point-to-multipoint packet drops */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)        /* show=
 medium frequency multi messages */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define D_X509_ATTR        LOGLEV(4, 59, 0)        /* show =
x509-track attributes on connection */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)        /* sh=
ow medium frequency init messages */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_MTU_INFO         LOGLEV(4, 61, 0)        /* show=
 terse MTU info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* show low-freq packet-i=
d debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)        /* show medium-freq pack=
et-id debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_CIPHER_INIT      LOGLEV(4, 65, 0)        /* show messages abo=
ut cipher init */</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print =
&#39;R&#39; or &#39;W&#39; to stdout for read/write */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define D_LOG_RW LOGLEV(5, 0, 0)        =
           /* Print &#39;R&#39; or &#39;W&#39; to stdout for read/write */<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level oper=
ations */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LI=
NK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (terse=
) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TUN_RW =
       LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP reads/writes */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TAP_WIN_DEBUG LOGLEV=
(6, 69, M_DEBUG)      /* show TAP-Windows driver debug info */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define D_CLIENT_NAT    LOGLEV(6, =
69, M_DEBUG)      /* show client NAT debug info */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_XKEY          LOGLEV(6, 69, M_DEBUG)=
      /* show xkey-provider debug info */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* =
show DCO related lowlevel debug messages */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /=
* show signal related debug messages */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)     /* s=
how RTNL low level operations */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)     /* show TCP=
/UDP reads/writes (terse) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)     /* show TUN/TAP=
 reads/writes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* show TAP-Windows driver =
debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show client NAT debug info =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_XKEY   =
       LOGLEV(6, 69, M_DEBUG)     /* show xkey-provider debug info */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_DCO_DEBUG     L=
OGLEV(6, 69, M_DEBUG)     /* show DCO related lowlevel debug messages */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SIGNAL_DEBUG=
  LOGLEV(6, 69, M_DEBUG)     /* show signal related debug messages */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data channel encryption =
keys */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW=
_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data channel key source entro=
py */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_REL_LO=
W            LOGLEV(7, 70, M_DEBUG) /* show low frequency info from reliabl=
e layer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_F=
RAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragment debugging info */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_WIN32_IO_LO=
W       LOGLEV(7, 70, M_DEBUG) /* low freq win32 I/O debugging info */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MTU_DEBUG       =
   LOGLEV(7, 70, M_DEBUG) /* show MTU debugging info */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_DEBUG        LOGLEV(7, 70=
, M_DEBUG) /* show medium-freq multi debugging info */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define D_MSS                LOGLEV(7, 70,=
 M_DEBUG) /* show MSS adjustments */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_COMP_LOW           LOGLEV(7, 70, M_DEBUG) /* show =
adaptive compression state changes */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_CONNECTION_LIST    LOGLEV(7, 70, M_DEBUG) /* show=
 &lt;connection&gt; list info */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_SCRIPT             LOGLEV(7, 70, M_DEBUG) /* show parm=
s &amp; env vars passed to scripts */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_SHOW_NET           LOGLEV(7, 70, M_DEBUG) /* show=
 routing table and adapter list */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define D_ROUTE_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show ve=
rbose route=2E[ch] output */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DEBUG) /* no TLS state =
for client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits (=
low freq) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_SEMAPHORE          LOGLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TEST_FILE  =
        LOGLEV(7, 70, M_DEBUG) /* show test_file() calls */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_MANAGEMENT_DEBUG   LOGLEV(3=
, 70, M_DEBUG) /* show --management debug info */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_PLUGIN_DEBUG       LOGLEV(7, 70, M_DE=
BUG) /* show verbose plugin calls */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show =
socket=2E[ch] debugging info */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define D_SHOW_PKCS11        LOGLEV(7, 70, M_DEBUG) /* show PKCS#=
11 actions */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
D_ALIGN_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose struct alignmen=
t info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PA=
CKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG) /* PACKET_TRUNCATION_CHECK verbose =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PING     =
          LOGLEV(7, 70, M_DEBUG) /* PING send/receive messages */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PS_PROXY_DEBUG     LO=
GLEV(7, 70, M_DEBUG) /* port share proxy debug */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DE=
BUG) /* show key selection for data channel */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG=
) /* show parse_line() errors in argv_parse_cmd */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_D=
EBUG) /* show detailed info from crypto=2Ec routines */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBUG          LOGLEV(7, 70=
, M_DEBUG) /* show packet-id debugging info */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG=
) /* show push/pull debugging info */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_SHOW_OCC           LOGLEV(7, 74, M_DEBUG) /* show=
 options compatibility string */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define D_SHOW_KEYS        LOGLEV(7, 70, M_DEBUG)  /* show dat=
a channel encryption keys */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_SHOW_KEY_SOURCE  LOGLEV(7, 70, M_DEBUG)  /* show data ch=
annel key source entropy */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define D_REL_LOW          LOGLEV(7, 70, M_DEBUG)  /* show low freq=
uency info from reliable layer */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_FRAG_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show fr=
agment debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define D_WIN32_IO_LOW     LOGLEV(7, 70, M_DEBUG)  /* low freq win32 I=
/O debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging i=
nfo */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MUL=
TI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging i=
nfo */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MSS=
              LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_COMP_LOW         LOG=
LEV(7, 70, M_DEBUG)  /* show adaptive compression state changes */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_CONNECTION_LIST  L=
OGLEV(7, 70, M_DEBUG)  /* show &lt;connection&gt; list info */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_SCRIPT           LOGLE=
V(7, 70, M_DEBUG)  /* show parms &amp; env vars passed to scripts */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_NET        =
 LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE_DEBUG      L=
OGLEV(7, 70, M_DEBUG)  /* show verbose route=2E[ch] output */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_STATE_ERRORS LOGLEV=
(7, 70, M_DEBUG)  /* no TLS state for client */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define D_SEMAPHORE_LOW    LOGLEV(7, 70, M_DEBU=
G)  /* show Win32 semaphore waits (low freq) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define D_SEMAPHORE        LOGLEV(7, 70, M_DEBU=
G)  /* show Win32 semaphore waits */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_TEST_FILE        LOGLEV(7, 70, M_DEBUG)  /* show=
 test_file() calls */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  /* show --management d=
ebug info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show verbose plugin calls */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SOCKET_DE=
BUG     LOGLEV(7, 70, M_DEBUG)  /* show socket=2E[ch] debugging info */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_PKCS11  =
    LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define D_ALIGN_DEBUG      LOGLEV(7, 70,=
 M_DEBUG)  /* show verbose struct alignment info */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_PING             LOGLEV(7, 70, =
M_DEBUG)  /* PING send/receive messages */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define D_PS_PROXY_DEBUG   LOGLEV(7, 70, M_DEBUG)  /=
* port share proxy debug */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBUG)  /* show key sele=
ction for data channel */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_ARGV_PARSE_CMD   LOGLEV(7, 70, M_DEBUG)  /* show parse_line=
() errors in argv_parse_cmd */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_CRYPTO_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show detai=
led info from crypto=2Ec routines */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_PID_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show=
 packet-id debugging info */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_DEBUG)  /* show push/pu=
ll debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define D_SHOW_OCC         LOGLEV(7, 74, M_DEBUG)  /* show options compati=
bility string */</span><br><span> </span><br><span> </span><br><span> #defi=
ne D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN tagging/unt=
agging debug info */</span><br><span>diff --git a/src/openvpn/forward=2Ec b=
/src/openvpn/forward=2Ec</span><br><span>index eb41d03=2E=2E82cb6c9 100644<=
/span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/ope=
nvpn/forward=2Ec</span><br><span>@@ -1164,12 +1164,6 @@</span><br><span>   =
      }</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* if (c-&gt;c2=2Ebuf=2Elen &g=
t; 1) --c-&gt;c2=2Ebuf=2Elen; */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2Ebuf), BLEN(=
&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                &quot;POST_=
DECRYPT&quot;, &amp;c-&gt;c2=2En_trunc_post_decrypt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>         /*</span><br><span>          * S=
et our &quot;official&quot; outgoing address, since</span><br><span>       =
   * if buf=2Elen is non-zero, we know the packet</span><br><span>@@ -1352,=
11 +1346,6 @@</span><br><span>     }</span><br><span> #endif /* ifdef _WIN3=
2 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2Ebuf), BLEN(&amp;=
c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                            &quot;READ_TUN&quot;=
, &amp;c-&gt;c2=2En_trunc_tun_read);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     /* Was TUN/TAP interface stopped? */</span><br><span>=
     if (tuntap_stop(c-&gt;c2=2Ebuf=2Elen))</span><br><span>     {</span><b=
r><span>@@ -1532,12 +1521,6 @@</span><br><span>         unsigned int flags =
=3D</span><br><span>             PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_=
NAT | PIPV6_ICMP_NOHOST_CLIENT;</span><br><span>         process_ip_header(=
c, flags, &amp;c-&gt;c2=2Ebuf, out_sock);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        /* if (c-&gt;c2=2Ebuf=2Elen &gt; 1) --c-&gt;c2=2Ebuf=2Elen;=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ipv4_packe=
t_size_verify(BPTR(&amp;c-&gt;c2=2Ebuf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_=
TYPE(c-&gt;c1=2Etuntap),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                &quot;PRE_ENCRYPT&quot;, &amp;c-&gt;c2=
=2En_trunc_pre_encrypt);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span>     }</span><br><span>     if (c-&gt;c2=2Ebuf=2E=
len &gt; 0)</span><br><span>     {</span><br><span>@@ -1937,11 +1920,6 @@</=
span><br><span> #endif</span><br><span>         dmsg(D_TUN_RW, &quot;TUN WR=
ITE [%d]&quot;, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ipv4_packet_siz=
e_verify(BPTR(&amp;c-&gt;c2=2Eto_tun), BLEN(&amp;c-&gt;c2=2Eto_tun), TUNNEL=
_TYPE(c-&gt;c1=2Etuntap),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                &quot;WRITE_TUN&quot;, &amp;c-&gt;c2=2E=
n_trunc_tun_write);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 #ifdef _WIN32</span><br><span>         size =3D tun_write_win32(c-&gt;c1=
=2Etuntap, &amp;c-&gt;c2=2Eto_tun);</span><br><span> #else</span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index 77ebfae=2E=2E03844fb 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -981,31=
 +981,6 @@</span><br><span>         status_printf(so, &quot;ERROR: bad stat=
us format version number&quot;);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATIO=
N_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        status_printf(so, &quo=
t;HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trun=
c,Post-decrypt Trunc&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        hash_iterator_init(m-&gt;hash, &amp;hi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        while ((he =3D hash_iterator_next=
(&amp;hi)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            const struct multi_instance *mi =3D (struct multi_instance *)h=
e-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (!mi-&gt;halt)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                status_printf(=
so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
            &quot;ERRORS,%s,&quot; counter_format &quot;,&quot; counter_for=
mat &quot;,&quot; counter_format</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                              &quot;,&quot; counter_format,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
    tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              m-&gt;=
top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tun_write,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
   mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                              mi-&gt;context=2Ec2=
=2En_trunc_post_decrypt);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
hash_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 ifdef PACKET_TRUNCATION_CHECK */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     status_flush(so);</span><br><span>     gc=
_free(&amp;gc_top);</span><br><span> </span><br><span>diff --git a/src/open=
vpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index cdd02b6=2E=
=2E970baa9 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><=
span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -269,12 +269,6 @@</sp=
an><br><span>     counter_type link_read_bytes_auth;</span><br><span>     c=
ounter_type link_write_bytes;</span><br><span>     counter_type dco_write_b=
ytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TR=
UNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cou=
nter_type n_trunc_tun_read;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    counter_type n_trunc_tun_write;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    counter_type n_trunc_pre_encrypt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    counter_type n_trunc_post_decrypt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
> </span><br><span>     /*</span><br><span>      * Timer objects for ping a=
nd inactivity</span><br><span>diff --git a/src/openvpn/proto=2Ec b/src/open=
vpn/proto=2Ec</span><br><span>index 2cdb147=2E=2Ea2b07df 100644</span><br><=
span>--- a/src/openvpn/proto=2Ec</span><br><span>+++ b/src/openvpn/proto=2E=
c</span><br><span>@@ -163,52 +163,3 @@</span><br><span>     /* Take the one=
&#39;s complement of sum */</span><br><span>     return ((uint16_t)~sum);</=
span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_=
CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ipv4_packet_size_verify(const uint8_t *data, const int=
 size, const int tunnel_type,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        const char *prefix, counter_type *errors)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct buffer buf;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        buf_set_read(&amp;buf, data, size);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (is_ipv4(tunnel_type, &amp;buf))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            const struct openvpn_iphdr *pip;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            int hlen;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            int totlen;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            const char *msgstr =3D &quo=
t;PACKET SIZE INFO&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msglvl_t msglevel =3D D_PACKET_TRUNC_DEBUG;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (BLENZ(&amp;buf) &lt; sizeof(struct openvpn=
_iphdr))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                retur=
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            verify_align_4(&amp;buf);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            pip =3D (struct open=
vpn_iphdr *)BPTR(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hle=
n =3D OPENVPN_IPH_GET_LEN(pip-&gt;version_len);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            totlen =3D ntohs(pip-&gt;tot_len);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(&amp;buf) !=3D totlen)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                msgstr =3D &q=
uot;PACKET TRUNCATION ERROR&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                msglevel =3D D_PACKET_TRUNC_ERR;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (errors)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    ++(*errors);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(msglevel, &quot;%s %s: size=3D%d totlen=
=3D%d hlen=3D%d errcount=3D&quot; counter_format, msgstr,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                prefix, BLEN(&amp;buf),=
 totlen, hlen, errors ? *errors : (counter_type)0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef PACKET_TRUNCATION_CHE=
CK */</span><br><span>diff --git a/src/openvpn/proto=2Eh b/src/openvpn/prot=
o=2Eh</span><br><span>index 1665751=2E=2E14f9264 100644</span><br><span>---=
 a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</span>=
<br><span>@@ -307,11 +307,6 @@</span><br><span> uint16_t ip_checksum(const =
sa_family_t af, const uint8_t *payload, const int len_payload,</span><br><s=
pan>                      const uint8_t *src_addr, const uint8_t *dest_addr=
, const int proto);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void ipv4_packet_size_verify(const uint8_t *data, =
const int size, const int tunnel_type,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                             const char *prefix, counter_t=
ype *errors);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </spa=
n><br><span> #define OPENVPN_8021Q_MIN_VID 1</span><br><span> #define OPENV=
PN_8021Q_MAX_VID 4094</span><br><span>diff --git a/src/openvpn/sig=2Ec b/sr=
c/openvpn/sig=2Ec</span><br><span>index 81654f9=2E=2E0cdb01a 100644</span><=
br><span>--- a/src/openvpn/sig=2Ec</span><br><span>+++ b/src/openvpn/sig=2E=
c</span><br><span>@@ -504,12 +504,6 @@</span><br><span>         comp_print_=
stats(c-&gt;c2=2Ecomp_context, so);</span><br><span>     }</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_=
TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatus_printf(so, &quot;TUN read truncations,&quot; counter_format, c-&gt;c2=
=2En_trunc_tun_read);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    status_printf(so, &quot;TUN write truncations,&quot; counter_format, c-=
&gt;c2=2En_trunc_tun_write);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    status_printf(so, &quot;Pre-encrypt truncations,&quot; counter_f=
ormat, c-&gt;c2=2En_trunc_pre_encrypt);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    status_printf(so, &quot;Post-decrypt truncations,&quo=
t; counter_format, c-&gt;c2=2En_trunc_post_decrypt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #ifdef _WIN32</span=
><br><span>     if (tuntap_defined(c-&gt;c1=2Etuntap))</span><br><span>    =
 {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2071?usp=3Demail">change 2071</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I61a0d15962584bc48cae459062fe=
ad08dc425aeb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2071=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--5o/RqhwhXaY=--


--===============5563940278485469613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5563940278485469613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5563940278485469613==--

