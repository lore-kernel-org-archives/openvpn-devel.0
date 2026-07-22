Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308DBC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VyjvJI04hDHOHyd3C3GEj4wXEvkL+TTTpwWnqpPXeGg=; b=HrGMo0oPy0QablzTfj4p1yNxr3
	kck7VBMI6vwBkTq5vMKvnPEUbJ2ZuoUw6G6VkT5wCj9cWxFEGRiCqvcO+nO+ik6E8YjQ9cEqF3niF
	Y82t4PdP1JWKcX+mARvSCCmMljceFTyCpRaUOmBrmmsKcK8seZfnU6Mk0s7gqHv4SIbk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmVxw-0006kx-DT;
	Wed, 22 Jul 2026 12:22:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmVxu-0006kq-Oj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bQCCneN+OlR1GQE2/JrKnqDa4h/9FPlxFBHEEMfuSpI=; b=GoGTovKuehI0efgX4posuNGwcD
 /lPv7vibcCN/SL/z3yKaE/15Mc1TyHLd7i1ZY3jEiwpP87+IqwfDHw6eAj4WJPrmir9X4LV1TLJmK
 2vTV4NFXevl4TWV+jxPtqwbeewYt5s47mMwHj71EFMzxvK3cVqehYvh/0loyYDMs7CZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bQCCneN+OlR1GQE2/JrKnqDa4h/9FPlxFBHEEMfuSpI=; b=d
 /xBizWtudaVKH7b4LL6/1W7WJsasf4BOdVD5a/KmJgYJ8SSHZdv1Q47gmQnDfsZCC4q99w7HU7ykH
 4zvgspMtyI+960M3OavXDCM5NFnnXFYcmdOUZ2KB1blEdKlILabUwNyQcCgWUMRa3HOT/M+ZTu9+U
 fKhJ/Ie2JQsnMOGU=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmVxr-0004Jd-7A for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:22:22 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so6624522f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784722933; x=1785327733; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bQCCneN+OlR1GQE2/JrKnqDa4h/9FPlxFBHEEMfuSpI=;
 b=GkPTAgDHtEt7QfznZQdxTHoBXjbLITOcAdQJmN4u/KjTEa/IW7nxqeo92dZkkwVNeD
 cZQGYFerYm7FKs+J5NGZNKXk5JiSKzGYV31FHGteN5x8J8urpHvSX3MbQExYoYzf2pHG
 faQijXHLYJB3OmYlxl6xJ1pMGdt9ZO9U5Ar21xQp65BUwT2vwnnQ2ZZ9xK8QGV0KuGxz
 Sv5p8SZ2K1naGlmfqHiQXNWmypb3/1FtAB6KQw/0/pyjeaWSDkgFpK32aUx1KZhynAmX
 onVyVfmlPvuMDJDiREm9CvrNske+hlWs5tbMNVb65LvMvKXMZrCsgrrjXjDE24l1EEsT
 yqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722933; x=1785327733;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bQCCneN+OlR1GQE2/JrKnqDa4h/9FPlxFBHEEMfuSpI=;
 b=TbIU81xwPVYsDA4RzpDHgIgf9cUCe9NwH0D4LqN2EZtTI1tpwaDr7JBhBVoKN1kPq/
 Myexw1BhUWS657Hz2js+8yZonVpzq9QcnAEUC9c36nAIy2y9WucudIXYu5LyhtHj96go
 7HgzscXyqSu1Kpf8c9RbMkgsLsxDLl5PnwmlNTOHuDsuHY6rtieXyPG2QmZJT9I8GPaF
 X3rfSXkYg9Y7SxWeO/bSXIgcj/WtOo3ntgGf3QarD1q4HaMVGNm899+J7RxukGm0H05y
 ZBqh9aPsQeBpKxSNlmUdSBj3oCAhQADsPY/F0JASa8UxpwhU+2r3rC3YS9ENiVSMYpMj
 sWlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe5y/gthZ200raHrCIeJz5R5Q8aAAM1jEVQa/2qdxpCd77iqHngnSx3VPbggg/F2LLR0PMT/faaDfKSQDd@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwhQ7KDXxx9C282UFrX0QCwjYw7zt4XkZRwMM23fC4Ka8TN/TTZ
 ZX8RrV8Ml1L1s/vhxup0B2md+8nmRmKbVfRBimUCyV3axHuq98C28ABKUiGtG4u23Va9UaI6uAn
 CjohRDmMVKHBzgvPJPDW2aEcySoWBtH/sq8Dpo+N3AM27tfeKV3xjtlX2al39CmBfho0c
