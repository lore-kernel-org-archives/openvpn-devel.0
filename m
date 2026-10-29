Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841C606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Au/jZyqq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Iei1WSRL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hoSSkQPT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JLEzAe8O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=a7YOWvI3BtIYkIDJBHqIRwlmpg6cFvhWWaicWTFjVrw=; b=Au/jZyqqnf3pCuJ2Bl+JsY2+2I
	tecXs28bbZesiYwE2vsu8pNkypGxvI/fTSekdvcSYWGEoKG7L6MvG/BMzHSELCStI6LpHz/SMRVGN
	PArS6fcEtBiM17qVDNQwkdrgWbfCAZkC+mgQveF61sufUyOQTuC01MQMmIAP+SYanUsI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTjG-000000000Oh-0QcP;
	Thu, 29 Oct 2026 17:15:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTjE-000000000ON-0Tz3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+hzxhIt4t5oahAQVNebDl8x47p7yjKQrg298hruWxpc=; b=Iei1WSRL1NoXfowzwrRXTz496H
 rSZAzCwN95hd2RrIeC9Bt8ccUKZc1k8xOCnj2oB/EpkKYcXan/+9u4kOoLoio1FsECPGZjDorxXzr
 q2rjeQs3Q6R2daYZehNeXMdS7Y6NFjSVk6OuSBT44bAjBkPsNUV1Uz/RELmjutquNjv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+hzxhIt4t5oahAQVNebDl8x47p7yjKQrg298hruWxpc=; b=hoSSkQPTrBcpImyDYOaNo8fXeS
 O9dCvs5ukSeOM3gv7MdCD34Ogt/hkLvtzNheugs9rut6t6mmSdyITr2YqikT4stOd1+it61f8fIps
 EOIyYdLbTYFbVFWrqz7QlKiLqy8ny55l8AG3UbfeJBSOYWEJjDD+18kNoQV75myGBCsU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTjA-000000000nf-3uKB for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso24671505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294142; x=1793898942; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+hzxhIt4t5oahAQVNebDl8x47p7yjKQrg298hruWxpc=;
 b=JLEzAe8OGiyXIThAD8Z/oWZX4rENOTUvweVEzWP6JMqFbuyTHSIa94WGLvHAZgCpTt
 F1u9UI+NT5RlIU/PnKuKRp5kJGe2ufgudEhiZlMEm+lmNtFg4mvFGTVZMWKEujPEYDzi
 bsc/bJasDQ4Wqjp2OjAedCIua+l7FYdz2DameBQrU9iKfvni6vAk1cnK3/y1uctfh6cL
 eo1XCeAbhkvbyVnBbQYcDVyR8c+eVpO+4aNQ0ktpuPm8NcRfcHHhhFsiFg2V/llxyWFt
 1N1DZx3pBaiKu7VlHSzGSKkEuGzn0xY8lrZAfokRKiO0aj1PeJF8L/9x9B6rhWsZNBgB
 wJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294142; x=1793898942;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+hzxhIt4t5oahAQVNebDl8x47p7yjKQrg298hruWxpc=;
 b=X5oMJYycza9X9+Mkc73/psnogiFO7gHLEt5FwzTJ5xCeYROJx2p0nocNR+IjzRUeDW
 vGvUNy2GyAjqgb3nVS1XQ6T20EJ6gHgPlMmWUgYC4O/BnryI0ytE0lerBMUSpIKWo34N
 odxfYx6UU+deeNPzcP/V1v4Oz7d8QKBobgkP8vH+gXTECnAyCS1csRdGNAyQZJMJMn1O
 nal6P59xKZrvfzFvocrEFqs7UimcLxT9zZhC/ztbkSvStV0ulHXSL1ZAFyY1l7ZEr18m
 YA2wcjFU5apkmKZayEYHtTcHDKfcPYwYKUNxGagPN8zh5qCvkacJ+rjWrgeRQYl+8FQ9
 LXRQ==
X-Gm-Message-State: AFq9FYJrHtL4XRBYRwn8wiqApBjIGkT5kG0KvSsqtYAPgoPbjaEM+qE0
 NfzTUfnYya/z2PG51jGokwDCSbIQL150knQ1ppNcngHMRPkdoOo2fvh7MGtSOM+cAIoi0pj7odB
 +Atne+sTnvccPBTnTQrJcX/FkwYVuKCZE8RTZlyow6URw5HsKqMUw8ywuwdK0AitQRirK5ybyV/
 E7tZ2IBA==
X-Gm-Gg: AYBFou0y+wJzEo04auqsiDZyH0F6w7nQ/mT1oyrz0ONJQFcmtyx6LeSBfcD0JRhlAHw
 jMKEJCp221vaQ6w2b+aAhCQ87o0ipU5Yv5V69fIzQnq9aPMsq2KrsnXmB8xZrgVD1tizLr8JvCy
 TlYjrAbb0rsQ71ZNsXU1wCxjrfFmBwguDa61/gUEU/dIycsKujTVGtfLPtE6lyg0zBx2DU6v76b
 TwczBFaporrDS0MvCjOuWqlpli4It4t8XRh8O7zIfgnI+u4RoOdkSN4wvJtwVN1luHILowejxJH
 lxb4+9Qx1gCKheL7O4n45/5CE+8wuiemRwI//oygiZ4+sPZgQTKgGS94pT5VPiOhbg6gXomYJjX
 RufubK4ZOQgbbx6tcjRR/D3QaeVOY1ZJDCoHgjUAQprNKIB3SLKv7iM7V3sXmjayfl4eE1DV2xy
 PjEWltaatcH/F96lawrlgBwBunVMpTWm9XPJdNRCvGtyu9yPwzw2BpTnOGz8n3NUkfVPLkhj+F5
 h9ooF35+2T99xdwXUlUt56BUW6g7jGwQg0bPfXiioFuC7E0eKYx6z8MfHDV2+IxlcGe205D3aP8
 I7kRm6lHjom9qPdHF3FxnE42m0IEPpjjNCmpkPZ/pv0EvxndlxI/skouBF9Nk7O+kGhkdZNF98I
 TcbgvSgdbmii9odIXoiaQ2iZ3nbn1XMtvbgz3s4yqpq0OSNDiuTFpi2i9LbLMxCVmnD9k/ilzdW
 2NZwZyCK1GZ5sqPg8/Sou4kR+JgscQcEPTU4zb
X-Received: by 2002:a05:600c:154d:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a967202a2cmr123736405e9.20.1793294141794; 
 Thu, 29 Oct 2026 10:15:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f4188f4sm75357535e9.4.2026.10.29.10.15.41
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:15:41 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:15:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
X-Gerrit-Change-Number: 2071
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2071?usp=email>
X-Gerrit-Commit: b75ef27f54bde6f3f470a62d9f7c177152887fa9
References: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk0MTM2MDAwLkk2MWEwZDE1OTYyNTg0YmM0OGNhZTQ1OTA2MmZlYWQwOGRjNDI1YWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <35d5fc27f6f11522c173d756f7f968c9223609d3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTjA-000000000nf-3uKB
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0279479325997436742=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0279479325997436742==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sp7rREVn9rA="; charset=UTF-8

