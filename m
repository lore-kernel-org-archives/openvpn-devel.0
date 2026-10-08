Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA1ECA600F
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZVBWTKrHWOWSPNa2thJLgq58JhVDBoWLa/wb+e3UX+c=; b=NEjO6y3/9U1uZDFa6XLeYznfgs
	CMqDXr7vhMXTCwRPFCBvtPHPOuenLmxU7CaxhzfgpwS6oHi+TR0903cqZAcvktxVnVYFYKh2EcN50
	UjzHBzQkBdxOHBgAQrnbaczIud5la4XctqzlEO9BxnJ2zLfO5Q4MxhViMKyVuxjqptns=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEl9T-0006T5-Ci;
	Thu, 08 Oct 2026 10:15:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEl9R-0006Sx-RC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5HGMRQ8LWtSWCbf88vM+P26K7qwHW3NQQZ54LgiY+jQ=; b=GlhhN/lMEsyRP6v3WeNbX8hBPc
 rrRjByG+6cFlnoWjd7kLkMifPf3ERvMDPuoqQftXt3CyaDGaGjeerkwofK4fC7/HPvgvOE+TM1VRd
 0j1yYxH6cDODmXcTwZRFJzkz+dxJqav4wPPR2UZWSFYSMVSOFtIQE1y5wfIxrsIwK10E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5HGMRQ8LWtSWCbf88vM+P26K7qwHW3NQQZ54LgiY+jQ=; b=K
 mt4yKtRp1YhcBmFJCa616qRN9weJlC18qn7hCW3ueiYqO5Qi4i1GJjzjCpJXsNDdKADsqPzcSyVGq
 ngOsWyDMhXbW9iYq+759ak3VZgn89kJf1UBF7BkDvrvkwymcNhENbS+N91Zb3rRY/TimUgjOm1u8D
 tKbQP7ZvsVIKbd1I=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEl9N-0005iu-Tw for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:14:59 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso2967349f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791454491; x=1792059291; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5HGMRQ8LWtSWCbf88vM+P26K7qwHW3NQQZ54LgiY+jQ=;
 b=OAI8g3v+9PJ+tggDPAYqTC39O4giDy9yu/Q1GsE/VPFTleryEQuratG8l5Ev0GHjVI
 ke248qVWqsrsmnihSzr+Y+8NQgirGAVIJHW/zGIlsHXUaGgVxpG1yIZYmFnfwg+lnyIR
 0jPDNBzPE7ExpFKDiCt3tvhswGkbRj8r9+zgS1IjZdTQHbeC6Pdq+m84OoIOEb1/ZeeI
 XLoIMiFonO10JRdCahJk8LqTfODCFOj911GGfDcTrtssJJWwemr6mCHGKPI8rnXdFHyf
 rIL+Q5GGXuoB0n94TIRoD5Y9fnC73NdBLkYt5fyDtk3J6wJ5NplUYvJE/07erv1SBa+K
 KPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454491; x=1792059291;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5HGMRQ8LWtSWCbf88vM+P26K7qwHW3NQQZ54LgiY+jQ=;
 b=RFT0V3bD4y69LWSmInmZ9D9jKTh5PDC+AgmfeGGlNPc9OBfhKf/Ei0bhsfUcxB5yyn
 yJegG0eYuyS+WBO04HHwOWol/QDK5Qg3J6HajbCPgEW8nwuplQ775ZzcmG53QroJLh4G
 a3ZdCE/C3WochHjjg5+q+Jrxw1hpmpo4rgylmD9oow365SGQqjoscJsTzIhRzQx+aYm9
 QKp+bxcaxWduJCTFsPUswRIaLJqNefhwXuPKgnplRpvRCC2UtYMBZ5iKNlYgbTDo/ozd
 m7nt6tIiz2maBjScgyiBtOXPoSd/JQoZzzoKhM1lLStJqhK9tTWX4avXvxX5Dt/4OAFT
 UFaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKKSZv/rwIp9DT1Cjz6xiNSc3yNXHnk8XzJWpsyVQWt7FV9IRcUIxsV9fKfNdG0kAKpbCDzjHMR76BviDK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJmLQLWeDzlTF4lRXQApwOqSI6X+SSTY+O3lItrbKh0MpNPGiEJ
 dd7qp1v+nOa20O74H7PJG5tFbnjtgSQQsh4xSHABXpejioRR0x2FANmSD68xlfERxRtUsfswIto
 tsWlilWwDiuz3au5KTkBgpEHHKWQu/N8H0P4nXri+9M9A48/sHECp1Jqng8k3bGzzTZmwtgP9+5
 WtHcUYpw==
