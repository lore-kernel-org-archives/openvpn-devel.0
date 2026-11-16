Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861E606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EA3lQOAw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LnopdaP/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TNcj9Qny;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F06pKdj3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uYCzTgaO65lSkKqEaiDL5ROovULXGU3CQiZ8vVw+cj0=; b=EA3lQOAwLS0wTmPhl1I5EqJL9w
	YgwFBB+BjT+cdkCKlMbpVw89qApx8+4CgYcN3VRfIy3heDyf3Sf0iVELtqy5XMYh0SwThC8zgpB46
	ivbXaf3WzYZ+VX5CKf4mEHz4Rks2S0Gtk2uTldykc+p2X8KFCKVg3a/VkC1yyF8aGL8c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSspi-000000006KP-3ohj;
	Mon, 16 Nov 2026 09:17:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSsph-000000006KG-1GhM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rPNVqIb6RIflBiB601fbw09vW1AW9eMsO8XZaArf7bs=; b=LnopdaP/G5+ub4vgDuVfXC24qQ
 /UV2cHazZyGrLP7619SDYHVcszaNbsle900zD5TqKL84Iu1tFt+HiwynlP/wtd2QMzByrZ5gZ8eab
 vgPRw7w0IUsz0DyYvn3q3XmsCXY+f17yP2Hsc1dnPwk2svMbpDMx4HbLXOLiWGRQ6OCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rPNVqIb6RIflBiB601fbw09vW1AW9eMsO8XZaArf7bs=; b=TNcj9QnyKMvew3ndrzjvwI64cr
 CPqTW1smKEvVpoohUqRLncMIAaooszazVB5jAIKCbv/jF3B4oH6BNqBGhaxO+wcMzUnZgkWj2zyVQ
 2LWQOkcJVpZpvsz4wf5e5n+S9uTA0RUk0M+jKkGmaqUQC28SCduBwR8UIS0jKLWMvc/c=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSspf-0000000010q-1z5b for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:17:01 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso20375605e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794820613; x=1795425413; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rPNVqIb6RIflBiB601fbw09vW1AW9eMsO8XZaArf7bs=;
 b=F06pKdj3m47VzPQAMGtB0GAhKO7x9YYuOyT0ETIWK27dQZMwLivFdNHdRCwqFgDvyR
 YlybIRpQKF5Ze8Is4D0bGd6Bg2A0KDjU6Uu2vqb8HJBS5CJA0bPG76A1hqZpBgrhSyEF
 /Qut3KkPIsW7r7piS/F5Ox2Kkc10O0e6sX/qKms13v0Oyx+fPZB97ds73vdJFXEFrVs4
 SAltKDxb1sIDiNFWISXWccvQhRsL7yst/P9qrkDnNshUzMEjoj7nSalNrtgSox+0t4xe
 5N5TPj6f+v+NpoTMGuvYlnw9eWgF85zRyAcYNt7BfxSIJ2mSdSU0VkkHzWMhU8lO3I3a
 mHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820613; x=1795425413;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rPNVqIb6RIflBiB601fbw09vW1AW9eMsO8XZaArf7bs=;
 b=cSB1X7sxDshVOxkxWLz10VBwkTdT2aOFqjfWW945AfBis9uL+OxBVrpFkLLGCZa6+n
 nsZ9T6q//0H3NF8U0SfHQg3Ij8CcJwxXkvSfahAFrHr8PxZV9WExqqjkrRfakrCl+M8i
 X4cyh5nOkMUpvGuHzUHeQdb5fNILqX14zRnwGsL8EAFXq86nxe6uUgfQqtZReazhcBDL
 6irZ4a1KdvEoMCX8iubZ4oUfLhNmhQ3uaSzaNfMalrZU102nFtbzEpaamoo+z1ucQgt+
 eu1FmWsBNOVRL1z8p88xC0cuZi+UG7ledjJGAmgKh4Qx957X8cIDAH22Gwz4+CdITiHg
 JAbw==
