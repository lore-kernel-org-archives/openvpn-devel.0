Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DC606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TbetfH5e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EdtBdZF0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QFPy5m6z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IHLAC8Cq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kFHtd4qwOSlzTrgCIlA/HFpHdyApeVjj8aVU3HwZLFY=; b=TbetfH5eOxi5HnppYWJ5n8EG1p
	PU1KooNlvhKeXlkUlpCrd1pWOnWKPlAJo3YfFQlMX51xsWbivQ35+2ZDZ/nKByrQz1TeXfWYHiLnd
	675deegZY/yOL5GBJaW+5TkAVrZP9BFLcfI6fGm1g4CCugQPXdXsDZ0pKBkVDsYmpzF8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8EU-000000006K4-1PsL;
	Sat, 31 Oct 2026 12:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8EQ-000000006J4-2k3a
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ssfazM8rFjNJn1hso+7dAFd35/RCbak4I9MT/GalW3Q=; b=EdtBdZF0lzV+ZPlgkj8a1bSghz
 4ZbfV1YmD0Q2250G65Zsr2tqCq2RuGYTmIf0+9WKykhRrVxlyYc/EE4lymzCTS4gB4VmvjVvNXQ6J
 PZS9KpnO4TL2M3+yBIvGP62+VWqgGcrHrS0O3xCw0OAcjWgteMefX0qxWaYMDULrOpRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ssfazM8rFjNJn1hso+7dAFd35/RCbak4I9MT/GalW3Q=; b=QFPy5m6zbKp4KaYWFmi3ni7WAu
 gvp8Y6H5/PvxT/CEUemzJOCBDlcb81U8fyp9FkfQmAvfoykdq5l03/je3ULwENd8/DxEU2PzvFF6s
 O9xZjfyIV05LGNh/+ddnHNxGfw5HmwLpOsxNH9k9AQJRRFm2VHjXj3vgcT3wxvXa64Aw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8EH-000000003H7-2U4N for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:39 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1248133f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793449831; x=1794054631; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ssfazM8rFjNJn1hso+7dAFd35/RCbak4I9MT/GalW3Q=;
 b=IHLAC8CqPs22xUo2fxzv7uluIFV8a6nQza/lDaiIJumbvpDNq8k8irShQi8jOCG6Pi
 bjviv7ewnAo/r6gsPoG0qS4uk1F/l5zmFNKVskxGzoYxMLHZ/T2xz2A+ISAoFEsNMFAh
 gGuTvDtuRC0215+f45ebK0xxcnOYIzGxvkjUV8vT5BmY5ejEyeV+n7PNdzR5TVJMYC3o
 vTgH5FSRq+XuPOYkPcNxmrhsFn28u2EJJipbaS5s2z2yOXfig1n2jmOdxRspFNcIenxB
 5GVfc9IkU4S72XkxmcDiF+wrt1/+ZvRkfsJFzJ31CK5v132zxHu1sTS1cX6f3FgCxACS
 SGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793449831; x=1794054631;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ssfazM8rFjNJn1hso+7dAFd35/RCbak4I9MT/GalW3Q=;
 b=gumC714H9BuKrR7eE1NTSoD5/4oceztCraGalWYHFckhfVBbey0/Mmsr2fm8PD9qJb
 Rupu2BCAsUaeeyVfiwldlhUEYlTtVeByJY5shN9t8BdoLZwZAn0qTXT3Y7AqXAn0UctI
 OD03cN0BX9OOTR90/1YNCtY6e5FTSHNvN3FQZppgPwdmKWx6p9hNiAUTedT7j6HXu5kz
 R4TF02cXanUK20V1srZWq9WsQpvYtUYE8gEUoUfuE9DQ8PmVhpUyXs4q6wziMV9mOmMA
 yS6ZvSEZ6WdpdzsHwWYN9ISC2gzk7bF+7DU+PGz6h1JDuubJLxCtJWdDy6wSI0aWBAsf
 N0tg==
X-Gm-Message-State: AFq9FYJfhE/pmN6kX2GDf3znodgzCFSpgEoMv16KdwmMBV0mLEb2pz5q
 92DH1tKnt/nnFNzGb0G9MQz5OA1RXfwpwZqBkdwnf8Qmy7+H9q9mELsKl1pyULCa7E6KcQfwpKU
 1ZBGx7WMFUzwXk5fWXsaDtlJ0GBXnQbVhvQKOsF6jXEKubRU5NXgEX2goTf6Z/BhN0zQN
