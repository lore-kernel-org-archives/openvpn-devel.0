Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D15C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAtLDEBwktqZz6YQRJAZ/q76YEABKoOV+d0aNk+Wyrs=; b=RttwjXXbflvHJaZQBdMfF5698q
	4aJz9juh3eSNNQaG1qQAEUP+qXTdqeNUnb4FVRyV/cGtTIy47MCSP90m65/EjoEuzqJeS9Pa2HSES
	TTY+8TVuQ34W+pBrsT4V07MJLFDDQcW0OHNqbX4WutYB/U2HswqtRC8XvJooWeT+lGKE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws1Qf-0002Pr-OZ;
	Thu, 06 Aug 2026 16:58:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ws1Qe-0002Pk-W8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 16:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=weGaBbTzBERpTmEq7Rd+hwdiVorNX5utEOsgW2K5WBs=; b=XfjWJM6Me/nBjnsdQNRZY0r1yy
 fYhuDsz3aBFX2mJk2YV67m72wanfOLyvx+DPcfoxUDsVTbzMJVNhHmiF2voeQsokvTz3DTgjQO2Tq
 3t8Ed3OJXeFNp02/loyHlhCoI3wuzWMZtjqUrpOy5hAW692vgSQfdds/nYYIpDh5EonI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=weGaBbTzBERpTmEq7Rd+hwdiVorNX5utEOsgW2K5WBs=; b=h
 XOFeGLxqn+sHTlsoyPm6K8VLUk3YlCBuvp5pT2+qHVWRbpMFfsEQkg6BA89d9s2sfXfIsnFkG9SjU
 wU/6qCb5DtvD152zSG1AKSuQLnz33J0ROCymwJsY4grGC2+Fh85SlwZM44kg2GvJBcVtUhWSIPYUd
 i6L35EFo+x0WONlE=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ws1Qe-00048i-43 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 16:58:48 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1234280f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786035521; x=1786640321; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=weGaBbTzBERpTmEq7Rd+hwdiVorNX5utEOsgW2K5WBs=;
 b=cGWi4quxo/kbXa3YNfHj9TeSG0anOMJvJFK6qxk2BtCUeJM37swu1gf7upVzcSgwIK
 +6ECID8nAG4rcHHYFDD41soVYa2nnUF3BlDRiqy8LxGpKDfDKQljMRD4V310Tg4mvUJU
 RqT8sZtd3cW6CyN9M9iGVJVZp01BBnzF4Ygqwxi+dknaZKQ4pgs8BFzZoGyTEmL4lFvv
 lkXlC2yBM9Rz69B90FWOhQppi/p0LZlT2f7CcZCJMDf1F72hB6C5sRc6NB/8/GO6Hwtg
 0RKrnonYxBEAIJqpcrz4ai5doXlvd9k9mlFUPs5S8Kg+ant4rLaEqN9dmDdURtqAT9zZ
 VdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035521; x=1786640321;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=weGaBbTzBERpTmEq7Rd+hwdiVorNX5utEOsgW2K5WBs=;
 b=YJiSUkC1e5dIX5p6qtT00hnJkKeosuAuq7DOLByT70X+ZLqOuiKB/M4djYZS88JD6y
 YLtIvM6gqYLyzulE1E+Fwcm1ojG1xk4Ccsk4e6pTwr9pknWMl+E3zejJs0xtfWNOu8RP
 ei7K6U/OG4QQ0guQ60dKshKt4zGUHi5fphd4eMkSpSvz5FMuUSPbye6cuQ9Cq0uK3r7K
 a5F+RPxetTD3wbP16HL2zq1z9cB5hGDM9EVlWg5K6fiNYD+2ZTA4HaCzPAD+VbgwSMW+
 6rvMxkS5Z53xDn54BWFAGcpkUkj8wq7trXfPgeBoN1S490TbB0LleaakpLNApjyQwVF0
 9Brg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1F/aOXmExt1zt6r+Ph70ludIF1/WK2EfiqaVeWCI5amRwgyW97bfut6m11VGP4hwuEG1gv0WxZptQ9jon@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxkXrS/sDT96BjfS4JTGxv/vPEk0AMm8QY4oD/x+2HWPFlIfg57
 qR9M1pjXJmZLf8kVGaX2rYkjIi32RleAl898p7DrKkv7dpz1oSt/853brdQ/NVlp4EGjwAj5WW+
 NT1sTYcQkcNctcgbCYeM8W4SuoOgX/Mp0cg2e/9iaSTG9uyzIjjknRO2sNgU4/qLAslzMPkOYSm
 Jd9dDXFQ==
