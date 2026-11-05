Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35C606EE81
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tu2ky/VV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WvJWaOTy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=APNwEfI7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NPLPBna7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GjkCwzylKeYPMWMp05Q04Rjo7d8QL+oxc2ODCm5pjn4=; b=Tu2ky/VV2ZptTQwBmwQYJsRLNk
	zAVHr6igKO6AVgltgnhxHFFSeImbv5exRNWO/utLdZtJfMY0Tl5KaMwM0JZkf8r5Bxb6liGkh6e5a
	yw779sDGEXUNG6Pw1B6y/lL5aL8OjzrS95lMgh8nihJ8Q59CbQmmdm+ouf1yKi5JFtLE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0b1-0000000051V-38p9;
	Thu, 05 Nov 2026 16:45:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0b0-0000000051O-2pkF
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VQQMQZ9dlT1T+BlmhEdamHW0Q+1m5XiK3NdgB72FaCA=; b=WvJWaOTyO2IZApYV7P4ctc9f6c
 aUR8Sw2vbVdYLGbl8Jdw5Ojom33rG0POExRL1W9s4Ci02zc9sbGrjP0fhYUICM48SjV7UNMQUQetX
 XDRpihH3qoW8mNtz/BJJvI9uiWhSHBI7kmvAcoP3PO4FIUqVkEJnrZlpFNlqgg1BQgh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VQQMQZ9dlT1T+BlmhEdamHW0Q+1m5XiK3NdgB72FaCA=; b=APNwEfI7AbTFosExhoBGZvXzYb
 WJ5KXxQEKgy2RK1ZX2+VD/JZTsZvwxzsuDxHbVOupw7UzhDxNIGUEhAt/hGr6a0QyzkniRMae7OMZ
 Nyr+jpNj2lJx3b1j7v0Kj/MZUCGfubozF2awkP8xlInRILBcdn2ANZ/a1ME5AH31ddNk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0ax-000000001dR-2tEo for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:45:50 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1321799f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793897141; x=1794501941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VQQMQZ9dlT1T+BlmhEdamHW0Q+1m5XiK3NdgB72FaCA=;
 b=NPLPBna7juYgA3WTmyMc7cwp79oZZLic69IAW+7QfToBeDwZJzWowXwetRM4AyWkUB
 HphDyfyLrd8RBlODGSDpqZGUvWtPew/31R5w3FTqogrldDTC69QKutvUI7PV33bWdeyy
 BxEL4cXjVFlxfdvA0ExQcs3FSaaLvmu8BuXs/qmc9dyk69O0xsZ4LeqSy028lGtCCoy/
 irmIq1QeS98qzWKQIL8AZ8J8PcFfxAA8OzfEz4yiVN68PdATfa88M+kIqOKP6rP+xZgp
 sbxZzowlLUZQp478PpxKgUPD3+oPRbMFPyMnmefwDdYwlDlOdpUDAuECZtZwe1Pax8r2
 ww7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897141; x=1794501941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VQQMQZ9dlT1T+BlmhEdamHW0Q+1m5XiK3NdgB72FaCA=;
 b=DQgFT8Vhggy7y45VQvZNSi4Za5BkOEZLIQPqJ24xnpHyHnXpnCKbrywhKWAF+35FDU
 5cS+cNBHV1npr0KtVtZg3QvQ+UYS7O77jOJbT7ebo/E4xXKANX3l7LNjnaMeiHse8/U9
 hKUPzHE4gXZHgTWHVHsQl9BfyAtv0ANaK8KuW109yP/5j6bzRFNPmCIH4rsYLamwqfUO
 r3q/KQx24KYX94UM8mbxzN88lEhhWBUn75DxohQHeoFvcTnYxNkldK08lSyQAxsQyjhb
 fPDipuRRUHuRMZEDno8E/dHZIpslFkWEwTFdik8CwhZ6K71iki9vvL0aDwg4c1xJtDo5
 jdJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKp3uLv4knUzwCrx5RcCxGsc4S3kRt/j0aOe15gCX9jDokBgpuXyK05N1DM1xExUBx6KeIbBvWR1Qq0BRf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8IvhksXd0AI6A66M85D3PlwEa7BLRXVobSaIf6SGpSVQV+JP+2
 caSIS30idhyJkvTswM9iNUPnxkn6Y8gTj8cJrmMYyL6w82G7Bb0gVN0N9ozzzUc6AVU0wFuz4ES
 zDPJr77sbYX3YoA/cd5Iqj/XUEWS7O7SCm3A7WiDECM7eWedQeQgJSkNxihviBc8m3OxyVoq3oV
 U81KGexg==
