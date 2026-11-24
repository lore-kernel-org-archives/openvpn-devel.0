Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C83606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A49uInZi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hw5x9OMk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SMt7UE7z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hL4CN0ft
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I0Xk2V+bP2zSxAkIYf0BhNO6X5uaOoqnnawUzeaF7ng=; b=A49uInZiMnjJ3gCRWIQCwPpYLN
	XXgboSprmgn4B476Ndv2yUMk68iGXdlBufbnxOV6Y8LFxpSqUGgBoVcEhQzFsOuMNtWnji8rYX2vz
	qU+GKICx4K/WBYvbZPGr/Bu/kzE6WQo6KCeYxMKpH2C8JPEFK894A1jBYj2vfMuadBIc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVoq6-0000000013Y-2UK9;
	Tue, 24 Nov 2026 11:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVoq6-0000000013S-0FC1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mp2rxre8ENEnDWpP/cZjijlBSr3YM8Qf4DC2OT0VQ64=; b=Hw5x9OMkqpRaHcVd7Weltk3Tgo
 8+uipWclJq6fNhj0xFB5QHILC6F5I6gatFPK6JvSzv7cZDDthKr50NpAKqNkTQat/ftT/qpy8n9+E
 Pgys8xsWFSjgxuZqbgGAgBFlncsKs3IYFxCKW1DC6skLf5ad0S3nc6Y1WeYRMT34RzAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mp2rxre8ENEnDWpP/cZjijlBSr3YM8Qf4DC2OT0VQ64=; b=SMt7UE7zgTCvTg2W68n5+blf7L
 p77iil2fqGTxVuYOR6ew/7cXwEoVhvWe+ko1+kyasXm51j+7JZqwi3hqWnGTbfY0omKe5/GcTL3Gt
 fSTAanQz75POeNGMenWs/HzVLzt7iH6Nvuy6EPcijI24Akpe+qZSrdEDyijQREPKwh+8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVoq4-000000008Jf-19vM for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:33 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso3716614f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795520246; x=1796125046; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mp2rxre8ENEnDWpP/cZjijlBSr3YM8Qf4DC2OT0VQ64=;
 b=hL4CN0ft+wJko/2kk/bSHao8kcW8UrvXrnpllO/GYbDrXrm0FERfUmbNviW0gP4FpX
 mkub+jCL1cqjSJiBmA2thIIhbMu4BabfONpDH5VNmVLujSCddTnRX4d7aHMRUUwbv5kc
 TfPL2c17K4nepyn4HICi7XD2BLdrF603ffZeEUNNb3hHITnCbQTwrQ7mDrOSH5xHmNvE
 IEvNxgUpilUs3q4uUkAUeikyWzkFEB2YMtCEZXoGDGCv+07vFV7GiGKIz6ixDUf3xeob
 h22hmGb44ye/TDTFJZs+1gmMwbfVwh4KhkxQajUSayqOLUsP76vS5uH2wbRNi6eW2vE0
 kegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520246; x=1796125046;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mp2rxre8ENEnDWpP/cZjijlBSr3YM8Qf4DC2OT0VQ64=;
 b=YfyN/omsjRE2axmBOuy7E7ig3WhkYEaUELY/8+0L2gz2DQ3vtds/X1ijMaygxHgEhR
 ayabhopKWautTSR+na9VorFSZgx832mCYVpUbqM1o8U1A0VC72PJ8f0prqsf0viF9yJD
 JuaLVWC6Ok+WTLk59ybKPATXcwilALzJG3nLVU1AVfN15rKwaEiWaTS3DlB+R01ZJO3f
 RGoMjvRqfIwz/75PwqQMQczIYOqyktv3w0i3hiiKU3AC5EbLx/rr0OxU6WkuXE7IAd7E
 rq4ZZzCuWLrtR36Sa6juEV7gg0KVCJSFWR5dbYcuI18Zfm0udXEvE8k+Y842CfsBEFVD
 KzGA==
X-Gm-Message-State: APuU4Z/9lgr6UhoTqggUdlIhc3FjHlvhT/PUCXRqDe5K3K4T9ZElHYdE
 0UftLyBTn7tfM+QWFd94NLAghmMeQxo98PNDK1//nmpf1gMsxN+uIslf92pOgkfXFDJJardcVcI
 T4G5hENlay0jB4GnabYFJZmtpoMwfGUz9CatH1F7ajFobkP8Z2/FaPdpMyYIGrKKTJ8SQ
X-Gm-Gg: AZFdTZfig8djbTnd1dwE4jJL3VoAyci6jD1GQ3n/0R9HPNLqc+DXrzQY3lWSZwjrcIi
 jJ0pwSX20ZMYALST2bayRdaOi5Eo4wfp+TFS2JnLUR7JEfmPyxo8QqRz0Xnx9smwY5Oys56KpAa
 8fM0FM+IFbA22zfuTO0RXQkREuVIvadb8fuLEL3FlgdHcZH/NY238OmEtrasEWB1Sywfu0AoJ5I
 4yA6k9gkzgI98lYV7TmA6QbukJlJIXKGOh5NlNkhTOCDJG8PFYK8/sbiQwBzcYNim2yGS0wZe3y
 FUB4qc/p1CcbSNdEz1R9cYPJ2C/EWS8hWxmz+Cnzpz1gAY0w04Xoeli0aZ57dPoYfXZmlf+gk0d
 D14yUSyx3uUpwXj5nsib8HqiMPJj2ziiEMFWHXBTpjlddjcTjkhiezqWCHkMaiCHLT479YOeAKz
 5jLwmSGPe/JtXJj0+aa0aXZT9clCLQHtag1BdUx1bo3Mo1GyY9ImXnnEUy14vFOuFT2F+PzWtX7
 F65feS9amJ1i/oMT+jRVGujfXUrQohCglFUsVD/zLAxgTJHkNt6wQE9xeeb30oKnB84WJNHlNUV
 qDsv2IHEytrENGETN2ZTEMu7Cx6dA5pq5elIcYl4WD0bPv3dA2PtzsDlRqCZ9JKyGAUymsev9ah
 RWLcNEgXPDtwx7YMgmw1dfVhi1d4n5YHZUD3nzSo+H2lc8DwsD+XF8vLTlFLWzF8dOofkz9mdrh
 vKB+6mSd2Acj1tWOi0fx3RddHBIRlN6GdVzQGt
