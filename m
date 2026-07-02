Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5B5C43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zqU6RtQH8m8tZvk9xf0wVF6Ejgz/xuy3EC1d5TDwukQ=; b=aVv1ohWVQN5ZzapBxLK/D9FsZb
	J0HcE+5OUh/CrO+/To/FN5JaXTA+O7B3kekLOTEnHy6tP4KgkuGwjO5XsE9u+p97OnH7T+cqHQQMZ
	t0St2tEXsWc0ND4o+PL9ul3VsYrLaczidg54Knd+itXuFKXy6ZdSCsMgow+COn64CqZg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfGZv-0002Wx-Bt;
	Thu, 02 Jul 2026 12:31:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfGZu-0002Wp-6v
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k3LuorvWtgnP9nzHUSsz1ozedmKeL1fkftdFDxNcON4=; b=Lg9HMgY+4O7gCkzCmTiUZklc2j
 uIulCYardMhBgHlrlqxXgKA+km9P9XS8/9cCagC3otiMIg+o7oI9AtYCMIOdEB2vtkvnZNK0D17M7
 K9JAQ1OKPyAJR/oL0719n42oigy9Xbdun69GKPnvd3x2WVBDdAmChjTh2Tk9xOz4yP74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k3LuorvWtgnP9nzHUSsz1ozedmKeL1fkftdFDxNcON4=; b=O
 eSM8ZtiijHqnZVhVoa1QGbJ/M7bMrip+YLycpcGXZK5XKPqgw5rFzPCCIhfnRbb8y+uwB/k+MtnXs
 1CZS/mYuRxuYGw4XUqIA9/13qPK15BctxxNxCbQ7D8wgqqjGNfQQi92YKOH0w+63ZKS2uCZfkjTx2
 /KMHJmq0Bt89d0wk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfGZr-0006mT-Iy for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:31:38 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so15647485e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782995484; x=1783600284; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3LuorvWtgnP9nzHUSsz1ozedmKeL1fkftdFDxNcON4=;
 b=caSTiu6/C2BzlZBygkXYP6aR4d7XMGmqk1nzExzXxm+cBKbXxcEIUBXt58d5Apvmuj
 X8MCw12eQC4rc5IgT1aIb//6vH6ZfpptDX4Y5npTpQef+h/eiRGj6+2KXJKqo655PbNv
 YK8vJlQdc1etjP5mnJFpLqckvlr7jKDs3xmvzeJ4q7f+oKDqsDZLyLSCphQSsMKuVdW0
 M69iITUSogBmI93xX8kLKEHKU1CjGSwGA9RnyjRpUJ5utl07YMpDhU00yLTumG+1UdIC
 tNFe1LLJyiuPrf9iNFxJxD8SP9LYkEi0InxOK6VM0cQ8MNdhglY0nV7x5aIbahvOXIeW
 mvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995484; x=1783600284;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3LuorvWtgnP9nzHUSsz1ozedmKeL1fkftdFDxNcON4=;
 b=VCyaN8ci3vSu1/ei/LUbvnouYJ/5aMjVu2jJE8518RZCNk71lEi852Crl0AAYo94wW
 OKcZLY+UsA2QhfomPRIamIhjF/zC7BbFHGAoNqt1sMTUbPyNfcNQfVZV4AnNj6tnX0wj
 K8eeOAlV1wPIIpF/f+W4jqD8ZEj6vBBLpwiRoeYZcZ/oJ75XkKox+K9J/zEDZG3R7nqt
 AAZh80xXjAF9oEaaXdmZmCNc0YND/uC/pE7qRKMsUJBARYMCf9RBEaRukwChf874eL+t
 UQa8mA813UZZa3i/SP3RL+4EKoKX/Yfm58/EyHQXSaQ46z1wVWKr75VGc5bkuhwYpb8p
 e5AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6+BFH4olwm+yOmnUovtp8p0czs4Ljr2j0AD5ABuoYuP2JpN8APxg+Yk+gwAkf3uSQFT8in6VoEG7cYkch@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwKie8NOjYNEF7UZDsodeQFfklzLvEw1g3E1jQILtCDW6gfKkwr
 xK9xTBmRMZ4zVuovzX5Ca6HTAHPIgpx6fmIt1c+iVPauWDhD4i6vIZ4hgvpwyuiJFNf7kF4FLi9
 4EHk0BHNYt22tQXGCUWOwWgnOH082VUZrUQzH8zq9sY9PjZqSijTWemS2CejQ37BBH3yX
X-Gm-Gg: AfdE7cn5QOIxnyTwMVwPmNvug1z2UQwXPyX+3Jaau8dNtb8ViDfOhlJ9HeE5a6dmeV8
 PmX1nAhcENSObO0CmgwfO1PvjbF8ubnDfuHs8K3yfZUASi9xnaREoqQ4LRogkI3L2tOtJxTcXlA
 f0E4GZJZ8IhqbaJh+tFaE9BKFDZ/MtnK3kaQPCB4/UpBmoyrfIMF25Q46/5ZdTJ/3oncstnMXNO
 +hdKhb1ALDnPZIZ3XpwOT7UiCW1+y6YAztMK5ooHsKyWEnlOxt9hNATCSOrQPmLOlOEQtWfJzZ2
 0rah86/zIRcjIog2gEudZbo1famO8mT/XT0KyjGunJH/F3JUaXvJ/031Yi6orhyboAr70gUb5Ap
 Dd5w3NsDo0CZUB4RcZ+BRvK4/Y1fv3v3LOdfS9dC1eGZu17zI3fB8yuNgi53H4pbh7rY3FpDR/x
 Y0s5zk0gTdVGWiTVQzDVJDpo8ZgW7glx2vsTsCD6A/snrRmoTYkAt/TkdAp6bvIYTNpddOfA3tj
 ssE0JbQ0ipTIAIxiBIwALoOYX8Nt+OqdOkSmizm8qMxgR9W2mV4h0cl7MWnvPZPT4ETKwYndDXs
 nzU=
X-Received: by 2002:a05:600d:840c:10b0:493:b9cd:1272 with SMTP id
 5b1f17b1804b1-493c3cf2f50mr54665635e9.23.1782995484338; 
 Thu, 02 Jul 2026 05:31:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm106089015e9.2.2026.07.02.05.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:31:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 12:31:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 493aec58151150b86fbdc1665e116706b34dcfcf
X-Gerrit-Comment-Date: Thu, 2 Jul 2026 12:31:22 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e85739400d6f6d1a9e98dfb4004520cd126e2f0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfGZr-0006mT-Iy
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4314576918364866049=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4314576918364866049==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kt2QdfK8Fec="; charset=UTF-8

--Kt2QdfK8Fec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/oob=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/9ef9c417_ef3b982e?us=
p=3Demail :
PS2, Line 95:  * @param expected_msg_type  the message type the=
 payload must carry
> If you document one parameter you need to document al=
l of them=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: =
1741
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Thu, 02 Jul 2026 12:31:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--Kt2QdfK8Fec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/9ef9c417_ef3b982e?usp=3Demail">Patch Set #2, Line 95:</a> <=
code style=3D"font-family:monospace,monospace"> * @param expected_msg_type =
 the message type the payload must carry</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If you docum=
ent one parameter you need to document all of them=2E [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d=
622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 02 Jul 2026 12:31:22 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--Kt2QdfK8Fec=--


--===============4314576918364866049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4314576918364866049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4314576918364866049==--

