Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569A0CD6E4A
	for <openvpn-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:Cc:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qHmw33VkQKOWqNWQDjn5yLAxOM50Wy+s6pMOde/krQ8=; b=S8+CbQi7yPeG/L
	+0BEzb7YuaVxqCGdN1ejPV1YhqCzATdF0auhri3RlLXg5ugRFWWmhrlUpSoXUXTRoa/mmzQFxlncH
	SS5Fd5LDfbv4cjyzWn3ZgkLO9BeWsqKaGrWdYuzFJD33zyK1TWm8P/pK5hpn3M3Uhi4is3sWivKAZ
	TYI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wUlry-0005ua-Ez;
	Wed, 03 Jun 2026 13:42:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wUlrx-0005uN-Aj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 13:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M68Xzyta0wQtpI9BA2KFRbi5OtTPHNkeLtnWiWbebB8=; b=DLFj9p1w4J0+kEDTAWIjjo5Z67
 C3VvocxCEgJQP+tRsDSKBM0zHpn5JZwVCNUowlfXu1eY65Ux22KEEFamySHFHYL3l0wDnhTBYuheY
 iJp8hdzzdjH4rcvnha/V7NSS1q/rLCEOyWI0BvjCLwiQUhOoi7+xVhAx03cPuiRu8Qw0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M68Xzyta0wQtpI9BA2KFRbi5OtTPHNkeLtnWiWbebB8=; b=H
 dIm4oX4ce2y+oQoky40nbYJ768VwCnyWwOkeDId9K7Uo0ZVWK8oC/5s5GTE9dnqcifg2bQ1ZSGTuf
 TVRdQfrO6o3TUBxhizlCf1YeFGoD0L9GQhfPANnmEYq/n3ATvZvYX2hgr3TD6fXlvBcEtxWR2B+UJ
 sbDcg6eZXghi+B9I=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUlrv-0002af-Hh for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 13:42:53 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so838545e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 03 Jun 2026 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780494165; x=1781098965; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M68Xzyta0wQtpI9BA2KFRbi5OtTPHNkeLtnWiWbebB8=;
 b=AdHUdSTJPlpJ0451NtM2LiNH7CjftPL4ajEhO79QvGGlrfES+plZFvZqhaXqupN6hq
 7N/vHjVSJFS/qa3SoUy7Jb8Huc+5h6Owx8tLb3GR4y6dcefjsGTMkQgPidiKFmabIxTZ
 RG7I19+nqIsA8zSInKXhLCdg+7FFhjkVCyLLgfgVBb/1oY+2rgR5F7a8fcq6G25BeUoB
 sXijIetWMvPqxYBa1EjpBKT3kKt3gxmOOtPe2cSBkS4R2Zj/WR0L0P/jBk//9dy9xHdg
 yBdD/17/PwsApyjaCaIKtQchFXpXjHbVVfkpODYn5b/Tf4yZrgehiU0BVXlNjDie2p+g
 gaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780494165; x=1781098965;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M68Xzyta0wQtpI9BA2KFRbi5OtTPHNkeLtnWiWbebB8=;
 b=QNLPWpqprnAHRCNp+YBpXne01Xy8MLfCHd1r2iHgQ9ZyZagUCdPvcrY/n9UD5FszSi
 /f557nmD15NyebV+wiiazjNaIceOYQwaDjC9Yi93qEgXY8On0sW/iZW05/1gltazjxct
 10bmsXT6WkUEIx06yzYE4nXGPAqoNH0bpRVfS4M0Ru9siERIu4eoTs0KpMPZGN7IVJIv
 eLdsSZdHLXCWXW3LSk4ULOKUioN5IDouAlQL0rvb8N4mBJXRqUX3OR2wugr2ZMp4q/27
 LNTyULTxvfCGUTXNS4kB56R8tESJX1q6M9NySU7vgN+idHKkeU6kCQBYSyOzkHEJCDSD
 GcSQ==
