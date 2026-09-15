Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21211C88E7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPZy0YwTkAw1fV4MaGAuuo8gpH0xdyWJs0jU6zkuCeg=; b=M1e+0dov+wTU78PeLGoyuPun5x
	61udb9ESpuifE7xTEQZuomlzi4ldVl3cMKU5fKogRi7L4XOk4xBmVgFgw7EEDcXcJTJWv4rVkih/s
	O8qXVcPnf4PYgPDNwzakQI4LC7ANtsreejwe9CfpJTLhIWvb2U9ZD7ZG+f+rbb/0MnW0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6WJI-0004Jl-3y;
	Tue, 15 Sep 2026 16:47:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6WJG-0004Jf-HE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:47:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NLzC4zCQi9zMoiYM1EofKhwqPQjB5BlVbMQPu8K3xaw=; b=V4sh0/nvoPgCnePfkHmAMV48kK
 9WZMUEpq8GveEo3wqTQB7erFGhnzwtteoDSYia9GDT7MfITrQPEDhaFrMYmrImt1wXS9r3WwSv16U
 Ei3NMkn07+hGzOm9o8lsXLocTGrlfkU2BLAVxOYOe2KGNzu5ZR3vJPPoQf1Ll8C5aEVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NLzC4zCQi9zMoiYM1EofKhwqPQjB5BlVbMQPu8K3xaw=; b=a
 X5s282X2mqE4MpS4YinMAyh/3MO+BKNpQvm/qQ0e6Kq26FKyJFwLCEBF8q5dAQ88Oad+/gkcL4eM6
 8BBV8R/iyIaC1r5FLI+0FnNxKjCfQSVdVxnm0H0kXsKom47YQ/LwzEmfMqCf3mBPcc+PgE7ncJMia
 V8ettZUgpr+EwfGA=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6WJF-00064Q-ML for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:47:07 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so1750660f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789490819; x=1790095619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NLzC4zCQi9zMoiYM1EofKhwqPQjB5BlVbMQPu8K3xaw=;
 b=Kuh2HcFFuQ8MWT+dkb6bHa0fRSFT/MejaC1IC5w+JKlyxm0KrggzrxriJJoWt+FZU3
 rYn2fkr2fzfgErUvuuWTlp1/wH5iTl5kIQupewr0nx2YU1Vir6wQmOGC2/dMtbqJH8gX
 ZCPmY7OZR0oxuB7djj7bCXlKF8Q1ZeUf0xAWMCngY32NTw6V0un3x6gc0bVCNtEz/vBv
 ErjQlBXvETU+LLhTz3NJxRYxBqpBJ2aLCp6TzxIgQv12WMEjNt2n8zMBexY0GqwYnNcN
 PHA6KMvnEW34b6kfolyQofaq+/n45Yh7ybCX4jbZgqQ/qPY6F8ZKZ9OBIJggFvpCUB7u
 NwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490819; x=1790095619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NLzC4zCQi9zMoiYM1EofKhwqPQjB5BlVbMQPu8K3xaw=;
 b=xUE4tzf1DfDeFlYbZepDTuqJXj8/ky1V8QJ+NozIlna8pMmAR1mGthdXYC0MdyzrwF
 Z+S13ftnF8XHPVpA0wJdkI0pZ9ChXAyohUuB2tLyf6C4MdP+IDlUodpzpTqdty8A5t51
 Sa43wo8o3HRklTwfgKXdJEvVinFgpWeQIlsdNMNQzCfgZfLj9kv1jfg73pkt2c72+LYu
 78vec+c9u3FacnJlnWrWq3Cl970tFzP0Kq77uxUcdZk/mBl87RMPVNKakmeUnNjpGTbK
 X+siefswMJerZ8dd+VtmhEi8J68JjKQoYH+ncYT6G5D22AhuCXobQXbc9ONv5Hcu8CQw
 iuuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIgN134hNpF4FFa4yTrTtovG9jDMdwB45at20tkm33UdqgpfKjdNpt++PlyTNuNfbPZUDjNxQ4+4aqtDsC@lists.sourceforge.net
X-Gm-Message-State: AFuF++m2/uBC0lMkBxnq3MkVuCtd6whDGrmIBP97U65JkrqLolU840cQ
 yymhb3ervUW/DwkPreA/B0wOaqPw3oiHWtzZ/s0brt4rUfh6IYPSU8Zqw8fGDGwX430ddovbE7i
 K587vyIX1XQLyN+PSkRWvtjZ0ncfWOehM1+gn1YGzk7NUXFCWqcyoydubIcge4P9rSdK4
X-Gm-Gg: AYBFou3eO+H04yRj2paZbCDVd1utcsRxGc/zgRFmJPjuVCdD61WZ+/i4EoEAHwWOcNy
 X6COolAMwlfqoJHIecb0T2v/F2VY0Odn99z36CzHlz/9hIe1/RoVv9e4Zuxpgg4XChWwYvrbWmY
 kXBQe2zhYTSjzHNEAc76vAucGF7ZEfB8zbDT9Z1+eX/JgwWQFu+Cc7ZxsIAAQ0WKhEHDXRQuv9q
 o+Fk5MbC6sr81itPgNfnWY8Zyb51lmrduGEKTlCsMSWnE8r9hbBs6T9iISI3AE+NISHSpVTjHaY
 6v1M6Hrp1xHK/WDTeZgZwUVloehZa4Zgn0J4rgkXQlpUj7VXpVp+vPznVWn+yj5Vaa05ur6kZBA
 siWGVUvOwMfT45OMDb5qE9TOFMUXyb2yMrW7qfqIsHJGSDMgd+Fe5DR5RG5TLa3M1lx8LXeQrsc
 n6pRsPnd578NZFYeag09IrfBQg3csSULBXQ1nkts3iuHymoa/EvczvQvvDEG/4f32jlUl3UbJNp
 ntF6UrOVQpBBRwb/Y+YyLHuy2pabu+JjAe45Djn3shbqY2WlmLUG+WtawbPIIs/eno4B51lBMOW
 cGM39LOBpLYFDMLEr9CG9wCFFZK/oK03bUCEA2wzHYvxB8CJIos5ZF9xCwTJ8A==
X-Received: by 2002:a05:6000:41c3:b0:482:eadd:174a with SMTP id
 ffacd0b85a97d-48702b069c8mr9259040f8f.17.1789490818805; 
 Tue, 15 Sep 2026 09:46:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43542sm258210f8f.32.2026.09.15.09.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:46:58 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 16:46:57 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0999fc1bb083c87bb4acd3e3011d11ad1e55e426
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 16:46:57 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e6a6fda0ec3bdd4e68e165deb1fdb992af25bd6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6WJF-00064Q-ML
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5330605456293558903=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5330605456293558903==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A4UpMnd4aCg="; charset=UTF-8

--A4UpMnd4aCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required action=
 returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10: Code-Review+2


-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cda=
a9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 10
Gerrit-Owner: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Tue, 15 Sep 2026 16:46:57 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--A4UpMnd4aCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 10:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfa=
d090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
0 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 16:=
46:57 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--A4UpMnd4aCg=--


--===============5330605456293558903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5330605456293558903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5330605456293558903==--

