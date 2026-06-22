Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60FFCD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWvihXWbWvRDYBgwcaDd7Y1yoW3eFCfEBvgdg5SLcWg=; b=jmabyT4rmWKGv0RfOHG77WjL1G
	itVfbLnhoLuUT4CKaAKrvZff/NycBlYHwPsWprqyT9lSM+ALMxbNR1z4t364HPL5RbQxzG+S7wryU
	4fD+sFzBDxq7QELdnym1eGqiaJAY07pkvBFlIeuSDIG30CBOfV9QmgsYuw+Cio7MiEvs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgcZ-0007lw-KD;
	Mon, 22 Jun 2026 15:31:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgcX-0007ln-VB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Kn6rJxBtAHHto5QznEh14FqOZC+EyjAjguo6BkyBHtI=; b=XJwv3wJ0yUkMtZqQrFiuVkzGZM
 htp29FCXeXjA+OoDQCZXZnzt+qL4SOGqlZYe97h1LncvUoSG6LYjIlRXY4T3YTx5RsQWVHCZrHbn0
 PoBQG0zPyUTVGFraKkP/rTEnEPMCDX8Oc2CKdCqff1eqGUXew2vHI3Q+khdCuw+heNMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Kn6rJxBtAHHto5QznEh14FqOZC+EyjAjguo6BkyBHtI=; b=P
 cELAvkG3Bn3FxTLEOeGEtRduzKAttLf3WTJNzhB6p8cU4hqEpEh7tvzjePle27GvXvaeqMas96Ikk
 YAbhrcNfS8P4Tn9Ahk1TJPDJyhFZzjltVpdCSoycaTMoEtDK4sDR/Yns/xZw0jSylXSnr2vs0yGl9
 Cj71vt00MEBIH2iM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgcW-0007nd-DX for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:34 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4633193af19so3172062f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142281; x=1782747081; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kn6rJxBtAHHto5QznEh14FqOZC+EyjAjguo6BkyBHtI=;
 b=dWr7xDRs2NKTqF6GpX5VmpVoy0iwrG+NWTy12PlpPWHXrN0Hy8SaRThrKJ7k7d3czy
 HkabejKu6x+kA9QD7ZUfPWpTT5odNkpkB7xRpVNXIc4CLAujGcsHRw76EkEDF9RPIGwc
 xogpOREuEvEbhbDabG+e3AMsJ70Qc247K/JWuEE1Ut1gdiFWofLKvravboWK6HwSxqSs
 DH6tY8UxNYHuzo0cfnZvAuCTuz2axvl6Sg65i6+qTXqATbxMOGPypsXoL7BVcuVZUsC5
 7nid5GN5EbUV7tSYlSKAlgsBXU1BdevqxdwnBZrOl2BB7WTQjxvz6JieGLZkWY26XL9w
 pcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142281; x=1782747081;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kn6rJxBtAHHto5QznEh14FqOZC+EyjAjguo6BkyBHtI=;
 b=GryhKiweNILFdyHIEK0c6PpQROQCh82tm4az1xGZB54ljag7h5CNK//3X8A00vBZR+
 +r0Vq0QK/ymWCxu99rvsQ9Gan0+y6I/z+WNg9L7I0DdXCMIMFOJ8Nfk77wSBzh0Ovhx+
 rlIs87YKPSLSgsCebsmKf7+ZbZVS+uhLDxZ7FiGgGXqvr1cV3FclYiugh95EM2W1EmPM
 D2FKQT1rBa4YFQkrY7orPoFhtKJULa0O3/FjwmqDFY2cB4NejxZg+kswR9jJpy0+tjuG
 r3ad821IneJ5RaidQTmLB6Fr+ADTr316pVvakkhzGrP3O7tYvz2xrhHofaOkeYenURyE
 ewdw==
X-Gm-Message-State: AOJu0YyCxDq9XnuF792t6pk7nCzj62bPSsUV0lThIO3Oi8VxjJxzZVWh
 8jXtfsS+y5qU9x3DhQJS7RfwL7JqGpbSMjYLAS+Kg601/iC4Ddx6BsDIoHPPH22ZIMyo4onkwu2
 QUwUK8Gj8U90oqBhELnUM2KHwbf9bmuG4YHaRKXRoCa5khVOzOVDVhSh3lAGTxAQHc5XR5sHVQ0
 B4enH4Jw==
