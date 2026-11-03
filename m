Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A5606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zbky5Ujm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QLZyLg8V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sq0p26vw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ucs1f/jo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4jhMIyCSgdbJr+S44retn882+Byb/lE+SdfeV9mgmi0=; b=Zbky5UjmKAASRYnobUmqdsnhqb
	Q6HOAca2tt3DKt1ZD2VeIbHkAq6tBKfQRORqZ+EswOg7GSTRYQvHAXWeZiJwhwDoX99MXoT5KGlNK
	He4fozzJXd0xHGZMrfDmzgt2dTSsCFCqy4Fx6YKK9e7VHo78kOs0q5niIoqJKtj/Iwyg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKWf-000000000j7-1mPN;
	Tue, 03 Nov 2026 19:50:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKWc-000000000ie-0GZf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fJO2r+l/EBhM2XwErbsm17rJrxFtg2oyP579UhLeVG0=; b=QLZyLg8V7kH0bOGLjC5wijNKSX
 aQ1cKY4wbqpxLzIsKQYTxhdfz+xfgOtY17vz7paxtA8J17MoVKNhuKdO9YfiEN9ngLB5Lf6lMTFNL
 X+q0wlPUzY7QBsJx/50wmo+XHOQinERl8kJYy1ZP7FPr1LuZeQ9drIfpmXjAKkeZfC+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fJO2r+l/EBhM2XwErbsm17rJrxFtg2oyP579UhLeVG0=; b=Sq0p26vwwMZYEUcWmgIlLqTgto
 /PzAAoUheEL0hyRN9per0erj+jCj0AzoGx6kz1XcDTG0vYBHQ37JCKStTWj5UtRDlZCFd0a1cqIbW
 Btz/T4kD3X38ElxMFMPGT6hwQnX5GtdxbN6NrHKAgrCcJO2cbNDOCL/T2boV5dLpvSlY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKWZ-000000006iG-1YWK for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:29 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so6788645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793735421; x=1794340221; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fJO2r+l/EBhM2XwErbsm17rJrxFtg2oyP579UhLeVG0=;
 b=Ucs1f/joMUkz/uHz4wYhrhFvNTX6NgK3969PP/2dNqmR5pEYmAtDZMBsuPWqIxasYA
 B+ljWZCbiAarl+XRmAmftjYQ36pah3j6k3X+2HVtWW4PiAmMEhz4pgpyqZBM+T4fLsTp
 BNh3pQaThJRInJr8L73fUCrWM1rDZQZ7aDTcM7zzTPn7+S07bNMF/FP5ms0cg+E/M/xd
 qMyx4SUh4txxeM/Q1t6T8rTPCsseYDZ+qK9IewJzgY6BGbCLyj93Mu5HbJg+lwUmoWJL
 YBvUYIwxbQY/d7mgmYKGVeR57Z3oTAPX2k6RdwYWQPU6yWcMV/N4V8LoRK18rCLsj+Ep
 fNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793735421; x=1794340221;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fJO2r+l/EBhM2XwErbsm17rJrxFtg2oyP579UhLeVG0=;
 b=RFw/aSGv0qgmQ/8ot9OeiWBi0E6gkKTsdCgV1QYM8yuqKIipbRvJN8AhJbg/cVNjf5
 6fPUkkxVNnFnROEw8GVmosgu35OrbhXXMt4wyIkov1r19zGPiW1Ku2x6EZabry5lXPV1
 13nMYJZHma6+inJ0KjF6hjBHHPu81kBVTg3WOehIwLHp4BrgaXdRlnaxsB0zjpdLOTvA
 Z7N8jh4Dcwzn2dfjrxprJ7DrZf4524TBlHnvXZPc7Be4Sv576pmgS47H57ZdkwcPFi5i
 rTsG+5ibf4gwa9p7CrJunUPQzOThXcDYYSx4/Rm10J+G1XQF/3IEDWZZyM+oSzQ+EbPc
 qdZA==
X-Gm-Message-State: APuU4Z+3BEBudS/5+HDR4uOO9RvBYlGFs59JqZ4sxjqG6UrssEpatOsH
 5HRegjQjdC2vwSGQTCQKS3T8UCdQyL2B46LgT9QXbbQp5gYDonqLyBUTR57B+LlBvlNwUnU5a8W
 Huq+lAegiAbykyZ6/TEwPGSCtrEeSluC+k8u7cv+hnLWXxmpK73hGyBH0NVGAlvRDSHL5
