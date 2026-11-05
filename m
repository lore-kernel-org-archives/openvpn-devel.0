Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0598606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BjbCnqlz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hn99alpU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BrK4L6te;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PTrd60J2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rIMGEG3Uf1/hru9OpVMLRw2w+gC011SnUGyzuIxMssY=; b=BjbCnqlzHr0Gzj5B+KAVm8tmda
	OOe2xw8HRANGyCpakh7FH3IH6Uk8OXdsk08pmWXQpd4ApXpDbjoY2P2ZX5ZXQrys4lGaNK+uyZIZ8
	LSvWHIXP3HN21WLMeVrlp2uh0xgzYBFE9NM6E4/gRCyub+omSmNT8sgh98hJonJcdYro=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOuGF-000000002MU-0aQ7;
	Thu, 05 Nov 2026 09:59:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOuGE-000000002MM-0dna
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0qngvRgHpzsZ4AFZ/epyWbmQkjVvhkBJgEaQD0NBz/Y=; b=Hn99alpUs/7uQ8YeVTwqvJaF/L
 ++XRdii1A/qYNndJpZcCOW+rNohcbIWW3ApW4TW5yNJ09F8JAVLeycs0cKs5BPt4zesjrz5UQdy4G
 dt3DPikOKLM0h7KoareYsNpK7i/kzUEBh7Qg8mdhjd6pjO89r9Tle6NHxDYFUPpah5Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0qngvRgHpzsZ4AFZ/epyWbmQkjVvhkBJgEaQD0NBz/Y=; b=BrK4L6tee8RxakxX6mucQ/60fl
 qGb6eMS0Uz7tlPhyhjT5iD4W0zUkLqsE97Rp7eXFvrLEfRc2RYITeQhSWrZu5Xp894lWsb2sd4hJb
 45TSY5YQkpvSZ/NGiwynDKDVmQ0LND/CubLiXhlYdtCLGqf906T0zQyygOn/uuawkDlk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOuGA-000000004Nm-1alF for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:59:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so4900645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793872788; x=1794477588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0qngvRgHpzsZ4AFZ/epyWbmQkjVvhkBJgEaQD0NBz/Y=;
 b=PTrd60J2diUVD4O//mTdFUmPtz7lmIKNU97WEYfVdoYn4yZVwjEJaEHc7YNht4NZFP
 8H2OnTe8cyp5fQ9GkqYhhDBEX37rWFtOYsFrvYaU4ZV5P+2DvsJKQQbKmQspL5KfwA1n
 fuwe3ZJ2WRo+DXkfzrO6Tacy09ah4N8luranoj/vAp/H8wZ4bQyzG3ffGi0y8wPEfi00
 +2AQFFAqcgsNZ6oVII47Ae/kfjXsxWawukONF1nXCSd6fk+nDXYmQ2SBz5OHvtF0dDus
 3ZRHX3oDOG0ARPRCyocz00WLN3/JDP8QoePonGVxAoP0Qk3dgNzmJ+FZL/Gk9LRt7tfA
 EwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872788; x=1794477588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0qngvRgHpzsZ4AFZ/epyWbmQkjVvhkBJgEaQD0NBz/Y=;
 b=Bv6+QACZ5WqxtmPpXCwXPmmYh3B22I72BNo89HlzR/fJg+7ZbzOokkUPm7hiTgyRku
 Ip6Td+N5xQiIYcexd5cOr9dJl9NcuynJ0lj+9/Lx4rb3C5LNnermIM0Zv1sRHz/UxH/4
 4bdwucUh+GWTRAwASad+m3YpfyNnUFg7wjAJRsw4pgOYs44KlZvWHZE+5IyN0Y1iRQo8
 GPjoCwVE86Aq9k0zPuo3ZWeFs53RUhfDvmxDwLVe46rcLO0L2WiDkNVjimRV5cNnyqVh
 MmwvDM8eaZRNMkmZAOb+f81A7ZG0XIwpauwRuLC78HvmiQ1JK68x4Yq+z+HwNr6v4e26
 3+CQ==
X-Gm-Message-State: APuU4Z8xNsDsS6s1n+Nc77Ia6BnwuLyzO64GEHQ6JJmDVm006L4HntpH
 ZdjH5o/EkJ10h+vkALYuNoZ2eijN00fU1fvZn+xNoeq9DnIzgHa1ElbDhXmLYeGdDFGcMco/XnU
 yHpVmguVJ4sexW97CuJftNPILrpt3nYH+b4zuX95f9zqqO8AlzVq25aUPVh5aE5T2gWNXOzcsB7
 kDfqW6/w==
