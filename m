Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0791C5DF70
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wgV/LBtwR8sT7WheQjx7c1tR8AIRK/FP0qvfEgl2VZg=; b=nA1n+q8QxeC3DD
	DQsbNMvxXAtkw/wAikQ7EFldnAZjYLrd+HzUlhAiKADr8q8/oiznj/T3wmawFoBcC/b9mmCtNI0Ii
	aQot+uc3skfv1gsl3Uw67fi0qCZqHmezQFxqSBsoQL/GVyUSzxyrlSr86r48jD1+0STD9fFvIZkYB
	LSA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvts1-00020A-FL;
	Mon, 17 Aug 2026 09:43:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvtrz-000203-E7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5JGb5rQEC7DHklQFm1DD5V79q0MlKFzisP3l4bN3iKg=; b=YZ0anfdy/osCSZqOrIXgXx382r
 XR7qVgiMO1Xo54S8jABmrasObTdRNeO3f1d9jA1RLk2pyBkZRjQ5EmkOjADg2oU7ya9Duw+6d3Sst
 Db8VYeu1Y0XohpaEslV8SLMYjvS3wmALve3DfQpYw9gorG4zDuujJgQELybOR3Wx40iU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5JGb5rQEC7DHklQFm1DD5V79q0MlKFzisP3l4bN3iKg=; b=Q
 QMi4tHBestuu6xiHAc+RMEDpsLvG9k72CLx2/dLp/ICS9+WdEFAS4JagtrX6jXbsASDEF9+iinE2q
 WXpEL09b8eLAim7eiMl3UWj/N/De/GTXMd1jrrRRAubJQhGpMbLv94ALD0PMyeYfLES7LpQQuDxQe
 5WTmCDHxLP6Mcwy4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvts2-0003Az-3b for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:43:04 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso31332565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786959776; x=1787564576; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JGb5rQEC7DHklQFm1DD5V79q0MlKFzisP3l4bN3iKg=;
 b=MgLPBpLNRjyeesgTgJVEFiXZBxjlDbZzNGKHNC2aH1CRcfyB18ZelwGZmVV2yJekvr
 ZQEaoR24qjp/rb016AtaZ+FclKj53ZtdKlorhyVDIxVvea+TCPCWev87tPoyMSOaW6lj
 Vk5bSA8Hv5Ry7Mlgw2JeWmtHDeB1bXTgPTBLjzthT79uMegGFR3l+k6g7/k+Ls7SYvfe
 tj0gPVm2FXM5anV3smFgfhjNMV0QO+QvhJ+I6RmBNWDsenAOrESp+WsL+cXur87n1Gpd
 jbPAOZPpM9GyzPNNQWEoZg4AplOBBHD/9Qg9bJJDhhWMWRQbpDj4No9JXi2YSjZ2MulZ
 sASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786959776; x=1787564576;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JGb5rQEC7DHklQFm1DD5V79q0MlKFzisP3l4bN3iKg=;
 b=Xq8xOlo8fQSBjm0lERgA2nvsOQyd3xY7iJ/whAm4elZgFgbF6aFZvMljXEzqchkvt8
 +xjESTLqDTeIhGuXlBKWJ0ZCrkpt2DXNuqLUo4GbiHSh7wPz85AcPuWqfQ/3VwMhRsNI
 6AjBFzos2FgDOjtyGWN9WIq4A8EqHfXEtwtvVPPC0C5DNnK0XDqqGvXAIWpuS3fdq+X8
 ufOw+q/T0VvHEuoDAVbslZnPFsbRppDpMznnzyNnWZPJ2voa8B6ynskP9A/9C3gM2B8P
 uakqcNHE46DJ1Po86U6+K+yqrGnNlJguyZMKBIKu8kvxFr86bo9eggj82t0sK1TICIje
 qyBg==
