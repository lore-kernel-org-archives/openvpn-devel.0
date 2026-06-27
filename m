Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B1FC43458
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i5acgcoxuQXKYTaKw0fQq5r4b2AnugFuiLiknILZ1Tg=; b=Mb4s5Pjbl4l4d4CM4ZsNjr7ysC
	A1qTfWpX3cTD/L3vzyx+CgpJnvNOtTtmAD6EyOOuqEl7EyKArg1MAZ5vuiB5ayADKm2f5NzBIToZv
	oXMfqMKe37gpYRIET5oHiw88G7Xs/Zt5ljsyrZ/c8TkV3OxE2342aEFTWaDZf32qK66k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdb4p-0002Ju-QM;
	Sat, 27 Jun 2026 22:00:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdb4f-0002Ji-4w
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 22:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m8QMWZXF23JZcJj7dYzowkncoyFZ18VOjCsfPwKZzQE=; b=kc9Jz00FgYkOs+SmIPKLWYgYYC
 PTUpsThiaVomCGQjSSKovW7cdHL8OLJQ+l7xL+ANU0SsdNg0awCl0qZ8tHc8F0Uwm0XD4dt0HvZDg
 G39CbImjkbG5PG05qhOuRKZIeXXBruQdd1k56kgO0M/6GbU08feshbKAteaseLvCNwSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m8QMWZXF23JZcJj7dYzowkncoyFZ18VOjCsfPwKZzQE=; b=J
 XfSZDyDf+of/wu3jpbWyi09AL4qlN/5CCYXF0lRasrqkY8PWvcPDKva8z77kfqS10PmFpsBcOKPV4
 vcv7ihXFKGeKir4NrnR6FseIpOeKZqK6wEbCLMuTRD4ccgKDNepBFeS2OFw9bzjCGXKaavFhxtEYc
 v+An7JIZfO98/tGg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdb4d-0005gG-Sd for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 22:00:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso26941295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782597622; x=1783202422; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m8QMWZXF23JZcJj7dYzowkncoyFZ18VOjCsfPwKZzQE=;
 b=Ow+RFmeVbyRPJSR42HI6sDnJXmR1GkCkgkvMJ6Lwwb/N+1hYCghyFl+XF4JaL9f3rq
 EkCsxKENOtPsi7MBc6860B5yMCQoZcbEmvps0/W7jW2Zkk9cS2q2vTo16s5GvbiENj9d
 kX5IcQUqxit+AHRDJ/P/oZ3lgJIluQRhHheWlm8fRaKsHBE2a8qZg5vN8LR0Tf3NBbRe
 a8sj726YIXl3pKfhHeN5YKQGxVw1JQxu5goYOiKt57IDjDkDtQoJPnpjKNIjXpsa50yv
 Q5f8/wci4E7njJT0s7h4zUGK89CLX9LxVgjgyLFZ3WQO/rHTmli9qbKRYonF7jwhU0py
 Apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782597622; x=1783202422;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8QMWZXF23JZcJj7dYzowkncoyFZ18VOjCsfPwKZzQE=;
 b=IGiZVbije9qWbCldMsiUdI+mZZFoPY/IEYb4FW67BslQBY/eJtfPSgP1LxRR8AaY0q
 5ua8JyvqRgpyY/psYJVMfN6BtqAcL+gs0QdNqETNgbn3fy4pbzbVzMuQu2NC2icXwnsv
 fsTh8nHbfZqeNois3baGklzRgiqjJVFAjmCr5tjotQIY6d7EGWA77RXSa2na9oKKACY4
 Hi9RBec9lQFTkISs3UeLpnkkhugNQK/yTQDL3XzuTR64WUyFkeq2/avcrbFGhiosTuG2
 kgJJ1CxVQ13kFVkM6JsmIBBJEPicMdnho5bDT4edfGNpASFUsr479SuVT+YzWogzOYqr
 MNnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Pl1KCYY8veZfiPJiysbsTpD8OS48VMd/t6pI9dQKxnf0zixYzvyGJAkusPoXsB7LDzmzJAJ+CognBBjZY@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwjjnStxEJpSLn3bEyogWIjKndZCqA+aXQkBuJ+C7GS/joXg4rw
 nROSK8F0Yw9Bk9jzBBO78J86drbroSFvc6pwRjKcGxIgXkskl3TCnR9Tq5xlKSGmn1eDGWsBLvv
 eD2nfZCMdjMKmixS//gbW+pMSLb1zG0ajg47CZ7NuM8C7hyiMT/cpT00YOlRSVFNf/ouK