X-Gm-Message-State: AOJu0YxmAd5Njm/ql+99K8xHe7mI24H8YZ0UGHteebY5jf41JvE5oEnc
 5N4tqVEceM2pvLn/uegSu0eOV8HvFETdyYTlpzeSrCxYrRA12trkmUoUagAHuNBgNh6NZycIyWp
 +QAUMTkPbsnG4xXrVBq6oBvG3uoOaccUvCpZT9AQtI6nnv36BY5ekIrptcOXi3yptXgVTNw8tWb
 nrsSp16A==
X-Gm-Gg: Acq92OGQRFxKDzeQWwOdGWRT5t9PZSOqG+fau8SrJ7UUp9AjyU1msqSdtHbYYEL5WYH
 xvI8S3EfOrvCeq1tm09gILzpQfMIuhi0ow0IQKMqvYTAKbAArxW48qi86eyQkxc5E2bz57U6Iv4
 Nrbh6X1MWOVDVRS/QQR1b/NzMEfNFmehA0ywvc//bst9El+CsDmoKOEYJZKWpn12gdb1CleJw7H
 jCBiEyRoc+v0m+BqLcTh3J5Erzc/YwksQoEAswsmx8PSmXl7Ajjio/tOrFaz3zXjSHLcddnLsym
 0xfEcbE7F7k422FgAfkzh8OLSaoMWIPVoCB92JBU80BxHTcd3RpCJ1WitXxCLhW0i9911e3ueLI
 +uySqY9N41J6k7Tjgycwse74CMUkOiUuHVxTwK/U6ajEPQy9KJappL0HMOEYjhqSzglqndEz0VF
 SC7PVOF3CBOoIuMB/3UsCT1E6LKfd6Ihlj9uKXSlJKI9b07EP4T3fIOT0gNZQr6RtDlpJftz4Ay
 NzEstJ+Ie3ZU5YZYGxUbe9Hd05zDPxr3WwCYEKfHNWM/beXYyz8YG0b0IJPRzZuNw6Ucm/5ntVT
 LLC70xqtLYX1UYeloIR7ZkN6
X-Received: by 2002:a05:600c:648:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-490b5e79899mr32159085e9.1.1780494165291; 
 Wed, 03 Jun 2026 06:42:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e13eefsm145851535e9.2.2026.06.03.06.42.44
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 06:42:44 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 3 Jun 2026 13:42:44 +0000
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1707
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1707?usp=email>
X-Gerrit-Commit: 282b65e1563fd55637872dda9c18cb9a5bbfe6ac
References: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDk0MTYwMDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5bcf930839064c0cb24c9eb9e03c56af238fc4bb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wUlrv-0002af-Hh
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure pushed
 tun-mtu is no lower than TUN_MTU_MIN
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============4011353818590196564=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4011353818590196564==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TXw03fvqGpY="; charset=UTF-8

--TXw03fvqGpY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1707?usp=3Demail )


Change subject: Ensure pushed tun-m=
tu is no lower than TUN_MTU_MIN
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Ensure pushed tun-mtu is no lower than TUN_MTU_MIN

The=
 normal path ensure that the minimum tun mtu is set to at least
TUN_MTU_MIN=
=2E However, the pushed options path does not have this
restriction=2E

Che=
ck that the tun-mtu is within the limits of min/max mtu
in options=2Ec=2E T=
his ensure that the check is also correctly done
on the pushed variant=2E

=
Also add an extra check to keep the allowed payload for icmp6 packets
to be=
 at least 64 bytes in the the block-ipv6 code path
(ipv6_send_icmp_unreacha=
ble) as extra layer of defence=2E

Pushing a low mtu like 1 and also block-=
ipv6 could trigger an
assertion in the ipv6_send_icmp_unreachable code path=
=2E

Reported-By: Haiyang Huang <huanghaiyang83@gmail=2Ecom>
Change-Id: Iff=
8b336126a5dff9871213664b1e8585fb70d21e
---
M src/openvpn/forward=2Ec
M src/=
openvpn/mtu=2Eh
M src/openvpn/options=2Ec
3 files changed, 20 insertions(+)=
, 11 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/07/1707/1

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec
index 27cfd36=2E=2Ed24f534 100644
--- a/src/openvpn/forward=2Ec=

