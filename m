Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6716BC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1GiOpmY0tOkcdOLggCJng6iK+vBlRiBKf0pxx6/grA=; b=XZpMSP+V7R8JcrTNYqsTGtr1mo
	UqdPEnOpH215IpkcqI/vCi+J6LzY19ULh5oMLF/c3oShnEcF2GI6YH44YOVdUNR6eZZFJvlNrcTPV
	arszcW8gA0iLuFB9PvS5aKgszyRwpn5fCmZ1M4jGSTWqaR5OAiThR0lq+D6jXiVJ9SSc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXMj-00035D-EW;
	Mon, 24 Aug 2026 16:17:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyXMh-000356-Uz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:17:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6CNQ42lWBsWzmTg6H8abAI/QuzfoFJ07POVCOsxEoBM=; b=Lv4pwI8N3vEIadHITbMQi9KuPx
 JODv5q6Mij5EPIZUjT2FQUyr0wbBqQOeb+z0FjVPgfZ2xSmdofLcmH1wTLUUNIFJevVfri/zG+K2K
 J0l7ouCUKA5r/PIMHlE0B4ko1iSOovNC6h4SWK6LBgIri+VnaKy+dSAK6rAMqMt6V6jM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6CNQ42lWBsWzmTg6H8abAI/QuzfoFJ07POVCOsxEoBM=; b=a
 5q0XE7PY2ot/8P7gVX3wGKxiGoS54vLSYmJR7jGV6aJujug8V/r8cA16tIh8f/y6hG9prbrzRZ17/
 7z6DExPUSnKF0oYqtYxddh+tH2/oJX7rsbl2u/bJw1Wwdp/nM7qjR2U0jLiRKgJJpQgQ1YGcqMsUx
 NmbYz1HxdDHvFu9I=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyXMh-0001fo-3i for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:17:40 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b2fso5430329a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787588252; x=1788193052; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6CNQ42lWBsWzmTg6H8abAI/QuzfoFJ07POVCOsxEoBM=;
 b=BrPDfPkGKtYehu4tghyF/GHsPJsgCBlbNR3Mv6iXQGpNtz9nJRu+/VzGq3smuhrc9t
 I4jALXxZs706kZwu429/D2nX0/m6qsoVwsvIAL2eheOgaK7I5qEqi4vAfGanxh70hSRX
 KozUiIZRzUe3q8N41/Q0ys+0hXpBPyslY4T3onmk3TTIFHrnTbPDjs4ySUdUOknP8X6J
 Cd/CkdxuTqqveBDW2AS2MoLFhgZu3OWngQSZ1ajOPuDp+R4fd9pPVYHct/8VWU0gyjBp
 qvmF8qKBItrts5K7iqm0Gam4RPWSOhcTPLxoxjjPLJ3psEpmNdrfJAcMspKXJqqzqGVu
 qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588252; x=1788193052;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6CNQ42lWBsWzmTg6H8abAI/QuzfoFJ07POVCOsxEoBM=;
 b=oSToaE5hacvgOqxeI0s0wcf9aQsQlOfjJ5z7qAToJ/opzSyuZiUbQMzQ8MYJPH1U8C
 cnFt6zw4FTZ4SQxAP3ZdoYgNL4H9zAEQmDVcc6J/BJcugZv6oZDk5UpE2hpYZgfERreS
 QWtDePnSvYK3rwi7QEU/hEo9fgAe9IkZeCrYqPEnz8MrjeTy4gxsp5Ba29v2mHWYHs8h
 gU3oUU57IcibbpaSnQKzfhBVqQfWlqcrJl/U3dIrZRWoXSi9KJdQwSyexMarJoo7llZg
 BftAFkM0JzMP3nru4TtJDo+v3fBjX8xpR65BwO6PdaHF4Zd4H4U/pSLsTWchrW4G90ym
 frAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpySDTW65z46rR2Km66s65LsS/ZCvbIjsm8YIgOY+OllWOknqZJ4dnT/fGFhTfZsGcDMdhUzb1nCFGSaJ1L@lists.sourceforge.net
X-Gm-Message-State: AFuF++neMpxtn+E3pUiKlY8avSpJxqkEhqFnf0EMf4vhRUm+ykHieeGH
 Os9qmIxXJnItbiqp/5UJlCJJmcPdyoyGNeQzJyip1kOtVIUjKp3u4N8NWMFnyuZ6upngO41Vbv2
 6rZdNOJrZfFq3mg8Jn2aT39vf44JlHxKm5111NmjRy7QQnhO+d+/LpzFHt/TUfquDQpMpLKN0/P
 cOEhs6Tw==
X-Gm-Gg: AR+sD12hiiBa3YZ8917Hqkr7Pd4VZVc0Ym1X2G8cNeuFlGtSXnItGWegY1tHFvG3FRf
 va47dKuM8/+kQR2RnWZ4Cyh5r36O6CkDWID8MHpSHFyuW4KC/KAsQOEgXylxwZ5mxt0m4ZO0FpT
 BWL49f23TuPyASS9e027q3ozdiOf1gdVJraP/PkHVGNFvXR/1y/85Kpd/YYbr7VUx3LOx9O15fe
 24tRMdmKwbB8e1vNu9S7/dRA9EQpoEBb1KXsQudzFPrrrYP2aznOhW/l995QFUEAlDUizUesFgX
 Ng0RcfunqJdiBa7OXRG6DfAOvL1zXG4rXMpPER/TEyQycvH1YT+JUUrD7EN0fDIvSpciEsmC5km
 JIA6/DUTnWbO/HzY3ZWhRVS4j0dAocZ03H9MUxtKFWPRPj5aYrmRR/Y7Hi08FipFg6rNBaAm6Ps
 /AX502cdk8x/qNL6DoLMrh6LlMQ9B8BMOWnoQQmJYaK9Z00E6lZZNYuJ1qf0wfgnFjV3kimQfBw
 H1xRXC5pkx/MCLOg2KiebeejWUE8xC3l8QlcLFFL0CNCe4rrN1FEDuyN3her5Qu/Jd3ZCkQE16z
 LfO6KCo8kNHUOsceXvf8+JwQK5dAag9F6XVivOYjqIZjhkQpVxw=
X-Received: by 2002:a17:906:fe03:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c246b4af7e1mr3479842666b.23.1787588252379; 
 Mon, 24 Aug 2026 09:17:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1249991366b.10.2026.08.24.09.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:17:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 16:17:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
X-Gerrit-Change-Number: 1866
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1866?usp=email>
X-Gerrit-Commit: f849b0a40256ce97961b9da5ff2ca96626e37a3e
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 16:17:30 +0000
In-Reply-To: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
References: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklhZDEzYzNiZjczZGJlMDczZTUyZWRlNTA0Y2VkN2ZiMmY2YTliNzFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f50f5443daf2388e0ed1d1146c93d5ec2503745-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyXMh-0001fo-3i
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: Remove
 unused functions
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4587779643868739431=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4587779643868739431==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lr2/fEzviyM="; charset=UTF-8

--Lr2/fEzviyM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1866?usp=3Demail )

Change subject: mroute: Remove unus=
ed functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1866?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
Gerrit-Change-Number: =
1866
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Mon, 24 Aug 2026 16:17:30 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--Lr2/fEzviyM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail">change 1866=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad13=
c3bf73dbe073e52ede504ced7fb2f6a9b71d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1866 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 16:=
17:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--Lr2/fEzviyM=--


--===============4587779643868739431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4587779643868739431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4587779643868739431==--

