Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48BCDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46JGF8Ism2fi1x6SCCPPQfoJZCKCqogJbj1Abws9ClI=; b=LLf0GGyxNOW9ysTSgUfwOXAmrI
	6A/xasDMFC4EF+hjfS5Toddb2670TX6eYqpEO4mCXP0X2f3LLA7f+vJ6/l1AFRdxT6JCQ4nLDQL5e
	d0A4U5tdhHtXk5Nx3Mk6Ia9fITdwzMR/qh061RppF0a+iCtordbSxL678+UXaWvwXROo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckHT-0004Ir-UF;
	Thu, 25 Jun 2026 13:38:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckHS-0004Ig-EV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ik34WoyQjB8EsS9zkyG7nv+AgjcPEIK5fLTJYoNrSCc=; b=Y8LdZKIA4iCzUzmDMJSQwkpLl2
 i7vvObu2xyrdfwNTUNXSHvgyQm3UP51u8fnB6vL48rUBnl1mpibUj5WbF7L6Ix5ETxVeY0fPZDIND
 gp3VrWxbyfWXLytDX3OFCA8vGFquu28X4zEmM2X/ZkPjOpxXmkv+IbtEouz4ehXhTMYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ik34WoyQjB8EsS9zkyG7nv+AgjcPEIK5fLTJYoNrSCc=; b=T
 2SjFGPAvpkL07QnzAiD2Duj7ZgoxV8JTCCuv9viziOWvxI6UWoyVjFTqOeWMxKdh7fO3kTK7o7Qug
 Q4RhIn0WsKuJnYYw9/sf3YZPa7uyC/bo+hm+WtGtWcdYF+3ASZwjP/Gb37OyGUmUEVYMDdEHeusv3
 yrhGbMkLqRXR8TXc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckHQ-0001Lv-SZ for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:38:11 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49249707788so12239815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394678; x=1782999478; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ik34WoyQjB8EsS9zkyG7nv+AgjcPEIK5fLTJYoNrSCc=;
 b=ULZFTdtTaDRU89uOabJwF620enqMl9/9TCslNhjUDrkqyd+p6zCGXAR+BWVwu5YZ/d
 5413zYid7MI2Iswpcbx8mbtsBUstDLqBmursXJ0COLDKXOm8omZrKUJ9eyf2rbyKEn6Q
 norAXQQd5w54EiX+tneEBxM0e96bumaHxf4G7xaUlQN8DSOQvB/0TRnoMLozVVvRcnXv
 MTkvkapfwZuRC18re8DviODJdX2m3YV4oW+fJkrSqHOHwiq3UoQD5pqhix8Tkw03IWgq
 CXtDDLpQy6H9s4vUGT4gU9RDNdIo/gfJ9PYKZ5jIYuksskbARhrmuu0QDF7R2m68A1n1
 AXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394678; x=1782999478;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ik34WoyQjB8EsS9zkyG7nv+AgjcPEIK5fLTJYoNrSCc=;
 b=eWzWH+p7MWzP9bIcAD59DogAxzIdgGhkYk0uldln+KVKFI2RPaq18hfiabxMJk70IQ
 y1L+RpvrPwaIakXfUz8n9Z+XuEc55goBmiXSigog7HXQiOwgXVy8OlM5Vf9A8VxdtFrS
 rV66FtbDwjwRmuuHG3q70bdqRDBH9EyTqNtb0I1nImds0iMYcHpMZ9IW6BoN/ykj0r8+
 PHxpjcYRVZ3wk/q6x+5qkpknoQ4Sh/jDsVrex3jhuxPs5C9bWI3Bk3jRZUt8QVa+A5tf
 9Fd31rK/YNs1bIkL0OMKTfseb8wk7KBzOkExpzKEmw02Xc75f9fhutpU7qHG2utfoNOY
 lPjw==
X-Gm-Message-State: AOJu0YwOFSgnwyenNNJ/o3pHgYSO+2uCznnALqzA6+l0ZWp/Dfo7RdhR
 9oOihsv9cLTSN0XEMy5Nn19c0NxkNrcQwQQFMQwp9TeQcj7H+Al35KP0mqPto3ON0VXu3K49DP2
 m8gIGmWy0KpqUfMH0H6iStxXE6J4dL1GGXyEhyk/xwb9aXrDgMM7FWpkrE0r8ov3VTgwkbepdux
 6dtHgmIQ==