X-Gm-Message-State: AOJu0YzrCsF/UjOx+Ng0R27MtPI/F9HV9RSrmV29J9QHV/m9NNPUBmhs
 fpP6bZvfDm6wNEUT3KfKVu2bKK8LixqD1SESqFzAqp3uIWdXpmjBec8l5NtFMAZC61CQsggCWoF
 XkxAW3+Qo6COM3cYZsFBWGJIR4DntBpRHzwLWFnu34J9WWFZhTZqdZeJ1OKtGV4c3VUX2iZ5SCw
 xuSRs60g==
X-Gm-Gg: AR+sD11TVmBOtvCsSxUz5YtLJVVGJBLrkg6RJb2Il8WzKCjN0aUMg1M4VveLyR1FKAi
 wD0oiYAqkiotoq45vvo/k2DhHeLu9Hi3dLKhSgMFufam8IrhahXHNp2hb9HcAB8Mrzrf8hh0f4W
 zneEou8ycDIKeckdh/zx2OH37eB7mU5yQCOwreLdMl+cXcaxlPUyy5bZS2+huUSKaypoAxCJA2r
 e3pBexezaPe8YQni4UZcVCVfG4PJ20WmTrIgYe4BxsGB3W+fxNVlvDXPlLB1UHZh0MllDQr0nK9
 yCRo7/5yHn2sP3JeN5uvZ2pE2xgrRMZjPmV9GVvBSy82gCP4tbRqgh8j+gR0fiKk7MDscCkj8ML
 hqcqtb6ZTRnFanZcBOMe8jEnDZQxPRvhdrF4HMpkRqF8VJss16nY863TrMuYnbBsSqeoCTHsuhC
 Y+Pc2QbaQ0gzuGvvO82so/nGboB9I4IrkXrJ58JjQAFXpym3zYrMmbuwAqgIYMJaA7c0W6zrhWy
 /UNBTI/iaJqGbbbI10xjl5yEHFdQWktMceKYwUKtH8xfWNjfVEmyaH8eIFSrcDBirT4W0VxmJ1s
 /BN2E34htH6Z8UcbvWEnMEsLPnZCvI2lj9aAYsqweEXR/l1vWzE=
X-Received: by 2002:a05:600c:8b6b:b0:499:8f9f:e9ee with SMTP id
 5b1f17b1804b1-4998f9febbdmr276626375e9.7.1786959775435; 
 Mon, 17 Aug 2026 02:42:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm296760005e9.13.2026.08.17.02.42.54
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:42:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 09:42:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: c35df952df85077d28b8b848f00ef5d450ce84ad
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99faaeb6215729e32b0d365e3d96c6a4849f64e7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvts2-0003Az-3b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6008498050634053679=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6008498050634053679==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QXXvUgJ3bNU="; charset=UTF-8

--QXXvUgJ3bNU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail )


Change subject: Reduce number of fu=
ture epoch keys from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Reduce number of future epoch keys from 16 to 4

The calcu=
lation in the RFC was wrong and probably influenced
by an older worst case =
assumption=2E With the fixed calculation
four future epoch keys should be m=
ore than enough even for
100 Gbit/s=2E So change the number to 4 in OpenVPN=
 as well=2E

This also reduces the spam about the epoch keys a bit=2E

Than=
ks to Ralf Lici for noticing the wrong calculation=2E

Change-Id: Id3c6681b=
29026c2920a62a0ea570fd098649e197
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, 42 insertions(+), 21 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/44/1844/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index=
 fd96b85=2E=2E617ac2f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ss=