X-Gm-Gg: AYBFou1hgfMctrxkkkOzY6DOE87aEvHVbI7hiX/AAn4f3sL3mqUDxFAwlnrxrEKjgYj
 lIww14BIfFqnWUfAswsN877cRVW0S5zVNfs2U8Ej5vOLbFWdnidYgAgB9CazuQLJknrOZPC+gny
 7XWdjhnqum8i7kBcnqP4nyy+egIJsTWS0rFcoeKfMiVM+V6gv7rnTOTfum1Y2v0ja9XTJswhuPb
 wOW1oN8AhiDtW0H6eIfrpgrr9UuPqd+BGB5S1EweHEBaBpytUtkzwY0vLJRlw4WM+YxAeuT9dzd
 0gydswqYUOtTifkXvG1nmjn45vrwGY9qC8KtH7pUTuCQnBnNPVnc/39Vr21kVS6x93euVhQZaI1
 kEzNWb8/S/liTWPfkHfXYfa3M55hq9GBcQeOqux+uGPTq8fY/pTwQLLXdSBuVRVXHsZyRsqNkkn
 OM1r5Knf075KHPQszfJWuyr+JA5uMJ7eoc95DrXTdnM6vDpYQS9GRzLRas7NIx8/q751RvIjF6P
 1lhGXmweJj0bQLm7X9cO3+4A5RaK4LDAZAkgRA+cYtwHfjeBzcO250pbx2ZO4Gr7gEauIPb1j6z
 w/nrjtvAAiPSTM0zDe00AqOFlAoDz9hrnp0PDLwkRdeREL6yQ/D+C2RB8aOhru9f+qB82xmRHBY
 aHBfD125oTWOItTvA+JOOEtIqxY360JwgGIq3fZ4nwrr51S694UuqEW59lXBcBfqls9/rD/wxml
 TOC83J0EMY7d8ImQ6VT585w278b4aduwqKbjQ=
X-Received: by 2002:a05:600c:46cf:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b55e07e569mr37718765e9.15.1793872787333; 
 Thu, 05 Nov 2026 01:59:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm130667205e9.5.2026.11.05.01.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:59:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 09:59:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
X-Gerrit-Change-Number: 2141
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2141?usp=email>
X-Gerrit-Commit: 58bbdfa2db1fda07c3f99eaeeaac00920b3b1626
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODcyNzg0MDAwLkkxM2Y5ZjdkZDYxZDdhNGNjOTg2MTU1NjI5ZjZhM2M3OTJhYWFjNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45aaeb13b201d8cc5eb9cfe11f6e8d39d221ae2c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOuGA-000000004Nm-1alF
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4021175051207400669=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4021175051207400669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZPt3qOLG9vc="; charset=UTF-8

--ZPt3qOLG9vc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2141?usp=3Demail

to review the following change=2E
=


Change subject: backport t_client=2Esh changes from master
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

backport t_client=2Esh ch=
anges from master

This is basically just copying in the current t_client=
=2Esh=2Ein script from
master, with a number of changes that are not in 2=
=2E7 yet - most notably
support for "expect failure" cases=2E

Given that t=
his is a test support script with no dependencies into the
OpenVPN core, an=
d the large number of non-backported scripts that touch
one line or the oth=
er, or re-indent things, copying the whole script
instead of trying to cher=
ry-pick all the individual change seemed like
a much better idea=2E=2E=2E

=
Here's the list:

commit e2548f6e3b7f9ed3d24020319117b17f30743656
    t_cli=
ent=2Esh=2Ein: Check whether addresses are in "tentative" state

commit af6=
a79c6a83739ca9542e52a02a3449a2f292758
    t_client=2Esh=2Ein: Add ability t=
o filter by test group

commit dc162485236b70ecfe1be639dbd9db8244a85d54
   =
 t_client=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc

c=
ommit 8b392d642eb4c9b9135dc6a442d943159467e058
    t_client=2Esh=2Ein: Add =
utility function needs_openvpn()

commit dc162485236b70ecfe1be639dbd9db8244=
a85d54
    t_client=2Esh=2Ein: Allow to override the location of t_client_i=
ps=2Erc

commit 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60
    t_client=2Esh=
=2Ein: Add support for expected test failures

commit ed427eab1683af3adf215=
53dd1c6b6e4b8b2f10d
    reformat-shell=2Esh: Add --simplify argument

commi=
t f781227c92a3d1017e9d8a67e83e4465b43edf66
    Reformat all shell-scripts w=
ith shfmt

commit b32d1ab45ec93786191e0dac2c8f5549d6c04258
    t_client=2Es=
h=2Ein: Do not try to guess the absolute path to LOGDIR

commit da1b2a7081e=
b2791f3a675945c42d7f3189ef752
    t_client=2Esh=2Ein: Use printf instead of=
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
---
M te=
sts/t_client=2Esh=2Ein
1 file changed, 253 insertions(+), 179 deletions(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/21=
41/1

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
inde=
x 876e84a=2E=2E5e924bb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_=
client=2Esh=2Ein
@@ -19,57 +19,82 @@
 srcdir=3D"${srcdir:-=2E}"
 top_buildd=
ir=3D"${top_builddir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/o=
penvpn/openvpn}"
-if [ -r "${top_builddir}"/t_client=2Erc ] ; then
-    =2E=
 "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ] ; t=