X-Gm-Gg: AfdE7cmVK3SMFKgIUipTrI/z0PGMONG8FRnETtBMnbTehb6KWObDqF9x2WNNH54X54/
 UsBLEI9BGqjQLaonKQRwmsJCx1lAVvRb/u8riK6QMm8sMFalCl2yd5dB3lNpNvU3iuOWxdXilQX
 l2MUkIfCa5cwszLsSAaoSQKBfLHP/sP2XBqNstkQV1MUIMussUGYLBemmZa0GlYXvSIWseVzGx9
 9Wjh0D73C3TNwziZG/hhnL2hfj12oMitQXnOxQT9hiPeJalS/yFWNhrnZ7CGv4SPk3bqCPE3OtO
 FrO+q34+PX0weKIRVAxHZO3lJE8i1nHSbSVlzeYR421BxVboaeMih4pkdHOyk4Xo1JFg81k+atO
 ga5oo1cROkt88YbymCIEl2OPyumOqE4ZU2G1XXhNEf9a7o/uLH2mwWXPCKRzRcBzzHZz8xDdEEA
 izs6c1e5j3w8RhS+/8bHIxt1RG8BmdhIIUVrT2QbZFRYQJAuRBxUlmfTnMy/bb5MlXsZLgxm31f
 YQJAMlFM1N13ZloPrCP6CtvcAO8mToaN94KLUSLTezv+AIOjxSQFfcsPgEvUeYV0fper/LIIPDC
 4W8=
X-Received: by 2002:a05:600c:3f07:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-492668961damr32664925e9.24.1782394677579; 
 Thu, 25 Jun 2026 06:37:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660a32ddsm54429515e9.1.2026.06.25.06.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: c43f71fa12b51fdc1c63b3a192e36ada7bbf143b
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62637c3323899de069aaaa26158328e28ea68069-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckHQ-0001Lv-SZ
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7174812033524634255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7174812033524634255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T2z9rLXHh/0="; charset=UTF-8

--T2z9rLXHh/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1719?usp=3Demail

to look at the new patch set (#3=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Support p2p NCP negotiation in p2mp mode
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Support p2p N=
CP negotiation in p2mp mode

This sends the peer info of the server to a p2=
p mode client if it is
detected=2E This currently makes little difference a=
s peer-id/DATAv2 does
not work without asymmetric peer-id support of the p2=
p mode client but
prepares for mesh/multipeer support=2E

Change-Id: I8f354=
5f703126dbe96f809e69ad351749b14b1e1
Signed-off-by: Arne Schwabe <arne@rfc25=
49=2Eorg>
---
M src/openvpn/multi=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/s=
sl_ncp=2Ec
3 files changed, 51 insertions(+), 7 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/1719/3

diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index b870d89=2E=2E3cc53b=
c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1723,6=
 +1723,43 @@
     gc_free(&gc);
 }
 
