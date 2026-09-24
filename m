Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA6C98314
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhRLuvBeaoQCGdzHxquOXdxkv0qk40VY17TJZqM1s6w=; b=dtvvh7pQKrO/5368+c/KGbN+Zk
	5Zl8A9X3Vg5jxt+69FUcknjMH4McB0mWpPDXHG1EbXw3KffiDwmDFMi2R95D3vmF1RGMmTNo2NQu/
	AhnTdzZAbAPT244M83aPjwXzoUKr+6kelohNNPCW9ZtEo4pLZhdTJe8wLNJ7gnlnhhtg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9iip-0008H8-QS;
	Thu, 24 Sep 2026 12:38:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9iim-0008H0-SG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IAbJQV9G/Fqg2IAF+YMz+pjykbjsy5mPSpmLhRzvPDk=; b=j6/Udr03Q2aHtMaejyi7daoPkO
 XgaW1pC4I5JP3mCWgcYDoFjHuDL6oxu08ixJ0W5AWN7tvmZWbwwnR9JMe2voTBmJH5AVWj1S4EDId
 nW6D9ksfD3+0osZRWMXWfTrtDeEcVR9zDqUzsw+jwdFgdMG2N3oURb5nm8s1DLmPwOo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IAbJQV9G/Fqg2IAF+YMz+pjykbjsy5mPSpmLhRzvPDk=; b=N
 kYKogjfWDcEyd6t+iwSOZEZU74eC6mTZm074CmoIcyap5KUbnp4X76w7eR+7kiYJ4WVMil6HYASU3
 qNsnpglIrXCJlEeVo/bAdoYm22Ujnqu9fNtX1HPPmsC5XXLRiRrwXfmfptavKxp9kunN9kXBHa4QZ
 xiaA7LNLvWX04I+A=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9iij-00083g-FQ for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:38:38 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso3027045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790253511; x=1790858311; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IAbJQV9G/Fqg2IAF+YMz+pjykbjsy5mPSpmLhRzvPDk=;
 b=UX2gBy+DQzJfPTTb9XSk04qVkXngGOL86qW0fIPsSdwLIsI/688PMjyy3E6HG6P4XG
 JBlXcPpabrKwl3zzbg5PaPltFKesDIyo4QgtN0tL1wGVzNGCkWfjad6VRNUYFv8sP+hC
 Itu4jYEYJVs1gOWYn51vzQaaIpBHq6mF5N0eW/cYrwexRUilUr6m/X4UMarBi3IxWybT
 3phdPUKkty6h02SVn4+z+LAcHcjr0R5wVqWysntgBA3Vfj40S4RPL5Q8t7GvGeBcY0UH
 oOvNSxu1GQ5/JVAsWOGVrFIeaaLkGN4JjTw7gzwHRqa6/e8qn3s17thD/Iq8jPpzLqTK
 AVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253511; x=1790858311;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IAbJQV9G/Fqg2IAF+YMz+pjykbjsy5mPSpmLhRzvPDk=;
 b=dODFLnhTPLRyxAQo5dpVrkg0mc1bqh+jKad/xWUp1XAH1pMrIqBNzKgRoAbohp+0jt
 Gis0qpuOp0l40uWH0jmLQ5SGYIaUumEeNkouWVbh1ehBqnkqY0TCV6tE7T+WRuQfp160
 /DALjypH+/w2l35KDCTnr4yE6x5TOY8mangjOzXuet//vxOiwFliVcP0lW/Lu5+u/tKk
 +eRw8pHrcKnyRGR+K0E1kTXETUW8IG31++S28K2dc9TADWaROpKCKHyre9IC7e7KQ20Z
 9CFNtygNUDaJvFHumZY6C3EJPa+fh8DaENWHBKLnuTeuXwowKqmhevFWlTtsrCTynQUW
 G+Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvcaVglGe0tceB3V28+5PZkiz19uwRiMSLO/bZRkXQszlYdKSyfjc6RVHBHfCq6kiZY5Wbz859iQz43pHP@lists.sourceforge.net
