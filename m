Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E07606A68E
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W7Fy0wox;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WGN5DMiq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y3ey0bbX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HszV/1PE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kY4I7DKB9AdubKncs7r8+DORLRH9OLu5Wq1vg0SZyGc=; b=W7Fy0woxcCcsQGzyGlg3orw3FF
	/Ixux18IAVXWWow1nVLrluNdsZIuP4nXla3uOR73ysnoMV2WZSFbVvyXBMxJYHwO+H0euBrfcSCgm
	JTsKsPSzpnHw/1xRIFoaFu/xJw2YwsF2kEIKMd2AIP9BqqlR6/APjfeo1HQ/kCCdOyNc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUmOU-000000003qD-3WfO;
	Sat, 21 Nov 2026 14:48:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUmOT-000000003q7-3C4F
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:48:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVnO9eph4dHiwtYRPoIkn/ZMXNvU6Xj9ZlIGa+b9JaQ=; b=WGN5DMiqt1Mt9XhPKrfS0rfZ7F
 P2QYQPKFUJc1bXwpO2fK4xr/DeSl65QDMJ2xSKTV4shsUALFQ1gzXvH9vucbrQgC4o/PFtKbN6k5b
 dhF6n1MWZ1spbUPBsuEroW4kn43g5dsBJ27bWVpmMBIjt7oxzLzeIvX0qXi9wKbnBbI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVnO9eph4dHiwtYRPoIkn/ZMXNvU6Xj9ZlIGa+b9JaQ=; b=Y3ey0bbXXKMd5K0DnCNnLY8z9C
 4lBkHAE641S0j5ucqyWC+vu1l+pMkkPPLkJK5ZwSxKOvFJ66VmM7n/kVQBNNNOrlVbT43iDv+oU1v
 HAsBXvRgc2uqWZrqpJYiGMVO2t6U2O45Xv2px2niaDbsCB5G8dOQ2fqrmjgarmMNvm8Y=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUmOS-000000008NE-2nDp for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:48:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so11699675e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795272518; x=1795877318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TVnO9eph4dHiwtYRPoIkn/ZMXNvU6Xj9ZlIGa+b9JaQ=;
 b=HszV/1PEVOwb2w1vHdaJCE511OOkoSseMymjuY2K3sjDHEppLAWw6cIuoACtGPpu1J
 n16WNtsNBL0np7DJrupp6tIgzpq3EqnfraiPm3n3YKCvULyK2cnyFD49y7rz3my957Wo
 OMchi3PM0jT4RI9/sK1L1svuHEknrlGEhElThEdXmeHiMYfzJcp1s1Y6SUaQ5nWDz9Y4
 zxkCH+jNSHAoL08mxio/QWb+T550ENa3QDFsb8eAGY5Ps8Ldo2/qJfWVEAcjJ/bXDJcG
 Jdz38uuEY+5W0x8cIpleAxlT5ZCsdEWtPaKCDoxXCtKeqYrsAhi2PMaAxTJSWO/9qxoQ
 y0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795272518; x=1795877318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TVnO9eph4dHiwtYRPoIkn/ZMXNvU6Xj9ZlIGa+b9JaQ=;
 b=S78UANBFqpyeq6m3k7SuuRnxFiVSiP43vb6RIlw1+sc/kKfmd5BRmmgptwa/BN7ojw
 HqXJ+q3xCJUE0mX1gWx7H62Mrn16tXkekn4iPjTF9a22fWcOqzkJ9vsiiogPLcig8G0f
 HMLfqcMJk3DnygE6dBPFmqGa+pECa5VGAoUsN430JHmJixZutaMi8N22ot91c89poq2U
 Rq9rP6egTIgPxqUSqeBM3I6PmLY16jwqyRhVTynxo/pLOhuWToYh233oBldaz7w1RGbj
 Teey6tO3b++9/IivoGWMFm32fmScsAzi1G16kYBCIVG7XYG9gK7LgfmnSr14LFQXU8Si
 GknQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHdLqr8Elp4T0dYVUrzGFU6L9neIGIDa9E1hyAtDMdC753p1S3oiwb0ArRxVTJJjd1YYQRvPwqolmrSaf9g@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/5MaRZkslIdkVjxlninlV5fuTBXaMQDExIMXP2lRLYUpvKIgUg
 eE72ZkNdApthIEtQbZ0zDM9bbrNq8v5poTMOoKJByb+ME4HGS4XjFLbr1dLuV7xnRl9kNr1n9wd
 r4n4ynmwl9nVe7/ClPJHEK6NKvCRcqUBOdLBBFsRUNWppa7VPj8p6/5tJ0qhiXN7xroVd
