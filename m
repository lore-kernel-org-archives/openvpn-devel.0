Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4615606A326
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JMwTM5Rn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g9YuHLZX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cjNv2MBy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IbcfkjWK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=mk9tM1xEpWj+Yo4o/K4pcOMJkmBbKLNB7EAstu7/SwE=; b=JMwTM5Rnk98Ue0ur99WZCMuzMx
	NU0PnGpOgkEWqwtPhQBMZxFpJNRUp2wVPxH02/PrNfMUvn5LHt7bzYqDZKqmVpepbhtfqXdddk5g+
	T+VTm8XYqJA7pzbe+FLosCjm7jvy9WaRATRM+0TrjZta2Y0SSg8oizn2us8pyB5p5vfg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdm0-000000001ok-1maG;
	Tue, 27 Oct 2026 09:47:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlz-000000001oZ-0OLa
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1lUEQtIqc3efMMieXlqS/5/QH+qRnNQJPxLVa5J3JEM=; b=g9YuHLZX1YoUNEMMd/eUAucsAN
 6rM4CHLQPaJL/oJY+4YVqa42gXlgtHb344FyhV8Yrim5ruZ0N8mF6QUJFDakd/mbfJvutHjYj7hb5
 JRk2OEww11rUsOZQp9vXSjALMVaxd77KtcvyTnW5xuRuthQtyXq9PI4o2Qbw7sIzJtyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1lUEQtIqc3efMMieXlqS/5/QH+qRnNQJPxLVa5J3JEM=; b=cjNv2MByIv8Fpu+Y9SMGrAEz5g
 JG2YRnNAf6XX7dnr8tTYnpwB1w/+C+YeSjTYXSA/LDbpXE8nI33oj4e9a3v5zsJWnbAlHMJcPNmxL
 uozaayDq0ORFh3UQUvkWhSZwredNNfLxOCINF8ssusY9TjCMPLHrFgAgMNGsAUb9DP2Y=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlx-000000001Ea-04fJ for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:15 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3327086f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094426; x=1793699226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1lUEQtIqc3efMMieXlqS/5/QH+qRnNQJPxLVa5J3JEM=;
 b=IbcfkjWKi1xh2gAZazceTw+yI/BQlit3tDHmy9FHFQMI2PjMYhCcm7eUjvGWOLcx3f
 1LEllj8W165w68s9uzBRxZikfg11mqaNrQCqpIvsud3TWcLew8kdchylvuMxYyYRlEM3
 UJPx7Jt1EpgtfIOgo4YXEFpuUK5PtjMN6KNBqnztao0w3fpb0fTfYm+75zMKTVWXMzfe
 06El0WjOL90HH7vFwXoXqbxxPBei9ApFZGzXfCSKBW8eZhYU8TKeAnQccw59YG5nq1jy
 GBa8A4k+3rj8U1UYXvogv8XnQYqyB8SsXVIZ1W5/IEwCzo3uxQews3/HeRPV2zPScn7E
 +sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094426; x=1793699226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1lUEQtIqc3efMMieXlqS/5/QH+qRnNQJPxLVa5J3JEM=;
 b=XVd5orrFSagIcqvCTyK2SL5Gj/40YpiQpCeuLAYsE6REpJWIv3HAXm+oUqbKUuHuhu
 3qUeHHpnn3jzEy9R6yohCIxdkDpFJhKa2370gV350i81nu0g8FO4TkIVRTC6gxpk2o5s
 OVqTnYbzm1xauNj7VNM5IveaKOZF47oGyxovg/j/iWBIgEOWj2PuX5YVK0y0q1VWbChs
 6qod/ulX/derJtn6e4SdznSx3kqgUX6eODZQ8SJvZZr7q8CF2EkUv4F95tbeOPR+nNwg
 uoPmqLw8ksB8BS9BQghX9PkB83fuCnptnS6rn9DZIRieyWU4Z6zd3DSvVpzFu3+7rEPD
 kImg==
X-Gm-Message-State: AFq9FYLb2UOzJBQoutLtQFDeohLOm2rr5fStaqT1YY06UeWsJIeYHiPk
 FzFnasKVMGuIZnDuTq3h+Li4zmWhYj4DYKyaRayJJH3kCbjrDT/X5zps/NE617C6IvbLukHJ9AB
 32o/ptgRR7VLIF0nk9PLffcPWPA0edPM4rte0CCmWemhmKdqXTK0xBlfnlhKLuhHYsraflZBviv
 BlmjHKfw==
