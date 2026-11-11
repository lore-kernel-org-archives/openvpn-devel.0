Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EC607011C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O5X/1Jze;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MOnruyBo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O97PHRrU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fRLU9K4e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R8NlX4D/ehhdKp6d1HBG+Z9OVJT6WJQNYrzzDPhr4n4=; b=O5X/1JzePFC4CNnq5mrnAnokkC
	TDIc0A48CnnG2Vvz7SHq1XoxrAPvDr2qDFt51zzMMZ79ZJ5C+tx8BS6CHKeuY1jKd4Tdkmg7EsN0C
	og4m2vKqw0W9EC39W+kS86+R7Xsw6BdntsjdSZP1W8f2E9wW2+kGhrKK6sBi+o/CM/SI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRCqU-000000001kt-3zoC;
	Wed, 11 Nov 2026 18:14:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRCpw-000000001jN-3Ymr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vezp0YIl9bA0wl9gmZs4WKLWp1+fDr/pnrsLu46CSCc=; b=MOnruyBoNHw0jKoaj9+Eqes4Ux
 UPeqdJwnqxpzWpC05r2Qn6TQ+QHwTwq6uBriA+TBWXpU4r/lBZoBjtmIRm9sKRIBJOvG1w6AtKr72
 ZZxPM65AKWsZwtp1bQxyPxD67ObomB+BzzvCjC6QZUQsAIsKomtyyF+gUZvPhsSHfFi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vezp0YIl9bA0wl9gmZs4WKLWp1+fDr/pnrsLu46CSCc=; b=O97PHRrUkZmtBedvxrNtCapUbJ
 tg7vbl9x5KvhFwIxXjS4R7PYhaalnySjKogwXD2ZVTgD7FX9a+w8oMD4v5hBgS36LDTqMEnjVT8VC
 mgHDBXgYtnV+82nHOE5kZGWnHUEvb81AnVrY3IfjNAoY8wBx0nZvqZ8897VqTgyfWWs4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRCpv-000000007bb-0Jmi for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:14:20 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2357016f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794420852; x=1795025652; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vezp0YIl9bA0wl9gmZs4WKLWp1+fDr/pnrsLu46CSCc=;
 b=fRLU9K4ejzYVlSNE9igh+HxgIFb3L6vlKKS8Yp3atnlAK4N2eMPRqbW+VN1JpYk2g2
 Gl3XIOLYVMOjgHdnbKtmTrs9blEn3FiMWt/+U8k8wFtn3HSZX7yDR7qp8l6LZ4YCedlq
 WM1lRAgIWWKuZtSPPJRmwaJ1Y2KHfsCi2Xiukw2DwxmRGEUOy91YJbk5vI1SRhA/jPam
 Ucp+OT0gb2ZVYgda+Bx6R7nA2cyEgOXVAsXnp0BIp1hEOe2C48hN3h3PtLy8POuos38s
 4+25SuyezU9GQGuyNECMNCXby7XLAJgLTPPCZ7bBY+2cFlJbhdPRTebdHm56Hdr4ZwtO
 WL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420852; x=1795025652;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vezp0YIl9bA0wl9gmZs4WKLWp1+fDr/pnrsLu46CSCc=;
 b=M2aIeC2NePCVyeEWgDyT8zGRDmNLGBRjDPi7DLBsgtDLcTO2AOYINR6YQgChY9AjPa
 IxRCttxnWfS9CyXmDExwd8eALeMhBSJRQMFBDs3jP1ZregueqVxq2oQLIP2VM65Y/kfM
 7l+7nW5DH8Q/8Uqe5uS/BTI7kSr2WU2QIKy426mSCMFuVgJQlybyQrhVrSt5hbiIO5up
 Dd/kOLIP9+N9uazsxqq+A8RyDiKcF8+yZGIiQRPYzX4OocbxEoPRJbB6mnQJN2lyrQM1
 iTaQR3CMPMW3CKop7QOy4ZNhi+jagzIjlYmex+PL2CN/hV93qWg3qU3uum8NHvAAVEJM
 oR8w==
