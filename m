Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A79606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BB5kAUrx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QA7Boqgp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OTeYIibo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fNYmEk6V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=IX8Prbn0otg3pOC+R3xkzkc9E2UPDOVOECVHKUa0XF8=; b=BB5kAUrx/5JIPmPVB8+eoWefPw
	3yurvLqLsl2FX+0FnkWFWTHj1bP/oXxUjFPf/rioRc2YygcHVMNIwfg2biwFosyrKD10/eAsJe4in
	YVimZSgmvUTWlKUpR+VEzXuSZgO+yG9t8spp+ItN1M5+kYD2dcfh8wijDeJVN4JWHOTg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWGI-0000000073L-1iQx;
	Thu, 26 Nov 2026 09:59:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWWGG-0000000073D-1olR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ypFuBcatLWnGDx/hismWVu7Eh8GLdB6uyRnmnyGjhCk=; b=QA7BoqgpFq7189oZCA728tXkdg
 lWthpEAFUKB8SbeLb7P5S0Oj3NpB5DLyf1rSHGcLQAZPOGRb5N9Vs6uLmF9/G4BwB0u5WoY2nlw7S
 g8i00BcaLQct9X5zykVbDW0Avp6LLd6ZoIvnMk6tXiXYUMoGKLCelmrTa8+ECczdQCfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ypFuBcatLWnGDx/hismWVu7Eh8GLdB6uyRnmnyGjhCk=; b=OTeYIiboCuIa5WrkpRka4STkJt
 wIDZMI4xlg38PoHSDYEkWSuSv86s0yg1m938+DRaFSYyIPC7kcF8yaVhBFK1h9ZWV+Y+Fr/6XfWs7
 AiU/J+r0emya2UfuHEUc05+qKmYysT+2dK4/toLWgkkFyJK1aBap1VcH50CksGoHFkYw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWWGE-000000006MQ-3akU for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:59:28 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so87497375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795687160; x=1796291960; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ypFuBcatLWnGDx/hismWVu7Eh8GLdB6uyRnmnyGjhCk=;
 b=fNYmEk6ViO7h32iJRHbBTT7YX5FWkiTHw1q/pVaKWgJVgpl3jBVdsYAKTv78HNKhbe
 l/Clk/fZ44W5XyVV8jR9Mw3kBQNGAA3bBg7fGbLVK/uk2wcZxjy62jkchyKKkDl1WxB5
 hemCYzBgi7bS3G+BmMNEMY7CphPvEE4ADBYjQuRS2E68Bbf1cxY8fhWqi4F/7R4NmkWJ
 Z3IUm5MNIs26DoqY+UOXcX7yB7zhgGw/eWOXt3poK2zYuZeuoGG+5PkGqhEfrSg2i8yj
 RBZDQAEHHri5Qwq3n5bgeyynt/MYupzio7Uj+C8x5GyQaewgJc7q3cyQfP9pqz1GbZ63
 PlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687160; x=1796291960;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ypFuBcatLWnGDx/hismWVu7Eh8GLdB6uyRnmnyGjhCk=;
 b=vli1wmjgBX4CUz8zZ9deagsvdtYBswQe8zXyWIogH4qb6K4hxw9kmMOYnOG4MHWSzq
 zQLj73TdRabVRkwuhbHu/skT9iEc0OZLFWv9uWVftNjdux3R30sMyer4NwaZp45CHN8L
 X8yJm37+KS8Zn58RrOjvdrIWpgvV+eWjfbj7HxEJcMcFX2RGw5XJm3eA2zu7ps4iJJek
 RlU+9gIAHBdY1Map54mHD+7nhAN/b4aoLaal4I8SunQgtylsgVfSng95jmWxTyKIW5EC
 sjmdt5oLYZpCkVHtpmW01wkFiVYr6jotFZvF/fj4qBdZy6Fc/ZxYsvmfwoY4ZPNBqC/j
 fktw==
X-Gm-Message-State: APuU4Z8cCXWfkDWn1Ai4h1H9lvtMNyL+CIdNVNwWXwQ7N9DBo29+XbD3
 JAynpZzWx6BnkraycNn34O4tgb0FWTwwdKcAh1ZnW6Yo0ltX1C97smL2OG5FPSBj07MP/a8JwXB
 Fnd8EZCs/DZo63YCpl2e6tn4KUk6lbwsd6sXuCg8Lc3LdB3pJDsmZgBCTJw0b1Rqcc++WIkP+YY
 reGGh99Q==
