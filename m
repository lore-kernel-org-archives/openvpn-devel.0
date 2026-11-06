Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841A606A328
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YDzHHavM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lvedeG9J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Wbt7m5gp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RwWeVDEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MLZWh2uKtKWLOmh60n9h8viQ1KHwqk5ThOBrg9voNU8=; b=YDzHHavMf7ZvjcmC/qfhxC3VJa
	dLFRHmEwvOu2n5bqyM5OALZAa0EX4VRhLa3cO668XqYXPVyo9iBDpb/SigVbu5cXt0g96ScB7BHJz
	s1N930Clyj7DCMvvS5U15czsYugzqdTpL2hvw0mwbKWT4TncZ9tfChKVVfWqiBxH7h5E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPGQZ-000000003Av-2gCt;
	Fri, 06 Nov 2026 09:40:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPGQY-000000003Ao-0xTM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0TW2AfKVEnKtbpwTgAB7aQZlRcjFO4pPNTkeB+Y4iU=; b=lvedeG9JXBacP/l9jR2T1cY/BI
 s7s9lmSEIfzq1LSmSfwwxXzefF/ZfmHt/QBOuk01PnrhphGvZbq+7WUPU90EWzmg9gyX7ErrtRSEZ
 uniuDfybRYGkq6uHXygPUa1tIk+K+W4vzdG6SYRrY0YhnL2c6m7PS5e7W3vTcI7ZR2+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0TW2AfKVEnKtbpwTgAB7aQZlRcjFO4pPNTkeB+Y4iU=; b=Wbt7m5gp8zlTJgP5GVcPW1RZZ9
 IcLL4eKx/YLRcRT88YygWBCPJC1/mGHwMobzUxL5R3yFVirgxM5TfQsunoBlASZaxa46qgGO6xDHT
 Nha50/N/lkN793Hi/z2MK1ZhgwSaZ0doqHLazX1M7hPu/evIH8EOC7isdKN2R+AvyOe8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPGQR-000000006Kg-3K8y for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:40:06 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so5327785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 01:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793957993; x=1794562793; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m0TW2AfKVEnKtbpwTgAB7aQZlRcjFO4pPNTkeB+Y4iU=;
 b=RwWeVDEMYvprma75AzG0OpvQZFN6mrmR+ljoV3p9G2mUxG0JUivq+8KNRyGyNtOu3N
 myu08zT8w58Jvp+fLH2GFOewdRhT8GlRBhs9pGuVo7HhraasQfuiIjDQElttez4SX11h
 AzKfUkme+ZLnYqHYpmHEur52K5Ge0oAHAJS/cH6bo6jeXq3/OPMg0QjT9oaLZFEtLcTj
 xfcP6Dk1N7kz+gpCRpqIlkpSpiMmYV+VwuCj3aSaASPkCIY00VUURBBun9JE7pOH45VZ
 Ig40XqHsG1ps85S0rKkIZLONNOUpO9JxcWY+FpYdmRvrL5wkSuL7xfK6+GYU9x0HasFU
 6CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793957993; x=1794562793;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m0TW2AfKVEnKtbpwTgAB7aQZlRcjFO4pPNTkeB+Y4iU=;
 b=cPXtUhuveWixy2Z7qG4wjY7N0wcQI9+SUzVp3RhLC1Gq4pFJlgAlunAbrXN/zc5AT/
 uwHpNmVZkjIlSJbXaCm0CX76YkQ/+oGqySnRxSn6d7TzN7WQw/f/GoUEEj0ANWnyHnWJ
 9pQzMwtgBZ4eU2vwIlTCHYXW/Xr3gkbx6/v+7F04PnAoLswcGwWSTm1DyliA0JMBu3en
 e5gqKd8MRgGlx49Cms+3wBC+RarUGPgOshk1+AzyOA3hMIbQP2Sl4pJQRDhM3VmXn0wg
 SjILpy9KcbZ70CX5LpuZ/MAXTQiJN2dl8VP1jP3q0xUfiNNhg4XL3gFo3P/nlf43rrkF
 8cMA==
X-Gm-Message-State: APuU4Z+2X30JFwjN20B1Z5gN3O0CT7dT8+6TnoTYl4x5m5EAXciINFTH
 oZT1RZwuhqY0HdxEGICfrkcwxiZYWUogmojmeFD8hP2y9g729zlsYRyNBe10qHTXHjgnjz4jPU8
 Hv0P6Szmc4ptv0YZXuCn74YqT0H3WpyBPbQO+G3KPYiAyw6sL+7gRyT1hcpUKZUJN4yDq64RYey
 DRbSdtQQ==
X-Gm-Gg: AYBFou0YtoMkzXcGVcnoAsCsHjMhTkQwu6NWt4q67h6U2vU7ZPsFYfDrh2ZFtvsHV5i
 ilsXIBrgqwerbo1Y/2SW6cNEfW2EBPdkVRnn/Fqc9mYkpCos/gfnOxzFVPOy5nodFXAGLMOhL1X
 00wZ/EA+DEEfER0G9tl40mQ+6eAV8oRIKU9+8SaT/lknwRUKRQSrD7s03BKS/dB/XXA55jOxFae
 HsLoptM8eynlvi6hQhU+sVMjau4K28umG94r8ONO0dgf3W2Ts1KUQnpcf+oQfiAO9wgXRMo4Wxp
 iiiiRieU6IA0xg12I9oTYI003XewWy54Pb3BnN0p2j1A1ielXgHoAhamrOcrUXanay/4P6n2YEk
 n8XMObJLefWwKVieuWlTVp2SK21NW1CDc6CFXy5q6L3y2pDWfVK9XflKsayPY+zC4DP3JnYXLgi
 d3AjOwSnB6+okBzw1PYUOJB6fZiNRKhaK9E133kjN72W8N3bP5yGhOdhdnuMWmBgTrF6vJZANHr
 1qc76dQwfA1dRihfTSrtwrVrppaxgO/IVk2OLu8lEou7b1G3sJbAtSxWEOMBF0pK89igjPrmgJF
 cTxE/d0Lu7LppQnJ6UAXh9TN1Kb7XgeMT8MKubJPQvSvHDwRcXzESAMCaUgbbsrGwJJHCziPv2F
 S4bKNnC0UY4ts/ejE9phLxvWWA9q0XlylN2om2rzUoZlWd0r7UVxJn1MWiedG2zai95YkuItZFQ
 J/pyvK1Jb7Dm2R9w==
X-Received: by 2002:a05:600c:190d:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4b6de4a5d67mr32201285e9.6.1793957992718; 
 Fri, 06 Nov 2026 01:39:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d770248esm2785092f8f.42.2026.11.06.01.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:39:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 09:39:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
X-Gerrit-Change-Number: 2141
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2141?usp=email>
X-Gerrit-Commit: 7804cf0170ecc8019c7eff79db9fa13a6108d080
In-Reply-To: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODcyNzg0MDAwLkkxM2Y5ZjdkZDYxZDdhNGNjOTg2MTU1NjI5ZjZhM2M3OTJhYWFjNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1cb13e2fee7998f017f6c932478f485dbbcee573-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPGQR-000000006Kg-3K8y
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.7]: backport
 t_client.sh changes from master
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8533588970316881559=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8533588970316881559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zx9qpF3O2Zc="; charset=UTF-8

--Zx9qpF3O2Zc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=
=3Demail

