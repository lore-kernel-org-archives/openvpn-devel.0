Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DC606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b2hLN7ej;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aa1OZz+Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=co3D+4yV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V5ZcxeFp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dSfkK1jT03OrbR9AJVSC7iUrRXWCPqZxerAkm7C5avM=; b=b2hLN7ejGXe7FAONTxUgOr6Rcj
	JfanGMjuVWyeDWI9pwjadEoiQBd5vnksZgwieFgWtMlKbsbiVBAYAumfutBCnqe7XLtj63x0PlnlB
	g956sB6SEUXQSsH6urfl+2D6X5PDx4wf9WnbzLWRTf6L66oD6gCdWcs3SXtFh4PDMTYA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVovy-000000006Q6-2ViV;
	Tue, 24 Nov 2026 11:43:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVovx-000000006Pt-2d0l
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7+tTYHvqYG3zwkw9AAKa1AcOtb6jfV8E4QYpdAmfPrc=; b=aa1OZz+ZjzEqz72UvIwHIVMxTB
 eb45WsID3TWTjiwVOLTPzBT4NZGDSm9NQmWeMKrmAnfwvJ+4X7Mswg69O+ef3RMwzApXoEUSC3/Sd
 RMvN3+sHch4Ae256VGjp3JOiKPxjKRCXuQ8bFPI2uhUAXfmbkpy1sttajRiedp8gvtDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7+tTYHvqYG3zwkw9AAKa1AcOtb6jfV8E4QYpdAmfPrc=; b=co3D+4yVB+7Uv67G+UFP4iJroc
 npDPDba4bgK0ldq5pR0G20GxMZpE7jtgRuHmkkkBGauu3WCXm0l7rPYlrdoXWJsk31ZxW06vI9fP0
 lyIHvGLaelfCS+S513lR4odYOPM/XqIMXNqb1HEJs7oJ4MZ8sR1IOoLyNPyDTFVUXkGY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVovv-000000000tQ-3k0x for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:37 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-491846221ffso3734921f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 03:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795520609; x=1796125409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7+tTYHvqYG3zwkw9AAKa1AcOtb6jfV8E4QYpdAmfPrc=;
 b=V5ZcxeFpj7tXb5m1zXQuyO/FpEBTtYR7h8x8t6H1ppgy4+SKQYZuV5nxGlvFO3fOhZ
 7Hzj21ZDL7+SOqbERHHK2Au1LNUl3/1uFJ5yzn/6gCx7dvIVzxLifrmBfGj5SmUy56c5
 J/mSiq3hrBQq8WT8vyYXskyYSrJ4fUol8DMo5FvQ8kAIanmIyG0Ciw9TtIEBBC/B/FFG
 RpXGZlC/1aica7OLprqlmcbsS3gq+rzQh3fPQcZD6CFbhOI4FSMS/sG/PDxUUXH9QsF+
 R0pPF80TdrXi/A8ToCfqLKwCY3lcW+wihCvlgCh3z3q2rHlaQLFlBwH59ljUXLgcIcC3
 nklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520609; x=1796125409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7+tTYHvqYG3zwkw9AAKa1AcOtb6jfV8E4QYpdAmfPrc=;
 b=xtSUYYfHWzAim9PoCmj4Bwq5hFZVPxM5JbBReeFSGjlpg8WxboeQ0Aa9PHZaHXT2v5
 wJYs5kd5LZOqAjrKv2zbsRjR9PBxjLEdLvqYQ3igsXwplT+yPMUGL+3qabgzQz9Ct7IC
 j7cnen6Kzsgb9OOiSXpoaennMPPrrXaLGK0BO7etQ/04+FDVUv7pTt1nMAE59ZGWRv2k
 6d0ZYKgWOxYbitRDw11ePhVIJhxaXKGPkT4z44+rFsCR6uaZAFvE69brvNrr3mSDED4l
 gUHX6Bgn2WOFSuvUOJbJpUhth9EnwkBbx9pV8Uww1NSVDFx5M+qZKYfw2jfwKNqXs4n/
 urbg==
X-Gm-Message-State: APuU4Z/yMnJy6x7twrAyO5lWUuwSmoLrXXu/xrGrK/obCvRTv1+9IDPF
 4SRwJZjW/RM5iVlm595TmhljjNhtlp8iRx3WDAWcu5u9InmHR7LaXfBVjwgkgdRmHZ/vdXYHe0A
 +eQHggWBl0y0xJm/pNT0EsdOnJ8L5ZmDm/ogsdEBqlUjfZcwlCOfqVkbIf7JXVudgNW1z
X-Gm-Gg: AZFdTZco5OcODkwkqEVmezUH922mrCSlLO8AS9gXZdp5Yh9Wpv12KBzxtfFl+l93OEe
 0H6Wkw+yBaLWTTN+W1bAHzWCY1XsUZS7HKB57SgvdHByn8KEJIx4weXqZ3kfsXFkxZDnaWd+GtL
 hFjIPitXxaE0My6QP4we5j+kPXAbJRTtQMyBj1v81pGBc9u+7+K4PwEzs0EEPhOGigv66fntygs
 F665HgT6Qdg93fMFnnc5WszmPJowhV51n49y3N6UBmgiCFNPl5pySY9u2lcbnvtPlXsVbgYdE4t
 XgC76P1YVX/XTqh6pSyjYRB66t7CK6FwTUFkaj4xp5oj5FWLWODyrg9FysoTqQ7L+1aHc0eQJzq
 /Ojet/u9yPRCgU8Yv/8USjsvlJTEVLg6k5XHXyamI9EUHdHGSNCu5KYbUPwcNoUOnEx1IXkS6eY
 nviBpIMks6mzwqNMOC1mKvobJ2yu4RDNhCwO8ypJs549y+gfo8n7CKrLxScIZBPZtQHK3GjKmbh
 bVGbuVvBaP8wzeicBh6wfkZiQqSe5ct7AAP4BYRngJBZSVxTyVhi5XmoZ+ECvC5I89gt2Fu/Ip7
 E8MvyqWBWfczKOiBisErJtG0M/fxEpB2QIT//z4c2PwoJJSxf+FZ57h/UjhjspRrM2CbZGDvUKt
 VWLSdcjl6cdKb9VArjOpv8T0vkZ5iMVmj7KlSfoIjK9Htn9qAXBBxtK4cIWDcQX/0i5vDOELjh1
 JUJbZIpMJWn0AmT5b8
