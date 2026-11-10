Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7F606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Xhtvafjf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H+jOD8Yu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SD2pX3Cc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PiOj6TiU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=d7u5RTbioqKLtbTskmKAcmudRX7mndPzwCn+jXGhGyE=; b=XhtvafjfOtXUOzCdoUWN/0N2mc
	KfsytLciuuxSDcpm7JQYxNbzNp6PFG8scI8yA997ZvmPxgBqAb8Jw5zziXhszsgJ0M4wTai4ICqH/
	uyzlMjPap84SBNhFva63iFJiTwPZFpAiA7EczcuN0HOV77tULOxahCEWWPwXL/r3cPiI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQl3z-000000002jR-3G5O;
	Tue, 10 Nov 2026 12:34:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQl3y-000000002jL-2Vt2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pVFqSO479G7lRo14nsuYBGgrhb3RYO/6oUjxbA/reUU=; b=H+jOD8Yup0XBPqNDOW1YZ962KF
 FtCdh3N/7nOl6qlZWoVMG6W8vzomz8WPf2ZtPIyTvJ+Bc0+hmTajCC7OJxb74UDIsQOBd9AK9GaHc
 iGp6Z2GmTGTy3lRGbwscn7DZDybdaOMyG+yB/3lfxm3UNafjStj49gDAfD85sOWACslQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pVFqSO479G7lRo14nsuYBGgrhb3RYO/6oUjxbA/reUU=; b=SD2pX3Cczf/fn+gU96xcwdyE9G
 wAIg/4PR0BUBML8rcJLu20QbVzCOqtUR/vxQPREVQdsmutA9EmhUgQfgFmV9xr6xQAJl22MQmFNmY
 ldApfUs5DFZL0OrF+9hSl6d+rrXjP2pgxsRKPmLVc/9QmiPh2m1kRyrM14GnOxGc1d60=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQl3v-000000005lw-3Rqm for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:34:58 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so14803915e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794314089; x=1794918889; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pVFqSO479G7lRo14nsuYBGgrhb3RYO/6oUjxbA/reUU=;
 b=PiOj6TiUxonCmA3+mSbDxoiemJaPg9sNCI/48hiQ8WF16INOKodWJ4JqgLyNsyFp9Y
 BDZzU+e5Fx0blHy4/cS8kG7QmyeD7Gn40rTvdIGkETPXkDcwkxgTYSzCmDSDJX62oRfI
 mHX3RyCjS7hlIMt2i9ayqb/mOnMfnAHLVWNP+VnBg/zOPlbZOLMCdfFruLuG1g9MYgF0
 fdS2bOrDfkbbKjisWV29feHojsMvBS+RcfXGfViXG+a5JzqoM1AVBT9RLV78d3QCgAnX
 HnabcGQABEn6Ymmcad8ktqTHbN56hkIorrGOsdN31BEaOpdryos4ELQXHKPbZrJYy4V2
 anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314089; x=1794918889;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pVFqSO479G7lRo14nsuYBGgrhb3RYO/6oUjxbA/reUU=;
 b=M7Qmbo9OoR7tYNZJZ0N5iSsLlxyW6oAIUURmurHZfqqLvb3jVQiSEoiLtTMn73Qex1
 jgT0TgbaiXanux4pbevYIH5GBkEZpFCFM8tAwM6IT4/RhmsvzN2hOdIctTfOD9OOVh2M
 VfUEeb/oiZNlhOT51xk0PWpE4XpY6nML+7aLOLo2HbDXQ2+JdoRDD5jepRZJHjZEfqSi
 pEbk0UN8wobaVK4zwphu3YbDko/9YK0qmdfzWMz7Vj2CKuWLwphn2dWhdHrZLLP4hKil
 tkwSz6j6cGYZNqtF/Xlg6l2+khwG8YxweTySHf6PIO7maNgFtBXTbkODmqV/w7ubyTWA
 YpMA==
