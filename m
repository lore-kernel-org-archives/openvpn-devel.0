Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2591C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tYpVw9tGjmSEOVp5VoLBIgScR5cWS28l0757zvL/bo8=; b=V8/DwxoyzEoEWi
	3lHAbfMb8vXOZui0O8tXuQ+CsxXsNSIbohB93nY9EbQXAU65Z7pOyZVMtzBQ4GdOCKpDOpBoswDmH
	T5UOmnZJStEisilpfnh+bpjPnuJXQmjkb3lYni+aLSEYtc6/GEGrTITzsERzYykvBwWxLj4AC6SHL
	Ahc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUne-00025V-56;
	Wed, 22 Jul 2026 11:07:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUnb-00025C-VX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCoZ56at0CyHkEbhuDYTANkU/w3MTOOODfwhbIVRAE0=; b=LZwxwxUSD6rpo2RtG9rXa6TCop
 H0LryitpkBRrU8gCMj8zkDwDvjLPB+T8Nai8gnWFmlHv5Bm5les2kOPqti8h9XAuRick+1n41f1nb
 TigrUYxv0JBT8LyRmtkb377YM09UZKeRMLAF+ww6H25wFjPBnLkTrxZBXRbJXvi46K8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LCoZ56at0CyHkEbhuDYTANkU/w3MTOOODfwhbIVRAE0=; b=g
 j9y/2fus39thiyYsCXIXQPz0sGILWXoBDEt6NmLFn0r8HB+ePJJYyLnKb3LGuyXBfg45lhmv/cAGl
 4/vWJQ0qR9X4BvCDIfUG9xncpsqqqG++P+huFWPMVG7VWJ+9vEROjlkb5O6ztBEsqjTeP2ehxp04y
 XM8q9op/FlGkQ71A=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUnb-0000xF-KS for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:07:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso40038365e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784718448; x=1785323248; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LCoZ56at0CyHkEbhuDYTANkU/w3MTOOODfwhbIVRAE0=;
 b=NatqItjCabweHHeLhviBVv65O0ixag34BsdxCIZlc9qVef4YWT4tor+RLuQ15/Wyqp
 gdbUApFm6puXACju4kyIBV3mFvXuo3yJUlev/zbQbM0nJf0IvOyRHnM2V/XcYDVNzPh6
 j0dNItGPw0klMyQPpIKqWsUAhMCRfSTuggZgVKO0ITi+3hsWF7u8UsWwCzhoHSy5w/7f
 /NilZni1mK9nck7BJmV6zPU1s6XTP5hVr9zsZhxhS5Ez6e40zffAb9kaGD9edYQQjthM
 StWG9nulTTRJojR76/cLFwKnV8Edkedh9KGLm+gK1nHWneklien27h3RWuZfNop0SZ1H
 cYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784718448; x=1785323248;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LCoZ56at0CyHkEbhuDYTANkU/w3MTOOODfwhbIVRAE0=;
 b=Nivn42L4MTdAsHA49Gxi86qk9hesO/AzZ9ms95p/XgpWPSNFyda8iSUrZd3Eq5lSN6
 P2A9t6FSwRay750XPFSrNChg0vyMrafnW9JT8J67doDgcwe/az3lT44oba2LH5kik5vN
 PFZlpJN35QTvtAQ1sWizKloS86LkBYiHj9fMtQBghIA4u3tfMGbqQRhG/Tu/5oWsHH0i
 Dza1JQ3X5HHYtg2N00M01tCDp59XoChyYHSxgnlmtY2gzl9i1QY2M99wS3DKyyfIXaDz
 8TCRMTQf6ndm3f9v2AmPgDb+lflzmCZHDqAvOHCDCdkjnTFpFYizmvqGxPjbRwZwU6H+
 ZNlA==
X-Gm-Message-State: AOJu0YxLEK149W+LQmWjB2vjRLsm7jc43gpYSERkvZ2FCco/lOkz+8bo
 74AuwMNaeK5VTbvsawFCy9OePRtNz3EUXTUyHWHbhMhvNdGPT2KqEDW4gOJpp5eX307CLdqJgon
 VqEoIGh4UlqrgTuuSTPT0pPIgr8+3oaJzlzyw5DewtCgLuyEb+xP4ZZFkbIUzp3W/LSdx/sQmBB
 s58tL2XQ==
X-Gm-Gg: AR+sD109TSjv6YM3HMDJWgezzn0QYSJ/2vMEUqwfQdw95OmNSK9uZX8vy4ORWLxf5ER
 yJ1kblGUcQbM4vwE53KcdiKzgQxU2c3/9yKGa0PG5P3DoutzUZxidN5U9Q+GYcfZJvqQaKerFze
 BviaBoI6479A5ThBWRI7IHL1bpJWsTPeJYXwi49DDoEcCIv2rxweIZkjqQzX1/SPH66WAtceocO
 W8NqsQZc+dCQ9Y8OF7bIRW7TGZrwKSVL2hV2feTJrnj0vVfB33kzPX8Qmk/j1S9rfD2VG/knDrf
 Pi4ExuOtFb8Q6Zc26ZO30hgmfQgCaGvjjxCY8Nt9N/EfluullP3+c10Ugq9RWpmBs6HDRpEBKma
 bHiJvhDaAxtZZXPk3ggSvoIxnHkSC+A4nwacOYw2LtdraZvX5F47brDy9Z9HHqbAxalUZVkicSz
 eersEw7Ma8HGuUOkiSZnS06MaRXQgl4H720TSq7rpgoq8JXlzXCqAACLaTYpJUpJCcXPQNcIFKp
 QG8cpUNDGxLuSmY7wfSMc83aYi2IQCujd+YYB/uj5kHsgUH+J6u3qaNtAuDO2YgMo4+
