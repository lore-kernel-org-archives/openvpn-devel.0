Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39EFC55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qi/w8CUZELNJ1itf43rwdKPes3FSEcrAuN0GBAtikkM=; b=M930Zmr+ZI8jkcc3xfSALfj42/
	H6HEk9PqgnS0jpeTjpH9eErhXNuAl5GIG51fzE5nVqfRCyk/4+sb7WtCvFCbCcGIaSuiPY+TQaTP3
	opZTLX6VsYw42dTKcBzTEpfIn6HIK24F//R6Zq0+V0h5YmyZCSh0p1MSexR7H7uNG/Vw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwT9-0002f4-94;
	Thu, 06 Aug 2026 11:41:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwT8-0002ex-B0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:41:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mGlL9qgB+Fo+mnrfCOhbpVGPAVM+FleLyYIoG90hrNg=; b=XPs+vOx7lK5tS/eCwux825C3Ov
 rVuOiTuQf28hbmOytFn9HdLKvWFNS200SEDLl6+IwYUKkNLsz0DT295/R7J1+gcqjPsZgzcU4KDZi
 F+aUayHcDhr1t9LYE794wecfZm2NDteUoj5X1Qn7BWNnj92+2TI67ryD0hYSTcsfHRSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mGlL9qgB+Fo+mnrfCOhbpVGPAVM+FleLyYIoG90hrNg=; b=N
 VbY5G6H0009hwHv+hnYJA//WsruSlRz0I146muQ0QwHkvgU1PZ6ikArBOCqDLyL+/XJ/aa6tKZcdA
 0ZZiI6HKmaUPNmBKerNpRF3tXtOci9wl1TOqpBJNZUNHFdt7uSZvQJdzlyM4iXPhrS5Nd/6Uv2JgW
 aF7FDKQOIGjVMpHI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwT8-0006iv-8F for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:41:02 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so17554465e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786016456; x=1786621256; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mGlL9qgB+Fo+mnrfCOhbpVGPAVM+FleLyYIoG90hrNg=;
 b=Tq+blNBi1LRjoh0IFi30P614TxeArC4iPPg2m+wXTP4fCTj69NwNOmyxZqVFtJa8zk
 VQp5glLf8eJrrmO1s6JTgjiBTkB3jNALDBgfO28lze2Jc6q+fNBagCMrxyg1S+wiWJky
 8Cu3uqrmftvdbDd6zX79iCaq4o9bqXk8QszRI4Y1Gqg+2YrJcIvyZwNQZNffRQp3S2Cs
 ugoyP0HPpLTs439Ng2TiyDNhkNwLVl/BnoujUIJ/ma7ZyTHSBUgWbzuNPgdJme5drrQA
 HHT6y4eJRD5dVEsOiEdQoYKrXizIOYuIyMkgtAT25DrN+DGMBqntXeRAeSfJfPAQLbmU
 AbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016456; x=1786621256;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mGlL9qgB+Fo+mnrfCOhbpVGPAVM+FleLyYIoG90hrNg=;
 b=EPvzQubdDcpbmZ9dMvDJbs+2kMYxn5XImJbD8oBSxls9vvvmsTAvmE4qj+YD6iXAMW
 yxThEzMM3UPROHKeLt1mQZjIBlIbAwwrSjSi/1Zk61XTKbVB/dkCkLFsiw+QxY7RZf6F
 8v9IUrFn2U/8qkGxNXh488v80AV0MadkOhmBJapj1cMBiTrBQnEemn0sAYvFZscIXpYV
 7wp49xhj1BLA22Mm86iu/mhpvZnhTRPAZKv1AqXH9/PEgdMwTMO70MqU9AQVu32wWQNo
 20PpDP7rFwRgKi09ms+SIU5F2KGIVMgGbtX0WtUXAoWIvcd0lnF/3pWrgs5jv5iLSIGV
 pJDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrji2j8OHNO3Nv4f9/hs/7/VFnX375vw3djjA7cWk4MsT+tKderOvR+kRL6ZbvWr9/rmj9CCWxgyrxc/a3R@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxgcra5iaBmTENctSN5szxzO9FcDz6L1eFf9LLEqQScfUkEPSC2
 8fEOu6PYIhMcDaLCooo1jRpkkjyGkkLniCbTSLJEgDE5YeYrd6tZ1+VF9KpgqtjxfQVXO6+EM83
 DkSxyomH8ZVqJaLI0tBdmZb0evMmTt3PYHqaYydvvvsFnYKAPI3DfkKQ4r2B8BUWFo3LdxC7uxp
 Indj9ZBg==
X-Gm-Gg: AR+sD12onmuRmw9IY48ICGWD77fgWmzXce2R6Z+Z636xSPQ2zt/lAD5UjmWObfqC0XG
 wUPhRZjUln7Q0Nz1ISST1BHxlkbJRpRyyfQMFI6DHHYeAZh2OAokDO/DKw8vHpRVaaqG/C7F520
 w1KC/KsygBQH/RupEnBQ9448ORp4XVL44XL4K5Mb0IhgB7M9a9xyz8ziI7T5uBA7S8fjc4nz2+E
 qzGUiwTT4O4sJ1MbCcMJ8qcKD1UDmky+fu6inelWOsaA4w24tim4sf5pzey7dmFFw9BSG/uFa8V
 RT+X/PbTes+DZUkKa3X19SU27/UYBnt2Z41PG9uYixnECztomSFP1cnr3Z0mPco4VujVhCgH/1o
 WEu4vvaGjeiEz+TFZe5ARpP2vDKSx5nRtaaTTVlKvOoCqg9xxOiYmEEb8ZIq/uab12QdAlGRj/8
 fP4Bt27ooKUNMBlD/4Pf188iO4aPIWCt5HaGk+SFpkMVdf0F669YuH4Pc/Kdmombdg9Ry1kWcKb
 tFabxwLlbNKjs6JI76XOIg/voMwHyCUuTsWsls7MIkXwORBMEtt6o563P69GgmemOC2O8G7nFLr
 A57i1rsNI5IWb23ud38vRSwsHWlvZRULbl2wsM2056GsNGQ4Vsk=
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id
 5b1f17b1804b1-4994e7d21fdmr167228885e9.16.1786016455492; 
 Thu, 06 Aug 2026 04:40:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995428f294sm56902085e9.15.2026.08.06.04.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:40:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:40:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 031918103f2e8e2063368d0e347a72ae8b95ea1c
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 11:40:53 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2cfb12a1200c7ed3ea74cd70eb9229fe3ab4dc97-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwT8-0006iv-8F
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
 ralf@mandelbit.com, frank@lichtenheld.com, antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5722631994632972437=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5722631994632972437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UQHlo/acono="; charset=UTF-8

--UQHlo/acono=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, ralf_lici=2E

pl=
aisthos has posted comments on this change by ordex=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exi=
t the process when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838=
949fe9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 3
Gerrit-Owner: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention:=
 ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 06 Aug 2026 11:=
40:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--UQHlo/acono=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, ralf_lici=2E </p>
<p>Patch set 3=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">chan=
ge 1835</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Thu, 06 Aug 2026 11:40:53 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: Yes </div>

</body></html>
--UQHlo/acono=--


--===============5722631994632972437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5722631994632972437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5722631994632972437==--