--sp7rREVn9rA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2071?usp=3Demail )


Change subject: Remove PACKET_TR=
UNCATION_CHECK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove PACKET_TRUNCATION_CHECK

This functionality checks if packets migh=
t be truncated by checking
the length of the IPv4 header against the length=
 of the buffer to
see if a packet is truncated=2E

This function has been u=
ndocumented and can be only enabled by
manually defining this define=2E

Th=
is might have been useful in 2005 when this function was added
but currentl=
y is rather dead code that can a diagnose a problem
that is extremely rare =
or has been already been fixed outside of
OpenVPN=2E

Change-Id: I61a0d1596=
2584bc48cae459062fead08dc425aeb
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2Ec
M src/open=
vpn/multi=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/proto=2Ec
M src/openv=
pn/proto=2Eh
M src/openvpn/sig=2Ec
7 files changed, 89 insertions(+), 204 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/71/2071/1

diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errle=
vel=2Eh
index d79efbb=2E=2Ee52cb65 100644
--- a/src/openvpn/errlevel=2Eh
++=
+ b/src/openvpn/errlevel=2Eh
@@ -49,105 +49,103 @@
  * of output=2E
  */
 
=
-#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages displayed =
even at --verb 0 (fatal errors only) */
+#define M_VERB0 LOGLEV(0, 0, 0)   =
                 /* Messages displayed even at --verb 0 (fatal errors only)=
 */
 
-#define M_INFO LOGLEV(1, 0, 0)                      /* default infor=
mational messages */
+#define M_INFO LOGLEV(1, 0, 0)                     /*=
 default informational messages */
 
-#define D_LINK_ERRORS    LOGLEV(1, 1,=
 M_NONFATAL)   /* show link errors from main event loop */
-#define D_CRYPT=
_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from encrypt/decrypt */=

-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TLS control c=
hannel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* sh=
ow hostname resolve errors */
-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONF=
ATAL)   /* show compression errors */
-#define D_REPLAY_ERRORS  LOGLEV(1, 6=
, M_NONFATAL)   /* show packet replay errors */
-#define D_STREAM_ERRORS  L=
OGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart */
-#define=
 D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import option e=
rrors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi=
-client server errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL=
)  /* show event=2E[ch] errors */
-#define D_PUSH_ERRORS    LOGLEV(1, 11, M=
_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1,=
 12, M_NONFATAL)  /* show packet_id persist errors */
-#define D_FRAG_ERROR=
S    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
-#define D_=
ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */
=
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link errors fro=
m main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)  /*=
 show errors from encrypt/decrypt */
+#define D_TLS_ERRORS     LOGLEV(1, 3,=
 M_NONFATAL)  /* show TLS control channel errors */
+#define D_RESOLVE_ERRO=
RS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */
+#define D_=
COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression errors */
+#de=
fine D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay error=
s */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP stream erro=
r requiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  =
/* show server import option errors */
+#define D_MULTI_ERRORS   LOGLEV(1, =
9, M_NONFATAL)  /* show multi-client server errors */
+#define D_EVENT_ERRO=
RS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] errors */
+#define D_PU=
SH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors */
+#define=
 D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persist error=
s */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentat=
ion errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show b=
ad struct alignments */
 
-#define D_HANDSHAKE LOGLEV(2, 20, 0)            =
    /* show data & control channel handshakes */
-#define D_CLOSE     LOGLE=
V(2, 22, 0)                /* show socket and TUN/TAP close */
-#define D_P=
ROXY     LOGLEV(2, 24, 0)                /* show http proxy control packets=
 */
-#define D_ARGV      LOGLEV(2, 25, 0)                /* show struct arg=
v errors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)               /* show dat=
a & control channel handshakes */
+#define D_CLOSE     LOGLEV(2, 22, 0)    =
           /* show socket and TUN/TAP close */
+#define D_PROXY     LOGLEV(=
2, 24, 0)               /* show http proxy control packets */
+#define D_AR=
GV      LOGLEV(2, 25, 0)               /* show struct argv errors */
 
-#de=
fine D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequency info from=
 tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, 0)         =
   /* show simulated outage info from gremlin module */
-#define D_GENKEY  =
      LOGLEV(3, 31, 0)            /* print message after key generation */
=
-#define D_ROUTE         LOGLEV(3, 0, 0)             /* show routes added a=
nd deleted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)       =
     /* show debugging info from TUN/TAP driver */
-#define D_RESTART      =
 LOGLEV(3, 33, 0)            /* show certain restart messages */
-#define D=
_PUSH          LOGLEV(3, 34, 0)            /* show push/pull info */
-#defi=
ne D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig pool info *=
/
-#define D_AUTH          LOGLEV(3, 37, 0)            /* show user/pass au=
th info */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show poi=
nt-to-multipoint low-freq debug info */
-#define D_PLUGIN        LOGLEV(3, =
39, 0)            /* show plugin calls */
-#define D_MANAGEMENT    LOGLEV(3=
, 40, 0)            /* show --management info */
-#define D_SCHED_EXIT    L=
OGLEV(3, 41, 0)            /* show arming of scheduled exit */
-#define D_R=
OUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exceeded messa=
ges */
-#define D_OSBUF         LOGLEV(3, 43, 0)            /* show socket/=
tun/tap buffer sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0)          =
  /* messages related to --port-share option */
-#define D_IFCONFIG      LO=
GLEV(3, 0, 0)             /* show ifconfig info (don't mute) */
-#define D_=
DCO           LOGLEV(3, 0, 0)             /* show DCO related messages */
+=
#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           /* low frequency info fr=
om tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30, 0)       =
    /* show simulated outage info from gremlin module */
+#define D_GENKEY =
       LOGLEV(3, 31, 0)           /* print message after key generation */
=
+#define D_ROUTE         LOGLEV(3, 0, 0)            /* show routes added an=
d deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)        =
   /* show debugging info from TUN/TAP driver */
+#define D_RESTART       L=
OGLEV(3, 33, 0)           /* show certain restart messages */
+#define D_PU=
SH          LOGLEV(3, 34, 0)           /* show push/pull info */
+#define D=
_IFCONFIG_POOL LOGLEV(3, 35, 0)           /* show ifconfig pool info */
+#d=
efine D_AUTH          LOGLEV(3, 37, 0)           /* show user/pass auth inf=
o */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show point-to-m=
ultipoint low-freq debug info */
+#define D_PLUGIN        LOGLEV(3, 39, 0) =
          /* show plugin calls */
+#define D_MANAGEMENT    LOGLEV(3, 40, 0)=
           /* show --management info */
+#define D_SCHED_EXIT    LOGLEV(3, =
41, 0)           /* show arming of scheduled exit */
+#define D_ROUTE_QUOTA=
   LOGLEV(3, 42, 0)           /* show route quota exceeded messages */