hen
-    =2E "${srcdir}"/t_client=2Erc
-else
-    echo "$0: cannot find 't_=
client=2Erc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source=
 directory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_SKIP=
_RC}"
+t_client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=
=2Erc}"
+update_t_client_ips=3D"${update_t_client_ips:-${srcdir}/update_t_c=
lient_ips=2Esh}"
+
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_bu=
ilddir}"/t_client=2Erc ]; then
+        t_client_rc=3D"${top_builddir}"/t_c=
lient=2Erc
+    elif [ -r "${srcdir}"/t_client=2Erc ]; then
+        t_clie=
nt_rc=3D"${srcdir}"/t_client=2Erc
+    else
+        echo "$0: cannot find =
't_client=2Erc' in build dir ('${top_builddir}')" >&2
+        echo "$0: or=
 source directory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
+        exit "${T=
CLIENT_SKIP_RC}"
+    fi
 fi
 
 # Check for external dependencies
 FPING=3D=
"fping"
 FPING6=3D"fping6"
-which fping > /dev/null
+which fping >/dev/null=

 if [ $? -ne 0 ]; then
     echo "$0: fping is not available in \$PATH" >&=
2
     exit "${TCLIENT_SKIP_RC}"
 fi
-which fping6 > /dev/null
+which fping=
6 >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping6 is not available =
in \$PATH, assuming fping 4=2E0 or later" >&2
     FPING=3D"fping -4"
     =
FPING6=3D"fping -6"
 fi
 
-KILL_EXEC=3D`which kill`
+KILL_EXEC=3D$(which ki=
ll)
 if [ $? -ne 0 ]; then
     echo "$0: kill not found in \$PATH" >&2
   =
  exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${openvpn}" ]
-then
+if [ ! -=
x "${openvpn}" ]; then
     echo "no (executable) openvpn binary in current=
 build tree=2E FAIL=2E" >&2
     exit 1
 fi
 
-if [ ! -w =2E ]
-then
+if [ =
! -w =2E ]; then
     echo "current directory is not writable (required for=
 logging)=2E FAIL=2E" >&2
     exit 1
 fi
 
-if [ -z "$CA_CERT" ] ; then
- =
   echo "CA_CERT not defined in 't_client=2Erc'=2E SKIP test=2E" >&2
+openv=
pn_version=3D$(${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E 's=
/^2\=2E([0123456789]+)=2E*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=
=3D$1
+
+    [ "$openvpn_version" -ge "$needs_version" ]
+    return $?
+}
=
+
+=2E "${t_client_rc}"
+
+if [ -z "$TEST_RUN_LIST" ]; then
+    echo "TEST=
_RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCLIEN=
T_SKIP_RC}"
 fi
 
-if [ -z "$TEST_RUN_LIST" ] ; then
-    echo "TEST_RUN_LI=
ST empty, no tests defined=2E  SKIP test=2E" >&2
-    exit "${TCLIENT_SKIP_=
RC}"
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=3D
+    for test=
 in $TEST_RUN_LIST; do
+        group=3D$(echo $test | sed -E 's/^([0123456=
789]+)=2E*/\1/')
+        if [ "$group" =3D "$TEST_RUN_GROUP" ]; then
+    =
        FILTERED_LIST=3D"$FILTERED_LIST $test"
+        fi
+    done
+    i=
f [ -z "$FILTERED_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty=
 (group=3D$TEST_RUN_GROUP), no tests defined=2E  SKIP test=2E" >&2
+       =
 exit "${TCLIENT_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=3D$FILTERED_LIST
 fi
=
 
 # Ensure PREFER_KSU is in a known state
@@ -77,16 +102,14 @@
 
 # make s=
ure we have permissions to run ifconfig/route from OpenVPN
 # can't use "id=
 -u" here - doesn't work on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >=
/dev/null
-then :
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+=
    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFE=
R_KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
 =
        klist -l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-       =
 then
+        if [ $? -ne 0 ]; then
             # No kerberos ticket foun=
d, skip ksu and fallback to RUN_SUDO
             PREFER_KSU=3D0
          =
   echo "$0: No Kerberos ticket available=2E  Will not use ksu=2E"
@@ -95,8=
 +118,7 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    =
if [ -z "$RUN_SUDO" ]; then
         echo "$0: this test must run be as roo=
t, or RUN_SUDO=3D=2E=2E=2E " >&2
         echo "      must be set correctly=
 in 't_client=2Erc'=2E SKIP=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -=
104,20 +126,22 @@
         # We have to use sudo=2E Make sure that we (hope=
fully) do not have
         # to ask the users password during the test=2E =
This is done to
         # prevent timing issues, e=2Eg=2E when the waits f=
