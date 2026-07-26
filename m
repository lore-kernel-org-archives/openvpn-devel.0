Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE461C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DGR+7eS+EiSvSivPz50F9DfT4unATBYmSpj6jlToPQ=; b=Xh0W2pGK6MMaJiZGi1rGywURPd
	K7t5tyflMsVHAy1x2dsRb6tIJitBXbC+1K05RoeVElyKstMSZzq+zuCEbDadr2tbPewPLG+dGfXcs
	JypHrjJvmRbuLSVkECEUnb9kBB5V2+/XcOv4y/r28WjE4zODXVwNeTdSYK9uo+HwIsAw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnnXJ-0001wP-H8;
	Sun, 26 Jul 2026 01:20:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnnXI-0001wE-OT
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9Stuc07ZvUWLYRR4O+bKFs6BmrDTy+9CLaMkkxkM0A0=; b=FH7tuctvE8uJxDKwBFsLIq+Qzh
 3RDSMfyH/6jS+3TZAtFGrC8sHCPa2GsLJTu6ErSUyUJk3pOWd8Pe8gnoZjni1Aq85g49McPelUMR2
 m/tYCjp03QNd8rwBf9HMzsCkYTGsRMGTjlsTudhz/e/WvTd+MuhbelpCO6HX819+UtA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9Stuc07ZvUWLYRR4O+bKFs6BmrDTy+9CLaMkkxkM0A0=; b=b
 4JJ5SnBMMa6tT1oARmYJOfDqIyXelnWHLkGHs80XgsTePDyYuN1GeT6w6PIv+U6nUoeZPQ+D05orG
 zRcNoHgGjw79oBToMPlKcjUmlJgIgnj+T4nnXlpr3cfXBRCdzLOD9Yw3ItTOBUge46aFGdeVxHZ4Q
 DMZjaBMFLafi/XoQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnnXI-0001if-A9 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 01:20:13 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so1217035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 18:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785028806; x=1785633606; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Stuc07ZvUWLYRR4O+bKFs6BmrDTy+9CLaMkkxkM0A0=;
 b=fzJuJJoc+7iYFgm5S2fq1DRuUa1r7r4RJDoSXx+xbFysaGhxjBfkBIdhxjvlOQVXKX
 ByljnWaESXd85K8GUIp50LQJyOSIAnHcusD1zXHfMeE3wP6VUf+nrMiYO7HeHBGhXIbL
 aVaKBLrYGvXKtgMc9X24gg+ZlGK37udge1H+VOBXT8LABkRqfLUaQKrLzCYAIQyax2XD
 jT8EeqJnOS0V7nTI0UwVjFypQbCCkWPfE3j4laZXdHpkBYhj2hQsKtSTbTNSf4/Qa24T
 SrRBWyhaCJgJUhLdVSS3iWHpHHKQEoo1jH9hAAa9sZGrl2RFSDD2wUbMvvbcFtbUqsV0
 p9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785028806; x=1785633606;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9Stuc07ZvUWLYRR4O+bKFs6BmrDTy+9CLaMkkxkM0A0=;
 b=G5zV1fYykO3wtCRUw8z6QZ7/cIz4KsCfAWxUUpV7FRp+Nf3Td/FtxAVAzuaWJlFdzu
 bELL7mvfKVJkqm/lQykWlnzrMwfcP5xttfmtR9X1PtJkOcwxcqd0J4yTJ9Mwbd8B+HBX
 1TFjg9wP7ThtpI55/nwUjF/hixDdJDl2XNlP5ZQE+4M/MBFmh/y1b1JR53z+odlEFZNR
 VZv0uTysWcKDNyfPtS2QUmGBXGoXkR1/nSwkxt952k1a+DPLDCAugqAKJikic0lIuEmB
 1kmgqS/6eSmFn3LsBFUchcb6ZydIER8hzPtvkXbU0cd1U3eIt+wIDjDUKZNIkySphefq
 DP7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RroCFZVoGdKPrFTQ9K7FdpdrUTt7gpDrqQoQbsZNeatNcHDBy71w+1BvCbdrh7hRRVeCvM2OWufdaDdZDaI@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxQHKpqhjjXaEEekY2f/Y2Nbhoe5zJcbBb9vA5Q3znRseZgfK3a
 VgN6HSNheecHn0P8Oiwvm2T9wiM/+uzmUnOC69bs3WEaAnMvad9/Rz7VIzeqWmRiIxMCiiew/XF
 cZL70QydqGSziTHYA/pzz9IiRUq/W/MrWmPxNSP7V9B6urHKBWwKPls6dMcO8IbsycSn4Din8Ph
 phrmKpqQ==
