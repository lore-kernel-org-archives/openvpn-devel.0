Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AF606D803
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OjRQT9pE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pdc8hDMI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z9pP+wTh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BFVpLy08
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4Z8CK5wms5qIFUlm1fybd5NS2AaG4GCFi4KUE3dlVpM=; b=OjRQT9pEyiXamIKFZHXpbSUB+J
	oBQEFfKOuDA3Gnp2BHrfS8PXI97K32/L2PJ5ZIVRFbQe844xnBKzAoh6d1Bw+5UvnU8k4da7qmrrD
	nzvP6rXlGD0OdVpuJKdrryFWQyi7X4mCT/Craa4di9M8Lzv0gHZ+l4Xl+uT5hXYxktGI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPL4G-0000000065Y-2n4T;
	Fri, 06 Nov 2026 14:37:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPL4F-0000000064x-16uR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CFF+jRCv0aJeHk2zTz5X23G5DPB/xFIwl0XBH8XHP9g=; b=Pdc8hDMILlnojsihT0DzcNNaed
 1ZxJWLKL9BvAP2HF66GKdnbJjX5RhTcNTIKUgWKwmkupCkkN/Ej+2N1KbbzkB98rY1wvX8djx2nmW
 VoDqGNCePaHCKqYvoRuqO4RcRZ/ERCrWji8pRl6PamBL97flbiVukuS68AihoFZ5Utjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CFF+jRCv0aJeHk2zTz5X23G5DPB/xFIwl0XBH8XHP9g=; b=Z9pP+wTh1+Bzoyvy71Yvycrr9+
 fxE9EjkWEEV7SM9Yqef+XMdQP+JbEQGOvrlhZ0wm/Ck0BG/odFiNM6erx9W4qCUo4Be3yt8BRJP2O
 bl4d2QFHLztQYW5aQKrNjX8nJJv0GnqSFmUFSJ+1N6mqG81+qzYGZ4yybVwZIScROuB4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPL46-000000004up-1tn7 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:37:18 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so6816465e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793975828; x=1794580628; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CFF+jRCv0aJeHk2zTz5X23G5DPB/xFIwl0XBH8XHP9g=;
 b=BFVpLy08OaVKagq1KrFPbhC7VSaNFDvuepyt7tVL8tAOPJr/aa1F7ptaRJerUJ5pII
 sGNV92TRTQa9DdLaCWx0l64qmN8tweXn7O7n5HFHV7hSwKFOnHfqZ6XzmK1H7g1J67Wx
 tX9ykGnxoEsgJrepn+uabct0O9c0kH4ZQNEXCs069ISyB64dgIlg8nxhBV+BVccfGYff
 Is9H508MYnFqZFdkaNAgtB4YNeueSPHNDQ0Mdkb/1z1TR9etgkLv8PLjTcgBwNTFkmPO
 bKISO/ViR7nqnIP+Gs87IP9o5rUC3gdJUvG7Nl1mEtZW+1Ohcqzy7ME+iYiycBHFCXS1
 sQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975828; x=1794580628;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CFF+jRCv0aJeHk2zTz5X23G5DPB/xFIwl0XBH8XHP9g=;
 b=HkjzBOjejeaodbgp+UOfGV1p0pPfGhDWhliD2U7gLJTeiOT9DtTKp0x2PDa8utwo/l
 0kO5wJ5cGKbAaW+VQH7lyaIVej6MMzqAn39HpSxShF+f/ILkxKUkd6gdMHiRP1G2FiT3
 HLVl3mJp9LXK7Mc86Vpqm9LlnZc7cNqbM79IrBuf8mwzOwvuyusHAV7sGeXm57yhZb46
 vJblsFlnq8dEI4o5O0+Q5U2p605l2rw/z52GcZNe0wi4SF7J0lE/x701GPbign+zpW4v
 elyRmOyJU/lPrApj9RRLZtMIvvz1fko5C+s3ExIMSdML+TFY+vRrcH/G2WZbWhbxUxWV
 u+Gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOgU6vLPapq0VRJL21JXwZzzqjUAKdsBASQFG0pRblF35TGgHJF9kNOhmS3HLQTEaujSVMuE5JI6A2nX4C@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+0C1mY92T8n42yCKHZi09Dwq8GHuOHQtMeCCW5NdbQK95UGfTJ
 zDsdqvJWH91nSivZW4vi8zQLBg+VZtnXFb+RzPx+CNpH0EOiN96AjYZQwV2Jkx8bBPLD/pfGZX+
 XwxWTtvIElS40Ktx4wt5GhcBH4gPygNVdyr0PzZ2e2knJ3Zn00bz6wttq0bes/2IyHGRxZOTMwa
 oLb91wxg==
