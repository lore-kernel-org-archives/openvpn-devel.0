Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5181ACD98C5
	for <openvpn-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40miCF8fab6ax4BWkxVbZJcWLnbUahAPaEfCp9W0Go4=; b=Ra9fw2v8rtfwFhODC3EWX0iw1F
	7YPEBv0LyKZvJr3/TACfJEpFW8ezZ8uM90cOYoo8YuKqmZ+lQ4rktVizTqUqmiXH5JHoS+MqGhT4i
	AGDABgBajPMIU9BE0VIaWVef/VGx/bviaWsrZTxUiwVvKdbAnph4IXwVaEBpieXhyV10=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZ4D7-0001oS-C3;
	Mon, 15 Jun 2026 10:06:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZ4D6-0001oH-5K
 for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q4E9RuD1daVQxHFYcDq69YcSwJWwA9r3ENVU0V20zlA=; b=IqI1zrwOWa4HOUUN4ilie2d9oP
 yHLOExsN/8wxO1hJYjaBp11/FOrzMv1XjvDsuWkeXAgdSIHAeyO0cj3bBBCS9HbW3tQn/1u1TY89X
 dtrhHx62PtHCk+aU9dSIyappl1+YR1hLQ/w2YKJt0IPgfFSsrJImcBra8QPYp3aTkpik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q4E9RuD1daVQxHFYcDq69YcSwJWwA9r3ENVU0V20zlA=; b=D
 PHMgIxjc4cqMEUa6Qi6PNE9twUddFABbSOD2rASkfHo5rT5LIJXy5dwKE3r3/sOIH2dGAhKSTvCzw
 OhAafdwpgnkUpHdURcmHmFVqLVMvaKV8A7uzOZNiiF1Wy3gw+tkKIgzZdQ9KSILtLSqSWZXs7hphz
 5rGT0YdMKxKYQrjg=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZ4D4-0000DB-SL for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:06:28 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45efb698ef2so1568111f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781517976; x=1782122776; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q4E9RuD1daVQxHFYcDq69YcSwJWwA9r3ENVU0V20zlA=;
 b=NHVOAxdOFpSLC8U/1dBh4hQ4GIWxTLiV9LFRGhMmwuoJMEzvXTN4yum5cGHqJwJP+2
 yEXfeFQvJ2VDElyJIxupNqFKM4CwLEsxKU9RmxG2i/rcFJcjZ2tjYAyfQJj6U7H3Mb3O
 BHsB2buNI6YRJwDCxKw8UncQ9dK9MaOr9Hohr7sjbOzIP3bpinxsniBPeTVzwprq/sqn
 Bm1LyHMaTmQnf3m+qBUznsmCM4GQ0dBX8g5Q8Sv2H9EyeyKWQxOfXTjxavS1IhVVHI+z
 SVLhohMoJWhtRThDbSQH8ziHlqEMvl076Plt8yuPrWZOhiB/qIvuYrkwBxo4qMLrMO3t
 jz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781517976; x=1782122776;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4E9RuD1daVQxHFYcDq69YcSwJWwA9r3ENVU0V20zlA=;
 b=tUke3xAEL41CZCwWryisNO5bNOFaL9RGSon0GL3fJ6X/aUQ7FJtdfaLpmeU8hy3qTh
 xbMJRdBRqJmGzj7xZsatUliMN2w1JTfNmEDI3+e+hcSSXYC4FzG0BVpmgIloV0vVrtYG
 Ea0xFu/EKgatOKNhM/3HBQdu8Suo6Z9WWT0/C5zU4JJCa8GHdPDQoYEfzLZBAho2xlfx
 PHscQi2++Vzg5VdXRMxSNx5/g1Msu40QJYPuTAHWL9PVPPbvnvqobmoRMQn8JK21BeTY
 gd/MM9K4Z6NlEcRkKRG4vxJkuFPCN0kxI4ACorhfM/M8a2KgidM67t9nugDCBgiVBu/Q
 5x4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WnUH8vncYsQzUeyNmPKaCixytW5e6uyTpu/6Wmg0SqZKZl/JFcXGBGeZQSk3U8LTfY7QP1aGsFCrNhZnT@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxY6Tf0h1ZUQhpDIBuVVc4bFNpbvgkC0QuPBXZx6xCGDre5jIyB
 GYObhQcI2CySpurZTpyqauuHCstvOdp+vDtEMPXYOXTNf2cmhUmHg4FcDFzXEIrqAKW3GOcVjr9
 vwhxsBnbmZ1vUYuZD0dr91mDwjI8EzryxTSQKlD7Kxpf8I/CTFgw1CQ+hzHKlRdJndbdW