+#de=
fine D_OSBUF         LOGLEV(3, 43, 0)           /* show socket/tun/tap buff=
er sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)           /* messages=
 related to --port-share option */
+#define D_IFCONFIG      LOGLEV(3, 0, 0)=
            /* show ifconfig info (don't mute) */
+#define D_DCO           =
LOGLEV(3, 0, 0)            /* show DCO related messages */
 
-#define D_SHO=
W_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on program in=
itiation */
-#define D_LOW              LOGLEV(4, 52, 0)         /* miscell=
aneous low-frequency debug info */
-#define D_DHCP_OPT         LOGLEV(4, 53=
, 0)         /* show DHCP options binary string */
-#define D_MBUF         =
    LOGLEV(4, 54, 0)         /* mbuf=2E[ch] routines */
-#define D_PACKET_T=
RUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */
-#define D_=
MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multipoint packe=
t drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show med=
ium frequency multi messages */
-#define D_X509_ATTR        LOGLEV(4, 59, 0=
)         /* show x509-track attributes on connection */
-#define D_INIT_ME=
DIUM      LOGLEV(4, 60, 0)         /* show medium frequency init messages *=
/
-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show terse MTU in=
fo */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* show low-freq=
 packet-id debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)  =
       /* show medium-freq packet-id debugging info */
-#define D_CIPHER_IN=
IT      LOGLEV(4, 65, 0)         /* show messages about cipher init */
+#de=
fine D_SHOW_PARMS       LOGLEV(4, 50, 0)        /* show all parameters on p=
rogram initiation */
+#define D_LOW              LOGLEV(4, 52, 0)        /*=
 miscellaneous low-frequency debug info */
+#define D_DHCP_OPT         LOGL=
EV(4, 53, 0)        /* show DHCP options binary string */
+#define D_MBUF  =
           LOGLEV(4, 54, 0)        /* mbuf=2E[ch] routines */
+#define D_MU=
LTI_DROPPED    LOGLEV(4, 57, 0)        /* show point-to-multipoint packet d=
rops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)        /* show medium =
frequency multi messages */
+#define D_X509_ATTR        LOGLEV(4, 59, 0)   =
     /* show x509-track attributes on connection */
+#define D_INIT_MEDIUM =
     LOGLEV(4, 60, 0)        /* show medium frequency init messages */
+#de=
fine D_MTU_INFO         LOGLEV(4, 61, 0)        /* show terse MTU info */
+=
#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* show low-freq packet-=
id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)        /*=
 show medium-freq packet-id debugging info */
+#define D_CIPHER_INIT      L=
OGLEV(4, 65, 0)        /* show messages about cipher init */
 
-#define D_L=
OG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to stdout for =
read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                   /* Print =
'R' or 'W' to stdout for read/write */
 
-#define D_RTNL          LOGLEV(6,=
 68, M_DEBUG)      /* show RTNL low level operations */
-#define D_LINK_RW =
      LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (terse) */
-=
#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP reads/w=
rites */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-W=
indows driver debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)=
      /* show client NAT debug info */
-#define D_XKEY          LOGLEV(6, 6=
9, M_DEBUG)      /* show xkey-provider debug info */
-#define D_DCO_DEBUG  =
   LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debug messages =
*/
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show signal rela=
ted debug messages */
+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)     /=
* show RTNL low level operations */
+#define D_LINK_RW       LOGLEV(6, 69, =
M_DEBUG)     /* show TCP/UDP reads/writes (terse) */
+#define D_TUN_RW     =
   LOGLEV(6, 69, M_DEBUG)     /* show TUN/TAP reads/writes */
+#define D_TA=
P_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* show TAP-Windows driver debug inf=
o */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show client NAT=
 debug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)     /* show =
xkey-provider debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)=
     /* show DCO related lowlevel debug messages */
+#define D_SIGNAL_DEBUG=
  LOGLEV(6, 69, M_DEBUG)     /* show signal related debug messages */
 
-#d=
efine D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data channel encr=
yption keys */
-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show=
 data channel key source entropy */
-#define D_REL_LOW            LOGLEV(7,=
 70, M_DEBUG) /* show low frequency info from reliable layer */
-#define D_=
FRAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragment debugging info *=
/
-#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low freq win32 I/=
O debugging info */
-#define D_MTU_DEBUG          LOGLEV(7, 70, M_DEBUG) /*=
 show MTU debugging info */
-#define D_MULTI_DEBUG        LOGLEV(7, 70, M_D=
EBUG) /* show medium-freq multi debugging info */
-#define D_MSS           =
     LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */
-#define D_COMP_LOW =
          LOGLEV(7, 70, M_DEBUG) /* show adaptive compression state changes=
 */
-#define D_CONNECTION_LIST    LOGLEV(7, 70, M_DEBUG) /* show <connectio=
n> list info */
-#define D_SCRIPT             LOGLEV(7, 70, M_DEBUG) /* sho=
w parms & env vars passed to scripts */
-#define D_SHOW_NET           LOGLE=
V(7, 70, M_DEBUG) /* show routing table and adapter list */
-#define D_ROUT=
E_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose route=2E[ch] output *=
/
-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DEBUG) /* no TLS state for =
client */
-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /* show Win3=
2 semaphore waits (low freq) */
-#define D_SEMAPHORE          LOGLEV(7, 70,=
 M_DEBUG) /* show Win32 semaphore waits */
-#define D_TEST_FILE          LO=
GLEV(7, 70, M_DEBUG) /* show test_file() calls */
-#define D_MANAGEMENT_DEB=
UG   LOGLEV(3, 70, M_DEBUG) /* show --management debug info */
-#define D_P=
LUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show verbose plugin calls */
-#=
define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show socket=2E[ch] de=
bugging info */
-#define D_SHOW_PKCS11        LOGLEV(7, 70, M_DEBUG) /* sho=
w PKCS#11 actions */
-#define D_ALIGN_DEBUG        LOGLEV(7, 70, M_DEBUG) /=
* show verbose struct alignment info */
-#define D_PACKET_TRUNC_DEBUG LOGLE=
V(7, 70, M_DEBUG) /* PACKET_TRUNCATION_CHECK verbose */
-#define D_PING    =
           LOGLEV(7, 70, M_DEBUG) /* PING send/receive messages */
-#define=
 D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share proxy debug */
-=
#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG) /* show key selection f=
or data channel */
-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG) /* =
show parse_line() errors in argv_parse_cmd */
-#define D_CRYPTO_DEBUG      =
 LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypto=2Ec routines */
-=
#define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show packet-id debug=
ging info */
-#define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG) /* show p=
ush/pull debugging info */
-#define D_SHOW_OCC           LOGLEV(7, 74, M_DE=
BUG) /* show options compatibility string */
+#define D_SHOW_KEYS        LO=
GLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
+#define D_SH=
OW_KEY_SOURCE  LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entr=
opy */
+#define D_REL_LOW          LOGLEV(7, 70, M_DEBUG)  /* show low freq=
uency info from reliable layer */
+#define D_FRAG_DEBUG       LOGLEV(7, 70,=
 M_DEBUG)  /* show fragment debugging info */