+++ b/src/openvpn/forward=2Ec
@@ -1598,7 +1598,9 @@
      * frame should b=
e <=3D 1280 and have as much as possible of the original
      * packet
   =
   */
-    const int max_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2=2Efr=
ame=2Etun_mtu - icmpheader_len);
+    int max_payload_size =3D min_int(MAX_=
ICMPV6LEN, c->c2=2Eframe=2Etun_mtu - icmpheader_len);
+    /* Ensure that m=
inimum payload size is at least 64 bytes as extra safety layer */
+    max_=
payload_size =3D max_int(max_payload_size, 64);
     const int payload_len =
=3D min_int(max_payload_size, BLEN(&inputipbuf));
     const uint16_t icmp_=
len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload_len);
 
diff -=
-git a/src/openvpn/mtu=2Eh b/src/openvpn/mtu=2Eh
index ca8109c=2E=2E8f07e75=
 100644
--- a/src/openvpn/mtu=2Eh
+++ b/src/openvpn/mtu=2Eh
@@ -68,6 +68,11=
 @@
  */
 #define TUN_MTU_DEFAULT 1500
 
+/**
+ * Maximum MTU we accept for=
 MTU related options
+ */
+#define TUN_MTU_MAX 65536
+
 /*
  * Minimum maxi=
mum MTU
  */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index 0c2866c=2E=2E128d1e5 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -6409,26 +6409,28 @@
     else if (streq(p[0], "tun-=
mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU | =
OPT_P_CONNECTION);
-        options->ce=2Etun_mtu =3D positive_atoi(p[1], m=
sglevel);
-        options->ce=2Etun_mtu_defined =3D true;
-        if (p[2=
])
+        if (atoi_constrained(p[1], &options->ce=2Etun_mtu, "tun-mtu", T=
UN_MTU_MIN, TUN_MTU_MAX, msglevel))
         {
-            options->ce=2Eo=
cc_mtu =3D positive_atoi(p[2], msglevel);
-        }
-        else
-       =
 {
-            options->ce=2Eocc_mtu =3D 0;
+            options->ce=2Etun=
_mtu_defined =3D true;
+            if (p[2])
+            {
+             =
   atoi_constrained(p[2], &options->ce=2Eocc_mtu, "tun-mtu occ-mtu", TUN_MT=
U_MIN, TUN_MTU_MAX, msglevel);
+            }
+            else
+          =
  {
+                options->ce=2Eocc_mtu =3D 0;
+            }
         }=

     }
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
 =
        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        atoi_cons=