or openvpn to start
-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: =
$RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
-	else
-	    echo "$0: $RUN_SUD=
O $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_=
SKIP_RC}"
-	fi
+        if $RUN_SUDO $KILL_EXEC -0 $$; then
+            ec=
ho "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
+        else
+        =
    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
=
+            exit "${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3D=
t_client-`hostname`-`date +%Y%m%d-%H%M%S`
+LOGDIR=3Dt_client-$(hostname)-$(=
date +%Y%m%d-%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR=3D"${LO=
GDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
-if mkdir $LOGDIR=

-then :
+if mkdir $LOGDIR; then
+    :
 else
     echo "can't create log d=
irectory '$LOGDIR'=2E FAIL=2E" >&2
     exit 1
@@ -137,21 +161,28 @@
 outpu=
t_start()
 {
     case $V in
-	0) outbuf=3D"" ;;			# no per-test output at =
all
-	1) printf "$@\n"			# compact, details only on failure
-           out=
buf=3D"\n" ;;
-	*) printf "\n$@\n" ;;		# print all, with a bit formatting
+=
        0) outbuf=3D"" ;; # no per-test output at all
+        1)
+        =
    printf "$@\n" # compact, details only on failure
+            outbuf=3D=
"\n"
+            ;;
+        *) printf "\n$@\n" ;; # print all, with a bit=
 formatting
     esac
 }
 
 output()
 {
-    END_NL=3D"\n"; if [ "X$1" =3D =
"X-n" ] ; then END_NL=3D"" ; shift ; fi
+    END_NL=3D"\n"
+    if [ "X$1" =
=3D "X-n" ]; then
+        END_NL=3D""
+        shift
+    fi
     case $V =
in
-	0) ;;				# no per-test output at all
-	1) outbuf=3D"$outbuf$@${END_NL}=
"	# print details only on failure
-           ;;
-	*) printf "$@${END_NL}" =
;;	# print everything
+        0) ;; # no per-test output at all
+        1=
)
+            outbuf=3D"$outbuf$@${END_NL}" # print details only on failur=
e
+            ;;
+        *) printf "$@${END_NL}" ;; # print everything
  =
   esac
 }
 
@@ -159,62 +190,61 @@
 fail()
 {
     output "FAIL: $@\n"
-   =
 fail_count=3D$(( $fail_count + 1 ))
+    fail_count=3D$((fail_count + 1))
=
 }
 
 # print "all interface IP addresses" + "all routes"
 # this is higly =
system dependent=2E=2E=2E
 get_ifconfig_route()
 {
-    UNAME=3D`uname -s`
=
+    UNAME=3D$(uname -s)
     case $UNAME in
-	Linux)
+        Linux)
     =
        # linux / iproute2? (-> if configure got a path)
-            if [ =
-n "@IPROUTE@" ]
-            then
+            if [ -n "@IPROUTE@" ]; then=

                 echo "-- linux iproute2 --"
-                @IPROUTE@ ad=
dr show     | grep -v valid_lft
+                @IPROUTE@ addr show | grep=
 -v valid_lft
                 @IPROUTE@ route show
                 @IPROU=
TE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//=
' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+=
ms//g'
             else
-	        echo "-- linux / ifconfig --"
-	        =
LANG=3DC @IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	        LANG=3DC @NETSTA=
T@ -rn -4 -6
+                echo "-- linux / ifconfig --"
+              =
  LANG=3DC @IFCONFIG@ -a | egrep "( addr:|encap:)"
+                LANG=3D=
C @NETSTAT@ -rn -4 -6
             fi
             ;;
-	FreeBSD|NetBSD|Darw=
in)
-	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | =
egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$=
2,$3,$NF }'
-	   ;;
-	OpenBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a=
 | egrep "(flags=3D|inet)" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [=
0-9]*//'
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	 =
  ;;
-	SunOS)
-	   echo "-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=
=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	=
   ;;
-	AIX)
-	   echo "-- AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|in=
et)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
=
+        FreeBSD | NetBSD | Darwin)
+            echo "-- FreeBSD/NetBSD/Da=
rwin [MacOS X] --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+  =
          @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+      =
      ;;
+        OpenBSD)
+            echo "-- OpenBSD --"
+            @=
IFCONFIG@ -a | egrep "(flags=3D|inet)" |
+                sed -e 's/pltime =
[0-9]*//' -e 's/vltime [0-9]*//'
+            @NETSTAT@ -rn | awk '$3 !~ /^=
UHL/ { print $1,$2,$3,$NF }'
+            ;;
+        SunOS)
+            e=
cho "-- Solaris --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+ =
           @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+      =
      ;;
+        AIX)
+            echo "-- AIX --"
+            @IFCONFIG=
@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UH=
L/ { print $1,$2,$3,$6 }'
+            ;;
         *)
-           echo "get=
_ifconfig_route(): no idea how to get info on your OS (`uname -s`)=2E  FAIL=
=2E" >&2
-           exit 20
-           ;;
+            echo "get_ifconfig=
_route(): no idea how to get info on your OS ($(uname -s))=2E  FAIL=2E" >&2=