+#define D_WIN32_IO_LOW     L=
OGLEV(7, 70, M_DEBUG)  /* low freq win32 I/O debugging info */
+#define D_M=
TU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */
+#def=
ine D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi de=
bugging info */
+#define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show=
 MSS adjustments */
+#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* =
show adaptive compression state changes */
+#define D_CONNECTION_LIST  LOGL=
EV(7, 70, M_DEBUG)  /* show <connection> list info */
+#define D_SCRIPT    =
       LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed to scripts *=
/
+#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table=
 and adapter list */
+#define D_ROUTE_DEBUG      LOGLEV(7, 70, M_DEBUG)  /*=
 show verbose route=2E[ch] output */
+#define D_TLS_STATE_ERRORS LOGLEV(7, =
70, M_DEBUG)  /* no TLS state for client */
+#define D_SEMAPHORE_LOW    LOG=
LEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */
+#define D=
_SEMAPHORE        LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits */
=
+#define D_TEST_FILE        LOGLEV(7, 70, M_DEBUG)  /* show test_file() cal=
ls */
+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  /* show --managem=
ent debug info */
+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* sh=
ow verbose plugin calls */
+#define D_SOCKET_DEBUG     LOGLEV(7, 70, M_DEBU=
G)  /* show socket=2E[ch] debugging info */
+#define D_SHOW_PKCS11      LOG=
LEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */
+#define D_ALIGN_DEBUG     =
 LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alignment info */
+#define =
D_PING             LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages */=

+#define D_PS_PROXY_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* port share proxy de=
bug */
+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBUG)  /* show key sele=
ction for data channel */
+#define D_ARGV_PARSE_CMD   LOGLEV(7, 70, M_DEBUG=
)  /* show parse_line() errors in argv_parse_cmd */
+#define D_CRYPTO_DEBUG=
     LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto=2Ec routines=
 */
+#define D_PID_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show packet-id d=
ebugging info */
+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_DEBUG)  /* sho=
w push/pull debugging info */
+#define D_SHOW_OCC         LOGLEV(7, 74, M_D=
EBUG)  /* show options compatibility string */
 
 
 #define D_VLAN_DEBUG LO=
GLEV(7, 74, M_DEBUG)             /* show VLAN tagging/untagging debug info =
*/
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681=
210d=2E=2Ed012b51f 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/f=
orward=2Ec
@@ -1159,12 +1159,6 @@
         }
 #endif
 
-#ifdef PACKET_TRUNC=
ATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2Ebuf=2Elen; */
=
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c->c2=2Ebuf), TU=
NNEL_TYPE(c->c1=2Etuntap),
-                                "POST_DECRYPT",=
 &c->c2=2En_trunc_post_decrypt);
-#endif
-
         /*
          * Set our =
"official" outgoing address, since
          * if buf=2Elen is non-zero, we=
 know the packet
@@ -1347,11 +1341,6 @@
     }
 #endif /* ifdef _WIN32 */
 =

-#ifdef PACKET_TRUNCATION_CHECK
-    ipv4_packet_size_verify(BPTR(&c->c2=
=2Ebuf), BLEN(&c->c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-                =
            "READ_TUN", &c->c2=2En_trunc_tun_read);
-#endif
-
     /* Was T=
UN/TAP interface stopped? */
     if (tuntap_stop(c->c2=2Ebuf=2Elen))
     =
{
@@ -1527,12 +1516,6 @@
         unsigned int flags =3D
             PIPV4=
_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLIENT;
      =
   process_ip_header(c, flags, &c->c2=2Ebuf, out_sock);
-
-#ifdef PACKET_TR=
UNCATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2Ebuf=2Elen; =
*/
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c->c2=2Ebuf),=
 TUNNEL_TYPE(c->c1=2Etuntap),
-                                "PRE_ENCRYPT=
", &c->c2=2En_trunc_pre_encrypt);
-#endif
     }
     if (c->c2=2Ebuf=2Elen=
 > 0)
     {
@@ -1932,11 +1915,6 @@
 #endif
         dmsg(D_TUN_RW, "TUN WR=
ITE [%d]", BLEN(&c->c2=2Eto_tun));
 
-#ifdef PACKET_TRUNCATION_CHECK
-     =
   ipv4_packet_size_verify(BPTR(&c->c2=2Eto_tun), BLEN(&c->c2=2Eto_tun), TU=
NNEL_TYPE(c->c1=2Etuntap),
-                                "WRITE_TUN", &c=
->c2=2En_trunc_tun_write);
-#endif
-
 #ifdef _WIN32
         size =3D tun_w=
rite_win32(c->c1=2Etuntap, &c->c2=2Eto_tun);
 #else
diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec
index 055305d=2E=2E90270f5 100644
--- a=
/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -979,31 +979,6 @@
   =
      status_printf(so, "ERROR: bad status format version number");
     }
=
 
-#ifdef PACKET_TRUNCATION_CHECK
-    {
-        status_printf(so, "HEADER=
,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-d=
ecrypt Trunc");
-        hash_iterator_init(m->hash, &hi);
-        while (=
(he =3D hash_iterator_next(&hi)))
-        {
-            struct gc_arena g=
c =3D gc_new();
-            const struct multi_instance *mi =3D (struct mu=
lti_instance *)he->value;
-
-            if (!mi->halt)
-            {
-   =
             status_printf(so,
-                              "ERRORS,%s," =
counter_format "," counter_format "," counter_format
-                     =
         "," counter_format,
-                              tls_common_name=
(mi->context=2Ec2=2Etls_multi, false),
-                              m->to=
p=2Ec2=2En_trunc_tun_read, mi->context=2Ec2=2En_trunc_tun_write,
-         =
                     mi->context=2Ec2=2En_trunc_pre_encrypt,
-             =
                 mi->context=2Ec2=2En_trunc_post_decrypt);
-            }
-=
            gc_free(&gc);
-        }
-        hash_iterator_free(&hi);
-   =
 }
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
-
     status_flush(so);
   =
  gc_free(&gc_top);
 
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/op=
envpn=2Eh
index cdd02b6=2E=2E970baa9 100644
--- a/src/openvpn/openvpn=2Eh
+=
++ b/src/openvpn/openvpn=2Eh
@@ -269,12 +269,6 @@
     counter_type link_re=
ad_bytes_auth;
     counter_type link_write_bytes;
     counter_type dco_wr=
ite_bytes;
-#ifdef PACKET_TRUNCATION_CHECK
-    counter_type n_trunc_tun_re=
ad;
-    counter_type n_trunc_tun_write;
-    counter_type n_trunc_pre_encr=
ypt;
-    counter_type n_trunc_post_decrypt;
-#endif
 
     /*
      * Time=
r objects for ping and inactivity
diff --git a/src/openvpn/proto=2Ec b/src/=
openvpn/proto=2Ec
index 2cdb147=2E=2Ea2b07df 100644
--- a/src/openvpn/proto=
=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -163,52 +163,3 @@
     /* Take the one'=
s complement of sum */
     return ((uint16_t)~sum);
 }
-
-#ifdef PACKET_TR=
UNCATION_CHECK
-
-void
-ipv4_packet_size_verify(const uint8_t *data, const =
int size, const int tunnel_type,
-                        const char *prefi=
x, counter_type *errors)
-{
-    if (size > 0)
-    {
-        struct buffe=
r buf;
-
-        buf_set_read(&buf, data, size);
-
-        if (is_ipv4(tu=
nnel_type, &buf))
-        {
-            const struct openvpn_iphdr *pip;
=
-            int hlen;
-            int totlen;
-            const char *ms=
gstr =3D "PACKET SIZE INFO";
-            msglvl_t msglevel =3D D_PACKET_TR=
UNC_DEBUG;
-
-            if (BLENZ(&buf) < sizeof(struct openvpn_iphdr))
-=
            {
-                return;
-            }
-
-            verify=
_align_4(&buf);
-            pip =3D (struct openvpn_iphdr *)BPTR(&buf);
-
=
-            hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);
-            t=
otlen =3D ntohs(pip->tot_len);
-
-            if (BLEN(&buf) !=3D totlen)
-=
            {
-                msgstr =3D "PACKET TRUNCATION ERROR";
-     =
           msglevel =3D D_PACKET_TRUNC_ERR;
-                if (errors)
- =
               {
-                    ++(*errors);
-                }
-    =
        }
-
-            msg(msglevel, "%s %s: size=3D%d totlen=3D%d hlen=
=3D%d errcount=3D" counter_format, msgstr,
-                prefix, BLEN(&b=
uf), totlen, hlen, errors ? *errors : (counter_type)0);
-        }
-    }
-=
}
-
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
diff --git a/src/openvpn/pr=
oto=2Eh b/src/openvpn/proto=2Eh
index 1665751=2E=2E14f9264 100644
--- a/src=
/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -307,11 +307,6 @@
 uint16=