X-Gm-Message-State: APuU4Z9VLGL2sIryGcXKDlubqdYLeceuYujiKzsxDUf6gawaFDCu3Qpd
 AFHf1RrSRi0hoHv2waMGV3+19Pj9dxrsKcf71GAlv4fj39758QhEkneU2JkuhdZVCo56Fd1gC03
 ySZMnMTGTxjIR21pzR/A9p95K2x4dynf9XYx3UL1bkfl4YXOZz8GuYxFbaj+BEhkJMwesi9ooMb
 05FnqpwA==
X-Gm-Gg: AYBFou17078MVy+ZCMvYY0GJUZc1IELikBziBvnqYBBWidc/E8zK+vVH/f6CSuqPPqh
 mNqoGTsAtJrLKNIkszFFCTyuPOYXA3TyOwF+ncIeifSLpDZ9J2MfjqBxbkD1Alomx4AbreHdHJY
 kbg94i0awV82pTo5QY3WSE9/fR0SYmBq3QW4xbkj/oFQDaBOC5aE+byShkW+8lRrTjGXVBk2znm
 Rxbu/E1RsizNy08tY6NhzFxYuSE6iAYEgffArnAAezbdz2omCreA/6InK/BWkw0kyIjWX9vi83g
 2DCFRzt/AGPCKEupAQIQmbhNunQX+JQ3hcJE+RFXShScKAjvmlBlqP4W9YdbJM2SB89FWGHECsf
 j9hRw5+MMKglrU5TyjEMwK6GEfTZiTTGHtrMQRpjX7vH72B8KNcjK/otO0QvOa4pB9iTcqXrbDY
 zXeHLAa7chT7xFQTY1vAw/kylTi9Z5y0fN0foClZ7QY+I6z9djFAy+s1/AJ/p9UHfsY45fSYqzp
 6HeV5vJuHFWcJNDhjZNmC9aSltLIAOyF/y6yiaa1jNdw4ozHTnUiFbIm18O8WMtHWvW+l+rHg8v
 eAEbxyc7tdk6YaGnGQam2r8q6XIvhxx98oIG57zIzdE/X8t5pO60aZBhXHK80L3o1q5CMi7os2Q
 LMidln/svW47R0JLlnViDdqY+pv+9I+uOITiG2PALwksiSKFmaKNTCP8ewE343gAr+gAVCF4qZL
 nqIJikyH/5QhQ26oE=
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb6f6a1e5amr72356065e9.2.1794820612476; 
 Mon, 16 Nov 2026 01:16:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm188623555e9.3.2026.11.16.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:16:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:16:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
X-Gerrit-Change-Number: 2133
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2133?usp=email>
X-Gerrit-Commit: ec96c65a5d2a9770533dde0d740a66bf282ac1eb
In-Reply-To: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
References: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAyMjczMDAwLkliYTFkYjMyY2QxMzBkMDkyZTM0YTMxMTU5ZjE0ZDNhYTM3ZGI5NmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f7ab188ff9756e047cdfa8d1eec7c03c12ee374-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSspf-0000000010q-1z5b
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: use
 multi_io_delete_event() and drop multi_tcp_delete_event()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0676914835370522171=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0676914835370522171==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dtBMdGl/ZnI="; charset=UTF-8

--dtBMdGl/ZnI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2133?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gianmarco De Gregori


Change subject: multi: use multi_=
io_delete_event() and drop multi_tcp_delete_event()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: use multi_io_delete_event()=
 and drop multi_tcp_delete_event()

cbb0440e ("multiproto: move generic eve=
nt handling code in dedicated
files") added multi_io_delete_event() as a co=
py of
multi_tcp_delete_event() but kept the old function and its only
calle=
r=2E Switch management_delete_event() to the new one and remove the
old cop=
y=2E

Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gianmarco De Gregori <gian=
marco@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2133
Message-Id: <20261104174306=2E15159-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg40713=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/multi=2Ec
3 files=
 changed, 1 insertion(+), 12 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/33/2133/2

diff --git a/src/openvpn/mtc=
p=2Ec b/src/openvpn/mtcp=2Ec
index fc5b657=2E=2Ed15fc22 100644
--- a/src/op=
envpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -104,15 +104,6 @@
 }
 
 void
