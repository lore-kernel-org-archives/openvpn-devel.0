Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8429606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LRxp8XTt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VLiSt1Sf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lUkjTSai;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HqY/JrBW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7Xnp4AVXpIjEA556gb1KTtdG+uWTskRrrb9/F2A1fjg=; b=LRxp8XTtYEVFHCWOhq06AbmyCn
	0g90coMFRPT9gqs4tzCTEGPo28s6Kg3QEkRWyGz/Hj/7L3CK12Ws4RtIu6u1L3INlQtEUXS+dMdkw
	AWI9Ix/madYNKjpm9nciMCzpg756bY78LqF9q4VVCNJAixvtZhKdCrJekiZa5pLFSnHE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHLy-000000007Jy-23UQ;
	Tue, 03 Nov 2026 16:27:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHLx-000000007Jp-0eJ3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0skw7QWOpGloxOir4sAe0UEWwtV2RBSCbB3gXxpwit4=; b=VLiSt1SfXZ3MHKzEPMsKZnTR6F
 nBi40pa56pw1pH/Q5HBuIl19seQQ5U5lJ4ygBm0TjnmFaJ34llE75gUeI+/TUVlnISqBpgSMCj8L0
 SxeIcvdJCCTU5crQW0Ro8+/OBx8xrmFG+oXiL0HKhxOD9L+wwb5RZQbSIltc8Uq/yBiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0skw7QWOpGloxOir4sAe0UEWwtV2RBSCbB3gXxpwit4=; b=lUkjTSai8epIzgJExbvP+INlDR
 hFpnUBWDOt8WW3StSWC1aekveDIWSmxdmOEOuKuXGoiFA/lSjnPA562xiBrwPz3nyQzMwxYZTZ1Tl
 As4KS+lGFPXJ5GLUIdiSh91sFtvCNu1QMzdS6zfQ9dh7vhkJ1zKg9paq+Vxb7DpDthwk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHLt-00000000879-3NBH for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:17 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2606779f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793723227; x=1794328027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0skw7QWOpGloxOir4sAe0UEWwtV2RBSCbB3gXxpwit4=;
 b=HqY/JrBWXgMRtp8Tupp5oUoo4AWAbayAnfuaJjSK+i6T0yu5qVh8NkWioBX0yR5IOB
 zt+/8k9ZHzgE06DgjnFqvvJl1BMNfKSrUBPN8cOWuNH96UJ9lurwVWnvWmVd3pkttcji
 AhKCKqeaxzRar1MQGf/OS0kexV2eSL2rPIv59qWust85otyHyfzm/OSxwOGUYigCL6bf
 I7cwTEgM+Oq4OIu/QdAyxtqppUOYa51e/7SBNPRiFFmGtOf693hONEzy12w/wgYNaGcR
 fDhE2BsrhbCioyirulMsm2xWQd7D8Uw8jHj8JdcNAA0lkafALMuUkTRG90EPBVU33gVG
 lWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723227; x=1794328027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0skw7QWOpGloxOir4sAe0UEWwtV2RBSCbB3gXxpwit4=;
 b=RC0mFoqCXpTzF4HZquolcdi36KuarOlG3L4ZwsK03Y7bBZFuGayprwcLuaTEp0uk4R
 D/GhodabkOAVhZJy5WnKtdSHEgZefWFyKpB++Eqjbk8j3AcAzQqrsOH7myMbZFNYWz8q
 0P6eNvsU8DqEk/qe3l/lnbw7KKqCwl5rn2w1oOd88zI7dg2GYI9qQgWKX94Oi31Va741
 QMLoCtWh3H63fp39hFTXmDw3ybGUg6D+sc2tXfF/vEpTR6fY18lo4OEtnVI6hSA6v2JK
 VZkZuamGl1zE+pSkWYms0MZsk5637QgmD4hsS89P8lCh0+On6W4P3aBhZ+3KS6t9gFrT
 Kdbg==
X-Gm-Message-State: APuU4Z96TGhDdgbQayzxufuNIwqOtQQOAkzmTT0CFPjmFvQ/HlRq/cut
 91TchM7afEkCADyH2sSErkZ1TCtFw62Pw3TD2OJvwCa5XBzs1FAUeOiX3bSUjGDtsotTLldkBU0
 jGKXkoGgnT5E/feRecsmhPsV+gZMzfBKi1Do+tqVa1kKUOLyWbu3msi9atgG8llJkX8LA
