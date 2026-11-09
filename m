Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F8606A331
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fjf6rh8n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GYyC5+T0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mhyr8/V/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HW7j3ld8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5OzHqezlwHb1k6BFeIHJnViivZGOLc0w5OyIRzySZJI=; b=Fjf6rh8nDzrED8f4trtN3P8FHI
	GdhzRpzn5o1JMOmAp4r5qJuB8qH0ktaJV09/1DapHvwRuKW/WAIV+frhQ8CJ1V1InFL7kvEvI2ai1
	eLGLZ0wr8bazeBdtBDpA188vFXDRecpgO/RLqd8XEyafFSG8/qbehQfribH08CAgDIio=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQXB8-000000003iU-0rpk;
	Mon, 09 Nov 2026 21:45:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQXB7-000000003iO-31vP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5XLMtprK1As7nWz5uL6Lvl5X1oLZqDGMXS7KP/o74J8=; b=GYyC5+T0VUwfq/+4yOpA94nNjl
 a4LT6NvmGoH+39G5OxxZ36kOX3RlzQqyLTswW/0bAx1FnfSusAc+hE4n1e5Q/WQ8bc8RufgYlCbMp
 PS5UI/+MeMHpHc3uwi6c+9jSouQZmMWIbb5YAUcbq5jEXsu/dFHflEciYg3CEM5phslU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5XLMtprK1As7nWz5uL6Lvl5X1oLZqDGMXS7KP/o74J8=; b=mhyr8/V/voeameuJ5RiuUEMOzf
 RNVk91+OSFlZuftH+0fTfTvzB+M/hehKU5qYKrD8NvDPgNlQNpmqVA8Qz3xDj9nCpHQMEJ04nwirK
 DvzeIn2Q2x/mhbV1D1Wr4l/3jJ2+3KoZbGTRecwgPXgw0AwUClyVzisOknumN6EACNiA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQXB5-000000001HQ-0Vfd for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:45:25 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so963927f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 13:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794260715; x=1794865515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5XLMtprK1As7nWz5uL6Lvl5X1oLZqDGMXS7KP/o74J8=;
 b=HW7j3ld8WcXr2V8svN0aAqqHZAMSvLSff9NXifnysxSemYj5oSbLk+XRsUzXvSrHUb
 GT+tBWEmOe1TQQyXJbZRcpQ1KxRzR22hC7p4b6jbRG3WyKTIJouRRLWfBegKAA+2K0gH
 J8LwwPyGjVMQ+5ZtC2BFewOEkoE2m4hnc3HR8UWgWIBJ4kmyQLxN9npmKrVZY/sIv+n+
 uKSSJyZQe1qmaHI+DA8EyDNHH4oWFCrpiT+dUWyN5S1oOQOVS1oc5Csh3rFD5AaSIQ1V
 2GMcoKdJWJHA9XZpACleoEo8bCjaNf3TwlsBlC5ykwor+ftCtFtpqwWA7+S83ri9fg/h
 RlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260715; x=1794865515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5XLMtprK1As7nWz5uL6Lvl5X1oLZqDGMXS7KP/o74J8=;
 b=DupivpgWomSPXRCdjg+HW1AiPvRw96U1JJLMzbjrZpwFJNPfaxp4Lx5sUJi0pjgFp0
 4VpvTVvjPv8zY3304m+KPcmHK2LHn4Ksj/E0gz3hTN3vu9TzkNj2sD/SKzbEyKjUupx+
 r1JOIHJ6M1D4nBVxnTk4VijrJPFC0cAlOSgYOYtvBQC+L5Hro42HlqmRcPYmq5tIpSWS
 xnLAY+5WTcXg3kM6VE+v1qsm4VYX6Ry7QRbvjASTATL7rEd1KOR7sjX3Aq24NQw9SurH
 lgInzCjOa86GUQfIVqAFFmqw8MoG3I1M8J6uPLsAlnnRC6YatEGVveKOMcKEVI50g1iA
 3KJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHLx1qW+MshqgASwVY5ucIOr30JAUCyaXszz7ZU2gnAB5AM6utqFfHx/cF/PwSocCHBRF/+QweEilE5cu6v@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8TDuhWgFCQ7TQz1tuYagYVNdmjkPRhFUTIQ7nL8lziOtPPe1Wh
 KuoMuTcX0TFqVOkc+KVCmMZt0yNeNvEMlkcLONAzMWGmi1ZinpndUTwj+Dr9Hf19kd8P1L1w+bp
 Xm32VlqyGNl9Hm6O8MbmyDha4R/+rKoiCjbLvzkYDS/TOETET2bGZRXf6M5LnoqPn5U29iKQr6N
 HXee/Pww==
