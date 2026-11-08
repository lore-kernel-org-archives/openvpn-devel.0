Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA2606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WZIZ8qzD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OnrseL2r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TCU60Del;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IP8LHfsq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2MxuChH9mt1RrBPDDnGu6q6N7Wr5JqqBM17AghAuKC0=; b=WZIZ8qzDded//xLTHBgpTRgBCa
	EgVCCyKTjEWH9TJCLiMJc5lbWZFlqi6Br8ZTQ7SD2KgT0WjRU2CMZN+uAGlTxSy7k7TuwlBoRAmEX
	kXNYvFeNRUjj72y/491cwv/Vwh9jGMyl2v7U/9Zv2hPxQCsS2CBmeHKPAg3KHWwJDoDw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ2mP-000000000mA-0EhC;
	Sun, 08 Nov 2026 13:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ2mO-000000000m4-05IK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sdLcmNW4fOD0FvN/pGy7FVV27ulGMiR77Pf5kTiUq8s=; b=OnrseL2rmo9F775dV5ZVLKF4+6
 CJPBuBBYeCzmfY9bP6GsDeXuCCBC+P5gMS+O0vUk0Aqa93MQ6cAsK0e1+aq6YwdDPb7BdKHD23UI7
 F/Vra9gyAaFJz4LUmw8jY09gQFFR4oHNOJAs5A2PhycS+tMNFmNQwxC81VSZH39q6eh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sdLcmNW4fOD0FvN/pGy7FVV27ulGMiR77Pf5kTiUq8s=; b=TCU60DelaVwQVlQ1LtByo/uQAz
 F4RVK3+Eoy7JCKC0GdtpEGTjvlDnCBQNH0WERg0O/tvBxKs/lspTX/MaZv2EMnanClFPmxZpAQMK3
 E3plBWevnJX5ZvE6LCUKwNL+KC5PxHCGDbHO14W9+aWd1t+63y1iRreeKIeU33+biKHk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ2mN-000000008Gf-0pnB for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:51 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so424895e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794143865; x=1794748665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sdLcmNW4fOD0FvN/pGy7FVV27ulGMiR77Pf5kTiUq8s=;
 b=IP8LHfsqY6XhszgBesZg7xfMUzXagWayHG337fbRJwjL8wQDVtmxNPTaefnRQocQgu
 zx9tIGwJWCiTAhYt7RKLr3h6tc/hc7vtNOMCHW1m9Aj6kciyD460OoG2UKZyasZPlQNS
 3k4yQhVIP9kDHIGKw2usky4sv+HIVam+eHqaW0+eeQgulwCyWkpQ+X8JkWTXmhH6RbJV
 tYweGmRum17A2zUN03dyApsaOe5lwbrCsLX0OwmTpe6UTPq5bRTbnGOYbgc6SlgFO4NH
 zlOt2/rQZV5lQ7hzKXQtxB/RQvSS+U4pscfvDjKJURaWRRx9F/HTHqhE0ESQTwOJIpLY
 C8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794143865; x=1794748665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sdLcmNW4fOD0FvN/pGy7FVV27ulGMiR77Pf5kTiUq8s=;
 b=gaW/lp8EZHPW515/0va3TQhagixSIzBN+VRV63zuyA19eoKI6IpB+6w7mi8ySk607x
 Ysjsf/fJ5UC9QE67ZJ6l7Xb4X/AMOusRcW9yOrzVMPfoOFfE3bYrXipZ//oE3/eettdd
 dDYedadEJeenAatF9zHCkaJ56SwtUFOdoi/x241YDPsYTHx+9wekNthTFlG3iDfJJ/0G
 WE2GnuW57W8Y0WpftHYM14COSD2tfwP4R8mzgnFYPfD6kgpcZZOhZke4j4DWwVIcL9BR
 k1sKDjd4Gqfa25jP4aE4gDZCRvm85jz+ViCl+ThmylQozPN31wva8jn7o32Io9DSPKKv
 8rRQ==
X-Gm-Message-State: APuU4Z/T9zOHRLAynJ5ZNW6g+RJUwi843tMH9d69fguPN0xX+/oA/VwM
 UsjFtqQDx7h4sV6Dp2pa9ooZqMYpLTah99rsoyK5h9ZOlafNVPeIxAXy7urmPfgrHvc3EL4BrNu
 QR6eC/wFFn2l0cjAAExlwXqgSvN5wZKScFxmVY9ynPMJixedDy+2szjSZTs5T8eOLkDSf
