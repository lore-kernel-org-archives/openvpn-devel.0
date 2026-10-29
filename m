Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBD606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pr4tCQeP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=laILzKm2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fRhOQJyj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IKSQZWO9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5s5WApSXlSMLTFTC0YFJXCztbr2ADSHD4LExEO8ieGI=; b=Pr4tCQePF4tI4hby4eapd8M2a3
	10PUXl3Bd6MHxz+6zXXHTw51mmILSIAlwLPRXtpeo/474mr/Za6r+8J+xorkdcb4ubYCU3MXGKTdZ
	cn/4VLlhzPEe2sBG2spY3ukSn2E1xuN0Un99cHv/j5Lvb5JVv1dV4Qvf88/yAd0bnqBw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMIbN-000000006LY-1vPA;
	Thu, 29 Oct 2026 05:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMIbL-000000006LJ-3PYx
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 05:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X2hO024Fhl+veuyRfhz6fvWNH49LMLIFoiBba2ZWkCQ=; b=laILzKm293ndbyyYhdwuM+B3u5
 2snFqGSf1BZ5TU8Wv8dBe0S/CZdJ4ig9AW0lyEKh7QmOIkonVSBoxWYXK27uPI5WB5sWiZ0QmD3OM
 octEEwBniq1U4zMU736qGkBfHVY2egnjR7Ytv0+vv8zJVkbq2HmK2SF8LTm+EL2q/DVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X2hO024Fhl+veuyRfhz6fvWNH49LMLIFoiBba2ZWkCQ=; b=fRhOQJyjXb+oYxOonu3TX50ixb
 j2y9yRl3mL1zy7JoODjtG1Y+BbXJrzcqQNVbbcOB17xOWAn4b3Xlte3PI14wXMBfOGXpA2x6TL1zm
 lnZbOTDSx4oDQokYdtmepjg/lz4nQgim0Othb89KINvn/7meun3kJExK6xs5axpmudhM=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMIbK-000000005n9-2zqw for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 05:22:59 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so14124825e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793251372; x=1793856172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X2hO024Fhl+veuyRfhz6fvWNH49LMLIFoiBba2ZWkCQ=;
 b=IKSQZWO9ArTcMT6mPAEKL52ZQkjh3M72qhxo2mlolOcK8uiuXJFPWMwj+HX9Im1LhV
 hviabAucSkse3NgwTt+YiAKbey9mRF27E0WDlWq3CHTO5lNhYZo09a3tpbdMmppl5xeH
 AEqBtPQuUc+NXPN7hLys00nDxlULzIz0MOHSdrjJLZ/TFkfllFOSVDVzMvq3ZSsfOynr
 aUGxIE68HIIhoBDcDObOpXfW/08F07/cL7JF0TlZJ8OTSxkwC/SVExCwnXc4pByCaYOq
 ut9Yebg4LRzgA9jptTIe7/Bz4j6R1HIN8GjG1Lxq51K+rEBK088Cl3PpMIO+JteTd4Aw
 v6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793251372; x=1793856172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X2hO024Fhl+veuyRfhz6fvWNH49LMLIFoiBba2ZWkCQ=;
 b=yGF80jhvI6V56VQSGgXklzLO24TSg4XC3EuDhwewcq7Tr+rT9GnIdxEZ3nwP7W7hkM
 NSjRCnzlcovZp2cqhvkvrT9DVZ2oBrjWq/9pgkyB3aC44t3bylv2Bptb1xhaxC2CDAGR
 +Ig2RHUjG7g0wGNxx5erneXFS9fVBBC38Ht5+5alGDofFDHo8u/i8cx3WaWJ6QL7Vnfo
 67YC6nKQ5tSHYcmxAxtLjJGTDcs7dt7dY3IxdLYIjqx0Z4C3iKpaNXdRhitX+cKNrh8U
 X31tqWyNesYht6cVFDAdvpTY5779nPIx6L34NTOJGla7H4KwbBoPzYG5+hXgC5hAwG90
 xTyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAEeLCPdbuKBxdeYVrMrtWPqBvmWPIO3nPimPLueSyEN6Ij5t7ctyH+MrP05ZNcGhH2Qy4vTbVRke6KrSC@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIsduN8v9qnIOrW3H2qkM7JUXPFRDzebq8JIhnw9VHKtUULjq4D
 jLXYpYoiMNxeY+mudC3eBZUrS4V2UBI0l6BwEsvGFV7vHswhhKRrDPjlO8WU/2hfsLUhoopQP5Y
 GusXxHwS0GGUp55yLfjgqw1YfllRylTyQIxEuOkPJd45fTHaoaG9Km45y6JV1Tzp4AlK4
