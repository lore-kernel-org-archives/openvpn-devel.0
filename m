Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C19606A33F
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GktqEkga;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UtuVjtuP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k3YC8zj5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dOhZSgm0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s5YPJpw2H29ilKE0GZC3JLaSWNN+KQKKvDUbPwj4Umw=; b=GktqEkgaB3iSkY8nNjzH5Z+iBv
	cPQBBKEDrHu3uV8N2LHM965aXKgVROY28i1FrU5BhkCAyuFjzHFcE91gjVk7bGgGiC+ahtbDbgPXh
	6gheOO/SmfD6vB98CgK7QkocJM5vLYAw3tM/h8ZHjWuor2TKCjsxKefC39LdZ9ZCOvhE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVShR-000000003Lx-2eSH;
	Mon, 23 Nov 2026 11:59:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVShP-000000003Lr-4Arw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HkgrIsHo5OxW0hjVqBGafL2u+Ye1ASSSP6JgNiaSe2I=; b=UtuVjtuPKwIv2pIL8/99FXjDYi
 GMTQit+dnRvs3gdmaKblunCpzKx+yvdlL/VYmZScnnqSKdzeZ6yPx2gRmNL1LXH37DiMuVUWbHla2
 VuAES8VSbjDt2DJXqY+C8hvt/uoxEArCju7f0mf/MmXVguwZIZ2cMLm8fMB2tKs4GVVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HkgrIsHo5OxW0hjVqBGafL2u+Ye1ASSSP6JgNiaSe2I=; b=k3YC8zj5XV1BTzY+m9xEvGe+qF
 XWOLEssoxmPAl23dbj/nYQNWewN7SFHrr9HhGPCbr0tsTCq0GEOJ4cV6eWW51BVOYvd70sUrSgbJM
 d4p09VZXeuSJeXdy8dnEPyWdPxfob5R+QncWoQihYDsMZWCa2fpIHuItHTl2T+FaiQSg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVShP-00000000056-1EVJ for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:07 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1964723f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 03:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795435141; x=1796039941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HkgrIsHo5OxW0hjVqBGafL2u+Ye1ASSSP6JgNiaSe2I=;
 b=dOhZSgm0SvA3ocoos1f8tiD0mUKzH2zMBTqTnnJZtnJaOMMrGElQPlkI3sz9bcnd1k
 7aH24KngZoGMSsMp3bQjb6GNZHFjFFVdFVcbuhsgLGSytU69a9Hg29G/PdocNcko1jZp
 p27p75nC0k2cDzeJbUjkTViiYoVa00CFdZ8pSREXT8syYMVRgtGDNUcCBBMQwQSPl+zj
 +DYGUjEpL+vCBwInFpYUdK3Zyjj4hyYtOo0ppD2X7ex0OHIV/ZQxuA11VwTiDrfnGCy/
 AuRtFiDcChktBatv+dRWc2VruESt4MEyySCTbw2QH93keeSq/R8mOznQAgDj1PKlycjR
 mG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795435141; x=1796039941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HkgrIsHo5OxW0hjVqBGafL2u+Ye1ASSSP6JgNiaSe2I=;
 b=EHCJkXt68t8h6zWs6Abp2+Z0+IGUb0rj7ScovsUlKgHICyAC28hm0sAkb2oOXrAer5
 GgFtBjHGViI0yqa/rF/bLN65LKiOfx719jROMl2CBbab1kRpUhUAdob+mU1xWMZ8WnvX
 TU6yrFK/dZUCiAEY0evR6O/mpMXHbBZNGWexKdDFft01Mf6hs9ZHxZhuhYKdzko9uUkP
 ZQSjtSnogMKTk+sOOa2n9OWt2+h3Rm3UDmkoxw1XUv/iV4oyCMo4CBypV2+1xMy/xZPS
 F7r7nnvZbrDK67dt/4nc8Kqi5h0WChCe544nnRss19XqtltvenXc3kgaNmj6MJJiyneP
 OwJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHhI6iRUpkdnxjXtmj/gIim8/wvlD5mC4Br6G9o5d0YrghAhB+wIM0xsuFnijOO0T7AoFVTMQdrdyIY7gAH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+1xT3PdEQ+B7M/PK/x4h2aiE8u87nU30Gj/5ZSoWK6f3pnC+Ut
 VWbnRjYG7LjOqipEjTxgCEzhROM7xkS7l38Soo6DweTkWLEO4dDxjF9MJa2HfjvneZwb5qpR3Ea
 kliy+F0dwDNirJ1akH1ANUmWqPGYnxDUE+Oe3ldJY1lDlLtXB2Qr+6eobp+NmJ/cJrSU5
