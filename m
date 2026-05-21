Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09611CD4F5E
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vszinNL+DCrfMdcUfRpe+53QwtClWCRxBGhhmv9qGcU=; b=TjNXlyjayaWW2CePzVQ9UqPd0K
	vBuS2V5w7NV1If1IdQ+EbL7sGBGgQfS5UqyzZbsDbg07lz7Z97wEVRmZ/SbfsJQ4EsE5dNCqsntHX
	Z/4NmSI8ScV+5SSmrZTgVzDj0+TcqaCIdaJ3KSOgjAXS0Q5p11MRVB4ETub7qTk2LvIA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ1VW-0005lj-9l;
	Thu, 21 May 2026 11:24:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ1VV-0005lZ-BS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 11:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9vOvX3MhIQ6bZIpzvTMBfGrcM4kI7owiACr9LrBFJK0=; b=TjTDuZVdr/z5qLL/onRIkpamL5
 N7Zm8Paf6KCWMvmUNNVZUARqnBlCeGvAEX3r59IAptZXFIpQt01TOorkjqd7tpT9nG5VfhPfbOrvk
 FzYvlV98Zf8EPGnS3oRksYQB/nsjd32HRE3TwrlCvBTJMkqw4k+jSsaGZipVjSNGYF0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9vOvX3MhIQ6bZIpzvTMBfGrcM4kI7owiACr9LrBFJK0=; b=S
 Dvs2WvXpGjlsSPYBV2W4utlV+SLQ80LOX+aV5Y9CoBFmnTu4cM/OLqqAwGk9BFUDaSwSE9+Jk0xRu
 M7+OrhIu+CY/Qlc89Lxrw6jiBDr1dZD2AhDTKIdiWHxEczmmwIPJGZu5mBfh7ju0cjDAuYn30kcNd
 hXj388YQrbh0FgSE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ1VT-00031L-0b for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 11:24:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso3837476f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779362632; x=1779967432; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vOvX3MhIQ6bZIpzvTMBfGrcM4kI7owiACr9LrBFJK0=;
 b=bAhVCRVU8W2JJUwdvmBP2FoXOhykDnVRfjqpVra4sCnvFgaZxUBxKFP/8PnDGwjM4W
 Od3bMa42DtGZqqqTAiv+R831deVLFoQQlKCcJNjfjTcCu0FVvRMVknLfTjXFQcNyqkaQ
 f5CXUGKh1gzyTXLIco7dwWVVdhblWTzfnVEEZzZvyOE6QtMRZK5FOZh4BKWVC+xHOrQC
 YsIxzhgs+EFUUJmZ5efe0lU/IkSFE8w4VRK/59UR57LvszOhyy5+fx7bo2ynlTYwQN1n
 UA7wytM5Wf2mRt1NcA5T4p8Wd2iwYDnDbtXINS8JmwlqYyP4EDfcpK8apM0AVpJ57ETr
 NypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362632; x=1779967432;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vOvX3MhIQ6bZIpzvTMBfGrcM4kI7owiACr9LrBFJK0=;
 b=bUL4LoqA+ZPRGwIfSHo1/Htg4nmQyJuKPAdAYzt9nN1bayaX1HACtZ34Ozq+XH28zf
 o2+HKF+wxxixR3M+pr47hjgZlVSOIWvpGueGHpVBM3Hai0agvGWvCj86s/j2T+Nvvz0d
 VBcYIfkhOqQ4tv+Y/CTr5+GQrKZRcshATJ4Eb8UdSosP1+ojNJam3c45PGdZ7Z0UF3FN
 lfjCAQHhuapRXRmTHIj/bTzmoMLbM0E5fXUk8wDl/oPH0strzWu2BFs01c96WGzOsNum
 Dm+QkiKV3Nm07eBpB444EkVFPaBZPNd4RyMe0Pxj17/1dkKaDMMBncf7yqdPGxTfYsa1
 J6rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p6ErdFSHoZ/AQhicX+1O9bHbM3K9gk8SGpEYTiTuSdsPMkX22MiEQzvFTL1NjNoasVpguz5Rlj2Pp3c/S@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx0ufmbyH0/0iT8DloIphA+JOQZ1D2pPztmczc8AL179G4N9Wag
 OBWHbkga25q2r5y90RLbPNB4eDYGYmEX3Dtdr2Eny2ogdgfkp3w+XX5NQjfdWe8XY++Jx/9GdeB
 Z1CyZtZJM4B6YvQ0wP+uKd9dukVfagZe7KvZ9Ic522/RP2fgmON5pfuMAfrJtYvMBDHsZGpzVap
 XNUN14Vg==
