Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E117ECDB478
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3X6ea1h6fp9bn7KpGSnBwlhFrDudbN/OHeGm+5u8dXE=; b=nHx5faKSRIGyxK
	yLBmpoL+H3wJSrip8h1G6rhFUDBJhozEANGLz8OASdgwJwSpPb4ZhX3yblMeIkzW5joPTDtj7M+tW
	Zb41zK4OAC75buWszMevUSGa6LyBQrYZGLqcLo2SytQr0ExvpgQhFF0eBpBMidkXEowNpKb98FvfL
	fDU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecz-0004sh-7e;
	Mon, 22 Jun 2026 13:23:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbect-0004s6-2A
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TDYmHcLh9SGzcsc5uGyB7mczSrtVxGWUQXlaCK4T254=; b=fr+6xRb5JnimiZnC6ADyHAEchA
 hNdBIjPDb1RbL7+hyAAY0isxUk3pniJW1E8XR0G6Q4kIdmbJR96YtAHIoUkqffMSZd6cKGrSNOdLe
 Q9GPxfi8RX9usvaO9H7tXAjCfdaYEkO3PtKA0Hg/TdeqDF73NGXBLXiLtWu7rVTujka0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TDYmHcLh9SGzcsc5uGyB7mczSrtVxGWUQXlaCK4T254=; b=R
 ephIzXR/QwFOUtVYIcN5V0UK9QiRG2h4K+ydlh2g1PhNugZOSWVYztJYGpN6A0mhqf0Yv3ifRxpXg
 rw603rDLRa4kaidY+vshhj+XrFmqzZk6lu4ju2n6EVQ3THFr8m6XkUqGJci7Y2+/OX2Fxn12EyGi1
 CF2rQTwAaLz5hv0g=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecs-0000aN-3V for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49249072f03so10946215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134615; x=1782739415; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDYmHcLh9SGzcsc5uGyB7mczSrtVxGWUQXlaCK4T254=;
 b=NAkFERbAO9Koww1H8b/wnqHVTMJ59E6727QztkAoIh4L+J8jiPHd+Dc0uliiFpdiLl
 VoNsK4pt7xvLBKMx6zTqV9K5W/Cb6Yka9+hxEVjbJQdx84zuh1YVRi4SGYMm6I9ksMvr
 OkkEcSjezPRRPQ2vf3ZWUFDUzJ5AMPk8zkF22PxDSzmig7Kcb2VNUHtw7HLmKQcH9vN+
 P2KsZpBN7yxys08lC2W9QosJ04nLX6ZgkIFj9N27gUQ1GQxS1iz+Z+cyAgkNXlZzdZm0
 tDMMkqStb4PQnExTlRR4vZztZi2qHywlZw1YPmwgPkz7T3IoYYYw0ZGv0nEQqr7pCK7t
 ZdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134615; x=1782739415;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDYmHcLh9SGzcsc5uGyB7mczSrtVxGWUQXlaCK4T254=;
 b=g/lJGVgfSiLvP3abucFop70QhrjYYwAoUJ7VM9uMWoYyTxXUkr/gH3lxNyISIdtO2K
 mloR9nPE2pWZHqVLRrFDoMclXLf20JyLGMh2y2Gkj3D5TbsL/L9GJvxbnf2PVx3duuFF
 nSAELTMZWEhhJaOcmKm2RDhebqOnEUVRRgca28nt+JkaZZLEz9ZXzyGxMB3BMwNPc3JJ
 a+xtXz7l9Y89VCiIkRq3vXQHJyUqNpxrX220D4CKGsAmXnDcS6XzeMp9Kj/tSzvV1PON
 mdqxxHe2MjV33SdvuY3G4Xq8+z22pybWC5r0OfoCTOpfhZPzPfOluyVF4iJW2NVsL7oa
 EMYQ==
X-Gm-Message-State: AOJu0YwT3gC7GxZo/eIxo7L7D1ukSdZ6W2jTsvCKahm9w3CRDbmsBJf0
 wTNnGu2LSyWMHKH+x6TiYr/+zeeguhIRF7xxz3FngjQg6sbmBWgpUKSsjlGtBArJzqt80LIrwXD
 3Kq/hplH9fksgwoUYkRQ3wogRliPyzhDtwN6EMbJLc8jWc9leIjZ3l0s6RW8hRu62RNPsYXfEK6
 deY/6w5w==
