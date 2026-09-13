Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C700BC88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/gznbEcSKVmBH0+2sdpuPYmpC5WnXi03cm9Xybvgz4=; b=ejgOr61AShfJz5s0nUNoER703c
	TzBY7WIqhKqPY7nwkWcq8Ju1vIeST942dZiAftD/tJ/hv1ndSbSo3GsxNu4PT1D10u1Bc3fUrUg2E
	6jY+dhcaBS4X8d7PLNTpgUn84VTFZRViWeI+s5l/Arv9Tz/DoiftmMfE3EzU51tObs4s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gkV-0001BA-FM;
	Sun, 13 Sep 2026 09:43:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5gkU-0001B3-5U
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KO3jLeVZslgA/sN39UUfXOYBTXzKI5kOOcQ/4fhdiVY=; b=WKR9amWi11pJP1sx+lpt9BUXgA
 Jgf4uk9+OxWRrZnP/Ab12NtvoldeIwiHn1RKuf91cWmQH6aRcumxz/4sViRSdjcMg8ADm4xPcofQa
 m1ugGboTjK3/RbRazt1AAk+mBgjJy1aiFDyMBAB2ITq6hZ+TAFcrpZCJL/25PUE6anfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KO3jLeVZslgA/sN39UUfXOYBTXzKI5kOOcQ/4fhdiVY=; b=h
 nOWeRYTy3uVKkzkiVvl5agAMNIgZZp9178XcM0PrtATPxZKQNsxDqgUm02z+fA14xo1PVuAM85qXi
 7sjNi3b9jeUU/27aaqlddCTOvLD1+uZpZ2GD3XKTrTS3rK8uMFD934mK+1K8VmQjJhRijwQzuRGp8
 gMFhgTWPmgSZsk5U=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5gkT-000512-T5 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:43:46 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so475530f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789292618; x=1789897418; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KO3jLeVZslgA/sN39UUfXOYBTXzKI5kOOcQ/4fhdiVY=;
 b=VpiVPxiej3Ql6YqHAq0jZkYemDPmHwIKYxXM7EdWWiX1eafoilaxXoKbrU5E8RypfY
 5TxZXbmKw6zYcUTjVQERoVJhivzHEtQLnoX/IKjIcVh9cQoI0GqUt3R3SBp8XvKNXI1F
 dFZhifmFSfxcqte86xjqIiWnn26hloTgAcATqsX96V/uuBIMNPEtW70rsfK+hIyhUPY5
 PWi1U6HnZ0tTCWbf25/mN0fd004JYSCStR3S2rUDlwyPB6M7zRKITHavP1sNQOkhYc/j
 f7R0ml1nv21ltpAWlYo1w1zWUOIgoN//eGGa7xSJZRlg/4uHk1hiL7OHR9szGuceKp62
 JL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789292618; x=1789897418;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KO3jLeVZslgA/sN39UUfXOYBTXzKI5kOOcQ/4fhdiVY=;
 b=iq4lHKcTAKbh6A3SO/w0geosxAGBPp2hd+rw24DFCo5t24esb2FcwmBzD3KDAvY52i
 vHYteODskebD7ezguMErltCUPg2pR44PNmh8GwHe1V82BTVFQVHV59NTDPmL5v61RzBP
 +N0ieKKp6kaflMyukwtvbsgJ72STVT1qu8lzWnJZbY50oFJjtbacAMeNQd1njopJFoVF
 bJA2HHOU9w9YU6WU+1NwDtf/DzIgDK21HM1iVqlb+pMNOcqXNGbdCFybvf83OS65zPWX
 myeoZIl1diEAgmN4PFuQd98Q3iVE9IeHC7BJ6sitGEdKQuLixzr7Y1XFLtikitJjjz7u
 FhlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYjjmyykE8NMi8ndKIf9j6vpymafMkDW2j9WzjRA6yTHAG/7v/QafK85sj1bl0lSAPxrvZZ/lajQD5Djtg@lists.sourceforge.net
X-Gm-Message-State: AFuF++lR1hJiXQnQxvlBwarvgrVU/07Yvj5G1141Nc0HH0kR6CntSF5F
 bZGGudtuNIuKPReNqz78562Gor5YbjDDEYwGFc1XPami2Re91y/l4OppxCWrsHRe6bEuZ/+KfDs
 pT22meU8xSITwxt3qbFSwXQuxtIHoh4efZy0Nk2caxGlSiAOPqoILGRAB/yG6Sd97FI2C7cM7Vy
 LJ8B9YTw==