X-Gm-Gg: AfdE7cmo8qpg1Byd8C5/68wjWd3PxB4fuK5eqpvX+gQJQnWjZ7cXT2MclHBc3N9ZtON
 6OKgSvqOZiCxxR3W653OlyV+ztd6TSscS9e3O0LNhwqkR5s485NYtK1F54UErHyAZaSS63QjJBY
 adq3eZ4U2RlwqQe5RY8yex8XrKRZLF4cWIykNgx2y9v+Ubs3PfbGtTovkdyLYLlih3yBFlNW+FH
 9hhQyUbwaTnUZ1oPlhBheUjcgpvCRXkQd/SWnoTs49TYwNONekUQ31TxW0/egpCwQki1CXvStPq
 sVCssQIyqP91d672a9wOalPbZeiei/6TU0Z0zZLRzrqOtW81SJHoouI7Lbz3mx7AjzaDyG4uwFB
 V8TeJWE/BOUtDnWEoWVyN81cgwBc0BGgfRdAzmucoyidwLpZJHwS/zAWhO3UIQYs7EmRg+O0Tjw
 Q1OHmriRVBIaez+Ug0OEOzV36fhxZzpyb796bfu3UMe/NSORHLZGz7YdOygfqWzOqtVXFrvgofY
 ku9nGQBPNE+kKwdSIzKsNzJpbzJrCeIdgTZhcLrW9xmD3EHqc2S4ojuQG+yBDvmV8aXnGwLKs3G
 VH/BPQFmodM1Gw==
X-Received: by 2002:adf:fec5:0:b0:461:b44c:a7a6 with SMTP id
 ffacd0b85a97d-46662dcdd1fmr12933108f8f.34.1782142281175; 
 Mon, 22 Jun 2026 08:31:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46667221de7sm26374802f8f.33.2026.06.22.08.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: c0541eaa980ef834b0c33d23aa466d7582ea877b
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e9a0261af972605654500c183af06c15c0a8c431-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgcW-0007nd-DX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support p2p NCP
 negotiation in p2mp mode
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
Content-Type: multipart/mixed; boundary="===============9053460314006279878=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9053460314006279878==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PLvlpBuw+8E="; charset=UTF-8

--PLvlpBuw+8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1719?usp=3Demail )


Change subject: Support p2p NCP negoti=
ation in p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Support p2p NCP negotiation in p2mp mode

This sends the peer info =
of the server to a p2p mode client if it is
detected=2E This is currently m=
ake little difference as peer-id/DATAv2 does
not work without asymmetric pe=
er-id support of the p2p mode client but
prepares for mesh/multipeer suppor=
t=2E

Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
M src/openvpn/=
ssl=2Ec
M src/openvpn/ssl_ncp=2Ec
3 files changed, 51 insertions(+), 7 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/19/1719/2

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
in=
dex e72066f=2E=2Ef853669 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openv=
pn/multi=2Ec
@@ -1707,6 +1707,43 @@
     gc_free(&gc);
 }
 
