Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A4C79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DJcu4YoQ5EV3Ixc58JobZPd2YUxvG0tN10XCUDWkTQ=; b=XPyAinYTyU2Jkkcq/k+WS7uV4d
	B63QASHbAhh2osOVUhhh2FooISerXPs9Jp1xnR+JDb1DTZ1yGkBdLXauBXrXlpnTQp1FaPArMtIvA
	18fHWdgTTtJYfMWl2dqrnHjM/EmW8C4jJoKF/kTfSxr9IhpqFUCZUTM5xo5wzTMaCR7w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3akl-0006yM-RW;
	Mon, 07 Sep 2026 14:55:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3akl-0006yE-3u
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+wrwR2egsUXxyAcTz5P171a10BWlcs4yxlN7IOf202w=; b=LFvdsvzBpk2wHGDFXFZeo7Xy9z
 997yCTbojUFn9qru0FAmj4fTK9zuJ1nICPvEjZO735qthLEulKBikz6SLLLjEDGLWJWE4zEPJ09he
 lzWGLAEuXaveUr8MpQ+cGsxtPgOMQA6/IWWtkuoaS7UEwZ6+HnaBLEx41cmjosVxNnV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+wrwR2egsUXxyAcTz5P171a10BWlcs4yxlN7IOf202w=; b=O
 1fLLxH3Jn35Pk/QbwahkFZmSNQiMtmNJB4E9BECSBxjPAhI+q9XTd0krShKmVK3D/i+fd8un1EHFC
 T5TA4DexN0ox4Ku5TopJ+wS/NVbLOZMKpvaW/Zqhw3j1Ybypj1u/O9q0bhz/bMxdepgge8yG6IO3E
 9QVgRDGbEohaLlEE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3akl-0003uv-21 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:55:23 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so1957482f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788792916; x=1789397716; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+wrwR2egsUXxyAcTz5P171a10BWlcs4yxlN7IOf202w=;
 b=Yn8S4ntUKM7UzlKsxPX99Cm/c+FEnj+C8f+ITiYnT8ZN11+xDCYTWSGYLpqstVMr+l
 taT+Uhxt+NtKb/mektm6x5nim71BqePnHkMd1uootqDr1HNa2W5Z1cuEnLCCyFc4NRri
 k3ZhrZdKMhRqqYZjORQ5uBaY/b3sXDAQNJke7RqK3bPxFWmadLP+Pw6E8BvfkdajGBYl
 cxTU+NyUyftOxFI1LNdKokVfKnvIdedokgNbI/G3DehG01X0RBvZcpGugLKt225V/t0V
 99Sc1u/RPaYxT9I4kMfmFuvDRPDHnvckjWoId4/srhh+7rF9SDvjFobxW89uf9G4Zs3M
 c5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792916; x=1789397716;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+wrwR2egsUXxyAcTz5P171a10BWlcs4yxlN7IOf202w=;
 b=mZA7M6VGs1C1/w+0U7+70UWXF5wJL44igwYzpWjvE6L/Ghl4U0sLJCfHvbG59+Uo4l
 AACOSmgYtsn0R+PqhKMfV8zdlauEFt23biB+kCJ9aD8OUd0yUico40P+OI+vEyLj5eHT
 MKDxoNqwIUYlXlh3+RzjOWMDEH0XIQjxr+UNYuZYN/gs16oVk/NA2Kb5D9pjvBvKiOqN
 /4DRzwU89Yw0LtloZD1wQMD/SnqDUqHHp3s5cJZt3RDmHKBx4axH3ejXGLRs281JyJDm
 nUufeduk2tEbt7/uxh47CVTRyU5GAA9tFclO6t2IZUW9EHffcIKlwd6pvj6OoAjE+TTN
 4Wug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy86jsiNNFHdE5yakPCLU177fwPGJ9YrSQuKiRZUAPa+cYhYC+ncHg6LOMG+cI1tgxGxxOQfTf0O1nnk/GJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQ9Ydu6z6OyTAtInwbTl9uTx5nVMgUXaoSwAq3BS9yXmZK2qV1
 nywaLliMr1fg2i7oDnf4lD8k1CgxpEP/SSVm/a2Lf9//oVKa6LGbxUGMf/ttgJQc2uhaD7yYmVF
 vvdhY9sJF5QavCf0XvgfI+ANCI4p4DY6Ngdm74rTIlARPo5Pv528o9JNF6iPq48GPvTwnvPTJVi
 lxDPRIfA==
