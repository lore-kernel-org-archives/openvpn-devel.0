Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF9606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jLUBMWys;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YxPwtnmI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZSYfqKdy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Egxsc16L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rg+i06QyM7Y2G3byfAWatZZuYTIGrhoZNwCa/pJ82hw=; b=jLUBMWysTOfztbjjm82FLTGbw+
	doy15wtJszwmBsq/D9m1ZXqsUXhA/2/o1sqCb4Bij7Y81qJ8qrDyErjFJGMf2LVe4wWeMvRMSuXc0
	UVyV0sjY7H9fnEA2TcS3S5+4lGlu9QIEPIQctX6fnTRPv+V7W0UnXuXhakZAbYILHwtA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxGA-0000000086w-2Bzv;
	Fri, 27 Nov 2026 14:49:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxG8-0000000086p-3eWL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkKxwXfhIJzTzszqKiFTkuB9wPfZHqpqKgFN9USQ7ks=; b=YxPwtnmI3rJxQEHWBM0mFLSyIW
 o/th0BiloUyDDR62xSYYenfrNxy7Klihvy2pezgceRFT49dr3RkeWGaksFM6cVgO0KKa1gUGcAW4/
 9dEmhpFDzyPVs4igDF3BbXI+SJCsYHsWNPOb9JnHdkVQJhJpwDbz/l2Ltle8r5jQ2scg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkKxwXfhIJzTzszqKiFTkuB9wPfZHqpqKgFN9USQ7ks=; b=ZSYfqKdyiZd5VeU7tVLSDLvctY
 hWAyssVYpK78604a2iRbiQZyBCBaoRWOBa7XMX9fQq0fkg9DCR7NYHRl2CSbAZRdzx7xGexYtRNyN
 20h+4R5l1F5inGxSprbGDFJJiXCubPmWyZ1C9vnPHz77a6R4yJ9mFPTJXx9S3dS0pOBc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxG7-000000003Rr-0xjo for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:49:08 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so71493265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795790941; x=1796395741; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NkKxwXfhIJzTzszqKiFTkuB9wPfZHqpqKgFN9USQ7ks=;
 b=Egxsc16L6iNK8IUtL3aXf5jJap6hNoRy/Fn9LGURDV5xfuXF/FNLEeRWr5ATPZwd6v
 0ChGmG3tFdC4tEThpKECmPbcnX2v1mA6mm+dXmCXXOrivauyBEBPKTbgiGk5W2/6s+pZ
 l7GBPRpf5sQXuJKgAnXr6iecwCfe+TFd2N+zs/aEbIa6bD/fYlX6PaNy4ZNiHhif0kMO
 B0AooQV/Ubfe7PLuCDP2wcC2Zc0XzSS5eXCW0WKZVKBC1GRATUoA0ZIZjyFc9FjOGzMV
 IiC7FvFhqRgiVnk6KILWrztfCjxeZF8mudJUsDSBC9lxxMPua88garbyHenVg1ex+wcq
 lbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790941; x=1796395741;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkKxwXfhIJzTzszqKiFTkuB9wPfZHqpqKgFN9USQ7ks=;
 b=2gNVmz1VBYZZvWOjzrMIEg7pKw3r2mwqStMg/GaGU/LT5/jGcMH5fe+SHzAvslH5St
 2fzRB7Z1+2wvDI+QakWtV33lHUYGWMOXJqiEtMrYZakZpZe+gygwL3TR4bF2xpjKaJtJ
 iGzvgBvMFaG12EJnVLVveCVagwtoj7HHvHLrJ5JbugajCowlPCaeSGF0nhvEna7x9PU2
 IOPaJEDe3soOpP1c15OPzC+9Nzve9o8yeqigXOpHQTTnimc27CXg3+ElemvoCiWbzmhb
 7DpEDU4/YptGLdYe4tU8qzsxiAV5oW7k30gnLx0+ndffN2PEOCOHY+7FxxXhrU6jHdlg
 gTAQ==
X-Gm-Message-State: APuU4Z9rkbkrb7BFMXnUK/PZWEcDMFVov+88Rv+D7WBN+JXNmH4kEjDT
 uyqZFvUqGQ8aCNnhYU/CFV8oJG7SQCXnnQVac2ocGlvP8ZkoY4/xAAsNKjb8OxgpwYwWmeb2ZfX
 yPVX7baZJ1hu0E/U/jJMy7ctOhYz0iC0g29fyvSy7U+N2E8/+e4BHhH3/OStXHXb5RJKbaFLnth
 FhRaZZzw==