X-Gm-Gg: AYBFou3eybkQdQoO2UQfY6YUCNetozZo4opBb0X8VdpQq0ECZW0sFMYShygA6K05Snr
 MZz3HRSsV+938067LTrqV5rhT7JmpNARh2+RIpfVXFNxKNOrf6YdVBY7HucoygnSJor27OlQ9l7
 sNO15WKR0j93429kHzLsJcf8Ne+VwujK3KOiRY1XLIPMm2BcmHCIyEBQRpnOzj2ZHXbz4dtuqKz
 JFptd8gG8/rOZIGbO0mV7QbkppJwVKIbhMYszzT2G7qs6tP4de2ccHCfzWaN8Z9sjm3LvEEE2/z
 XYxhp6k+GeDXZhOD8I1N0KhqCve1GdEP0kYxBu064e6mP5AFyzeKX09H7KkLBatHBUGLicoOZrK
 zqFNT2JLEYcUBdqVr6wTKL8hgcvuOKgG145iaosr92n9SMm0o1EEcMx45SLymo37qwsgpCj+3eq
 krfFrvI4SUfGMJXFSP11EMeGAxOJGDq4XWCfiR8NcANjLhaKkgykxZB3EcZ5OX8C6SmhhpkvQof
 dReIAqdlGDt60zvWqAgzPz9bJsXfJgy1bvKGEq46oGGViU8Ot6mH3roFr6217Vfwq4Gd68vKbWM
 HKJF13hwBV45xxq5m49eyjFfqRVJrzvna3TRsalVfwtk/mtVOU642BARutaw3p0tWhrv6QjPSxU
 jBiKtYtNHQMRJxMB9/FqpV/zFwePoP5S3RQsUoz7A8N6Rhoh8xfD+8kPkypPtdB40zR1BEbzY8N
 BRm+H/ySnEk7J5x0c=
X-Received: by 2002:a5d:5f86:0:b0:48f:bce7:38ab with SMTP id
 ffacd0b85a97d-48fbce73902mr2087621f8f.48.1793723226924; 
 Tue, 03 Nov 2026 08:27:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm28995644f8f.6.2026.11.03.08.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:27:06 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:27:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Steffan Karger <steffan@karger.me>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
X-Gerrit-Change-Number: 2089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2089?usp=email>
X-Gerrit-Commit: abc1f3260bc11373d671dd7ad3a9e97ec489a7f5
In-Reply-To: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
References: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIzMTQxMDAwLklkNjU4N2IzZDQ0ZDMzMjZjYWU4M2M0NjBjZDg1ZTg1NzBlZTg2NjZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a15cef6d0a5d52094db8df48747ed5732b91423-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHLt-00000000879-3NBH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: assert opt
 before first use in openvpn_decrypt_aead()
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7509764755229141045=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7509764755229141045==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H9ugH20w7qQ="; charset=UTF-8

--H9ugH20w7qQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2089?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Steffan Karger


Change subject: crypto: assert opt befo=
re first use in openvpn_decrypt_aead()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

crypto: assert opt before first use in openvpn_de=
crypt_aead()

opt was dereferenced before ASSERT(opt)=2E Move the assertion=
 up=2E

Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Steffan Karger <steffan@=
karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089
Me=
ssage-Id: <20261102141556=2E29908-1-gert@greenie=2Emuc=2Ede>
URL: https://l=
ore=2Ekernel=2Eorg/openvpn-devel/20261102141556=2E29908-1-gert@greenie=2Emu=
c=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/open=
vpn/crypto=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/2089/3

diff --gi=
t a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ff17b22=2E=2E2d91=
c60 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -44=
0,6 +440,7 @@
     struct gc_arena gc;
     gc_init(&gc);
 
+    ASSERT(opt=
);
     struct key_ctx *ctx =3D &opt->key_ctx_bi=2Edecrypt;
     const bool=
 use_epoch_data_format =3D opt->flags & CO_EPOCH_DATA_KEY_FORMAT;
     if (=
!use_epoch_data_format && cipher_decrypt_verify_fail_exceeded(ctx))
@@ -450=
,7 +451,6 @@
     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
 
 
-    =
ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx=
->cipher);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id65=
87b3d44d3326cae83c460cd85e8570ee8666a
Gerrit-Change-Number: 2089
Gerrit-Pat=
chSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffa=
n Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--H9ugH20w7qQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2089?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">c=
rypto: assert opt before first use in openvpn_decrypt_aead()<br><br>opt was=
 dereferenced before ASSERT(opt)=2E Move the assertion up=2E<br><br>Change-=
Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Steffan Karger &lt;steffan@=
karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
089<br>Message-Id: &lt;20261102141556=2E29908-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102141556=2E29908-1=
-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>1 file changed, 1 insert=
ion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/89/2089/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index ff17b22=2E=
=2E2d91c60 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><s=
pan>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -440,6 +440,7 @@</span>=
<br><span>     struct gc_arena gc;</span><br><span>     gc_init(&amp;gc);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(opt);</span><br><span>     struct key_ctx *ctx =3D &amp;opt-&gt;key=
_ctx_bi=2Edecrypt;</span><br><span>     const bool use_epoch_data_format =
=3D opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>     if (=
!use_epoch_data_format &amp;&amp; cipher_decrypt_verify_fail_exceeded(ctx))=
</span><br><span>@@ -450,7 +451,6 @@</span><br><span>     const int tag_siz=
e =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(opt);</span><br><sp=
an>     ASSERT(frame);</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</sp=
an><br><span>     ASSERT(ctx-&gt;cipher);</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=3Demail">ch=
ange 2089</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2089 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steff=
an@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--H9ugH20w7qQ=--


--===============7509764755229141045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7509764755229141045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7509764755229141045==--

