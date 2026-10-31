Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F8606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WqOdyrfI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NNdL+V1d;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f0yPSaO4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WfZdJrfI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P/iifxUs5bGvjwA084NvmxKwf/Uf+65A58fA4i10AUo=; b=WqOdyrfI52kn3kyegdE/lfnG25
	vvLtlGO+/Mgupy1pSVd2nKYumkJNSAA1qelEnYYOVrl/cMqAjK5Xhu4EhQpO+5bwjBlZUy2RHVZOw
	b2qkeDMmNumU/jXvr/a4oMQZuflXnu8bte/SlSAHE81XlygFu9/XUj/6PIfbTMR8rugQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8ER-000000004zt-3vRE;
	Sat, 31 Oct 2026 12:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8EJ-000000004zg-2do6
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fz/nkGTJRc/SYFsbEDAnjXRwBI1abpCcLO28j61jHC0=; b=NNdL+V1dQ1SBtzyahBpFHdyLop
 c0/GPNbEL4hRohFqYakFgemE9D0uvY+V5LJqmPoigMCb7xLy91jHV/GicI5Mm7EtlHpiyYbHnGLWo
 zgsSDkFH8K6Eq2+pE31k5UTkiZVzhXt+TMiVy9/NonJiRkqLB3l/WTJtC/T0lexuNQp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fz/nkGTJRc/SYFsbEDAnjXRwBI1abpCcLO28j61jHC0=; b=f0yPSaO42V8yMLQyTaR8jAl2gG
 Yg6/STrTDSqGlm2hjz8DfYDieErHGMNVc+xInnoQ3BoMVlvAzpEg8P15p5ecv+GU7VNhSUrsdccLR
 lj2p7kD2s7prScGRR4tcDqmbHKSH9ve5qyhT7qBwVAsKOKGwBCgjBn9j2/q72vHuK9dc=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8EI-000000008RD-2cbt for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:39 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so868689f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793449832; x=1794054632; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fz/nkGTJRc/SYFsbEDAnjXRwBI1abpCcLO28j61jHC0=;
 b=WfZdJrfIZJCH6waGvuDcnp324byERTOXOb1p8kuPf/vlqU8F24LOwPnhgaMhi4LdJ6
 5a1/ZYQ34PBYRNyqhi0XfBt8/glvkAbP7dVPCvHAKwaNl6KcVReNe25Lp8odF4ktZEt0
 miyS0DmC/55Vc2tpF+CTtT3J1PD+ss9z4sYIf4F+CxQJVXC0x5xpJhlvwnE/gazrIeUW
 uZbM3L7sSzlg17gxXo4mcrxkmAKvvq5I41GV+rXJJeBKR4tMWL7bxXUFM1xTvepqDjxh
 ok388wIoEbk9uIDgU9HKeVU5KZIluYJ3IEFrkpgnnoWekrfEsc5zYiR57kcrdX7Hgwqu
 IPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793449832; x=1794054632;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fz/nkGTJRc/SYFsbEDAnjXRwBI1abpCcLO28j61jHC0=;
 b=2wO+VoDuDkDvwfz4jjb4LbkJywtHh5uKFvVMu8yLkqFizu5HeJ0VUyFzagZuUg2TVz
 2hoYHioacrtkjcwoHK4glzDva6upGnsF9R0QtSv9RoOpaL1dpjv4qJdnMeOIFKSkZzhc
 xZyL3g8QmjKSgfVUnJ7fQhPSRNxr2DlxItCWd2fU6PnCH2SD5KWyO8lcjEV+L691TYQ9
 O1Mr5lv484Ej/dXcDeVCuN/tRi8+x8KF5KoUbMBEdbmJ3g6wss42bEPwGXAQbprNL6+I
 aO8IxZXxs9U1EF3FYHy6LJ3MPPHGXE7Htif6STHV1CFcT0Zu1KN9iK/NDojS8yFgf99W
 dPoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiCzo/J/USMg8e9dFET988K2k/2cF9JtnIkMWz/TGjYQQlz4aBzWUyY7iN4HMpL9lJj5JeiV5lRiq5r0Wv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJHf575wmCkId5NhubRp6VmlVRwCgNYYiT7DUaai90LwkhVPUCQ
 IVwU9wlwmy1Vb8hlyMtjBOu0hYyZk26ubA9UNljUPZ3V7kcxsROraH74bx5DS1NA5cn9md5l3g0
 gO9azz1oZ2I6b2nIkHz1sAE4/EiSdvexQBlhshG6P5Y9j6RUoimvuak/oyX/tspJx4TYH