+            exit 20
+            ;;
     esac
 
     # another round of p=
er-platform information gathering, for DNS info
     # for most of the plat=
forms "cat /etc/resolv=2Econf" is good enough
     # except Linux and MacOS=

     case $UNAME in
-	Linux)
-            if [ -x /usr/bin/resolvectl -a -=
d /run/systemd/system ] ; then
+        Linux)
+            if [ -x /usr/bi=
n/resolvectl -a -d /run/systemd/system ]; then
                 echo "-- li=
nux resolvectl --"
                 resolvectl status
             else
@@ =
-222,7 +252,7 @@
                 cat /etc/resolv=2Econf
             fi
  =
           ;;
-	Darwin)
+        Darwin)
             echo "-- MacOS scutil=
 --dns"
             scutil --dns
             ;;
@@ -260,19 +290,19 @@
 # =
 arg2: IPv4/IPv6 address that must show up in out of "get_ifconfig_route"
 =
check_ifconfig()
 {
-    proto=3D$1 ; shift
+    proto=3D$1
+    shift
    =
 expect_list=3D"$@"
 
-    if [ -z "$expect_list" ] ; then return ; fi
-   =
 if [ "$expect_list" =3D "-" ] ; then return ; fi
+    if [ -z "$expect_lis=
t" ]; then return; fi
+    if [ "$expect_list" =3D "-" ]; then return; fi
 =

-    for expect in $expect_list
-    do
-	if get_ifconfig_route | fgrep "$=
expect" >/dev/null
-	then :
-	else
-	    fail "check_ifconfig(): expected I=
Pv$proto address '$expect' not found in ifconfig output=2E"
-	fi
+    for e=
xpect in $expect_list; do
+        if get_ifconfig_route | fgrep "$expect" =
>/dev/null; then
+            :
+        else
+            fail "check_ifco=
nfig(): expected IPv$proto address '$expect' not found in ifconfig output=
=2E"
+        fi
     done
 }
 
@@ -283,47 +313,48 @@
 #  arg3=2E=2E=2E -> =
fping arguments (host list)
 run_ping_tests()
 {
-    proto=3D$1 ; want=3D$=
2 ; shift ; shift
+    proto=3D$1
+    want=3D$2
+    shift
+    shift
    =
 targetlist=3D"$@"
 
     # "no targets" is fine
-    if [ -z "$targetlist"=
 ] ; then return ; fi
+    if [ -z "$targetlist" ]; then return; fi
 
     =
case $proto in
-	4) cmd=3D"$FPING" ;;
-	6) cmd=3D"$FPING6" ;;
-	*) echo "in=
ternal error in run_ping_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+       =
 4) cmd=3D"$FPING" ;;
+        6) cmd=3D"$FPING6" ;;
+        *)
+         =
   echo "internal error in run_ping_tests arg 1: '$proto'" >&2
+           =
 exit 1
+            ;;
     esac
 
     case $want in
-	want_ok)   sizes_l=
ist=3D"64 1440 3000" ;;
-	want_fail) sizes_list=3D"64" ;;
+        want_ok)=
 sizes_list=3D"64 1440 3000" ;;
+        want_fail) sizes_list=3D"64" ;;
  =
   esac
 
-    for bytes in $sizes_list
-    do
-	output "run IPv$proto pin=
g tests ($want), $bytes byte packets=2E=2E=2E"
+    for bytes in $sizes_lis=
t; do
+        output "run IPv$proto ping tests ($want), $bytes byte packet=
s=2E=2E=2E"
 
-	echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlis=
t" >>$LOGDIR/$SUF:fping=2Eout
-	$cmd -b $bytes -C 20 -p 250 -q $fping_args =
$targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
+        echo "$cmd -b $bytes -=
C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
+       =
 $cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fpin=
g=2Eout 2>&1
 
-	# while OpenVPN is running, pings must succeed (want=3D'wa=
nt_ok')
-	# before OpenVPN is up, pings must NOT succeed (want=3D'want_fail=
')
+        # while OpenVPN is running, pings must succeed (want=3D'want_ok=
')
+        # before OpenVPN is up, pings must NOT succeed (want=3D'want_fa=
il')
 
-	rc=3D$?
-	if [ $rc =3D 0 ] 				# all ping OK
-	then
-	    if [ $wa=
nt =3D "want_fail" ]		# not what we want
-	    then
-		fail "IPv$proto ping=
 test succeeded, but needs to *fail*=2E"
-	    fi
-	else					# ping failed
=
-	    if [ $want =3D "want_ok" ]		# not what we wanted
-	    then
-		fail "=
IPv$proto ping test ($bytes bytes) failed, but should succeed=2E"
-	    fi
=
-	fi
+        rc=3D$?
+        if [ $rc =3D 0 ]; then                 # all=
 ping OK