X-Gm-Gg: AYBFou2fL7H6yj0zIvJJCbM8k3W1+n59M6Vmng0/Rawf8t4p6OS4uJAQYtDOhdx+opq
 E3kT8SwBHC8bG7H7QtGTZ3n3GYilnK+H8AYfcNp9uOVnPK7JP8/M26Dm6tpx33wDzhngEcPzXH6
 dxx31W9cVpgKYWlF1q+AeznyHyykmQ9qDa+Gd0IvoLfaUGkJcmu43z1nFXVulHcdjrC7j33A6Hg
 62nDIf9Bi0LF35C2LoKUqrPqX3ONTc0hX/rqZoobn5CZKRyA1scK+OKtwkRBj//6R6vsHHvD7nD
 gPZ4O8yH94+yf72o7hvwabiC+8jhUG/axgabiiwjf7H4Q71mSlBI3wUA1vqiFQmnlDEAHcpDUwP
 +mCRS4IGdyudMuIKNkUSPQFa0ZGykaHX4+/iBlBzjYYCnDht8hp81HXrb15vLSIdOnzcWECbvkn
 yP5JN/BHpp1txfS8JLeLzaS6mOp0qmMsvArhmUoU6MJ+nrHVBDRVsC153SgvM2iBPz65WIKaARE
 bYkPEnGCDSBtuLF5nciHklqQKrWmDf/QpEHNVgFbsjb6YU6iLgeQR0oc7qmZB24BYOTG5YtuiOu
 naRCIzTutYWA3GhqyNhEYIp8ko8CvoHO9erv6TUsc17T/DZ9a37aJtSSuffZ2TI=
X-Received: by 2002:adf:ebc3:0:b0:485:b14f:ec44 with SMTP id
 ffacd0b85a97d-486eb336324mr10204085f8f.44.1789292618033; 
 Sun, 13 Sep 2026 02:43:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm18155968f8f.22.2026.09.13.02.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:43:37 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:43:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: 7a0342ba24ad6d46a9afd3bb0e128829450cd455
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 09:43:36 +0000
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <291cb35238cec6ac236bf61163eb4818a7afefe3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5gkT-000512-T5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3397355996899921933=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3397355996899921933==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qnx+mdi7Rp8="; charset=UTF-8

--Qnx+mdi7Rp8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1914?usp=3Demail )

Change subject: options: fix unsigned underflow=
 when clearing domain_search_list
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(2 comments)

Commit Message:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914/comment/7bc87ed3_c5700913?usp=3Dem=
ail :
PS1, Line 18:     o->domain_search_list[SIZE_MAX] =3D NULL
This is no=
t true=2E `domain_search_list_len` is not `size_t`=2E It is `unsigned int` =
and wraps to `UINT_MAX`=2E


File src/openvpn/options=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1914/comment/b78d0c03_9dc5cd4e?usp=3Demail :
P=
S1, Line 3784:         }
If understand this correctly, the following would =
just remove the loop, and with it this whole class of bug:

```
o->domain_s=
earch_list_len =3D 0;
CLEAR(o->domain_search_list);
```

This seems to be p=
revailing idiom in the rest of the file for similar fields, not sure what m=
ade this case special=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1914?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Gerrit-Change-Number: 1914
=
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sun, 13 Sep 20=
26 09:43:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Qnx+mdi7Rp8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914/comment=
/7bc87ed3_c5700913?usp=3Demail">Patch Set #1, Line 18:</a> <code style=3D"f=
ont-family:monospace,monospace">    o-&gt;domain_search_list[SIZE_MAX] =3D =
NULL</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">This is not true=2E `domain_search_list_len` is not `size_t=
`=2E It is `unsigned int` and wraps to `UINT_MAX`=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1914/comment/b78d0c03_9dc5cd4e?usp=3Demail">Patch Set #=
1, Line 3784:</a> <code style=3D"font-family:monospace,monospace">        }=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">If understand this correctly, the following would just remove t=
he loop, and with it this whole class of bug:</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>o-&gt;domain_sear=
ch_list_len =3D 0;<br>CLEAR(o-&gt;domain_search_list);<br>```</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This se=
ems to be prevailing idiom in the rest of the file for similar fields, not =
sure what made this case special=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">ch=
ange 1914</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I3724236d4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1914 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Sun, 13 Sep 2026 09:43:36 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Qnx+mdi7Rp8=--


--===============3397355996899921933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3397355996899921933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3397355996899921933==--