l=2Ec
@@ -1343,10 +1343,14 @@
 init_epoch_keys(struct key_state *ks, struct=
 tls_multi *multi, const struct key_type *key_type,
                 bool s=
erver, struct key2 *key2)
 {
-    /* For now we hardcode this to be 16 for =
the software based data channel
+    /* For now we hardcode this to be 4 fo=
r the software based data channel
      * DCO based implementations/HW impl=
ementation might adjust this number
-     * based on their expected speed *=
/
-    const uint8_t future_key_count =3D 16;
+     * based on their expect=
ed speed=2E
+     *
+     * One epoch lasts 910 GB with 128 byte packets or=
 78s at 100 GBit/s=2E
+     * (respectively 1011 GB and 86s with 1280 byte =
packets)=2E
+     */
+    const uint8_t future_key_count =3D 4;
 
     int =
key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
  =
   struct key_direction_state kds;
@@ -1874,7 +1878,8 @@
 
     /* In serve=
r mode we only add this when the client has announced its
      * support f=
or the feature */
-    if (session->opt->mode !=3D MODE_SERVER || multi->us=
e_asymmetric_peer_id)
+    if (session->opt->mode !=3D MODE_SERVER || multi=
->use_asymmetric_peer_id
+        || !session->opt->server)
     {
        =
 return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
     }
@@ -1945,21=
 +1950,21 @@
         /* support for P_DATA_V2 */
         int iv_proto =3D=
 IV_PROTO_DATA_V2;
 
-        /* support for the latest --dns option */
-  =
      iv_proto |=3D IV_PROTO_DNS_OPTION_V2;
-
         /* support for exit =
notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIF=
Y;
 
-        /* currently push-update is not supported when DCO is enabled=
 */
-        if (!session->opt->dco_enabled)
-        {
-            /* sup=
port push-updates */
-            iv_proto |=3D IV_PROTO_PUSH_UPDATE;
-    =
    }
-
         if (session->opt->pull)
         {
+            /* support=
 for the latest --dns option */
+            iv_proto |=3D IV_PROTO_DNS_OPT=
ION_V2;
+
+            /* currently push-update is not supported when DCO i=
s enabled */
+            if (!session->opt->dco_enabled)
+            {
+ =
               /* support push-updates */
+                iv_proto |=3D IV=
_PROTO_PUSH_UPDATE;
+            }
+
             /* support for receiving =
push_reply before sending
              * push request, also signal that th=
e client wants
              * to get push-reply messages without requiring=
 a round
@@ -1974,21 +1979,26 @@
 
             /* support for tun-mtu as p=
art of the push message */
             buf_printf(&out, "IV_MTU=3D%d\n", s=
ession->opt->frame=2Etun_max_mtu);
-        }
 
-        /* support for Neg=
otiable Crypto Parameters */
-        if (session->opt->mode =3D=3D MODE_SE=
RVER || session->opt->pull)
-        {
+            /* legacy support for N=
egotiable Crypto Parameters (deprecated in
+             * favour of IV_CIP=
HERS) */
             if (tls_item_in_cipher_list("AES-128-GCM", session->o=
pt->config_ncp_ciphers)
                 && tls_item_in_cipher_list("AES-25=
6-GCM", session->opt->config_ncp_ciphers))
             {
                 =
buf_printf(&out, "IV_NCP=3D2\n");
             }
         }
-        else
+=
        else if (session->opt->mode !=3D MODE_SERVER)
         {
-         =
   /* We are not using pull or p2mp server, instead do P2P NCP */
+        =
    /* If we are not using pull we announce P2P NCP support */
            =
 iv_proto |=3D IV_PROTO_NCP_P2P;
+
+            /* We are sending our ping =
receive timeout to allow detecting
+             * mismatched ping */
+    =
        if (session->opt->ping_rec_timeout)
+            {
+               =
 buf_printf(&out, "P=3D%d\n", session->opt->ping_rec_timeout);
+           =
 }
         }
 
         if (session->opt->data_epoch_supported)
@@ -2317,6=
 +2327,17 @@
              * can only handle symmetric peer IDs */
        =
     multi->tx_peer_id =3D multi->rx_peer_id;
         }
+
+        unsigne=
d int iv_proto =3D extract_iv_proto(multi->peer_info);
+
+        if (iv_pr=
oto & IV_PROTO_NCP_P2P && multi->session->opt->push_peer_info_detail < 1)
+=
        {
+            /* If are currently not sending any peerinfo to the =
peer but the
+             * (most likely mode =3D=3D MODE_SERVER) but the =
peer is using NCP P2P
+             * we also enable sending minimal peerin=
fo that carries p2p NCP to
+             * allow peers in p2p mode to conne=
ct */
+            multi->session->opt->push_peer_info_detail =3D 1;
+     =
   }
     }
 
     free(multi->remote_ciphername);
@@ -2413,7 +2434,7 @@
  =
       setenv_del(session->opt->es, "exported_keying_material");
     }
 