X-Gm-Gg: AfdE7cmVn45R+Hw/lMhmDJQFzL+oqJzDcqwWKrriH3fSmuvhUZ4deu+2SB+DMxQFA0e
 ufnzvtIhzNQq2nspATD/hbGgPSiQhZNxKWRjRAmyz+K7M5LVj+9XxKadavp5HjS7d5ap0aSds6w
 6s7UTdc6a0B368O11mMFW5Ovae/h/edImnO+EiBC46iLRuLtQGjHTfrx0hXy36hMf87Givm8r05
 sRJvS1HqGdQ2IGbMfuHCBoTtJe1LPQquxELXVLkZoi5Ku+VIcyJIAq0ggQp9FsxHlNdOsG3aRXQ
 5ZH9P3gEtOJHvCR7oqVpd3awtLXKETM3jRJUCjOl++YMsbq8lQHEtw+2ABaQ9UM4t6cjcVnSAx8
 yYmkdLks0N7Uup99KL8y6M4G1sfhBQ/LG07cPJf7ua+Br/qMX7E5c9SZR0QJO8edQyafRr6fdaM
 A46+B2wDeFc28+yJ7R86L1T0MU/Ffkts2sqXn37iadZDNyyDgId1gTyUZLZ/scfULST3MJYLvmn
 WLCp6YA/JxXbmER3pyYrJwdmRoPJY6txB9Uhn1uPdHNZL7xpQNgOZJPwoM37Oz6DSvZxv9C6APV
 zXw=
X-Received: by 2002:a05:600c:4712:b0:492:5e21:458b with SMTP id
 5b1f17b1804b1-4926683236dmr174601435e9.8.1782597621591; 
 Sat, 27 Jun 2026 15:00:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm23249066f8f.14.2026.06.27.15.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 15:00:21 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 22:00:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: c1033d72f7c595c4a5a59f026441edef43024197
X-Gerrit-Comment-Date: Sat, 27 Jun 2026 22:00:18 +0000
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51fbd933a5dc60346292e2a8fb2f5447c33bac0d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdb4d-0005gG-Sd
Subject: [Openvpn-devel] [L] Change in openvpn[master]: openvpnserv: rework
 ConvertItfDnsDomains and tests
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5751936378905331443=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5751936378905331443==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PnIUsOJ1lns="; charset=UTF-8

--PnIUsOJ1lns=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

d12fk has posted commen=
ts on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
730?usp=3Demail )

Change subject: openvpnserv: rework ConvertItfDnsDomains=
 and tests
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 5:

(1 comment)

File src/openvpnserv/interactive=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1730/comment/3b7ad273_1bbac960?usp=3Demail=
 :
PS5, Line 36: #include <malloc=2Eh>
> I don't think this is needed, sinc=
e malloc is in stdlib=2Eh=2E [=E2=80=A6]
MSDN says both are needed:
https:/=
/learn=2Emicrosoft=2Ecom/de-de/cpp/c-runtime-library/reference/malloc



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8=
fa1af2c50fc45d938
Gerrit-Change-Number: 1730
Gerrit-PatchSet: 5
Gerrit-Owne=
r: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 27 Jun 2026 22:0=
0:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-T=
o: stipa <lstipakov@gmail=2Ecom>

--PnIUsOJ1lns=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1730?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1730/comment/3b7ad273_1bbac960?usp=3Demail">Patch Set #5, Line 36:</a> <=
code style=3D"font-family:monospace,monospace">#include &lt;malloc=2Eh&gt;<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I don&#39;t think this is needed, since malloc is in =
stdlib=2Eh=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">MSDN says both are needed:<br>ht=
tps://learn=2Emicrosoft=2Ecom/de-de/cpp/c-runtime-library/reference/malloc<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1730?usp=3Demail">change 1730</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2=
c50fc45d938 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1730 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D=
"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 27=
 Jun 2026 22:00:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>

</body></html>
--PnIUsOJ1lns=--


--===============5751936378905331443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5751936378905331443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5751936378905331443==--

