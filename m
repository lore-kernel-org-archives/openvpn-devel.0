Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91215C79FB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIVYb6XqMO32BrwbaRVfVCEVFhQREsJROZXBpZTqs/8=; b=iLEbNSL7eRjseFxLeF7v8Pf2mT
	PKOcz1auLBFUBBoZg0438khq0WoQtTHdOQpFE9pPCEMD/bci74JkV/pq8edNNutDl4P7W3oR2Qoag
	PEW9KAiuPrMNcKHXDhItojCcpBZyljr9d5D/sfOmnkxeHRteKrEydh3dk99KI4I2QMcw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Z9B-0002PD-Vi;
	Thu, 10 Sep 2026 07:24:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Z98-0002Oo-Kd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UEbMSnrMuXe19q2JOw/WpQAGnDdfnHqlnkkrGZh+esE=; b=isprs5u9W68b2y3YpbJEwfiZsv
 1h/h7WDoyRRoRVNDgoJs323NgYjMC8en4LdNiwAo5k4AjYTBN2nNBybUZErwKD9jMhBqCbs/jO3RW
 2e3ZCE32KdAgwFPPUUH78kNVcfyQfuM/SQs9qCL3G4oJ4atHg4839e8uQHmxynpWXAkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UEbMSnrMuXe19q2JOw/WpQAGnDdfnHqlnkkrGZh+esE=; b=C
 DTfiRPtoYs69ZqjkaQ5ud2jDO3Nl8m05RON4eZHvv2nRoL/tOc+yq5tIPQmFrMrt9wkr3LyieB7/K
 qCNcmEawSMsG631JFbcYV7hNZtTEXq48UXKayK3agENAMbWddvQurmJRwcKZHeC3SMGL+gbwuJVJs
 Y0et2zb0az7WxmG0=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Z97-0005iu-92 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:24:35 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48434392b02so889194f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789025067; x=1789629867; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UEbMSnrMuXe19q2JOw/WpQAGnDdfnHqlnkkrGZh+esE=;
 b=CUkSsUXyiQZfr0rWRlbdmPpYL2vYAib6MrKbTj1jzoWjCCac1/oeB3VRJU2t26ydUp
 3ZKWgH7lhC1ZBd/C2s/xUFFB7w19NnO/511C7bFkco3Wg7eMetfaWmoeWEGAF6bqcoFB
 qifU1i7KPFZ2FhWrUidZyTj3FG4uDekuMbIVJbsUndYOUnHWnrfgxu+1JGe+i7fMoq7u
 1k1wQ5JkB2wDK2idgpd65DcS/YPC3aCNrVr6b3+u42EnTEnOXHsR2oQXfjR1BUa2JJbq
 J4uifbYcPlGpGPkY87hJ87f1LtznCSPKnyEGYr1h5ypg2vk2p5NN1ETk85MAyPWrWLfA
 SKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025067; x=1789629867;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UEbMSnrMuXe19q2JOw/WpQAGnDdfnHqlnkkrGZh+esE=;
 b=s2281QijY4uIR7RxvegfihMQXWhYG1ZTpEs1qY+wu5bnhTI7Oqz0qzl77KkfG6GKHZ
 /3sP7rt0uHHm3nHNo2Sy445EPuzKgzI9ELm/Bi8eBhP7RMU2tsP3T74UmR98t1y2kelF
 Ccd4hd157HAxZQpTfrchjd5t1q8DQfzwc+wiy9dFINXtwhDJeDMZOSPFA681AJ2y9gOF
 xrTyNTp1UjfMq9DPODoYaSwWViL+NdPJeJYJ0xGiPq1VMS5W+n5+mBDk9qN3Z/DMybXM
 bf/ahaezEslsJ/gAsxCtys+3WkVrWphQ/coNwRSOAuH92CZ4KT3CUkk+9F/uSknEOtfx
 rKwA==
X-Gm-Message-State: AFuF++l4xaoCS8rGWNmkY7G9sxa5+it/xZmkN1NdVIeES2KJ6TFMOjOj
 Q61KJhKI6msdexY+6WUel7IS0vgZBUOhkl9MH1G+mZg6z6eYWKLrLvf2MFc4eiPVK3ctD2eyawJ
 /9lew8Rk7VtgH0QqDww/c7Up7izqpx7TX3NUh8nao8Gz2wSx/gZoZpxheljStKZu88uzkVuwAGR
 OI1d99gw==
X-Gm-Gg: AYBFou1ozdVE06+h0sWIysuckagKdHhNvONABuLI27OgGg0Wy+XcNxCHktjm6SOCses
 Goov79PXBg47KwH9aw1UrfhL90A+JcZM5MMBCVZVCQsJnOveI5x58XFumAiIKPbaEsrIpMJENRU
 3tdmFZqIjmaT/Vj/pdRLp7vtUKFCuJFn4y+TrRYJs07r6GCtV9s7GFvEHPaFIV2kl9YEDAGywRr
 dz0vrxXRs4wpc2Wn7riMmctL5Jh9MLV+6K/BN3xg6k9MQCES9TIeQTfp5qmp2ra1bQkbk1lQ8hi
 aQVSsFpEkonm2cZwADCbXw1HWXr5Rg6czf/ueYa49+PRMcpGMcSOKNgab+xTaR0JUo3xLcywgxC
 oLafmBD+f9XUgARG3blP8TMDgxbrmeMHG+PxOeXuxBnfeSfk6OWh4U+RI7s4GPqs3wCVmz3THzN
 iKnaru2spmcpnUTNyPglQJbrKTrcF3DUk2zCwWoTnJtIgY584miFguKZepbL/zDDH52dk6XDy6x
 hV9rfEpJUhQvfVvQwfswQFRUrIwwC5DEUGmVQlPR8kf3l8P4PQUsrOQoc+5MghE6+zhZdF3+nyf
 c7JYuBsWl4uNtZPYWe8w8kUyb+PqDKT0PpSgx8cfP2UvkD1fCKURYav13c72kw==
X-Received: by 2002:a05:6000:4819:b0:485:ac96:7272 with SMTP id
 ffacd0b85a97d-485c23e492dmr13100931f8f.19.1789025065921; 
 Thu, 10 Sep 2026 00:24:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm52403442f8f.24.2026.09.10.00.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:24:25 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 07:24:22 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: 229883de43903aeac1225a292bb9fe916c256c5f
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 07:24:22 +0000
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f856b20a31fe798b782a4650d19535a8116701ce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Z97-0005iu-92
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Ignore acks for
 packets that cannot be outstanding
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1036403131309763777=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1036403131309763777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LMoqi9RL71g="; charset=UTF-8

--LMoqi9RL71g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

razvanc has posted comments =
on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?=
usp=3Demail )

Change subject: Ignore acks for packets that cannot be outst=
anding
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1909?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-=
Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Gerrit-Change-Number: =
1909
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-D=
ate: Thu, 10 Sep 2026 07:24:22 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--LMoqi9RL71g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Patch set 4:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1909?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail">change 1909</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/=
2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I944478767b52a1=
b9bf6a65373ce0544c69cb1012 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1909 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div=
>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fill=
inger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Th=
u, 10 Sep 2026 07:24:22 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--LMoqi9RL71g=--


--===============1036403131309763777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1036403131309763777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1036403131309763777==--

