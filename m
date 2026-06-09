Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6A7CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q5oHVYfb/VObGCkpvsRm79S2/UEKQFacut/peoDLY3A=; b=fuLvftw2NzEsFKaorlUJ4D33Rv
	VeOX1otUJR5etHNAQiAJHlzSWPJ7MW/rQFeN1OqN/B1jaX9Iv30fvHzpLaUjuDquTxxZLjeCHtbAt
	NRAXsyrA2irTQKFV7CKEEqcig/iIfQVOg3f37FhDMlTj4wF6FkyBGjT3+jiyZ2iRBAS0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxwd-00015O-Cy;
	Tue, 09 Jun 2026 15:00:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxwa-00015C-Hm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:00:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xPSjBt58IzQPfYHnjjbFHmCh+BYaHUC1WBolwxXWV88=; b=EvOMGKypRwc95LoxoxT9ch9ULn
 hsWUTXggzSd6V+coto6ifFBXIY48H/bnINUQwi4xPrAuq64co4gYVPR5koy6zRK9LzeEtBfh+ECCo
 GKiY/ggT2mWbcQ/oi854f0QaLtX1ny2e/D00c9pw2eUlGy/CQEBKSM/xKFtEWWDljg1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xPSjBt58IzQPfYHnjjbFHmCh+BYaHUC1WBolwxXWV88=; b=F
 PSf2kYMJZyW1ccT/Mp+N3FBd8QRloU1ebhv4H/B5/P1hSQyAOZiIwiUFB08GLGsktj34zhyU2dogN
 RlaKqcMocuV9B0o77Cu3JD2zzv9wwMgbj+t+CDDOwtwjrmhPmWFHczLy70xWxUwf9bJvuJdFmP3+P
 omxG0VK4ESUIiQB8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxwX-0000Pr-Ts for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:00:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso43689965e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017231; x=1781622031; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPSjBt58IzQPfYHnjjbFHmCh+BYaHUC1WBolwxXWV88=;
 b=R+2PhH783D9P1ZTX68kZAmhSCPst1HEejaXvUaCbRzypZml+8eRnB5xgD/lG0CzuOw
 p9BzyP7QSDYCAn5lU0+c6h8BpCnDulCj6sHiDvXH9YXBUDqZ0Zl6Hjk3QS3M0ETXhYeQ
 sJb0tzcdgiGLMioziwqKNOuOAn5qxnRvMWGhKottP0WtudosV97WLztUEvH8CfCFQjkN
 hoGvxr2IwJbsn/0U49hXJ+UlDLaNwvCKCG0gaEqfZd4Jo+dUszmjZCxDbUDSrIb0T5Sh
 9RfkHe/57TLkBemlTJ3ZUp9Lt7DNyUq3iJk8sOnJTWnGmid11+TJCCSKn0kTeLsD4NYw
 JtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017231; x=1781622031;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPSjBt58IzQPfYHnjjbFHmCh+BYaHUC1WBolwxXWV88=;
 b=gQ8zPtRKw6GavgYe0njAahQu/NMBXH497apJWz2I8M44NY9rRe0spJTyoR5ggOZ7rD
 sPemk8MqTIMrHVcmKxQfkJnKN67G8pTWS4qXZqbratRK/uVtY7qBPIRZdFA1F3nB6Gw9
 RDm52SxvHB0urc/CTCTlHpumU4cRAIrqwmsRSTJ9iVPRFL78/0yZ+9H/jsKu4GLGRZxy
 nPABXRbk+sRfRkTEo5fXgd5ryyDBWrGf2XtYdiVdnTDjox3rHxIH8ajP1E1lyARbpl+K
 tPkZd0DtcHyLXtN7tFXFnqu7pJ7md0ArupkUWDXBFGPL4amOWWOMrp5tmDY6DiWyjSrS
 HuSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7J76k79mH7DbMc3FkUYq8mdexLDgwyyDLVBohq3MQ82zZd+yEArKuHXtx+lwGUx3CWPhr8GadG9cSAUtr@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyg//8kn3UVFp4+fOkFGU9zbiweZvnLNZ3FmLMwqDJBvsvFbyYa
 U5Lk0J+VENfbtQpMvQ/GEamU61HPx4eN7o6OIVgIR8UrzA989/HnIiU1PSOrqNAWkUk/WchrKKA
 pojrMR7986beesS3Wi3ZDT9P4RYlJw73NqF0s7KYD2Iw29LqhoetYcl+mdQHZ2vCj4dfrNA5BmL
 N2RlY/1g==
