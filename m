Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5203EC9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFum/UeTzsdvmnRxZAgceERGoVgvwvBiM7nNiE0caqY=; b=i9nuLxwGudhcP4brJf/kRSnqmG
	dwsjCcl+4rl2McIALRATvZzGReeHpWXYn9ogttUsmIA2EVfGlke204gkSSbRU46GUWmXEwHd/vRCu
	56wbxK7gG2ZV4sFgA5FZGMhEsAIFSFuHPANO8bmIqHSEgM3BXtJd4ZeUfKQYOL4yBGCY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Mdv-0005MI-T8;
	Wed, 23 Sep 2026 13:04:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Mdu-0005MC-Jl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:04:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=16UIpaedaWXe4PcfEm4z4hYfjqbb1iMJdN2tER2aHPo=; b=iI9MrnPS2rb9a4uQF4VGo+GwLC
 +qGwe/EzFHFUtZ6ohKCqwL5t9xP/1oxG7J9Ee8QnEUJT5sxeFi03Aiat4iCBSwPYpvNU6eNFmm6hf
 pYxuShDKWQPCgzwutZWUlSjn+ejeakEXxcYN2c2+r/tpUssxvXDQ23jGppcKxQ486Hmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=16UIpaedaWXe4PcfEm4z4hYfjqbb1iMJdN2tER2aHPo=; b=k
 3QxSoJ03Sargpnleg8ogWcUA27sYZ64glhF96RC1GyzK8khe4Eqt6USvWUOP5AoRfc5HhdXRzPexU
 32HH0w1YUNOuXSCYd9sZCJkeb8FH2N4J3+XyhKu+wHrIG9dQXnIA+5UjsmKflrGJ3Ri2XyhoiXS+L
 8/KHiu9bywC4o670=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Mdt-000092-96 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:04:10 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so7574225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790168643; x=1790773443; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=16UIpaedaWXe4PcfEm4z4hYfjqbb1iMJdN2tER2aHPo=;
 b=dW2DUZzoR9xPvBd5jJ+c/rH2FM502fGMhrfJfLMKvOvRPYH7g3O1YbWkJlC5w1TwVr
 jbf/Z0bwmdfmLetVYP7/Soppkv0pABpQfuAgq+yU/9vMx87yjvOpqE2J8H/YoRIVE4mQ
 D63DA+Ou3ewgiG9BCd/w5G3ZVi4aZncEm/c2lZgpMvgRKVaHv4ELtMyO2whmwFkaigUa
 gNQbSkK7GLaj90Lcs9RQvCjMbxAKwFHGyEIXzcaccOSsQoiTViJ3/zToyX4YEaC3QLus
 1lrZpNd6TczFKcMydlYQtVQvya+X5oLdivcNkfyVZNWDWcYX0m2AkYmKk5VtG/idhrKd
 UQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168643; x=1790773443;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=16UIpaedaWXe4PcfEm4z4hYfjqbb1iMJdN2tER2aHPo=;
 b=lm1evFoo8G8DpxY399wiN5ONvXDCS7ycT1zTFPlvAnwv+hxocN2P7rDyi4a35KsejW
 uZuHfIvZ+vARL8jotGiJuXg/lHjopIVq1WQB3TPLLdK0EeRPhMUs1VqL6E1NA6W4PgUD
 OWugFaFLmnGb6DpzVcWneNfuOFVb4e3Gq5FLSAjw7ulz46UvQTrLkTMEvJRJIX0UWUlu
 XWN5reS31xuxx7Gpr0lNTuEumf/ql6NzFWeUijKlKcnk8Mn+TwJzRUk57xpxSDBubDrV
 lmfKJ0NEBkgGQzPH8astMlgtsr5dXZVKgbD+stMcwTovclc8dRMyziNaop0jWD48tRlu
 SMBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxadJmDVdwRgj5UcMpLZnuYnbccF1CTtnw9/QXY5pDA4mHR0fc/mKCHnZk+njQbZE2coefNOCnuK3+Hx0he@lists.sourceforge.net
