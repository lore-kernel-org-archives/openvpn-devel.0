Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5117BCD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+6ZCvG9ERw47m1rL54IVn63/MWokEb1/hy/H9wh3Io=; b=TIG0LqSBj2RHbfCnGAHvuOD/2g
	92anOyrBxTukvZMZi7i7peYiqSbyGRVUGa7PZVfKfSd2cS1/r1Wqj9vc3Fpbw1gj+Ykcx/k1x1qTm
	PazdXhfXBKqVwcut7KYuD5TO3A/a8YDsPgeGZS010WrBL2CWNAVli6Cmym+nt+IOnpGs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPj9y-0005JQ-AS;
	Wed, 20 May 2026 15:48:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPj9x-0005JE-BM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 15:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BP/59tuQTz41kHAKlkA2PqJOZOgTw1cbkqMrxlNomt4=; b=DKdZw8GqXeT7gbPtJ0dVYEJ78W
 m9hkPNzEWT/CMFJO8lu/Yl5X9+//NHOLNM35sND4c+QmpFI1E5nb32LZl8SAxIdYi0MXdTNPNyd35
 mYS3UHLGgCx5ArQgfxmIaJVDq9y97jhk/aiY0mPUGG/RfdvjezIRgr77Fs66JDk3cCMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BP/59tuQTz41kHAKlkA2PqJOZOgTw1cbkqMrxlNomt4=; b=Z
 P72r4soJUsaWJE3D+m1dLWnQWLyLOu1F78HWnnUOwdQ0Jlg3dwDfSmp3fVlr04D6I57SUPUoyfWWp
 jIb7ACgvuuu13gj1dNWerh/4eUYfQCdyyLMC9xTk8sCR9kwptG6UDeIpXB0hJhGdcP1jf+5ChTcLl
 QmY9jGOIoJXBkrps=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPj9v-00066p-Io for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 15:48:36 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so54572905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779292104; x=1779896904; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BP/59tuQTz41kHAKlkA2PqJOZOgTw1cbkqMrxlNomt4=;
 b=P4JR36W2MmGk77KVV5OzdrxaBLu6rv4k1l0lJnmz99fO6V4GQg2jX7HW7vQwngNFWn
 1/JvOeCTokjXQQzcuiXy7TxrA1w2R1xxtLqpHzAsHe2Szv8ObT7G8kpyOvGEnKLJgIbj
 nL31mToIpURkgtQU+0x8LwbXkWNLlXHAsGlmNUOsjWBB+hmMiOynqMgDNMPOwg/AUH7+
 K+uou78YTRrKX33H7DThzehdyelQNM2FiPBlwE76pll8pRzEwYfpjUaF0XoXAn0tBZBZ
 r41XqIlbVG8NHKsH6KNM04TaiP49TxpPbv4FBuAhUD/XFJNu8pzikSoHQ63KkZB0a6Fx
 kwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779292104; x=1779896904;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BP/59tuQTz41kHAKlkA2PqJOZOgTw1cbkqMrxlNomt4=;
 b=Kj0BVGeCRW+L0XbviL85FS3oNN0UL8FGU6VXSTHTYeA437NGYOfHELuq33oK9b4Mqp
 z22wAB2jO9H/PCMOkC20kHN6pUwKM/SSrKiDrrban+xHRzFQGAflcYNYC/kE5YJmtTAw
 GUCwDKTzghp5+MLkHQ9Lb6lW3UlaOGMaDwwbUzj/vJK0UTG8K6qqvLH8BpAh24AYRSO8
 yww9yefPGHWSleMrbJFz+PCaT6osJLBaaFpT3ksoWGjh2Ug1NikDBroxZBniO7ARfrPP
 NvqgiIGdUulLTZYIvGj1UDJxFgLwxwOffpb0ndETYSHGI+yQ56MVM/k/DeAyS2vmdPfn
 b4sg==