X-Received: by 2002:a05:600c:4f81:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4955b4a5c0amr158244575e9.19.1784718447257; 
 Wed, 22 Jul 2026 04:07:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a64d4b6sm57525355e9.15.2026.07.22.04.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:07:26 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 11:07:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 1ec92ed73b843478ad10411fc63aa76cc3f1b3a8
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abf396a7e8adae60563b53a7c2a8d78f23083f0f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUnb-0000xF-KS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 option for Mbed TLS
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5076634742558420587=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5076634742558420587==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7wIrJLykJkk="; charset=UTF-8

--7wIrJLykJkk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1799?usp=3Demail

to review the following change=2E


Chang=
e subject: Remove --providers option for Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove --providers option for Mbed TL=
S

This is an OpenSSL-only option, so remove it from option parsing when
bu=
ilding with Mbed TLS=2E Previously, OpenVPN would print a warning and
not d=
o anything with the providers=2E

Change-Id: I0f56ca69efae0ca376eb9eae064a8=
93c8768188e
Signed-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=
=2Ecom>
---
M src/openvpn/options=2Ec
1 file changed, 3 insertions(+), 1 de=
letion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/99/1799/1

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 87218d4=2E=2Ed68210a 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -606,7 +606,9 @@
     "                : Use --s=
how-tls to see a list of supported TLS ciphers (suites)=2E\n"
     "--tls-c=
ert-profile p : Set the allowed certificate crypto algorithm profile\n"
   =
  "                  (default=3Dlegacy)=2E\n"
+#ifndef ENABLE_CRYPTO_MBEDTL=
S
     "--providers l   : A list l of OpenSSL providers to load=2E\n"
+#end=
if
     "--tls-timeout n : Packet retransmit timeout on TLS control channel=
\n"
     "                  if no ACK from remote within n seconds (default=
=3D%d)=2E\n"
     "--reneg-bytes n : Renegotiate data chan=2E key after n b=
ytes sent and recvd=2E\n"
@@ -8575,7 +8577,6 @@
             options->engin=
e =3D "auto";
         }
     }
-#endif /* ENABLE_CRYPTO_MBEDTLS */
     el=
se if (streq(p[0], "providers") && p[1])
     {
         for (size_t j =3D =
1; j < MAX_PARMS && p[j] !=3D NULL; j++)
@@ -8583,6 +8584,7 @@
            =
 options->providers=2Enames[j] =3D p[j];
         }
     }
+#endif /* ENABL=
E_CRYPTO_MBEDTLS */
     else if (streq(p[0], "show-tls") && !p[1])
     {
=
         VERIFY_PERMISSION(OPT_P_GENERAL);

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Gerrit-Ch=
ange-Number: 1799
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--7wIrJLykJkk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1799?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rem=
ove --providers option for Mbed TLS<br><br>This is an OpenSSL-only option, =
so remove it from option parsing when<br>building with Mbed TLS=2E Previous=
ly, OpenVPN would print a warning and<br>not do anything with the providers=
=2E<br><br>Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e<br>Signed-o=
ff-by: Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>---<b=
r>M src/openvpn/options=2Ec<br>1 file changed, 3 insertions(+), 1 deletion(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/99/1799/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec =
b/src/openvpn/options=2Ec</span><br><span>index 87218d4=2E=2Ed68210a 100644=
</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/op=
envpn/options=2Ec</span><br><span>@@ -606,7 +606,9 @@</span><br><span>     =
&quot;                : Use --show-tls to see a list of supported TLS ciphe=
rs (suites)=2E\n&quot;</span><br><span>     &quot;--tls-cert-profile p : Se=
t the allowed certificate crypto algorithm profile\n&quot;</span><br><span>=
     &quot;                  (default=3Dlegacy)=2E\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span>=
<br><span>     &quot;--providers l   : A list l of OpenSSL providers to loa=
d=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span>     &quot;--tls-timeout n : Packet retransmit timeout on T=
LS control channel\n&quot;</span><br><span>     &quot;                  if =
no ACK from remote within n seconds (default=3D%d)=2E\n&quot;</span><br><sp=
an>     &quot;--reneg-bytes n : Renegotiate data chan=2E key after n bytes =
sent and recvd=2E\n&quot;</span><br><span>@@ -8575,7 +8577,6 @@</span><br><=
span>             options-&gt;engine =3D &quot;auto&quot;;</span><br><span>=
         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>     else if=
 (streq(p[0], &quot;providers&quot;) &amp;&amp; p[1])</span><br><span>     =
{</span><br><span>         for (size_t j =3D 1; j &lt; MAX_PARMS &amp;&amp;=
 p[j] !=3D NULL; j++)</span><br><span>@@ -8583,6 +8584,7 @@</span><br><span=
>             options-&gt;providers=2Enames[j] =3D p[j];</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>     else if=
 (streq(p[0], &quot;show-tls&quot;) &amp;&amp; !p[1])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c=
8768188e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1799 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>

</body></html>
--7wIrJLykJkk=--


--===============5076634742558420587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5076634742558420587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5076634742558420587==--