X-Gm-Message-State: AFuF++liF1f4el4m1IGjIQ3b+MTkZbv73TshxsD6erq/j/u1pbOFkCdj
 7HNydHl2Ue5uaPf6jClw1VR/NeWhSpdXLLaus91V+F0Xlp/Cjehcmdf6vm8OclKwlHayM9tETQU
 MitnSGU1t9RRhGLCwnt7fb32GIdhPNLZe4vgeIyq0dsMWDUM3oXCzPPNW0zHEwumtitGk
X-Gm-Gg: AYBFou0KVc8/kbVc77mcaaJL20yQN6GSK3RDofeYHMa4RaNL3f5cwTxnA6lHQ9rIM2t
 rmYcS5qc5Uo9doHVa9dQw6RB5+Kdaddfc2cZDQgz/jNYgEjGVpdjtnc818LAiLGeMZ6pD9Ek3eC
 7IrNkb+SZ2X7NAvdg/J90Gz141xV+B/WOPQZG2yJ3aWsKu99bWH2Zpi3TglLUcxrK3K4wlfw64q
 V7SG51lM2uwK5vBN5YW0s1U3uKPMBklASZ4rcgWP3a+CLBY6RMFwHFFLNYUzkNDmhD684gXfAZS
 Eqx0ymiiZstqbLDsbGL0h3oJ4ocg8czMFmG8Qx0i8yeRafCAFnviPS4UOWqp3OtGrlPcIE3b76S
 DKZL/rgONdtEhNt96ah2ERIdIWXUakyBcBFILq2XnEKHZO0foyMVduATyuvRhBnlJEu0q/NAKcF
 ZMkKsXj8ktq0eqyBRNjD/d0T3BF8q22sr/kRGhPif5pQX/DwypXkXzpc6j7WH83dpRmSgDx43CT
 61OakJjxyPEvvS1bJDB5w0If7xs2eDiKX1+H+DzpW5PR8zu6frDqR5/fpSXaARo5+TEYO7CbzT2
 GLFi4fD6zevcqKY3apR9mOmU9cIAPB2bxEc+/BI+7cx3IbF8Qjv3woIFBAPp
X-Received: by 2002:a05:600c:630c:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49fe66eb254mr39199285e9.17.1790253510730; 
 Thu, 24 Sep 2026 05:38:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm100838055e9.5.2026.09.24.05.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:38:30 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 12:38:28 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 6d7faf037d7a3bc4be7c9e35649add2ec6d01e39
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 12:38:28 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24cd6f964b9dfce7e0667b152a1daededff364fd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9iij-00083g-FQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: let an
 optional UDP socket give up on a failed bind
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2036372084156198829=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2036372084156198829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9XWKgLI9yL4="; charset=UTF-8

--9XWKgLI9yL4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1915?usp=3Demail )

Change subject: socket: let an optional UDP s=
ocket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+1

(1 comment)

File src/open=
vpn/socket=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/606=
cdaa3_11d58094?usp=3Demail :
PS7, Line 965:             print_sockaddr_ex(l=
ocal->ai_addr, ":", PS_SHOW_PORT, &gc));
nit: Should this now print `cur->a=
i_addr` rather than `local->ai_addr`? `local` may point to an entry of anot=
her address family, while `cur` is the address on which the failed bind was=
 actually attempted=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Ge=
rrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@=
mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep 202=
6 12:38:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--9XWKgLI9yL4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>ralf_lici has posted comm=
ents on this change by stipa=2E</p><p>Patch set 7:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/socket=2Ec:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915/comm=
ent/606cdaa3_11d58094?usp=3Demail">Patch Set #7, Line 965:</a> <code style=
=3D"font-family:monospace,monospace">            print_sockaddr_ex(local-&g=
t;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">nit: Should t=
his now print `cur-&gt;ai_addr` rather than `local-&gt;ai_addr`? `local` ma=
y point to an entry of another address family, while `cur` is the address o=
n which the failed bind was actually attempted=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?u=
sp=3Demail">change 1915</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24 Sep 20=
26 12:38:28 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bod=
y></html>
--9XWKgLI9yL4=--


--===============2036372084156198829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2036372084156198829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2036372084156198829==--