X-Gm-Gg: AYBFou12lL3u6R82IYuN8h4BZX0fbrNfhv+FC7UABdhaGupdoY2PwbdtDXpSXLBmVvS
 BzNAQiJKzG5GWYhuj8zMHcwYTitn0Wo6DDpgt+2lelEaJnDdbJ8Q5GN5uPiSNmPKFZIy4TMfFMA
 ltBr6quFc1VyYtQMJiea2tSeZpYn4IOyh7zQTda2Ne8Av/tiUAZBD2/d6cWZjvKjgpNavBEDK7V
 +wssDSRjGkMuDwAzZ317x4xMRE3Xmw66PazqKvB7b/uHzR6gUBYps1s+DwPbEo1bLuCl5oONfbK
 s95O+j40XsHT4Na/CkDfW0+PavtSaRXL1lOlw26Qv+O5jZB1T2KSWsWLm6+IGG7CRR9sUZKSVb1
 6AOYVyGzI59HTZ9aaWB352QFuZXLeXwwbwcNJgsqApg8OTW+8VJkJjP7vWLrQIK/xzxSOwzGW7Y
 15PFohDUgJ17XxIwSgnM9OPlKbrb2+vGxJDiJCGugFH4X7jsYwkJhu+o0hAiwIU/FBcGBAXe0XX
 UFbDbWNX9rlMYz6fauOZJLKpdGudb/BzX1irYL02LpH/tPGvh6kPJ4PdLKDrd13IGgmg4aRg1W2
 Ygk1lLX7BX2FdS60iNLrL5wC3BDzKJ2LWU6EEKewqQ5YHk5q07AumfgQ/Q7q2KmQYuuaXwhvrP0
 iCifCVoJuZM3OLlpI1Ii5NEfCo1k9hg/plU97w3mILtE1+Y10U3z1V9sHNC2o9D7CgjI0w+30P9
 2Ql9OPYWVTb3K7vFGoo48mXLA6BuLP6EfpCnmG
X-Received: by 2002:a5d:5886:0:b0:48d:fce6:884e with SMTP id
 ffacd0b85a97d-48e6e2cb717mr11771023f8f.12.1793449831821; 
 Sat, 31 Oct 2026 05:30:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm8514986f8f.8.2026.10.31.05.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:30:31 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:30:30 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
X-Gerrit-Change-Number: 2030
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2030?usp=email>
X-Gerrit-Commit: 2115ebfacd6190fec4a872de060233b6497da337
In-Reply-To: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
References: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNzc5OTQ5MDAwLkkwMDgzYzZjNTQ2MGZmMmFmZjYzODU5OGFjMjZmOTlmZDMwZDAxZmQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91faf467b5b57ce95504d13988c8d8cbc94649a2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN8EI-000000008RD-2cbt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interactive:
 validate message size for dns/nrpt/wins handlers
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5833195304979057906=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5833195304979057906==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CN/ZkyPRiOc="; charset=UTF-8

--CN/ZkyPRiOc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2030?usp=3Demail )

Change subject: interactive: validate messa=
ge size for dns/nrpt/wins handlers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

interactive: validate message size for dns/nrpt/wins=
 handlers

HandleMessage() dispatches every fixed-size request only after c=
hecking
that msg=2Eheader=2Esize equals the size of the expected struct: ad=
dress,
route, flush_neighbors, wfp_block, enable_dhcp, set_mtu and
create_a=
dapter all do this=2E The dns, nrpt and wins config handlers do
not, so the=
y inherit only the generic gate (header=2Esize <=3D sizeof the
message unio=
n)=2E

The stack message object is not zeroed, so an unprivileged pipe clie=
nt
can send an undersized dns/nrpt/wins message and have the service act on=

uninitialized stack memory: addr_len, the address array, family, the
inter=
face name and the domain lists are all read beyond the bytes that
were actu=
ally received=2E The service runs as SYSTEM and takes these
messages from a=
ny local user, so it should apply the same size check the
other handlers al=
ready use=2E

Add the matching msg=2Eheader=2Esize =3D=3D sizeof(=2E=2E=2E)=
 check to the dns,
nrpt_dns and wins cases=2E

Github: closes OpenVPN/openv=
pn#1129

Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Change-Id: I00=
83c6c5460ff2aff638598ac26f99fd30d01fd1
Signed-off-by: Naveed Khan <dxbnavee=
d=2Ek@gmail=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030
Message-Id: <20261023185614=
=2E5201-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg40113=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 fi=
le changed, 14 insertions(+), 7 deletions(-)




diff --git a/src/openvpnse=
rv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d36e8d5=2E=2Ee82=
03c6e 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/in=
teractive=2Ec
@@ -3292,20 +3292,27 @@
 
         case msg_add_dns_cfg:
    =
     case msg_del_dns_cfg:
-            ack=2Eerror_number =3D HandleDNSCon=
figMessage(&msg=2Edns, lists);
+            if (msg=2Eheader=2Esize =3D=3D =
sizeof(msg=2Edns))
+            {
+                ack=2Eerror_number =3D H=
andleDNSConfigMessage(&msg=2Edns, lists);
+            }
             break=
