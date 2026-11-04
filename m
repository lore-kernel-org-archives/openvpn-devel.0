Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E727606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aWFflkQQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TZP+e8fj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VPbK9ndM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PXcONHAG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kw5JeAIAciDmgQZhSFKeSLBzjgkzWVGnAyvS1RfIKDM=; b=aWFflkQQHoP2oQZfA7KGOeMQV1
	WDeHggYUVhBy7IBJlbn53v6q6uTDisQooXTytDhklSODtN+qLlljzhZdTEKGuX2ghdYTBclw57OS3
	pSstUUuQPNLn4cV/hWnpmTxjs/OoQK00wmtF3lE8CjWuKCARZNlOQCN0W/32km2T2nA8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcvW-0000000008r-1kcF;
	Wed, 04 Nov 2026 15:29:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcvV-0000000008j-0XeQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kG93Z25NdUq67ai0KPYlk56OBGjT5eT3OaJaTr1GIfo=; b=TZP+e8fjDLoEYOCBKBDEr+8vl6
 BdUtBvAbxlpG5MCsCsICpbAkM7ck8a6rLfiVr85A4o5ARJ3Td8Q00zGbbnp9l5+jsrU+FvRo8N6XG
 6luSqTu9MN5rb43i8ic4WcV128P2eFuyMIT5DneEDr1vKs84UG8CpE9+L27lsRgB3JGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kG93Z25NdUq67ai0KPYlk56OBGjT5eT3OaJaTr1GIfo=; b=VPbK9ndMH7ieKDTYFVCgxOrtYl
 6ZthXzz+lk+OnhpKXzRrvVov7EBbZt/mW92cGyM2/ZkC6X3ZkNYlJPrAdcp3HRSM39zvPaqLG5tcG
 tWJdU10uNSMzdRPbuKvR79VZtxtVRTP9ipMIaBX52ZAwlPIDWyBrzerMgdgsu4/V8+GU=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcvT-000000007GG-22TP for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:29:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so7909045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793806157; x=1794410957; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kG93Z25NdUq67ai0KPYlk56OBGjT5eT3OaJaTr1GIfo=;
 b=PXcONHAGceeLmOkkjssbF8tlz9p6UYC2j2qsKyOCQfBN4rdTskRnCQq19wGWlLDndC
 JredGICEgC6NGEdUzD5klS+C0tQetpzgSD2GWs4cvOAW3mswmQtGtxWsNlVs2wXSj3Zl
 DRUIaDFlDLOiSD5dat3rIgCW5aoqkXC0u7WiW/q+rH8yqJL1yYxMDBXKmOLwBwww2DXq
 wY6fE2HdnQul5wO653wPZjwByS4tJDsqTXRMxMSaB51+y/MMMrHBvOdtpgeBfgfGXpla
 uK1GKyHldaYpqnaD9shMlWKhP4xOSB4wzz1jgeFfwSeHeJLAL7UN8VopW6Cezzh2m1US
 IIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793806157; x=1794410957;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kG93Z25NdUq67ai0KPYlk56OBGjT5eT3OaJaTr1GIfo=;
 b=u5VGsIuBmzBQwum16gquvFWGugSBNm+HCgvUMkSoaILJRIWEVhqds47qMDjCBZ6bkI
 5EXYPyh6rLs6n0/AYUbuhotptRGH40/OmsiAjWekw8pPoddKWvEl8evEIKZIBbGPzJwF
 g45xcwr/zxdIcqUm6GErf+FH1hEntbay4/ThO/xrs/C4S5GJhYaJ/Cd7Fyzips5oeyND
 SUXugVKSnFex0zEXNNywe4iyx3+rXWtKM69nAREzyrb3yilWf3dtUjrKuCcNQlcSpNcW
 bH8POL7b5GXYsQI58fJYIHsHZQ7gAtkfL6DB1QpBPpFVe9/bDtpXDYvoPpF/tS5n3ljg
 EAAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhmr547svqAT7MsuAnqYvJ1WjXgUoDQB639pB96CV+kHirsSDNXnvB144cXURnmslaSai+A0gRUfN0WLxM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8zwDcLxGLzJB5v1IkAQADcgpwnFh+Sv/wOBChO8CjzjXjaHbOJ
 hYdOWsF/m3JCla/a17yP3vd04oxJHZJjm5qgmPUIifr5VMk66t0NUpwP2eKlKUD60Qywl5tfOhT
 32D1pmXCOXWnmQoieX2IebjsF3U4SNp2nUpGF85Ys/MeunnHcVJpUXHBhZn6N2dPFbhMG
X-Gm-Gg: AYBFou2Qv4iT4cbMWSJZgRgCWihekxswOsBkXp/EEvCgNRS3Cl34v4YQtA1BGarh1fI
 Ub0RygB5pBHN17XTWN5AIdZZpmAh8UBWGkDbUucuSfhWaLlezApQWZ1nVXhoroVA8U7zl6DqKix
 UxdAX2psAZYZ+2yqAe6jrMs8UeWPx6jNdaF7TQtI7U+5WTHNbt+3r1I8ivPq9Kq3M2b3bolVXr3
 AS/ehkg2pLJw8iQPJexxevMjXmgj3x42itcywRssbvEH0sbD+KhsCvKjdsvYMxhn9dVCJyu0c/Z
 x/XyTz3AAYHP7QXULDZwiBunU1QyJ3AOWDasIWDo98t11gWrbDAxugnGJSqD1tRiz3FA12KpZva
 a+caUoIGNbwzCGfzuGWU4/j8BCEc2+70MeawRH2/swjt62hgS1kOQ6jJTwvJAhS5vAOahnfNOnI
 4UOrTgiuw/7qnJfDKvRgmo/QiRXoPHamOpTvpJJOsW8/Q15fnsHpRx29CQnIBM6eGWwhcWl4CWG
 AQA94ixzMaOItjIr6BrGNeaym5WnUiC0d2ZFiiYvUO4G1fPbdiKD8LdieQjsNThV9w/baQKd6Qe
 hFDZB8lJBynjjW4sV2a1wqQHXGI5PiRy5qQz1tEdlI/+MFc41WX9m5kRxHUaAdwY11i8e33SBa6
 tWD6YyMsEX3CcHSPQuHVns9/yyc5IFfX6grOzysGnHXDKHHmZisyzpMmKcQA1JSKSgabPMcHuhz
 6yNH3BxB7YvNKjUA==
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr367483105e9.5.1793806156617; 
 Wed, 04 Nov 2026 07:29:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm198645295e9.13.2026.11.04.07.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:29:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:29:14 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 07c096a514de967e7fda4329f129d42478f3ac58
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:29:14 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02ed7ac4ff2001c41291cc2e1e07694755531e80-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcvT-000000007GG-22TP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0874372674703258719=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0874372674703258719==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YarCYnWt6o4="; charset=UTF-8

--YarCYnWt6o4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipako=
v=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail )

Chang=
e subject: socket: Let an optional UDP socket give up on a failed bind
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: C=
ode-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1915?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5=
925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-Patc=
hSet: 12
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ral=
f@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev St=
ipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:29:14 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--YarCYnWt6o4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>R=C4=
=83zvan Cojocaru has posted comments on this change by Lev Stipakov=2E</p><=
p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dema=
il">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?u=
sp=3Demail">change 1915</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 15:=
29:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--YarCYnWt6o4=--


--===============0874372674703258719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0874372674703258719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0874372674703258719==--

