Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4363CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNXHu/3+8jXzCs9Q/OLNq4NPZ5XZmPHcDAA/Kq5/CcI=; b=f+MPTPJpxDj7BTaBVZoYPX/Gor
	K/48z1KorQ83XVQChappXIT2Ojxqe5Hm85V19uMpwCypad7xvOs+XLtXyTHPielPL3ec4j94VquDC
	JKDgTCEFQSj4SJdpoF9v7VjnsrZibUdaoD1/3abCngZXOJJii1RsxKBHFTFICWqAIvBg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfFR-0005oX-CK;
	Mon, 22 Jun 2026 14:03:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfFQ-0005oI-Lq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+U/ECtB/heoNM0L0EAJyP2rqkAg+VDH+Pj2juUlRLx8=; b=MyfODthVUc7gbMD4JdLUSsG8v6
 UCqYDW3eMJyN3/U9f3Ks7j5mXwJwAFCQyi01PdmuFg/bT8eIvAUyiv/t2PgzVG5sVWcAwaMIuqoG9
 fIUw+UvA0aoJJqEWeWdwEkeOXFvbPrIJ7F0QNKrFxTOxyzayUdxIG5H1+d79c5LVQKcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+U/ECtB/heoNM0L0EAJyP2rqkAg+VDH+Pj2juUlRLx8=; b=Z
 FlQkEuSeRFBGmcZmaTHmlDExNi6CdgpvwSBg4WD7bl+8zw+YQurpffGQCwF7UNfXMVs9jp3FPCaJ/
 WxjiY7ouxvBu+a9QPT619usMnJ6JanRddrJawQBUh5L+THDKy/oIXUX0iP+ldtG35c9uexAdR9lMO
 BLA2v5MWs3ezkq6Q=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfFG-0002rP-U5 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:03:30 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so48525795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782137001; x=1782741801; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+U/ECtB/heoNM0L0EAJyP2rqkAg+VDH+Pj2juUlRLx8=;
 b=QAT2+KqCBFOboCEXeoF0mP9K4P1jgYGpV2Gs261asJTR7x1M962Gy2CvRIIkZ7oZEe
 bmOIjmn5R4GP3WydHpv3Kd2yJn68DJl+H28PGRk0PWeEREsOw/EBEIN74rQrl1nJXJVN
 OTKtVylbSTBO1ga4EuC/cdZaXZTaqB3FrkZGmmiPnjjh+ZeYr5BrAFbBHV4gI4TL5WVg
 RrsmqDT6a6QOhEwIF9k+Da9a4Mlxi/CsjjDVQXdgrztoHvtX9SQtAu9W2XDh4/3Y2ku+
 Tjh0I1/S2fzWxxeAfKaiEB1TlZ8dQdjE47Y7sCe3Awhrlt8+ndHldk7NqxRdsn/rF4IA
 SKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137001; x=1782741801;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+U/ECtB/heoNM0L0EAJyP2rqkAg+VDH+Pj2juUlRLx8=;
 b=BVHxQvlSKmRntYdfrPX0JGfY09uxJPTDjnYWkb6IF1OAlNRsDv1mmRu6VyrD+HRhkT
 A0NXyGtpUziuK/rfKEFVMwAhRo+8ppiPtu+Nw3RgjGcG9N379QGGWKRXIiYEqFifXZ1G
 gjYMeEsDY1ZnUI0ceZ1J+8pVj/SwL29qgKKEqglLIv+W/TtRLQyU3nn2+fE5h6tLdQpD
 VchWe1ikDMlFQwcvVNdemDvQiOm5cinziYZ3JCgvvrjdAzIPjPQNkQ68TXzDfKoOLr/z
 KRpyNUvhTGyvQvxnJQHczbEorZcS8agILD8njcKMjlzYW23ory3NNXmdCQHSGz1YZrmY
 Oqwg==