X-Gm-Gg: Acq92OEW6hQWpQ/TDibmNbhv4uRkAmPcl3L5dPic4lh5f025wb6s4hiN+eQem1dLiF7
 AlxKoG2lwH2J803uJWnISFz9YeOdPf2FPeJMzXNNmOVUzUKC57v9soOoY7NzXHL7A9RCYzUQbpb
 8iVw1pk3miXo4zpqsvj2EeUc8jUUtZlODzMZQ4daUFvkZzJODgiNc9jQy5j4610HrOGav94AYVt
 8cUxLbdHqSgFzgdXdHUYI1teTaQIjiyMdX20qhaZRFWWW7F/WXbod8Ai0lKofVa3D81rJ9zU/Z3
 soYQ/6etRQ9AiWeTWG+NnOzFZKkkcAin9AUIS5+4X9IK5tCytEjeFAj7sFcMgc0nQcOsTYARcMM
 dtyZGfPD2eFfCUNiJ2/dra1RzGK+5y8gweVxMosaV/Foom9m4CpWQjWy1pZKJ67ZWJMQhUFZC2p
 fRdBRpVrru033V/+nkFEKmKRDxM7EvQVX3ZZMLHu1U0khwD6laaP5vIsKBKJs4+WlPllBN91Yxq
 gB4djK7sHK8aOAkFJZtR6wfVknxTj6rrKJnU/A6Fyu9OuhFFzBJwCfJH1ZG223TVKRPZuQ2+j4X
 JAzQqQPyF4iM6A==
X-Received: by 2002:a05:6000:2584:b0:45f:f142:d563 with SMTP id
 ffacd0b85a97d-46074a62560mr12883770f8f.16.1781517975602; 
 Mon, 15 Jun 2026 03:06:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm33197058f8f.19.2026.06.15.03.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:06:14 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 15 Jun 2026 10:06:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 052e3fc122f867d848340b684537317f5d28ebb8
X-Gerrit-Comment-Date: Mon, 15 Jun 2026 10:06:13 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10e2cfb76a1b5f2114a28086b0032d61eafd6f07-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZ4D4-0000DB-SL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1526854845335695797=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1526854845335695797==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BaKB//V2L7M="; charset=UTF-8

--BaKB//V2L7M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 6:

(5 comments)

File src/openvpn/forward=
=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/b33923dd_b35d=
d207?usp=3Demail :
PS5, Line 78: 
> can we have proper documentation commen=
ts here?
Done


File src/openvpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1635/comment/32383fc8_4265d587?usp=3Demail :
PS5, Line 2035: =
{
> This function most definitely needs a comment to explain what it does, =
and where it is called from ( [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1635/comment/86200023_d64fa367?usp=3Demail :
PS5, Line 2132=
:  */
> We need to extend this comment a bit - the fact that it deals with =
only one socket confuses me every [=E2=80=A6]
Done


File src/openvpn/mudp=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/37b6bec0_fd60=
4124?usp=3Demail :
PS5, Line 364: p2mp_iow_flags(const struct multi_context=
 *m, struct link_socket *sock)
> let's move this function to multi_io=2E [=
=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/83=
887180_78763e16?usp=3Demail :
PS5, Line 375:         if (LINK_OUT(&m->pendi=
ng->context) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
> I=
 have my doubts about this change - IOW, I am not understanding this at all=
=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1635?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Number: 1635
Gerr=
it-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-R=
eviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Mon, 15 Jun 2026 10:06:13 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--BaKB//V2L7M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p><p>=
5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/forward=2Eh:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1635/comment/b33923dd_b35dd207?usp=3Demail">Patch Set #5, Line 78:<=
/a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
can we have proper documentation comments here?</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forwa=
rd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/32383fc8_4265d587?usp=3De=
mail">Patch Set #5, Line 2035:</a> <code style=3D"font-family:monospace,mon=
ospace">{</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">This function most definitely needs a comme=
nt to explain what it does, and where it is called from ( [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1635/comment/86200023_d64fa367?usp=3Demail">Patch Set #5, Line 2132:=
</a> <code style=3D"font-family:monospace,monospace"> */</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">We need to extend this comment a bit - the fact that it deals with only=
 one socket confuses me every [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/37b6bec0_fd604124?usp=3Demail">Pa=
tch Set #5, Line 364:</a> <code style=3D"font-family:monospace,monospace">p=
2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">let&#39;s move this function to multi_io=2E [=E2=80=A6]</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1635/comment/83887180_78763e16?usp=3Demail">Patch Set #5, Line 3=
75:</a> <code style=3D"font-family:monospace,monospace">        if (LINK_OU=
T(&amp;m-&gt;pending-&gt;context) &amp;&amp; m-&gt;pending-&gt;context=2Ec2=
=2Elink_sockets[0] =3D=3D sock)</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I have my doubts abou=
t this change - IOW, I am not understanding this at all=2E [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change 1635</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b303805a3688=
b6f6363140c76853a58badecd8f </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 1=
5 Jun 2026 10:06:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>

</body></html>
--BaKB//V2L7M=--


--===============1526854845335695797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1526854845335695797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1526854845335695797==--