_t ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_=
payload,
                      const uint8_t *src_addr, const uint8_t *dest=
_addr, const int proto);
 
-#ifdef PACKET_TRUNCATION_CHECK
-void ipv4_packe=
t_size_verify(const uint8_t *data, const int size, const int tunnel_type,
-=
                             const char *prefix, counter_type *errors);
-
-=
#endif
 
 #define OPENVPN_8021Q_MIN_VID 1
 #define OPENVPN_8021Q_MAX_VID 40=
94
diff --git a/src/openvpn/sig=2Ec b/src/openvpn/sig=2Ec
index 81654f9=2E=
=2E0cdb01a 100644
--- a/src/openvpn/sig=2Ec
+++ b/src/openvpn/sig=2Ec
@@ -5=
04,12 +504,6 @@
         comp_print_stats(c->c2=2Ecomp_context, so);
     }=

 #endif
-#ifdef PACKET_TRUNCATION_CHECK
-    status_printf(so, "TUN read t=
runcations," counter_format, c->c2=2En_trunc_tun_read);
-    status_printf(=
so, "TUN write truncations," counter_format, c->c2=2En_trunc_tun_write);
- =
   status_printf(so, "Pre-encrypt truncations," counter_format, c->c2=2En_t=
runc_pre_encrypt);
-    status_printf(so, "Post-decrypt truncations," count=
er_format, c->c2=2En_trunc_post_decrypt);
-#endif
 #ifdef _WIN32
     if (t=
untap_defined(c->c1=2Etuntap))
     {

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2071?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
Gerrit-Chang=
e-Number: 2071
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--sp7rREVn9rA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Remove PACKET_TRUNCATION_CHECK<br><br>This functionality check=
s if packets might be truncated by checking<br>the length of the IPv4 heade=
r against the length of the buffer to<br>see if a packet is truncated=2E<br=
><br>This function has been undocumented and can be only enabled by<br>manu=
ally defining this define=2E<br><br>This might have been useful in 2005 whe=
n this function was added<br>but currently is rather dead code that can a d=
iagnose a problem<br>that is extremely rare or has been already been fixed =
outside of<br>OpenVPN=2E<br><br>Change-Id: I61a0d15962584bc48cae459062fead0=
8dc425aeb<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<=
br>M src/openvpn/errlevel=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn=
/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/proto=2Ec<br>M src=
/openvpn/proto=2Eh<br>M src/openvpn/sig=2Ec<br>7 files changed, 89 insertio=
ns(+), 204 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/71/2071/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh</span><br><span>index d79e=
fbb=2E=2Ee52cb65 100644</span><br><span>--- a/src/openvpn/errlevel=2Eh</spa=
n><br><span>+++ b/src/openvpn/errlevel=2Eh</span><br><span>@@ -49,105 +49,1=
03 @@</span><br><span>  * of output=2E</span><br><span>  */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_VERB0 LOG=
LEV(0, 0, 0)                     /* Messages displayed even at --verb 0 (fa=
tal errors only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define M_VERB0 LOGLEV(0, 0, 0)                    /* Messages displayed ev=
en at --verb 0 (fatal errors only) */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define M_INFO LOGLEV(1, 0, 0)           =
           /* default informational messages */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define M_INFO LOGLEV(1, 0, 0)                 =
    /* default informational messages */</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define D_LINK_ERRORS    LOGLEV(1, 1, =
M_NONFATAL)   /* show link errors from main event loop */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M=
_NONFATAL)   /* show errors from encrypt/decrypt */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NON=
FATAL)   /* show TLS control channel errors */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL) =
  /* show hostname resolve errors */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /* show =
compression errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet replay e=
rrors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_STR=
EAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restar=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IMPORT_=
ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import option errors */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_ERRORS =
  LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server errors */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_EVENT_ERRORS   LOGLE=
V(1, 10, M_NONFATAL)  /* show event=2E[ch] errors */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NO=
NFATAL)  /* show push/pull errors */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show =
packet_id persist errors */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmenta=
tion errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_ER=
RORS    LOGLEV(1, 1, M_NONFATAL)  /* show link errors from main event loop =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_CRYPT_E=
RRORS   LOGLEV(1, 2, M_NONFATAL)  /* show errors from encrypt/decrypt */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_ERRORS  =
   LOGLEV(1, 3, M_NONFATAL)  /* show TLS control channel errors */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_RESOLVE_ERRORS LOG=
LEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_COMP_ERRORS    LOGLEV(1, 5,=
 M_NONFATAL)  /* show compression errors */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  =