X-Gm-Gg: AYBFou0gJV2rFZtGBC7tBKvbCUeTGVifXkl1W94H9iNWi1ITYNgRFDjyBzi8Hk8ingX
 Rl0Hsnmt91QWswe3fltlLA8FhNmOayJ3RPV9+Go0DE9wwQSy2lAU1aWaKrDQx4jkMDjXm9Wzehk
 bGcy2B66adCp1kF3IXYz4mbyAMp6TTIpaiO2xLaurQsnULwJ56kwHnOlfHVbWrz5l5Pj98z7I7y
 4AwqLqzf+xYmp9o8jXc2B/5q/0nkTtxWWKHS4l55kDWjB5wfgnwFMkryqlPP56rifwCYfJCVDGT
 qi6Me52nr4di7Rl/0taoDs5dCXZMHxETJPNuTBtdr3O8mnlTqEK1RpzkLEE7e2CNMn2PpzkvxKv
 r2/w5lciRodvIy6Ox5qZK2BDX8V5pH9aM2oPX65I+19ymF2OfIm5zKJI6lRu3JbESsE3rma3Vxn
 NRJ+xdlia1dQZzFYPByptNUJyu8EaWQwhH7xzuQrn+5rC3iHmYRv/aA+hrrxceB2vCiF6lYBCRr
 rrjPtYzo1ZIVNZHxVELs3E0TV5YStgpYSJ+fCX8XbLxQkcGjCl1e+248V2W73EyASR6K5AQ0M+q
 G0c45vY2uiFfhPnzF9E2XzUM1hX6u3iKUoH+43hXPG0BWGi2rB+6wmiXYFnOvXhIIi82cs+lTrO
 t5rXF5g/BiSa4DtYCp2pqubBtxbV+s1FRo/cJIXiW2bdQG1GhsXxvHX6hvNATp+pKY+FwZsMf/W
 YIrEY5Mkweo1OpWvI=
X-Received: by 2002:a05:6000:4709:b0:487:6f2:1a4c with SMTP id
 ffacd0b85a97d-49830206d19mr1062939f8f.25.1794260715299; 
 Mon, 09 Nov 2026 13:45:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585cc9bsm1307716f8f.14.2026.11.09.13.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:45:14 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 21:45:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: ed3ea74c421347f3da06957ec0ac183b1c74bdf2
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 21:45:12 +0000
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6e2ab43ad11235572c34d9603e6b5825cab04816-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQXB5-000000001HQ-0Vfd
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Enable
 -Wsign-conversion
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3767475951851224280=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3767475951851224280==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MyEhO6jWA0Q="; charset=UTF-8

--MyEhO6jWA0Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail )

Change subject: Enable -Ws=
ign-conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 19:

(1 comment)

This change is ready for review=2E

Patchset=
:

PS19: 
I want to get started on fixing these issues, so moving this to "=
Ready for Review"



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1186?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Iecf502ec811e99c56647b2d45298fa0fb66960fb
Gerrit-Change-Number: 1186
Gerri=
t-PatchSet: 19
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 09 Nov 2026 21:=
45:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--MyEhO6jWA0Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Frank Lichtenheld=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #19:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I want to get started on fix=
ing these issues, so moving this to &quot;Ready for Review&quot;</p></li></=
ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1186?usp=3Demail">change 1186</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1186?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb6696=
0fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1186 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09=
 Nov 2026 21:45:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--MyEhO6jWA0Q=--


--===============3767475951851224280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3767475951851224280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3767475951851224280==--