X-Gm-Gg: AR+sD12/57/B4cUJk+CgOw+rnBlUl4rThnUr8Vg4vD6Z3EHKptYgFcDPzNiVPUlFSm8
 KXaUmsYQ6Xry1XuT+kn+DZoOBGe3WjWQXCKoMpOEY7iuBGzlGHMnbmabQKliBdjkhrTceKWafrG
 fKW0P5IQUgbWLBzPtnqphWwpyQUI0ywTRAHK6Pcpu6MSXZoFPe1dnKH+OFzcE9GE1jTNuOB1O1X
 SlNUKYFH4GQ3sf7TuySLPAereFmuneWIY0Cqei9uwH08p70s3x5GM1p6XZKApOJ74gGUDD0LvNW
 ZW9S074Lzy3l7K/+28coWycKrvFcXqwqqCBTnULDpdjy7W6tMVG0ktGsyIkcw4FHxbuY4fC6GV3
 xTULPIds79Pidb2OTbiGxH9bbxuW+LTZWjbseYrzYrFB0dcJr8+SWVOKsVxG9pX20Zjx7lPipsN
 YzqiDgifA40VfNUX24jc2AvdnuK8zs8BdKJNJFmOQjKwnCs29ppn+LLH8a7EXWNxj9DkN62UuQ/
 yStehNllMwzEZI6lNggdjQk/ElbUJxFnUCGKiQvw1klpkW0t8rqJF2DCVadxhnjggiq
X-Received: by 2002:a05:600c:46cb:b0:493:f78f:cd70 with SMTP id
 5b1f17b1804b1-496b76164b3mr35914935e9.18.1785028805705; 
 Sat, 25 Jul 2026 18:20:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm129986885e9.1.2026.07.25.18.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 18:20:05 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 01:20:04 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: dc49b3ff37024a0bb810a18c1c03e2ec6f9df2e2
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 01:20:04 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43b7581cb044185a5c5180caf0427a17746e469d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnnXI-0001if-A9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0250725374848506679=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0250725374848506679==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DhOkZ2wRQ5o="; charset=UTF-8

--DhOkZ2wRQ5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

plaisthos has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client PROBE_REPL=
Y parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 8: Code-Review-1

(4 comments)

File src/openvpn/oob=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/44ce705a_e1b25856?usp=3Demail=
 :
PS8, Line 191:         }
In the happy case we do not check that the leng=
th is valid and inside the buffer


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1745/comment/82a7b47d_f8e4d6de?usp=3Demail :
PS8, Line 196:         }
fo=
r the other case we check this=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1745/comment/80a327f4_450b8ad1?usp=3Demail :
PS8, Line 198:     return f=
alse;
Can we have nicer formatting of methods? I find this style of everyth=
ing squished together not great to read=2E


http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1745/comment/89434ef2_3db2521a?usp=3Demail :
PS8, Line 207:    =
        && oob_probe_parameter_read(payload, param, value_len);
I am just a=
t this and I wonder if we can improve the code=2E

This API/function does n=
ot look particular great if this the way we have to interact with it=2E Thi=
s is not a very readable method to me=2E



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Chan=
ge-Number: 1745
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Sun, 26 Jul 2026 01:20:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: Yes

--DhOkZ2wRQ5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p>Patch set 8:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1745/comment/44ce705a_e1b25856?usp=3Demail">Patch Set #8, Line 191:</a>=
 <code style=3D"font-family:monospace,monospace">        }</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">In th=
e happy case we do not check that the length is valid and inside the buffer=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comm=
ent/82a7b47d_f8e4d6de?usp=3Demail">Patch Set #8, Line 196:</a> <code style=
=3D"font-family:monospace,monospace">        }</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">for the other cas=
e we check this=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1745/comment/80a327f4_450b8ad1?usp=3Demail">Patch Set #8, Line 198=
:</a> <code style=3D"font-family:monospace,monospace">    return false;</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Can we have nicer formatting of methods? I find this style of every=
thing squished together not great to read=2E</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/89434ef2_3db2521a?usp=3Dema=
il">Patch Set #8, Line 207:</a> <code style=3D"font-family:monospace,monosp=
ace">           &amp;&amp; oob_probe_parameter_read(payload, param, value_l=
en);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I am just at this and I wonder if we can improve the code=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This API/function does not look particular great if this the way we=
 have to interact with it=2E This is not a very readable method to me=2E</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63=
e05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1745 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Sun, 26 Jul 2026 01:20:04 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--DhOkZ2wRQ5o=--


--===============0250725374848506679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0250725374848506679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0250725374848506679==--