-=
    if (!session->opt->server && !session->opt->pull && ks->key_id =3D=3D 0=
)
+    if (!session->opt->server && !session->opt->pull && ks->key_id =3D=
=3D 0 && session->opt->mode !=3D MODE_SERVER)
     {
         /* We are a p=
2p tls-client without pull, enable common
          * protocol options */

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b29026c2920a=
62a0ea570fd098649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 1
Gerrit-=
Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--QXXvUgJ3bNU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Reduce number of future epoch keys from 16 to 4<br><br>The calcula=
tion in the RFC was wrong and probably influenced<br>by an older worst case=
 assumption=2E With the fixed calculation<br>four future epoch keys should =
be more than enough even for<br>100 Gbit/s=2E So change the number to 4 in =
OpenVPN as well=2E<br><br>This also reduces the spam about the epoch keys a=
 bit=2E<br><br>Thanks to Ralf Lici for noticing the wrong calculation=2E<br=
><br>Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br=
>1 file changed, 42 insertions(+), 21 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/184=
4/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><b=
r><span>index fd96b85=2E=2E617ac2f 100644</span><br><span>--- a/src/openvpn=
/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1343=
,10 +1343,14 @@</span><br><span> init_epoch_keys(struct key_state *ks, stru=
ct tls_multi *multi, const struct key_type *key_type,</span><br><span>     =
            bool server, struct key2 *key2)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* For now we hardcode this to=
 be 16 for the software based data channel</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* For now we hardcode this to be 4 for the soft=
ware based data channel</span><br><span>      * DCO based implementations/H=
W implementation might adjust this number</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * based on their expected speed */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t future_key_count =
=3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * based=
 on their expected speed=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* One epoch lasts 910 GB with 128 byte packets or 78s at 100 GBit/s=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (respectively 101=
1 GB and 86s with 1280 byte packets)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t future_key_count =3D 4;</span><br><span> </span><=
br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DI=
RECTION_NORMAL;</span><br><span>     struct key_direction_state kds;</span>=
<br><span>@@ -1874,7 +1878,8 @@</span><br><span> </span><br><span>     /* I=
n server mode we only add this when the client has announced its</span><br>=
<span>      * support for the feature */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || mul=
ti-&gt;use_asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || multi-&gt;u=
se_asymmetric_peer_id</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        || !session-&gt;opt-&gt;server)</span><br><span>     {</span><br>=
<span>         return buf_printf(out, &quot;ID=3D%x\n&quot;, multi-&gt;rx_p=
eer_id);</span><br><span>     }</span><br><span>@@ -1945,21 +1950,21 @@</sp=
an><br><span>         /* support for P_DATA_V2 */</span><br><span>         =
int iv_proto =3D IV_PROTO_DATA_V2;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* support for the latest --dns opt=
ion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv_prot=
o |=3D IV_PROTO_DNS_OPTION_V2;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>         /* support for exit notify via control c=
hannel */</span><br><span>         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* currently push-update is not supported when DCO is enabled */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!session-&gt;opt-=
&gt;dco_enabled)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* su=
pport push-updates */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         if (session-&gt;opt-&gt;pull)</span=
><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* support for the latest --dns option */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            iv_proto |=3D IV_PROTO_DNS_=
OPTION_V2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* currently pus=
h-update is not supported when DCO is enabled */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!session-&gt;opt-&gt;dco_enabl=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* sup=
port push-updates */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>             /* support for re=
ceiving push_reply before sending</span><br><span>              * push requ=
est, also signal that the client wants</span><br><span>              * to g=
et push-reply messages without requiring a round</span><br><span>@@ -1974,2=
1 +1979,26 @@</span><br><span> </span><br><span>             /* support for=
 tun-mtu as part of the push message */</span><br><span>             buf_pr=