X-Gm-Gg: AYBFou2wkhISnEgia5ckBW6V39Peef/H8j+oL/EHD/3IWJ+Gt2HMUHmoPy+PLf5kUl4
 60SMb9y8laek48s/tzd0rwazxS5x+2nFWke7y3QZpI/TUqEF0NkwfLgWut2e4cvkfPV3B4qJshW
 eSrdCidTTBRn5KHEmcAlFd5NUUkgpLhiPt1aqeo/m34qxPJEfsuzokhppqeY9j2C8+Kf1dqtyh0
 aqD9Vz9vFcwrkLcCddgyoln+vFCihaqwKLVQn8HHAxPJbWWYFeXH9xTjdkCcsOMe8PxdOaZYSTV
 Gfx3DiSNcqh5Tx0OoTPHiCeUkRtcAkiYRiXWse4O/HuBEbG4bJjzu6yAwSztA+OTcY64yrgiQIJ
 TkEJKB8Q5WE9m419DW++U3urys17nqic6WVgOz2fq8xnBoi1/UdyoevAFY5uDPYRaTX/ZZTSivp
 07QSp9bVWlcSP7l6Eb0HmU5bf57tuNvJs2D+M4td3Ucmc3aw1iG+P4rjKWK785qW+7ufPZrcscC
 JbL8tF8WZB6+LCsAT5yb5KvboUVCxbZZXHFoKoa1kSjRcqbn0TeObptIgqEQ+m0OdfCap7S+svW
 aw/ptOTzWhClcDvtYvwdHgjh+bawouIMVAcg2oLtHqmaj5k0S3zpWKCEwjDfyYYrg7yL8Y/h0Pe
 D2v9vlPuh5dkNz2USVoI7UwJC1LXQR1Su3t2Ox+wl4w==
X-Received: by 2002:a05:6000:29c6:b0:48a:eeef:b4a7 with SMTP id
 ffacd0b85a97d-48e3eb9a1ecmr12145729f8f.48.1793094426352; 
 Tue, 27 Oct 2026 02:47:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm21207340f8f.42.2026.10.27.02.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:05 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:05 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4637d59ed1fba450e81518766526d934cd2902b7
X-Gerrit-Change-Number: 2049
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2049?usp=email>
X-Gerrit-Commit: 1c809b56129c8ba881e3b10e4cc2dcf17e11fafb
References: <gerrit.1793094393000.I4637d59ed1fba450e81518766526d934cd2902b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0NjM3ZDU5ZWQxZmJhNDUwZTgxNTE4NzY2NTI2ZDkzNGNkMjkwMmI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b9a80ca1ca59ad359933d44c6a97d30625829bf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlx-000000001Ea-04fJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: replace
 TA_INITIAL with TA_INSTANCE_POST
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1998619122740437068=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1998619122740437068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ADaSmoIn6xY="; charset=UTF-8

--ADaSmoIn6xY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2049?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: replace TA_INITIAL with TA_INSTANCE_POST
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: replace T=
A_INITIAL with TA_INSTANCE_POST

TA_INITIAL is TA_INSTANCE_POST plus multi_=
tcp_set_global_rw_flags(),
which multi_io_post() already calls once the ins=
tance has no output
left=2E Use TA_INSTANCE_POST for new TCP instances too =
and drop
TA_INITIAL=2E

With UDP instances going through the state machine =
as well, make the
MTP_NONE branch of multi_io_post() explicitly TCP only: r=
eading the
stream residual and re-arming the socket only make sense on a
co=
nnection-oriented socket=2E multi_tcp_set_global_rw_flags() is then
never c=
alled on a datagram instance, and loses its proto check=2E

Change-Id: I463=
7d59ed1fba450e81518766526d934cd2902b7
Signed-off-by: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
---
M src/openvpn/mtcp=2Ec
M src/openvpn/multi_i=
o=2Ec
M src/openvpn/multi_io=2Eh
3 files changed, 17 insertions(+), 27 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/49/2049/1

diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
ind=
ex 2d0af06=2E=2E524e437 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn=
/mtcp=2Ec
@@ -118,11 +118,8 @@
 void
 multi_tcp_set_global_rw_flags(struct =
multi_context *m, struct multi_instance *mi)
 {
-    if (mi && !proto_is_dg=
ram(mi->context=2Ec2=2Elink_sockets[0]->info=2Eproto))
-    {
-        mi->=
socket_set_called =3D true;
-        socket_set(mi->context=2Ec2=2Elink_soc=
kets[0], m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out=
_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,
-                   &mi=
->tcp_rwflags);
-    }
+    mi->socket_set_called =3D true;
+    socket_set=
(mi->context=2Ec2=2Elink_sockets[0], m->multi_io->es,
+               mbuf_=
defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,=

+               &mi->tcp_rwflags);
 }
diff --git a/src/openvpn/multi_io=2E=
c b/src/openvpn/multi_io=2Ec
index a14978b=2E=2E8580d7d 100644
--- a/src/op=
envpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -76,9 +76,6 @@
       =
  case TA_TUN_WRITE:
             return "TA_TUN_WRITE";
 
-        case TA=
_INITIAL:
-            return "TA_INITIAL";
-
         case TA_TIMEOUT:
   =
          return "TA_TIMEOUT";
 
@@ -455,12 +452,6 @@
             multi_io=
_write_link(m, mi, true, mpp_flags);
             break;
 
-        case TA=
_INITIAL:
-            ASSERT(mi);
-            multi_tcp_set_global_rw_fla=
gs(m, mi);
-            multi_process_post(m, mi, mpp_flags);
-            =
break;
-
         case TA_INSTANCE_POST:
             ASSERT(mi);
         =
    multi_process_post(m, mi, mpp_flags);
@@ -506,13 +497,16 @@
           =
  break;
 
         case MTP_NONE:
-            if (mi && sockets_read_resi=
dual(c))
+            if (mi && link_socket_connection_oriented(mi->context=
=2Ec2=2Elink_sockets[0]))
             {
-                newaction =3D TA_=
SOCKET_READ_RESIDUAL;
-            }
-            else
-            {
-    =
            multi_tcp_set_global_rw_flags(m, mi);
+                if (sock=
ets_read_residual(c))
+                {
+                    newaction =3D=
 TA_SOCKET_READ_RESIDUAL;
+                }
+                else
+       =
         {
+                    multi_tcp_set_global_rw_flags(m, mi);
+    =
            }
             }
             break;
 
@@ -584,7 +578,7 @@
    =
                      * before returning to the main loop=2E */
           =
              if (mi)
                         {
-                         =
   multi_io_action(m, mi, NULL, TA_INITIAL, false);
+                      =
      multi_io_action(m, mi, NULL, TA_INSTANCE_POST, false);
              =
           }
                     }
                     else if (e->rwflag=
s & EVENT_READ)
diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_i=
o=2Eh
index 591225c=2E=2Ee178240 100644
--- a/src/openvpn/multi_io=2Eh
+++ =
b/src/openvpn/multi_io=2Eh
@@ -41,10 +41,9 @@
 #define TA_SOCKET_WRITE_DEFE=
RRED 5
 #define TA_TUN_READ              6
 #define TA_TUN_WRITE           =
  7
-#define TA_INITIAL               8
-#define TA_TIMEOUT               9=