+
+/**
+ * Gene=
rates warning for p2p mode peers=2E
+ */
+static void
+multi_client_set_pro=
tocol_warnings_p2p(struct context *c)
+{
+    struct tls_multi *multi =3D c=
->c2=2Etls_multi;
+    const struct tls_session *session =3D &multi->sessio=
n[TM_ACTIVE];
+
+    /* we can support p2p clients but only if we and the o=
ther side
+     * support asymmetric peer-id */
+    msg(D_TLS_DEBUG_LOW, "=
Note: peer reports running in P2P mode "
+                         "(no --p=
ull/--client option)=2E This will "
+                         "probably not=
 work as expected=2E");
+
+    /* Figure out which side is lacking asymmetr=
ic peer-id support and
+     * print appropriate warnings */
+    if (!mult=
i->use_asymmetric_peer_id)
+    {
+        if (session->opt->dco_enabled)
+=
        {
+            msg(D_TLS_DEBUG_LOW, "Note: Supporting P2P mode peer=
s requires "
+                                 "support of asymmetric peer-=
id which the "
+                                 "current DCO module does n=
ot support=2E Disable "
+                                 "DCO or upgrade t=
o a version of OpenVPN and "
+                                 "DCO that su=
pport asymmetric peer-id=2E");
+        }
+        if (extract_asymmetric_p=
eer_id(multi->peer_info) =3D=3D MAX_PEER_ID)
+        {
+            msg(D_=
TLS_DEBUG_LOW, "Note: Supporting P2P mode peers requires "
+               =
                  "support of asymmetric peer-id=2E The peer does not "
+  =
                               "indicate it supports this=2E");
+        }
=
+    }
+}
+
 /**
  * Calculates the options that depend on the client capab=
ilities
  * based on local options and available peer info
@@ -1737,13 +177=
4,11 @@
         return false;
     }
 
-    /* Print a warning if we detec=
t the client being in P2P mode and will
-     * not accept our pushed ciphe=
rs */
+    /* Print a warning if we detect the client being in P2P mode=2E =
The
+     * negotiations will be otherwise compatible */
     if (proto & I=
V_PROTO_NCP_P2P)
     {
-        msg(M_WARN, "Note: peer reports running in=
 P2P mode (no --pull/--client "
-                    "option)=2E It will no=
t negotiate ciphers with this server=2E "
-                    "Expect this=
 connection to fail=2E");
+        multi_client_set_protocol_warnings_p2p(c=
);
     }
 
     if (proto & IV_PROTO_REQUEST_PUSH)
diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec
index c97d479=2E=2E6d58a3d 100644
--- a/src=
/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1883,7 +1883,8 @@
 
     /* =
In server mode we only add this when the client has announced its
      * s=
upport for the feature */
-    if (session->opt->mode !=3D MODE_SERVER || m=
ulti->use_asymmetric_peer_id)
+    if (session->opt->mode !=3D MODE_SERVER =
|| multi->use_asymmetric_peer_id
+        || !session->opt->server)
     {
=
         return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
     }
@@ =
-2331,6 +2332,14 @@
                 /* With DCO we don't need the tx_peer_=
id atm */
                 multi->tx_peer_id =3D multi->rx_peer_id;
       =
      }
+            unsigned int iv_proto =3D extract_iv_proto(multi->peer=
_info);
+
+            if (iv_proto & IV_PROTO_NCP_P2P && multi->session->o=
pt->push_peer_info_detail < 1)
+            {
+                /* If the pe=
er is using NCP P2P we also use p2p to make connecting
+                 * =
with p2p peers easier */
+                multi->session->opt->push_peer_in=
fo_detail =3D 1;
+            }
         }
     }
     else
diff --git a/sr=
c/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index e860f6d=2E=2E003b77e =
100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -515,=
7 +515,7 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation re=
sult: "
-                         "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-i=
d %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+                         "T=
LS_EKM=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=
=3D%s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIA=
L_EXPORT),
         multi->use_peer_id,
         multi->rx_peer_id,

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f3545f703126dbe96f809e=
69ad351749b14b1e1
Gerrit-Change-Number: 1719
Gerrit-PatchSet: 2
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--PLvlpBuw+8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Support p2p NCP negotiation in p2mp mode<br><br>This sends the pe=
er info of the server to a p2p mode client if it is<br>detected=2E This is =
currently make little difference as peer-id/DATAv2 does<br>not work without=
 asymmetric peer-id support of the p2p mode client but<br>prepares for mesh=
/multipeer support=2E<br><br>Change-Id: I8f3545f703126dbe96f809e69ad351749b=
14b1e1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
M src/openvpn/multi=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_ncp=
=2Ec<br>3 files changed, 51 insertions(+), 7 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
19/1719/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index e72066f=2E=2Ef853669 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -1707,6 +1707,43 @@</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generates warning for =
p2p mode peers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_set_protocol_=
warnings_p2p(struct context *c)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct tls_session *session =3D &amp;=
multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we=
 can support p2p clients but only if we and the other side</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * support asymmetric peer-id */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG=
