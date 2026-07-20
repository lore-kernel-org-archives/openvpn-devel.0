Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EE1C4452A
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ytTt7Za1YF9uvFh5JyNFC3BJbxVAsp2ZLnmGOSvd14Y=; b=jI3sj4RJvLAR8JR8FiSV/KMV72
	e9PkMHeJGJnI7ltk5A/53S2XTW0E8zPBdsjmkIadKJrcMe37C750xvp20LWnLedKdFFlyTjcEvAmO
	Yv6xnG3bRQkfwhS3I0uH8GxIsdzDfaO1NEUUR/smzw/Z22aWDxiQq1NbRtN/uq288O4g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wloOJ-0004RY-FI;
	Mon, 20 Jul 2026 13:50:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wloO9-0004RK-7D
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=v8EPkkkQSv8+z8gYilPPV67geHuWj5GYpYGbfZ2hhpA=; b=e2gw57+G80KI+as/XNAjOMFKN0
 0IQ4peI6IDm4Stp8MUglkHSUkInAiN+D+GxShNdVnRBZJauWOyVWt6M/qsxHjX6jAQifryr51sELi
 POaqU6s6p5oG33AP/DYkdab3k8wOQviEKuO65+NpgSaz4f4Q8TbNDfF4UtogMenoZY+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v8EPkkkQSv8+z8gYilPPV67geHuWj5GYpYGbfZ2hhpA=; b=e
 2tgUe7kas64hc2nU5awAd0OshxOJH6p3SFDZD7uzH+/3IFT5kFb9Q9au1sSCaJaX2MDPSEPe1qtXJ
 m6n7u8EKzWrWcXTzc3nlDToZ6zAlxreoNgLeb8e05m1QR/364vuyVNBziVNYf3BZyf9uRlJ7h3sSL
 C60IppY9paZviY1Y=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wloO8-0003Su-IM for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:50:33 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso445851f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784555421; x=1785160221; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v8EPkkkQSv8+z8gYilPPV67geHuWj5GYpYGbfZ2hhpA=;
 b=Oub0+mCXc/E8H7/mitpoCZQEWdGAAjiahyvncO7V9qTkLvhxF38xtix/I2txPgNtsb
 mw14nl0OM5X92C4/G3H+PphI229ooL//NtFgbCiB1HG5eBmdyscrPAPwDMErKUtiUmow
 J0YNs2KylE6x2Y7Qq6MaB/IMHAqk8xwCqcigrm4QGMIh60DFVQJNtlIZbTpIk+3P1GZl
 itRFjffqTT9MSeVL49zRUdPEyhciXkqHUwPQi0dUlMSBisTqi85CZ3wf22e5O1MV7bDL
 qqBOe7wSxR7jDce5ym/UjPf+9Cez5VAQi2tCQpE5jeGKH377oAJPWDqTfD5X0ui1HJpy
 CdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555421; x=1785160221;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v8EPkkkQSv8+z8gYilPPV67geHuWj5GYpYGbfZ2hhpA=;
 b=oHRpmuORBrsBIpFj+1Yb5e0FtllEUBhwNBYVWx1wf5U/StEg2EJpft+VxKmXFzDtyv
 cD0K2SOkQ4/lT5IoUH0W6Czk/z0Pb1uYryuRtEum+iGEocGvSzG4ZlWfI4cYxXdJmgPy
 L/zBo9A90ol802Th9kPxVRHMD1bl2rv2Ies8d24ZuEPQabuj5WWRFWUS6iRsc/itdtbt
 69o8vyom1/QpvnzfSLfHzKUNApRT7H3shmSs67qemOc2M1ylLjfEa2jN27eLvfRHniko
 B8RQvVE+Xk9KEIhlYeTE9Sisx1o/ie0yxgdlr1NFMAU+M72w5N7QRaxeyUEuPUIzVc2k
 8bNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4pPSnFCJe9o9nXewLYOe7HVmvO3Vq9uYh+WWJTub+Wto3H8H0hvNZ5dmYsbJOaC43Pf4kqK1YZXidJud/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxxLUB5pkDyHobPLha65BtZAI13Tk6pn5myyXkpqWyFb5Dt0lq4
 7NifOhegS1j6y0MQCKhb2F9JCcGd2cftoQ3ZBSR2n12kp+4j5eXJYg+iTaYcFsrQfoosQedJaDX
 Rtnounqh/ad/3EAkuNU7kekjFWN+u+djdWl2ePiiY0hWQxXNO1OR93hzK/UPDZm1EkO5X
X-Gm-Gg: AR+sD10eeqGWFP+v1T/yGzuU6/uLMysty64veSVOaUs9bquLz22aTgxjISOIi1XNhiX
 Cfce0Ls8B4AqxGiv2zkQyZv+Ytb0o5xhbpDdR7SBZIdyWXszEWyDZh4IYQ5bQ8nAKaM3MaFIErl
 8HPnpvjxVs5Y2oadk9i6frKe7Z5gYLQcTUcN9iwAeke9NQ1ONfJZ654njQoVShRAX1Cc8wVQod3
 9ox3ZUGzPi3Oj1iVlhXOUEv+4VyLHz1oEIXVmdONt3QTEIzBGtbs3r0PWsyRjedwApWQR40hQQs
 Gv/v76JAUjJrK/CQOudyDpFrsJwoU5E9mJ7dfCJDNVfdshMXS2R+wZeLxV1AMpMweKkae+LKUEe
 L6GXbztktY1b1IMCSvrMBBltm8Ce0oefXbqNF70IHyS6gyGIY/ElCde71Zer/sAj1/ag39khRuC
 HMo7G+aFPg0r8O6I9qPH79ggFiWC/M3ddJzaQP1nLzVmgnjxdonL79AgeP+LTscQUvZ4fUz9Jk1
 gSgCE0ooT05WuoHimLS8WlKYsBwzB3VfOVa3VsfJxprC5zIYZFVmIHZutqPYU9+lmLN
X-Received: by 2002:adf:e351:0:b0:478:77c1:787c with SMTP id
 ffacd0b85a97d-47f6233bf07mr11550584f8f.56.1784555420845; 
 Mon, 20 Jul 2026 06:50:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496ffsm29646953f8f.3.2026.07.20.06.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:50:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 13:50:19 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: c46db4fb2223a358944d3fe8c58a662778cd0ca7
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 13:50:19 +0000
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3af944051b8053d15b1761bd3d6353fda0c86e8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wloO8-0003Su-IM
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8844824639813655020=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8844824639813655020==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iFu8j1ZGoYg="; charset=UTF-8

--iFu8j1ZGoYg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1743?usp=3Demail )

Change subject: mudp: extract send_standal=
one_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Gerrit-Change-Num=
ber: 1743
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Dat=
e: Mon, 20 Jul 2026 13:50:19 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--iFu8j1ZGoYg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 7:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee=
9b59a4e11f37cd9653df268bba33889c </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1743 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 13:50:19 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--iFu8j1ZGoYg=--


--===============8844824639813655020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8844824639813655020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8844824639813655020==--

