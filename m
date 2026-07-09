Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E58C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2m+LwG1oCsRmMzybJ4XhAZJEICyj5rk5MAlg1YXVTCs=; b=LdS6QXlHstDoEIzwNAo+K2543V
	dlSWGJ0ajKtlmj4rdGagYY+CqCa/vLStt7S93cmzQEc/nGLo20UkxK/cFmwVVeRWyIQMvXvulShZB
	ZW9pD5XY6g9fr7Oi7tbF5zAU/A8JBp65GoM/G+GKYz6Kz3M9nouTnPdxG/b5BH2tTSSI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqr0-0007lp-5p;
	Thu, 09 Jul 2026 15:39:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqqz-0007lj-5r
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pgtes9FeyzhDhbG7J9e2KHyRbsC0o7nWbRvVomhsFdM=; b=OHC6vjhHxbBKnKEFmvDN6AMxuJ
 xXjcfkSQPhNVf1th1p/u/uFRET7fwfgnEDsP6hhpdhJR3990JTvUWdzjT9G4bJSDsVGpxCcaDdW7Y
 JiyBxniRP5CpvlMUdkhQJFaBRCt0skf47dF0YG3np6cG7l/u+Xq6tTvMLYdMraGiiA6I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pgtes9FeyzhDhbG7J9e2KHyRbsC0o7nWbRvVomhsFdM=; b=J
 8frXk9rCB7IMRYafEGGeYHxdgjBwUZ9rGkAoR9RinEDQ7mwxfADXMfLsZ6pcHKjtl0o3+lg/Vz+nq
 OtohuNdFucBsiCLJJM0S+joi9BLXzXuLU+1Di7rB+pnhC4dz8yyK2vkOGLvbjPY8mPXDOGvxU9YXX
 7C9SNiDemZuo8AVc=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqqy-0000YE-GV for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:39:57 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-69c20ba892eso86157a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783611585; x=1784216385; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pgtes9FeyzhDhbG7J9e2KHyRbsC0o7nWbRvVomhsFdM=;
 b=YD7DvOwlsNOA32oOsXqzHACUPwRKcTVilQH6NGTGpHmpuwre1He1CE+A615SxCgjsE
 3ox839r5s9IP5Fnn/NU9dUCZpS6VuBMSofs7ZQnO55LPd1wTPxoTLx8GdkIbwwdHy8nL
 Hxd1m1cpRNnFKRA5vUUIS1VkfADBkOw68zfXZRixntN6m29pWQGQQMQFSSdMe1oFH+tE
 nbK0R7EvE9SAg30tgf9s7hHImyc+uaE3Px2lY0MVDZGip1zp59v578+mgSNiru0kitQi
 SWFkDOMSquLHJodkl+0njVS5tsF0orKmbWyFI/akFHqsep+QFbZjKr6KwSE5/XhiT/j5
 3rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611585; x=1784216385;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pgtes9FeyzhDhbG7J9e2KHyRbsC0o7nWbRvVomhsFdM=;
 b=fFPjy1FBEcnLMxDi1fseEz7Caj6+M0/U+Oe9VVhA9cpSjZivTI8uCvyM2p9/2eNgg/
 OhV7+tdCmDqrJjkojLkZeeUhWH0K0bQ204ZEFkteu22adkjBOcfbzZwqJ7azCU9cNi4v
 FbgfFbrQIfVBmiUHH2Oeo3ioo2RASn/4iHOO47zLlWPsUOEK1bEZkByqaAGyQ+W3YW4J
 HBEpBHzEPaMvKi7+krKMgLVTcroOWK2HzvtElGZSIA8KaH7zc2d5zdvoO1EWCdB3xiOM
 P5mx7/ZOt1nLLMxOryv9U9DbYmsIGrEGtNDMgk7xKO4ezAZIqHWvr22m/aaKkgobB6a0
 Zk6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6Nez1Y7dh/ynDRJZTntT8K+gsBbKAgJXJhHF9qijVAW69VdF2SsvlmH1yD0EoZy+12blWngHYkXLXGdO/@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy7vZL5X7jS615+bJmoeHWdcKjAilgtYT9MJRWtUoGWIZUbi4hr
 i/7n4VynmACW6/UAbXx1ZsDldjNAMtTgDLVvEhWjf7xToJ7xfHN0hY5e6OGPVtMg9InVYVpLMnP
 iExkxg7ODC5g+ahYS7KC20yg0GdKmzc91uHy0Kq/vDxLMO5QZLdRrhHSNtnKdgRfFsLGWr/lK2x
 h8+TNARg==
X-Gm-Gg: AfdE7ckE7RqNANhM6g2N0KqjAQFWZ7hEijofV2fYptDVBexupc0W9eLr0gxl2QWjcbp
 3TlmC0m8HjK/qvJFVDCpUrL4JMTbWeDg8RlbxcdrW4JrVhX226I0mqUOmuQpQJPBy5j1o5FraqP
 4v7p7hrhFpA2cLw9YKIbjJVtBO975qmqA+45n9LMJs7RR0FOoDv1Kiwrdgev770E9A1a0iZybex
 PPwifsZWcq1V2wHhERxav8/My3FFGzjTy93yQp/DVf9HfWU4rGo++5z8FBKd7tgl+HFY6RuLk12
 +rlJnPOaT8YxpMpJJ0Lp98nQNHZG86Zq6wPPsLBVbEUOOgHdbidPVMLHwh4Sioyj9hpfmpjLb6k
 CFLaEy5nFDzzJ7+SIY8IK6Xi98nYbFqE5tW+u9QXxJUCqgBjze/sf9BShc+iQW1+wMrkWL64Ckm
 u6KF2IKgE6xdXFWiKNhQjlhnLTp/VRFwc0TF7ooNxfLFVFmbgLGNz7UymV6Oy9ERtfk4Ly0/fSh
 Nm542E111D4aXRUmbTOJYuaYc/NgLY7L/QaX9sBGpgmDvVP7/f+ns+HNKqOTxkiMAV0TWgIvWlW
 3Ks=
X-Received: by 2002:a05:6000:40c9:b0:46b:70db:2113 with SMTP id
 ffacd0b85a97d-47df750e193mr3532614f8f.0.1783604979876; 
 Thu, 09 Jul 2026 06:49:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm53636234f8f.21.2026.07.09.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:49:39 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:49:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: a42fcc7cb35546e3b6e785928aa11e08365b68bc
X-Gerrit-Comment-Date: Thu, 9 Jul 2026 13:49:37 +0000
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afb327acb251f25d10007f8e460feaf479116ff2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqqy-0000YE-GV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mudp: extract
 send_standalone_reply() helper
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4001404567102338025=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4001404567102338025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CkheCQYSLNU="; charset=UTF-8

--CkheCQYSLNU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1743?usp=3Demail )

Change subject: mudp: extract send_standal=
one_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1743/comment/6afc6e98_2b1d76f1?usp=3Demail :=

PS3, Line 40: /* Send an already-built standalone control packet back to t=
he peer that just
> Mark as doxygen
done



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Gerrit-Chan=
ge-Number: 1743
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 09 Jul 2026 13:49:37 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>

--CkheCQYSLNU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1743/comment/6afc6e98_2b1d76f1?usp=3Demail">Patch Set #3, Line 40:</a> =
<code style=3D"font-family:monospace,monospace">/* Send an already-built st=
andalone control packet back to the peer that just</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ma=
rk as doxygen</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">ch=
ange 1743</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1743 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jul=
 2026 13:49:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--CkheCQYSLNU=--


--===============4001404567102338025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4001404567102338025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4001404567102338025==--