/* show packet replay errors */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP strea=
m error requiring restart */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  /* show server =
import option errors */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client=
 server errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] error=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH_=
ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_PID_PERSIST    LOGLEV=
(1, 12, M_NONFATAL) /* show packet_id persist errors */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define D_FRAG_ERRORS    LOGLEV(1, 13, =
M_NONFATAL) /* show fragmentation errors */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) =
/* show bad struct alignments */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_HANDSHAKE LOGLEV(2, 20, 0)          =
      /* show data &amp; control channel handshakes */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define D_CLOSE     LOGLEV(2, 22, 0)      =
          /* show socket and TUN/TAP close */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_PROXY     LOGLEV(2, 24, 0)               =
 /* show http proxy control packets */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define D_ARGV      LOGLEV(2, 25, 0)                /* sho=
w struct argv errors */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_HANDSHAKE LOGLEV(2, 20, 0)               /* show data &amp; c=
ontrol channel handshakes */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_CLOSE     LOGLEV(2, 22, 0)               /* show socket =
and TUN/TAP close */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define D_PROXY     LOGLEV(2, 24, 0)               /* show http proxy cont=
rol packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv errors */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequency info from=
 tls_session routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_GREMLIN       LOGLEV(3, 30, 0)            /* show simulated ou=
tage info from gremlin module */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_GENKEY        LOGLEV(3, 31, 0)            /* print mes=
sage after key generation */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_ROUTE         LOGLEV(3, 0, 0)             /* show routes a=
dded and deleted (don&#39;t mute) */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)            /* show =
debugging info from TUN/TAP driver */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_RESTART       LOGLEV(3, 33, 0)            /* show=
 certain restart messages */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pul=
l info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IF=
CONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig pool info */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_AUTH          LOG=
LEV(3, 37, 0)            /* show user/pass auth info */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_LOW     LOGLEV(3, 38, 0) =
           /* show point-to-multipoint low-freq debug info */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define D_PLUGIN        LOGLEV(3, 3=
9, 0)            /* show plugin calls */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define D_MANAGEMENT    LOGLEV(3, 40, 0)            /* s=
how --management info */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_SCHED_EXIT    LOGLEV(3, 41, 0)            /* show arming of sc=
heduled exit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exceeded =
messages */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
OSBUF         LOGLEV(3, 43, 0)            /* show socket/tun/tap buffer siz=
es */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PS_PRO=
XY      LOGLEV(3, 44, 0)            /* messages related to --port-share opt=
ion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IFCON=
FIG      LOGLEV(3, 0, 0)             /* show ifconfig info (don&#39;t mute)=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_DCO     =
      LOGLEV(3, 0, 0)             /* show DCO related messages */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_DEBUG_LOW LOGLE=
V(3, 20, 0)           /* low frequency info from tls_session routines */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_GREMLIN     =
  LOGLEV(3, 30, 0)           /* show simulated outage info from gremlin mod=
ule */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_GEN=
KEY        LOGLEV(3, 31, 0)           /* print message after key generation=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE =
        LOGLEV(3, 0, 0)            /* show routes added and deleted (don&#3=
9;t mute) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 D_TUNTAP_INFO   LOGLEV(3, 32, 0)           /* show debugging info from TUN=
/TAP driver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne D_RESTART       LOGLEV(3, 33, 0)           /* show certain restart messa=
ges */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUS=
H          LOGLEV(3, 34, 0)           /* show push/pull info */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG_POOL LOGLEV(=
3, 35, 0)           /* show ifconfig pool info */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_AUTH          LOGLEV(3, 37, 0)     =
      /* show user/pass auth info */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show=
 point-to-multipoint low-freq debug info */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_PLUGIN        LOGLEV(3, 39, 0)           =
/* show plugin calls */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_MANAGEMENT    LOGLEV(3, 40, 0)           /* show --management=
 info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_S=
CHED_EXIT    LOGLEV(3, 41, 0)           /* show arming of scheduled exit */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE_QUO=
TA   LOGLEV(3, 42, 0)           /* show route quota exceeded messages */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_OSBUF       =
  LOGLEV(3, 43, 0)           /* show socket/tun/tap buffer sizes */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PS_PROXY      LOG=
LEV(3, 44, 0)           /* messages related to --port-share option */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG      L=
OGLEV(3, 0, 0)            /* show ifconfig info (don&#39;t mute) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_DCO           LOG=
LEV(3, 0, 0)            /* show DCO related messages */</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_PARMS   =
    LOGLEV(4, 50, 0)         /* show all parameters on program initiation *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LOW       =
       LOGLEV(4, 52, 0)         /* miscellaneous low-frequency debug info *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_DHCP_OPT  =
       LOGLEV(4, 53, 0)         /* show DHCP options binary string */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MBUF             =
LOGLEV(4, 54, 0)         /* mbuf=2E[ch] routines */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)=
         /* PACKET_TRUNCATION_CHECK */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* sho=
w point-to-multipoint packet drops */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show=
 medium frequency multi messages */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_X509_ATTR        LOGLEV(4, 59, 0)         /* show x=
509-track attributes on connection */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show=
 medium frequency init messages */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show te=
rse MTU info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* show low-freq packet-id de=
bugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)         /* show medium-freq packet-id=
 debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about cip=
her init */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
D_SHOW_PARMS       LOGLEV(4, 50, 0)        /* show all parameters on progra=
m initiation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_LOW              LOGLEV(4, 52, 0)        /* miscellaneous low-frequen=
cy debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_DHCP_OPT         LOGLEV(4, 53, 0)        /* show DHCP options binary=
 string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_MBUF             LOGLEV(4, 54, 0)        /* mbuf=2E[ch] routines */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_DROPPED   =
 LOGLEV(4, 57, 0)        /* show point-to-multipoint packet drops */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_MEDIUM    =
 LOGLEV(4, 58, 0)        /* show medium frequency multi messages */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_X509_ATTR        =
LOGLEV(4, 59, 0)        /* show x509-track attributes on connection */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_INIT_MEDIUM   =
   LOGLEV(4, 60, 0)        /* show medium frequency init messages */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MTU_INFO        =
 LOGLEV(4, 61, 0)        /* show terse MTU info */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0) =
       /* show low-freq packet-id debugging info */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, =
0)        /* show medium-freq packet-id debugging info */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_CIPHER_INIT      LOGLEV(4, =
65, 0)        /* show messages about cipher init */</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LOG_RW LOGLEV(5, =
0, 0)                    /* Print &#39;R&#39; or &#39;W&#39; to stdout for =
read/write */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_LOG_RW LOGLEV(5, 0, 0)                   /* Print &#39;R&#39; or &#39;W=
&#39; to stdout for read/write */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_RTNL          LOGLEV(6, 68, M_DEB=
UG)      /* show RTNL low level operations */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)     =
 /* show TCP/UDP reads/writes (terse) */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* s=
how TUN/TAP reads/writes */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windo=
ws driver debug info */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT de=
bug info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
XKEY          LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_DCO_DEBUG=
     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debug message=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SIGNAL_=
DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show signal related debug messages */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_RTNL     =
     LOGLEV(6, 68, M_DEBUG)     /* show RTNL low level operations */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_RW       LO=