X-Gm-Gg: Acq92OG3oKv7qEe8L9xlYCooXP+ywJ+/WabDumWyC3eC9G6c+ErCt/DWUFlmp9oKk17
 Yesiq6QO6p4Szzy+eCK+fwDUOazJiOL9s5Rnp/28jSrUZl+sqTDOpgT9tMdWRjObW9jCfgcCU5u
 bZZnOZR5Yh2oIY47MmAEfQuOhQPBQnT1RmLWpO5uAJxD4RXjZdAuEBnf/p/FLRkr9/AKd9F9Kok
 2htlOkqepJcgvE8/s/ItpBPcYI8Nee0bMYwTXER8CIAOdBiWNt4WUHR7wvQjVu2Mi0EfCPmg3w9
 WNHY0p85OOTByxP4Y+7KjfAm3OL53iQbpe3ruMa41Gi7lFwhmabFwQAkmnmFurt3MupvtdyKf+F
 +4skUOayAtM9iPYgQjzIRCItHyFQc9GtIJLgz6Pq7tUElQm7us/bYUCJmjM9GF6jKACroEoZ1qy
 +2poK6foLw2v5HIDGvzE1wZmqBlY84CmoORMYeMAUsEvkEupIATYYyTK2ZEa2iOj/pWd5vYErce
 w4UXt5JH6gufjRu9Re9k4D1DhzrVw7eKkFWhp4bUPETFK/ozUsb/iXyfZmM5eIvlTsc9Z1WTfgt
 yKKpEJTqbD1BjKQB5UPtwETi
X-Received: by 2002:a05:6000:4708:b0:45d:7fdc:2e99 with SMTP id
 ffacd0b85a97d-45ea349d16amr3327311f8f.12.1779362631645; 
 Thu, 21 May 2026 04:23:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92de9asm2101106f8f.17.2026.05.21.04.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:23:51 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 11:23:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 6ba94fe192fc58331f740bae631c15ab08827439
X-Gerrit-Comment-Date: Thu, 21 May 2026 11:23:49 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c1cdf5de9ed4f7562c53afd1f28cb2dabba67cf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ1VT-00031L-0b
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0278926219105901496=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0278926219105901496==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wJsyjoHf1OM="; charset=UTF-8

--wJsyjoHf1OM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove iroute at clie=
nt exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(2 comments)

Commit=
 Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/05fca6cd_=
7ed20462?usp=3Demail :
PS4, Line 28: 
I think it would be helpful to add a =
short comment on why this is a DCO-specific problem=2E It is probably obvio=
us to you since you know how differently the iroutes are implemented in the=
 non-DCO case=2E But I think it would make the patch easier to understand f=
or people less familiar with the code=2E


File src/openvpn/forward=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/04747dd8_aea88847?usp=
=3Demail :
PS4, Line 537:     /* DCO iroutes must be removed now, because t=
he delay introduced by this
You might even consider adding that explanation=
 on why it is DCO-only here in the comment?



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit=
-Change-Number: 1683
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandel=
bit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Ger=
rit-Comment-Date: Thu, 21 May 2026 11:23:49 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--wJsyjoHf1OM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 4:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/co=
mment/05fca6cd_7ed20462?usp=3Demail">Patch Set #4, Line 28:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I think it would be help=
ful to add a short comment on why this is a DCO-specific problem=2E It is p=
robably obvious to you since you know how differently the iroutes are imple=
mented in the non-DCO case=2E But I think it would make the patch easier to=
 understand for people less familiar with the code=2E</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1683/comment/04747dd8_aea88847?usp=3Demail">Patch Set =
#4, Line 537:</a> <code style=3D"font-family:monospace,monospace">    /* DC=
O iroutes must be removed now, because the delay introduced by this</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">You might even consider adding that explanation on why it is DCO-only h=
ere in the comment?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d12=
d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Thu, 21 May 2026 11:23:49 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--wJsyjoHf1OM=--


--===============0278926219105901496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0278926219105901496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0278926219105901496==--