X-Gm-Gg: AR+sD13l5cqdkpon8oy1JnGupk8RT60yGcc4MMZowFlOOU6XCWMZX6ehnFmFl2AWfOb
 mKyp59ImggiwTO0lVaQsyly+uF0b08c+jVXf1InZU0D8jzFn0wkGa6/qPg9/3VZB8mjwxf4zi3T
 hWFJgD5dF7kN9Qchwh/GZ3Yi3f62ApY3u7douKHvVXuWY/bTaqe+fNXvlglZd3lCtoD5XQisnBq
 NgFirJnaaZJCN8PUm4vHmk3bSj/d0D1YXUKIJLjLbsObVwz7PU/nCUL5L6DoPB7sVGwrmwBzhNE
 D/G0yfBHp18HQvOtE9eszp6TG1IQYDyWBXYaqJFbXohLNWdbGEdtEJ6HRDYbA3QUSD5c/JbpxIe
 pLEgqWFbI/9y19uU4k0jfDOUBQaCBaDdDTSe/wA32r1StbvYTTiUv+qRTdUgQdr2L8nAEGxJlF4
 Hq7Eck9gjIOp5YFq/e/viTByIK8wRi3WpwO9ApZ1RnzYg4SwT5csy1KnCdB38kQSN23GmGLo/4v
 kXyaO16ZlS3TGL9FKj+/zAEOvZKrqCAFGL2uJskid31ALtpDIwALw47EosqBZ5kaW2qFlW6yGEn
 /+o=
X-Received: by 2002:a5d:5f0a:0:b0:477:6874:542c with SMTP id
 ffacd0b85a97d-47f6230c34dmr29245589f8f.22.1784722932440; 
 Wed, 22 Jul 2026 05:22:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm5531691f8f.5.2026.07.22.05.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:22:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 12:22:10 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 1ec92ed73b843478ad10411fc63aa76cc3f1b3a8
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 12:22:10 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57793852f82725ff019abd9998fa261d9e8e734f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmVxr-0004Jd-7A
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 option for Mbed TLS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4325577726841935863=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4325577726841935863==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BsDg6GSlAY8="; charset=UTF-8

--BsDg6GSlAY8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

cron2 has posted comments on=
 this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?us=
p=3Demail )

Change subject: Remove --providers option for Mbed TLS
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review-1

(1 comment)

Patchset:

PS1: 
what Arne said=2E=2E=2E at least fo=
r some of my t_client configs, I have to use `--providers` to deal with Ope=
nSSL oddities, and it would break mbedTLS builds=2E=2E=2E so "ignore, but t=
ell users about it" would be easier for me=2E



-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Gerrit=
-Change-Number: 1799
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-filling=
er=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Comment-Date: Wed, 22 Jul 2026 12:22:10 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--BsDg6GSlAY8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Patch set 1:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1799?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">what Arne said=2E=2E=2E at least for some =
of my t_client configs, I have to use `--providers` to deal with OpenSSL od=
dities, and it would break mbedTLS builds=2E=2E=2E so &quot;ignore, but tel=
l users about it&quot; would be easier for me=2E</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?us=
p=3Demail">change 1799</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1799?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1799 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 12:22:10 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--BsDg6GSlAY8=--


--===============4325577726841935863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4325577726841935863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4325577726841935863==--