-=
multi_tcp_delete_event(struct multi_io *multi_io, event_t event)
-{
-    if=
 (multi_io && multi_io->es)
-    {
-        event_del(multi_io->es, event);=

-    }
-}
-
-void
 multi_tcp_dereference_instance(struct multi_io *multi_i=
o, struct multi_instance *mi)
 {
     const struct link_socket *sock =3D mi=
->context=2Ec2=2Elink_sockets[0];
diff --git a/src/openvpn/mtcp=2Eh b/src/o=
penvpn/mtcp=2Eh
index 47c6308=2E=2Eb4ec1f9 100644
--- a/src/openvpn/mtcp=2E=
h
+++ b/src/openvpn/mtcp=2Eh
@@ -43,6 +43,4 @@
 
 struct multi_instance *mu=
lti_create_instance_tcp(struct multi_context *m, struct link_socket *sock);=

 
-void multi_tcp_delete_event(struct multi_io *multi_io, event_t event);
=
-
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/multi=2Ec b/src/open=
vpn/multi=2Ec
index ca650ec=2E=2Ead9f9f4 100644
--- a/src/openvpn/multi=2Ec=

+++ b/src/openvpn/multi=2Ec
@@ -3996,7 +3996,7 @@
     struct multi_contex=
t *m =3D (struct multi_context *)arg;
     if (m->multi_io)
     {
-       =
 multi_tcp_delete_event(m->multi_io, event);
+        multi_io_delete_event=
(m->multi_io, event);
     }
 }
 

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2133?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Gerrit-Change-=
Number: 2133
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dtBMdGl/ZnI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2133?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gianmarco De Gregori</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi: use multi_io_delete_event() and drop multi_tcp_delete_event()<b=
r><br>cbb0440e (&quot;multiproto: move generic event handling code in dedic=
ated<br>files&quot;) added multi_io_delete_event() as a copy of<br>multi_tc=
p_delete_event() but kept the old function and its only<br>caller=2E Switch=
 management_delete_event() to the new one and remove the<br>old copy=2E<br>=
<br>Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gianmarco De Gre=
gori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2133<br>Message-Id: &lt;20261104174306=2E15159-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg40713=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mtcp=2Ec<br>M src=
/openvpn/mtcp=2Eh<br>M src/openvpn/multi=2Ec<br>3 files changed, 1 insertio=
n(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/33/2133/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index fc5b657=2E=2Ed=
15fc22 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>++=
+ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -104,15 +104,6 @@</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_tcp_delete_event(struct multi_io *multi_io, e=
vent_t event)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi_io &amp;&amp; =
multi_io-&gt;es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_del(mul=
ti_io-&gt;es, event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void</span><br><span> multi_tcp_dereference_instance(stru=
ct multi_io *multi_io, struct multi_instance *mi)</span><br><span> {</span>=
<br><span>     const struct link_socket *sock =3D mi-&gt;context=2Ec2=2Elin=
k_sockets[0];</span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openv=
pn/mtcp=2Eh</span><br><span>index 47c6308=2E=2Eb4ec1f9 100644</span><br><sp=
an>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</s=
pan><br><span>@@ -43,6 +43,4 @@</span><br><span> </span><br><span> struct m=
ulti_instance *multi_create_instance_tcp(struct multi_context *m, struct li=
nk_socket *sock);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void multi_tcp_delete_event(struct multi_io *multi_io, event_=
t event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #endif /* ifndef MTCP_H */</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index ca650ec=2E=2Ead9f9f4=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -3996,7 +3996,7 @@</span><br><span>=
     struct multi_context *m =3D (struct multi_context *)arg;</span><br><sp=
an>     if (m-&gt;multi_io)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        multi_tcp_delete_event(m-&gt;multi_io,=
 event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mul=
ti_io_delete_event(m-&gt;multi_io, event);</span><br><span>     }</span><br=
><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2133?usp=3Demail">change 2133</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba1db32cd130d092e34a3=
1159f14d3aa37db96f2 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2133 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dtBMdGl/ZnI=--


--===============0676914835370522171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0676914835370522171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0676914835370522171==--