X-Gm-Gg: Acq92OFSXcCoYMWiZKULhBuPNLEJ+DOWLZYnXQ0+OxM9DqTXQhhBGXGKQFbZkUVtclm
 xZzQ4oB8A2FX+NuZxCcz7ATb8Bmm4vYL/eL3CtHilz+Yt9aMwHiXUcPc8erzOEBBva8VxR08Rvl
 O0sx3IuhaU7XWTDRzHewp8vw/HAQ0AKWUm1qNVEFeuyDOVu4MjbClrB6PJqV+aG9y3QpR4gHp/v
 38VEy2gq0jh4SjDjMn7BHXw0/dc5Kzo6MpbfwsjS/Lt/HneTGX51rd103tdf82kmi4HQOUFP7ov
 nkHtiaLDM87zs++zkdzZgrH8ZNpOsTCbDlBGS6ZloQGqAtUKcNzChrFf4gdEdqo9uSuAlZilkSo
 L2Vp6+XB44AyvxZWVFQvvJDaGfVx0GNymW4Cp3oUGLrvj4QdcPJt+T5m0nAqM8qmsGi3JyPmsJd
 CvyY7RKzp3ix2UfkiEsXkB9ervYG/YGPr2JRD/J8Zgv4yCRb+EHweuYYVQLTep2kJg6p+N5h3u2
 smHzx3gP0nwBZmpBTpwVB52ZWjJFv8nOG5yg/Alk4/OkhiBqv/QWjP8T4lIHXhsWZ93ZjApqFl5
 szJOrl2Oi2GK5lBHNWkEvBO9
X-Received: by 2002:a05:600c:45ce:b0:490:9699:4428 with SMTP id
 5b1f17b1804b1-490c25c8522mr290287115e9.26.1780990258894; 
 Tue, 09 Jun 2026 00:30:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm57273449f8f.16.2026.06.09.00.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:30:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:30:57 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 813856dba54347167bcd041b67ed831479cf37b7
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 07:30:57 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f6e0d541295f3d1b9b82cab03ed5f5687f05a2c7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxwX-0000Pr-Ts
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1552765782132190621=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1552765782132190621==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BUULG4H+fFk="; charset=UTF-8

--BUULG4H+fFk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex=2E

cron2 has posted=
 comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset reply s=
ynchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1702/comment/19e74ef5_09f25a8d?usp=3Demail :
PS1, =
Line 61:      * dropping on EAGAIN is acceptable as the client retransmits =
its HARD_RESET=2E */
Also, I would reduce this comment to focus on "what we=
 do", not "how we did it in the past, which did not work" - of course one c=
ould make it work asynchronously (just create deep copies of `from`, `aux_b=
uf`, `sock`)=2E

So maybe something

```
  /* we do not want to keep any st=
ate here, anywhere, so we just send the
   * reply to the initial packet sy=
nchronously, without queueing anything=2E
   * Should we hit EAGAIN on a bu=
sy socket, the packet would get lost, and
   * the client needs to retransm=
it its HARD_RESET - which is considered
   * an acceptable compromise for m=
anaging server resources under attack=2E
   */
```



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
G=
errit-Change-Number: 1702
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianm=
arco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
G=
errit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, =
09 Jun 2026 07:30:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--BUULG4H+fFk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
02/comment/19e74ef5_09f25a8d?usp=3Demail">Patch Set #1, Line 61:</a> <code =
style=3D"font-family:monospace,monospace">     * dropping on EAGAIN is acce=
ptable as the client retransmits its HARD_RESET=2E */</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Also, I wo=
uld reduce this comment to focus on &quot;what we do&quot;, not &quot;how w=
e did it in the past, which did not work&quot; - of course one could make i=
t work asynchronously (just create deep copies of `from`, `aux_buf`, `sock`=
)=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">So maybe something</p><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">```<br>  /* we do not want to =
keep any state here, anywhere, so we just send the<br>   * reply to the ini=
tial packet synchronously, without queueing anything=2E<br>   * Should we h=
it EAGAIN on a busy socket, the packet would get lost, and<br>   * the clie=
nt needs to retransmit its HARD_RESET - which is considered<br>   * an acce=
ptable compromise for managing server resources under attack=2E<br>   */<br=
>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I2df0fec786184b9fcf9b7=
c56c74816325cdb6942 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1702 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jun 2026 07:30:57 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--BUULG4H+fFk=--


--===============1552765782132190621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1552765782132190621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1552765782132190621==--

