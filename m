Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E3EC61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DyUkdtbipXDKUaQWVCyBJkLJMSmveyAsHioSHSbyVD0=; b=K+5sf5zZZwDdsNnbUuu1uda5CJ
	Pe38DTYDNY4lixpTmJXDXjSHqZ4x4UG7BDTAupDSgAXTmis0gs/rFcxGUdwUKp/+XJWbRkovHQNna
	CxHwx8F/WOX/zwx04swMyih7u6Ii8XvKfKGcTYQ2hGkyGvvALsPsVVbnOCU+YOIEd5wE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jqU-0005yo-V3;
	Sun, 30 Aug 2026 18:01:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jqT-0005yh-5P
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=R+/NLxL64bj5Eh2cuqFKaDKmdGHy0tvCGTh4yJak/QA=; b=Geg1fl5+G2COxjJyENHKVL3Wku
 cieLMMReB7Xup9xJHBuZuMAymmSM1K3N3k0q3NhHcJkZ5zrlAraR2qUSkfx7CKS3Lb/J2P4wB/3jm
 EhwnmREbJvQv56MCC4QN3/uT8b30fd7iARyoQdfIeWGt1PNnkleZerRqVQO51UqaUt6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R+/NLxL64bj5Eh2cuqFKaDKmdGHy0tvCGTh4yJak/QA=; b=H
 0ahxRvJfpjzQtkz/17dMSPK2Vv/H/AbtsqMjlQH51Xck8de9rkAnZ8DOQdEW6pNtsIggW3WQvsQ8L
 WCh6kcQ/MSEOZqjdBVK5KqIYFsiinL75xLCoEBPY9GQBXlvq1yNTlIMXB4P6XRp+QALk6dJVKkyra
 QMnMuHruzx1Nf3bQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jqS-0002I6-5X for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:01:29 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1312559f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788112881; x=1788717681; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R+/NLxL64bj5Eh2cuqFKaDKmdGHy0tvCGTh4yJak/QA=;
 b=LdoO9aUUmHcvnQS7BD7M6sCQuRS/bfdj8SRAUmbAZBlaGZNk9r3qJL/FC70JJsiPcz
 /VSn4W9lb3eAvut+W2nCfdrtgrhkCF5qi4F57YB3Kj4ZqmarZtGd/DQifQBe0d71Usrr
 ojx5bWAp650PQ2Wgivp663CDckcgwt1OKEs/cMlp3wjR35p7ER7hV309UKaSy4FJ4Evk
 5xdKXoDndVK7dz7Sd1YnxI6HGFhlf8QTZ/vyg9JrOMg1pyzpB+E2/mAUXT0uOQf26m5Z
 0m7L2mP59edxUAreb0oIDrfOEtTa9mtd/9FXdDvcHvb2ydIVBJhuIkAMkW3YYXKkOt3M
 N7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788112881; x=1788717681;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=R+/NLxL64bj5Eh2cuqFKaDKmdGHy0tvCGTh4yJak/QA=;
 b=Ilu9HI/Q5DY46fYAIO69G6/WZ/5xahQGDO7STCYjQDhnXmgKH2K0mjkau2vpJuRUMp
 rFbwEAsQR3HyH24Tp9nufH+n0VJYnzXeiFfGaJX4b44bygVGSs85g7H1/BA1pjXrv21k
 15l5PutqddQIC18mvqdFjnrdYbiho5Qkeosz0Nhe0G6dihWaLSnqFWYI505N0E3cBoQm
 bQRUfHLEYSQrjOJfh56t1YQPt7VO3ZfFOWN+u1aQi3tBnsdgEjhg5OorJ8Pl9a0YsdDs
 IwJGxLqIEZoydVZJdLmvPjq9jgpRdafhFequ6lUkktrOYP/O46oko1yzTtSdVFknq09M
 7Sxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGks5IfW7l9fUMUsrigi2sAWTHc38Sfv7urx0SmXzV16maWpSD8qGDULKwKjoLrCIP9oS5J2lQoIbXsyL3@lists.sourceforge.net
