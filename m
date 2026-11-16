Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CB606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CRqgpnMp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fh0Fqg/a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iiwNTDvU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d6CJ776j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UtNvV4eFEe0IzI1ROeupRKcjON+PyFpu/hiXiT8vfCk=; b=CRqgpnMpnOCvrzT00Gtesg3XgN
	dmo1nods60ieLQK0e+/85MkPSxLiTuyGvAhV5N7BMyecDuvQho2DuFiJGyWR98LaW9AF5hUOWAqHZ
	x1OfahkuaAfXX1VnhmLE2+sOZE4lLEH3c2uTjzxh8m27lThQz51LVURyngyImbhy+aLY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxrt-0000000026n-0I5N;
	Mon, 16 Nov 2026 14:39:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxrh-0000000026a-11aC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cc9B32webSdmiLR9ZGGewugyc3tkcAZM9s8RXC9BHIw=; b=fh0Fqg/a4D8l4liYo3H/hFqyRX
 evWXm6yChirkCRuRpnrEH2a8FD4st6sU2hnBl/pfMg+I8pi/9va69BLDuLQ4P2UsoXJ2UJ97QYJdX
 Jw23ksgfQbSTQvmAV7kQz1lkXu9DYsjbxb0AMFVSSNknW3P9AovxjBs8Achaqt7QFmd0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cc9B32webSdmiLR9ZGGewugyc3tkcAZM9s8RXC9BHIw=; b=iiwNTDvUK2rVGFXBY9znfi/fEf
 MPV6U6H35ezARZwUUaHyhwMPGSJ6lyxo3Rm6CyAC4ibk/pYFivVEwjPmV6J0KZUJMiXNjrJqc3Bgi
 RQ1ZkL4+frF6Enjc3Ziuto9MaMzYPjIBryTkSBUWmHHOw8fKBXSNJSXrAJjdO0h/SihQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxrf-000000000Vw-2mS5 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:39:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20302535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839957; x=1795444757; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cc9B32webSdmiLR9ZGGewugyc3tkcAZM9s8RXC9BHIw=;
 b=d6CJ776jQ/WFGe0m0CgUvb7ouEkPqBxTGtlJEJw+/K9lrUvNCIjdtOycrBLOf/OW0M
 Sb0gMlrMEFAvg0FSizXi3kSaS3zBlAr0N7qL710kpgyGJ3Gdb9v9BUIPVUOaotqhZByC
 HEQmXcLo7CHNAgl02Qw53zphv5VXtgWTuWo8mMkxNQAiIRFx4P29QEeOVB/vgAZKrCNd
 lSfcENquH3MTjULs/wG5MeNcy80wbQVqy2TFNghz971QtMBFagirOJexUil5PVaItW/x
 xWHkl1vVCU23LqTeXfSDJJd4uvN00YAc7IrGPJz9VhYTX9TiLGSJYqjTWsm61IGehFDz
 KiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839957; x=1795444757;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cc9B32webSdmiLR9ZGGewugyc3tkcAZM9s8RXC9BHIw=;
 b=aacsxAsXLJX4ZFE281spWIxpOeS3AbWRsB7a7VBPAd0XgZ3s7D7BPPSoS1PhXOrXeJ
 wacPp5/ZjUuymEpFbj6TerkfiNLAv8eBlzq+hZSOejAinsHoMuCe4eVoXleeXeIV7mJW
 /LHVKQz2XG4Mrwuvm6yTZ8qb5QEJR0kUOV0FEsDL1d9qaFGnkN/NqdW5Dj8+u4DZUEYf
 qCWJSrfTlivY9SOWsA1WLrBCWH4WElZQj3gji//49jpfiK9OJOD7br1PIM7cRZb9CExH
 igUEckMI6baxvPouKn7f5RAWzpMoSetIb/BUbugyonmxxoSq1eT3kP5fBbxjZ3ot2ISk
 +BxA==