_LOW, &quot;Note: peer reports running in P2P mode &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         &quot;(no --=
pull/--client option)=2E This will &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         &quot;probably not work as e=
xpected=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Figure out wh=
ich side is lacking asymmetric peer-id support and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * print appropriate warnings */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;use_asym=
metric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sessio=
n-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_TLS_DEBUG_LOW, &quot;Note: Supporting P2P mode peers require=
s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                      &quot;support of asymmetric peer-id which the &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             &quot;current DCO module does not support=2E Disable &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
           &quot;DCO or upgrade to a version of OpenVPN and &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     &quot;DCO that support asymmetric peer-id=2E&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (extract_asymmetric_peer_id(multi-&g=
t;peer_info) =3D=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_TLS_DEBUG_LOW, &quot;Note: Supporting P2P mode peers r=
equires &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                            &quot;support of asymmetric peer-id=2E The peer=
 does not &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                              &quot;indicate it supports this=2E&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * Calculates the options=
 that depend on the client capabilities</span><br><span>  * based on local =
options and available peer info</span><br><span>@@ -1737,13 +1774,11 @@</sp=
an><br><span>         return false;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Print a warni=
ng if we detect the client being in P2P mode and will</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * not accept our pushed ciphers */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Print a warning =
if we detect the client being in P2P mode=2E The</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * negotiations will be otherwise compatib=
le */</span><br><span>     if (proto &amp; IV_PROTO_NCP_P2P)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_WARN, &quot;Note: peer reports running in P2P mode (no --pull/--client &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  &quot;option)=2E It will not negotiate ciphers with this server=2E &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &=
quot;Expect this connection to fail=2E&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        multi_client_set_protocol_warnings_p2p(c=
);</span><br><span>     }</span><br><span> </span><br><span>     if (proto =
&amp; IV_PROTO_REQUEST_PUSH)</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index c97d479=2E=2E6d58a3d 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -1883,7 +1883,8 @@</span><br><span> </span><b=
r><span>     /* In server mode we only add this when the client has announc=
ed its</span><br><span>      * support for the feature */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (session-&gt;opt-&gt;mode !=3D M=
ODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERV=
ER || multi-&gt;use_asymmetric_peer_id</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        || !session-&gt;opt-&gt;server)</span><br><span>=
     {</span><br><span>         return buf_printf(out, &quot;ID=3D%x\n&quot=
;, multi-&gt;rx_peer_id);</span><br><span>     }</span><br><span>@@ -2331,6=
 +2332,14 @@</span><br><span>                 /* With DCO we don&#39;t need=
 the tx_peer_id atm */</span><br><span>                 multi-&gt;tx_peer_i=
d =3D multi-&gt;rx_peer_id;</span><br><span>             }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            unsigned int iv_proto =
=3D extract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (iv_proto &amp; IV_PROTO_NCP_P2P &amp;&amp; multi-&gt;se=
ssion-&gt;opt-&gt;push_peer_info_detail &lt; 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                /* If the peer is using NCP P2P we al=
so use p2p to make connecting</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 * with p2p peers easier */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;session-&gt;opt=
-&gt;push_peer_info_detail =3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span>         }</span><br><span>    =
 }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/ssl_n=
cp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index e860f6d=2E=2E003b77e=
 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b=
/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -515,7 +515,7 @@</span><br><spa=
n>     }</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;=
P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                         &quot;TLS_export=3D%d, DATA_v2=
=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                         &q=
uot;TLS_EKM=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, c=
ipher=3D%s&quot;,</span><br><span>         (bool)(session-&gt;opt-&gt;crypt=
o_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span>         mul=
ti-&gt;use_peer_id,</span><br><span>         multi-&gt;rx_peer_id,</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1719?usp=3Demail">change 1719</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I8f3545f703126dbe96f809e=
69ad351749b14b1e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1719 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--PLvlpBuw+8E=--


--===============9053460314006279878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9053460314006279878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9053460314006279878==--