X-Gm-Gg: AZFdTZeDZoql+kvqsAf75RkYFLm6MsoggS+vAPtP6xwpTyGwW50Cv8o27KCT/1DzYs/
 XjUtNc2Ab3RvaDBlSHv7ruBKmlG1UQlWhLCeXoP/2AERqnn5XLpTga813SIFHjNuVUNXeJLaDTu
 Y3SpkAtxq/f4iOoOZJEhjvPG1tSdfElflWr8mM6jO4eX8HTqNFiiEX4uFWAKTF1ROA6DsI76qxi
 Ydrny56SiUxu2pzRWPi5gVEWqrYDhNwZaiZ9y2sgAQfYda3RgblwFj1n2oKphluZwOXlRU82+Hg
 n0T6qBBv4WUIk65TpzvvaWH5znDuuJB67cxF77HJuvm/eLmLslosLzpazJXbropLMEjTOQMCq9F
 k+pIoHlHDZL9qqDNWcfwVdVgUivNWXgkvVfGvVEn4napYPEaitz33xhQPejrRU+0E7tB0ZNjioR
 TCwU3AquvazHJdxSTS81k8zdd3EK8dGhrFCRv19K5G2gA2T/X1oqeek53LI8/SzoSSm5H82oMuT
 LSyPtE+Zwehx1ycEdlsg8Iy4iWiY3w3A+jc0oM7HZ1pHtfLCD7jSjUfb5WnnqWvhcXARzyVzYqB
 Stzq97V6+YwfKB+i7UsDT75eqBo6tjow0dfgwI2Yk8usQCGSRJdWrVGdIn8HXmHxAInt2cNwqDe
 Oy519Knb7NHAMphLb9zEcEQ3FgARj1QXbEJZkUUFi/vMmsl/OwF+6rUSwzcLRpwH/LVVpsDTD94
 l0HNcZHDztnkLwHEI=
X-Received: by 2002:a05:600c:2d42:b0:4ba:7a0:7b67 with SMTP id
 5b1f17b1804b1-4bb8613a0b1mr312654325e9.3.1795687160042; 
 Thu, 26 Nov 2026 01:59:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm40161167f8f.53.2026.11.26.01.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:59:19 -0800 (PST)
X-Google-Original-From: "Farshid Rezaiyan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:59:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054
X-Gerrit-Change-Number: 2350
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2350?usp=email>
X-Gerrit-Commit: 94c2e2c986d1ebe723b000e433f97fa6c6fbc696
References: <gerrit.1795687157000.Ic667de6f830fa86e2842f1da2820e1250b9d6054@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njg3MTU3MDAwLkljNjY3ZGU2ZjgzMGZhODZlMjg0MmYxZGEyODIwZTEyNTBiOWQ2MDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48ab88124bee073d909d58a95ce71b4e17f82516-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWWGE-000000006MQ-3akU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: call
 client-disconnect handlers when late client setup fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Farshid Rezaiyan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: farshidrezaiyan@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Farshid Rezaiyan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1603527506336609083=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1603527506336609083==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QDGJOtnnTkk="; charset=UTF-8

--QDGJOtnnTkk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2350?usp=3Demail

to review the following change=2E
=


Change subject: multi: call client-disconnect handlers when late client s=
etup fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
ulti: call client-disconnect handlers when late client setup fails

multi_c=
lient_connect_late_setup() is only reached after all
client-connect handler=
s (scripts and plugins) have succeeded=2E It sets
the state to CAS_CONNECT_=
DONE and then downgrades it to CAS_FAILED if
setting the protocol options, =
adding the DCO peer or generating the
data channel keys fails=2E

multi_clo=
se_instance() only calls the client-disconnect handlers for
instances in st=
ate CAS_CONNECT_DONE, so for such a client the
client-connect handlers have=
 run but client-disconnect never does=2E
