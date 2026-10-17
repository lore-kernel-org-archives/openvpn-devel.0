Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BFDCCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ylaoNmNJODLDc6S5x5eZTfk8qi7lM8TZViSQvvBhQZ8=; b=VpJHVsZvZZ5NrY
	ERCs9PrXiQEhgV89ceNDDpANBTjjCeky6XwT1rwOXeVrNj1a8bWY+d9nfG4yZ785Opvcq+gDkq7AD
	I81wYanCNTS9x35w6hgMYJjw22+vyIt90bZ5J7F/7eZ4ihFvzLYjfa5gT1wlwq02DSO/OHhsc8Win
	ODw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xICLq-0004aQ-R0;
	Sat, 17 Oct 2026 21:54:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xICLp-0004aI-IK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 21:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nqe5I8bqaDdXqzZiOxiLWhqhWjpK+93lHeUGD30Cens=; b=aClX9Ey2NfjkrrMWsCeVySB0Bw
 Lgiyci9g2KLwVvUhf53vYnEobGxLCpAVrGI5DiwR/+5aYNUJUjGw4hMPElIwT5uJ4RJY2gvUWjU7j
 aZpck1uxmiZE/o//sCumAdh5Gm17QF4K73p4aJRMQsgKkKsNGBelMkkDq1skxRtN+lDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nqe5I8bqaDdXqzZiOxiLWhqhWjpK+93lHeUGD30Cens=; b=N
 sItl8QWhMd9zSieiXRsbh0vuPL6YU4F/aSIBv8uD/LLAirYQHNzvXBiJwV2a8IEgLnKj99ARLVL+G
 9icxSSsmXVbSxjsyyANB/qbgw7+2HE0/l6lY13IZ8GcdFrXaj4W35mCHKq/iVrvGhkC7P1Q+2VnNZ
 vHnVrwCeRw1Gpano=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xICLp-0004dC-Ag for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 21:54:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so2754455e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792274035; x=1792878835; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nqe5I8bqaDdXqzZiOxiLWhqhWjpK+93lHeUGD30Cens=;
 b=XVolLBXVgeGFBPp9mIpPD6Rk9XFE71dF0S4zwShRplvBNnb7SvoK8u/dWLnk6dlP+2
 z01jYYTFmaO4uqIo9qHShKz4cKP3rOhu2vBRDc2kqFxRA64AOWj+gLTomPeRdICbZgts
 99o0vPdSJyUnFG1BZs1nUfQMgOu4sTpck8drKvs4zZtqsq3ry6O5dY7qFlYLFuluYM5l
 xFGVdCoxz/xFRjxsCLGdH90L++sNoe68qIDd+odM2Y+OXk+nAZTmUXRFPZuPsq1rNJwC
 czMnu/8m1X27/SkJ6juKIr+DtVL/e0JuC7tl9CwOhsc+1M5fsFSyhp0OYZWGietTVJEO
 Hgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792274035; x=1792878835;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nqe5I8bqaDdXqzZiOxiLWhqhWjpK+93lHeUGD30Cens=;
 b=R4tRb/YNU6Ylw82nDhBz/H5xiUBM1ihQ8u8x3K4ROqPO6vym/zkHAvo0Feci0rOmzs
 k2r4O46oJlr7A9u1RG0BHwzO7ABQSt/lR0hGILDJs1FF5xI+MnmvXeFOqBA8IKgduUhY
 oJ7orxIMXLEi+G9Trt/IjQW54U1QG2YXBHPYayPL3RHMz0Xw4etRHncyLg+Tl4lLwK46
 jQAEDS9dPU/sILyFAQ6O+V2HlVpMq7Lr25VfgkCgRBLnRuuLjUz4vzTE4Zi9UKG/dRR3
 mfJQX5jgfVZ39WnkEsKCBOFBtw/dMBCas0ZUs/vi8UwO2bXinZnHvVrEpNvWMlvf0qS+
 sj3w==
X-Gm-Message-State: AFq9FYITxtICU+2ukIDM7b6BlWhQa3xBldPuV71l7fwqk6dCwPOpnRNG
 gZKiBm6xtaCSZ1/4PVzaVXWReeX5/Rm32Lq8+HGvSolnjdwIsenyQUJd4REjMuvjtalShYXGfx+
 Wturkz3bV16TNOnM/dj5pK738ERmRzT68fRQOeaHzpl/PkkMpNgMG3bDbgkaEASXoy2eo4WMfRY
 MKiQbzNQ==