X-Forwarded-Encrypted: i=1;
 AL+hErGC+XWKVvx+WdMm3j4m1rtLnC7YHtw+FC2bj9DUTo42VRuUUGF4ZwCEmthAn/HQctudn3pXxfMLj5/qCgAo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9CqbJnzCYx+kQ38N1OQSI43xZL0kRnSE9iV981PF1w49HEwBnl
 2ok5/2zZw2MQtBf1nT/Ww3uaw8Xump2D8Q5y2P7fED9LNkGmrDjOvkMNFp4VunNx+FzzTkRqNuU
 05Tu+tLKPyo5fCrrDtlzd1+319fXxOro58qYSFo/t5kwiiQbavSnpOn17gPRJ5ljsmj0kMAevkj
 mT77TVnw==
X-Gm-Gg: AYBFou0xsza9gRv32856HKXuEt+uI9Y2oXOZdP7agfWsXHGPXv8Hpc/nz7EvbgFfefT
 6vtJ9RbcdShvfsnayTgiPROuYhFsDZpw8EUZ1tmDF9PrTIlaRxmC4ZWC7ZsRgNIwAj3rrUMZ4+G
 3iExnilddhgHKMljuyFCcmLP+MZufYco6Gt0Bl/Yf6A00al74IhD0a5J3YLLXF4oP8I0rA/ocST
 sVDYyZnGxTyYim56tdsJ7RSYEEjL7NR1Bf6oiGvy21S8+g8QDTRX+CiQffBjchg2Fv6hlE7zZr7
 8VUYptmE8JStXvg4sV2LCoU8zGL5k+QOKXC1UlypqJgg9vl8CyNOzTpyYm62Ey4n2h+UDplPhl/
 Js5HdaAYuaDNNcChKAlnVkXdwPomFunEk/Kvuu3jUVgziwywsmDVlRuo0HPAYm842YqVpOiLBJk
 rZvL5BTKymkP+REw9mA0n7oiEqDlVd4lGP4pHgiK6ZQ8X30KKI2wuG/CCTFoA9yEIcigqjfriub
 VGLHOPTq95LrxkRTk+ImBILt5dGzkW+MHs0Bx6DWGzcCTmnNWjU2wg3msze9lI07sZ6diHaZnsq
 f9qauFwTaLMKwclG2mH8uGLkubFh0dAVgKqRbBaraZGTRgdW2q0Ks0C8hr7SoHdyNVbplmWYT+F
 IvhYx1OaCDuTe2Bg7hxB3p4F9uN1wDCg+U9Y++qoT59YDb4oFjd+/jIO1p3cFaM4qzPXeIKLT6J
 bXrqaq2Y0xQeCpGg8=
X-Received: by 2002:a05:600c:811a:b0:4b7:6b0a:a2f6 with SMTP id
 5b1f17b1804b1-4ba02349500mr39593465e9.21.1794314088969; 
 Tue, 10 Nov 2026 04:34:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0223c41csm62772665e9.14.2026.11.10.04.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:34:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:34:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: 217855e54eaff32ea697e3575533c19afdf1a2c9
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:34:46 +0000
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <481715afad611d10b81f5e5a26cd2b9f9b2c44f1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQl3v-000000005lw-3Rqm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 return type of buf_forward_capacity_total to size_t
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
Content-Type: multipart/mixed; boundary="===============7949735486153926334=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7949735486153926334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/OiR4tHO+jU="; charset=UTF-8

--/OiR4tHO+jU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail )

Change=
 subject: buffer: Change return type of buf_forward_capacity_total to size_=
t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2165?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
Gerrit-Change-Number: 2165
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
Gerrit-Comment-Date: Tue, 10 Nov 2026 12:34:46 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--/OiR4tHO+jU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail">change 2165</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2165?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2165 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 12:34:46 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--/OiR4tHO+jU=--


--===============7949735486153926334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7949735486153926334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7949735486153926334==--

