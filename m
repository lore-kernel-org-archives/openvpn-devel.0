Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB12606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XUnMIROl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hd/p/dmv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T4/dQwVw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MLrm1LqR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eviU/VSVSsvnaouQroHO08yIosSWVNt0MI++on12Or8=; b=XUnMIROl5GxYw7xXSbZ/szBxiB
	b8v9gabSUTRmG2Z0q2CQ5rY9inC5CR1R6P5AoYnn7m32PZRt6jenTURSNEyWKkfqP5YNnI4a/2YNf
	kENk0Asj4LGNmxcmESsiG3aujKxrC4Qse2vSJlLCGERG3SCbqXK1rWEHsAgsVOR2pCUs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTUU-000000006Fp-2FLS;
	Mon, 23 Nov 2026 12:49:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTU8-000000006FW-06S9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x8jQufE7XdwsoUg4fd8fy4tRsVUfkyiu0YychjJN/5A=; b=hd/p/dmvR8KrJVzs30Vj+gr/6D
 hx07nkKsHTVrCTQP4rxW0A2cZSDMzfkRHeOu/TV81BgxyO16jPAKF4a5xvUp12lr9R7/bKjeGR+EX
 BEJQUMich7fG7EQVs80KOe0Yp2faKxQfWBlyT5rHyErOMa/Izff/iOetdjKGFOJ4Tw24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x8jQufE7XdwsoUg4fd8fy4tRsVUfkyiu0YychjJN/5A=; b=T4/dQwVwz4zMls0N1PHYLWBouj
 d/b6DWfpfSzOdV37PuN0o3dZL6GGOCbO3bVGr3a+AOi4sbPz+cHLWlkt7M9cvp2vbjBxq8643wcjO
 4RTLezXSIuBLKIIW1bl1cEr6MInSd1YsBrqwpVnc4/aEb2BVBOuQaXGKRVEOMP5X6eVg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTU5-0000000019x-0hww for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:49:27 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2370205f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438158; x=1796042958; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x8jQufE7XdwsoUg4fd8fy4tRsVUfkyiu0YychjJN/5A=;
 b=MLrm1LqRbAGY01tn3Tz2NacIztshll8PCpg68ek+0BJL9+0+11hvmoeVbYiJXicFT1
 jilfZxKzPH7zOT1G7xpDf+Rgar7eqhQjgbir+qDr1PodIc4ar5M4mrPaiOciyW2XVh3Q
 IuLFEfL+g73hRLY5CbDCzYTls2vILiiW/Y5nSCRuD7prYZSDdl3G2VDBG9tRNPuDN92I
 JnfTbot2AELt+I4QmGZjWEZbEmttWDgxgKOF0kXitjlG9kru6BxQlc1C0zzam3mbmtk2
 fckJlJ/aGq/NqiKH1yqGwNK6NMis2I72CFUwuM47iwGIRi//KK7p/uRaVQGyrDlvR8jr
 4hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438158; x=1796042958;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x8jQufE7XdwsoUg4fd8fy4tRsVUfkyiu0YychjJN/5A=;
 b=tb7lJ7k1I+WBmO4udHwxqIY8Qjw4lJzDH08Dcdu+NOoch/OYq+uRE/gWdgZrcZ26Ta
 tAp0rQRsXIOF6lb1CtYbD7+QtZuQo6CLSnJctYo3Mt7v2o4Ha72vLoe1En2aQewJjKwD
 Q6G4NUd2pFNmKyKHBDQZnDb7nQ3ryLcbEiFBeX3aOuj8o2imoB4EUOToZt/BfJ6xw0dR
 or6vfTn3JCnzUgCmlboTLlB17MC+IEjTseR5Y8OXwdrgnqtXoTX7tQztH7+eNRog950e
 yQvddT/wZmdBGNMb3ETlU++x663/eXr3Z7JSl3Gmm5Ywt+TpE7vAutKt0A1le5e7Wx2f
 O/Sw==