X-Gm-Message-State: AFuF++nlcdd0Vr8IcQ+ba+1XaDedITLzqZkhXDcvDdMKok28JZw6gxX4
 rLJN3kVxiMYWttF+ZJjUPNsEogQh8nrHpYAMhsqZ8WQAjsFclbmXjOtdCQE9QosVHujsM4ipFP5
 a6g4XJn9ssopColqwC35dNB0qNRigtLH2GEg12Vs5DCQuDFSOWhoa6WvqVs5q2X4YAEjF
X-Gm-Gg: AR+sD12QDJD1x81sEiS0LtOgIf1nttipP77sQDYSVuznzYBbiPC0woiZuAHOPu0RygI
 B+dKhrEkYftOxDtFXrvu0MehR/vl7hh2O7QuOBwJd6fZFxEf7d7vaEpym5pzFvM429ITajjVCSj
 +yi5Cvdn4pZ51WlGKy3dgQu/6HvVqtkQeLqYocFY8K6GSzU6FAoywJbG3cw6FFL+fT1xtNH0j4o
 yg078ZsdymLQB/nzDhbFZaiqvnZCEk0zFPgIMo4ykryrBSHsjF41j8xdgM6WW6avIkG/M+jWLim
 Y5Ra1r6Lw8EDeLWjs/W33OSS1eesEtq+mtcudgfQaG/kjnRUsmLAR1ANOIv6hC3AwYu72/iL3AL
 IIPIaCmsnsJiszV7ZTAjJ3wV6afxtMjotccb38/ekmBRbLz/ErHhDd2YvVWlQPQ4ZF8pcpIJbkG
 M2m1E49Xx6VyKyvIPYwrvY/Ta1asVc03n5ucQoMnAZVaqtbeTCEUlM5UDmlbqni4Kfyu62EXkAu
 EQz5JIP8tojLvXe7TTicWwQXZ9r/Z2qM5zjEUsEiFre7RZxj+IYo5EeAf0vZURCf9kPlVtS4aXR
 JJHVYHUCWnnznaUMsHwsnhbfk714HaZpMPukOmb9vTOyFLdSXKU=
X-Received: by 2002:a05:600c:a016:b0:49c:d60c:74e0 with SMTP id
 5b1f17b1804b1-49cd60c74eemr55496005e9.13.1788112881360; 
 Sun, 30 Aug 2026 11:01:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b963c3c0asm389719135e9.10.2026.08.30.11.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 11:01:21 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 18:01:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: 5666e7ada4aee52a1277fc8f24614b6d9f2f418e
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 18:01:19 +0000
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32110daf3784db2fcc7441af887def0835f06ae7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jqS-0002I6-5X
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2026619068555281816=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2026619068555281816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gPebAL3oHHY="; charset=UTF-8

--gPebAL3oHHY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail )

Change subject: run-cppcheck=2Esh=
: Make it more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868/comment/a199211c_b672104a?usp=3Demail :
P=
S1, Line 10:   adjust to the verbosity of the Make run
Maybe a misread of t=
he intent, but if we want the verbosity of the make run (as in, the way =2E=
/configure is run) to affect the cppcheck settings, I can't figure out how =
=2E/configure would influence the value of `V`=2E

E=2Eg=2E, should `=2E/co=
nfigure --disable-silent-rules` affect what happens when we run `make cppch=
eck`?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65beb37a2d82=
2333aa888de1baf11dfcb8490e90
Gerrit-Change-Number: 1868
Gerrit-PatchSet: 1
=
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 30 Aug 2026 18:0=
1:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--gPebAL3oHHY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868/co=
mment/a199211c_b672104a?usp=3Demail">Patch Set #1, Line 10:</a> <code style=
=3D"font-family:monospace,monospace">  adjust to the verbosity of the Make =
run</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Maybe a misread of the intent, but if we want the verbosity =
of the make run (as in, the way =2E/configure is run) to affect the cppchec=
k settings, I can&#39;t figure out how =2E/configure would influence the va=
lue of `V`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">E=2Eg=2E, should `=2E/configure --disable-silent-rules` a=
ffect what happens when we run `make cppcheck`?</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=
=3Demail">change 1868</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1868?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1868 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 30=
 Aug 2026 18:01:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--gPebAL3oHHY=--


--===============2026619068555281816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2026619068555281816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2026619068555281816==--

