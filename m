Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D4606A326
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U5qB/DrB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KAOA2P+x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KlU3oaZW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B7K4cry5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMIMZF5wO073Llj6nV9Kkc1HyNciH3buB6w97k+eiqg=; b=U5qB/DrBQgB7TJqxxF9C7xJ609
	ssSZwCxrfM4uqL6ynStFxSgcGuRScyTAN75bz4jxXIjCOEcBef1XItXgzrrFALSzQFUPL1B607Ddj
	Gml+mz7uH/LiqYxxooDqf0Fo/KaDehcAgY5KLHQXOSJ1FhmtJD2v9zUxfwL2pXZZ4Hr8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9fs-0007Zo-8S;
	Tue, 20 Oct 2026 13:14:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ9fq-0007Zh-N7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NYe6CDimEtLjwN6FhT5SX3xU1pbEjFffQMUKBb9K6FI=; b=KAOA2P+xxBcZtwZjC49tNY3QRE
 d0pXJhcYWjnhhj6ANB9k+ps9ZSkulE4FNGrW1Tj0w6qnXNGIScpqn3V6k0JixLCqG8lLi27P05qpO
 1ew+R14cEsCfR4Zz+QnXZH7ihlVZAooC/7mJ7KKzE5WYDbq+ip6Kln4tA1e0fwnjr5HM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NYe6CDimEtLjwN6FhT5SX3xU1pbEjFffQMUKBb9K6FI=; b=K
 lU3oaZWN75vRdkEnGrFoEPulicD6BH4Ye1xLSutiERWG12XJkpzGkmVVD8RCx6S1zNpIqVoZ4HNsj
 imDsKzdWjYaIj511HI02373PjfsdryRx9gsc8m1OQmI8rHGCGdrCqPRk6tENdZq9r1oqasOFE5Vr1
 11/BgmSzAJyyKZAY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ9fn-0004pj-Jg for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:14:36 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so41226695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792502069; x=1793106869; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NYe6CDimEtLjwN6FhT5SX3xU1pbEjFffQMUKBb9K6FI=;
 b=B7K4cry5hre4dPfyxXwy2MekpZ+M1Xo1LPVUNNx2cbN2FULjze/mPfhod7OBZqhEOg
 09ITPt0F9uDoenPV29Rg2+U0IAsU33TTw1iyH2g+0t+UdZC/RiYo9Re05VkKrv/yKOTR
 JnVizb5DkriQOmM7sekU+l30x/Vs/evcDOp2aNmDUUWLgWlfjjJDyuzLNDOVUY1YgU1C
 JZ1wHNl5y900PhtcGcWWJnndYCqeR6eoWCOim9C0zdd98uxCowZ9xzLqTLD9f2lkOnAC
 wGkJtD3am+n40h0iTYWSMgw/lwKU1wpL6VdSYGrkYwO18bKqKr56Y4HwHxypNeXNW4gL
 ekXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792502069; x=1793106869;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NYe6CDimEtLjwN6FhT5SX3xU1pbEjFffQMUKBb9K6FI=;
 b=LvmOzMj9D0IY1PK/R+7OQSRpwIQN7U0YZnCUQuamqF+Nx3tJ0V0K4zCZ2MUMtx1mZ2
 /LbyjZut8HjLI44Tbu6W5F+380XopdOhtp+r1bto4UZlBCHShr+QRDm2onhZ7INo89y7
 wHghq1FKHnqsJeTW5vcKxD9B9fvP3Ysbesg81/vSVRsWFByyzlvvShONp48wtlyBzNJw
 MgglSrk1cWhhBJs1v9OG67fZNm9QwOYb8SNF4VzUNzqpkPfn8laHut6W7yBrAsAKwa9S
 kF+p5vMfJ4UcuWt/BOZbsXlrKls0pwNMtqfWXj/cviN8naKFjdt/H9B2qu/V6hQbU+k8
 3h+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm2mzNRm+Zc61TRio+qHDfmjqJ3wbyCA+ff299clyvYa2/L+fHcEQg7L7fBcfD+xuXAShOx0CGm0QIANtX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIqiZ7M6tEraXn0YVtEey7v0ctrUw+GZvQFyXrqY3t13BYqRd7F
 fodIqaeT/W9/rmwqICZ4tAUlhkfzwLyPVa8Lsz9cgNfIrybpWbqSAKmbLluL/wXVwDBLDMmx3R1
 t1fPFkab4mRL5PugpHc0vMLVIgp4V+Dvv0sjrQh2vzCODE2N1z5aWbo0CTIFznNsFqaZ7