X-Gm-Message-State: AOJu0Yw/3HNk9jsGM3SZxof13eqUnuKcUnvBVFz5/7u3I/fJjjqr1BY4
 4biStxiBToEhj/SZzk7rOTPjAxU8twLfCpyIN0QThLEGorBThCFjgUiPVdKy2ycUJSLkUJ9kSGz
 bF0J6Zemp30AD5IBWtRQGPrVlByjKxkVaEvTuQMluqPuY8LKGcAqRDXqv3FERJgyz2dqGqlOupA
 deDWK2uw==
X-Gm-Gg: AfdE7cmAiZHHoYa2V+U1M/iiKbrmzmnIS5bMq5ZJc8n3/sDb56FfQBR02+pkGy3tg0s
 0GfSRzd0w2/dtKsH4ajToPHIzGT58zGJ1HhsFgrkwlmwvUb1sCFgYTodXiiALFj2qaLHLm9eu7f
 Y/BNuWeo2LvC2F3YvNKo7/XLM8fCf1651j0EwibggsRJ9qY/B6F52odL3z0WL0ROIAn/jQo2YmQ
 3lrnSxAdJFm1zBl2IhQeFprlPEqUS/pJLK2PC/eRMPnHeva7WOt+dsHTJXEowlKdxsVwjW8riuq
 gj0jbX9FBVmwK7oWwqfLNhAKYzODDHAwyqCRzLyiSFCBp2SnQbaot4hMR2gj3mAmhq9Y6DaoYSZ
 s20utRniEFMrZOi/5dMPZSERW0TFZuj46sw60VzrEvxw6v2hzGeqexJEeGb1fAr7G0DReNOwMUo
 Ee9PkeM+kU5Gj2t2GwoKJdauXAw9iMdkFebfjArn5903rpYM/M6tc29Ins1ozT/5t8gEhitFatY
 Mq3lOoD9MJItDmKHfrzGxiF2B9gTrYJJfKpXQs0nlw4/FGF6pJ8yZU/w74ASj4p6mvhmIf3F1lW
 DnU=
X-Received: by 2002:a05:600c:4e05:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-49240e6c534mr247955925e9.25.1782136999221; 
 Mon, 22 Jun 2026 07:03:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494497ffsm223416615e9.11.2026.06.22.07.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:03:18 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:03:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 43b6031f882d58e4d5b9790c558b913926128399
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 14:03:17 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92b8562acaa637bd0ec95e40359025d0eddc9dda-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfFG-0002rP-U5
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7800771311700370049=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7800771311700370049==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sj9zt4QDm38="; charset=UTF-8

--Sj9zt4QDm38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1: 
build fails

=

File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727=
/comment/1640ce6c_498f33f7?usp=3Demail :
PS1, Line 351:         return mult=
i_get_instance_real_udp_real(m, real);
```
mudp=2Ec:351:56: error: too few =
arguments to function call, expected 3, have 2
  351 |         return multi=
_get_instance_real_udp_real(m, real);
      |                ~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~        ^
mudp=2Ec:265:1: note: 'multi_get_instance_real_=
udp_real' declared here
  265 | multi_get_instance_real_udp_real(struct mul=
ti_context *m,struct mroute_addr *real, struct link_socket *sock)
      | ^=
                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Nu=
mber: 1727
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026=
 14:03:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Sj9zt4QDm38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">build fails</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/1640ce6c_498f33f7?usp=3Demail">Patch Set #1, Lin=
e 351:</a> <code style=3D"font-family:monospace,monospace">        return m=
ulti_get_instance_real_udp_real(m, real);</code></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>mu=
dp=2Ec:351:56: error: too few arguments to function call, expected 3, have =
2<br>  351 |         return multi_get_instance_real_udp_real(m, real);<br> =
     |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        ^<br>mudp=2Ec=
:265:1: note: &#39;multi_get_instance_real_udp_real&#39; declared here<br> =
 265 | multi_get_instance_real_udp_real(struct multi_context *m,struct mrou=
te_addr *real, struct link_socket *sock)<br>      | ^                      =
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd11933=
1b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 22 Jun 2026 14:03:17 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: Yes </div>

</body></html>
--Sj9zt4QDm38=--


--===============7800771311700370049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7800771311700370049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7800771311700370049==--