X-Received: by 2002:a05:6000:184b:b0:48e:5cd4:aa60 with SMTP id
 ffacd0b85a97d-4abb42e9099mr27774007f8f.42.1795520245456; 
 Tue, 24 Nov 2026 03:37:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm27775809f8f.5.2026.11.24.03.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:37:24 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 11:37:24 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
X-Gerrit-Change-Number: 2327
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2327?usp=email>
X-Gerrit-Commit: d170885f8c278c142c1cd0cd47ee97c3e236bc36
In-Reply-To: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
References: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMyMjg4MDAwLklkZDRkNzFkMDJiYWZlY2U3NDg3MWE4Yjg4YjFjMTJkMDNkNTg1NDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eaae86c369dd6013ccbbffedb252dbcb659a960-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVoq4-000000008Jf-19vM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
 the address family in addr_match() and addr_port_m...
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3550360858166116777=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3550360858166116777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bMEbX9kBQLk="; charset=UTF-8

--bMEbX9kBQLk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2327?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: socket_util: check t=
he address family in addr_match() and addr_port_match()
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket_util: check the address =
family in addr_match() and addr_port_match()

Both read a2 as if it had a1'=
s address family=2E The arguments are
openvpn_sockaddr unions, so the reads=
 stay in bounds, but a mixed pair
compared an IPv4 address against sin6_flo=
winfo, or an IPv6 address
against sin_zero and the bytes after it=2E Mixed =
pairs reach
link_socket_actual_match() when a client floats between an IPv4=
 and an
IPv6 --local=2E Return no match for a different family, as
addrlist=
_match() does=2E

Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Sign=
ed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2327
Message-Id: <20261123140843=2E1436-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41832=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/socket_util=2Eh
1 file changed, 8 insertions(+), 0 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/27/2327/2

diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket=
_util=2Eh
index e85f6fe=2E=2Ea7821df 100644
--- a/src/openvpn/socket_util=
=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -294,6 +294,10 @@
 static inline =
bool
 addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_so=
ckaddr *a2)
 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2->addr=2Esa=2Esa_f=
amily)
+    {
+        return false;
+    }
     switch (a1->addr=2Esa=2Esa=
_family)
     {
         case AF_INET:
@@ -381,6 +385,10 @@
 static inline =
bool
 addr_port_match(const struct openvpn_sockaddr *a1, const struct openv=
pn_sockaddr *a2)
 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2->addr=2Esa=
=2Esa_family)
+    {
+        return false;
+    }
     switch (a1->addr=2E=
sa=2Esa_family)
     {
         case AF_INET:

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Ge=
rrit-Change-Number: 2327
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--bMEbX9kBQLk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2327?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">socket_util: check the address family in addr_match() and addr_port_mat=
ch()<br><br>Both read a2 as if it had a1&#39;s address family=2E The argume=
nts are<br>openvpn_sockaddr unions, so the reads stay in bounds, but a mixe=
d pair<br>compared an IPv4 address against sin6_flowinfo, or an IPv6 addres=
s<br>against sin_zero and the bytes after it=2E Mixed pairs reach<br>link_s=
ocket_actual_match() when a client floats between an IPv4 and an<br>IPv6 --=
local=2E Return no match for a different family, as<br>addrlist_match() doe=
s=2E<br><br>Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2327<br>Message-Id: &lt;20261123140843=2E1436-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41832=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/socket_util=2Eh=
<br>1 file changed, 8 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/232=
7/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_u=
til=2Eh</span><br><span>index e85f6fe=2E=2Ea7821df 100644</span><br><span>-=
-- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_u=
til=2Eh</span><br><span>@@ -294,6 +294,10 @@</span><br><span> static inline=
 bool</span><br><span> addr_match(const struct openvpn_sockaddr *a1, const =
struct openvpn_sockaddr *a2)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (a1-&gt;addr=2Esa=2Esa_family !=3D a2-&g=
t;addr=2Esa=2Esa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span>     switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span> =
    {</span><br><span>         case AF_INET:</span><br><span>@@ -381,6 +385=
,10 @@</span><br><span> static inline bool</span><br><span> addr_port_match=
(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (a1-&gt;addr=2Esa=2Esa_family !=3D a2-&gt;addr=2Esa=2Esa_family)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     switch (a1-&=
gt;addr=2Esa=2Esa_family)</span><br><span>     {</span><br><span>         c=
ase AF_INET:</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2327?usp=3Demail">change 2327</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd4d71d02bafece74=
871a8b88b1c12d03d58540f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2327 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--bMEbX9kBQLk=--


--===============3550360858166116777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3550360858166116777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3550360858166116777==--

