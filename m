Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A24CDE001
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVkhozVIQofBiof2OSdAyPr+khR/S29DlGaUod1gRw8=; b=nTBD///Q5t1m6xrWvk8v1ZJrB1
	K3Ea+FCVvUcxzXHPz5ypfRk/SMZKh9ogpcXruZ76OYjHVUQYTQmpPWgHOiqBNFPlmN7HZAkvrA2Jj
	R8njH86Y0VMBL1YWBfdaDXtWPwLWF2bzyT+Tp+WcVcyDBHSc5WqRx9StGpM9u7d4H7uo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcl63-0002WH-8E;
	Thu, 25 Jun 2026 14:30:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcl61-0002WB-Qg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8tx+TFxEXR0n/rfFmzLrLAlojiRjO7oT7oGsTgQsK90=; b=NAf3w82UCgQukWPPZXEkSzUsGG
 fE40wm8RGZVezZJhXh2I5bjfF4e7EBlguFq++EBIIfiUdmP7TMgblILslVkL7kDuGMpxXwr55gfDZ
 QPUXravGNSd71hbZaFWXmQPVZ5D5lKHvCfyy5rdYATDXoUajFGvmjwBq8yeDM7l2eK30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8tx+TFxEXR0n/rfFmzLrLAlojiRjO7oT7oGsTgQsK90=; b=N
 X48ReLbyqohxvv/rucEu/3XNbEf+wWSGeRbPHGUZu2VHYCGFcytU9UcSYHNy23fvpWOG4BJBgkuwV
 iKZwGQX2KoDu4rspcmahnxWxF4OuYllZKkHqyXsW89WynT0y7n6isjoUrLuxrZs9Ye0+MplPAgGzF
 J37PfWAsdgDfCf4I=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcl5y-00043I-Hc for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:30:25 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so15662335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782397811; x=1783002611; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tx+TFxEXR0n/rfFmzLrLAlojiRjO7oT7oGsTgQsK90=;
 b=PGb43TF95dI9aZK8/pzXH4BlD2WFkA4PptYx78PY1tBdj8RXj0vjwUr/53B/miywYT
 fPRuZSAdFIzQrs3gZwSvIDnuVOXqv6rHq/GULIpxF3gLt0yMUZeMNlN2BTcVGphtHBwq
 djhJjOKan28kz19m/uV7StqiF9xz1caJ42+8fNvgrIVzZ8bCFJcQ8GtaM+7OAqQNrS0Z
 caUIQB7M6wsXPbcdtZCxs2ef5Jk1bTLYDQ8i0Td0SgwXsnZ29qsE9RFoQv3hSYossdhd
 sG/b/M9CTIRYaqvxt1lf31rmHuV9o86GOY7KEiJcvl4QTbc2OKeGNQaPLryNeovFYTMd
 5oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397811; x=1783002611;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tx+TFxEXR0n/rfFmzLrLAlojiRjO7oT7oGsTgQsK90=;
 b=rGxeY3N7tS/k9jFeZC9arj30RLZoIYyJ1Gso4ikygngFrBVOrG2mqr5IG+7NzGtJG5
 uJ7cbQS23jH953XV+KrqxFtWe6PRJAgjCGy0zc29XEvfpKeJFWEnlp5ndSUJhvZxxGu7
 /UjYd6g0Bj7WTOaBKOel6kHlinMM6X1yxYNUSBLjbrZ/93jXMIZTzngh2huQTgTlvvAl
 KKmwhBH4yC4mMEBhW+d05r044vTkkXD+PL3Cn9gH8rXO5O+5OIVWHZCSt7jSuH6lioip
 9lVPFE1pH+Y1+d36cWmI9arWluP92zyDjOK78Br3sn8hnRzd+PAT7fJU6YSSgJZFvWVC
 GaGw==
