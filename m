Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A060606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VVtdzXR5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FP+iTjeW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=as5AytVM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E0tRzo32
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aZ/PjLcOLQbSNpiJZPizPA8qomV+pmQ7I8aFWC9UYpI=; b=VVtdzXR5o6OT0uxW4rif4ykgJ6
	9w7NyCrK7Vdj3C/wXH/cn/Kw7zRphDCsIVuMhp3uizuH4oUpqjn6GHNMCTAapv4pi4b9Gb6b3u/xX
	HXfV9jOc9QB2+0bdaDfoPmV0fgXydbYfyqR4lifGgqysdqRTsrmLNaIFgNphKoMsFSDs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrrD-0000000067V-10ll;
	Mon, 02 Nov 2026 13:13:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrrC-0000000067P-1k2E
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7woRo9eIPPNEBLfNLs8onAADtVEoeE9O36ztiS8sZDg=; b=FP+iTjeWkChbHYdoUTO0yYBMMc
 a/nRlhO0Ayw7azRc0WesdSGL8oTXLRSgy+yNg3wPV7/qVYUKIit4kybJDSYClNJrdXZykhEN6UOB9
 K65bC1tEa6MHPbxu7OFaxR6hEQNT97FbB0kOp/A4dpPxv09D74JjDKyFQzBjLS0yRV3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7woRo9eIPPNEBLfNLs8onAADtVEoeE9O36ztiS8sZDg=; b=as5AytVMgINWEnMYVZrttPcmDM
 m6ntah6FNuwoT6/NBCsgT7KbL3GRiAcZmuVTT1vOlBY4ZzHcI5XjHF5Q4spidrfm2bhBI8ZyDyCar
 sC7nI43AjCb7gg4ENkZg6lPLGeM7ubXklcZAXYLfbOwJRgIz62kMFbQ3vLajadOyRVKU=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrrB-000000007zb-05m7 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:13:50 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so3053344f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625222; x=1794230022; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7woRo9eIPPNEBLfNLs8onAADtVEoeE9O36ztiS8sZDg=;
 b=E0tRzo3220p+mg/hawrwiyhZRwLtQ38NBNFv5aIBAwCEdejwjhRZHTr9B5xHBVDDI1
 9/1SC+3v3HoNbW9q7fHr1MHiH0+kDFzvuEjKPR46Zd2nCMDAHWuxI9CK2THI31+e/e6z
 y1B+PJKvA89tZ0zK5PGUZPnIMIDdkBxDZ/srNqkwtCRQ8MbeyS+gv1RAYgnfGfsr8Mk1
 nYPVj8i6pWwPkR+o2UuHu+KoTBOjFLVC3AOA06ncRESmTzXpMXfucrIkRMUkfjuigP+o
 SV6yGy06swhH7e7txACDblR5WVXSBhBg+8N6x6VZlOw3bd47HaVg1C30sJpQbyZNPGhX
 vR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625222; x=1794230022;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7woRo9eIPPNEBLfNLs8onAADtVEoeE9O36ztiS8sZDg=;
 b=xcmjYGN4+L5ZqcypMYSVJMSX9/e3Oa/6Anh7swIRLMJ1iH3zUOPuefluY0ZS/uJLtB
 M0OueW2rPnrckegVpSVJ5nD/QCkeGAjJQ8TKkY2Xxhu+LpLckJw9qhS9QfgLsYposZCh
 q+e4EPYgm+nNt+RkGoG26sCf8ak9fgyZgloxbgnnOQgRNDxTuwN9FssNpKtb73r1v5id
 XyFXqfGv972XMuXrspfhBvrLNeEiilhKlhEaiG/qb7OTzn3WLrCL3rz0/AP5BtNYnUbo
 TXX+/873ACf2HtISt8hEd5j07ddSXNQOOL7NAmuxe73Ufcv683UA83ba9Kn9/N81r7UP
 nEZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw39yTKtVOxfFgMnCExOWt3tdVSc4C9RHXZOsoNtZd95iWN5VnHsrfzoeTWsFUvKzRv7LzbEncf9j3ZTh3S@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9HXWfs8GzzCzqk3Hmi6y58KhSmZ3Wbl0N1f2WfAQ4jqWzMr6do
 RZWkyK8y4RccijZ0m0kQ2y3E2RwkqlOqNim+e/cfMq9yVPPDD47Vm9OFymvr6TFnzCeRerJEn3p
 hEBWkRxcqfipIXoS3DUuwHkbocYG4tJi0JGs8vmZp+DP1fEsOuDL8S0tH30cvVuWyf6r/