X-Forwarded-Encrypted: i=1;
 AL+hErGU6Nt8cmHPIlfYyQoHErvLkz1g8K1ZFFTwo88eVZn2thuBw8MvJE595Jpdl6XTe4WN8vgqWTpEvArYKw7L@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/nt94nxpeQ4G2iDWFKvWVNrMz8iLgFi8wLOS/tyyc6lAe2QpLy
 UueOOvE14sf/Rf03kLmFpe+ing5afxWAewwn2jPss4Zy5uPgRxNVOdWb4NKMvM6Bzuf0pl36Q9a
 3G0BCvruFw3FcJTE86Q/p77FExM62X/sCnzkgkg0MuxOUDrWEdcsjXagv1jjRXXDd/+d0
X-Gm-Gg: AYBFou0CrOuEgHoa5N1/86CkJTOoNsA5OSs1z874O76BlFSANh8Obq/dkkiM1gptMIW
 RbOlpAdVmCJHgvOPpGwGiYeoQKckgBvIqyQXu4l/kMh5AQTME/yFE7TTMO6pnUTXcY/KKjkgy7S
 QlOqMbN5A23boqxlsahZjY4ip9krpso8e7knJzAQnrVtdTV/bJ1FEx06UB5KOhm7Idepd+HI6K3
 IGrDC79J9Z+fdDP/3FJXOx5rMfqZ5v32soRxg6XHT4LRR5jw5zL7wWWs+R4lyk7R035RetqdTm9
 0b/ODsMDRQfPiKjHWc/FEPv4BM+hVV9BSrF76RznLemQfmXbYuwCG5Ep0lABcMqVTaP4agBXH9k
 jSr9rnqceTBlOhs9LuB5fWjuif0Ay4EBzCmviaWpEQId/GmuMFSUdTWiNAtE+sUrGQ2r7f/yJz0
 DdxLbEYGGQWYvpX/HurnAm21Lf7HWOps8OGYnK/jk3WlAO8OhEk8gNAq1UdcUw/jqM79syi+taJ
 DNZEfjPxCA1RrR6YeqnEGLQ86G/SA5Exvx5Eajn52+by31Na0ZgD5ii3pMs1oZa0ET5TDQW3AmM
 DSBIoETslYzGeGo7K62uRGgVDXMjjHGBoSI1U1MESfLzvpZcz8EhZZSBNMii4ngnBQoZtUpdnYV
 HN6i6s/Ec28dkianXUezN/y4KN2Ply07QQD+SBv3pnQMSfGW85MJxBsr6vWmWLRHtoLfs4cM4xU
 4nNNbmg2m+h9D86tU=
X-Received: by 2002:a05:600c:3b8b:b0:4bb:7007:4a5a with SMTP id
 5b1f17b1804b1-4bb70074dedmr97374065e9.23.1794839956761; 
 Mon, 16 Nov 2026 06:39:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e252f7fsm399450175e9.2.2026.11.16.06.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:39:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:39:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
X-Gerrit-Change-Number: 2194
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2194?usp=email>
X-Gerrit-Commit: 6f1b0274bb5d9af332b749d54716084834a95101
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 14:39:13 +0000
In-Reply-To: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkliMjg0OWRjMmMwYTQ1MWIyNmZhZDk4NWZhZjc1N2ZmMjJhODUyZTkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c93ff5fade1bd61d7a04aeebc70632c1139afa1e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxrf-000000000Vw-2mS5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Use latest NDK
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6299857183181390300=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6299857183181390300==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zTBK6GTjZ8A="; charset=UTF-8

--zTBK6GTjZ8A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail )

Change=
 subject: GHA: Use latest NDK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
Gerrit=
-Change-Number: 2194
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 14:=
39:13 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--zTBK6GTjZ8A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=
=3Demail">change 2194</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2194?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2194 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 14:39:13 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--zTBK6GTjZ8A=--


--===============6299857183181390300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6299857183181390300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6299857183181390300==--