X-Gm-Gg: AYBFou3KUa+2nEfoorWAxCUIxm0BZBiVKq9JcpSXFj6baet+WUdPO0JB7Z/KKZ0r3cO
 oCxfv3TxIjiwYHX79uzXWlGZjeboQiamL5m38i2zZaPkyrpI1WH61OgmHmfkjz0WV705xMCjH0i
 BSyUP1CPzNeiob2FQzJQa+QKJYwb2cR7bBG35YTs5r0tF4l7sne9hZA13XDs+siudKoeYPnNsSW
 yKsIf9eGvsHhWfrTOvd4Uqnb0gSUlidy6ajtmBurZLCC9RyWttiXgwpl1XCFKxoKSLs2+3pmT1R
 2/zzh5QNgxk0V+tlCbtFH3XCjBnjAyA/zgc+tgt9Gh8DusUNGxPW+w5v1FHH4vUDAzO0CX5TKz9
 FZx9CNnSGMlIg/wUMGtiG0R254eOra/oohncz0gHkA4UkRGl9nP59n4tT0QvzSUDmF2DEnj1wqs
 /n3JYpqCGyiYyffU3SODppW7Y6LCyY0+KF6vB1n2aiiJ4KJawhRlU2VmXihWzVep5ohHZJ1jAkI
 45XSR9RT86QG9k+16OmQ2CSDh61U53F7XjPs5UrSqqPwSBxSwItr5//HIq5+k+wl8CoJ7cdoUr1
 yRRel+/dB80+m/JQ6urG2UlTH4/QobL9B/+e+ew9SnBzMV2nCC1XKJKKi6/H
X-Received: by 2002:a05:600d:644e:10b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4a1f72076d1mr27906135e9.24.1792502068558; 
 Tue, 20 Oct 2026 06:14:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cc8e98sm76711425e9.9.2026.10.20.06.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:14:27 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 13:14:26 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
X-Gerrit-Change-Number: 2025
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2025?usp=email>
X-Gerrit-Commit: 930c5b29609edfed0201c4164ef1dfb14403fb26
X-Gerrit-Comment-Date: Tue, 20 Oct 2026 13:14:26 +0000
In-Reply-To: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
References: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAxNzUzMDAwLkliOTk2MTg3NDI5MjlmZDk2NTYyODg0ZDA3MWYzYmVkYzVjYTMwOWU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bce0e98f9c23b5de55c6c7dc0f1bfaf782eb29b4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ9fn-0004pj-Jg
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_pkt: Correct
 comment about which systems use ushort sin_family
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
Content-Type: multipart/mixed; boundary="===============8489590764430228342=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8489590764430228342==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u7vJsuz60G8="; charset=UTF-8

--u7vJsuz60G8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail )

Change=
 subject: test_pkt: Correct comment about which systems use ushort sin_fami=
ly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2025?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ib99618742929fd96562884d071f3bedc5ca309e4
Gerrit-Change-Number: 2025
Gerrit=
-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 20 Oct 2026 13:14:26 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--u7vJsuz60G8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=
=3Demail">change 2025</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2025?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2025 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 20 Oct 2026 13:14:26 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--u7vJsuz60G8=--


--===============8489590764430228342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8489590764430228342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8489590764430228342==--