X-Gm-Message-State: AOJu0YyW7W7MeMnsySynxZ1ZFNuLZ4dYPZ6ml0S++9ifQISbHjQo/Myk
 vfASq5D8ruKycJLjLDAT+zfv32mX5WCkZ4YHYLT/uaAMczEPPbgasJS0jm4g9+djDV7ede4MZal
 rmtX0J7r/MX2YkiYntiIg3FEBiLfssjZ9aMPrR+NGkbP+GPr47c/lVkfGegmofiiBbV78UifTeY
 S6UfcsJA==
X-Gm-Gg: Acq92OFQM9qmVQ/vHGCyyZEHMwMRP7so6rKVB1rzsHCjmTeyOm4s6JSSQ0HElv+DKQu
 9VabKSC5Q2jjfOhOFjywq6l+PwRro2bRDAeUPRz3JPu36H8V0bP3sBCFBpn7YnffuFWCl2FjBTU
 qtK94w0vSaluztF0AvpKdIUlCe8u8kei0B/u4fZB4aJygjlJhdqM/a/6FwMOedRIyA6C31QNSD2
 e8Z93EWtgvKC6vvsSTlPgQDQean8yXoEM8j59RdEB9egm3bZHdRGmPTEsy7sOP/iqB87ZsOXs3T
 CVQbVeJU6x5SF/DmDDl9YW2tbztvhwh/VouV+drwiQuce9b3eQf9J5n7FkdJIrc/BwhGCBY0RPo
 390tP13R+CTwH091GSkWAXXelseSf1oNHCK0toc/iMaOT/u5Q0yhEZXxTAAEvM53svFIBhbS2pN
 6C9P7+/xntLdkoeRIxbdhjHcRvdb70p0RUvmoj3JBDnaARR/jJIVIu9SF8Al8/mtSnuwpiIFAxp
 kgybW/owzdcdaaKdt2gh3o5MTqpMM1+5OxtVVI57Zr0l+YjFaNzvT178FqLdfPbW+2feyeO6Cg7
 hI86cmP58alGPA==
X-Received: by 2002:a05:600c:181b:b0:48f:e230:2a1d with SMTP id
 5b1f17b1804b1-48fec369d0fmr231103015e9.32.1779292104282; 
 Wed, 20 May 2026 08:48:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf80d04sm132952185e9.36.2026.05.20.08.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:48:23 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 15:48:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: c2db2045f18ba56609fadd81e23bf1bbd5830f11
X-Gerrit-Comment-Date: Wed, 20 May 2026 15:48:21 +0000
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efde9109dcbff5c671872960b66db8581b05a984-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPj9v-00066p-Io
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strtok with
 strtok_r
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2593137601282449019=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2593137601282449019==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hcqs0nCpPy8="; charset=UTF-8

--Hcqs0nCpPy8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:=


(1 comment)

File src/openvpn/options_util=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1679/comment/0fcc165a_f8562a96?usp=3Demail :
PS4, Line 5=
1:         char *lasts;
The Linux man page for strtok_r warns "On some impl=
ementations, *saveptr is required to be NULL on the first call to strtok_r(=
) that is being used to parse str=2E" So maybe we should initialize it to N=
ULL instead of giving it uninitialized?



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Chang=
e-Number: 1679
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 20 May 2026 1=
5:48:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Hcqs0nCpPy8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options_util=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
79/comment/0fcc165a_f8562a96?usp=3Demail">Patch Set #4, Line 51:</a> <code =
style=3D"font-family:monospace,monospace">        char *lasts;</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
he Linux man page for strtok_r warns &quot;On some implementations, *savept=
r is required to be NULL on the first call to strtok_r() that is being used=
 to parse str=2E&quot; So maybe we should initialize it to NULL instead of =
giving it uninitialized?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7056=
0efd113308b7377424127eb2c1da4266371a </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Wed, 20 May 2026 15:48:21 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--Hcqs0nCpPy8=--


--===============2593137601282449019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2593137601282449019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2593137601282449019==--