X-Gm-Gg: AfdE7cnA9awFhjKqdwXiCVIMGW+qTWCUVsf4tdEljkSzzxXC0PswJfXNVnQLQmxDsYE
 blKypo0VsJ7GwML+0+kzLXkmEtf8CQn8X/EhxKgRdmJk0qnc7E9UCmLUWjv9TpOiNQzboHORXNE
 VHsfdFxMBhVWAy8BHpOBrbA41MdcpTZqujSkDlDOo3u7CHN5iPZJqPCIxZ4V3JrgsSXE5q+N8fc
 OBlN/scvfYZDO3y4Co67eqgJ7P7NQz+XoLxwDaOimlJ/zBG+b2bDbeC+gNzHHEH7t0/0eunaSnm
 Wb0LiMLzQq96fMt0/GCcYeNhoRWkJwIHLr4/6aA3YhMWC21LUzE+4Jnbj5EVjcJqFlYFWOgFn+Z
 uNX9MUdkitXdJc15nOUDEdCy5gnmpTJSqSIZnlcNMYpcVUiCKn0hhgr+NDXp7H18row628UO94V
 IhoillSLZzNXbNq8obvnUYehp+/CQujQZcXD88ji/U026Vhvamt42ZUduXGmaX275zwjGFJhfpn
 YnkLw4J2NWKaiiPCSyN7Geckh9SS+pnUO+JkmO3qMXmzUtS9WUk2Th+FaOmubRBKnO2vvBZ9lWQ
 wWU=
X-Received: by 2002:a05:600c:524d:b0:492:51aa:2d46 with SMTP id
 5b1f17b1804b1-49251aa2da9mr91533995e9.13.1782134614661; 
 Mon, 22 Jun 2026 06:23:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd154fdsm278590975e9.1.2026.06.22.06.23.34
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: 77d7cb922ef91d8ae21aef93c4d544d8671f6c1e
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <461628da12d47ba23b476419a6c875dd0732d53f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecs-0000aN-3V
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
Content-Type: multipart/mixed; boundary="===============6773981200620436133=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6773981200620436133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XXXCSfafm+c="; charset=UTF-8

--XXXCSfafm+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1719?usp=3Demail )


Change subject: Support p2p NCP neg=
otiation in p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Support p2p NCP negotiation in p2mp mode

This sends the peer in=
fo of the server to a p2p mode client if it is
detected=2E This is currentl=
y make little difference as peer-id/DATAv2 does
not work without asymmetric=
 peer-id support of the p2p mode client but
prepares for mesh/multipeer sup=
port=2E

Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
M src/openv=
pn/ssl=2Ec
M src/openvpn/ssl_ncp=2Ec
3 files changed, 53 insertions(+), 8 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/19/1719/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index e72066f=2E=2Ef853669 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -1707,6 +1707,43 @@
     gc_free(&gc);
 }
 