intf(&amp;out, &quot;IV_MTU=3D%d\n&quot;, session-&gt;opt-&gt;frame=2Etun_m=
ax_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* support for Negotiable Crypto Parameters */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (session-&gt;opt-&gt;mode =3D=3D MODE_=
SERVER || session-&gt;opt-&gt;pull)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* legacy support for Negotiable Crypto Parameters (depreca=
ted in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
* favour of IV_CIPHERS) */</span><br><span>             if (tls_item_in_cip=
her_list(&quot;AES-128-GCM&quot;, session-&gt;opt-&gt;config_ncp_ciphers)</=
span><br><span>                 &amp;&amp; tls_item_in_cipher_list(&quot;AE=
S-256-GCM&quot;, session-&gt;opt-&gt;config_ncp_ciphers))</span><br><span> =
            {</span><br><span>                 buf_printf(&amp;out, &quot;I=
V_NCP=3D2\n&quot;);</span><br><span>             }</span><br><span>        =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (session-&=
gt;opt-&gt;mode !=3D MODE_SERVER)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            /* We are not using pull=
 or p2mp server, instead do P2P NCP */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            /* If we are not using pull we announce P2P =
NCP support */</span><br><span>             iv_proto |=3D IV_PROTO_NCP_P2P;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* We are sending our ping=
 receive timeout to allow detecting</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * mismatched ping */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;ping_rec_=
timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                b=
uf_printf(&amp;out, &quot;P=3D%d\n&quot;, session-&gt;opt-&gt;ping_rec_time=
out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span>         }</span><br><span> </span><br><span>         if (s=
ession-&gt;opt-&gt;data_epoch_supported)</span><br><span>@@ -2317,6 +2327,1=
7 @@</span><br><span>              * can only handle symmetric peer IDs */<=
/span><br><span>             multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;=
</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uns=
igned int iv_proto =3D extract_iv_proto(multi-&gt;peer_info);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (iv_proto &amp; IV_PROTO_NCP_P2P &amp;&am=
p; multi-&gt;session-&gt;opt-&gt;push_peer_info_detail &lt; 1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* If are currently not sendi=
ng any peerinfo to the peer but the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * (most likely mode =3D=3D MODE_SERVER) but th=
e peer is using NCP P2P</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             * we also enable sending minimal peerinfo that carries p2p=
 NCP to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * allow peers in p2p mode to connect */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;session-&gt;opt-&gt;push_peer_in=
fo_detail =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span>     }</span><br><span> </span><br><span>     free(m=
ulti-&gt;remote_ciphername);</span><br><span>@@ -2413,7 +2434,7 @@</span><b=
r><span>         setenv_del(session-&gt;opt-&gt;es, &quot;exported_keying_m=
aterial&quot;);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!session-&gt;opt-&gt;server &amp=
;&amp; !session-&gt;opt-&gt;pull &amp;&amp; ks-&gt;key_id =3D=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!session-&gt;opt-&g=
t;server &amp;&amp; !session-&gt;opt-&gt;pull &amp;&amp; ks-&gt;key_id =3D=
=3D 0 &amp;&amp; session-&gt;opt-&gt;mode !=3D MODE_SERVER)</span><br><span=
>     {</span><br><span>         /* We are a p2p tls-client without pull, e=
nable common</span><br><span>          * protocol options */</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd09=
8649e197 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1844 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--QXXvUgJ3bNU=--


--===============6008498050634053679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6008498050634053679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6008498050634053679==--