+
+/**
+ * Generates warning for p2p m=
ode peers=2E
+ */
+static void
+multi_client_set_protocol_warnings_p2p(stru=
ct context *c)
+{
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    =
const struct tls_session *session =3D &multi->session[TM_ACTIVE];
+
+    /*=
 we can support p2p clients but only if we and the other side
+     * suppo=
rt asymmetric peer-id */
+    msg(D_TLS_DEBUG_LOW, "Note: peer reports runn=
ing in P2P mode "
+                         "(no --pull/--client option)=2E=
 This will "
+                         "probably not work as expected=2E");=

+
+    /* Figure out which side is lacking asymmetric peer-id support and
=
+     * print appropriate warnings */
+    if (!multi->use_asymmetric_peer_=
id)
+    {
+        if (session->opt->dco_enabled)
+        {
+            =
msg(D_TLS_DEBUG_LOW, "Note: Supporting P2P mode peers requires "
+         =
                        "support of asymmetric peer-id which the "
+       =
                          "current DCO module does not support=2E Disable "=

+                                 "DCO or upgrade to a version of OpenVPN =
and "
+                                 "DCO that support asymmetric peer-i=
d=2E");
+        }
+        if (extract_asymmetric_peer_id(multi->peer_info=
) =3D=3D MAX_PEER_ID)
+        {
+            msg(D_TLS_DEBUG_LOW, "Note: S=
upporting P2P mode peers requires "
+                                 "supp=
ort of asymmetric peer-id=2E The peer does not "
+                         =
        "indicate it supports this=2E");
+        }
+    }
+}
+
 /**
  * Ca=
lculates the options that depend on the client capabilities
  * based on lo=
cal options and available peer info
@@ -1753,13 +1790,11 @@
         return=
 false;
     }
 
-    /* Print a warning if we detect the client being in P=
2P mode and will
-     * not accept our pushed ciphers */
+    /* Print a w=
arning if we detect the client being in P2P mode=2E The
+     * negotiation=
s will be otherwise compatible */
     if (proto & IV_PROTO_NCP_P2P)
     {=

-        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--=
client "
-                    "option)=2E It will not negotiate ciphers wit=
h this server=2E "
-                    "Expect this connection to fail=2E"=
);
+        multi_client_set_protocol_warnings_p2p(c);
     }
 
     if (pr=
oto & IV_PROTO_REQUEST_PUSH)
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec
index 0e8b4bd=2E=2E7499628 100644
--- a/src/openvpn/ssl=2Ec
+++ b/=
src/openvpn/ssl=2Ec
@@ -1883,7 +1883,8 @@
 
     /* In server mode we only =
add this when the client has announced its
      * support for the feature =
*/
-    if (session->opt->mode !=3D MODE_SERVER || multi->use_asymmetric_pe=
er_id)
+    if (session->opt->mode !=3D MODE_SERVER || multi->use_asymmetri=
c_peer_id
+        || !session->opt->server)
     {
         return buf_pri=
ntf(out, "ID=3D%x\n", multi->rx_peer_id);
     }
@@ -2331,6 +2332,14 @@
   =
              /* With DCO we don't need the tx_peer_id atm */
             =
    multi->tx_peer_id =3D multi->rx_peer_id;
             }
+            un=
signed int iv_proto =3D extract_iv_proto(multi->peer_info);
+
+            =
if (iv_proto & IV_PROTO_NCP_P2P && multi->session->opt->push_peer_info_deta=
il < 1)
+            {
+                /* If the peer is using NCP P2P we =
also enable p2p NCP allow
+                 * peers in p2p mode to connect =
*/
+                multi->session->opt->push_peer_info_detail =3D 1;
+    =
        }
         }
     }
     else
diff --git a/src/openvpn/ssl_ncp=2Ec =
b/src/openvpn/ssl_ncp=2Ec
index e860f6d=2E=2E003b77e 100644
--- a/src/openv=
pn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -515,7 +515,7 @@
     }
 
 =
    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-             =
            "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, e=
poch=3D%d, cipher=3D%s",
+                         "TLS_EKM=3D%d, DATA_v2=
=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
         (bo=
ol)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         =
multi->use_peer_id,
         multi->rx_peer_id,

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
Ge=
rrit-Change-Number: 1719
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--T2z9rLXHh/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Support p2p NCP negotiation in p2mp mode<br><br>This sends th=
e peer info of the server to a p2p mode client if it is<br>detected=2E This=
 currently makes little difference as peer-id/DATAv2 does<br>not work witho=
ut asymmetric peer-id support of the p2p mode client but<br>prepares for me=
sh/multipeer support=2E<br><br>Change-Id: I8f3545f703126dbe96f809e69ad35174=
9b14b1e1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<b=
r>M src/openvpn/multi=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_ncp=
=2Ec<br>3 files changed, 51 insertions(+), 7 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
19/1719/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index b870d89=2E=2E3cc53bc 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -1723,6 +1723,43 @@</span><br><span>     gc_free(&amp;gc);</span><=
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
options and available peer info</span><br><span>@@ -1753,13 +1790,11 @@</sp=
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
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 0e8b4bd=2E=2E7499628 10064=
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
so enable p2p NCP allow</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 * peers in p2p mode to connect */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;session-&gt;op=
t-&gt;push_peer_info_detail =3D 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span>         }</span><br><span>   =
  }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/ssl_=
ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index e860f6d=2E=2E003b77=
e 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -515,7 +515,7 @@</span><br><sp=
an>     }</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot=
;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         &quot;TLS_export=3D%d, DATA_v2=
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
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--T2z9rLXHh/0=--


--===============7174812033524634255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7174812033524634255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7174812033524634255==--