+
+/**
+ * =
Generates warning for p2p mode peers=2E
+ */
+static void
+multi_client_set=
_protocol_warnings_p2p(struct context *c)
+{
+    struct tls_multi *multi =
=3D c->c2=2Etls_multi;
+    const struct tls_session *session =3D &multi->s=
ession[TM_ACTIVE];
+
+    /* we can support p2p clients but only if we and =
the other side
+     * support asymmetric peer-id */
+    msg(D_TLS_DEBUG_L=
OW, "Note: peer reports running in P2P mode "
+                         "(n=
o --pull/--client option)=2E This will "
+                         "probabl=
y not work as expected=2E");
+
+    /* Figure out which side is lacking asy=
mmetric peer-id support and
+     * print appropriate warnings */
+    if (=
!multi->use_asymmetric_peer_id)
+    {
+        if (session->opt->dco_enabl=
ed)
+        {
+            msg(D_TLS_DEBUG_LOW, "Note: Supporting P2P mode=
 peers requires "
+                                 "support of asymmetric =
peer-id which the "
+                                 "current DCO module d=
oes not support=2E Disable "
+                                 "DCO or upgr=
ade to a version of OpenVPN and "
+                                 "DCO th=
at support asymmetric peer-id=2E");
+        }
+        if (extract_asymmet=
ric_peer_id(multi->peer_info) =3D=3D MAX_PEER_ID)
+        {
+            m=
sg(D_TLS_DEBUG_LOW, "Note: Supporting P2P mode peers requires "
+          =
                       "support of asymmetric peer-id=2E The peer does not =
"
+                                 "indicate it supports this=2E");
+     =
   }
+    }
+}
+
 /**
  * Calculates the options that depend on the client =
capabilities
  * based on local options and available peer info
@@ -1737,13=
 +1774,11 @@
         return false;
     }
 
-    /* Print a warning if we =
detect the client being in P2P mode and will
-     * not accept our pushed =
ciphers */
+    /* Print a warning if we detect the client being in P2P mod=
e=2E The
+     * negotiations will be otherwise compatible */
     if (prot=
o & IV_PROTO_NCP_P2P)
     {
-        msg(M_WARN, "Note: peer reports runni=
ng in P2P mode (no --pull/--client "
-                    "option)=2E It wi=
ll not negotiate ciphers with this server=2E "
-                    "Expect=
 this connection to fail=2E");
+        multi_client_set_protocol_warnings_=
p2p(c);
     }
 
     if (proto & IV_PROTO_REQUEST_PUSH)
diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5f3c09f=2E=2E852d475 100644
--- =
a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1883,7 +1883,8 @@
 
   =
  /* In server mode we only add this when the client has announced its
    =
  * support for the feature */
-    if (session->opt->mode !=3D MODE_SERVER=
 || multi->use_asymmetric_peer_id)
+    if (session->opt->mode !=3D MODE_SE=
RVER || multi->use_asymmetric_peer_id
+        || !session->opt->server)
  =
   {
         return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
     =
}
@@ -1994,7 +1995,8 @@
         }
         else
         {
-            /*=
 We are not using pull or p2mp server, instead do P2P NCP */
+            /=
* We are not using pull and are are either in real p2p mode
+             *=
 or doing p2p negotiation as p2mp server */
             iv_proto |=3D IV_P=
ROTO_NCP_P2P;
         }
 
@@ -2331,6 +2333,14 @@
                 /* With =
DCO we don't need the tx_peer_id atm */
                 multi->tx_peer_id =
=3D multi->rx_peer_id;
             }
+            unsigned int iv_proto =
=3D extract_iv_proto(multi->peer_info);
+
+            if (iv_proto & IV_PR=
OTO_NCP_P2P && multi->session->opt->push_peer_info_detail < 1)
+           =
 {
+                /* If the peer is using NCP P2P we also use p2p to make=
 connecting
+                 * with p2p peers easier */
+                m=
ulti->session->opt->push_peer_info_detail =3D 1;
+            }
         }