X-Gm-Gg: AZFdTZcR2dF0iUDGxPnfEeHfA/qu1Gt+ly0AagXi4USJEGVEJxnRnVzXrFtDKXz5O8n
 PkNOAQ4xH5/56r2tWFQb4HIAQq32DMSyU+CNXLLy9GqocgduuMavhJvJd6+RhSmlBrPzEbne99P
 vsveNeJJKLLF++HA7es6gLqsBFPzMb5t+R0FboCA9Zprt8uwPG+FpiPLeG6vv3Vj2faooGPxtWo
 smwRTsd0eWX+rGTmlZF3UVNVAB2BRHB2vvFsjbJb7rpcm3YWRQ5uLTZIAOVakry4ObSaj1GrLPw
 EOfCAKl8HCfQNm8Ky6d73bsZQj52Tsu0brXTaMYaCyy4xChODGtiqvde8j8GNHr/vQitmvp8EYq
 +VJdQUEXkta38qrIm8BDxHIShf5T4MwV6xivubql01b8zzyRjWjHgmlrIpiA2ahvD5agA0DiaCF
 esEMSrao4SORAYjmGl6SFhPJ3hvAaJf8cUMguio9ZtjNzyoavvGWa+0C3f0cCouJLIXqs8REKh5
 dUGtB0yLLDwWp3I68ys40RUuXQowArfZ/qPM4tgxZJvp0at74xm7oQIclRRto6g8OsnFL+/mxFm
 TdFCxxIeYIcEe/kCO2V9u6qfExrwklnrwx87Yoc2rIKu1fhoFdNiWsLc6Z9qaNaRXEfyJwSWtMd
 aKLDx0JKB+AmDjnp9dPem3WnIv2kbK+uPPekvL+nPy9HGU+ZciiC2nBr+EOhXsAhJ0jgiCcqHCP
 glZbQZ5p6LJzQjXTw=
X-Received: by 2002:a05:600c:674f:b0:4bb:7e4e:de69 with SMTP id
 5b1f17b1804b1-4bb88814c37mr226107505e9.20.1795435140496; 
 Mon, 23 Nov 2026 03:59:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm539461215e9.14.2026.11.23.03.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:59:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 11:58:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
X-Gerrit-Change-Number: 2236
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2236?usp=email>
X-Gerrit-Commit: e8c48a220f9fa6156a349a3d3f0a8fb88f01442b
In-Reply-To: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
References: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3ODM0MDAwLkkxMjQ5ODM0YjE4OTk0NjFiYzhmMDFlODQ4YmVhOTVlMzBkZWNmNjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a73bb6d904622d9dc4e6bf1c42845592fb52556-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVShP-00000000056-1EVJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: zero
 name server bufs with ZeroMemory
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1525672766373670760=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1525672766373670760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rhr6szjUmAU="; charset=UTF-8

--Rhr6szjUmAU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2236?usp=3Demail )

Change subject: openvpnserv: zero name serv=
er bufs with ZeroMemory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

openvpnserv: zero name server bufs with ZeroMemory

The buffers =
in GetItfDnsServersV4/V6() are NUL terminated at their
start and their end =
at the start of the functions=2E For better
readability use ZeroMemory() he=
re=2E

Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
Signed-off-by: =
Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/223=
6
Message-Id: <20261121094633=2E28585-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4175=
3=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpnserv/interactive=2Ec
1 file changed, 2 insertions(+), 4 deletions(-)

=



diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interacti=
ve=2Ec
index 6bd679f=2E=2Ebe57d43 100644
--- a/src/openvpnserv/interactive=
=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2174,8 +2174,7 @@
 static LS=
TATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
 {
-    ad=
drs[0] =3D '\0';
-    addrs[*size - 1] =3D '\0';
+    ZeroMemory(addrs, *si=
ze);
 
     LSTATUS err;
     DWORD s =3D *size;
@@ -2221,8 +2220,7 @@
 sta=
tic LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
 {
-=
    addrs[0] =3D '\0';
-    addrs[*size - 1] =3D '\0';
+    ZeroMemory(addr=
s, *size);
 
     LSTATUS err;
     DWORD s =3D *size;

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30decf60=
c
Gerrit-Change-Number: 2236
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hund <h=
eiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Rhr6szjUmAU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2236?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: zero name server bufs=
 with ZeroMemory<br><br>The buffers in GetItfDnsServersV4/V6() are NUL term=
inated at their<br>start and their end at the start of the functions=2E For=
 better<br>readability use ZeroMemory() here=2E<br><br>Change-Id: I1249834b=
1899461bc8f01e848bea95e30decf60c<br>Signed-off-by: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236<br>M=
essage-Id: &lt;20261121094633=2E28585-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41753=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 2 inserti=
ons(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 6bd679f=
=2E=2Ebe57d43 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec<=
/span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2=
174,8 +2174,7 @@</span><br><span> static LSTATUS</span><br><span> GetItfDns=
ServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[0] =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[*size - 1]=
 =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ZeroMemory(addrs, *size);</span><br><span> </span><br><span>     LSTATUS=
 err;</span><br><span>     DWORD s =3D *size;</span><br><span>@@ -2221,8 +2=
220,7 @@</span><br><span> static LSTATUS</span><br><span> GetItfDnsServersV=
6(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    addrs[0] =3D &#39;\0&#39;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[*size - 1] =3D &#3=
9;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ZeroM=
emory(addrs, *size);</span><br><span> </span><br><span>     LSTATUS err;</s=
pan><br><span>     DWORD s =3D *size;</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail">change=
 2236</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I1249834b1899461bc8f01e848bea95e30decf60c </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2236 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &l=
t;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Rhr6szjUmAU=--


--===============1525672766373670760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1525672766373670760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1525672766373670760==--