X-Gm-Gg: AYBFou1/PwW4dG4eHhxBx1EhhdiuSzzD4EbR83Hof6XLfOTnuAaXLXJh4+N59Qxbhdj
 ABmciuXhLFVl+GNPE2acB2jQKi3DN58MIqudhAZ0XZGLONRtT0N9Y0pLvjuYa8lj9kpb5j9V658
 KdlyvGCjt+crsTKGe54oZScm5cwktgcr2L5ono0PRAJhrCA7S47HbyDipj5fKLEzI13iN3DHxOk
 UeB94cyH0Re/PYe6UxjRdbzDPPNhAugzYC6WvYIgaLqoptpd8V5uLCKOGeMueTF0V9T+b2Xvu8c
 knqK8TSp00JoayUiFYisRs1VMDDH/nIf6iHDlO+zD60NQfWclg0aNMwQwwCZ3Dk8qe65FJ6Y+3r
 x5tBaH2UkpqFMI4HysFoye6APxzCgIh8eqVxiuQ9XQ1nZO+jO7mjrwGIrS3PJ/NPN73dk9XTQiv
 PIX9KWZs7N0QrccwB6wCQKw/GxyE8DyZ7L0A2Q5zBrcf+VGn3Virv2sheo1qajfxOMIAVXn2O7Q
 nZqBW8g+yQpC3fWSvUarQmpNbcHzLCydKFfGQF59d6upbi9KFy97ALBr7g9R6B3f4EOBaKB68L2
 JpkRHYt7tv7XgVu4pRKHC/2/Ss9+HNeXrlofCSbm7JrE/DssloLAIaWIjtRU89jVwU2Z1ns=
X-Received: by 2002:a05:6000:2888:b0:48c:67d8:abd1 with SMTP id
 ffacd0b85a97d-48c72788346mr9587162f8f.13.1791454491245; 
 Thu, 08 Oct 2026 03:14:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71bd7983sm10676269f8f.6.2026.10.08.03.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:14:50 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 10:14:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 5acd7a922b4bcdb4579db8006d8db02c2d38fc3e
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 10:14:47 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38faaee38e2013104e3c2d6e9c07f41877d5c384-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEl9N-0005iu-Tw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2293273523566558346=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2293273523566558346==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xO4FFqWzV9s="; charset=UTF-8

--xO4FFqWzV9s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Arne Schwabe=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subject=
: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32:

(3 comments)

Commit Messag=
e:

PS31: 
> Done
the TCP part was resolved, thanks!

However, the second p=
art of the comment was not taken into consideration=2E
It was:

"does not m=
ake it really easier to exhaust all pending session": the ceiling is unchan=
ged (connect-freq-initial), but the per-source-port bound is gone - one IP:=
port can now hold unlimited pending sessions=2E Worth making it explicit, I=
 think=2E


Don't you think it makes sense to make this behavioural change =
explicit in the commit message?


File doc/man-sections/advanced-options=2E=
rst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/c493404d_58c1=
746e?usp=3Demail :
PS32, Line 42:   If ``s`` is specified, the size of sess=
ion id hash table is
missing "set" after "is"?


File src/openvpn/multi=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/6b49a325_2957490=
4?usp=3Demail :
PS32, Line 275:     msg(D_MULTI_LOW, "MULTI: multi_init cal=
led, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
I think you accide=
ntally reverted this line after your rebase=2E These should all be %u=2E


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd119331b1987=
92ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 32
Gerri=
t-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Thu, 08 Oct 2026 10:14:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No
Comment-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--xO4FFqWzV9s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Arne Schwabe=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727/comment/f43135c0_7dbf0a65?usp=3Demail">Patch Set #31:</a> </p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Done</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">the TCP part was resolved, thanks!</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">How=
ever, the second part of the comment was not taken into consideration=2E<br=
>It was:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">&quot;does not make it really easier to exhaust all pending se=
ssion&quot;: the ceiling is unchanged (connect-freq-initial), but the per-s=
ource-port bound is gone - one IP:port can now hold unlimited pending sessi=
ons=2E Worth making it explicit, I think=2E</p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;"><br>Don&#39;t you think it =
makes sense to make this behavioural change explicit in the commit message?=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sec=
tions/advanced-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/c4=
93404d_58c1746e?usp=3Demail">Patch Set #32, Line 42:</a> <code style=3D"fon=
t-family:monospace,monospace">  If ``s`` is specified, the size of session =
id hash table is</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">missing &quot;set&quot; after &quot;is&quot;?</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/m=
ulti=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/6b49a325_29574904?usp=
=3Demail">Patch Set #32, Line 275:</a> <code style=3D"font-family:monospace=
,monospace">    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=
=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think you =
accidentally reverted this line after your rebase=2E These should all be %u=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792a=
d1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026=
 10:14:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt; </div>

</body></html>
--xO4FFqWzV9s=--


--===============2293273523566558346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2293273523566558346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2293273523566558346==--

