Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681A9C5AE49
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjBdAF6P9fe9q4P+XmgPPJ1sktmrkmwFsi1Qy38/d5E=; b=LoafjWovhS8KRSOn2IdXYzNac5
	JYcQaoYKJIPCZf90b8ZCeHHouaqoPd2CHpw0ByZriAbQEnMlTk0nmadcZ55/i2TWsIcV1PhW8fY2Y
	exggSF/a0ERus+hL7V5rA5oENvDRgMLKKAfb1Pg6szCZOdbKsWJaKcxlgdiFZt4YH7CU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtQiV-0002cn-Q8;
	Mon, 10 Aug 2026 14:11:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtQiV-0002cg-0V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 14:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qKATadQV0uDc3hoGvDLxAPwixgOICCx58RzDhtrhoFI=; b=RxjrIl3gDzcmQY4Hh7eHYsj2AK
 r2EoJ9tmSlbBLoiDTzZYCiIdhUDKHJCNJIaDF9c1IVMLWdqiE75oe2+NNu2ZlcJdYo5kIg3kyG/b8
 SfVtfOjtWGgXlholAYnZMgygQhhZpILSWk2kb/BDFos8/Ug2P9i9d8T6mf4ryCMr0Cm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qKATadQV0uDc3hoGvDLxAPwixgOICCx58RzDhtrhoFI=; b=P
 SDlXacmlfDRcjpHm5gLfbPqcmNWForcMz1xai55avUxm6M7Z293vHmyIDOo6+dlRbNc+3ucAes2da
 7p0VZtkn5Ww5OUNFyijMKwfN0+xjSEAiPCbzLiCly+jrP7MHH/x7SvOzAx1M5ITWmEA908drdvJQm
 qLKv1CVSqfcYZxiM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtQiU-0006lh-R9 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 14:11:03 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-495437bb891so16219675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786371053; x=1786975853; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qKATadQV0uDc3hoGvDLxAPwixgOICCx58RzDhtrhoFI=;
 b=OYgUw+a0LV7KWICKW9GI1zARtNjpaBNvig/66jqQ9OClM5wpoAKQB/2Rkp+ZE2ndqG
 hS49nLgrHsAJcwh/nrHB1jdk1DBeh+JDNnx4dk56Cy+ttCBXNzXpupt3U0ANKe6FmqgE
 CXqXpTL8MfVuTW6pDQW6o09SMb+MNivnWDd4JozuGi1bBzAVSx7eArOC+W41hVvkSKeR
 Ch4KqCHqUleh+1JVJKhza9QF6OZhhEQ3nVwN7wCB/e7uwx/P+8ghLs1BcN9PDrRzyWkh
 d4LPRsfhvrI5Cec3YI+XRgK6kSl4ZdED2LF4pL58su1nN3h8y4SNGdCWryzILIhK9Dbz
 tH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371053; x=1786975853;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qKATadQV0uDc3hoGvDLxAPwixgOICCx58RzDhtrhoFI=;
 b=kyWZUMWf3ql+68vyVFRWxq5eTgaohTcE2bEcn0lI+//G5mqWyU0+4IjcbG4Sxb80vd
 nrNj3K6xeNBvQEze37fws24l0p+Ajl9Ke7zb57kosJKwSt4Em8nrz6Fy82UgcbJjoCbk
 eur7Q09xaEtfRFlxsRTHBZwXfvQQkq6XLTkP94KZEiQcu3r0rwOaLi6cifOGiLPePLrr
 Q7fKfrRW3M9OI8Li8x//fzwXywB7NIzcfliy5+aNiiQGcQBrDQ9g+0iajA2O8aXSYzZ4
 E73AdxEBC1oRBD7y8XaCgAEDaVsatQOpT+Nw/XxZQ4MN53an3zaDjcf3WklG7Q6OscBX
 NY1g==
X-Gm-Message-State: AOJu0YwfO+1BO5hdzQ+HGEx+lHzIfThPDC+5nZGpNRpdqwsZExFgiir6
 Ct1ci0dKUJOkrWKAlaa7aGEh/z6IEbkIopw2jybjvefwIZXe6PEE3YsFMPBmErld/R3zeVfbq1W
 zgsQhgulOYShDf+z5rG1BLbwprxUdxe6hT0MwqbFB+KgngSqFVxjWq7nNh+0ctAWVAV1Foh5ZMd
 pDot4+SA==
X-Gm-Gg: AR+sD11SOlJCWb872ODqSksjbaOTMChymoKpWE9YHx7k/o37NBXnK46hYqzks14KsgM
 7/BW9KK5BX7L+gcs4lnTTuzjTpJ3VRZSv8braUkG1ihOOOOiCV8Onu3Cev7nFvrRq5WNFMrws0W
 faVM0GUqlJ82D3Tk0JfDiugjY41b5RbQ3gphyLo1LS0lh04ruWKKHWqfe07q17en9e6jiDJCp+Y
 Qnf3HjCuWhiWKYfEhdeEF8LrCvXWQwSqPkB33mWhL9bAb5y9tOhZqk/10f/mgUDptdyqmatRy7c
 bwLoxzemLNHCN1OzU/55EIJCe8P0+MQvUEuG4Em8uwtfmTceFzLKSYMr5f30wD9dwPdgSRhFSrO
 d7blMfIpCqzyzkDdcu+Pf6DxqYYVNUGvggKAWMN9lUWthtd27Y4VdQ6NJlL30OKwLM8kOYFVwek
 sqBVUjyKGZsumCoxN3LO2qaYvptUod+obBjT+doQcKfPGHJa40owXeXuyywwX5XawPYuX766SHF
 A7nMwKTu1XERhnHJnIz3ualF22n0ob0+LbWjqrCq9h0r+gp3Lkpx2B+TdQoyGetFikh3Uufv62g
 alHlZnNJex2R3aCIbRks8xyHvfGY8VRZyKrGXzFNLbwVa3PzJio=
X-Received: by 2002:a05:600c:6c50:b0:499:60e5:248a with SMTP id
 5b1f17b1804b1-49962484763mr160656735e9.4.1786371052368; 
 Mon, 10 Aug 2026 07:10:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fd392sm33397316f8f.31.2026.08.10.07.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:10:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 14:10:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: bc395940fc61b1c251bbc3a6e1a435bfd28f1d88
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 14:10:48 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfec85354db040bb90bbac4083b7c17bdd6c3b05-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtQiU-0006lh-R9
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6342985864495029397=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6342985864495029397==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qm0xkCFNwkI="; charset=UTF-8

--Qm0xkCFNwkI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 26: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
G=
errit-PatchSet: 26
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 10 Aug 2026 14:10:48 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Qm0xkCFNwkI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 26:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac20475=
30800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Mon, 10 Aug 2026 14:10:48 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--Qm0xkCFNwkI=--


--===============6342985864495029397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6342985864495029397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6342985864495029397==--