X-Gm-Gg: AYBFou3d2flDgOqWP1K8SXe8+zbqB81FAvu+noaM30c0jEe2a/39OPLzOvUXUhxrC4L
 hxYBvuaOA/UNjzFizog9DaztX3/ZTPvZxKjuZ4RaByCLPaADoGXJtDSQ4AQsIs6Mt4EdmTbsGJt
 pyyqoPfn6yxRmjaejYheMetkWF9OUi0SxN4PcjZuig4c2Tet3f9IUxSg/AEKQDWbBRl+kQRjPII
 U4RdBVEvMMitCwzW7fXWaHmUMfaw1yC8oAyfuJ7bKIh4D00XBj22yqhrYVmks1GeGv4WpnlecmL
 IPZo3UmT2loEx0jO6XxXEPaYhgSCBUrylR/3M1LlpoGccyoB6Otx07eibagy9BGkh2LsQM6x0Jz
 bPfh/er3fiqVaZJ42bTtTxFmZnUfKFghN3Ym5K7lDxowpLHX5kU+2VmaOjlPUsIoNgnlDq+xumo
 7aUKl2QD5AV3mtpAo/5yViU310sn3OhAbfZqnSUyiuBI9PAVa0SSId7RZg0JbgYYQXQjDlxf9Fv
 yaDwBeiwuP7MeQwJxtdLI6BRS+sRgVnO8nLvh75bgro9a7yVpQ2DrEda8EvE/+L2iKvi2g2F7tS
 jZm0lmMUy8JQkrrdaPXV+qosXRTpvauO1p+K+To7y3IP1iY9pKxnGzEOd8Hck3oHZhaLVbK+XMc
 raDchdmRW4qhDG2HA+zlxsvcxwodxIA9v4aq5bMCbq6IpewFLBbejtxAHZ2KHk3NhYzvEpzAX6h
 quqiEL7GS5hvxNOA==
X-Received: by 2002:a05:600c:3e0e:b0:4a2:150f:1605 with SMTP id
 5b1f17b1804b1-4b6dfba908bmr50538215e9.24.1793975827714; 
 Fri, 06 Nov 2026 06:37:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b572bba207sm135463165e9.10.2026.11.06.06.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:37:07 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 14:37:06 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
X-Gerrit-Change-Number: 2131
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2131?usp=email>
X-Gerrit-Commit: 32420c1ef430271f1630212b65d50f59b74149d8
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 14:37:06 +0000
In-Reply-To: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk1NzQxMDAwLklmOTAzZGM1ODIzODU4MGVjMDY4MGYyZDRjOTA4YjFmOTQ5YTI3NDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79f9300227da9bca65e3d9c681f1d6e8405852bf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPL46-000000004up-1tn7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6821458244098919033=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6821458244098919033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ojuHJOxzmJk="; charset=UTF-8

--ojuHJOxzmJk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail )

Change subject: route:=
 use setenv_int_i()/setenv_str_i() for indexed route env variables
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If903dc58=
238580ec0680f2d4c908b1f949a27469
Gerrit-Change-Number: 2131
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Comment-Date: Fri, 06 Nov 2026 14:37:06 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--ojuHJOxzmJk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail">change=
 2131</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If903dc58238580ec0680f2d4c908b1f949a27469 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2131 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06=
 Nov 2026 14:37:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--ojuHJOxzmJk=--


--===============6821458244098919033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6821458244098919033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6821458244098919033==--