to look at the new patch set (#3)=2E

The following approvals got=
 outdated and were removed:
Code-Review+2 by Frank Lichtenheld


Change sub=
ject: backport t_client=2Esh changes from master
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

backport t_client=2Esh changes from m=
aster

This is basically just copying in the current t_client=2Esh=2Ein scr=
ipt from
master, with a number of changes that are not in 2=2E7 yet - most =
notably
support for "expect failure" cases=2E

Given that this is a test su=
pport script with no dependencies into the
OpenVPN core, and the large numb=
er of non-backported scripts that touch
one line or the other, or re-indent=
 things, copying the whole script
instead of trying to cherry-pick all the =
individual change seemed like
a much better idea=2E=2E=2E

Besides t_client=
=2Esh, this also brings tests/update_t_client_ips=2Esh
from master, because=
 the dc16248523 commit will break functionality
otherwise=2E

Here's the li=
st:

commit e2548f6e3b7f9ed3d24020319117b17f30743656
    t_client=2Esh=2Ein=
: Check whether addresses are in "tentative" state

commit af6a79c6a83739ca=
9542e52a02a3449a2f292758
    t_client=2Esh=2Ein: Add ability to filter by t=
est group

commit dc162485236b70ecfe1be639dbd9db8244a85d54
    t_client=2Es=
h=2Ein: Allow to override the location of t_client_ips=2Erc
    (needs upda=
ted update_t_client_ips=2Esh)

commit 8b392d642eb4c9b9135dc6a442d943159467e=
058
    t_client=2Esh=2Ein: Add utility function needs_openvpn()

commit dc=
162485236b70ecfe1be639dbd9db8244a85d54
    t_client=2Esh=2Ein: Allow to ove=
rride the location of t_client_ips=2Erc

commit 37ea1c7683ccb464f80d6e7e8fb=
cd4b8baf2ac60
    t_client=2Esh=2Ein: Add support for expected test failure=
s

commit ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
    reformat-shell=2Esh:=
 Add --simplify argument

commit f781227c92a3d1017e9d8a67e83e4465b43edf66
 =
   Reformat all shell-scripts with shfmt
    (touches update_t_client_ips=
=2Esh)

commit b32d1ab45ec93786191e0dac2c8f5549d6c04258
    t_client=2Esh=
=2Ein: Do not try to guess the absolute path to LOGDIR

commit da1b2a7081eb=
2791f3a675945c42d7f3189ef752
    t_client=2Esh=2Ein: Use printf instead of =
echo -e

commit 162f19112702d1c8045efd17c5b09022fe1e04fb
    t_client=2Esh=
=2Ein: Do not run resolvectl if systemd is not running

commit 841ab0b216a4=
24eb0100448362f76a2c12b3a516
    t_client=2Esh: Do not use CA_CERT variable=
 as indicator for good =2Erc file

Change-Id: I13f9f7dd61d7a4cc986155629f6a=
3c792aaac6d2
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2141
Message-Id: <20261105164926=2E24646-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40756=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
M tests/update_t_client_ips=
=2Esh
2 files changed, 257 insertions(+), 185 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/2141/3

diff --git =
a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 876e84a=2E=2E5e=
924bb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
=
@@ -19,57 +19,82 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_build=
dir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
=
-if [ -r "${top_builddir}"/t_client=2Erc ] ; then
-    =2E "${top_builddir}=
"/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ] ; then
-    =2E "${s=
rcdir}"/t_client=2Erc
-else
-    echo "$0: cannot find 't_client=2Erc' in b=
uild dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${sr=
cdir}')=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+t_client_i=
ps_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
+update_t_c=
lient_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
+
=
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client=
=2Erc ]; then
+        t_client_rc=3D"${top_builddir}"/t_client=2Erc
+    e=
lif [ -r "${srcdir}"/t_client=2Erc ]; then
+        t_client_rc=3D"${srcdir=
}"/t_client=2Erc
+    else
+        echo "$0: cannot find 't_client=2Erc' i=
n build dir ('${top_builddir}')" >&2
+        echo "$0: or source directory=
 ('${srcdir}')=2E SKIPPING TEST=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
=
+    fi
 fi
 
 # Check for external dependencies
 FPING=3D"fping"
 FPING6=
=3D"fping6"
-which fping > /dev/null
+which fping >/dev/null
 if [ $? -ne 0=
 ]; then
     echo "$0: fping is not available in \$PATH" >&2
     exit "${=
TCLIENT_SKIP_RC}"
 fi
-which fping6 > /dev/null
+which fping6 >/dev/null
 i=
f [ $? -ne 0 ]; then
     echo "$0: fping6 is not available in \$PATH, assu=
ming fping 4=2E0 or later" >&2
     FPING=3D"fping -4"
     FPING6=3D"fping=
 -6"
 fi
 
-KILL_EXEC=3D`which kill`
+KILL_EXEC=3D$(which kill)
 if [ $? -n=
e 0 ]; then
     echo "$0: kill not found in \$PATH" >&2
     exit "${TCLIE=
NT_SKIP_RC}"
 fi
 
-if [ ! -x "${openvpn}" ]
-then
+if [ ! -x "${openvpn}" =
]; then
     echo "no (executable) openvpn binary in current build tree=2E =
FAIL=2E" >&2
     exit 1
 fi
 
-if [ ! -w =2E ]
-then
+if [ ! -w =2E ]; the=
n
     echo "current directory is not writable (required for logging)=2E FA=
IL=2E" >&2
     exit 1
 fi
 
-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CER=
T not defined in 't_client=2Erc'=2E SKIP test=2E" >&2
+openvpn_version=3D$(=
${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E 's/^2\=2E([012345=
6789]+)=2E*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=3D$1
+
+    [ =
"$openvpn_version" -ge "$needs_version" ]
+    return $?
+}
+
+=2E "${t_cli=
ent_rc}"
+
+if [ -z "$TEST_RUN_LIST" ]; then
+    echo "TEST_RUN_LIST empty=
, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi=

 
-if [ -z "$TEST_RUN_LIST" ] ; then
-    echo "TEST_RUN_LIST empty, no te=
sts defined=2E  SKIP test=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -n "=
$TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=3D
+    for test in $TEST_RUN_L=
IST; do
+        group=3D$(echo $test | sed -E 's/^([0123456789]+)=2E*/\1/'=
)
+        if [ "$group" =3D "$TEST_RUN_GROUP" ]; then
+            FILTERE=
D_LIST=3D"$FILTERED_LIST $test"
+        fi
+    done
+    if [ -z "$FILTER=
ED_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty (group=3D$TEST=
_RUN_GROUP), no tests defined=2E  SKIP test=2E" >&2
+        exit "${TCLIEN=
T_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=3D$FILTERED_LIST
 fi
 
 # Ensure PRE=
FER_KSU is in a known state
@@ -77,16 +102,14 @@
 
 # make sure we have per=
missions to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doe=
sn't work on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then=
 :
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-  =
  if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]=
; then
         # Check if we have a valid kerberos ticket
         klist -=
