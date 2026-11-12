Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEF60A3827
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mIBmJoBH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nPMsabRm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SGf5+WcN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YLGUMh+2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bVMqrfp+T03/j1v9/hpl6enHUapVygnOLchCgoWZMc4=; b=mIBmJoBHuMXJRh6hpQa7jkEP1G
	lXMFJnBbWQaZa7/nvEDOJh8+tr7JVeThDt+oA/hg5Mt6jiUEdH48lpec4/aXS2EeJRLadOJ6XcJaQ
	XYkuI0/1/nj5Wm/U6zIVmILwwrpYaHcojJfx60Vee0XZmYKqqJ0KOyrS3P786CqLXKVI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRWbY-0000000055m-09xm;
	Thu, 12 Nov 2026 15:20:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRWbW-0000000055g-3fNG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kDIxJr8D+ZVha5w+aSNCJy3nd7viisQ5pkDC+JaiZBM=; b=nPMsabRmq4G6D+EnmdoXp4kyBc
 DvwEAevRywLt4ynd6M2GQc1lhOK7hjyPMSe9cJJvfNNDaL+Hsv61U+4i7bVRN0ky3CL0WT8JC4Vwb
 YLGqgnNlgj5tzsH9JBPE3OyqR5owNfkTnOs3iCXfcc8cTvVsbcTenyHhKiobF7RWYY4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kDIxJr8D+ZVha5w+aSNCJy3nd7viisQ5pkDC+JaiZBM=; b=SGf5+WcNMaBG++vtUa0WL2MJFN
 IVmtDKQVRmh8ajae/QZNWAVF/JMnGwIH39n3GWs+lL6UYUoiyFpbpq0Zw+rpLNlgJWd7BkRqG/g+D
 8GwlQtZYIuXlMPYLpjAQSbLpJ7Z9pbmxWZ3W3H3maSzHhjQnk2h6jev4n6K7FkEhAr30=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRWbU-000000000Wk-3Q6z for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:20:46 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so28274525e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794496838; x=1795101638; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDIxJr8D+ZVha5w+aSNCJy3nd7viisQ5pkDC+JaiZBM=;
 b=YLGUMh+23iGtad4qhRl+gbnmsueMIraCWt76okdY7W2bY++JtylnDz39Tsc+5fMBWf
 A+TB3GTx8Ah62y/HrIi7VsKuI3yOU+a4H6YyRBFRASvz5H4VyjouQNdAVOphxE7rffeU
 0IbH5OP9cR99AX1ETqByvj2gvWb+IwVVAC+GP7QQ3gT712phq2rqDwzqY8MUDAbjLEl8
 wLeCDUUqJ71FOBVbmYSXVfitkotKmdmlaa+Y7aoHfxt2Hdo2Jsl/FcODuPSB8Rt8oat5
 NMsV5PMsu6supAhQN+UVncXr18iINU5RdtxpVhZ9D68wD9T18TpnjmO6/BH419OCl/BY
 BW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794496838; x=1795101638;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kDIxJr8D+ZVha5w+aSNCJy3nd7viisQ5pkDC+JaiZBM=;
 b=KJYRj1WJutks9pKV/74wR5xRTLUGXeX6ml7kPmU49LT3TLeDad1h8wqOld8URD2KRo
 8NrajgLS0NEbKlUbkQT7WKpznRsv4y0SG6bEPlq9on7gPgkJ3ZoJHvon9sMiz0EabKtH
 oSljElNy/2Q/Ft7MuFkVkbdRGiJk943f/NNkqBVYxAaS/3Yf96K6xH8H+NX7swxiK41H
 8DLO9zzZ52KkLWL1v8hbzAnyaVTvDWulKY3ktUFmzYEVtUSTbo7OLmhor8u8+WMSpu2r
 JoTMP7OOeGi/6tBi/Qxus7U8ZvE1v2ee2WLhA+Zsu4H7XieIAyia8tIW/Y+JsfpbnMq9
 1BYw==
X-Forwarded-Encrypted: i=1;
 AL+hErEO2JM3tHfISNl34+WM9Jq2YffA/AgVahsMEShDvsKvw/6E7T0eckB2DxUWBO3hKh4PzYIbm+m/7XYhq2Ek@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+3s4FkOQUJH6H5D3XpsUwBGEmL6382MbQs4l+oClAcBARzwPwb
 B60RfCWELoL6IfBUcEyq1kj0hw78yArMpZVfGweVv80gErkc2r37otzTVrh++k3a1Wx2G+VMMST
 +24qF6H45Rrk0WgxI1S0iDPkK2QI7WylGBbv+B4hYIWZmcyIUgdUBHN3fC+k5MXqIbSvAez8C3u
 xpqyQrfg==
