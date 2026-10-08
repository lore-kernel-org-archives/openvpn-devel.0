Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5663BCA600C
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOaaqbgb3BwLN9sjQ3z0a57ODS762n2UbdPCy8qsHho=; b=F38gThcD4SPggQFMNzC1MgHBD0
	ZD4Z/wGvZH2Cp4FiOKXmxO31s4xhgqoOYTsALX3clp7Jf3RCMP7nPPJx3jnk4O3zl0LzxSkvszmuC
	Ex9nFObjT0M1DzfMRBZFPpJ5I5UgGmjEjjwaVzi4VG8hATjJfF+PZa/DzTD6bq1xq9MI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEqiB-0006g5-01;
	Thu, 08 Oct 2026 16:11:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEqi9-0006fy-Ec
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ythXZLRSpiYUNIf10eWfYtEHQO4HL15EVYoHF4JW+8I=; b=Jg43CD3h4W69hq7KEAxf70Nki4
 xCXOODCSpSxcQEnbh9L7WkmjKN3LHK4XDm3q8HTOM28nSDYhG8RCPVP4ePPOiPCWnJw3q/64xbxv6
 9iCJwuCAkhx+rLHEboZMW7LphdErIp457sjvix5fcXZ8PsfS86DwZhL6/wumsTT0aoFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ythXZLRSpiYUNIf10eWfYtEHQO4HL15EVYoHF4JW+8I=; b=G
 JXWIyL4DVQy5v+teZIF3DjWGYtW4kiuHjm6rEb6BsxTR+3Mmun0mJ7GDjvJ6IVWfR0syt/rwwKPy3
 lvR4K+LYKnrNgdoil8k1zyAxC03Nc5hUL4uMvVeRSk6TN0H4u8weytJ3z54J+FDg8xud3XHiCu9Fk
 M4qsWG55Z+6zjero=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEqi8-00044a-Rv for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:11:13 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso49853165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791475866; x=1792080666; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ythXZLRSpiYUNIf10eWfYtEHQO4HL15EVYoHF4JW+8I=;
 b=eqaXLwD/4HTGJOjLdCzaJmCP06Qfx7UTXdScOXGJtYcLcsyOSCeQ2jOan3y/aBp1LG
 Cwb1XzMsayX7uGAlB+YDG52XcR2mTbBrL/fLBd6t2tW5hd8ag5nkAyEBvOVf2fcJfAN5
 jLUmLmx6ReTdRf4GnPkgRd1unZ+GxzYpGB+JI6oWRWMP06GbZVjrVLYHA5tg4j6CC00q
 THjxzfMbu0vJF5EY53y9hxwcwDcaZxZ1ifd1NWbnBiIh7+Tzxf7cEKr//adT8YW5yuvb
 +AhtvvzMigKcu8IElkiEO9NL8dlUX/KBqghUxfYI+sjQ1ZGtxNHM6ER7EEHGxFB5REQU
 GSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475866; x=1792080666;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ythXZLRSpiYUNIf10eWfYtEHQO4HL15EVYoHF4JW+8I=;
 b=B1lJg0lFLdYyZ2lytO/KsQkULOiHukQGWCTGpVS0tw8NQ0u08ZdfKK28d4ip5vsbyk
 kM6MZnOn4sogonGjh5pmx78TDLXcgGDNybGUAqU8caSPBPb6Xn9lmIQ3ArWdqhG+x/9w
 rFOogDki36hGZCtuIcTRDi6xNz7zeb1OfYNKbcoeRK7gpMfIETC460nQkCOCAQUxWyCs
 fa2ymFLZIGMjGWDKkXzuAeYSxD41zTKf8492h+faQiXZ8dEboaYdjW0bsQLmOrpqp19a
 yomFbCvoYk14KLEtVi0SYT7d6ApK9oSgz4DonHL8lu0UhA61VempNHFJCuPZg/kbPZU2
 +SYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvH9JYhqU6NzHU24pR/Jh8BrSwMEYBzPChmF8OvE98fyOWpGZoIBCBXiesqvPcLKf20azBe9b+tnqplsvY@lists.sourceforge.net
X-Gm-Message-State: AFuF++k6MVlZGqGcbECmNxJ9QVciiR1IZMJIcWM4DrWoeYXTo8jPvv/u
 1rjZaGIkaTzO2JevFSkNIPDoILVKJ34t2dhhFIy5Ii/nvBtLabalrHUnPD1gBnEkkY8HpqkpNb6
 MBt6HtZIdAGoPyg9HClXE2YlWd+D7q5vEshK05EAoWtFYJoXYPPziPWHB7G/2HUnWoNrW
X-Gm-Gg: AYBFou2pVdZoVEGdcNTiveKl23/hXF089e8u6aCA5BtqXmoJ9scM4gYz5hPMt6Egg7y
 bgcp6Uvo4Bz6f7DH6D+s3Gl/FTH8WqXRLajNsOzMcQBuKzBHHxlh5ufHGR+ERo0lkTktYS4iBfR
 7Aal5qQIFpZqXhbiZq+3N+nOhVcBWUXKL326uT411kBwQeta01gXKbtuBeja33xUc3ovlihCksO
 LLCpIQDB5NTrzDLEJZTKxYOENiFiFFI5r0+A9qnhzKPmwMl/FQoBtaxOSHnhnVfewtMVLqKQMSA
 NoFN7rMofJj8DqL4JFJVDkxi2eEv2ruf+9kGlgdeZon+ugS0hE2eMrxUC9yZtXxj0wLHUEpzjS3
 rm4+4DeDcaMk2tTzqt1xo2q2CTM5gd8tq/6iluHWxyDfyInFxdY7K7GLfIPJ6glUNxFb10nGkg8
 q1GU8aWslXtu5BnarQHvubDdPNXHjhn5hKYNZvxQnZjPapZXofrnSCM/AVniVg0NHOq7cl6Q0iE
 /ZH2ZNQPrpyj+fT7UJUgqGSgNBoqSDHsEby4nC+TxnxNPH2NgC6TeLak9TUZtd8BWXOZETDvisj
 ohia6BDQqXH81iiMulhvH1jXwY1sKYMfbRC9sIXcx2Lhk0AQJTBnIENJMGLP
X-Received: by 2002:a05:600c:5254:b0:49f:c1a1:5222 with SMTP id
 5b1f17b1804b1-4a180679d9dmr106326075e9.33.1791475866183; 
 Thu, 08 Oct 2026 09:11:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db65321f3sm328571f8f.44.2026.10.08.09.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:11:05 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 16:11:04 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: 86829f5cd9d89561c5eae4bb556b27432bc11f79
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 16:11:04 +0000
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <114a56c614e9e350d79a08864f3a50820c666f83-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEqi8-00044a-Rv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5698892119935107834=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5698892119935107834==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IdrSnwq63Nk="; charset=UTF-8

--IdrSnwq63Nk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail )

Change=
 subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27dd=
bfba3cdd
Gerrit-Change-Number: 1987
Gerrit-PatchSet: 2
Gerrit-Owner: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 0=
8 Oct 2026 16:11:04 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--IdrSnwq63Nk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=
=3Demail">change 1987</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1987?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1987 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 16:11:04 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--IdrSnwq63Nk=--


--===============5698892119935107834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5698892119935107834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5698892119935107834==--