X-Gm-Gg: AR+sD11EiajCoKfYf3a7VhoQ9L+t63oTzoSsUMv5sV1ZC1Klj7Q6sdaMHQftsIzjE5f
 3ALZEtoQ+TMaOU5a+BzNvyt5Pcz0slnKvYClFZtL0/aMiHRdExnFUIPKz+Gb2/kdyPjqFMQMUvH
 qdY0UL//+jrTIryD2MsGhlI+FjDbkxduxLhbm50+HtrSAG0FZOW4yOHVQ3kQ+NthT+l0ALDzuGh
 K7YByjNLYhb8/p1zyeVjp5WXkQO5skippdpBn+6Nrdta2Tqs71M1Edld3Kz8G3FQEAxL3S6eoT/
 x0175dP/lJUIekXPLMoC2Ei0EKwKqMIB1dOc1t17LQiN5LOs6dJAJeheowwBxb/K33jDuWzJYxe
 118XH6d4k+qphsFgwOv1UCXS8F5XAb/FG6pa6bk5gOfbgpZWjeu053D60PMDWMHmzWh9ZQ7DXsm
 4Ewn7kr2NekZzap409Jfo2VqkDUZ6K0fa8gQ0kLAJRc4yJU7yfeQULfdunHT6CJYMo0KkNZrGYk
 pwcjl4bQmur9c6/vgTDraFqtnBRPwmoeEozmP/LApTuitb7BPM0fspX6X09ZXTM88Fq7tbbMFzt
 3hfovcsi2RPnfjZrUKtH37vhTkw3z2JZ2ub7z5rH+hXnf5pBz6g=
X-Received: by 2002:a05:600c:3583:b0:499:59e9:64 with SMTP id
 5b1f17b1804b1-49959e900b4mr37305915e9.12.1786035521316; 
 Thu, 06 Aug 2026 09:58:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542241cfsm73115455e9.10.2026.08.06.09.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:58:40 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 16:58:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: b65e19e081d86b0929dc82dc48b0e71816167f73
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 16:58:39 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <289467f4f18f4492947acbd3fa95503ad4569256-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ws1Qe-00048i-43
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4751354807965573571=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4751354807965573571==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k/3YymxUlaE="; charset=UTF-8

--k/3YymxUlaE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File tests/unit_tests/openvpn/tes=
t_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/8024d63a=
_812aa102?usp=3Demail :
PS5, Line 522:     rand_bytes(key, sizeof(key));
> =
You missed one=2E As apparently did I in my last review since I flagged two=
 and you fixed two=2E [=E2=80=A6]
damn=2E



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Cha=
nge-Number: 1827
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 06 Au=
g 2026 16:58:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment=
-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--k/3YymxUlaE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827/comment/8024d63a_812aa102?usp=3Demail">Patch Set #5, Line 52=
2:</a> <code style=3D"font-family:monospace,monospace">    rand_bytes(key, =
sizeof(key));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">You missed one=2E As apparently did I i=
n my last review since I flagged two and you fixed two=2E [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">damn=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b6bb178f=
fb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 06 Aug 2026 16:58:39 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--k/3YymxUlaE=--


--===============4751354807965573571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4751354807965573571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4751354807965573571==--

