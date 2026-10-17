Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA935CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFF3qfHSBhHsH3/fPGN+z1xt2xu3obApkybGXl2FGEc=; b=Jm5ccXXXBkljgMhM4S32lrG035
	fjdjWqDKNjYjA8gbo1r1GTGZkcaGlAQRtrDEhe7QB16+uuP0PnU5U4ylTWmfDTpY3KRUUdCxa3EsC
	kI2KiaSHMr5xaNa3eU8NxS0CWf4sr4RZ+w3q6LP4Uihhi2jYjb2+bfRctYFpEm1SNGyA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIACx-0004ps-KH;
	Sat, 17 Oct 2026 19:36:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIACj-0004pd-CH
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iRWrWXc88Oq32j9NpkdR1Ii1SnTkSGi3F1kUzuMXeYk=; b=H85/DKPdSbu9i1SFSWgltTiuc5
 V+NZ2+K99fcZg0dkVXZqIWldhJlUDCRPN1MElhtn9tLaMrf4zOi0MFJAmXImi0qAurl4XJUnizQuL
 CQML+5tfzU5uppEXqSw8f+2U0DM0aq8cs4obpgZg+cOurxPlQvesRWrim650ujDjZfUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iRWrWXc88Oq32j9NpkdR1Ii1SnTkSGi3F1kUzuMXeYk=; b=Z
 CkkCodvz0lrG8StbkNDcVKV9xWHv+ux49qnmm+YP7JQi+uuR+8bvJ35Cu3yDHT3xWwO4oUeF6rP53
 CUvyS8em0baW8L/BsGxJDVTSqj/biZS33AozjlFbwNOifz8nFmMq/PIZgO7ZQ+pUv56NizN8NEMzr
 pJoUCEU5vyW3mWcw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIACi-00028r-QB for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:36:30 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so532950f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792265782; x=1792870582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iRWrWXc88Oq32j9NpkdR1Ii1SnTkSGi3F1kUzuMXeYk=;
 b=gtqFuMBvoKlMzoyVhHKAwlpn7hNfoVU2bbV2b3KE75DbvSAWafFR93Wrwav7gla3W8
 Z8z3a5ty8WfyX8z+JRVC/V4FHEiaAbPF+hNM8x9lsoTpYzAGjh6tVPstuN9jgVo2XjOo
 JLjV5YpXOE2tLo5dOarL5wSipk4YVP5fBovUXyURyzcYo1qPmUpiWZOvWacoLmAyRRLZ
 eFZFnLoZPtbXWFJ4eBqtt59H2yDV5DByKEmhrvNoHhRW84pJNrHoHaaTSP0oJIC/exT1
 rEx9T0aJn+KGMnhI4IT3pFymm0opxFmvo+ytoaBcIbth/bqVL+vHNu6dW75FaIXN4yZF
 DByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792265782; x=1792870582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iRWrWXc88Oq32j9NpkdR1Ii1SnTkSGi3F1kUzuMXeYk=;
 b=1KQemHiAkZlKpQMou1s0lhHBQMuH8o2Z+115aCFhVC/jZON9g66LXX71hgUdqBzJ3l
 g86/Quz9X+9rBJw6lwv9re4IZ9lVL4DU6Ln85UhzLhVax9lIOmWw4Jdin/q3lubJ/Q1G
 1s5X50vNTdJ91y/34IAJ6E2YO0iPukwjbcxto89ldUKqZsxY375j2XwDZNmMe7jxqZz0
 T0/aSzoNOxStBEBXbz0ST+pug8T+mcifyS8pSEfeT+okefL0dIn+dLCU62oFTowqdmJ/
 QzsywL/8+ADJcUqSVF4eluMt7AKse9A416cc/UlR/f9isq9WUKvU9wQSvC7CXB3E1HOG
 h+fw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA8KeQhyWPTHVttS+sjX8EjWrLh30XdpmDGvMkle/taR4r6fx+45xAFbsNYrPd6Qi0uAvCzQjActcxGbzV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKi0gMFeXB5j+cuJsb+P61gJRmMJE1ek79R8stxiD1D+7lL0wpl
 1JJYMrOVa7HF2TcwTiT5hW8AxAbNsyOPkmXRkc8BDVSuvGIAnBIpnsmTidBth9uz4fD1YjTNWFQ
 Z9u3R5bkqOen6p/Zk2axB4lqDTlAXGjnE688Q+6fliC69f9gFTXbE5NVLO6WDWLpPh5jQ
X-Gm-Gg: AYBFou1bicQxoz3sBR6404zMn33Kiw+eLiBkPzi26pLcLmKUHwDkr3TzhmC3oGEKqrX
 5MC3DqlUMFyCQ1mCU+gzh8mtbSjaFWip1dbY2UP3wZfAQwsiIylRQu6oPJPQrMB899ijbCIIOvk
 q+mKiFTUr2KVjKrTuNH50Pf9FyR6LMSiJC/vtH42pefMTxjjj+goLpMiYAdgGWvjuLC6nf02Mz2
 fFK/KmvIN7ztdWWBwGi48BIAnpe9lGwkjdV0ihqv88a67WJSCNXbbxSThVhZJIuHLqHrjaXvSFT
 9SqpK92sCKM7OEGUnkYvdnj1SkqrqitE5YlqvKWDiGkeQ6CjWC+d/Tnx5F9kmkUHby+Gp8aFxJ9
 8NNqZQlfNaYIFbSEWPDU4+tKRPreHuhRxfptkoEDunQin/CjCYhe5GAU509n3NPV5z8GV64uDlI
 QXxVlnkkls7kWxvXW26wpnr522WBAkGjo/hU3DLOq1ixovrsR/umaYEDMZmSsD8siUTnxMFOm97
 khcMBx+FAT8PAktBEk/wIigfEJwXgo2p7Gp75WxA48zMtX/XIMdPaNFVPDdlcmZlENlUTxqzc8D
 Ah7QoUwoWK9V2AK2NsdQ+wIw7znBMv4hkcAvW+gHAzZDN3rM0ViPAjCMctoo
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id
 ffacd0b85a97d-48e07978bfcmr6894525f8f.7.1792265782068; 
 Sat, 17 Oct 2026 12:36:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5038b8sm12907884f8f.48.2026.10.17.12.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:36:21 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:36:19 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: 27536b037fb0b147d040876515a831b5604f7c10
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:36:19 +0000
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cd1845781f9a7ab810764bc306de323921d8b4d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIACi-00028r-QB
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3137745145763484916=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3137745145763484916==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nMYnRtp/KXY="; charset=UTF-8

--nMYnRtp/KXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail )

Change=
 subject: Factor out address resolve code to a new file resolve=2Ec
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
46?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I12bef330=
e2c8a5e5b21c2fa807584319b2b7101f
Gerrit-Change-Number: 1846
Gerrit-PatchSet=
: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Sat, 17 Oct 2026 19:36:19 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--nMYnRtp/KXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=
=3Demail">change 1846</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1846?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1846 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
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
lay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 19:36:19 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nMYnRtp/KXY=--


--===============3137745145763484916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3137745145763484916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3137745145763484916==--