X-Gm-Gg: AYBFou1ngxB5/yaDmh0B+HB/8Yq7tFxJzfzD7W90MVIEKt8ORFXXsFTZ2ejHCB3eEzK
 08Vv8U5bINFwbvfbikBI2Z4OQa5IO4ep11Fy5pAtKCc/wyeQvf52U7hi0L2Z7LYGr/fkRUaztHW
 3ICTZvSnq1tfogtEcak5jE5Ov8n8YnPeffPpKP3N5dEasKvhxr9PWzbJjPofCGG1FqJE+J3Fu5V
 MvqlBwIofWCNx2ELtHwPxgSD1vmU4HXKRjwV+nLHa+M07A7bzAhm44keQ8x7WflqRw6gUutob6m
 hT5kPuJUtxklyBas8/jApHum87iEWXToJQmXY3lckT4EjZ9F/HCDbMiyaEPCZynPYfFqKyn1D17
 XncKihFvYL0TdaJzGWGTyGRWRVOprVYf4CKuP966CfLQwQLeAC2X58JjAz7sibp7hH01jpd0fYe
 jar5D706NgnYo9CLYb83wLr/LxBpswtQUEvrZWkaZDddaD5t4sRXcLAwNEz/uL1qaUeAxxHCwzE
 Zjj4VWIlZb8FqJwZR7uHJN/eLPW2YP9dlSt8C9RtR4/znK4WyVxNkKYlt6BemcNwLRbIkCYzRKt
 FUXJfqpZXw8xlIhsPjz9TChiuWDBmdyT8Z8hOzuej9Xz4s/iTpLeJwoc7e0bGIXTebrT0FQR2hs
 4qHlrBLRzmkS6JA4t7of4HESn32u9LIIZpGw3pJGTVqw9W8JgD48Ms140/TigpCJ5eWLlSUC+Ur
 nZjGV0GA8k5qZteEOo7JAisy4kyJBjRxM6fmKY
X-Received: by 2002:a05:600d:82d3:b0:4a2:1612:6367 with SMTP id
 5b1f17b1804b1-4ba09365bb9mr118891275e9.15.1794496837799; 
 Thu, 12 Nov 2026 07:20:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e25e3bfsm76062325e9.7.2026.11.12.07.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:20:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 15:20:35 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: ed3ea74c421347f3da06957ec0ac183b1c74bdf2
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 15:20:35 +0000
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9529651be18a0768f2fc1d2a104a95f273f843ad-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRWbU-000000000Wk-3Q6z
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3528997563649030041=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3528997563649030041==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2WqMjL6JmGc="; charset=UTF-8

--2WqMjL6JmGc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail )

Change=
 subject: Enable -Wsign-conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 19: Code-Review-1

(4 comments)

File src=
/openvpn/buffer=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comme=
nt/4d642f67_cdedf54d?usp=3Demail :
PS19, Line 741: #endif
Is this ever popp=
ed? If it is, I can't find it=2E


File src/openvpn/options=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/90b13b63_fd870ee0?usp=3Demai=
l :
PS19, Line 7981: #pragma GCC diagnostic pop
This covers almost all of t=
he file=2E Also, at first sight I thought it's copy/paste mistake=2E =F0=9F=
=99=82


File src/openvpn/ssl_verify=2Ec:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1186/comment/78bbe36f_b85c843f?usp=3Demail :
PS19, Line 899: #en=
dif
This doesn't appear to be popped anywhere=2E


File src/openvpn/tun=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/8958078c_c5c74c2=
2?usp=3Demail :
PS19, Line 2294: #endif
This doesn't seem to have a corresp=
onding pop=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1186?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec=
f502ec811e99c56647b2d45298fa0fb66960fb
Gerrit-Change-Number: 1186
Gerrit-Pa=
tchSet: 19
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Thu, 12 Nov 2026 15:20:35 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--2WqMjL6JmGc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 19:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demai=
l">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/4d642f67_cdedf54d?usp=3Demail=
">Patch Set #19, Line 741:</a> <code style=3D"font-family:monospace,monospa=
ce">#endif</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Is this ever popped? If it is, I can&#39;t find it=2E=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/90b13b63_fd870ee0?=
usp=3Demail">Patch Set #19, Line 7981:</a> <code style=3D"font-family:monos=
pace,monospace">#pragma GCC diagnostic pop</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">This covers almost al=
l of the file=2E Also, at first sight I thought it&#39;s copy/paste mistake=
=2E =F0=9F=99=82</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/ssl_verify=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment=
/78bbe36f_b85c843f?usp=3Demail">Patch Set #19, Line 899:</a> <code style=3D=
"font-family:monospace,monospace">#endif</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">This doesn&#39;t appear=
 to be popped anywhere=2E</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/tun=2Ec:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comme=
nt/8958078c_c5c74c22?usp=3Demail">Patch Set #19, Line 2294:</a> <code style=
=3D"font-family:monospace,monospace">#endif</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This doesn&#39;t see=
m to have a corresponding pop=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail">chan=
ge 1186</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1186 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Thu, 12 Nov 2026 15:20:35 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: Yes </div>

</body></html>
--2WqMjL6JmGc=--


--===============3528997563649030041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3528997563649030041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3528997563649030041==--