X-Gm-Gg: AYBFou2x+lH6RZuAQ487u/NvbvonBx4hboBteo/zSOd4lXyCaw/vo6yOmbfevdfSN0n
 +c8jYTHQZhwS8X96nmRzMGoV53toZQ6qwGfYsj09es4G0QIvvMkDhixfNNYlhSztW31tLAo+BI4
 F8/Lv/0WPOL6ztZXH/7foVos5ErDb/PMvE1ajLbaNodS6M5EmLkbJUQutOPgp558t9iIMe+tabk
 OD63hPl+vlsXtWsd83U1jAD7H53mrbDza0kGisjBkeL7hlJuhvRlBYlSHY/I8ERAcpnuYNtifF9
 KHanAhWgvKqiU8LzRM0ll01yhkxXLQPbmjgPNupiMKKDB09bH/Yks3RTZuZIOAVkjjiDJ7fhtum
 OR1zmgtmnpMYbc0Gs7CHtZmCWoY9cyQRJMKWbdlBkUiPcn9VDRljBolnBomHo97KOLSDo8sE5gr
 xfaWdQMvAn+A5uzH5DpCeMDyd+9sZ6+AdtJ91IaV+T4cPMxUuEECeilJmwVeuo8XzdV1QpSv9Kp
 rS0bkORMtGcJnzksMXTBahkPRzo+/icZV/5BN5/OqNzXTVA22qh3637rFVFWCsko1hA5t70kLFc
 83v1iIDhkmn9bG4p2mct+MkhiBE0F0pBuU7wrWvN9vOS1Q0ve7G88M4LI+m1
X-Received: by 2002:a05:600c:c16a:b0:4a1:acab:234c with SMTP id
 5b1f17b1804b1-4a1d75f23a1mr72739425e9.10.1792274034608; 
 Sat, 17 Oct 2026 14:53:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cbedb6f7sm170911775e9.2.2026.10.17.14.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 14:53:54 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 21:53:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
X-Gerrit-Change-Number: 2009
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2009?usp=email>
X-Gerrit-Commit: 932aa2cc2f4bace8dedb736f1e1e1652afe7e970
References: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkkzNTEzNTYzZjE5OWUxYzVhYzk4MjE5YTUyNzY5NWU0MDU0MGE5ZjczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8efc88e491dc01c9459e4e369413c9582e470d6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xICLp-0004dC-Ag
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 Don't apply server extensions to CSRs
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3322570523679969139=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3322570523679969139==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RxlmIFPqcXg="; charset=UTF-8

--RxlmIFPqcXg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2009?usp=3Demail

to review the following change=2E
=


Change subject: gen-sample-keys=2Esh: Don't apply server extensions to CS=
Rs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-sample=
-keys=2Esh: Don't apply server extensions to CSRs

Newer OpenSSL versions r=
efuse to add authorityKeyIdentifier with
issuer:always to a CSR, since ther=
e is no issuer certificate yet=2E The
extensions are already applied when s=
igning with 'openssl ca', so drop
them from the 'openssl req' calls=2E

Cha=
nge-Id: I3513563f199e1c5ac98219a527695e40540a9f73
Signed-off-by: Steffan Ka=
rger <steffan@karger=2Eme>
---
M sample/sample-keys/gen-sample-keys=2Esh
1 =
file changed, 1 insertion(+), 3 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/09/2009/1

diff --git a/sample/samp=
le-keys/gen-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh
inde=
x fa5f697=2E=2Ee5a11f5 100755
--- a/sample/sample-keys/gen-sample-keys=2Esh=

+++ b/sample/sample-keys/gen-sample-keys=2Esh
@@ -31,7 +31,7 @@
     -conf=
ig openssl=2Ecnf
 
 # Create server key and cert
-openssl req -new -nodes -=
config openssl=2Ecnf -extensions server \
+openssl req -new -nodes -config =
openssl=2Ecnf \
     -keyout sample-ca/server=2Ekey -out sample-ca/server=
=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server/emai=
lAddress=3Dme@myhost=2Emydomain"
 openssl ca -batch -config openssl=2Ecnf -=
extensions server \
@@ -66,7 +66,6 @@
 openssl dsaparam -out sample-ca/dsap=
arams=2Epem 2048
 
 openssl req -new -newkey dsa:sample-ca/dsaparams=2Epem =