X-Gm-Gg: AYBFou2TSuFaW0uktNAi9kFd8uo+BeeBFvFptSjHu6i6pZIHWrJgRW2+Qd+KVnJtNRB
 Emy7Sai7M2JgPtaPx4FPGiIWgNsDyo1YrIg/7CiNo36cbnFcNMWv4ML90lz2Cl2FDHrCwOPp59l
 lPoCHWuSRzP7DawWzIB4Sqe7iqqrE3KnC7S70DhMSexNfCXJ/Lkv6O2GCFspsEIMrZQKFFkIi1r
 FtIMqyLwR20mTK/E8z+3zZMq8Ddee4efPsOVcLrGm5onZTD9PRO846gKhQH56KiG1OGIyCQHDiU
 lRVBQyRBywG4MZkeidtrT9N/bps14R3awni4R/EbauJgyfOtijWZNnkjkCSnHch3Vlq4jpuAx2X
 V4x667+BGythXIJvh87F8FdaZ7hXXr8+v+l7mwZu2XwwkaKEdULTk6yltTc1ZHhbj4T1wC9JnOp
 ONUR2/yp0HptReU5xPQW74suGm68OnxGQO3yqVkXQgrW6BcuAGUyYcbssS8z8qAVjNonKVMq7MZ
 jMJFtYbR8br4Zjf4eEXnMhNY2/bmrQWavtJvH8El3GyJeIlkI1pZa69vYB4TL+WnubiDJqGGgSR
 ZdlXYEe13jb1ZDvz5qj6FwQqBU+QLregHs7m7tqkoU2P2lMeS2I=
X-Received: by 2002:a05:6000:240c:b0:485:8f37:79b7 with SMTP id
 ffacd0b85a97d-4858f377a4emr16987262f8f.33.1788792916475; 
 Mon, 07 Sep 2026 07:55:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588390e30sm28816726f8f.7.2026.09.07.07.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:55:16 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 14:55:15 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 67bc78c7f97e197fe98ce901e36edb13709376c2
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 14:55:15 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d150759fda79f292f54300f81d71e4648fd6472-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3akl-0003uv-21
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4321742696839416528=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4321742696839416528==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wWVfkRTfygo="; charset=UTF-8

--wWVfkRTfygo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, srkyn=2E

razvanc has posted c=
omments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fds in =
forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5: Code-Review+2

(1 comment)

File tests/unit_tests/openvpn/t=
est_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/6f076=
3dc_fa9922a8?usp=3Demail :
PS4, Line 567:                                 :=
 '0';
> This has the tests pass even without the patch, since `dup(source)`=
 will return the lowest free desc [=E2=80=A6]
Done



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
G=
errit-Change-Number: 1881
Gerrit-PatchSet: 5
Gerrit-Owner: srkyn <david@srk=
yn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emu=
c=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: srkyn <=
david@srkyn=2Ecom>
Gerrit-Comment-Date: Mon, 07 Sep 2026 14:55:15 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: razvanc <r=
azvanc@mailbox=2Eorg>

--wWVfkRTfygo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, srkyn=2E </p>
<p>Patch set 5:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881/comment/6f0763dc_fa9922a8?usp=3Demail">Patch Set #4=
, Line 567:</a> <code style=3D"font-family:monospace,monospace">           =
                     : &#39;0&#39;;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This has the test=
s pass even without the patch, since `dup(source)` will return the lowest f=
ree desc [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Dem=
ail">change 1881</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: srky=
n &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Sep 2026 14:55:15 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

=
</body></html>
--wWVfkRTfygo=--


--===============4321742696839416528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4321742696839416528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4321742696839416528==--