X-Gm-Gg: AYBFou1iS2ndtxCsM4jsROJqB/1J8tDxz1d9pGG9bS/Lq39gDkS4JN7Az3sb0yZinPe
 ezWNfURNPwz37Hf62aMdqNWaxJ4BF/nwsFAQ0U/IAkIzn2PO3qx8NfzieXL3/JpKYnhJGs8eOWN
 ZPrbMKJ/MXzpWIZ/lLRBpXWIIjdZeEdPuC8zS/iuqA3CyvZL6mejPEngizwFqt76Cp2zwn6BZJb
 wfutBJjdKqBN7Ea8ddkSzSDJwRmZteGjbQdyg+iGu2HHPGre4zWiQbpVYg5CvNCPbVznxI/4R8G
 tyT9EaVW4aivJwotnF41rHCXPcsdmfTQ0g+u3gGbqq0zkPpoiSGJcjO/k1xjPCscbcw9yRaO+hU
 9oEmPV/OszMRCWl8U1gTAfkZNqvgWTC1zx/BNCNIMMgGKj1kMbxJ4jM/w+FW+WJZtG0Cql1dh9q
 DXghg0pMrkTDbXP6zs5V+VDha7TBE/tM+ZWVb4hauMS0l6Uekr7IwYRgOf38GXmU2a2ZtmvN+zs
 jWkLporlQ8RUCDAA+I+W1SbGqTgsw/rBrcr1O3D7n/gE1tbQcly/Jjf0Dqq0ivQDFJSpGDspNZy
 C6tUxSCpk/s4OVhQmXcweXlg/v991SgcdlmcOl8s8t04gz0t1rme7DdIsGYtEVnV602AZW91tq1
 qtSWg5Wfcko4KkHAahS5Vwb1huGLoEapYuqLKcaWkb9IFoQW+102R1PXzUS+ynIoztJfK773bTY
 p1jUPJcTYEqQ/72w==
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4ac17567cc8mr311475955e9.11.1793735420708; 
 Tue, 03 Nov 2026 11:50:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm81495775e9.9.2026.11.03.11.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:50:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:50:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
X-Gerrit-Change-Number: 2109
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2109?usp=email>
X-Gerrit-Commit: 99292e77a6c9c2fd94d3d767dd5dfe00055ca925
In-Reply-To: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
References: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMxMjkxMDAwLkk5ZWI0Yjc0YjUzZDY4MGMxNjBiOGFjNjVhYjg0NGY2NDA0NDMxZTYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4459a3fc92c31c905f40c647c2110b684f393f93-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKWZ-000000006iG-1YWK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 DhcpNameServer lookup in GetItfDnsServersV4()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5831958914844865653=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5831958914844865653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6v/LC6sEEkA="; charset=UTF-8

--6v/LC6sEEkA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2109?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: openvpnserv: check DhcpNa=
meServer lookup in GetItfDnsServersV4()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: check DhcpNameServer lookup in Ge=
tItfDnsServersV4()

The RegGetValueA() result for DhcpNameServer was discar=
ded and the
error from the earlier NameServer lookup was tested instead=2E =
With no
NameServer value, err was still ERROR_FILE_NOT_FOUND, so the DHCP
f=
allback always failed=2E

Broken since 0f3b7d17 ("win: implement --dns opti=
on support with
NRPT")=2E

Change-Id: I9eb4b74b53d680c160b8ac65ab844f640443=
1e62
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2109
Message-Id: <20261103184453=2E9550-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40608=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1 insertion(+)=
, 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/09/2109/2

diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec
index 484f27c=2E=2E4a8d0b5 100644
--- a/src/openvp=
nserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2151,7 +215=
1,7 @@
     if (!strchr(addrs, '=2E') && IsDhcpEnabled(itf_key))
     {
   =
      s =3D *size;
-        RegGetValueA(itf_key, NULL, "DhcpNameServer", R=
RF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+        err =3D RegGetValueA(itf_ke=
y, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
        =
 if (err)
         {
             *size =3D 0;

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
G=
errit-Change-Number: 2109
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--6v/LC6sEEkA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2109?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: check DhcpNameServer lookup in GetItfDnsServersV4()<br><br>The Re=
gGetValueA() result for DhcpNameServer was discarded and the<br>error from =
the earlier NameServer lookup was tested instead=2E With no<br>NameServer v=
alue, err was still ERROR_FILE_NOT_FOUND, so the DHCP<br>fallback always fa=
iled=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement --dns option sup=
port with<br>NRPT&quot;)=2E<br><br>Change-Id: I9eb4b74b53d680c160b8ac65ab84=
4f6404431e62<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109<br>Message-Id: &lt;20261103=
184453=2E9550-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40608=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pnserv/interactive=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/09/2109/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2E=
c b/src/openvpnserv/interactive=2Ec</span><br><span>index 484f27c=2E=2E4a8d=
0b5 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br>=
<span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2151,7 +215=
1,7 @@</span><br><span>     if (!strchr(addrs, &#39;=2E&#39;) &amp;&amp; Is=
DhcpEnabled(itf_key))</span><br><span>     {</span><br><span>         s =3D=
 *size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        RegGet=
ValueA(itf_key, NULL, &quot;DhcpNameServer&quot;, RRF_RT_REG_SZ, NULL, (PBY=
TE)addrs, &amp;s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       err =3D RegGetValueA(itf_key, NULL, &quot;DhcpNameServer&quot;, RRF_=
RT_REG_SZ, NULL, (PBYTE)addrs, &amp;s);</span><br><span>         if (err)</=
span><br><span>         {</span><br><span>             *size =3D 0;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2109?usp=3Demail">change 2109</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2109?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431=
e62 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2109 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--6v/LC6sEEkA=--


--===============5831958914844865653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5831958914844865653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5831958914844865653==--