GLEV(6, 69, M_DEBUG)     /* show TCP/UDP reads/writes (terse) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_TUN_RW        LOGLEV=
(6, 69, M_DEBUG)     /* show TUN/TAP reads/writes */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_D=
EBUG)     /* show TAP-Windows driver debug info */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBU=
G)     /* show client NAT debug info */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)     /* s=
how xkey-provider debug info */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)     /* show DCO =
related lowlevel debug messages */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)     /* show s=
ignal related debug messages */</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_SHOW_KEYS          LOGLEV(7, 70, M_DE=
BUG) /* show data channel encryption keys */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) =
/* show data channel key source entropy */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_REL_LOW            LOGLEV(7, 70, M_DEBUG) /*=
 show low frequency info from reliable layer */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define D_FRAG_DEBUG         LOGLEV(7, 70, M_DEBU=
G) /* show fragment debugging info */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low =
freq win32 I/O debugging info */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_MTU_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show MTU =
debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_MULTI_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show medium-freq multi d=
ebugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne D_MSS                LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_COMP_LOW     =
      LOGLEV(7, 70, M_DEBUG) /* show adaptive compression state changes */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_CONNECTION_L=
IST    LOGLEV(7, 70, M_DEBUG) /* show &lt;connection&gt; list info */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SCRIPT           =
  LOGLEV(7, 70, M_DEBUG) /* show parms &amp; env vars passed to scripts */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_NET    =
       LOGLEV(7, 70, M_DEBUG) /* show routing table and adapter list */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE_DEBUG    =
    LOGLEV(7, 70, M_DEBUG) /* show verbose route=2E[ch] output */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_STATE_ERRORS   LO=
GLEV(7, 70, M_DEBUG) /* no TLS state for client */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_D=
EBUG) /* show Win32 semaphore waits (low freq) */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_SEMAPHORE          LOGLEV(7, 70, M_DE=
BUG) /* show Win32 semaphore waits */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_TEST_FILE          LOGLEV(7, 70, M_DEBUG) /* show=
 test_file() calls */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define D_MANAGEMENT_DEBUG   LOGLEV(3, 70, M_DEBUG) /* show --management de=
bug info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
PLUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show verbose plugin calls */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SOCKET_DEBUG =
      LOGLEV(7, 70, M_DEBUG) /* show socket=2E[ch] debugging info */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_PKCS11       =
 LOGLEV(7, 70, M_DEBUG) /* show PKCS#11 actions */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_ALIGN_DEBUG        LOGLEV(7, 70, M_D=
EBUG) /* show verbose struct alignment info */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG=
) /* PACKET_TRUNCATION_CHECK verbose */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define D_PING               LOGLEV(7, 70, M_DEBUG) /* PI=
NG send/receive messages */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share pro=
xy debug */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG) /* show key selection for data ch=
annel */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ARG=
V_PARSE_CMD     LOGLEV(7, 70, M_DEBUG) /* show parse_line() errors in argv_=
parse_cmd */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypt=
o=2Ec routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show packet-id debugging=
 info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PUS=
H_DEBUG         LOGLEV(7, 73, M_DEBUG) /* show push/pull debugging info */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_OCC    =
       LOGLEV(7, 74, M_DEBUG) /* show options compatibility string */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_KEYS      =
  LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_KEY_SOURCE  LO=
GLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define D_REL_LOW          LOG=
LEV(7, 70, M_DEBUG)  /* show low frequency info from reliable layer */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_FRAG_DEBUG    =
   LOGLEV(7, 70, M_DEBUG)  /* show fragment debugging info */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define D_WIN32_IO_LOW     LOGLEV=
(7, 70, M_DEBUG)  /* low freq win32 I/O debugging info */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_MTU_DEBUG        LOGLEV(7, =
70, M_DEBUG)  /* show MTU debugging info */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  =
/* show medium-freq multi debugging info */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_MSS              LOGLEV(7, 70, M_DEBUG)  =
/* show MSS adjustments */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive =
compression state changes */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* show &lt;con=
nection&gt; list info */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define D_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms &amp;=
 env vars passed to scripts */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routi=
ng table and adapter list */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_ROUTE_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose=
 route=2E[ch] output */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_TLS_STATE_ERRORS LOGLEV(7, 70, M_DEBUG)  /* no TLS state for =
client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
SEMAPHORE_LOW    LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low=
 freq) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
SEMAPHORE        LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TEST_FILE  =
      LOGLEV(7, 70, M_DEBUG)  /* show test_file() calls */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_MANAGEMENT_DEBUG LOGLEV(3,=
 70, M_DEBUG)  /* show --management debug info */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DE=