=
     }
     else
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=
=2Ec
index e860f6d=2E=2E003b77e 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/=
src/openvpn/ssl_ncp=2Ec
@@ -515,7 +515,7 @@
     }
 
     msg(D_TLS_DEBUG_L=
OW, "P2P mode NCP negotiation result: "
-                         "TLS_expo=
rt=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%=
s",
+                         "TLS_EKM=3D%d, DATA_v2=3D%d, rx-peer-id %d, t=
x-peer-id %d, epoch=3D%d, cipher=3D%s",
         (bool)(session->opt->crypt=
o_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id,
   =
      multi->rx_peer_id,

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1719?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
Gerrit-Change-Number: 1719
=
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--XXXCSfafm+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Support p2p NCP negotiation in p2mp mode<br><br>This sends the pee=
r info of the server to a p2p mode client if it is<br>detected=2E This is c=
urrently make little difference as peer-id/DATAv2 does<br>not work without =
asymmetric peer-id support of the p2p mode client but<br>prepares for mesh/=
multipeer support=2E<br><br>Change-Id: I8f3545f703126dbe96f809e69ad351749b1=
4b1e1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M=
 src/openvpn/multi=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_ncp=2E=
c<br>3 files changed, 53 insertions(+), 8 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/=
1719/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</=
span><br><span>index e72066f=2E=2Ef853669 100644</span><br><span>--- a/src/=
openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><sp=
an>@@ -1707,6 +1707,43 @@</span><br><span>     gc_free(&amp;gc);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Generates warning for p2p=
 mode peers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_set_protocol_war=
nings_p2p(struct context *c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct tls_session *session =3D &amp;mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we ca=
n support p2p clients but only if we and the other side</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * support asymmetric peer-id */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LO=
W, &quot;Note: peer reports running in P2P mode &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         &quot;(no --pul=
l/--client option)=2E This will &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         &quot;probably not work as expe=
cted=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Figure out which=
 side is lacking asymmetric peer-id support and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * print appropriate warnings */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;use_asymmet=
ric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&=
gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(D_TLS_DEBUG_LOW, &quot;Note: Supporting P2P mode peers requires &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   &quot;support of asymmetric peer-id which the &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          &quot;current DCO module does not support=2E Disable &quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
        &quot;DCO or upgrade to a version of OpenVPN and &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
  &quot;DCO that support asymmetric peer-id=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (extract_asymmetric_peer_id(multi-&gt;p=
eer_info) =3D=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(D_TLS_DEBUG_LOW, &quot;Note: Supporting P2P mode peers requ=
ires &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                         &quot;support of asymmetric peer-id=2E The peer do=
es not &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                           &quot;indicate it supports this=2E&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  * Calculates the options th=
at depend on the client capabilities</span><br><span>  * based on local opt=
ions and available peer info</span><br><span>@@ -1737,13 +1774,11 @@</span>=
<br><span>         return false;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Print a warning =
if we detect the client being in P2P mode and will</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * not accept our pushed ciphers */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Print a warning if =
we detect the client being in P2P mode=2E The</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * negotiations will be otherwise compatible =
*/</span><br><span>     if (proto &amp; IV_PROTO_NCP_P2P)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WA=
RN, &quot;Note: peer reports running in P2P mode (no --pull/--client &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &=
quot;option)=2E It will not negotiate ciphers with this server=2E &quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quo=
t;Expect this connection to fail=2E&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        multi_client_set_protocol_warnings_p2p(c);<=
/span><br><span>     }</span><br><span> </span><br><span>     if (proto &am=
p; IV_PROTO_REQUEST_PUSH)</span><br><span>diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec</span><br><span>index 5f3c09f=2E=2E852d475 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ss=
l=2Ec</span><br><span>@@ -1883,7 +1883,8 @@</span><br><span> </span><br><sp=
an>     /* In server mode we only add this when the client has announced it=
s</span><br><span>      * support for the feature */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (session-&gt;opt-&gt;mode !=3D MODE_=
SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER |=
| multi-&gt;use_asymmetric_peer_id</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        || !session-&gt;opt-&gt;server)</span><br><span>    =
 {</span><br><span>         return buf_printf(out, &quot;ID=3D%x\n&quot;, m=
ulti-&gt;rx_peer_id);</span><br><span>     }</span><br><span>@@ -1994,7 +19=
95,8 @@</span><br><span>         }</span><br><span>         else</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       /* We are not using pull or p2mp server, instead do P2P NCP */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* We are not=
 using pull and are are either in real p2p mode</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             * or doing p2p negotiation as p2mp=
 server */</span><br><span>             iv_proto |=3D IV_PROTO_NCP_P2P;</sp=
an><br><span>         }</span><br><span> </span><br><span>@@ -2331,6 +2333,=
14 @@</span><br><span>                 /* With DCO we don&#39;t need the tx=
_peer_id atm */</span><br><span>                 multi-&gt;tx_peer_id =3D m=
ulti-&gt;rx_peer_id;</span><br><span>             }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            unsigned int iv_proto =3D ext=
ract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (iv_proto &amp; IV_PROTO_NCP_P2P &amp;&amp; multi-&gt;session-&=
gt;opt-&gt;push_peer_info_detail &lt; 1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                /* If the peer is using NCP P2P we also use =
p2p to make connecting</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 * with p2p peers easier */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                multi-&gt;session-&gt;opt-&gt;pu=
sh_peer_info_detail =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span>         }</span><br><span>     }</spa=
n><br><span>     else</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec =
b/src/openvpn/ssl_ncp=2Ec</span><br><span>index e860f6d=2E=2E003b77e 100644=
</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_ncp=2Ec</span><br><span>@@ -515,7 +515,7 @@</span><br><span>     =
}</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;P2P mod=
e NCP negotiation result: &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                         &quot;TLS_export=3D%d, DATA_v2=3D%d, rx=
-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                         &quot;TLS_E=
KM=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%=
s&quot;,</span><br><span>         (bool)(session-&gt;opt-&gt;crypto_flags &=
amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span>         multi-&gt;us=
e_peer_id,</span><br><span>         multi-&gt;rx_peer_id,</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1719?usp=3Demail">change 1719</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1719?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14=
b1e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1719 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--XXXCSfafm+c=--


--===============6773981200620436133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6773981200620436133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6773981200620436133==--