X-Gm-Message-State: AFuF++kz3lBXa0Gd9M6Dt0h1BYjzKOpPiC8KUICla+6Da6HYj+11OFI0
 66e9flMWSJWLo9xZPyAwO/EDwKSLV4w386xFil/4SQPjFB1AWUGwSZgOUKipehl+Yoo7Wtgd/Yx
 ibeeJv/8Fw7EGQZasLmLz9QIMCzvb7eDGWDNOQuV40FYfmUXdMEDeLh4P+vLncix9lGHPusbvqF
 EdEWolCQ==
X-Gm-Gg: AYBFou09Hg07pqAaSuQt35Kt43epYdihSppczB/OrqiddtDrXVkuImtcv2MWWcESwN4
 TNDfhlEWmxiF1SjG5+KiNtijnx/lr5YJU+coug90knsTTu0FM2eXlmaIJYMVpUvh7wEsWxgIvKh
 RJ40aHmg++cpeLAMmANYNY0gEiBUGD3IuKcJBnXo3BRleAKNxH6CDayN0Gk9fwoWkyAC0D1Z73l
 KbSG5UwhCJItnNyT6zsjJcgwaUCtEwWaBpe5dHw1DHDsDTHySez2BY8vZPaDiKmOxkJJJ+MA0aM
 Te8482fySgeHMUnfTw4fnd4/O6Ye3m2a51yAo6PkVZsv5ZwOQFZXVHGLgkH9nksXHJwQsvDBUN/
 R2ooH0liBaLXWi9nhymfM1M1n/Ug5DDGkAqMp5lE7nL8ruCPtjjI9x9MIqYyGaKvaAxbE/23SBV
 FsFkkeB3U4BNkT21ddgkOMPqveAInOymnDzv0inHkjYsE+WXnKQMhGBJmpq6IiyyoNjQA9/BWlm
 0jVL4QPgohiC7Yf4w+zoB+5wC8grSPXBQhIKQjxXG3DlT516ZQogFHOSFGpg8hnBinze3XxVzdD
 DwMkqehOtdhkYk+aBnjHOfHLZlX4kXKWg816hqiIKd0ZHXW6vlvsGfWPQ3i6
X-Received: by 2002:a05:600c:6304:b0:49e:6c9b:4e94 with SMTP id
 5b1f17b1804b1-49fdf1546b7mr34089565e9.28.1790168642552; 
 Wed, 23 Sep 2026 06:04:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde13096csm85008155e9.0.2026.09.23.06.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:04:01 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 13:04:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20
X-Gerrit-Change-Number: 1944
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1944?usp=email>
X-Gerrit-Commit: ab8bbcb4c70a4f775cae0c445e2a654109c9d701
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 13:04:00 +0000
In-Reply-To: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
References: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTU1NDkxMDAwLkk5OGYzMzM0M2QzNTQ1MzIxOWU0M2I4NzMwY2MxMGJjZWYxMTllYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b29af99748f1fcd311b67029efa16197cfab6430-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Mdt-000092-96
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Inline ret
 definition in dco_linux.c
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4672853220575410992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4672853220575410992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P3TgkCzKxXI="; charset=UTF-8

--P3TgkCzKxXI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail )

Change subject: Inline re=
t definition in dco_linux=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> cppcheck do=
esn't understand the `NLA_PUT()` macros, which on failure `goto nla_put_fai=
lure`, which i [=E2=80=A6]
clang is fine with it but apparently not gcc=2E =
Anyway, declining this



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1944?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I98f33343d35453219e43b8730cc10bcef119ea20
Gerrit-Change-Number: 1944
Ge=
rrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date: Wed, 23 Sep 2026 1=
3:04:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Repl=
y-To: razvanc <razvanc@mailbox=2Eorg>

--P3TgkCzKxXI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has pos=
ted comments on this change by plaisthos=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">cppcheck doesn&#39;t un=
derstand the `NLA_PUT()` macros, which on failure `goto nla_put_failure`, w=
hich i [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">clang is fine with it but apparently no=
t gcc=2E Anyway, declining this</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail">change=
 1944</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I98f33343d35453219e43b8730cc10bcef119ea20 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1944 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2=
026 13:04:00 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div s=
tyle=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eo=
rg&gt; </div>

</body></html>
--P3TgkCzKxXI=--


--===============4672853220575410992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4672853220575410992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4672853220575410992==--

