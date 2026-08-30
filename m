Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2674C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PFPLZk+ElDHHmlkQ8SOILJiHFtNPjeGnaMiCW80UUX4=; b=P3VA9sPncdr3X+P6ljJ0rPBAjV
	tjWUKzCOKw3g3gz6F8yfMGsgVqFBOmLk0TEv63I4DzBtz3iDCyqGqDjEq5yUUtOhzJtSVsaJpxhmC
	65/YmX7BZLxt/VQt6NAFluuYC/SBYsd8nN6uQC3q8qITB9+ak87JdbQpaduxqaY9hsZU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jAx-0004UG-Ex;
	Sun, 30 Aug 2026 17:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jAO-0004Tc-6j
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=n3cmsr1XJaQLNU2sAVIottvVkvqwwauSNlDb4SjPc6o=; b=AzVHqqyEx40okHHQTq9aLceysY
 hleYp8HN3bHFmg1NMdUbtoaPxACtR9QkUs4jW+WCUIToQNzZAfK5VEIJJFOJ9Wl9T7TzPABn/xYVh
 F+pTbqZIl0LW0pdkwEixl8RCeR+0nEIQ+U9gKqkqGW40bEBJr5dr+QWhAJ/xJ4rqQbOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n3cmsr1XJaQLNU2sAVIottvVkvqwwauSNlDb4SjPc6o=; b=j
 yUJrgyu7GOFykkHLmJ/TmEKGKTgyhRPvCvjh3uTkIBwRbcYnvasBSfjMVbiJFNHrXzShfxh+vznRh
 eLYDmSIaAQ63vMNIdOt6LQcy5CXbzzkfJ2IH2OZfiiMlZC+fRpM8krt8jJMbj6KeU4+h/NHqLDvJW
 P9qGW0PxCXNzckB0=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jAN-0001Nn-Fq for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:18:00 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so1899981f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788110273; x=1788715073; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n3cmsr1XJaQLNU2sAVIottvVkvqwwauSNlDb4SjPc6o=;
 b=Ab2Tlt7N37Xv0PikDNDCvKu6B3HTFSgYzs87mkSrZAK1wh8+KfaK3S9SOfmUZHXBXV
 OQzBrpxKBwCAQ+YPRoEZ5YKzlH6Nk4jmEhTGu7bRAx80ZvWwyxUjkuw7ZQUYlzIS/NWO
 n2EbmzsOOMlcGIzprloWK44v183lqTE3VP4OozNPFVPmi3ZwOgPuf1ezNtKD22eu/7YW
 tDcidiLXzvBuibsApeIcjtImVEhH4lfuSY/bcaF+iJ2kOOG5M5MCPqXg/uhgeYK2NlOO
 0+T9ooYkKT1xiJLRXa++67M+zUGGLtGuPKDSB7OV3Mla9MJU0E911RuhKHRGeeaVWW6n
 +T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788110273; x=1788715073;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n3cmsr1XJaQLNU2sAVIottvVkvqwwauSNlDb4SjPc6o=;
 b=VNsQE09Ay00/O9nZc5c5Wj0fXmZrwT5SR3Nw0fxbgfizQD+mUTexl/ujyuT+yhrHvc
 lexFHIE2M2/DGRAJIa9XuQjl/dzXQZZwk/a6SD4Vt4Vxq081LxcLMhtSWZoEAXD0sDdD
 xy0xkU1fGXPH0TnB/L5f+dUI7/KG3zePXJOYCUEacFElyMMxNapy9I2CGmvxKejgYf8O
 4GWx4pDrKKtkHkX6HpWpoGEoV6KSZbWjb4yuHtS8ecPNuIaZWMZrNFJW2L55sFR6tCVC
 fAArX3ZWP75JM1AzmLPXcaIcEsErQYkl+v8panSd0eN5QxQJKSgBnKAl4cwQqCuGfJs0
 yOQw==
X-Gm-Message-State: AFuF++k130w8GAmNWVOjfqJcQj8pXg7lfh7efmUtKE1u+Vj1yaKC+oPb
 K4y6lAi2TaYKPsEpBeBK7u5d3/y7VT7UnGN+5qWQP6ClwqTzxiP92F71wtlqQzLz5Y74hzIqJli
 DyXu692ySe7rs7og26R4wPSKLOQseBlXaVObrV84Gu38HaP8cFF4hnEcNIDu2VmZNUHCZTsI/Xi
 TcitThxQ==
X-Gm-Gg: AR+sD10b2N69Uije/Vrx4gVwLjpxHmvyzczxcWEzVv5UdqS/t9ieoadnQWGHcNDcDqJ
 wm8aswv112rzzVg4MbjpTi/l3SpjuOBJEIP3sxFf6t6dcwhV0dBGfBUOJWikagIuKo07PHGZQpn
 mFQoBU/Sg+B54zJMBtvE4PQdZ9V/7eTcbQmZNWu9awlYmM/b80Pv0lfy9O6to97zh+MaLK/zdo5
 8RQ1WOVbAG6lu3KFgC5sZAxthaVdlzzGWOADsfalQWXLMK06/NgSSnzFku+kkDaRSpKeBBi1an7
 9Dh678avJM2zotmiJ8B1hPZR/I77DEYpXtFZLIC1e9W3x1M+aATBJ4aWo/QyOg6e+NdE4w0WyDT
 4GnOtldS9OrRTi53TXjC3VAy6MBZSAHtOZ8GUZhx0cOzVfnBvCYHYcBkSPeqSlvS6cy2M9knCZD
 tpS8f4ryAau/HgGSPOyDED9gkZNAYxjtgauO4v7bx1wEbQvW2SLnHhK9vmNI+3vJ64R+44/UOcJ
 T59R0nO18qLoAD5s7OXzQXbhqDfbjvvXDI1qdVyEkilghiJabut4Nkyjs0YICb7RTcxYbS4HsuA
 BMW9be96aGc7MWzT8XYh7Zx6TgvttROImUVcLzTqAwl3S7fipD8=
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr335933015e9.6.1788110272741; 
 Sun, 30 Aug 2026 10:17:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cca1ed292sm161926525e9.8.2026.08.30.10.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:17:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:17:51 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 8b392d642eb4c9b9135dc6a442d943159467e058
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <600c7a792bdf46d23e3ffc720fd5e961a11a91c3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jAN-0001Nn-Fq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8842092231575715012=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8842092231575715012==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H2gPUtEWtDo="; charset=UTF-8