+            if [ $want =3D "want_fail" ]; then # not what we want=

+                fail "IPv$proto ping test succeeded, but needs to *fail*=
=2E"
+            fi
+        else                               # ping fai=
led
+            if [ $want =3D "want_ok" ]; then # not what we wanted
+   =
             fail "IPv$proto ping test ($bytes bytes) failed, but should su=
cceed=2E"
+            fi
+        fi
     done
 }
 
@@ -334,8 +365,7 @@
 S=
UMMARY_SKIP=3D
 SUMMARY_FAIL=3D
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF i=
n $TEST_RUN_LIST; do
     # get config variables
     eval test_prep=3D\"\$=
PREPARE_$SUF\"
     eval test_check_skip=3D\"\$CHECK_SKIP_$SUF\"
@@ -347,26=
 +377,32 @@
     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     e=
val ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_=
HOSTS_$SUF\"
+    eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping=
_args=3D\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFI=
G* variables for this test are missing, run an --up
     # script to genera=
te them dynamically=2E
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_=
ifconfig6" ]; then
-        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDD=
IR ${top_builddir} --script-security 2 --up ${srcdir}/update_t_client_ips=
=2Esh"
+        up=3D"--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} =
--script-security 2 --up ${update_t_client_ips}"
     else
         up=3D""=

     fi
 
     output_start "### test run $SUF: '$test_run_title' ###"
+  =
  if [ -n "$expect_fail" ]; then
+        output "### expect failure: '$exp=
ect_fail'"
+    fi
     fail_count=3D0
 
     if [ -n "$test_check_skip" ];=
 then
         output "check whether we need to skip: '$test_check_skip'"
-=
        if eval $test_check_skip; then :
+        if eval $test_check_skip;=
 then
+            :
         else
             output "skip check failed, =
SKIP test $SUF=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    printf "=
$outbuf" ; continue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+     =
       printf "$outbuf"
+            continue
         fi
     fi
 
@@ -385=
,13 +421,14 @@
     output "\nrun pre-openvpn ping tests - targets must not=
 be reachable=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
    =
 run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_count" =3D 0 ] =
; then
+    if [ "$fail_count" =3D 0 ]; then
         output "OK=2E\n"
    =
 else
-	fail "make sure that ping hosts are ONLY reachable via VPN, SKIP te=
st $SUF=2E"
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D31
-	printf=
 "$outbuf" ; continue
+        fail "make sure that ping hosts are ONLY rea=
chable via VPN, SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $=
SUF"
+        exit_code=3D31
+        printf "$outbuf"
+        continue
  =
   fi
 
     pidfile=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"
@@ -406,38 +443,77 =
@@
     # to $ovpn_init_check times=2E
     ovpn_init_check=3D30
     ovpn_=
init_success=3D0
-    while [ $ovpn_init_check -gt 0 ];
-    do
-       sle=
ep 1  # Wait for OpenVPN to initialize and have had time to write the pid f=
ile
-       grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=
=2Elog >/dev/null
-       if [ $? -eq 0 ]; then
-           ovpn_init_check=
=3D0
-           ovpn_init_success=3D1
-       fi
-       ovpn_init_check=
=3D$(( $ovpn_init_check - 1 ))
+    while [ $ovpn_init_check -gt 0 ]; do
+ =
       sleep 1 # Wait for OpenVPN to initialize and to write the pid file
+=
        if [ -n "$expect_fail" ]; then
+            grep "$expect_fail" $LO=
GDIR/$SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+    =
            ovpn_init_check=3D0
+                ovpn_init_success=3D1
+   =
             sleep 5 # give openvpn time to quit
+            fi
+        e=
lse
+            grep "Initialization Sequence Completed" $LOGDIR/$SUF:open=
vpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+                ov=
pn_init_check=3D0
+                ovpn_init_success=3D1
+            fi
+ =
       fi
+        ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
-=
    opid=3D`cat $pidfile`
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
  =
   if [ -n "$opid" ]; then
         output "  OpenVPN running with PID $opi=
d"
     else
-        output "  Could not read OpenVPN PID file"
+        i=
f [ -z "$expect_fail" ]; then # print this only if unexpected
+            =
output "  Could not read OpenVPN PID file"
+        fi
     fi
 