-nodes -config openssl=2Ecnf \
-    -extensions server \
     -keyout sampl=
e-ca/server-dsa=2Ekey -out sample-ca/server-dsa=2Ecsr \
     -subj "/C=3DKG=
/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server-DSA/emailAddress=3Dme@myhost=2Em=
ydomain"
 openssl ca -batch -config openssl=2Ecnf -extensions server \
@@ -=
82,7 +81,6 @@
 openssl ecparam -out sample-ca/secp256k1=2Epem -name secp256=
k1
 
 openssl req -new -newkey ec:sample-ca/secp256k1=2Epem -nodes -config =
openssl=2Ecnf \
-    -extensions server \
     -keyout sample-ca/server-ec=
=2Ekey -out sample-ca/server-ec=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOpe=
nVPN-TEST/CN=3DTest-Server-EC/emailAddress=3Dme@myhost=2Emydomain"
 openssl=
 ca -batch -config openssl=2Ecnf -extensions server \

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9=
f73
Gerrit-Change-Number: 2009
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Kar=
ger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--RxlmIFPqcXg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">gen-sample-keys=2Esh: Don&#39;t apply server extensions to CS=
Rs<br><br>Newer OpenSSL versions refuse to add authorityKeyIdentifier with<=
br>issuer:always to a CSR, since there is no issuer certificate yet=2E The<=
br>extensions are already applied when signing with &#39;openssl ca&#39;, s=
o drop<br>them from the &#39;openssl req&#39; calls=2E<br><br>Change-Id: I3=
513563f199e1c5ac98219a527695e40540a9f73<br>Signed-off-by: Steffan Karger &l=
t;steffan@karger=2Eme&gt;<br>---<br>M sample/sample-keys/gen-sample-keys=2E=
sh<br>1 file changed, 1 insertion(+), 3 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/20=
09/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/sample/=
sample-keys/gen-sample-keys=2Esh</span><br><span>index fa5f697=2E=2Ee5a11f5=
 100755</span><br><span>--- a/sample/sample-keys/gen-sample-keys=2Esh</span=
><br><span>+++ b/sample/sample-keys/gen-sample-keys=2Esh</span><br><span>@@=
 -31,7 +31,7 @@</span><br><span>     -config openssl=2Ecnf</span><br><span>=
 </span><br><span> # Create server key and cert</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-openssl req -new -nodes -config openssl=2Ecnf -ex=
tensions server \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+op=
enssl req -new -nodes -config openssl=2Ecnf \</span><br><span>     -keyout =
sample-ca/server=2Ekey -out sample-ca/server=2Ecsr \</span><br><span>     -=
subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server/emailAddress=
=3Dme@myhost=2Emydomain&quot;</span><br><span> openssl ca -batch -config op=
enssl=2Ecnf -extensions server \</span><br><span>@@ -66,7 +66,6 @@</span><b=
r><span> openssl dsaparam -out sample-ca/dsaparams=2Epem 2048</span><br><sp=
an> </span><br><span> openssl req -new -newkey dsa:sample-ca/dsaparams=2Epe=
m -nodes -config openssl=2Ecnf \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    -extensions server \</span><br><span>     -keyout sample-ca/=
server-dsa=2Ekey -out sample-ca/server-dsa=2Ecsr \</span><br><span>     -su=
bj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server-DSA/emailAddress=
=3Dme@myhost=2Emydomain&quot;</span><br><span> openssl ca -batch -config op=
enssl=2Ecnf -extensions server \</span><br><span>@@ -82,7 +81,6 @@</span><b=
r><span> openssl ecparam -out sample-ca/secp256k1=2Epem -name secp256k1</sp=
an><br><span> </span><br><span> openssl req -new -newkey ec:sample-ca/secp2=
56k1=2Epem -nodes -config openssl=2Ecnf \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    -extensions server \</span><br><span>     -keyout s=
ample-ca/server-ec=2Ekey -out sample-ca/server-ec=2Ecsr \</span><br><span> =
    -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server-EC/emailA=
ddress=3Dme@myhost=2Emydomain&quot;</span><br><span> openssl ca -batch -con=
fig openssl=2Ecnf -extensions server \</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail">chang=
e 2009</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3513563f199e1c5ac98219a527695e40540a9f73 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2009 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--RxlmIFPqcXg=--


--===============3322570523679969139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3322570523679969139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3322570523679969139==--