--H2gPUtEWtDo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: t_client=2Esh=2Ein: Add utility function needs=
_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
_client=2Esh=2Ein: Add utility function needs_openvpn()

This allows to ski=
p tests on old versions of openvpn=2E
Makes it much easier to maintain a t_=
client=2Erc across
multiple versions=2E

Change-Id: I1905d9494336da4e91f194=
6d2ffd875720605b41
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1763
Message-Id: <20260828095300=2E9652-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38760=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
1 file changed, 22 in=
sertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/63/1763/6

diff --git a/tests/t_client=2Esh=2Ein b/te=
sts/t_client=2Esh=2Ein
index 7c23020=2E=2Ec3a9655 100755
--- a/tests/t_clie=
nt=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -22,14 +22,16 @@
 t_client_i=
ps_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
 update_t_c=
lient_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
 
=
-if [ -r "${top_builddir}"/t_client=2Erc ]; then
-    =2E "${top_builddir}"=
/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ]; then
-    =2E "${src=
dir}"/t_client=2Erc
-else
-    echo "$0: cannot find 't_client=2Erc' in bui=
ld dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcd=
ir}')=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -z "${t=
_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client=2Erc ]; then
+=
        t_client_rc=3D"${top_builddir}"/t_client=2Erc
+    elif [ -r "${src=
dir}"/t_client=2Erc ]; then
+        t_client_rc=3D"${srcdir}"/t_client=2Er=
c
+    else
+        echo "$0: cannot find 't_client=2Erc' in build dir ('$=
{top_builddir}')" >&2
+        echo "$0: or source directory ('${srcdir}')=
=2E SKIPPING TEST=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
 fi
 
=
 # Check for external dependencies
@@ -63,6 +65,18 @@
     exit 1
 fi
 
+op=
envpn_version=3D$(${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E=
 's/^2\=2E([0123456789]+)=2E*$/2\1/')
+
+needs_openvpn()
+{
+    needs_vers=
ion=3D$1
+
+    [ "$openvpn_version" -ge "$needs_version" ]
+    return $?
=
+}
+
+=2E "${t_client_rc}"
+
 if [ -z "$TEST_RUN_LIST" ]; then
     echo "T=
EST_RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCL=
IENT_SKIP_RC}"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1763?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1=
905d9494336da4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763
Gerrit-P=
atchSet: 6
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--H2gPUtEWtDo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add =
utility function needs_openvpn()<br><br>This allows to skip tests on old ve=
rsions of openvpn=2E<br>Makes it much easier to maintain a t_client=2Erc ac=
ross<br>multiple versions=2E<br><br>Change-Id: I1905d9494336da4e91f1946d2ff=
d875720605b41<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763<br>Message-Id: &lt;20=
260828095300=2E9652-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38760=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tes=
ts/t_client=2Esh=2Ein<br>1 file changed, 22 insertions(+), 8 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/63/1763/6</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein</span><br><span>index 7c23020=2E=2Ec3a9655 100755</=
span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t=
_client=2Esh=2Ein</span><br><span>@@ -22,14 +22,16 @@</span><br><span> t_cl=
ient_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&q=
uot;</span><br><span> update_t_client_ips=3D&quot;${update_t_client_ips:-${=
srcdir}/update_t_client_ips=2Esh}&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_c=
lient=2Erc ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${sr=
cdir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quo=
t;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir=
}&#39;)&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    echo &quot;$0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING=
 TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+if [ -z &quot;${t_client_rc}&quot; ]; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -r &quot;${top_buil=
ddir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        t_client_rc=3D&quot;${top_builddir}&quot;/t_client=2E=
rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elif [ -r &qu=
ot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        t_client_rc=3D&quot;${srcdir}&quot;/t_client=
=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$0: ca=
nnot find &#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&=
quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     echo &quot;$0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING T=
EST=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    fi</span><br><span> fi</span><br><span> </s=
pan><br><span> # Check for external dependencies</span><br><span>@@ -63,6 +=
65,18 @@</span><br><span>     exit 1</span><br><span> fi</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_version=3D$(=
${openvpn} --version | head -n 1 | cut -f2 -d&quot; &quot; | sed -E &#39;s/=
^2\=2E([0123456789]+)=2E*$/2\1/&#39;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
eeds_openvpn()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    needs_version=3D$1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    [ &quot;$openvpn_version&quot; -ge =
&quot;$needs_version&quot; ]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return $?</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+=2E &quot;${t_client_rc}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if [ =
-z &quot;$TEST_RUN_LIST&quot; ]; then</span><br><span>     echo &quot;TEST_=
RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><b=
r><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1763?usp=3Demail">change 1763</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1763 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--H2gPUtEWtDo=--


--===============8842092231575715012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8842092231575715012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8842092231575715012==--