trained(p[1], &options->ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msg=
level);
+        atoi_constrained(p[1], &options->ce=2Etun_mtu_max, p[0], T=
UN_MTU_MAX_MIN, TUN_MTU_MAX, msglevel);
     }
     else if (streq(p[0], "t=
un-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MT=
U | OPT_P_CONNECTION);
-        if (atoi_constrained(p[1], &options->ce=2Et=
un_mtu_extra, p[0], 0, 65536, msglevel))
+        if (atoi_constrained(p[1]=
, &options->ce=2Etun_mtu_extra, p[0], 0, TUN_MTU_MAX, msglevel))
         {=

             options->ce=2Etun_mtu_extra_defined =3D true;
         }

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff8b336126a5dff9871213=
664b1e8585fb70d21e
Gerrit-Change-Number: 1707
Gerrit-PatchSet: 1
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--TXw03fvqGpY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Ensure pushed tun-mtu is no lower than TUN_MTU_MIN<br><br>The norm=
al path ensure that the minimum tun mtu is set to at least<br>TUN_MTU_MIN=
=2E However, the pushed options path does not have this<br>restriction=2E<b=
r><br>Check that the tun-mtu is within the limits of min/max mtu<br>in opti=
ons=2Ec=2E This ensure that the check is also correctly done<br>on the push=
ed variant=2E<br><br>Also add an extra check to keep the allowed payload fo=
r icmp6 packets<br>to be at least 64 bytes in the the block-ipv6 code path<=
br>(ipv6_send_icmp_unreachable) as extra layer of defence=2E<br><br>Pushing=
 a low mtu like 1 and also block-ipv6 could trigger an<br>assertion in the =
ipv6_send_icmp_unreachable code path=2E<br><br>Reported-By: Haiyang Huang &=
lt;huanghaiyang83@gmail=2Ecom&gt;<br>Change-Id: Iff8b336126a5dff9871213664b=
1e8585fb70d21e<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mtu=2Eh=
<br>M src/openvpn/options=2Ec<br>3 files changed, 20 insertions(+), 11 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/07/1707/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 27cfd36=2E=2Ed24f534 =
100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/=
src/openvpn/forward=2Ec</span><br><span>@@ -1598,7 +1598,9 @@</span><br><sp=
an>      * frame should be &lt;=3D 1280 and have as much as possible of the=
 original</span><br><span>      * packet</span><br><span>      */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const int max_payload_size =
=3D min_int(MAX_ICMPV6LEN, c-&gt;c2=2Eframe=2Etun_mtu - icmpheader_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_payload_si=
ze =3D min_int(MAX_ICMPV6LEN, c-&gt;c2=2Eframe=2Etun_mtu - icmpheader_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that =
minimum payload size is at least 64 bytes as extra safety layer */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    max_payload_size =3D max=
_int(max_payload_size, 64);</span><br><span>     const int payload_len =3D =
min_int(max_payload_size, BLEN(&amp;inputipbuf));</span><br><span>     cons=
t uint16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payloa=
d_len);</span><br><span> </span><br><span>diff --git a/src/openvpn/mtu=2Eh =
b/src/openvpn/mtu=2Eh</span><br><span>index ca8109c=2E=2E8f07e75 100644</sp=
an><br><span>--- a/src/openvpn/mtu=2Eh</span><br><span>+++ b/src/openvpn/mt=
u=2Eh</span><br><span>@@ -68,6 +68,11 @@</span><br><span>  */</span><br><sp=
an> #define TUN_MTU_DEFAULT 1500</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Maximum MTU we accept for MTU related options</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX 65536</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Minimum maximum MTU</span><br><span>  */</span><br><span>diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 0c2866c=
=2E=2E128d1e5 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6409,26 +6409,28 =
@@</span><br><span>     else if (streq(p[0], &quot;tun-mtu&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_PUSH_MTU | OPT_P_CONNECTION);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce=2Etun_mtu =3D positi=
ve_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;ce=2Etun_mtu_defined =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (p[2])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &amp;optio=
ns-&gt;ce=2Etun_mtu, &quot;tun-mtu&quot;, TUN_MTU_MIN, TUN_MTU_MAX, msgleve=
l))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            options-&gt;ce=2Eocc_mtu =3D positive_atoi(p[2], msgle=
vel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            options-&gt;ce=2Eocc_mtu =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;c=
e=2Etun_mtu_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (p[2])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                atoi_constrained(p[2], &amp;options-&gt;ce=2Eocc_mtu,=
 &quot;tun-mtu occ-mtu&quot;, TUN_MTU_MIN, TUN_MTU_MAX, msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                options-&gt;ce=2Eocc_mtu =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span>         }</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_M=
TU | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_max, p[0], T=
UN_MTU_MAX_MIN, 65536, msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_=
max, p[0], TUN_MTU_MAX_MIN, TUN_MTU_MAX, msglevel);</span><br><span>     }<=
/span><br><span>     else if (streq(p[0], &quot;tun-mtu-extra&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (atoi_constrained(p[1], &amp;options=
-&gt;ce=2Etun_mtu_extra, p[0], 0, 65536, msglevel))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &amp;o=
ptions-&gt;ce=2Etun_mtu_extra, p[0], 0, TUN_MTU_MAX, msglevel))</span><br><=
span>         {</span><br><span>             options-&gt;ce=2Etun_mtu_extra=
_defined =3D true;</span><br><span>         }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1707?usp=3Demail">change 1707</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1707?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1707 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--TXw03fvqGpY=--


--===============4011353818590196564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4011353818590196564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4011353818590196564==--

