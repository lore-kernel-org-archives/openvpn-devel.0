Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFB606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wj6pV5Uz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NOkXjOQS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=goKoWLIy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GDI95GuM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=412wSj/FirAJVxS0+ibUjB0atCP/di34JbEwLV5l3Gg=; b=Wj6pV5UzVqQah/J3tjdn4ApF2v
	UrPdugvLevSllHyHuDblIywQpKnMKrCNS3RMO4MrPD70NhXDSWlo0dMnbGryYN0xsKEKqe6bml+gp
	1TpLZHe7BjkS9ZanwIJWIAceDFhhHAtoLYZ0zV8jU0F53Guq8EtcC3xRlF43g7nScOPg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMpTa-000000004EF-3NeB;
	Fri, 30 Oct 2026 16:29:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMpTa-000000004E9-1F0Z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPL6pcrEQcyihksfPrR+i1mSZFYK4P4aeV1Zppu/JUQ=; b=NOkXjOQS+QiJJ7/C6oxP7q7xEv
 OA1oPTWK7mWsYRlc/yo8Nu9YOskCi3G3/PDe5YuhpPRPGZEiXD2+Ry3A0seEuNE0HhZNEZw8CnAA2
 8dmAGhXVFg2cMwxfes59qhisf3ckpI6GMnhrljyaW9CRhG4b6PA6D5RubRLSbnwC8X+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPL6pcrEQcyihksfPrR+i1mSZFYK4P4aeV1Zppu/JUQ=; b=goKoWLIybMG9Ms+kdVS96Ofc5E
 /RPAqMZKNvrCJNYVLF0nN1wsw7pQs42y5BtrIAnwiwEPqCrpZn3jhBq8aWSl05mCZN5rUxyN84k9B
 bS2jz/R3mO1BPC7WoL8Z0m1LGTmEUL32mcNeqZC46dXA7jRNsm9JS7s0O1MEqIyVdyP4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMpTY-000000006bh-2i65 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:29:10 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9152845e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793377742; x=1793982542; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bPL6pcrEQcyihksfPrR+i1mSZFYK4P4aeV1Zppu/JUQ=;
 b=GDI95GuMZiB8rpFsyFhS94SxVYlhXm7YqRsicUXyzi7me9Kee7bnFPyXrVXt6uRvyY
 Ol8AKOC81uvZgRq9n6p6RjCAo8YCF4FtMA3GJtJachJUyIBQOj7IbmijtUWD4eqKdkB3
 P4Z+J/OWNVZengAnCbqy9IRrwdiOaoY699XN+eBoysXh1DwtI3tKwOJZQF/+/Us1jDlY
 HGQGdULtLEKMDXewIjBh2/Y3cPYiKkLl0xtQ8hh/PfDAmgsQRykMPxNNOS3Ep1sCxmv8
 zA+JqpKzzk/QIOD6OYv9Ntc6s8mJyT9u39Fd8JTA71Zy54kwKTTxScWG2rfA7pwoWECx
 M5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377742; x=1793982542;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bPL6pcrEQcyihksfPrR+i1mSZFYK4P4aeV1Zppu/JUQ=;
 b=aSONw28Cct0tcJ25R6Yivxw33p8Y4LMLKKbJwvrWg8R/TG6R9mYE8XA09nQUCBJ8mE
 alaqPzLzD8K4glDQF9iVzgOIqxk9bFmS+hNDCLZfX8b4UcoOff8A65s1KhIKRq61kWom
 xt7pUIIRSo1fgM+RPi8urbhE3k8rh8tp8nyRTiZWe5B6Rvpfm4o+3lugMiBDLFatVPnY
 C5Oq7+tNpo70+vsY8VdVC4CqK5MZajBkf31Ie9KA8MxidCZBfe+OjjYw1G/f2FhAOVKs
 AmQkxt/zbc+zyKou79Dyf99iVhvZzYV7PjUmd/nCi7KdqYsaNK4lS5xVz2MwJaBDqaa6
 /DoA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFwFA2GfQgfpzhCoTfdsQKGZSKcEHQs+edpx+JrcoWrnoC7NgEaR6m7YTPY1nUHP/oJPTZXRg3/HIsVjcl@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLIjNH6MJJT7xXMage5rh54kdIpYFSLcGKPP0HvtYG+6eKQovOH
 pCfYkxbkh+72HUCkN4IdNFd+5kMSe6nkbJvVb1tptGyVDej1aFL4/7e1cM9KkNLz3B9uWLnQVwu
 zU8wiAY9hzV4LgWHGcFx+zAmXEokV5iCZqqQu8EehzBkISjTf2rgvQGE+sZfuJ0Eao4gN8ZwgCh
 pmnpb8bg==