X-Gm-Gg: AYBFou0eTJANTQEzkMk55RmTEfrOz+9U/NjjnBP3t/q35kNZrZOgL1K9mIgr4cxOYsD
 yVX6MQvpJowb2/caMg+DoOIZWoyRdRqiXlYGpY7SK023dcdpPW5A+M7LDAYKmsTArx9M1GDcFDc
 sdUuepPeVBguc1luR0044RFZjSeURz1AWQk6Ta3mq2L5FMcIxdj5dPHfEJhxuC9hPp/tb9UiQPz
 3AGJyWb5OT180Amp+p8hXG8ExwncVbZm5YvctWBLCi64qVQ4f4R2jiJ+8boneUTvx/ULo7mmbdW
 ZkvNNUMb/vfSxG//o6aTsVeP97r80Br1T4kKSQEGUfD3+XQ9aCUlp85t25cq77mDSEjo2gEShOd
 hxFlKox3vFfhu4Xe0Vwyi5qqvjxFc7O4idDgRxqRG1Fsb6cTADjr4L2Osqt03zCE2mQAc0gJKPh
 0P4xnSPzsjhg/hTylM25ESOJis6lBM8ALkg7rUrLLN5ySXfEdQVDljc51aAP5jvHE4yTs7c5lDU
 pWJpv9CbFjFNaiI2FhhMEp55LXEECIF6wS9bXjlLA7NnSHHOIgt3BJPtawydCTYFlXKJEWHUlDJ
 5BK31pV0f5A9VGT22z7QGlAjuAdtqrUGK4DxmPNn3fJ3lRadFWJsmGS2MMlruxaZgqU6cSz920A
 wCZCCg7i2TlTp04khRe//UH6STWIqw4GkoZcEmsXCwz5ZiwSzxzqUBRGmgAdfqS8aFyvBqYQExR
 JlhyrmRgBRsGhHGQ==
X-Received: by 2002:a05:600c:4f43:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4b960d9bb82mr36235405e9.6.1794143864463; 
 Sun, 08 Nov 2026 05:17:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90619bc91sm55759335e9.2.2026.11.08.05.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 05:17:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 13:17:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
X-Gerrit-Change-Number: 2142
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2142?usp=email>
X-Gerrit-Commit: ebc370a5a232aff244c9d2d1f8497c665e6bd853
In-Reply-To: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
References: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTQ3NjA3MDAwLkk3ODRmM2ZmZTE3ZWNhZGFiZjk2Y2FhZDExZmU5Zjc3NGFhMDBiN2NjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6fe69e452693669e1d494180f39d448513664e2c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ2mN-000000008Gf-0pnB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: comp: use the wire
 byte when escaping v2 uncompressed packets
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
Content-Type: multipart/mixed; boundary="===============1749669229535864973=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1749669229535864973==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DF9FD9TKRaw="; charset=UTF-8

--DF9FD9TKRaw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2142?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: comp: use the wire byte w=
hen escaping v2 uncompressed packets
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

comp: use the wire byte when escaping v2 uncompre=
ssed packets

compv2_escape_data_ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (=
the
algorithm id, 10) instead of COMP_ALGV2_UNCOMPRESSED_BYTE (0) after
the=
 0x50 indicator=2E Receivers reject that header, so packets whose
first byt=
e is 0x50 were dropped with stub-v2 and lz4-v2, e=2Eg=2E tap
frames to a MA=
C address starting with 0x50=2E

Broken since a75bb2e4 ("Implement the comp=
ression V2 data format for
stub and lz4=2E")=2E

Change-Id: I784f3ffe17ecad=
abf96caad11fe9f774aa00b7cc
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142
Message-Id: <20261106125757=2E=
14721-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg40883=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/comp=2Ec
1 file changed, 1=
 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/42/2142/2

diff --git a/src/openvpn/comp=2Ec b/src/o=
penvpn/comp=2Ec
index 387a7c4=2E=2E513a766 100644
--- a/src/openvpn/comp=2E=
c
+++ b/src/openvpn/comp=2Ec
@@ -100,7 +100,7 @@
 
     head =3D BPTR(buf);=

     head[0] =3D COMP_ALGV2_INDICATOR_BYTE;
-    head[1] =3D COMP_ALGV2_UN=
COMPRESSED;
+    head[1] =3D COMP_ALGV2_UNCOMPRESSED_BYTE;
 }
 
 

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I784f3ffe17ecadabf96caad=
11fe9f774aa00b7cc
Gerrit-Change-Number: 2142
Gerrit-PatchSet: 2
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--DF9FD9TKRaw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2142?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">com=
p: use the wire byte when escaping v2 uncompressed packets<br><br>compv2_es=
cape_data_ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (the<br>algorithm id, 10=
) instead of COMP_ALGV2_UNCOMPRESSED_BYTE (0) after<br>the 0x50 indicator=
=2E Receivers reject that header, so packets whose<br>first byte is 0x50 we=
re dropped with stub-v2 and lz4-v2, e=2Eg=2E tap<br>frames to a MAC address=
 starting with 0x50=2E<br><br>Broken since a75bb2e4 (&quot;Implement the co=
mpression V2 data format for<br>stub and lz4=2E&quot;)=2E<br><br>Change-Id:=
 I784f3ffe17ecadabf96caad11fe9f774aa00b7cc<br>Signed-off-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2142<br>Message-Id: &lt;20261106125757=2E14721-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg40883=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/comp=2Ec<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/42/2142/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index 387a7c4=2E=2E513=
a766 100644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><span>+++ =
b/src/openvpn/comp=2Ec</span><br><span>@@ -100,7 +100,7 @@</span><br><span>=
 </span><br><span>     head =3D BPTR(buf);</span><br><span>     head[0] =3D=
 COMP_ALGV2_INDICATOR_BYTE;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    head[1] =3D COMP_ALGV2_UNCOMPRESSED;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    head[1] =3D COMP_ALGV2_UNCOMPRESSED_BYTE;</s=
pan><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail">change 2142</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I784f3ffe17ec=
adabf96caad11fe9f774aa00b7cc </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2142 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--DF9FD9TKRaw=--


--===============1749669229535864973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1749669229535864973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1749669229535864973==--