X-Gm-Gg: AYBFou2dzruEVulPxbGboXUSRoeqKEDI/Re4ZuG2C9rcDhN36sFlQx3Z46DJ73E9Atu
 gdFanrdhMIytibLwwVTKPCB5j5Day/SeJnBT9xp5UNqRo9Cjh6gqeP2kfs8HT2og8Po6R+o4pZV
 bVfPUL6E5MP2sJh2KRDLwWgHfAoHj8moXz9na0ly2UidXjkwuO2aIuzpb5IgF5c+CZ6y1XC5mX/
 3AnhNLYKzvcM4xI0ljdJkYXt8gi5G695dct8c9K2dPDsrSRNP5woasXV5CdAPFYjKuPyvkqE8+s
 D/GsefyKKo4fRfd2BMb0NXkR3YC4wir4zPz9CEDdxOn7uyQYjYmgqHd4nZD5fwplFz/7xl8rnTa
 lqYMIJN8PviIRU4htSuOKYy7ShPQw5hF/nTmk/R6GKt1VmUMdiasQQkG0O3IQCNPPq0TkmrUYTN
 SSZ25tWXdX8I3zVTiXYoMVpuHpgtdRkj3fKawQc7xspkGF/0kUnjkWYZoamfNpaobJYTx/luqFr
 Z3BDAehGOUzYcIZSb5D9x1C1vStnGp+4T3HVrRioPORLEJ5s9qYje24KMrghGZtxxwjvrzBAYwp
 9AfZuEBez1AJDKclioadQmn0F68Xl2DvedLbi1hb6PT3CDrxindKroAOArSYEROhEqsnW1sNAnV
 7Lpaa2cMAVNN/1ALe9KsGn5h+LND6feUO5b680dFNqHcAIH6/80Schy443/03zwVa0rASY+Sjlm
 jPpahk//cnEbKZp1w=
X-Received: by 2002:a05:6000:4811:b0:48e:5ae5:dcc0 with SMTP id
 ffacd0b85a97d-48e6e2ff6fdmr11115446f8f.43.1793449830756; 
 Sat, 31 Oct 2026 05:30:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm9302413f8f.6.2026.10.31.05.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:30:30 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:30:28 +0000
To: Heiko Hund <heiko@openvpn.net>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
X-Gerrit-Change-Number: 2030
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2030?usp=email>
X-Gerrit-Commit: 2115ebfacd6190fec4a872de060233b6497da337
In-Reply-To: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
References: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNzc5OTQ5MDAwLkkwMDgzYzZjNTQ2MGZmMmFmZjYzODU5OGFjMjZmOTlmZDMwZDAxZmQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91faf467b5b57ce95504d13988c8d8cbc94649a2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN8EH-000000003H7-2U4N
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3828686390028050707=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3828686390028050707==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FUZI71hMlx8="; charset=UTF-8

--FUZI71hMlx8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Heiko Hund


Change subject: interactive: validate message size fo=
r dns/nrpt/wins handlers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

interactive: validate message size for dns/nrpt/wins handlers=


HandleMessage() dispatches every fixed-size request only after checking
t=
hat msg=2Eheader=2Esize equals the size of the expected struct: address,
ro=
ute, flush_neighbors, wfp_block, enable_dhcp, set_mtu and
create_adapter al=
l do this=2E The dns, nrpt and wins config handlers do
not, so they inherit=
 only the generic gate (header=2Esize <=3D sizeof the
message union)=2E

Th=
e stack message object is not zeroed, so an unprivileged pipe client
can se=
nd an undersized dns/nrpt/wins message and have the service act on
uninitia=
lized stack memory: addr_len, the address array, family, the
interface name=
 and the domain lists are all read beyond the bytes that
were actually rece=
ived=2E The service runs as SYSTEM and takes these
messages from any local =
user, so it should apply the same size check the
other handlers already use=
=2E

Add the matching msg=2Eheader=2Esize =3D=3D sizeof(=2E=2E=2E) check to=
 the dns,
nrpt_dns and wins cases=2E

Github: closes OpenVPN/openvpn#1129

=
Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Change-Id: I0083c6c5460=
ff2aff638598ac26f99fd30d01fd1
Signed-off-by: Naveed Khan <dxbnaveed=2Ek@gma=
il=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2030
Message-Id: <20261023185614=2E5201-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40113=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed=
, 14 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/30/2030/2

diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec
index d36e8d5=2E=2Ee8203c6e 100=
644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=
=2Ec
@@ -3292,20 +3292,27 @@
 
         case msg_add_dns_cfg:
         case=
 msg_del_dns_cfg:
-            ack=2Eerror_number =3D HandleDNSConfigMessag=
e(&msg=2Edns, lists);
+            if (msg=2Eheader=2Esize =3D=3D sizeof(ms=
g=2Edns))
+            {
+                ack=2Eerror_number =3D HandleDNSC=
onfigMessage(&msg=2Edns, lists);
+            }
             break;
 
     =
    case msg_add_nrpt_cfg:
         case msg_del_nrpt_cfg:
-        {
-    =
        DWORD ovpn_pid =3D proc_info->dwProcessId;
-            ack=2Eerror=
_number =3D HandleDNSConfigNrptMessage(&msg=2Enrpt_dns, ovpn_pid, lists);
-=
        }
-        break;
+            if (msg=2Eheader=2Esize =3D=3D sizeo=
f(msg=2Enrpt_dns))
+            {
+                DWORD ovpn_pid =3D proc_=
info->dwProcessId;
+                ack=2Eerror_number =3D HandleDNSConfigN=
rptMessage(&msg=2Enrpt_dns, ovpn_pid, lists);
+            }
+            b=
reak;
 
         case msg_add_wins_cfg:
         case msg_del_wins_cfg:
-  =
          ack=2Eerror_number =3D HandleWINSConfigMessage(&msg=2Ewins, lists=
);
+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Ewins))
+       =
     {
+                ack=2Eerror_number =3D HandleWINSConfigMessage(&msg=
=2Ewins, lists);
+            }
             break;
 
         case msg_ena=
ble_dhcp:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
30?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0083=
c6c5460ff2aff638598ac26f99fd30d01fd1
Gerrit-Change-Number: 2030
Gerrit-Patc=
hSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@o=
penvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--FUZI71hMlx8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">interactive: =
validate message size for dns/nrpt/wins handlers<br><br>HandleMessage() dis=
patches every fixed-size request only after checking<br>that msg=2Eheader=
=2Esize equals the size of the expected struct: address,<br>route, flush_ne=
ighbors, wfp_block, enable_dhcp, set_mtu and<br>create_adapter all do this=
=2E The dns, nrpt and wins config handlers do<br>not, so they inherit only =
the generic gate (header=2Esize &lt;=3D sizeof the<br>message union)=2E<br>=
<br>The stack message object is not zeroed, so an unprivileged pipe client<=
br>can send an undersized dns/nrpt/wins message and have the service act on=
<br>uninitialized stack memory: addr_len, the address array, family, the<br=
>interface name and the domain lists are all read beyond the bytes that<br>=
were actually received=2E The service runs as SYSTEM and takes these<br>mes=
sages from any local user, so it should apply the same size check the<br>ot=
her handlers already use=2E<br><br>Add the matching msg=2Eheader=2Esize =3D=
=3D sizeof(=2E=2E=2E) check to the dns,<br>nrpt_dns and wins cases=2E<br><b=
r>Github: closes OpenVPN/openvpn#1129<br><br>Acked-by: Heiko Hund &lt;heiko=
@ist=2Eeigentlich=2Enet&gt;<br>Change-Id: I0083c6c5460ff2aff638598ac26f99fd=
30d01fd1<br>Signed-off-by: Naveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br=
>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2030<br>Message-Id: &lt;20261023185614=2E5=
201-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg40113=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/int=
eractive=2Ec<br>1 file changed, 14 insertions(+), 7 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/30/2030/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src=
/openvpnserv/interactive=2Ec</span><br><span>index d36e8d5=2E=2Ee8203c6e 10=
0644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>=
+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3292,20 +3292,27 =
@@</span><br><span> </span><br><span>         case msg_add_dns_cfg:</span><=
br><span>         case msg_del_dns_cfg:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            ack=2Eerror_number =3D HandleDNSConfigMessage=
(&amp;msg=2Edns, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Edns))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                ack=2Eerror_number=
 =3D HandleDNSConfigMessage(&amp;msg=2Edns, lists);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>           =
  break;</span><br><span> </span><br><span>         case msg_add_nrpt_cfg:<=
/span><br><span>         case msg_del_nrpt_cfg:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            DWORD ovpn_pid =3D proc_info-&gt;dwProcessId;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            ack=2Eerror_n=
umber =3D HandleDNSConfigNrptMessage(&amp;msg=2Enrpt_dns, ovpn_pid, lists);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (msg=2Eheader=2Esize =
=3D=3D sizeof(msg=2Enrpt_dns))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                DWORD ovpn_pid =3D proc_info-&gt;dwProcessId;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                ack=2Eerror_=
number =3D HandleDNSConfigNrptMessage(&amp;msg=2Enrpt_dns, ovpn_pid, lists)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span> </span><br><span>         case msg_add_wins_cfg:</span><br><spa=
n>         case msg_del_wins_cfg:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            ack=2Eerror_number =3D HandleWINSConfigMessage(&amp=
;msg=2Ewins, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Ewins))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                ack=2Eerror_number =
=3D HandleWINSConfigMessage(&amp;msg=2Ewins, lists);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>           =
  break;</span><br><span> </span><br><span>         case msg_enable_dhcp:</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2030?usp=3Demail">change 2030</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99=
fd30d01fd1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2030 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Hei=
ko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--FUZI71hMlx8=--


--===============3828686390028050707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3828686390028050707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3828686390028050707==--