;
 
         case msg_add_nrpt_cfg:
         case msg_del_nrpt_cfg:
-      =
  {
-            DWORD ovpn_pid =3D proc_info->dwProcessId;
-            ac=
k=2Eerror_number =3D HandleDNSConfigNrptMessage(&msg=2Enrpt_dns, ovpn_pid, =
lists);
-        }
-        break;
+            if (msg=2Eheader=2Esize =3D=
=3D sizeof(msg=2Enrpt_dns))
+            {
+                DWORD ovpn_pid =
=3D proc_info->dwProcessId;
+                ack=2Eerror_number =3D HandleD=
NSConfigNrptMessage(&msg=2Enrpt_dns, ovpn_pid, lists);
+            }
+    =
        break;
 
         case msg_add_wins_cfg:
         case msg_del_wins=
_cfg:
-            ack=2Eerror_number =3D HandleWINSConfigMessage(&msg=2Ewi=
ns, lists);
+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Ewins))=

+            {
+                ack=2Eerror_number =3D HandleWINSConfigMes=
sage(&msg=2Ewins, lists);
+            }
             break;
 
         cas=
e msg_enable_dhcp:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2030?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
0083c6c5460ff2aff638598ac26f99fd30d01fd1
Gerrit-Change-Number: 2030
Gerrit-=
PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <hei=
ko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--CN/ZkyPRiOc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2030?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">interactive: validate message size=
 for dns/nrpt/wins handlers<br><br>HandleMessage() dispatches every fixed-s=
ize request only after checking<br>that msg=2Eheader=2Esize equals the size=
 of the expected struct: address,<br>route, flush_neighbors, wfp_block, ena=
ble_dhcp, set_mtu and<br>create_adapter all do this=2E The dns, nrpt and wi=
ns config handlers do<br>not, so they inherit only the generic gate (header=
=2Esize &lt;=3D sizeof the<br>message union)=2E<br><br>The stack message ob=
ject is not zeroed, so an unprivileged pipe client<br>can send an undersize=
d dns/nrpt/wins message and have the service act on<br>uninitialized stack =
memory: addr_len, the address array, family, the<br>interface name and the =
domain lists are all read beyond the bytes that<br>were actually received=
=2E The service runs as SYSTEM and takes these<br>messages from any local u=
ser, so it should apply the same size check the<br>other handlers already u=
se=2E<br><br>Add the matching msg=2Eheader=2Esize =3D=3D sizeof(=2E=2E=2E) =
check to the dns,<br>nrpt_dns and wins cases=2E<br><br>Github: closes OpenV=
PN/openvpn#1129<br><br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt;<br>Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1<br>Signed-off=
-by: Naveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Acked-by: Heiko Hund =
&lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2030<br>Message-Id: &lt;20261023185614=2E5201-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg40113=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file=
 changed, 14 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><=
span>index d36e8d5=2E=2Ee8203c6e 100644</span><br><span>--- a/src/openvpnse=
rv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</s=
pan><br><span>@@ -3292,20 +3292,27 @@</span><br><span> </span><br><span>   =
      case msg_add_dns_cfg:</span><br><span>         case msg_del_dns_cfg:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ack=2Eerro=
r_number =3D HandleDNSConfigMessage(&amp;msg=2Edns, lists);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (msg=2Eheader=2Esize=
 =3D=3D sizeof(msg=2Edns))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                ack=2Eerror_number =3D HandleDNSConfigMessage(&amp;msg=2Ed=
ns, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span>             break;</span><br><span> </span><br><span=
>         case msg_add_nrpt_cfg:</span><br><span>         case msg_del_nrpt=
_cfg:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            DWORD ovpn_pid =
=3D proc_info-&gt;dwProcessId;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            ack=2Eerror_number =3D HandleDNSConfigNrptMessage(&amp=
;msg=2Enrpt_dns, ovpn_pid, lists);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Enrpt_dns))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                DWORD ovpn_pid =3D pro=
c_info-&gt;dwProcessId;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                ack=2Eerror_number =3D HandleDNSConfigNrptMessage(&amp;=
msg=2Enrpt_dns, ovpn_pid, lists);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            break;</span><br><span> </span><br><span>         case =
msg_add_wins_cfg:</span><br><span>         case msg_del_wins_cfg:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ack=2Eerror_number =
=3D HandleWINSConfigMessage(&amp;msg=2Ewins, lists);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (msg=2Eheader=2Esize =3D=
=3D sizeof(msg=2Ewins))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              ack=2Eerror_number =3D HandleWINSConfigMessage(&amp;msg=2Ewin=
s, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span>             break;</span><br><span> </span><br><span>=
         case msg_enable_dhcp:</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail">change 2030</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0083=
c6c5460ff2aff638598ac26f99fd30d01fd1 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2030 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko=
@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--CN/ZkyPRiOc=--


--===============5833195304979057906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5833195304979057906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5833195304979057906==--