X-Forwarded-Encrypted: i=1;
 AL+hErEb9k+ZJ1kT/iLpEtSxxoCkdphvvZjgvRUBFTxji6HG9ct4fFozhIfNXy4uFSRiUyEl8Cc+/ftZHhv1HNQn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/3MDILktwOH91GQpynDHvvrZ6XQ7wsPZ8QHOlca4o/PGXHVrq1
 lguyGp7BJIsJ2L0SWmzHNjevgCIATjlcdKKwxrNkx0lvxyH2oXQI2eHdhqTtUjFH0jssXCMPpkc
 bD9f+ecml6doRPRj5Lny5bkLO8EPZ318QnOOM9sDMNyY3pGYgDV0/ZG/LAA3iFTnS3rZa
X-Gm-Gg: AYBFou1Dipvw4TVew2rC62Yu5+82yaEbsbm8Hm1GTHabzaeTayVDT0M2PfV7KhhF9Ja
 CnaUp+HWbudfzZUxhcKXLQhNREXkuBqxZv5jgmMWVTaJjddehzuBf1ifcrGv1F6r5lDtMTo4jli
 sHsGiBqrluRaVIMTeeBbQjOJ02fQe++UNe7AdkCyVEPWi79kcSvVHIbIYAfVdjRSjjJeYbCCXQ+
 4dlRgYtZz5u1+cwjiH2gNgWTbU5ZKt5himwXKIua6iKaILEGKsTBL3DE3U2wnawebFh+9AAqNMN
 oqZhcNmFboxmx+jnPa/MhNx372M7qLfEXGGDcAmNVuncIxRWoCZseZeUrYOUu2fIndMCZnw605H
 QpjqxaJCFcuIjB/79HKsyuFQ28WOJ3TSppe5LMt7BXoaxC9fzCkTjodfZUD7uguRCjkuHhQ5qR/
 kvG6PrXuT2bBagFiHG1UeBrQlDhu3bCZpI400RJGIqmzHwaYSmWdhUbsORU1Gg3S+19WBz2mIw4
 MOnRfy5bZSFB0bcd3ILDLE9/m0N1l6DYybicgrCf/EU33Yd6o0P0dEwfVSvIrdG9gYQFx7sZHji
 VOmhjaoqGZNWt2YXLSFMn3WMDYXaTMEywHI4mYGDjgupoMFO8e/IM/sGchjmIAgLEbB0Qxa4II4
 wu/vi1t5vZgijeLqkHKszVhpXMkQoBODB175dhKJN78NR5kZ/RaU64Pmc6sDj2SOyAm9ofO+YOe
 Oz9OYjn5REP/veqdU=
X-Received: by 2002:a05:6000:4b15:b0:48d:c29e:40c3 with SMTP id
 ffacd0b85a97d-499c6bb6913mr5564479f8f.33.1794420852334; 
 Wed, 11 Nov 2026 10:14:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363dffa1sm11829012f8f.39.2026.11.11.10.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:14:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 18:14:10 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 19f2ddf9de29e73f657ea877c51e3418c71ff33d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 18:14:10 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c6865c3551c4ecf41c1472bc1f9e4a75ee35b75-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRCpv-000000007bb-0Jmi
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
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
Content-Type: multipart/mixed; boundary="===============7993443693416870235=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7993443693416870235==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N1mTrtsBDb0="; charset=UTF-8

--N1mTrtsBDb0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 5: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2158?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit=
-PatchSet: 5
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
Gerrit-Comment-Date: Wed, 11 Nov 2026 18:14:10 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--N1mTrtsBDb0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=
=3Demail">change 2158</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2158?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
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
lay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 18:14:10 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--N1mTrtsBDb0=--


--===============7993443693416870235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7993443693416870235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7993443693416870235==--