-#define TA_TUN_WRITE_TIMEOUT     10
-#define TA_INSTANCE_POST         11
=
+#define TA_TIMEOUT               8
+#define TA_TUN_WRITE_TIMEOUT     9
+#d=
efine TA_INSTANCE_POST         10
 
 /*
  * I/O state and events tracker

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4637d59ed1fba450=
e81518766526d934cd2902b7
Gerrit-Change-Number: 2049
Gerrit-PatchSet: 1
Gerr=
it-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--ADaSmoIn6xY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: replace TA_INITIAL with TA_INSTANCE_POST<br><=
br>TA_INITIAL is TA_INSTANCE_POST plus multi_tcp_set_global_rw_flags(),<br>=
which multi_io_post() already calls once the instance has no output<br>left=
=2E Use TA_INSTANCE_POST for new TCP instances too and drop<br>TA_INITIAL=
=2E<br><br>With UDP instances going through the state machine as well, make=
 the<br>MTP_NONE branch of multi_io_post() explicitly TCP only: reading the=
<br>stream residual and re-arming the socket only make sense on a<br>connec=
tion-oriented socket=2E multi_tcp_set_global_rw_flags() is then<br>never ca=
lled on a datagram instance, and loses its proto check=2E<br><br>Change-Id:=
 I4637d59ed1fba450e81518766526d934cd2902b7<br>Signed-off-by: Gianmarco De G=
regori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mtcp=2Ec<b=
r>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>3 files chang=
ed, 17 insertions(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/2049/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>inde=
x 2d0af06=2E=2E524e437 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -118,11 +118,8 =
@@</span><br><span> void</span><br><span> multi_tcp_set_global_rw_flags(str=
uct multi_context *m, struct multi_instance *mi)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi &amp;&amp; !proto_=
is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        mi-&gt;socket_set_called =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-&gt;=
context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                   mbuf_defined(mi-&gt;tcp=
_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &amp;mi-&gt;ev_arg,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-&g=
t;tcp_rwflags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;socket_se=
t_called =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               mbuf=
_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &amp;mi-=
&gt;ev_arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
       &amp;mi-&gt;tcp_rwflags);</span><br><span> }</span><br><span>diff --=
git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>i=
ndex a14978b=2E=2E8580d7d 100644</span><br><span>--- a/src/openvpn/multi_io=
=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -76,=
9 +76,6 @@</span><br><span>         case TA_TUN_WRITE:</span><br><span>    =
         return &quot;TA_TUN_WRITE&quot;;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case TA_INITIAL:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_INITIA=
L&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>         case TA_TIMEOUT:</span><br><span>             return &quot;TA_=
TIMEOUT&quot;;</span><br><span> </span><br><span>@@ -455,12 +452,6 @@</span=
><br><span>             multi_io_write_link(m, mi, true, mpp_flags);</span>=
<br><span>             break;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case TA_INITIAL:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_set_global_rw_flags(m=
, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mul=
ti_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>         case TA_INSTANCE_POST:</span><br><span>=
             ASSERT(mi);</span><br><span>             multi_process_post(m,=
 mi, mpp_flags);</span><br><span>@@ -506,13 +497,16 @@</span><br><span>    =
         break;</span><br><span> </span><br><span>         case MTP_NONE:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (mi &amp=
;&amp; sockets_read_residual(c))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (mi &amp;&amp; link_socket_connection_oriented(=
mi-&gt;context=2Ec2=2Elink_sockets[0]))</span><br><span>             {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                newaction =
=3D TA_SOCKET_READ_RESIDUAL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  multi_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                if (sockets_read_residual(c))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    newaction =
=3D TA_SOCKET_READ_RESIDUAL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    multi_tcp_set_global_rw_flags(m, mi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an>             }</span><br><span>             break;</span><br><span> </sp=
an><br><span>@@ -584,7 +578,7 @@</span><br><span>                          =
* before returning to the main loop=2E */</span><br><span>                 =
        if (mi)</span><br><span>                         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                            multi_io_a=
ction(m, mi, NULL, TA_INITIAL, false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                            multi_io_action(m, mi, NULL,=
 TA_INSTANCE_POST, false);</span><br><span>                         }</span=
><br><span>                     }</span><br><span>                     else=
 if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span>diff --git a/src/openv=
pn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index 591225c=2E=
=2Ee178240 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br>=
<span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -41,10 +41,9 @@</sp=
an><br><span> #define TA_SOCKET_WRITE_DEFERRED 5</span><br><span> #define T=
A_TUN_READ              6</span><br><span> #define TA_TUN_WRITE            =
 7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_INITIAL =
              8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e TA_TIMEOUT               9</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define TA_TUN_WRITE_TIMEOUT     10</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define TA_INSTANCE_POST         11</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define TA_TIMEOUT               8</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_WRITE_TI=
MEOUT     9</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
TA_INSTANCE_POST         10</span><br><span> </span><br><span> /*</span><br=
><span>  * I/O state and events tracker</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?usp=3Demail">chan=
ge 2049</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I4637d59ed1fba450e81518766526d934cd2902b7 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2049 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco=
 De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--ADaSmoIn6xY=--


--===============1998619122740437068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1998619122740437068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1998619122740437068==--