X-Gm-Gg: AYBFou1wLhyhlO13g3RPOOQnh+TFMYUzCi8hZk9zv/T5ZdtAlWDaxcGmnKZKy3u29E1
 aC/MdRjciA9uhvoGjWtsqDB4s8u4G9OhxSwEDlue2N40QT55pGbc5sHgmS9vab238jhGZVc6Wjg
 95JeqxRhzOeEXFEsby6hDZ/u2f5JVuJxS85Vi2Q+hKPvKOaWq4Ivn3wO3Eyq/WGskyQpMUeO5xs
 oHTbkCKSjDvrvuCExMGpBs4uOBrOXVP0hDBjyK/cMCvc/Vq4Ji9pXmmte7Q2eZugi+8H8TzS7tQ
 apFvmvNtefou9bSDiL5CeKrw8QS93yE5Gu68zaCqIUwknfeu+BdHkEpJ8qQ2mOsWAO/xQnHJnKP
 YyY6W3lMhzaANC7q6ilwlzRzUUDoeDBsO97fgZZO75FYoYTUi46NiP58+Oo+aNw1zalkji4TnbV
 7S3jSA9+Aa6YDimvBShZuOvITd48PvUQV/FbCrQOlxdsZ9b6otVYUWX02/g7xFNCxM5qtqZyjLy
 d8g7X6d3oaFxx9jRzpAy8nTN5ydXpc2fgH/H9224z7lu0g7zvNDGvJ0X6f1GaokI1DLJBBJx6mH
 /K/KGjH9fnngUhcH5owPzZeI+HV0caq6/fhGRuPyUSZs+KUFvqEOt88AWO8BEI/pJZ4Rf2oQ61C
 zX+L4MdrJgUtd6UEA6Rf5e5q8hp+UilJW8YrFdts70kd4VAvfgucGqgbHwliehVxaTMPCcrgh3g
 b0VERX9nw3mIlz8RcAncMC/WNnH9tyevBY1xs=
X-Received: by 2002:a05:6000:470e:b0:492:20e0:f666 with SMTP id
 ffacd0b85a97d-492707c3b8cmr483336f8f.0.1793897140856; 
 Thu, 05 Nov 2026 08:45:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea18104bsm11448676f8f.6.2026.11.05.08.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:45:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 16:45:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 3d760aa23b004c8e6b95875d7d76209bcf129a19
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 16:45:38 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c34cdcadecd21ba98f8e9ab3046142501ccf59cc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0ax-000000001dR-2tEo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3071879171492643986=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3071879171492643986==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EIaE+/PaO8w="; charset=UTF-8

--EIaE+/PaO8w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:=
 Code-Review-1

(2 comments)

File src/openvpn/acc=2Eh:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2130/comment/8caf0242_92628aaa?usp=3Demail :
PS4, =
Line 34: #define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
`log_acc_mess=
age()` sends messages through `msg()` which formats them into buffers of `E=
RR_BUF_SIZE` which is currently `1280`=2E

`ACC_MAX_MSG_LEN` is now `1920` =
so bigger than what can be delivered=2E

Not sure if we want to fix that=2E=



File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
30/comment/0478a2e2_94f4f011?usp=3Demail :
PS4, Line 2403:         notify_c=
lient_acc_protocols(multi);
This seems to be sent out regardless of whether=
 negotiation worked or not=2E

Would it be acceptable to send it in `determ=
ine_common_acc_protocols()` after `after acc_negotiated_protocols` is set, =
when `when multi->opt=2Emode !=3D MODE_SERVER`?



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Ge=
rrit-Change-Number: 2130
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 05 Nov 2026 =
16:45:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--EIaE+/PaO8w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 4:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">Vie=
w Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Eh:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2130/comment/8caf0242_92628aaa?usp=3Demail">Patch S=
et #4, Line 34:</a> <code style=3D"font-family:monospace,monospace">#define=
 ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">`log_acc_message()=
` sends messages through `msg()` which formats them into buffers of `ERR_BU=
F_SIZE` which is currently `1280`=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">`ACC_MAX_MSG_LEN` is now `1920` so=
 bigger than what can be delivered=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Not sure if we want to fix that=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/0478a2e2_94f4f011?u=
sp=3Demail">Patch Set #4, Line 2403:</a> <code style=3D"font-family:monospa=
ce,monospace">        notify_client_acc_protocols(multi);</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This s=
eems to be sent out regardless of whether negotiation worked or not=2E</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Would it be acceptable to send it in `determine_common_acc_protocols()` aft=
er `after acc_negotiated_protocols` is set, when `when multi-&gt;opt=2Emode=
 !=3D MODE_SERVER`?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2130</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a268=
fc602e916bf54853c950761977cf3d7f835 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2130 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 05 Nov 2026 16:45:38 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--EIaE+/PaO8w=--


--===============3071879171492643986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3071879171492643986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3071879171492643986==--