BUG)  /* show verbose plugin calls */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define D_SOCKET_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* sho=
w socket=2E[ch] debugging info */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_SHOW_PKCS11      LOGLEV(7, 70, M_DEBUG)  /* show PK=
CS#11 actions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_ALIGN_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alig=
nment info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_PING             LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PS_PROX=
Y_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* port share proxy debug */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_KEYSELECT    LOGLE=
V(7, 70, M_DEBUG)  /* show key selection for data channel */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define D_ARGV_PARSE_CMD   LOGLEV(=
7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define D_CRYPTO_DEBUG     LO=
GLEV(7, 70, M_DEBUG)  /* show detailed info from crypto=2Ec routines */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG    =
    LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH_DEBUG       LOGL=
EV(7, 73, M_DEBUG)  /* show push/pull debugging info */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_OCC         LOGLEV(7, 74=
, M_DEBUG)  /* show options compatibility string */</span><br><span> </span=
><br><span> </span><br><span> #define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)  =
           /* show VLAN tagging/untagging debug info */</span><br><span>dif=
f --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span=
>index 681210d=2E=2Ed012b51f 100644</span><br><span>--- a/src/openvpn/forwa=
rd=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -11=
59,12 +1159,6 @@</span><br><span>         }</span><br><span> #endif</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACK=
ET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* if (c-&gt;c2=2Ebuf=2Elen &gt; 1) --c-&gt;c2=2Ebuf=2Elen; */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ipv4_packet_size_ver=
ify(BPTR(&amp;c-&gt;c2=2Ebuf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt=
;c1=2Etuntap),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                         &quot;POST_DECRYPT&quot;, &amp;c-&gt;c2=2En_trunc_=
post_decrypt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    /*</span><br><span>          * Set our &quot;official&quot; outgoing ad=
dress, since</span><br><span>          * if buf=2Elen is non-zero, we know =
the packet</span><br><span>@@ -1347,11 +1341,6 @@</span><br><span>     }</s=
pan><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ipv4_packet_size_verify(B=
PTR(&amp;c-&gt;c2=2Ebuf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=
=2Etuntap),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  &quot;READ_TUN&quot;, &amp;c-&gt;c2=2En_trunc_tun_read);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Was TUN/TAP =
interface stopped? */</span><br><span>     if (tuntap_stop(c-&gt;c2=2Ebuf=
=2Elen))</span><br><span>     {</span><br><span>@@ -1527,12 +1516,6 @@</spa=
n><br><span>         unsigned int flags =3D</span><br><span>             PI=
PV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLIENT;</sp=
an><br><span>         process_ip_header(c, flags, &amp;c-&gt;c2=2Ebuf, out_=
sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* if (c-&gt;c2=2Eb=
uf=2Elen &gt; 1) --c-&gt;c2=2Ebuf=2Elen; */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2E=
buf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
&quot;PRE_ENCRYPT&quot;, &amp;c-&gt;c2=2En_trunc_pre_encrypt);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</spa=
n><br><span>     if (c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</s=
pan><br><span>@@ -1932,11 +1915,6 @@</span><br><span> #endif</span><br><spa=
n>         dmsg(D_TUN_RW, &quot;TUN WRITE [%d]&quot;, BLEN(&amp;c-&gt;c2=2E=
to_tun));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2Eto_tun)=
, BLEN(&amp;c-&gt;c2=2Eto_tun), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                &=
quot;WRITE_TUN&quot;, &amp;c-&gt;c2=2En_trunc_tun_write);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span>      =
   size =3D tun_write_win32(c-&gt;c1=2Etuntap, &amp;c-&gt;c2=2Eto_tun);</sp=
an><br><span> #else</span><br><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 055305d=2E=2E90270f5 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -979,31 +979,6 @@</span><br><span>         statu=
s_printf(so, &quot;ERROR: bad status format version number&quot;);</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        status_printf(so, &quot;HEADER,ERRORS,Common Name,TUN Read Trun=
c,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        hash_iterator_init(m-&gt;h=
ash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            const struct multi_instance =
*mi =3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (!mi-&gt;halt)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                status_printf(so,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                              &quot;ERRORS,%s,&quot; counte=
r_format &quot;,&quot; counter_format &quot;,&quot; counter_format</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
&quot;,&quot; counter_format,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                              tls_common_name(mi-&gt;context=2Ec2=
=2Etls_multi, false),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                              m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;con=
text=2Ec2=2En_trunc_tun_write,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                              mi-&gt;context=2Ec2=2En_trunc_pre_en=
crypt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
               mi-&gt;context=2Ec2=2En_trunc_post_decrypt);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        hash_iterator_free(&amp;hi);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif /* ifdef PACKET_TRUNCATION_CHECK */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     statu=
s_flush(so);</span><br><span>     gc_free(&amp;gc_top);</span><br><span> </=
span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=
=2Eh</span><br><span>index cdd02b6=2E=2E970baa9 100644</span><br><span>--- =
a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</sp=
an><br><span>@@ -269,12 +269,6 @@</span><br><span>     counter_type link_re=
ad_bytes_auth;</span><br><span>     counter_type link_write_bytes;</span><b=
r><span>     counter_type dco_write_bytes;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    counter_type n_trunc_tun_read;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    counter_type n_trunc_tun_w=
rite;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    counter_type=
 n_trunc_pre_encrypt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    counter_type n_trunc_post_decrypt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span> </span><br><span>     /*</span><br=
><span>      * Timer objects for ping and inactivity</span><br><span>diff -=
-git a/src/openvpn/proto=2Ec b/src/openvpn/proto=2Ec</span><br><span>index =
2cdb147=2E=2Ea2b07df 100644</span><br><span>--- a/src/openvpn/proto=2Ec</sp=
an><br><span>+++ b/src/openvpn/proto=2Ec</span><br><span>@@ -163,52 +163,3 =
@@</span><br><span>     /* Take the one&#39;s complement of sum */</span><b=
r><span>     return ((uint16_t)~sum);</span><br><span> }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipv4_packet_siz=
e_verify(const uint8_t *data, const int size, const int tunnel_type,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        cons=
t char *prefix, counter_type *errors)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (size &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer=
 buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        buf_set_read(&amp;buf, data, =
size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (is_ipv4(tunnel_type, &am=
p;buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            const struct o=
penvpn_iphdr *pip;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         int hlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         int totlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           const char *msgstr =3D &quot;PACKET SIZE INFO&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msglvl_t msglevel =3D=
 D_PACKET_TRUNC_DEBUG;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN=
Z(&amp;buf) &lt; sizeof(struct openvpn_iphdr))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                return;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  verify_align_4(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            pip =3D (struct openvpn_iphdr *)BPTR(&amp;buf);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            hlen =3D OPENVPN_IPH_GET_LEN(pip-&gt;ver=
sion_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 totlen =3D ntohs(pip-&gt;tot_len);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (BLEN(&amp;buf) !=3D totlen)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msgstr =3D &quot;PACKET TRUNCATION ERROR&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msglevel =
=3D D_PACKET_TRUNC_ERR;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (errors)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    ++(*errors);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(ms=
glevel, &quot;%s %s: size=3D%d totlen=3D%d hlen=3D%d errcount=3D&quot; coun=
ter_format, msgstr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              prefix, BLEN(&amp;buf), totlen, hlen, errors ? *errors : (cou=
nter_type)0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* ifdef PACKET_TRUNCATION_CHECK */</span><br><span>diff --git a/src/o=
penvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 1665751=2E=
=2E14f9264 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><sp=
an>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -307,11 +307,6 @@</span><=
br><span> uint16_t ip_checksum(const sa_family_t af, const uint8_t *payload=
, const int len_payload,</span><br><span>                      const uint8_=
t *src_addr, const uint8_t *dest_addr, const int proto);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATI=
ON_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ipv4_pac=
ket_size_verify(const uint8_t *data, const int size, const int tunnel_type,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
        const char *prefix, counter_type *errors);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span> </span><br><span> #define OPENVPN_8021Q_MIN=
_VID 1</span><br><span> #define OPENVPN_8021Q_MAX_VID 4094</span><br><span>=
diff --git a/src/openvpn/sig=2Ec b/src/openvpn/sig=2Ec</span><br><span>inde=
x 81654f9=2E=2E0cdb01a 100644</span><br><span>--- a/src/openvpn/sig=2Ec</sp=
an><br><span>+++ b/src/openvpn/sig=2Ec</span><br><span>@@ -504,12 +504,6 @@=
</span><br><span>         comp_print_stats(c-&gt;c2=2Ecomp_context, so);</s=
pan><br><span>     }</span><br><span> #endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    status_printf(so, &quot;TUN read trunca=
tions,&quot; counter_format, c-&gt;c2=2En_trunc_tun_read);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    status_printf(so, &quot;TUN write =
truncations,&quot; counter_format, c-&gt;c2=2En_trunc_tun_write);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    status_printf(so, &quot;Pre=
-encrypt truncations,&quot; counter_format, c-&gt;c2=2En_trunc_pre_encrypt)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status_printf(so=
, &quot;Post-decrypt truncations,&quot; counter_format, c-&gt;c2=2En_trunc_=
post_decrypt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_defined(c-&g=
t;c1=2Etuntap))</span><br><span>     {</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail">chang=
e 2071</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I61a0d15962584bc48cae459062fead08dc425aeb </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2071 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--sp7rREVn9rA=--


--===============0279479325997436742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0279479325997436742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0279479325997436742==--