X-Received: by 2002:a05:6000:4704:b0:491:6a7:b4ac with SMTP id
 ffacd0b85a97d-4abb5eabd6bmr27654436f8f.56.1795520609136; 
 Tue, 24 Nov 2026 03:43:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm3340966f8f.54.2026.11.24.03.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:43:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 11:43:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
X-Gerrit-Change-Number: 2240
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2240?usp=email>
X-Gerrit-Commit: f195766e8196bca6deccc1d157b4fb458aa4a399
In-Reply-To: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
References: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc5MjE4MDAwLkk3NGVjYTIzNjQ2NTE5MGFiNTVkYjI4OWI5OGU0MzI3NTdjNjFhNGEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f104272a6140627f947c03bad57e0004b92d5fb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVovv-000000000tQ-3k0x
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: drop duplicate
 remote address check in tls_pre_decrypt()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8237170341280020602=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8237170341280020602==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jn8zU557Q7g="; charset=UTF-8

--jn8zU557Q7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2240?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: ssl: drop duplicate remot=
e address check in tls_pre_decrypt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

ssl: drop duplicate remote address check in tls_p=
re_decrypt()

The existing-session branch already rejects a packet whose so=
urce
doesn't match ks->remote_addr, and key_state_soft_reset() keeps that
a=
ddress, so the later check never fails=2E new_link is always false in
that =
branch=2E

Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
Signed-off-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipak=
ov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240=

Message-Id: <20261123103742=2E10589-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41806=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/ssl=2Ec
1 file changed, 1 insertion(+), 8 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/2240/2

diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index eb6b86f=2E=2Eca5958f 100=
644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -4002,7 +4002,7 =
@@
         /*
          * Verify remote IP address
          */
-        i=
f (!new_link && !link_socket_actual_match(&ks->remote_addr, from))
+       =
 if (!link_socket_actual_match(&ks->remote_addr, from))
         {
        =
     msg(D_TLS_ERRORS, "TLS Error: Received control packet from unexpected =
IP addr: %s",
                 print_link_socket_actual(from, &gc));
@@ -41=
04,13 +4104,6 @@
         ks->remote_addr =3D *from;
         ++multi->n_se=
ssions;
     }
-    else if (!link_socket_actual_match(&ks->remote_addr, fr=
om))
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: Existing se=
ssion control channel packet from unknown IP address: %s",
-            pri=
nt_link_socket_actual(from, &gc));
-        goto error;
-    }
 
     /*
  =
    * Should we do a retransmit of all unacknowledged packets in

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74eca236465190ab55db289b=
98e432757c61a4a3
Gerrit-Change-Number: 2240
Gerrit-PatchSet: 2
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gma=
il=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--jn8zU557Q7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2240?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
: drop duplicate remote address check in tls_pre_decrypt()<br><br>The exist=
ing-session branch already rejects a packet whose source<br>doesn&#39;t mat=
ch ks-&gt;remote_addr, and key_state_soft_reset() keeps that<br>address, so=
 the later check never fails=2E new_link is always false in<br>that branch=
=2E<br><br>Change-Id: I74eca236465190ab55db289b98e432757c61a4a3<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipa=
kov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2240<br>Message-Id: &lt;20261123103742=2E10589-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41806=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file ch=
anged, 1 insertion(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/2240/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index =
eb6b86f=2E=2Eca5958f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span=
><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -4002,7 +4002,7 @@<=
/span><br><span>         /*</span><br><span>          * Verify remote IP ad=
dress</span><br><span>          */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!new_link &amp;&amp; !link_socket_actual_match(&am=
p;ks-&gt;remote_addr, from))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!link_socket_actual_match(&amp;ks-&gt;remote_addr, fro=
m))</span><br><span>         {</span><br><span>             msg(D_TLS_ERROR=
S, &quot;TLS Error: Received control packet from unexpected IP addr: %s&quo=
t;,</span><br><span>                 print_link_socket_actual(from, &amp;gc=
));</span><br><span>@@ -4104,13 +4104,6 @@</span><br><span>         ks-&gt;=
remote_addr =3D *from;</span><br><span>         ++multi-&gt;n_sessions;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else if (!link_socket_actual_match(&amp;ks-&gt;remote_addr, from))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            &quot;TLS Error: Existing s=
ession control channel packet from unknown IP address: %s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            print_link_socket_ac=
tual(from, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span> </span><br><span>     /*</span><br><span>      * Shoul=
d we do a retransmit of all unacknowledged packets in</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=
=3Demail">change 2240</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2240?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2240 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--jn8zU557Q7g=--


--===============8237170341280020602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8237170341280020602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8237170341280020602==--

