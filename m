Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86723CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBHN1yZi1F1MFZW139C49VN0bTXulWxXtXykfdjqx0c=; b=OU7a2RglJlVMHZoNtbehQHeAnD
	g0I5VrLswdqPQ7yO0SZgHiDdDHD2BYyqb//0bE9y9oQ/oEln1ngPnzn+Vw3E3NWL33RkYEiLZ32yt
	EQSHE8n42EXE1ty1CHMrl/xy6BUHVPxJQJq/2pjXh6eO7SgsinFsSTp0Xj8zCtUj399E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSCa-00025q-Rr;
	Thu, 14 May 2026 09:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNSCZ-00025j-TO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kcsioULGePB/dURieztXQbAYDOXDqX+dlrm7BE/xirI=; b=Rbrm+/QNFgq278Y6BSOlKTGCjd
 2fasCUeZnQifuLy1oeLs15NyhMY+nX4bNPsOz0mWw5EMWsnA0BlQ/bt3tlCLGo0bSxrL2SyuBR/qz
 eEtFaMFwuzJ9fOyD0D9nCmI0lSvZuNsD5BiqzEQviaj31EqKTPuNr5iacCVPZEHXaOgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kcsioULGePB/dURieztXQbAYDOXDqX+dlrm7BE/xirI=; b=F
 nTO8sEXV/7Yk3k/eCCQ2KCVBUx6zL6Ck3MRS1y45/Vv+3P2mJZK5PkoGXM0JO/UEkRnifpVxZr+WY
 h3pNxYxg0NyaNfAVoVe/KCQ1AlQ4mhOWzlLL1UQrmayebHkGx3rbnBOS2pIXDjnV6fWqhpJbz7pQ7
 xw28DXrqTDvruXzo=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNSCT-0002Sj-Hc for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:17:53 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso68989365e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778750258; x=1779355058; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcsioULGePB/dURieztXQbAYDOXDqX+dlrm7BE/xirI=;
 b=Sgx0vHAq4D5pDO/RvPzbbVicacXvOik0AKDWyQgFNt5bsvmzKCNYrWgqfT+AWg7D2D
 dExns9qt6IafPKrOddk89Ybt946U3Tktt/+8urmRVj0ZpBJwvN54RQDy5S5QQDpGGaqq
 vkDqCYwCj5n0G16bpeIw4GeimluTRGDCUGYqaRIyjj/iOGnkDC5cQYkeOm44QgovV9MU
 ZKt6Fjp34F784rLatvgbuCROQlvVB7VIuMKmrmqq3ABRN14RN8nKp2MCzy3HALxnCfHU
 15tK5AedxG3k1BDh/ee0BYPJwwpbFK1jWymUQqzWXzH29REHp67VwEL3rWTcYWw+QvKu
 qHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778750258; x=1779355058;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcsioULGePB/dURieztXQbAYDOXDqX+dlrm7BE/xirI=;
 b=ILPosiCRAxnCcjcul/3G8erO7epPFrosYl/LCO1LNbgS1lRmW2XLRWTH/4b5NtXgIa
 Q/xwzYNkX1FT5GxXePv+Az9W4MkxzgJdLlnLaPZfn0o4jg7Zd7KM2/+lNYUNv6IUFYZw
 G5F3WSYDOGdAhDPJujQoVzx5C0ODwuvLCUqyRoPujq5pEfbCivnSHuURDUEjPSujBX8I
 J8HLonDbDiUtiR5yhe36u4j7078nnoJAKPKCyNmGGNlVfk2ZsrG260cF4CMDRGv1h0ug
 nzhXfpRf2oV//6KKH7ShoU+B9XIFPVNyyIE+E+DRWQFHxAKpeuTYFxJc3groH+xcFE/d
 8sjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gKsbpl1SlRTTh9G8YDw472YYghmJk49ApAAW8NCbNONy4vKbkvzQbcxocgokW862nsDWPCPsRzIzl+eSU@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwSYkDp9aXpde8oEOUNYV7NTl+8QBbP+47o+KOKszniOZ3dLqxz
 WXujnYLwWyx3VHqXDZrTRV5GCaoUKjB7VtoRKr681x3AkgcjKWEfwxFpCON9WBeBzLheutWBF+N
 4eAbxN7/CAB3Q19ETBzJ1kt1594o8pA0E7FtCducKx0KETM0pOy1KuaJb4+W/PoP3vQlU
X-Gm-Gg: Acq92OFL73/ShgoKuzRtgJIg4lcUzMw7Ygry9BX2fxY3aF53DcddiYHPq0dwryxIh7j
 WuzMLi7IFRCPxy4VkZO+FAMOvpH3Ts6I4YcDjZKEOigOWKiMtsMqZ/mnSWxive8IMPvGC7GCOcS
 QJZd5+Ja3tZpDhO9iLnRR1kkuwFZovWoxsx2+ha28tKL7vlUuwXCTVdlO9Qb64bfElJBXI6EMGb
 99dAssgYGTogL6NmMowV9qPtPmy5dOjaPHcE0nD/O3R789pzKw4yRKX4oPaIbYNkYdUOIo0ixOh
 61s+5BNrCVpDFJX0JmnGCll4AnXUi9O0yb4l/nNKIfZ3uRjjPjpFag5YuNXWKHhe9pRDBEOwdmy
 1ZIs5bZezuH9JN92oMWkuP1rjSswozYaLtx9vI2RYKN5rS5OQ1tEyR1SxGDF1KbuZoor8S1ObmA
 ztZu0G1BG777lJUJ18qLUpa3E8Hy7E1blt81HxfRvCYPpUgqKarb6jJJKK+GqRSSL48PQu/YQwk
 gS4IxPd9wAFbVauTJlMwUdzUprytTCECaDuUZ82+eQVeXFh+Go+iuTFFh4MxV+7Xs/wz+I35+Ue
 Cs84kacOSAUNqQ==
X-Received: by 2002:a05:600c:4509:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48fce9b2e5dmr96307185e9.3.1778750258451; 
 Thu, 14 May 2026 02:17:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64cead5sm49868705e9.10.2026.05.14.02.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 02:17:38 -0700 (PDT)
From: "d12fk (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 09:17:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
X-Gerrit-Change-Number: 1671
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1671?usp=email>
X-Gerrit-Commit: fb39fd36f9bcbb2ea030cbf91a1ecaf794f4b605
X-Gerrit-Comment-Date: Thu, 14 May 2026 09:17:36 +0000
In-Reply-To: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
References: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkzZDM5MTAxNmRjZDNjNjZlNThmM2YwNWIzNTZiY2Q0MTkyMjRhY2IxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd067a7129cf4050a1f50b6b96e0e6b91d72cefb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNSCT-0002Sj-Hc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: Use
 same variant of UuidToString and RpcStringFree
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
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0165287808908452571=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0165287808908452571==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gZ1LtL33Hf0="; charset=UTF-8

--gZ1LtL33Hf0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

d12fk has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1671?usp=3Demail )

Change subject: openvpnserv: Use sa=
me variant of UuidToString and RpcStringFree
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd4192=
24acb1
Gerrit-Change-Number: 1671
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Thu, 14 May 2026 09:17:36 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--gZ1LtL33Hf0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail">change 1671=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d39=
1016dcd3c66e58f3f05b356bcd419224acb1 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1671 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Thu, 14 May 2026 09:17:36 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gZ1LtL33Hf0=--


--===============0165287808908452571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0165287808908452571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0165287808908452571==--

