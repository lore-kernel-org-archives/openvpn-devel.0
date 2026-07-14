Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E0C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RkV7Wv36NmsSVlkUuW58LcZvM7py/CRLzwEcsp1A2lc=; b=P02HVyjXNmT/alm+1NRLRpLR4M
	oSukUWAIOgP+cZMEyHUZBsX0Yc64RZysyAE2vfuhq2u8495D/wKSTz1Jwoe2F8pPMsGHncLwnRqOU
	/iyaEILDXIc0K4z0GZKGpV7+Eu+pA/dJFp1Yza8ublqU3qAT0D4HxbNeVM6DeiTZLwWA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjcAA-0000Dd-AA;
	Tue, 14 Jul 2026 12:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjcA9-0000DO-0n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qb1WymG9RF7owhQ49lpvhG/meX7+nMvqHDAYtZeueJI=; b=OIb0nUqDhH7SFliPgo+Bi8Kv0r
 cdIPOPFqyzZCygH8m5Ur7Hh9aHEfK9jMLGTJSI1SiWbsCKPqcGhD1r3X9FYYmh6HQCikznfmJN45S
 87I7K6qm+e/Z3W35nb13PmgtKOd6FASyFvc2Vlb0vl5yEif0+eq7OEmUDZMM8oqInVN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qb1WymG9RF7owhQ49lpvhG/meX7+nMvqHDAYtZeueJI=; b=f
 dFIYOy8qDww4siHX1LnRGFWQ8meM9me0CL0+8XW+UHnqTQPHDYDenrIBh5XFt0Fns0BB4tzAzKjVL
 9pimjM0QRLcufWNcXLz6oQLkyuI3IKo8rJ4Ee6W+jY4vagHp3WAMRKtvHdokSK5xRpzGaYXfLKQgP
 u6zDOpTjENwl2rUk=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjcA7-0008OA-Jx for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:23:00 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1877485f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784031773; x=1784636573; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qb1WymG9RF7owhQ49lpvhG/meX7+nMvqHDAYtZeueJI=;
 b=NfzT4oM723DmM3p34q0NorFvgZFHiAZfQT1XM6XXd0n/9Y41Ueuft23+ApH61MNwIE
 xjLHWjcYA1OPTI2UfSVNXCrYx+OsiWcivo95Ugk36AnwfNjDWjYDHXbdk6alFI+3v/zq
 SiRzlUESME7H6BqZnMiLMwQ2WHrVR/SO5iaXkSP/wgyNQ1FkkHDusTAtq+9hmEzUrs6Q
 riMMQiMT/+tkzi2f8HkImxoCG+Z1B29fRbvSKENz3gwAvCR7c8KHAfpOkevGhuv2I7+l
 +H1H+/dhGultYxi0cJPIxF773RHbkhjdWYAzeArbsT9hjro3i/aozQqRFpQ+cLPlD/Lr
 scyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031773; x=1784636573;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qb1WymG9RF7owhQ49lpvhG/meX7+nMvqHDAYtZeueJI=;
 b=BN6vPI/YYFcfH3+Tzk8MMfHrU+MMZkxAwQLmVThTj9Ivu2wlR+ZFoPcZkAAV1CmTyx
 GOA473uWSotr6UVirZ1yfb09LDHImFMVhu54yNOiViwI8xYmLfcayx3b5U5zXwgt6ddL
 PpOFvMQKPdmtPnDE1lAj51CtziwYjztVLghdFdGtOt3fhFATTS8GWAdLdtJ3C+SZuKHY
 jLlxJbPJvz8YpD38rDi8zAy88WAmahy+LKZsy59Pm8oxO+aq30O/1rn0S2sHOV0jyLcx
 iYvuP1Fn1IeZo474YrPd2JoZsfN6Xh+hbufglFDXO7RKS3dS/LRvDToQvYYAyFxj6DlI
 oDUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkLcrxYbbcB44y35L72hKJniERKJ93ulIgHg3mq8or01+X3Li1iZO+lHvRylON1rou22ckeaPzemyzHNox@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyOUUVQVnltYd+1/dJWHtvy2g5cyQkg0LCzIcTGmFRIUZa969T6
 CIlYzxoiwqO9GIpIDzKH4OEwJP9PKIg/SqLC3u+TIMfhLLnteUjX0OFNVju74VeY2P9kHoZQrFp
 J3y4t9EeYd6aosClj9oh9179Ghf3h7uiBFcrk1e8B2pS8xf2WubMra08zbgYKQLyuyR+gMzDSVJ
 MjZk/R2Q==
X-Gm-Gg: AfdE7cnWcyYH1JgJhnt+jgCl7I/V3EwioFVaxFfKFFlCL65sy2OIOxMeVXQDbLyir20
 jB4oRaYkayoZZLKQ2vOQwwcxja7Fk/9HccFG/oo4K+Z7UhlBNO6TA2Tzms3yghRcV4RPqfE5D3g
 0D52boTJiwwYkSHJGCXuniwCPcwhOFMqQPdoFc2Ny7+TTdYT2lTFSxOBWZVGNa74uy75kIZocIC
 XHkPO0KXVGEzZhZ644C4EgExJECpbWEbC/inaR8BlpxkhNq+LC7L65rxuh6viSPJ2TGqcJMtZiq
 2/pzArWvgUulizltSNmqKHgtdXTXPx5sKDs2fth34DRWAynw0GHKrPjfqDfTLr2eJUpbhSavRdg
 6XdcKlBpc6Ehgrg1+90WeP3wg21o7pYmUmgE+uIFXJ35e/vEXuINasTvZGYNVwrj44CLYdJ6Zfb
 qomnFxVNmS3z2feBb/2T9VLRt+j2PeaEo233H55Z/gRwTgLV1F9MbRkiwr0NA+EhyYikhzQSOQ/
 5BZfovfU7CD9VT74JXDDmTvnaJuARiG5WKLlquzLKrEVUt4GBXx7XtXwGTBPBBe4wTr+95DuF/B
 pW0=
X-Received: by 2002:a05:6000:400a:b0:47f:25b1:e7b6 with SMTP id
 ffacd0b85a97d-47f2dcec940mr14447117f8f.30.1784031772768; 
 Tue, 14 Jul 2026 05:22:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c9cc3sm7809127f8f.35.2026.07.14.05.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:22:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:22:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 30112912578226bfe2e750920037a567b6ca5a16
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 12:22:51 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4c5fe620fb9a0ab93f3a9762d97c288c58bbff1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjcA7-0008OA-Jx
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4176090143083269692=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4176090143083269692==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KE8xeI7zeyM="; charset=UTF-8

--KE8xeI7zeyM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instan=
ce_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/mudp=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/94cb8b1b_b89af34=
2?usp=3Demail :
PS3, Line 297:         return multi_get_instance_real_udp_r=
eal(m, &real);
> ``` [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Chang=
e-Number: 1726
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 14 Jul =
2026 12:22:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--KE8xeI7zeyM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/co=
mment/94cb8b1b_b89af342?usp=3Demail">Patch Set #3, Line 297:</a> <code styl=
e=3D"font-family:monospace,monospace">        return multi_get_instance_rea=
l_udp_real(m, &amp;real);</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1726</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f184c7d4=
9d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
ue, 14 Jul 2026 12:22:51 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--KE8xeI7zeyM=--


--===============4176090143083269692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4176090143083269692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4176090143083269692==--