X-Gm-Gg: AZFdTZduyjT48VqQRH5WY9FCOvOPbHeJE6bFks90HhR3xgnnvBYhjx+h4DJkfZysH+X
 ZPVYgvUCoIviu6QG+TJ01N+NZK5ZJQAoe7ohSsp1/ntMampfKlzXexjFHLZAy7TG8wlfcBAsSdv
 a4Sgfw+V4GeTMz1Jj+CohJ/vmR/MO4Q9Vlagl2um5depYh855Bl0+dkeTbMARRRrtipaXwCWrbk
 lqMEHPH9tzP4RtQyqpxIqLBEdMKn2jkv6pXPVf3ZtR7oGVMZHm4yEBuAsuut1/O+lXMkED4bMXk
 HxrUpkQYwXvdts/HGd+f6qQ+/Ui7TJjon5KFDLdpS1jQwPzIVoeVBmVHefCqfEGNsxeVooVuSA9
 gMqIpnciFy60OYaG1R89ivm0lbd1sNfQIoFOSGAkSGLkjnv+rXGQwmCWLkPhS4iMWvnU1Adz6PT
 nkD+89jK+ZyKHrx+hoFzK5J3qaX6IMPICvfjXhEAQ4ioDaAP6C4MeU9sFqo51cL1sj7WEGtAe3J
 SWBbvyyNe+43KSAekyIKjwe1lUoHc+RGDtd7M/eCYJRWKUVVOVuQScXnIDXEm9SJl9SqlXcdmom
 fNNR+cPh9IW29kzlY4TMwXTtd83WKhYoJBLlmqpJ40Q0uZbpjZ28ytnkxaRMHThEwjmW248Jm0h
 exsG355MPWCTY2O0wqcxfO56ZjICzekYz5PeWwTCjX/Ysaflfd4HdJ4i2RUdNV0RPYpwGtGvVNV
 UJrZtGrjs/VxEmhvM=
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id
 5b1f17b1804b1-4bb8880f283mr148599345e9.19.1795272517940; 
 Sat, 21 Nov 2026 06:48:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm198846915e9.5.2026.11.21.06.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 06:48:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 14:48:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
X-Gerrit-Change-Number: 2227
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2227?usp=email>
X-Gerrit-Commit: 9ac51f010824b69f8cd6c48cfa9a400f9d777965
X-Gerrit-Comment-Date: Sat, 21 Nov 2026 14:48:36 +0000
In-Reply-To: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
References: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTczMDE3MDAwLkkxZDUxNmIxYWNlZTNlZGMyYTY5YzY3MGQ2MmY0OWUzY2QzNGQ2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abb0d7b56e69caaae2de88be0bfb4bb2ca52bd05-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUmOS-000000008NE-2nDp
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: route:
 initialize the table of block-local routes
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2525859281843652212=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2525859281843652212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BwTIIi/TvF8="; charset=UTF-8

--BwTIIi/TvF8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail )

Change=
 subject: route: initialize the table of block-local routes
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I1d516b1ace=
e3edc2a69c670d62f49e3cd34d6dc7
Gerrit-Change-Number: 2227
Gerrit-PatchSet: =
1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Sat, 21 Nov 2026 14:48:36 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--BwTIIi/TvF8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=
=3Demail">change 2227</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2227?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2227 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Sat, 21 Nov 2026 14:48:36 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--BwTIIi/TvF8=--


--===============2525859281843652212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2525859281843652212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2525859281843652212==--

