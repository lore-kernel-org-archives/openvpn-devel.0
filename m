Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B9C44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqLf/vwzskRfoe3llgMfS+g0y6hcxz1xzz8Fpe6Et88=; b=FIZ7jBbbAx6fe6zL0YIXxIxY98
	j4ww3pvam1HUoWwvxDLFAjkUu5Mf2CmW19t5KBC3MRyh3GQkmMQJMH9o0p5gFfgu6tpiX5Ow3eucX
	qebm7OTBVWZM1bDm1JjdONhnoxdJzUCaodY1PpjwB3ioZd8qFZVnbmr7eh6CodhCTiI0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlfm-0007Mw-4V;
	Tue, 14 Jul 2026 22:32:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlfl-0007Ml-9l
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:32:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A7OlI5LQC8+JdbiBu5uGzln456GJQ5+pqAEMllnRHLI=; b=CWTGUd1+5QlPt7v6JZmiuRgx1q
 AH9nG6L1INAPutzJk1qDClz5P9ZNyVET3ly8TNSwvUIBESCql0ubp18manAOxCOl/gM7ImfNmeX0r
 +4pk0LG/p9KgD/KYvSZW0HuDiymKADfyd+FEzaA7Yw1bLFIri+JtIf7JWtuoP2cK2T4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A7OlI5LQC8+JdbiBu5uGzln456GJQ5+pqAEMllnRHLI=; b=U
 5RZOrg+befZAfywST5oHfmeJL69xykGwPD00JqUCZExkGMV5A0Z+aAYbaAqnRGID9UagjD/mTcWcs
 JW1nZ0jAl3vJG3wCO6Fj8clYj9N4eOawmFB97Uh+8lDiLhJRzsbg4JeJZ0KIOMg6Ky3rMvs5Gwfmg
 lHceHjgIuzu4OQiU=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlfk-0003Ql-AV for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:32:18 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so23346f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784068325; x=1784673125; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A7OlI5LQC8+JdbiBu5uGzln456GJQ5+pqAEMllnRHLI=;
 b=IVVtOEijBxuVyjzntYsqAMLdfkB4eKb4vO7K2k2u/v5EyDo45ly3dF9Y8EX5XLeTMt
 jdvgA3ipfuzuCB0CotjfhWR9ON+45XCaayTvALpRsVQG62DCxGJJ+wAaqRCluzMjM8CD
 jNa7kCQV2z8uRJfXbzFADbUOQl8R1tHSXUMDEelsRS0W7tn0tOB3T2jw1j5rZwPL+Bjt
 +AA+u5s5oDYQybzGBW9GSK977yAanB8hu2HF4xCPSNPP7OEBvzgLoJKGeY+tpadav4kA
 BYol07WyDt2oejAgk01esjBdFFodIonjwejyrF00asM/31qualEPvhkWu1nzNhdAt8ow
 uTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784068325; x=1784673125;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A7OlI5LQC8+JdbiBu5uGzln456GJQ5+pqAEMllnRHLI=;
 b=ItHOhiPMXjDDoKclfjnBqiSz2oD5MUsHYHBxsWZIv5E1vSYWHocEQlpP4jAiBcG+cT
 V+2z2aYNUJa5YGlt/lST9YnTIi4sa+/NhJnXhBs7tCHIDxiefVBXqvBiLbkSooQxT6VQ
 Lzdsk9X8qDPdrRr6ppWhXDCoZ2tLJxxb9reIaf2h3gHJHblecbLZJoqXTU3WatX+nmrm
 aBfdr4ZKuzZWol/T5D9ZvgtezhiDHPQ3PmFznzZMf9tQlOgltQEyx032F1MB6e6Z5J6A
 5Ir6uCMgvz4e387Lurzyjio+77TYwF4nuuru8RRKfe4A8hn3C3qcisqd/WOOXCniky/h
 Qbhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVKNxWwzyh4L7TE7xZnA5RKgqA7Rhpe8vxwAvoOYXa2AouTP+FpeUOQiyoDmRsvdZD3LcrZfB8H/SGALCj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxrVQb1d6+TZtKZZkyCwyndNV/SANy7J2+PGQ82/cumYr4NM4ag
 sR7K2oWVGd0j48IcjHnH53y6dKcNgMFI7/m0luIcQZ8gdihbjbodW7KnN8JoGse/cARGGg/lZfC
 yUB2P141+ACbBGjxjqtCLNG76SeTy440yXNJ/dYMB7a8zPjNUIJkzAA6OpFmNRGDp+gOF
X-Gm-Gg: AfdE7cnu6wxT9PXSPpd37s8e6TMh6sFVzlpjNRMrFoLutpBzYcK/kEOW1GDWnDSgIK8
 whZZXRqCVQ/1y7JkXYfKaPn/Akxk61bp0MCZ1SQe1dTTRfg/8IrNdCt548hMNXAAQt1Ht0zF7Zx
 QCIPA8OwBZU9G5mpLjDCoeS5719XE9Bj/fePc6XYFHtkdNnmRsJlub/u+SHVReuS1uS4gsRBBoa
 cO3VzVbqK0jqCAnFellwe0TdJ4AhUjuS/Et0Jo3aRl0Bk50/DbelHN7hYE8vId1cYBVpk1+DlX6
 Tj+rEqPfJYEm0npQ8CjaIFFEpLZghC9lTX2GH58KoG/UuDLuaKW5bua34twQ0vlnx0jESO8nxf6
 X6TsYJUS06Nk+tjIuoyvCeU3PwvQhlj68W+w7NXjy8C/0AvZYbzTdmxKaiuUDFNevGU7n7mFcEs
 ygVEENblhKZP0SEaRbb/b3ltcA7PIm0Bp3TmvV1okBDwhto7jCSdCPajRnhFF4CvrmjzXLEip8c
 vkTO7t7I59b2G9Ln+cOGgv63aEHOTM+feKiSwHMuFHnLVSDZCYBDHEz7RX5aM6OUSggtOBBVSuX
 tE829ipvKDFefw==
X-Received: by 2002:a05:6000:2305:b0:475:f0c2:75b0 with SMTP id
 ffacd0b85a97d-47f2dcd7854mr18082875f8f.27.1784068324654; 
 Tue, 14 Jul 2026 15:32:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464d6fa7sm11041710f8f.37.2026.07.14.15.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:32:04 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:32:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 4786ae8ca577fea293664e3d0ece8dbabf8d91b0
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 22:32:02 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <169701a2dc07852ec1702c7ed12c3ce3f7c86d7b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlfk-0003Ql-AV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8724046609145931709=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8724046609145931709==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BKLLfoHGa9A="; charset=UTF-8

--BKLLfoHGa9A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1783?usp=3Demail )

Change subject: multi: assign clients from=
 a named, tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn=
/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783/comment/109eb=
09a_94d45d09?usp=3Demail :
PS1, Line 7634:     else if (streq(p[0], "subnet=
-pool") && p[1] && p[2] && p[3] && !p[5])
Please add new options also to us=
age string



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1783?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db9=
5615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSe=
t: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 14 Jul 2026 =
22:32:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--BKLLfoHGa9A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1783/comment/109eb09a_94d45d09?usp=3Demail">Patch Set #1, Line 7634:<=
/a> <code style=3D"font-family:monospace,monospace">    else if (streq(p[0]=
, &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] =
&amp;&amp; !p[5])</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Please add new options also to usage string</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1783?usp=3Demail">change 1783</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996=
dc8033e2631 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1783 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Tue, 14 Jul 2026 22:32:02 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--BKLLfoHGa9A=--


--===============8724046609145931709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8724046609145931709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8724046609145931709==--