X-Gm-Message-State: AOJu0Yw/ik3HuAYYDTcTnzDmhvoQgC5d7yhQUARd/d5g4+BdzDyao48S
 ag9Ga33NMjIy+rmOgdk8bRnTi9do6qV+6UB2zQ4cPx00CVL0trtfS9BUQMHnLzeUpAo6N8UUo0A
 SlVwQ6ydUMIUlCHN9kNaJ8/qaM5EoJTESRGp+op+DbgLB6YGQ5k5KMdEg8bI6nltwmfUwS6cNKU
 TxoseKMA==
X-Gm-Gg: AfdE7cmcJbNPY2nbsY8kBf7dIszPCL8bb3gNJrwyQ2Uhk2HZZgcErU+J+hoylv93RnZ
 OzmO9bt/Hn7aXo8NOv6dp4YQmJC7J+B8N8kkWNPcqViIHdgyW50DC8Wzbvzci65rUnPptSccvqI
 zWqRD2+7IGvlRpQ3EkOs0aTQK+FnCHRzQaZjYPrpfdUHH/4eEtqbCEiJ4Fg+Xb/SWSXhNPqXN0I
 Ih8/hROtbU64FyS3cWXKd/rY4o1gBDvvKGpWg2SWJpIhZxosjIhSGWW7iZ5sGsBhsQ7c2jGun+K
 Zm6ECQYBSuonxOMxbKyv20nSmoH86ua3A09113QIeFZxK/Ra7iAjwUc/3PlO9KeOF3WV3v6IE8z
 mIHlZU1Psuc+IFzJi+b7NaGNcc25HhMkw3Kc+3QpSpm6H/PX0rrBVERKmyhDNlx5N3nsMT6d8z0
 +rC/OhvG3J8p7sBods/AsrdyCD94YulsYaI8OYyndwUrxm2UObFE6dcvU4FSq3xQbgYpd6HHWKg
 1kSY+sIkdYrGDK6HcYnwVCtVf7uEhDY62Xu4bsOtaLpEQVIAEoLslF+qH1X1M0vLJ2e1aSK2UwY
 Aos6VGd8T1H0ag==
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id
 5b1f17b1804b1-4926689ab05mr39343235e9.33.1782397811137; 
 Thu, 25 Jun 2026 07:30:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49265fef873sm36919095e9.1.2026.06.25.07.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:30:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 14:30:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 3f2f6171c104d6725e08d3889206a373f041a627
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 14:30:09 +0000
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <043492d719d8409794a3dad6b1912033c210b5b0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcl5y-00043I-Hc
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move incoming data
 processing in its own method
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
Content-Type: multipart/mixed; boundary="===============6009585376904258687=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6009585376904258687==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TRc12p6r0jA="; charset=UTF-8

--TRc12p6r0jA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1722?usp=3Demail )

Change subject: Move incoming data processing=
 in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review-1

(2 comments)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/1b50b74d_15ee=
2180?usp=3Demail :
PS3, Line 3310:  * data packets, so the be be forwarded=
=2E
"the be be"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/3=
dc352b2_3e1dc02f?usp=3Demail :
PS3, Line 3312:  * @param m P
If there is no=
 documentation for the params, do not include `@param`=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a15=
75bd5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Thu, 25 Jun 2026 14:30:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: Yes

--TRc12p6r0jA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722=
/comment/1b50b74d_15ee2180?usp=3Demail">Patch Set #3, Line 3310:</a> <code =
style=3D"font-family:monospace,monospace"> * data packets, so the be be for=
warded=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">&quot;the be be&quot;?</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/3dc352b2_3e1dc02f?usp=3Demai=
l">Patch Set #3, Line 3312:</a> <code style=3D"font-family:monospace,monosp=
ace"> * @param m P</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">If there is no documentation for the params, =
do not include `@param`=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">change 1722=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f10=
d91407347faf32397535c95e2d80a1575bd5 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1722 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 25 Jun 2026 14:30:09 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--TRc12p6r0jA=--


--===============6009585376904258687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6009585376904258687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6009585376904258687==--