X-Gm-Gg: AYBFou3uRpGPo1yN3sW2Ab/QNIjbNm3Kp5SdeSvoS43a+L7kttUIdlFriqn5rRUpSm6
 gxyT+2pHpeRT0OFPZyzo8UNjueCJUs0B6Fdk+EBkwAGbc+RL6BVyR5UD27DAzmzxRWpGvfBZAg3
 yTIrqALEXNd1xSWJtHX0iTGLbn297Jf0U3mDl2qhSH2nwm1JylPEwx4SwfHw7Puh3f8tb6KDXu3
 tqiHnwdcbAlSHmoX44lhu/TCGbhm/IOrZfezyEDA88D9gF7j6hgcsudoUsAXnuFpWeKI1yVuJ4+
 eiE3wKNB2Y7LVuF55+oSJroKEpS0qmSrEPCgVxWnCcq/Slfu4RhBPNSkp3mdDRIYzMOzZQ/ak6R
 Nv0sVHdolhQt/zJ91Xw6zcA4/w/wVoeWAhsMPc/5+1oPEpwII+COKNkD81lxGHdtCgATu0YDyk+
 JNqWH48Q5hQBmFEXSzZ8DFfA2wntBI5S9Z7muQtR2j1txMTXZ9JguAz4kM42awvg546Qgfrbbid
 UBYK5nmPgMOaYPTPxG+9ZGWeiNzUphUKSEiBoufru18abc/E+LBM9Y602i7EKe3cf2AmCTmO0c2
 c3UX8db+YsH5TwPntLiAg0ajYsOaUg+TK1ZYl9L8PlSavKH5eUNrayDZugQ5FhatDFo/RsgajoS
 wHnEsmH7Tl5PJ38MCPx6sH/VYhhPj+bjo/ecB0nZc+ydJRVdeNjdKnVbXgz1DTMXVGmcFr5raYw
 1RgeKxpnIXnBoX1g==
X-Received: by 2002:a05:6000:2c03:b0:48c:6cdd:ba89 with SMTP id
 ffacd0b85a97d-48e6e4ff80emr20531144f8f.36.1793625222380; 
 Mon, 02 Nov 2026 05:13:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm22111299f8f.39.2026.11.02.05.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:13:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:13:40 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: d1b1dff10d81d0fcfd57a74dbadf2958e025c98c
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:13:40 +0000
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ecb8ecd08a2d147c36f541ed6d9cc0159963f48-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrrB-000000007zb-05m7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1009251224161843818=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1009251224161843818==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Mjazjb+RVE="; charset=UTF-8

--0Mjazjb+RVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Gert Doe=
ring has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_ope=
nssl: Clear PEM decoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: -Code-Review


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61=
ebe2ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 2
Gerrit-Owner: H=
ansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ge=
rrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Hansaem Wi <h=
ansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:13:40 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--0Mjazjb+RVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Gert Doering has =
posted comments on this change by Hansaem Wi=2E</p><p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">change 2077</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b427=
85de99ee1e6b555d8c5e61ebe2ae784510e </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2077 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansae=
mw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@ka=
rger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Mon, 02 Nov 2026 13:13:40 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--0Mjazjb+RVE=--


--===============1009251224161843818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1009251224161843818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1009251224161843818==--