X-Gm-Gg: AYBFou2HR85iC2enBW1KicTt/2hHuvDDXx4E77M17hFOrIawsQIGdpDfcZTz5fcfJmJ
 JBWi/U858aVhfaR8t4nWfYadTMdQjE+CZMoL9mCJUTspVh497NuFfpAVSQ/5WjallRGDor+sq4o
 sJ/LScb/jk5CWVE7D/cOMIWArhRo06b0dcY/Xs9DDbfKrqHjVF0I400AJpKx36ahtPjVSso1MP/
 Emlf213FWluX7n5FHtqQ/LEV0SZ3JXWf1MrZNfxEYl3KV0n5zvS9k0Ea38CzeAzVQ8oWJPuCZey
 5Y1ZNhsMJBrCjwFDaWcz8tQjUGtVcxKpS0e1vo4/RXhF7UCNKz9PkZESr2vGn4fzwcz+avHJHml
 LGBIdITHFokgKln0Z4qqha1dUGcXIML50cAd6lQ730OtXprIcWMeXsOvkbmvrXtHJhcXW+DlM4V
 S5fmS8tEN2AGJWn+8stGirZRiBf8lpfmSflkhVIQVYdxCxEwPg7xBJhEHNg5qh3ikl4bO8aBBai
 h8iXIMj5M79etKQ+YFQIaL5LA1hnncRwTZwFHTAy51vOsLTKtFQV11IoJOsSM7UavJt56YJvj4y
 rZoZLqTOdts3WAWa0I0amCV/tAaSSpCAi7ualmNa/nTI6X1hnhrteBEYLBBUluLypTZWjvcCAA2
 gwtRagOdvHcf5dB7gTEnqJ6kC3cTtx2lhnIIZeyHZK70gFbPyn4ZClkaIYJiiCeHzLQlz9lXSsw
 J+BqrGOGCDWXnLE/w=
X-Received: by 2002:a05:600c:3554:b0:4a2:267:25b3 with SMTP id
 5b1f17b1804b1-4ac18c7461emr67586165e9.35.1793377741884; 
 Fri, 30 Oct 2026 09:29:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm4158956f8f.35.2026.10.30.09.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:29:01 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 16:28:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 5f607a5226a716c1e2b6bde9beb5ee9bc9405e83
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 16:28:58 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4f66eb9039cb42374c47324f85793834ab29406-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMpTY-000000006bh-2i65
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
Content-Type: multipart/mixed; boundary="===============2851159425042881669=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2851159425042881669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ula06Pb6yZk="; charset=UTF-8

--ula06Pb6yZk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, chug=
ly=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arne Schw=
abe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Cha=
nge subject: Implement sending/receiving app custom control protocol messag=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 24: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerri=
t-PatchSet: 24
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charli=
e=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 30 =
Oct 2026 16:28:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ula06Pb6yZk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, chugly=2E </p>
<p>R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E</=
p><p>Patch set 24:<span style=3D"border-radius: 3px; display: inline-block;=
 margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</sp=
an></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3D=
email">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Fri, 30 Oct 2026 16:28:58 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--ula06Pb6yZk=--


--===============2851159425042881669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2851159425042881669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2851159425042881669==--