X-Forwarded-Encrypted: i=1;
 AL+hErGXwqE6UqiBR4XLhk+3+t8eIBp5bnDHbjhETB8Tv0Hio6OjswOoQ86r4Z8xebywuS3Pun3nrtKxqmTo+L/3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z87DIy5NwAvl0vdBfuAmzd4O1qf1vpXsCV9iNJRyvDhl0Py6fRs
 qIduKNBcPX9SwTUxE4k05bAPxqpam/+kzsJv7xWVDg2Y8iU9BNhfS4c2bcWDS4dmtZoK8xScrX0
 zUnrG9rsV0StOYouudjTQQpAueDl9NOscCrZWF91sxrxyQxBJ2RCfB4taPTcjsOHl3t72
X-Gm-Gg: AZFdTZdt6J6Xyew3FiwcmWRnG+5TPuGG9qYecirl2uqNHjD1+9c19naslG/iz4+73uf
 8UftN1GWE18eCn8GxCcmxtWXSXlGkUxRk0RwVO8MFHK5I7+ZV2yx8+oS81lL1sxxAXw+rkbjNui
 0CouUSXBy1azLWbJjklAHBunTuSgESElCTDPjUaww/kBn9J6Lppt4miT5oKTpzj2T07pV044K+c
 at9TOwH3UjFnokH4V/39tI80TjZrgtk55RcSgtApNeGEQf5qxHbZmNKAnx1DIrwl01hqyKFQK26
 +Aapy7Hld9d1TPXYNSPTM7T/8j7LWt2vtC1lpIe1R8Z4oKJvwopZ+1IPW38QA5/zBhA6kMvJM0D
 5OU/Uj+pgCQiF0ld49Fu1y7FTpZVRSomhVr4XfgCUfFHuNiZDXOdeI8lHzaMBZlJYp5TtElic07
 L7GkuT3SV7s7wkx/4htYp1VwbBdDp0VehyXus6JxUt1l+iscdpZ5gOH60TEdOVmXW2mGk/0OdrZ
 CFBFNkBOJZtsSBr02bkKqbMIm5+Mt7OT7T3L3prl/NdE8ejXXUxaKfY5e8CKY+bQSaFsZur6ept
 YmmjvV6pd4qbOas7fA6EzE+uMYn82NjgZ7Cdb7kcP2rsNIfXHw+RsLK4/2/Pb5NZ7fCeVrXf1Wf
 g41hcuQYRVjhTZfPgyKgJ59YzqqIaryfVbFzdeE5S+AhgPyknis/oxg6y1wMJi/Oxjlqzvxqnau
 5muus+jIlpwyXl7A/dYVbmy2dhthpmn4gyNBtY
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id
 ffacd0b85a97d-4abb57f7b6fmr22280622f8f.47.1795438157945; 
 Mon, 23 Nov 2026 04:49:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab9cf005f2sm17968838f8f.45.2026.11.23.04.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:49:17 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 12:49:16 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
X-Gerrit-Change-Number: 2232
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2232?usp=email>
X-Gerrit-Commit: c6ee15ad9c27b777e9be29a2922c851d14a853cc
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 12:49:16 +0000
In-Reply-To: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwOTk0MDAwLkk0OWJjMWZlMGIyYzJhNzFmMmYzNzQ5MWExYjQ0ZDRjYWNjOGE3MDZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fddd258b34aaa5ebed54a060f653066d1ff7c98-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTU5-0000000019x-0hww
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: merge the
 two multiline flatten helpers
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7202530059678395814=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7202530059678395814==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u3gyuZeZq5k="; charset=UTF-8

--u3gyuZeZq5k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail )

Cha=
nge subject: manage: merge the two multiline flatten helpers
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49bc1fe0b2c2a7=
1f2f37491a1b44d4cacc8a706b
Gerrit-Change-Number: 2232
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Mon, 23 Nov 2026 12:49:16 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--u3gyuZeZq5k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?=
usp=3Demail">change 2232</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2232?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2232 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 12:49:16 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--u3gyuZeZq5k=--


--===============7202530059678395814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7202530059678395814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7202530059678395814==--