X-Gm-Gg: AZFdTZfU2Y0EdA/i+YQQOeNBKaYBwQkqrHcFDZuuD1st++i1ghe0xODJqdbrl9LNN4x
 gAn0KxpedXa12EvMSa9cnHlTCNodK5Gg2Unn+I1JOsh817xsuOSupQXHHZeYKuZmFeNjLA9wIz/
 3qDyRVhyOuE25hz85/4bVhvh/4Ev9iECkvePJlxXdqCBQSgQ2PGaQ9tFWlkyicYRC7Fkt/gt3xH
 EY6jaHJibOMhckm4J8yQruZHuU279NP6HMrJWg0nU+agU/j5n1RcuqrTIp1GnFGG5hfF8zII2th
 OkSSprSGc47ixV8r4rygUMw+DHuaRRJB3GIKQuirxVADDtoZP1m82wMO+Xgsh5niHZ4RdCrqOsq
 TPXRAhNmF7gW9bBmdrLvgTMupl4Qg0y4yeuXKRQOky1+gFfRMlhLaI4BOAc8EKWu1bhvDy/Ixlk
 dwn7vNGAX/rSA6/zpH0XVG0uwkPVoInoom8HF6BM2ls/FYoHzXX88OooGMMDpoTFbP31k9kdD8Q
 OL7COA45UjHAfXxOu2yQtnQf1IgGijzxDZGyqA49q/LhYnRT8E78ZNnYjjxL0o3n3obyo5SMRQ4
 5nhvcANm9fxPj4asLJXdf/e7k8r2X0zerKVK+ake/ghD9dtuwR13GE72JHIFukTsd4SatY5h5Oy
 ydCNGuNWNGf9tks2KlA6yS52jQ1qT84mIVz6WVhxkfroyA6NGnHZmIgGfTiwcxZQKxkQEwq3Nl4
 0DU3VjsmPMMwlUztwh
X-Received: by 2002:a05:600c:37c3:b0:4bb:b7a7:8377 with SMTP id
 5b1f17b1804b1-4bbb7a7837cmr30862455e9.32.1795790940410; 
 Fri, 27 Nov 2026 06:49:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b8b7888sm47786980f8f.42.2026.11.27.06.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:49:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:48:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016
X-Gerrit-Change-Number: 2362
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2362?usp=email>
X-Gerrit-Commit: 86f7541de5be622aeb4c6398b120df634109e7a5
References: <gerrit.1795790938000.Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkwOTM4MDAwLklhNjczMWY0ZThlYmU4YjVhYzc4ZWMxNzA0NWI1MTViNmNjOWVhMDE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18ee60c3d4bf2488be8bdcc9f56d473b7070ab18-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxG7-000000003Rr-0xjo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpn: unload
 providers before freeing the options
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5652491235346228005=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5652491235346228005==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ArpT52sq2x0="; charset=UTF-8

--ArpT52sq2x0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2362?usp=3Demail

to review the following change=2E
=


Change subject: openvpn: unload providers before freeing the options
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn: unload =
providers before freeing the options

uninit_early() passes the --providers=
 names to crypto_unload_provider(),
but uninit_options() has already freed =
them along with the options gc=2E
Call uninit_early() first=2E

Change-Id: =
Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
---
M src/openvpn/openvpn=2Ec
1 file changed, 1 inser=
tion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/62/2362/1

diff --git a/src/openvpn/openvpn=2Ec b/src/ope=
nvpn/openvpn=2Ec
index 2278266=2E=2Ed9a7c85 100644
--- a/src/openvpn/openvp=
n=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -330,9 +330,9 @@
             } whil=
e (signal_reset(c=2Esig, SIGUSR1) =3D=3D SIGUSR1);
 
             env_set_d=
estroy(c=2Ees);
+            uninit_early(&c);
             uninit_options(=
&c=2Eoptions);
             gc_reset(&c=2Egc);
-            uninit_early(&c=
);
         } while (signal_reset(c=2Esig, SIGHUP) =3D=3D SIGHUP);
     }
 =


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6731f4e8ebe8b5=
ac78ec17045b515b6cc9ea016
Gerrit-Change-Number: 2362
Gerrit-PatchSet: 1
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--ArpT52sq2x0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpn: unload providers before freeing the options<br=
><br>uninit_early() passes the --providers names to crypto_unload_provider(=
),<br>but uninit_options() has already freed them along with the options gc=
=2E<br>Call uninit_early() first=2E<br><br>Change-Id: Ia6731f4e8ebe8b5ac78e=
c17045b515b6cc9ea016<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>---<br>M src/openvpn/openvpn=2Ec<br>1 file changed, 1 inserti=
on(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/62/2362/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index 2278266=
=2E=2Ed9a7c85 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><b=
r><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -330,9 +330,9 @@</=
span><br><span>             } while (signal_reset(c=2Esig, SIGUSR1) =3D=3D =
SIGUSR1);</span><br><span> </span><br><span>             env_set_destroy(c=
=2Ees);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
uninit_early(&amp;c);</span><br><span>             uninit_options(&amp;c=2E=
options);</span><br><span>             gc_reset(&amp;c=2Egc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            uninit_early(&amp;c);</=
span><br><span>         } while (signal_reset(c=2Esig, SIGHUP) =3D=3D SIGHU=
P);</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3Demail">change 2362</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia67=
31f4e8ebe8b5ac78ec17045b515b6cc9ea016 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2362 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ArpT52sq2x0=--


--===============5652491235346228005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5652491235346228005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5652491235346228005==--