X-Gm-Gg: AYBFou2Y3zyAe56UCMNg4NyM6dc/wva2XnZ0Zsz7K7IqJIyfBInTQ004YtGtbzG+t8z
 pqqgsEefQrSSkSNEY8O3I7HKBmYOtEczwxpOBVojw0ndJ0TtiyY8jNRokSPIvU1CUcR7CWw2785
 I+YFbGsuAVybHpsIfC3O+PNSQOtrkKQGJIwgi6OXHCn/vSgOMcqBJz/KWjESyHVCc/pzf24MIkE
 UrumSxdMjaWjm7YCv+yYdtYUm+A1VvAXCs+wbYzklWNRD9eKqqhkx5NwIvOiYCVyF9N1pN5blvj
 eN8apQ/wk1U37GSWaQf9xipMBg7IKcvh8zE4/6+f1yv1ZKGw+d8y9pz0gaF4t/1BXzzwpdZYOas
 QNoYNJS8MN9aQzAa6EyTv8lDOGXsLRWfybbwindqyUoKW7ma11OwBvnIXmlj87Cnjq5pDqDRbwc
 lhR3Ax2G8vqEUvNdsP5E36nr4C1W6vEMKuGnRLSj2iIte0nMxE3xIZ9puA29Do2B6s/+p1IZJ/4
 iEFXtgIIj779/fVY53qNeM1tTqxmcYYOB3sn9qBKrkpoWMcQWkeR++tVpg4aYVSr+GIjQC/Hvgz
 k7zcfEZvLqUnWzKyrDX5zWWxFEKmCQ06A1BmqtLlizu2mKly6J7ir7tYt2wm9YuqxjzbQ/44zBJ
 wrzLhYLuvRCD/BUgO7X0nIOpV+KyzvUzaSdEm5XW3oYNmapTsgJsUKKrexnBJacS8AZXayR45KL
 ssmmL6YiDN215PYBs=
X-Received: by 2002:a05:600c:8b6d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4a967f8c344mr94515125e9.31.1793251372088; 
 Wed, 28 Oct 2026 22:22:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm60249095e9.4.2026.10.28.22.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 22:22:51 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 05:22:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 01d4f811e40ab07cd36eaf7f554cc118c1ba6501
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 05:22:47 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <558b0ae7cfaa7809ad1556430cbca8beadf7cd35-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMIbK-000000005n9-2zqw
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============3881670277124182503=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3881670277124182503==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JsXSjRJBTRk="; charset=UTF-8

--JsXSjRJBTRk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 21: C=
ode-Review-1

(3 comments)

File src/openvpn/init=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858/comment/c94369e6_7421f666?usp=3Demail :
PS21, =
Line 2755:         notify_client_acc_protocols(multi);
Is it OK that now we=
 seem to be sending `>ACC_PROTOCOL` twice (from `INFO_PRE,ACC:` and again w=
hen `custom-control` arrives in `PUSH_REPLY`)?


File src/openvpn/options=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/1bfc8ce3_995=
3f0fa?usp=3Demail :
PS21, Line 7141:         if (!streq(p[2], "A:6") && !st=
req(p[2], "A:6"))
This is now the same check twice=2E


File src/openvpn/pu=
sh=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/fcfa0336_f=
5d107b7?usp=3Demail :
PS21, Line 227: parse_server_pushed_info_acc(struct c=
ontext *c, struct buffer *buf)
Should this function return early in server =
mode? `INFO`/`INFO_PRE` are dispatched in `parse_incoming_control_channel_c=
ommand()` on the server as well



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Numb=
er: 1858
Gerrit-PatchSet: 21
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly=
 <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 29 Oct 2026 05:22:47 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--JsXSjRJBTRk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 21:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1858/comment/c94369e6_7421f666?usp=3Demail">Patch=
 Set #21, Line 2755:</a> <code style=3D"font-family:monospace,monospace">  =
      notify_client_acc_protocols(multi);</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Is it OK that now we s=
eem to be sending `&gt;ACC_PROTOCOL` twice (from `INFO_PRE,ACC:` and again =
when `custom-control` arrives in `PUSH_REPLY`)?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/1bfc8ce3_9953f0fa?usp=3Demail">Patch Set #2=
1, Line 7141:</a> <code style=3D"font-family:monospace,monospace">        i=
f (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;A:6&quot;))<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">This is now the same check twice=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/fcfa0336_f5d107b7?usp=3Demail">Patch Set #21, Lin=
e 227:</a> <code style=3D"font-family:monospace,monospace">parse_server_pus=
hed_info_acc(struct context *c, struct buffer *buf)</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should this =
function return early in server mode? `INFO`/`INFO_PRE` are dispatched in `=
parse_incoming_control_channel_command()` on the server as well</p></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4=
c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 2=
9 Oct 2026 05:22:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--JsXSjRJBTRk=--


--===============3881670277124182503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3881670277124182503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3881670277124182503==--