-    # If =
OpenVPN did not start
+    # did we expect a failure?
+    if [ -n "$expect=
_fail" ]; then
+        if [ -n "$opid" ]; then # OpenVPN did start!
+     =
       output "$0: OpenVPN did start up, expected failure"
+            $RU=
N_SUDO $KILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn=
=2Elog"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+      =
      fail "skip rest of sub-tests for test run $SUF=2E"
+            trap =
- 0 1 2 3 15
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            =
exit_code=3D32
+            printf "$outbuf"
+            continue
+       =
 elif [ $ovpn_init_success -eq 0 ]; then
+            output "$0: OpenVPN f=
ailure did not match expected failure"
+            output "tail -5 $SUF:op=
envpn=2Elog"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+ =
           SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D33
=
+            printf "$outbuf"
+            continue
+        else
+        =
    output "test run $SUF: all tests OK (saw expected failure)=2E"
+       =
     SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+   =
 fi
+
+    # If OpenVPN did not start but should have
     if [ $ovpn_init_=
success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not i=
nitialize in a reasonable time"
         if [ -n "$opid" ]; then
-         =
  $RUN_SUDO $KILL_EXEC $opid
+            $RUN_SUDO $KILL_EXEC $opid
      =
   fi
         $RUN_SUDO $KILL_EXEC $sudopid
-	output "tail -5 $SUF:openvpn=
=2Elog"
-	output "`tail -5 $LOGDIR/$SUF:openvpn=2Elog`"
-	fail "skip rest o=
f sub-tests for test run $SUF=2E"
-	trap - 0 1 2 3 15
-	SUMMARY_FAIL=3D"$SU=
MMARY_FAIL $SUF"
-	exit_code=3D30
-	printf "$outbuf" ; continue
+        ou=
tput "tail -5 $SUF:openvpn=2Elog"
+        output "$(tail -5 $LOGDIR/$SUF:o=
penvpn=2Elog)"
+        fail "skip rest of sub-tests for test run $SUF=2E"
=
+        trap - 0 1 2 3 15
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+  =
      exit_code=3D30
+        printf "$outbuf"
+        continue
     fi
 
=
     # make sure openvpn client is terminated in case shell exits
@@ -452,1=
7 +528,16 @@
         exit 1
     fi
 
-    if [ "$expect_ifconfig4" =3D "-=
" ] ; then
+    if [ "$expect_ifconfig4" =3D "-" ]; then
         output "s=
kip ifconfig+route check"
     else
-	output -n "compare pre-openvpn ifconf=
ig+route with current values=2E=2E=2E"
-	if diff $LOGDIR/$SUF:ifconfig_rout=
e_pre=2Etxt \
-		$LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/null
-	then
-	    =
fail "no differences between ifconfig/route before OpenVPN start and now=2E=
"
-	else
-	    output " OK!\n"
-	fi
+        output -n "compare pre-openvpn=
 ifconfig+route with current values=2E=2E=2E"
+        if diff $LOGDIR/$SUF=
:ifconfig_route_pre=2Etxt \
+            $LOGDIR/$SUF:ifconfig_route=2Etxt =
>/dev/null; then
+            fail "no differences between ifconfig/route b=
efore OpenVPN start and now=2E"
+        else
+            output " OK!\n"
=
+        fi
     fi
 
     # post init script needed?
@@ -483,8 +558,8 @@
 =
    $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=3D$?
-    if [ $rc !=3D=
 0 ] ; then
-	fail "OpenVPN return code $rc, expect 0"
+    if [ $rc !=3D 0=
 ]; then
+        fail "OpenVPN return code $rc, expect 0"
     fi
 
     o=
utput "\nsave post-openvpn ifconfig + route=2E=2E=2E"
@@ -496,23 +571,22 @@=

 
     output -n "compare pre- and post-openvpn ifconfig + route=2E=2E=2E"=

     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-	    $LOGDIR/$SUF:if=
config_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt
-    then
-=
	output " OK=2E\n"
+        $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR=
/$SUF:ifconfig_route_diff=2Etxt; then
+        output " OK=2E\n"
     else
=
-	output "\n\n" "`cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt`" "\n"
-	fail =
"differences between pre- and post-ifconfig/route=2E"
+        output "\n\n=
" "$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)" "\n"
+        fail "diffe=
rences between pre- and post-ifconfig/route=2E"
     fi
-    if [ "$fail_co=
unt" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0 ]; then
         output "=
test run $SUF: all tests OK=2E\n"
-	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+      =
  SUMMARY_OK=3D"$SUMMARY_OK $SUF"
     else
-	if [ "$V" -gt 0 ] ; then
-	  =
  printf "$outbuf"
-	    echo "test run $SUF: $fail_count test failures=2E =
FAIL=2E"
+        if [ "$V" -gt 0 ]; then
+            printf "$outbuf"
+  =
          echo "test run $SUF: $fail_count test failures=2E FAIL=2E"
      =
   fi
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
+        SUMMA=
RY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
     fi
 
     if [ =
-n "$test_cleanup" ]; then
@@ -522,9 +596,9 @@
 
 done
 
-if [ -z "$SUMMARY=
_OK" ] ; then SUMMARY_OK=3D" none"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SU=
MMARY_SKIP=3D" none"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D"=
 none"; fi
+if [ -z "$SUMMARY_OK" ]; then SUMMARY_OK=3D" none"; fi
+if [ -z=
 "$SUMMARY_SKIP" ]; then SUMMARY_SKIP=3D" none"; fi
+if [ -z "$SUMMARY_FAIL=
" ]; then SUMMARY_FAIL=3D" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK=
=2E"
 echo "Test sets skipped:$SUMMARY_SKIP=2E"
 echo "Test sets failed:$SU=
MMARY_FAIL=2E"

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2141?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change=
-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
Gerrit-Change-Number: 2141
G=
errit-PatchSet: 1
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>

--ZPt3qOLG9vc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">backport t_client=2Esh changes from master<br><br>This is basic=
ally just copying in the current t_client=2Esh=2Ein script from<br>master, =
with a number of changes that are not in 2=2E7 yet - most notably<br>suppor=
t for &quot;expect failure&quot; cases=2E<br><br>Given that this is a test =
support script with no dependencies into the<br>OpenVPN core, and the large=
 number of non-backported scripts that touch<br>one line or the other, or r=
e-indent things, copying the whole script<br>instead of trying to cherry-pi=
ck all the individual change seemed like<br>a much better idea=2E=2E=2E<br>=
<br>Here&#39;s the list:<br><br>commit e2548f6e3b7f9ed3d24020319117b17f3074=
3656<br>    t_client=2Esh=2Ein: Check whether addresses are in &quot;tentat=
ive&quot; state<br><br>commit af6a79c6a83739ca9542e52a02a3449a2f292758<br> =
   t_client=2Esh=2Ein: Add ability to filter by test group<br><br>commit dc=
162485236b70ecfe1be639dbd9db8244a85d54<br>    t_client=2Esh=2Ein: Allow to =
override the location of t_client_ips=2Erc<br><br>commit 8b392d642eb4c9b913=
5dc6a442d943159467e058<br>    t_client=2Esh=2Ein: Add utility function need=
s_openvpn()<br><br>commit dc162485236b70ecfe1be639dbd9db8244a85d54<br>    t=
_client=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc<br><=
br>commit 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60<br>    t_client=2Esh=2Ei=
n: Add support for expected test failures<br><br>commit ed427eab1683af3adf2=
1553dd1c6b6e4b8b2f10d<br>    reformat-shell=2Esh: Add --simplify argument<b=
r><br>commit f781227c92a3d1017e9d8a67e83e4465b43edf66<br>    Reformat all s=
hell-scripts with shfmt<br><br>commit b32d1ab45ec93786191e0dac2c8f5549d6c04=
258<br>    t_client=2Esh=2Ein: Do not try to guess the absolute path to LOG=
DIR<br><br>commit da1b2a7081eb2791f3a675945c42d7f3189ef752<br>    t_client=
=2Esh=2Ein: Use printf instead of echo -e<br><br>commit 162f19112702d1c8045=
efd17c5b09022fe1e04fb<br>    t_client=2Esh=2Ein: Do not run resolvectl if s=
ystemd is not running<br><br>commit 841ab0b216a424eb0100448362f76a2c12b3a51=
6<br>    t_client=2Esh: Do not use CA_CERT variable as indicator for good =
=2Erc file<br><br>Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M test=
s/t_client=2Esh=2Ein<br>1 file changed, 253 insertions(+), 179 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/41/2141/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b=
/tests/t_client=2Esh=2Ein</span><br><span>index 876e84a=2E=2E5e924bb 100755=
</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests=
/t_client=2Esh=2Ein</span><br><span>@@ -19,57 +19,82 @@</span><br><span> sr=
cdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${t=
op_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${to=
p_builddir}/src/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ] ; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_b=
uilddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ] ; then</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_cli=
ent=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot find=
 &#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt=
;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot=
;$0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &g=
t;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit &quo=
t;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_client_=
ips=2Erc}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+upda=
te_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client_ip=
s=2Esh}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;${t_client_=
rc}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;${top_b=
uilddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;=
${srcdir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#3=
9;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        echo &quot;$0: or source directory (&#39;${src=
dir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>=
 fi</span><br><span> </span><br><span> # Check for external dependencies</s=
pan><br><span> FPING=3D&quot;fping&quot;</span><br><span> FPING6=3D&quot;fp=
ing6&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping=
 &gt; /dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+whic=
h fping &gt;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><spa=
n>     echo &quot;$0: fping is not available in \$PATH&quot; &gt;&amp;2</sp=
an><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping6 &gt; /dev/=
null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+which fping6 &g=
t;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     ech=
o &quot;$0: fping6 is not available in \$PATH, assuming fping 4=2E0 or late=
r&quot; &gt;&amp;2</span><br><span>     FPING=3D&quot;fping -4&quot;</span>=
<br><span>     FPING6=3D&quot;fping -6&quot;</span><br><span> fi</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`w=
hich kill`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=
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
ho &quot;Test sets failed:$SUMMARY_FAIL=2E&quot;</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Dem=
ail">change 2141</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2141?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2141 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--ZPt3qOLG9vc=--


--===============4021175051207400669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4021175051207400669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4021175051207400669==--