Anything that pairs the two calls =
gets out of sync=2E For example, a
RADIUS accounting plugin that sends Acco=
unting-Start on connect and
Accounting-Stop on disconnect keeps the session=
 open forever=2E

This is easy to hit with DCO on Linux and TCP: if the cli=
ent closes
the TCP connection while a client-connect handler is running, th=
e
kernel refuses to attach the socket ("provided TCP socket is not in
ESTAB=
LISHED state") and dco_multi_add_new_peer() fails=2E

Remember in the new d=
id_client_connect flag that a client-connect
plugin or script was called wi=
th success=2E This is the case if one is
defined, because multi_client_conn=
ect_late_setup() is only reached
when all client-connect handlers have succ=
eeded=2E
multi_close_instance() then also calls the disconnect handlers for=
 an
instance in CAS_FAILED that has this flag set=2E So they run on instanc=
e
shutdown and exactly once, as for any other client, and only after a
succ=
essful client-connect=2E

GitHub: closes OpenVPN/openvpn#1155
Change-Id: Ic=
667de6f830fa86e2842f1da2820e1250b9d6054
Signed-off-by: Farshid Rezaiyan <fa=
rshidrezaiyan@gmail=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=
=2Eh
2 files changed, 16 insertions(+), 1 deletion(-)



  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/2350/1

diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 900b5a3=2E=2E706195a 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -718,7 +718,1=
0 @@
     set_cc_config(mi, NULL);
 #endif
 
-    if (mi->context=2Ec2=2Etl=
s_multi->multi_state >=3D CAS_CONNECT_DONE)
+    /* A client that failed in=
 multi_client_connect_late_setup() is in
+     * CAS_FAILED, but its client=
-connect handlers did succeed */
+    if (mi->context=2Ec2=2Etls_multi->mul=
ti_state >=3D CAS_CONNECT_DONE
+        || (mi->did_client_connect && mi->c=
ontext=2Ec2=2Etls_multi->multi_state =3D=3D CAS_FAILED))
     {
         mu=
lti_client_disconnect_script(mi);
     }
@@ -2414,6 +2417,15 @@
     /* set=
 context-level authentication flag */
     mi->context=2Ec2=2Etls_multi->mu=
lti_state =3D CAS_CONNECT_DONE;
 
+    /* We only get here if all client-co=
nnect handlers succeeded, so a
+     * defined client-connect plugin or scr=
ipt has been called with
+     * success=2E Remember this, as the steps bel=
ow may still set
+     * CAS_FAILED, and the client-disconnect handlers mus=
t then be called
+     * when the instance is closed=2E */
+    mi->did_cli=
ent_connect =3D plugin_defined(mi->context=2Eplugins, OPENVPN_PLUGIN_CLIENT=
_CONNECT)
+                             || plugin_defined(mi->context=2Eplu=
gins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+                             || mi=
->context=2Eoptions=2Eclient_connect_script !=3D NULL;
+
     /* Since dco-=
win maintains iroute routing table (subnet -> peer),
      * peer must be a=
dded before iroutes=2E For other platforms it doesn't matter=2E */
 
diff -=
-git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3d2e932=2E=2E9cc=
986c 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -145=
,6 +145,9 @@
     struct buffer_list *cc_config;
 #endif
     bool did_irou=
tes;
+    /** a client-connect plugin or script was called and succeeded, s=
o
+     * client-disconnect must be called when the instance is closed */
+=
    bool did_client_connect;
     int n_clients_delta;    /* added to multi=
_context=2En_clients when instance is closed */
 
     struct context conte=
xt; /**< The context structure storing state

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2350?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054
Gerr=
it-Change-Number: 2350
Gerrit-PatchSet: 1
Gerrit-Owner: Farshid Rezaiyan <f=
arshidrezaiyan@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--QDGJOtnnTkk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Farshid Rezaiyan would like A=
rne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350?usp=3Demail">View Change</a></=
p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">multi: call client-disconnect handlers when late client set=
up fails<br><br>multi_client_connect_late_setup() is only reached after all=
<br>client-connect handlers (scripts and plugins) have succeeded=2E It sets=
<br>the state to CAS_CONNECT_DONE and then downgrades it to CAS_FAILED if<b=
r>setting the protocol options, adding the DCO peer or generating the<br>da=
ta channel keys fails=2E<br><br>multi_close_instance() only calls the clien=
t-disconnect handlers for<br>instances in state CAS_CONNECT_DONE, so for su=
ch a client the<br>client-connect handlers have run but client-disconnect n=
ever does=2E<br>Anything that pairs the two calls gets out of sync=2E For e=
xample, a<br>RADIUS accounting plugin that sends Accounting-Start on connec=
t and<br>Accounting-Stop on disconnect keeps the session open forever=2E<br=
><br>This is easy to hit with DCO on Linux and TCP: if the client closes<br=
>the TCP connection while a client-connect handler is running, the<br>kerne=
l refuses to attach the socket (&quot;provided TCP socket is not in<br>ESTA=
BLISHED state&quot;) and dco_multi_add_new_peer() fails=2E<br><br>Remember =
in the new did_client_connect flag that a client-connect<br>plugin or scrip=
t was called with success=2E This is the case if one is<br>defined, because=
 multi_client_connect_late_setup() is only reached<br>when all client-conne=
ct handlers have succeeded=2E<br>multi_close_instance() then also calls the=
 disconnect handlers for an<br>instance in CAS_FAILED that has this flag se=
t=2E So they run on instance<br>shutdown and exactly once, as for any other=
 client, and only after a<br>successful client-connect=2E<br><br>GitHub: cl=
oses OpenVPN/openvpn#1155<br>Change-Id: Ic667de6f830fa86e2842f1da2820e1250b=
9d6054<br>Signed-off-by: Farshid Rezaiyan &lt;farshidrezaiyan@gmail=2Ecom&g=
t;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>2 files =
changed, 16 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/2350/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span=
>index 900b5a3=2E=2E706195a 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -718,7 =
+718,10 @@</span><br><span>     set_cc_config(mi, NULL);</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state &gt;=3D CAS_CONNE=
CT_DONE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A cl=
ient that failed in multi_client_connect_late_setup() is in</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * CAS_FAILED, but its client-c=
onnect handlers did succeed */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state &gt;=3D =
CAS_CONNECT_DONE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     || (mi-&gt;did_client_connect &amp;&amp; mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;multi_state =3D=3D CAS_FAILED))</span><br><span>     {</span><br><sp=
an>         multi_client_disconnect_script(mi);</span><br><span>     }</spa=
n><br><span>@@ -2414,6 +2417,15 @@</span><br><span>     /* set context-leve=
l authentication flag */</span><br><span>     mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;multi_state =3D CAS_CONNECT_DONE;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* We only get here if all clien=
t-connect handlers succeeded, so a</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * defined client-connect plugin or script has been call=
ed with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * succe=
ss=2E Remember this, as the steps below may still set</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * CAS_FAILED, and the client-disconn=
ect handlers must then be called</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * when the instance is closed=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_client_connect =3D plugin_=
defined(mi-&gt;context=2Eplugins, OPENVPN_PLUGIN_CLIENT_CONNECT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                             |=
| plugin_defined(mi-&gt;context=2Eplugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
           || mi-&gt;context=2Eoptions=2Eclient_connect_script !=3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 /* Since dco-win maintains iroute routing table (subnet -&gt; peer),</span=
><br><span>      * peer must be added before iroutes=2E For other platforms=
 it doesn&#39;t matter=2E */</span><br><span> </span><br><span>diff --git a=
/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 3d2e93=
2=2E=2E9cc986c 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br=
><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -145,6 +145,9 @@</spa=
n><br><span>     struct buffer_list *cc_config;</span><br><span> #endif</sp=
an><br><span>     bool did_iroutes;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** a client-connect plugin or script was called and su=
cceeded, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * c=
lient-disconnect must be called when the instance is closed */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    bool did_client_connect;</sp=
an><br><span>     int n_clients_delta;    /* added to multi_context=2En_cli=
ents when instance is closed */</span><br><span> </span><br><span>     stru=
ct context context; /**&lt; The context structure storing state</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2350?usp=3Demail">change 2350</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2350?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2350 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Farshid Rezaiyan &lt;farshidrezaiyan@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--QDGJOtnnTkk=--


--===============1603527506336609083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1603527506336609083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1603527506336609083==--