l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        =
if [ $? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and=
 fallback to RUN_SUDO
             PREFER_KSU=3D0
             echo "$0: No=
 Kerberos ticket available=2E  Will not use ksu=2E"
@@ -95,8 +118,7 @@
    =
     fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_S=
UDO" ]; then
         echo "$0: this test must run be as root, or RUN_SUDO=
=3D=2E=2E=2E " >&2
         echo "      must be set correctly in 't_client=
=2Erc'=2E SKIP=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -104,20 +126,2=
2 @@
         # We have to use sudo=2E Make sure that we (hopefully) do not=
 have
         # to ask the users password during the test=2E This is done =
to
         # prevent timing issues, e=2Eg=2E when the waits for openvpn to=
 start
-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KI=
LL_EXEC -0 succeeded, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC =
-0 failed, cannot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	f=
i
+        if $RUN_SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_=
SUDO $KILL_EXEC -0 succeeded, good=2E"
+        else
+            echo "$0:=
 $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+            =
exit "${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_client-`hos=
tname`-`date +%Y%m%d-%H%M%S`
+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-=
%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR=3D"${LOGDIR}-${TEST_=
RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if =
mkdir $LOGDIR; then
+    :
 else
     echo "can't create log directory '$LO=
GDIR'=2E FAIL=2E" >&2
     exit 1
@@ -137,21 +161,28 @@
 output_start()
 {
=
     case $V in
-	0) outbuf=3D"" ;;			# no per-test output at all
-	1) prin=
tf "$@\n"			# compact, details only on failure
-           outbuf=3D"\n" ;;=

-	*) printf "\n$@\n" ;;		# print all, with a bit formatting
+        0) ou=
tbuf=3D"" ;; # no per-test output at all
+        1)
+            printf "$=
@\n" # compact, details only on failure
+            outbuf=3D"\n"
+       =
     ;;
+        *) printf "\n$@\n" ;; # print all, with a bit formatting
 =
    esac
 }
 
 output()
 {
-    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; the=
n END_NL=3D"" ; shift ; fi
+    END_NL=3D"\n"
+    if [ "X$1" =3D "X-n" ]; =
then
+        END_NL=3D""
+        shift
+    fi
     case $V in
-	0) ;;			=
	# no per-test output at all
-	1) outbuf=3D"$outbuf$@${END_NL}"	# print det=
ails only on failure
-           ;;
-	*) printf "$@${END_NL}" ;;	# print ev=
erything
+        0) ;; # no per-test output at all
+        1)
+          =
  outbuf=3D"$outbuf$@${END_NL}" # print details only on failure
+          =
  ;;
+        *) printf "$@${END_NL}" ;; # print everything
     esac
 }
 
=
@@ -159,62 +190,61 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=
=3D$(( $fail_count + 1 ))
+    fail_count=3D$((fail_count + 1))
 }
 
 # pri=
nt "all interface IP addresses" + "all routes"
 # this is higly system depe=
ndent=2E=2E=2E
 get_ifconfig_route()
 {
-    UNAME=3D`uname -s`
+    UNAME=
=3D$(uname -s)
     case $UNAME in
-	Linux)
+        Linux)
             # =
linux / iproute2? (-> if configure got a path)
-            if [ -n "@IPROU=
TE@" ]
-            then
+            if [ -n "@IPROUTE@" ]; then
         =
        echo "-- linux iproute2 --"
-                @IPROUTE@ addr show   =
  | grep -v valid_lft
+                @IPROUTE@ addr show | grep -v valid_=
lft
                 @IPROUTE@ route show
                 @IPROUTE@ -o -6 =
route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (=
mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
   =
          else
-	        echo "-- linux / ifconfig --"
-	        LANG=3DC @=
IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 =
-6
+                echo "-- linux / ifconfig --"
+                LANG=3DC=
 @IFCONFIG@ -a | egrep "( addr:|encap:)"
+                LANG=3DC @NETSTAT=
@ -rn -4 -6
             fi
             ;;
-	FreeBSD|NetBSD|Darwin)
-	   e=
cho "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(fl=
ags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }=
'
-	   ;;
-	OpenBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "=
(flags=3D|inet)" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-=
	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	Sun=
OS)
-	   echo "-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
=
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX=
)
-	   echo "-- AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @=
NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
+        Fr=
eeBSD | NetBSD | Darwin)
+            echo "-- FreeBSD/NetBSD/Darwin [MacOS=
 X] --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            @=
NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+ =
       OpenBSD)
+            echo "-- OpenBSD --"
+            @IFCONFIG@ -=
a | egrep "(flags=3D|inet)" |
+                sed -e 's/pltime [0-9]*//' -=
e 's/vltime [0-9]*//'
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { prin=
t $1,$2,$3,$NF }'
+            ;;
+        SunOS)
+            echo "-- Sol=
aris --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            =
@NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
+ =
       AIX)
+            echo "-- AIX --"
+            @IFCONFIG@ -a | egre=
p "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print =
$1,$2,$3,$6 }'
+            ;;
         *)
-           echo "get_ifconfig_r=
oute(): no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E" >&2
- =
          exit 20
-           ;;
+            echo "get_ifconfig_route(): n=
o idea how to get info on your OS ($(uname -s))=2E  FAIL=2E" >&2
+         =
   exit 20
+            ;;
     esac
 
     # another round of per-platform=
 information gathering, for DNS info
     # for most of the platforms "cat =
/etc/resolv=2Econf" is good enough
     # except Linux and MacOS
     case =
$UNAME in
-	Linux)
-            if [ -x /usr/bin/resolvectl -a -d /run/syst=
emd/system ] ; then
+        Linux)
+            if [ -x /usr/bin/resolvect=
l -a -d /run/systemd/system ]; then
                 echo "-- linux resolve=
ctl --"
                 resolvectl status
             else
@@ -222,7 +252=
,7 @@
                 cat /etc/resolv=2Econf
             fi
             =
;;
-	Darwin)
+        Darwin)
             echo "-- MacOS scutil --dns"
   =
          scutil --dns
             ;;
@@ -260,19 +290,19 @@
 #  arg2: IPv4=
/IPv6 address that must show up in out of "get_ifconfig_route"
 check_ifcon=
fig()
 {
-    proto=3D$1 ; shift
+    proto=3D$1
+    shift
     expect_lis=
t=3D"$@"
 
-    if [ -z "$expect_list" ] ; then return ; fi
-    if [ "$exp=
ect_list" =3D "-" ] ; then return ; fi
+    if [ -z "$expect_list" ]; then =
return; fi
+    if [ "$expect_list" =3D "-" ]; then return; fi
 
-    for e=
xpect in $expect_list
-    do
-	if get_ifconfig_route | fgrep "$expect" >/d=
ev/null
-	then :
-	else
-	    fail "check_ifconfig(): expected IPv$proto ad=
dress '$expect' not found in ifconfig output=2E"
-	fi
+    for expect in $e=
xpect_list; do
+        if get_ifconfig_route | fgrep "$expect" >/dev/null;=
 then
+            :
+        else
+            fail "check_ifconfig(): exp=
ected IPv$proto address '$expect' not found in ifconfig output=2E"
+       =
 fi
     done
 }
 
@@ -283,47 +313,48 @@
 #  arg3=2E=2E=2E -> fping argumen=
ts (host list)
 run_ping_tests()
 {
-    proto=3D$1 ; want=3D$2 ; shift ; s=
hift
+    proto=3D$1
+    want=3D$2
+    shift
+    shift
     targetlist=
=3D"$@"
 
     # "no targets" is fine
-    if [ -z "$targetlist" ] ; then r=
eturn ; fi
+    if [ -z "$targetlist" ]; then return; fi
 
     case $proto=
 in
-	4) cmd=3D"$FPING" ;;
-	6) cmd=3D"$FPING6" ;;
-	*) echo "internal erro=
r in run_ping_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+        4) cmd=3D"=
$FPING" ;;
+        6) cmd=3D"$FPING6" ;;
+        *)
+            echo "in=
ternal error in run_ping_tests arg 1: '$proto'" >&2
+            exit 1
+  =
          ;;
     esac
 
     case $want in
-	want_ok)   sizes_list=3D"64 1=
440 3000" ;;
-	want_fail) sizes_list=3D"64" ;;
+        want_ok) sizes_list=
=3D"64 1440 3000" ;;
+        want_fail) sizes_list=3D"64" ;;
     esac
 
-=
    for bytes in $sizes_list
-    do
-	output "run IPv$proto ping tests ($w=
ant), $bytes byte packets=2E=2E=2E"
+    for bytes in $sizes_list; do
+    =
    output "run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E"=

 
-	echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDI=
R/$SUF:fping=2Eout
-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist=
 >>$LOGDIR/$SUF:fping=2Eout 2>&1
+        echo "$cmd -b $bytes -C 20 -p 250=
 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
+        $cmd -b $b=
ytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&=
1
 
-	# while OpenVPN is running, pings must succeed (want=3D'want_ok')
-	#=
 before OpenVPN is up, pings must NOT succeed (want=3D'want_fail')
+       =
 # while OpenVPN is running, pings must succeed (want=3D'want_ok')
+       =
 # before OpenVPN is up, pings must NOT succeed (want=3D'want_fail')
 
-	rc=
=3D$?
-	if [ $rc =3D 0 ] 				# all ping OK
-	then
-	    if [ $want =3D "wan=
t_fail" ]		# not what we want
-	    then
-		fail "IPv$proto ping test succe=
eded, but needs to *fail*=2E"
-	    fi
-	else					# ping failed
-	    if [ =
$want =3D "want_ok" ]		# not what we wanted
-	    then
-		fail "IPv$proto p=
ing test ($bytes bytes) failed, but should succeed=2E"
-	    fi
-	fi
+     =
   rc=3D$?
+        if [ $rc =3D 0 ]; then                 # all ping OK
+ =
           if [ $want =3D "want_fail" ]; then # not what we want
+         =
       fail "IPv$proto ping test succeeded, but needs to *fail*=2E"
+      =
      fi
+        else                               # ping failed
+       =
     if [ $want =3D "want_ok" ]; then # not what we wanted
+               =
 fail "IPv$proto ping test ($bytes bytes) failed, but should succeed=2E"
+ =
           fi
+        fi
     done
 }
 
@@ -334,8 +365,7 @@
 SUMMARY_SKIP=
=3D
 SUMMARY_FAIL=3D
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN=
_LIST; do
     # get config variables
     eval test_prep=3D\"\$PREPARE_$SU=
F\"
     eval test_check_skip=3D\"\$CHECK_SKIP_$SUF\"
@@ -347,26 +377,32 @@=

     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_h=
osts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\=
"
+    eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=3D\"\=
$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variable=
s for this test are missing, run an --up
     # script to generate them dyn=
amically=2E
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" =
]; then
-        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_bu=
ilddir} --script-security 2 --up ${srcdir}/update_t_client_ips=2Esh"
+     =
   up=3D"--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-secu=
rity 2 --up ${update_t_client_ips}"
     else
         up=3D""
     fi
 
  =
   output_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$e=
xpect_fail" ]; then
+        output "### expect failure: '$expect_fail'"
+ =
   fi
     fail_count=3D0
 
     if [ -n "$test_check_skip" ]; then
       =
  output "check whether we need to skip: '$test_check_skip'"
-        if ev=
al $test_check_skip; then :
+        if eval $test_check_skip; then
+      =
      :
         else
             output "skip check failed, SKIP test $SU=
F=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    printf "$outbuf" ; co=
ntinue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+            printf=
 "$outbuf"
+            continue
         fi
     fi
 
@@ -385,13 +421,14 @=
@
     output "\nrun pre-openvpn ping tests - targets must not be reachable=
=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_ping_tes=
ts 6 want_fail "$ping6_hosts"
-    if [ "$fail_count" =3D 0 ] ; then
+    i=
f [ "$fail_count" =3D 0 ]; then
         output "OK=2E\n"
     else
-	fail =
"make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E"
-=
	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D31
-	printf "$outbuf" ; =
continue
+        fail "make sure that ping hosts are ONLY reachable via VP=
N, SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+       =
 exit_code=3D31
+        printf "$outbuf"
+        continue
     fi
 
     =
pidfile=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"
@@ -406,38 +443,77 @@
     # to =
$ovpn_init_check times=2E
     ovpn_init_check=3D30
     ovpn_init_success=
=3D0
-    while [ $ovpn_init_check -gt 0 ];
-    do
-       sleep 1  # Wait=
 for OpenVPN to initialize and have had time to write the pid file
-       =
grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/n=
ull
-       if [ $? -eq 0 ]; then
-           ovpn_init_check=3D0
-        =
   ovpn_init_success=3D1
-       fi
-       ovpn_init_check=3D$(( $ovpn_ini=
t_check - 1 ))
+    while [ $ovpn_init_check -gt 0 ]; do
+        sleep 1 #=
 Wait for OpenVPN to initialize and to write the pid file
+        if [ -n =
"$expect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openvp=
n=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn=
_init_check=3D0
+                ovpn_init_success=3D1
+                sle=
ep 5 # give openvpn time to quit
+            fi
+        else
+           =
 grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/=
null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=3D=
0
+                ovpn_init_success=3D1
+            fi
+        fi
+     =
   ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
-    opid=3D`cat =
$pidfile`
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
     if [ -n "$opi=
d" ]; then
         output "  OpenVPN running with PID $opid"
     else
-  =
      output "  Could not read OpenVPN PID file"
+        if [ -z "$expect_=
fail" ]; then # print this only if unexpected
+            output "  Could =
not read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not =
start
+    # did we expect a failure?
+    if [ -n "$expect_fail" ]; then
+=
        if [ -n "$opid" ]; then # OpenVPN did start!
+            output "$=
0: OpenVPN did start up, expected failure"
+            $RUN_SUDO $KILL_EXE=
C $opid $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+        =
    output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            fail "skip =
rest of sub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 15
+   =
         SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D32
+ =
           printf "$outbuf"
+            continue
+        elif [ $ovpn_ini=
t_success -eq 0 ]; then
+            output "$0: OpenVPN failure did not ma=
tch expected failure"
+            output "tail -5 $SUF:openvpn=2Elog"
+   =
         output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            SUMMAR=
Y_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D33
+            prin=
tf "$outbuf"
+            continue
+        else
+            output "test =
run $SUF: all tests OK (saw expected failure)=2E"
+            SUMMARY_OK=
=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If=
 OpenVPN did not start but should have
     if [ $ovpn_init_success -ne 1 -=
o -z "$opid" ]; then
         output "$0:  OpenVPN did not initialize in a =
reasonable time"
         if [ -n "$opid" ]; then
-           $RUN_SUDO $KI=
LL_EXEC $opid
+            $RUN_SUDO $KILL_EXEC $opid
         fi
         =
$RUN_SUDO $KILL_EXEC $sudopid
-	output "tail -5 $SUF:openvpn=2Elog"
-	outpu=
t "`tail -5 $LOGDIR/$SUF:openvpn=2Elog`"
-	fail "skip rest of sub-tests for=
 test run $SUF=2E"
-	trap - 0 1 2 3 15
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF=
"
-	exit_code=3D30
-	printf "$outbuf" ; continue
+        output "tail -5 $=
SUF:openvpn=2Elog"
+        output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
=
+        fail "skip rest of sub-tests for test run $SUF=2E"
+        trap -=
 0 1 2 3 15
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=
=3D30
+        printf "$outbuf"
+        continue
     fi
 
     # make sur=
e openvpn client is terminated in case shell exits
@@ -452,17 +528,16 @@
  =
       exit 1
     fi
 
-    if [ "$expect_ifconfig4" =3D "-" ] ; then
+   =
 if [ "$expect_ifconfig4" =3D "-" ]; then
         output "skip ifconfig+ro=
ute check"
     else
-	output -n "compare pre-openvpn ifconfig+route with c=
urrent values=2E=2E=2E"
-	if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-=
		$LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/null
-	then
-	    fail "no differ=
ences between ifconfig/route before OpenVPN start and now=2E"
-	else
-	    =
output " OK!\n"
-	fi
+        output -n "compare pre-openvpn ifconfig+route=
 with current values=2E=2E=2E"
+        if diff $LOGDIR/$SUF:ifconfig_route=
_pre=2Etxt \
+            $LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/null; the=
n
+            fail "no differences between ifconfig/route before OpenVPN s=
tart and now=2E"
+        else
+            output " OK!\n"
+        fi
   =
  fi
 
     # post init script needed?
@@ -483,8 +558,8 @@
     $RUN_SUDO $=
KILL_EXEC $opid
     wait $!
     rc=3D$?
-    if [ $rc !=3D 0 ] ; then
-	f=
ail "OpenVPN return code $rc, expect 0"
+    if [ $rc !=3D 0 ]; then
+     =
   fail "OpenVPN return code $rc, expect 0"
     fi
 
     output "\nsave p=
ost-openvpn ifconfig + route=2E=2E=2E"
@@ -496,23 +571,22 @@
 
     output =
-n "compare pre- and post-openvpn ifconfig + route=2E=2E=2E"
     if diff $=
LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-	    $LOGDIR/$SUF:ifconfig_route_po=
st=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt
-    then
-	output " OK=2E=
\n"
+        $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_=
route_diff=2Etxt; then
+        output " OK=2E\n"
     else
-	output "\n\n"=
 "`cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt`" "\n"
-	fail "differences be=
tween pre- and post-ifconfig/route=2E"
+        output "\n\n" "$(cat $LOGDI=
R/$SUF:ifconfig_route_diff=2Etxt)" "\n"
+        fail "differences between =
pre- and post-ifconfig/route=2E"
     fi
-    if [ "$fail_count" =3D 0 ] ; =
then
+    if [ "$fail_count" =3D 0 ]; then
         output "test run $SUF: =
all tests OK=2E\n"
-	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+        SUMMARY_OK=3D=
"$SUMMARY_OK $SUF"
     else
-	if [ "$V" -gt 0 ] ; then
-	    printf "$outb=
uf"
-	    echo "test run $SUF: $fail_count test failures=2E FAIL=2E"
+     =
   if [ "$V" -gt 0 ]; then
+            printf "$outbuf"
+            echo =
"test run $SUF: $fail_count test failures=2E FAIL=2E"
         fi
-	SUMMARY=
_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
+        SUMMARY_FAIL=3D"$SUM=
MARY_FAIL $SUF"
+        exit_code=3D30
     fi
 
     if [ -n "$test_clean=
up" ]; then
@@ -522,9 +596,9 @@
 
 done
 
-if [ -z "$SUMMARY_OK" ] ; then S=
UMMARY_OK=3D" none"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" =
none"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D" none"; fi
+if =
[ -z "$SUMMARY_OK" ]; then SUMMARY_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP=
" ]; then SUMMARY_SKIP=3D" none"; fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMA=
RY_FAIL=3D" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK=2E"
 echo "Tes=
t sets skipped:$SUMMARY_SKIP=2E"
 echo "Test sets failed:$SUMMARY_FAIL=2E"
=
diff --git a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Es=
h
index 96e3826=2E=2Ef02dc7f 100755
--- a/tests/update_t_client_ips=2Esh
++=
+ b/tests/update_t_client_ips=2Esh
@@ -3,14 +3,12 @@
 # This --up script ca=
ches the IPs handed out by the test VPN server to a file
 # for later use=
=2E
 
-RC=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
-
-grep EXPECT_IFCONFIG4_$TES=
TNUM=3D $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/n=
ull 2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifc=
onfig_local" >> $RC
+    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local"=
 >>$RC
 fi
 
-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+grep =
EXPECT_IFCONFIG6_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-  =
  echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $RC
+    echo =
"EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >>$RC
 fi

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I13f9f7dd61d7a4cc98615=
5629f6a3c792aaac6d2
Gerrit-Change-Number: 2141
Gerrit-PatchSet: 3
Gerrit-Ow=
ner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--Zx9qpF3O2Zc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review+2 by =
Frank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">backport t_client=2Esh changes from mast=
er<br><br>This is basically just copying in the current t_client=2Esh=2Ein =
script from<br>master, with a number of changes that are not in 2=2E7 yet -=
 most notably<br>support for &quot;expect failure&quot; cases=2E<br><br>Giv=
en that this is a test support script with no dependencies into the<br>Open=
VPN core, and the large number of non-backported scripts that touch<br>one =
line or the other, or re-indent things, copying the whole script<br>instead=
 of trying to cherry-pick all the individual change seemed like<br>a much b=
etter idea=2E=2E=2E<br><br>Besides t_client=2Esh, this also brings tests/up=
date_t_client_ips=2Esh<br>from master, because the dc16248523 commit will b=
reak functionality<br>otherwise=2E<br><br>Here&#39;s the list:<br><br>commi=
t e2548f6e3b7f9ed3d24020319117b17f30743656<br>    t_client=2Esh=2Ein: Check=
 whether addresses are in &quot;tentative&quot; state<br><br>commit af6a79c=
6a83739ca9542e52a02a3449a2f292758<br>    t_client=2Esh=2Ein: Add ability to=
 filter by test group<br><br>commit dc162485236b70ecfe1be639dbd9db8244a85d5=
4<br>    t_client=2Esh=2Ein: Allow to override the location of t_client_ips=
=2Erc<br>    (needs updated update_t_client_ips=2Esh)<br><br>commit 8b392d6=
42eb4c9b9135dc6a442d943159467e058<br>    t_client=2Esh=2Ein: Add utility fu=
nction needs_openvpn()<br><br>commit dc162485236b70ecfe1be639dbd9db8244a85d=
54<br>    t_client=2Esh=2Ein: Allow to override the location of t_client_ip=
s=2Erc<br><br>commit 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60<br>    t_clie=
nt=2Esh=2Ein: Add support for expected test failures<br><br>commit ed427eab=
1683af3adf21553dd1c6b6e4b8b2f10d<br>    reformat-shell=2Esh: Add --simplify=
 argument<br><br>commit f781227c92a3d1017e9d8a67e83e4465b43edf66<br>    Ref=
ormat all shell-scripts with shfmt<br>    (touches update_t_client_ips=2Esh=
)<br><br>commit b32d1ab45ec93786191e0dac2c8f5549d6c04258<br>    t_client=2E=
sh=2Ein: Do not try to guess the absolute path to LOGDIR<br><br>commit da1b=
2a7081eb2791f3a675945c42d7f3189ef752<br>    t_client=2Esh=2Ein: Use printf =
instead of echo -e<br><br>commit 162f19112702d1c8045efd17c5b09022fe1e04fb<b=
r>    t_client=2Esh=2Ein: Do not run resolvectl if systemd is not running<b=
r><br>commit 841ab0b216a424eb0100448362f76a2c12b3a516<br>    t_client=2Esh:=
 Do not use CA_CERT variable as indicator for good =2Erc file<br><br>Change=
-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2141<br>Message-Id: &lt;20261105164926=2E24646-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40756=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>M tests/update_=
t_client_ips=2Esh<br>2 files changed, 257 insertions(+), 185 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/41/2141/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein</span><br><span>index 876e84a=2E=2E5e924bb 100755</=
span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t=
_client=2Esh=2Ein</span><br><span>@@ -19,57 +19,82 @@</span><br><span> srcd=
ir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top=
_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_=
builddir}/src/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ] ; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_bui=
lddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ] ; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_clien=
t=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot find &=
#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&=
amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$=
0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;=
&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit &quot;=
${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_client_ip=
s=2Erc}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update=
_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client_ips=
=2Esh}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;${t_client_r=
c}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;${top_bu=
ilddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;$=
{srcdir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#39=
;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        echo &quot;$0: or source directory (&#39;${srcd=
ir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> =
fi</span><br><span> </span><br><span> # Check for external dependencies</sp=
an><br><span> FPING=3D&quot;fping&quot;</span><br><span> FPING6=3D&quot;fpi=
ng6&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping =
&gt; /dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+which=
 fping &gt;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span=
>     echo &quot;$0: fping is not available in \$PATH&quot; &gt;&amp;2</spa=
n><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping6 &gt; /dev/n=
ull</span><br><span style=3D"color: hsl(120, 100%, 40%);">+which fping6 &gt=
;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo=
 &quot;$0: fping6 is not available in \$PATH, assuming fping 4=2E0 or later=
&quot; &gt;&amp;2</span><br><span>     FPING=3D&quot;fping -4&quot;</span><=
br><span>     FPING6=3D&quot;fping -6&quot;</span><br><span> fi</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`wh=
ich kill`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=
=3D$(which kill)</span><br><span> if [ $? -ne 0 ]; then</span><br><span>   =
  echo &quot;$0: kill not found in \$PATH&quot; &gt;&amp;2</span><br><span>=
     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${=
openvpn}&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${op=
envpn}&quot; ]; then</span><br><span>     echo &quot;no (executable) openvp=
n binary in current build tree=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>=
     exit 1</span><br><span> fi</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ ! -w =2E ]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if [ ! -w =2E ]; then</span><br><span>     echo &quot;current direct=
ory is not writable (required for logging)=2E FAIL=2E&quot; &gt;&amp;2</spa=
n><br><span>     exit 1</span><br><span> fi</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$CA_CERT&quot; ] ; th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;CA_C=
ERT not defined in &#39;t_client=2Erc&#39;=2E SKIP test=2E&quot; &gt;&amp;2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_version=3D$=
(${openvpn} --version | head -n 1 | cut -f2 -d&quot; &quot; | sed -E &#39;s=
/^2\=2E([0123456789]+)=2E*$/2\1/&#39;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
needs_openvpn()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    needs_version=3D$1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    [ &quot;$openvpn_version&quot; -ge=
 &quot;$needs_version&quot; ]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return $?</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+=2E &quot;${t_client_rc}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$TEST_RUN_LIST&quot; ]; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;TES=
T_RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span>=
<br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z =
&quot;$TEST_RUN_LIST&quot; ] ; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &quot;TEST_RUN_LIST empty, no tests defined=2E  SKIP=
 test=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_=
LIST; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gro=
up=3D$(echo $test | sed -E &#39;s/^([0123456789]+)=2E*/\1/&#39;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot=
; =3D &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $tes=
t&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$FILTERED_LIST=
&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   echo &quot;Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no te=
sts defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    TEST_RUN_LIST=3D$FILTERED_LIST</sp=
an><br><span> fi</span><br><span> </span><br><span> # Ensure PREFER_KSU is =
in a known state</span><br><span>@@ -77,16 +102,14 @@</span><br><span> </sp=
an><br><span> # make sure we have permissions to run ifconfig/route from Op=
enVPN</span><br><span> # can&#39;t use &quot;id -u&quot; here - doesn&#39;t=
 work on Solaris</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ID=3D=
`id`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID=
&quot; : &quot;uid=3D0&quot; &gt;/dev/null</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ID=3D$(id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    :</span><br><span> else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_=
KSU}&quot; -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quo=
t;${PREFER_KSU}&quot; -eq 1 ]; then</span><br><span>         # Check if we =
have a valid kerberos ticket</span><br><span>         klist -l 1&gt;/dev/nu=
ll 2&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if [ $? -ne 0 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if [ $? -ne 0 ]; then</span><br><span>             # No kerberos ticket fou=
nd, skip ksu and fallback to RUN_SUDO</span><br><span>             PREFER_K=
SU=3D0</span><br><span>             echo &quot;$0: No Kerberos ticket avail=
able=2E  Will not use ksu=2E&quot;</span><br><span>@@ -95,8 +118,7 @@</span=
><br><span>         fi</span><br><span>     fi</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot=
; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&q=
uot; ]; then</span><br><span>         echo &quot;$0: this test must run be =
as root, or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</span><br><span>        =
 echo &quot;      must be set correctly in &#39;t_client=2Erc&#39;=2E SKIP=
=2E&quot; &gt;&amp;2</span><br><span>         exit &quot;${TCLIENT_SKIP_RC}=
&quot;</span><br><span>@@ -104,20 +126,22 @@</span><br><span>         # We =
have to use sudo=2E Make sure that we (hopefully) do not have</span><br><sp=
an>         # to ask the users password during the test=2E This is done to<=
/span><br><span>         # prevent timing issues, e=2Eg=2E when the waits f=
or openvpn to start</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	i=
f $RUN_SUDO $KILL_EXEC -0 $$</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo=
 &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, c=
annot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if $RUN_SUDO $KILL_EXEC -0 $$; then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$0: $RU=
N_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 faile=
d, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            exit &quot;${TCLIENT_SKIP_RC}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><s=
pan>     fi</span><br><span> fi</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M=
%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LOGDIR=3Dt_clien=
t-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TES=
T_RUN_GROUP}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
i</span><br><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-if mkdir $LOGDIR</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if mkdir $LOGDIR; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    :</span><br><span> else</span><br><span>     echo=
 &quot;can&#39;t create log directory &#39;$LOGDIR&#39;=2E FAIL=2E&quot; &g=
t;&amp;2</span><br><span>     exit 1</span><br><span>@@ -137,21 +161,28 @@<=
/span><br><span> output_start()</span><br><span> {</span><br><span>     cas=
e $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) outbuf=3D&=
quot;&quot; ;;			# no per-test output at all</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	1) printf &quot;$@\n&quot;			# compact, details onl=
y on failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
  outbuf=3D&quot;\n&quot; ;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	*) printf &quot;\n$@\n&quot; ;;		# print all, with a bit formatting=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0) outbuf=
=3D&quot;&quot; ;; # no per-test output at all</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            printf &quot;$@\n&quot; # compact, details on=
ly on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      outbuf=3D&quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *) printf &quot;\n$@\n&quot; ;; # print all, with a bit format=
ting</span><br><span>     esac</span><br><span> }</span><br><span> </span><=
br><span> output()</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    END_NL=3D&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot=
;X-n&quot; ] ; then END_NL=3D&quot;&quot; ; shift ; fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    END_NL=3D&quot;\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;X$1&quot; =3D &qu=
ot;X-n&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        END_NL=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        shift</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    fi</span><br><span>     case $V in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	0) ;;				# no per-test output at all</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@${END_NL}=
&quot;	# print details only on failure</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-           ;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	*) printf &quot;$@${END_NL}&quot; ;;	# print everything</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0) ;; # no per-test o=
utput at all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outb=
uf=3D&quot;$outbuf$@${END_NL}&quot; # print details only on failure</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *) printf &quot;$@${END_=
NL}&quot; ;; # print everything</span><br><span>     esac</span><br><span> =
}</span><br><span> </span><br><span>@@ -159,62 +190,61 @@</span><br><span> =
fail()</span><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$((=
 $fail_count + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    fail_count=3D$((fail_count + 1))</span><br><span> }</span><br><span> </=
span><br><span> # print &quot;all interface IP addresses&quot; + &quot;all =
routes&quot;</span><br><span> # this is higly system dependent=2E=2E=2E</sp=
an><br><span> get_ifconfig_route()</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    UNAME=3D`uname -s`</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    UNAME=3D$(uname -s)</span><br><span>=
     case $UNAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	L=
inux)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)=
</span><br><span>             # linux / iproute2? (-&gt; if configure got a=
 path)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
[ -n &quot;@IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if [ -n &quot;@IPROUTE@&quot; ]; then</span><br><span>     =
            echo &quot;-- linux iproute2 --&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                @IPROUTE@ addr show     | grep =
-v valid_lft</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         @IPROUTE@ addr show | grep -v valid_lft</span><br><span>          =
       @IPROUTE@ route show</span><br><span>                 @IPROUTE@ -o -=
6 route show | grep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*s=
ec//&#39; -e &#39;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/=
 (rtt|rttvar) [0-9]+ms//g&#39;</span><br><span>             else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	        echo &quot;-- linux / i=
fconfig --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    =
    LANG=3DC @IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	        LANG=3DC @NETSTAT@ -rn -4=
 -6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
echo &quot;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                LANG=3DC @IFCONFIG@ -a | egrep &quot;( =
addr:|encap:)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             f=
i</span><br><span>             ;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	FreeBSD|NetBSD|Darwin)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	   echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egre=
p &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#3=
9;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OpenBSD)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	   echo &quot;-- OpenBSD --&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(=
flags=3D|inet)&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-		sed -e &#39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#=
39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	SunOS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ech=
o &quot;-- Solaris --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^=
UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AIX)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- AIX=
 --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFI=
G@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2=
,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | Net=
BSD | Darwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep =
&quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,=
$NF }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OpenBS=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo =
&quot;-- OpenBSD --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                sed -e &#=
39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$=
3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            ;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        SunOS)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            echo &quot;-- Solaris --&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(=
flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        AIX)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- AIX=
 --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !=
~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ;;</span><br><span>         *)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           echo &quot;get_ifconfig_rou=
te(): no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt=
;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           exi=
t 20</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           ;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;=
get_ifconfig_route(): no idea how to get info on your OS ($(uname -s))=2E  =
FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            exit 20</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ;;</span><br><span>     esac</span><br><span> </span><br><=
span>     # another round of per-platform information gathering, for DNS in=
fo</span><br><span>     # for most of the platforms &quot;cat /etc/resolv=
=2Econf&quot; is good enough</span><br><span>     # except Linux and MacOS<=
/span><br><span>     case $UNAME in</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	Linux)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ -x /usr/=
bin/resolvectl -a -d /run/systemd/system ]; then</span><br><span>          =
       echo &quot;-- linux resolvectl --&quot;</span><br><span>            =
     resolvectl status</span><br><span>             else</span><br><span>@@=
 -222,7 +252,7 @@</span><br><span>                 cat /etc/resolv=2Econf</=
span><br><span>             fi</span><br><span>             ;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	Darwin)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        Darwin)</span><br><span>             =
echo &quot;-- MacOS scutil --dns&quot;</span><br><span>             scutil =
--dns</span><br><span>             ;;</span><br><span>@@ -260,19 +290,19 @@=
</span><br><span> #  arg2: IPv4/IPv6 address that must show up in out of &q=
uot;get_ifconfig_route&quot;</span><br><span> check_ifconfig()</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    proto=3D$1 =
; shift</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=3D=
$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    shift</span><=
br><span>     expect_list=3D&quot;$@&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$expect_list&quot;=
 ] ; then return ; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ] ; then return ; fi</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$exp=
ect_list&quot; ]; then return; fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ]; then r=
eturn; fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for expect in $expect_list</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	if get_ifconfig_route | fgrep &quot;$expect&quot; &gt;/dev/null</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	then :</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	    fail &quot;check_ifconfig(): expected IPv$proto address &=
#39;$expect&#39; not found in ifconfig output=2E&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for expect in $expect_list; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if get_ifconfig_route | fgrep &qu=
ot;$expect&quot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            :</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fail &quot;check_ifconfig(): expected IPv$proto address &#3=
9;$expect&#39; not found in ifconfig output=2E&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span>     done</spa=
n><br><span> }</span><br><span> </span><br><span>@@ -283,47 +313,48 @@</spa=
n><br><span> #  arg3=2E=2E=2E -&gt; fping arguments (host list)</span><br><=
span> run_ping_tests()</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    proto=3D$1 ; want=3D$2 ; shift ; shift</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    want=3D$2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    shift</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    shift</span><br><span>     targetlist=3D&quot;$=
@&quot;</span><br><span> </span><br><span>     # &quot;no targets&quot; is =
fine</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot=
;$targetlist&quot; ] ; then return ; fi</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if [ -z &quot;$targetlist&quot; ]; then return; fi<=
/span><br><span> </span><br><span>     case $proto in</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) echo &quot;interna=
l error in run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   exit 1 ;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        4) cmd=3D&quot;$FPING&quot; =
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        6) cmd=3D=
&quot;$FPING6&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      echo &quot;internal error in run_ping_tests arg 1: &#39;$proto&#39;&q=
uot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ;;</span><br><span>     esac</span><br><span> </span><br><span>     =
case $want in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	want_ok=
)   sizes_list=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	want_fail) sizes_list=3D&quot;64&quot; ;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        want_ok) sizes_list=
=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><spa=
n>     esac</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for bytes in $sizes_list</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	output &quot;run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for by=
tes in $sizes_list; do</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        output &quot;run IPv$proto ping tests ($want), $bytes byte packe=
ts=2E=2E=2E&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targe=
tlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetl=
ist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        echo &quot;$cmd -b $bytes -C 20 -p 250=
 -q $fping_args $targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        $cmd -b $bytes -C 20=
 -p 250 -q $fping_args $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&a=
mp;1</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	# while OpenVPN is running, pings must succeed (want=3D&#39;want_ok&#39;)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# before OpenVPN is =
up, pings must NOT succeed (want=3D&#39;want_fail&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        # while OpenVPN is running, pin=
gs must succeed (want=3D&#39;want_ok&#39;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # before OpenVPN is up, pings must NOT succe=
ed (want=3D&#39;want_fail&#39;)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	rc=3D$?</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	if [ $rc =3D 0 ] 				# all ping OK</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	    if [ $want =3D &quot;want_fail&quot; ]		# not what we wan=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test=
 succeeded, but needs to *fail*=2E&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	else					# ping failed</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	    if [ $want =3D &quot;want_ok&quot; ]		# not what we wanted</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test ($byt=
es bytes) failed, but should succeed=2E&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  rc=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 [ $rc =3D 0 ]; then                 # all ping OK</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if [ $want =3D &quot;want_fail&q=
uot; ]; then # not what we want</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                fail &quot;IPv$proto ping test succeeded, but n=
eeds to *fail*=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else                               # ping failed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if [ $want =3D &quot;want_o=
k&quot; ]; then # not what we wanted</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                fail &quot;IPv$proto ping test ($bytes byt=
es) failed, but should succeed=2E&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            fi</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        fi</span><br><span>     done</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -334,8 +365,7 @@</span><br><span> SUMMARY_=
SKIP=3D</span><br><span> SUMMARY_FAIL=3D</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     =
# get config variables</span><br><span>     eval test_prep=3D\&quot;\$PREPA=
RE_$SUF\&quot;</span><br><span>     eval test_check_skip=3D\&quot;\$CHECK_S=
KIP_$SUF\&quot;</span><br><span>@@ -347,26 +377,32 @@</span><br><span>     =
eval expect_ifconfig6=3D\&quot;\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><sp=
an>     eval ping4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\&quot;</span><br><span=
>     eval ping6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    eval expect_fail=3D\&quot;\$EXPEC=
T_FAIL_$SUF\&quot;</span><br><span>     eval fping_args=3D\&quot;\$FPING_EX=
TRA_ARGS \$FPING_ARGS_$SUF\&quot;</span><br><span> </span><br><span>     # =
If EXCEPT_IFCONFIG* variables for this test are missing, run an --up</span>=
<br><span>     # script to generate them dynamically=2E</span><br><span>   =
  if [ -z &quot;$expect_ifconfig4&quot; ] || [ -z &quot;$expect_ifconfig6&q=
uot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
p=3D&quot;--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --scr=
ipt-security 2 --up ${srcdir}/update_t_client_ips=2Esh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        up=3D&quot;--setenv TESTNU=
M $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_c=
lient_ips}&quot;</span><br><span>     else</span><br><span>         up=3D&q=
uot;&quot;</span><br><span>     fi</span><br><span> </span><br><span>     o=
utput_start &quot;### test run $SUF: &#39;$test_run_title&#39; ###&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$exp=
ect_fail&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        output &quot;### expect failure: &#39;$expect_fail&#39;&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span=
>     fail_count=3D0</span><br><span> </span><br><span>     if [ -n &quot;$=
test_check_skip&quot; ]; then</span><br><span>         output &quot;check w=
hether we need to skip: &#39;$test_check_skip&#39;&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if eval $test_check_skip; then :=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if eval $te=
st_check_skip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            :</span><br><span>         else</span><br><span>             ou=
tput &quot;skip check failed, SKIP test $SUF=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SU=
F&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    printf &q=
uot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            printf &quot;$ou=
tbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   continue</span><br><span>         fi</span><br><span>     fi</span><br><=
span> </span><br><span>@@ -385,13 +421,14 @@</span><br><span>     output &q=
uot;\nrun pre-openvpn ping tests - targets must not be reachable=2E=2E=2E&q=
uot;</span><br><span>     run_ping_tests 4 want_fail &quot;$ping4_hosts&quo=
t;</span><br><span>     run_ping_tests 6 want_fail &quot;$ping6_hosts&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$fail_=
count&quot; =3D 0 ] ; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if [ &quot;$fail_count&quot; =3D 0 ]; then</span><br><span>     =
    output &quot;OK=2E\n&quot;</span><br><span>     else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	fail &quot;make sure that ping hosts ar=
e ONLY reachable via VPN, SKIP test $SUF=2E&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D31</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	printf &quot;$outbuf&quot; =
; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
ail &quot;make sure that ping hosts are ONLY reachable via VPN, SKIP test $=
SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        exit_code=3D31</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        continue</span><br><sp=
an>     fi</span><br><span> </span><br><span>     pidfile=3D&quot;$LOGDIR_A=
BS/openvpn-$SUF=2Epid&quot;</span><br><span>@@ -406,38 +443,77 @@</span><br=
><span>     # to $ovpn_init_check times=2E</span><br><span>     ovpn_init_c=
heck=3D30</span><br><span>     ovpn_init_success=3D0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while [ $ovpn_init_check -gt 0 ];</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-       sleep 1  # Wait for OpenVPN to init=
ialize and have had time to write the pid file</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-       grep &quot;Initialization Sequence Complete=
d&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-       if [ $? -eq 0 ]; then</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_check=3D0</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_success=3D1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       fi</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-       ovpn_init_check=3D$(( $ovp=
n_init_check - 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    while [ $ovpn_init_check -gt 0 ]; do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sleep 1 # Wait for OpenVPN to initialize and t=
o write the pid file</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            grep &quot;$expect_fail&quot; $LO=
GDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_check=3D0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init=
_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         sleep 5 # give openvpn time to quit</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            grep &quot;Initialization Sequence Completed&quot;=
 $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_check=3D0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                ovpn_in=
it_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ovpn_init_c=
heck=3D$((ovpn_init_check - 1))</span><br><span>     done</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opid=3D`cat $pidf=
ile`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D$([ =
-e $pidfile ] &amp;&amp; cat $pidfile)</span><br><span>     if [ -n &quot;$=
opid&quot; ]; then</span><br><span>         output &quot;  OpenVPN running =
with PID $opid&quot;</span><br><span>     else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        output &quot;  Could not read OpenVPN PID =
file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f [ -z &quot;$expect_fail&quot; ]; then # print this only if unexpected</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &quo=
t;  Could not read OpenVPN PID file&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        fi</span><br><span>     fi</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # If OpenVPN did n=
ot start</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # did w=
e expect a failure?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if [ -n &quot;$opid&quot; ]; then # OpenVP=
N did start!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     output &quot;$0: OpenVPN did start up, expected failure&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_=
EXEC $opid $sudopid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            output &quot;$(tail -5 $L=
OGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            fail &quot;skip rest of sub-tests for test run $SUF=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            exit_code=3D32</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            printf &quot;$outb=
uf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
if [ $ovpn_init_success -eq 0 ]; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            output &quot;$0: OpenVPN failure did not matc=
h expected failure&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            output &quot;$(tail =
-5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit_cod=
e=3D33</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p=
rintf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            continue</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            output &quot;test run $SUF: all tests OK (saw expected failure)=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # If OpenVPN=
 did not start but should have</span><br><span>     if [ $ovpn_init_success=
 -ne 1 -o -z &quot;$opid&quot; ]; then</span><br><span>         output &quo=
t;$0:  OpenVPN did not initialize in a reasonable time&quot;</span><br><spa=
n>         if [ -n &quot;$opid&quot; ]; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           $RUN_SUDO $KILL_EXEC $opid</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $=
opid</span><br><span>         fi</span><br><span>         $RUN_SUDO $KILL_E=
XEC $sudopid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &=
quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	output &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;skip rest of=
 sub-tests for test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	printf &quot;$outbuf&quot; ; continue</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;tai=
l -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        output &quot;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;s=
kip rest of sub-tests for test run $SUF=2E&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        trap - 0 1 2 3 15</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FA=
IL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  exit_code=3D30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     printf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        continue</span><br><span>     fi</span><br><span> </spa=
n><br><span>     # make sure openvpn client is terminated in case shell exi=
ts</span><br><span>@@ -452,17 +528,16 @@</span><br><span>         exit 1</s=
pan><br><span>     fi</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; =
] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &q=
uot;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br><span>     =
    output &quot;skip ifconfig+route check&quot;</span><br><span>     else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output -n &quot;compa=
re pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	if diff $LOGDIR/$SUF:ifconfig_r=
oute_pre=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		$LO=
GDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	    fail &quot;no differences between ifconfig/route before OpenVPN=
 start and now=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    output &q=
uot; OK!\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        output -n &qu=
ot;compare pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if diff $LOGDI=
R/$SUF:ifconfig_route_pre=2Etxt \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            $LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fai=
l &quot;no differences between ifconfig/route before OpenVPN start and now=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outpu=
t &quot; OK!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fi</span><br><span>     fi</span><br><span> </span><br><span>     =
# post init script needed?</span><br><span>@@ -483,8 +558,8 @@</span><br><s=
pan>     $RUN_SUDO $KILL_EXEC $opid</span><br><span>     wait $!</span><br>=
<span>     rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if [ $rc !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	fail &quot;OpenVPN return code $rc, expect 0&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if [ $rc !=3D 0 ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;OpenVPN retu=
rn code $rc, expect 0&quot;</span><br><span>     fi</span><br><span> </span=
><br><span>     output &quot;\nsave post-openvpn ifconfig + route=2E=2E=2E&=
quot;</span><br><span>@@ -496,23 +571,22 @@</span><br><span> </span><br><sp=
an>     output -n &quot;compare pre- and post-openvpn ifconfig + route=2E=
=2E=2E&quot;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=
=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    $LOGDIR/=
$SUF:ifconfig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	output &quot; OK=2E\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        $LOGDIR/$SUF:ifconf=
ig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot; OK=
=2E\n&quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	output &quot;\n\n&quot; &quot;`cat $LOGDIR/$SUF:ifconfig_r=
oute_diff=2Etxt`&quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	fail &quot;differences between pre- and post-ifconfig/rout=
e=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
utput &quot;\n\n&quot; &quot;$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)&=
quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fail &quot;differences between pre- and post-ifconfig/route=2E&quo=
t;</span><br><span>     fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ];=
 then</span><br><span>         output &quot;test run $SUF: all tests OK=2E\=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_OK=3D=
&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>=
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if [ &quot;=
$V&quot; -gt 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	    printf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	    echo &quot;test run $SUF: $fail_count test failures=2E FAI=
L=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f [ &quot;$V&quot; -gt 0 ]; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            printf &quot;$outbuf&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;test run $SUF: $fa=
il_count test failures=2E FAIL=2E&quot;</span><br><span>         fi</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMAR=
Y_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exi=
t_code=3D30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        exit_code=3D30</span><br><span>     fi</s=
pan><br><span> </span><br><span>     if [ -n &quot;$test_cleanup&quot; ]; t=
hen</span><br><span>@@ -522,9 +596,9 @@</span><br><span> </span><br><span> =
done</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-if [ -z &quot;$SUMMARY_OK&quot; ] ; then SUMMARY_OK=3D&quot; none&quot;; f=
i</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMA=
RY_SKIP&quot; ] ; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_FAIL&quot; ] ;=
 then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_OK&quot; ]; then SUMMARY_OK=
=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+if [ -z &quot;$SUMMARY_SKIP&quot; ]; then SUMMARY_SKIP=3D&quot; none&q=
uot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &qu=
ot;$SUMMARY_FAIL&quot; ]; then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><=
br><span> echo &quot;Test sets succeeded:$SUMMARY_OK=2E&quot;</span><br><sp=
an> echo &quot;Test sets skipped:$SUMMARY_SKIP=2E&quot;</span><br><span> ec=
ho &quot;Test sets failed:$SUMMARY_FAIL=2E&quot;</span><br><span>diff --git=
 a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh</span><b=
r><span>index 96e3826=2E=2Ef02dc7f 100755</span><br><span>--- a/tests/updat=
e_t_client_ips=2Esh</span><br><span>+++ b/tests/update_t_client_ips=2Esh</s=
pan><br><span>@@ -3,14 +3,12 @@</span><br><span> # This --up script caches =
the IPs handed out by the test VPN server to a file</span><br><span> # for =
later use=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-RC=3D&quot;$TOP_BUILDDIR/t_client_ips=2Erc&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&a=
mp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFC=
ONFIG4_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -=
ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo =
&quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $RC</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCO=
NFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span> fi</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep EXP=
ECT_IFCONFIG6_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC =
&gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG6_=
$TESTNUM=3D$ifconfig_ipv6_local&quot; &gt;&gt; $RC</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$=
ifconfig_ipv6_local&quot; &gt;&gt;$RC</span><br><span> fi</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141=
?usp=3Demail">change 2141</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2141?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2141 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--Zx9qpF3O2Zc=--


--===============8533588970316881559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8533588970316881559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8533588970316881559==--

