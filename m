Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEC606A329
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lbQQUMnF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M8S7KRzk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MNtccNj0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GoE8NHzS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YbHyoRYU5jKu/UDcPWlMh68Pgd4TGdAlvQfmznx9RUk=; b=lbQQUMnFSpLoxDsUK5YFqKLfWh
	atq+EtdUu9CB0zFjcvh8aFEL9rDVuXwMYGIHqWLZiRZhkCydFElAKbg8Kj13gwILj/tMxrJs0ySvo
	uLfju1gwcO/GYxgu6KXDH5xPVxT10cWRLZMRPiUa18+nMmU+HAY04QrlHC5vzIogNKsw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP3Pw-0000000027Z-2BcW;
	Thu, 05 Nov 2026 19:46:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP3Pt-0000000027O-1jte
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oJFuGD7Do8azKfmi3my4H87raSYoFpCR2OL9qrde6YI=; b=M8S7KRzkhVStz6VwUj0R5nZKqw
 9zECZibnuMq80xxJ95uWr6mqvbJWAKQiDEL20W0wSbkmeTyhH6/AmRAVhHJrWnJf6fYQfoZjEOBbe
 hNAxS66y4iGusR95q7BkkoCk3WemfAVIJFI5/MTNRcKIqk5/XrTXj5sDQLCND9abZ0xU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oJFuGD7Do8azKfmi3my4H87raSYoFpCR2OL9qrde6YI=; b=MNtccNj0SMVpNKt1a5ruwRrou3
 U2aFG0S0xUaoSiJd3pY21+2KSTKOoUVV5P3TXqYmYtA8UOzoN5thfr6wHsPI8+7TdCDEE5JNFufYS
 tC+XfHJIPtiMqUIpEWe15uH839kCmNnQnccL0TtV6NTBtfcufJ2qtlLs7ny8pSXY3vfc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP3Pr-000000004B3-2usj for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:33 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso24994645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793907985; x=1794512785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oJFuGD7Do8azKfmi3my4H87raSYoFpCR2OL9qrde6YI=;
 b=GoE8NHzSKLWuL6ru8rak6siIUnGyD+M+yDxLpKd2k3O6tfOnQiNuJctyR6KeoAZ1jp
 Iku0o5Ssv/zH3BxxRaM9+SS7DTSQ3GyilcHaiG6KlmYkRCJawfQUILO1g1/P01oPOHr3
 Q1JYJO38w38FTrcNQEBSWvvTVPoi2gcrdIpkldzlQHHMY15xODmpKr/2gsW6Tp7MR6ku
 QKtNgmg6iZ9RVo4D+i34Iz2Uusq0Ex513TwofgCOU73NeU1JhdhJ2DcjS6rfWvWGPM9P
 ufFVELQHPhN8XikvmVdJMwKZKkD6AYvBOh+YLby7UF0JACXEB8s2N+M1UH1CVUZfoJn/
 lqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907985; x=1794512785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oJFuGD7Do8azKfmi3my4H87raSYoFpCR2OL9qrde6YI=;
 b=LwZgaHpKfLfFDsPoRTbaiAXMS1ITmT/Lj7OPAIvbgyPBxLZx2DHJTkabptf9lytKgT
 iMwE4PFSSHdloY+1Qb5R2/C5dQo4sZilXubgUSgxUm9wnfjyTsP2Aku5YkpBXdbvy2OO
 ZNoAR4YS8jAmscsVNm8cUnd6whBbzvBLIgNfziih5GYkm30QzGHRlrtgdypG80jGFRTB
 IJJ16AAdBFk6DzACNKYFjOjNqva5DDmx3WeXZo8usXqM/l10du/+X+6XCfcT0yyT1N/3
 1/rKVRQdtx544uyv1xUyaE6Km5KB1bTwaAc/gIVxIjayamVBQKspQBF0Gulhuq1POKnv
 03hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZzHy0o3xsNi+4am8BlRrGkFiOUbBrnGo9x0OnuVFB+35jAX8xWXcHyShO18H0iowPAuDV8Cn2uiHEi/ie@lists.sourceforge.net
X-Gm-Message-State: APuU4Z91EYhUHWdnLGbGBnvzura2h0UmBCZUXuaE+avV8DapAwTc0hyt
 LWj0rpfx7P8C5Y96Tkv5bM0FaV6iFuKoXE1LBXxMRyxGcyzUnPeXycJs24efbeZn/9Pvo1lp8UV
 /kNKCiApOeF7a11mepzpyYtboZ30M8+IMpfp+hy6Ldu8mX3qMJQWR0ehJyKiUb0QtWYT9YqKP2k
 JkXpqBLA==
X-Gm-Gg: AYBFou0XCFGAwsylv7Xz25NjMVUce/dfwHV9U+ag22/rvBIKQDMlyH04XOj2/C/AST8
 NlXo/afT5BHUrMU9gceSE+V+jr+51Chph7/rJaV8gHeJPTACQnemRuFKYBFylv+tVF1YDkMUjb7
 BwSMytEfW5siFpmbFjP7CZqNZDyjCaLLyWIy4jzr6NsDi/OGAN4SskWG8+wr9BOgQ2xcksq+iG8
 732DAiViPzJ533CVf7m7WHAUr/eMPwFNywVmum8GZMI36HSD8URflvODLeg69rKfHzOFh07yCYG
 jcSkQnegxCH/yUXklrylGl2sazVn/wj3t0Fc/UOtV8ag4atTb0VrM/O1ye2kqJ2FeEopT1aqH3y
 IXqOQ4KwIYNBCsOgQxf7xSJ+FAvgmSqURRzIiu2o1Ml7mkaphD39QoqMohC5O2wrnsglVADneT1
 EBqJ5q/MXQcpegW6ePW+kjMr/CLsMHq9yow5UPORbcn3QcUJ8LR0VPZZ9RqWIqkYJGeFXWEaY4x
 98Bi7WpRIDL/ZBrhonF5dPk+0kYcPXOMZ/n3wa9N9ukk0yLFunQ1pmpIHZuQbybgCS2gN2eWGeI
 f4jhXI+tNdGwWi3XWOoOdwJDW0vX4kn036i03Q2I3l1R2ls6CDg5rVuMToqKdBGtPHAmwlQK/DX
 Tq3czNUZ+2UPpy8bD9N3pRNgiMbEpFEWYtPKQkRqSWLk6emMsefpCTOyioRWFJJA1gmEshRv/K5
 xine2LIQgLDnAj+w==
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4b6df6df5d9mr2519125e9.32.1793907984954; 
 Thu, 05 Nov 2026 11:46:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2029278sm1793875e9.10.2026.11.05.11.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:46:24 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 19:46:23 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
X-Gerrit-Change-Number: 2107
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2107?usp=email>
X-Gerrit-Commit: adf5ecfd8f09da1935a00b039cc0b92bc800c87d
In-Reply-To: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
References: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkkzNjQzMGJhYjg5N2U1ZmU5YjFjZmQ0OGRlNTAyMjQzOTVkNTZkOGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e33c4ab504c2035b563eab8745653556fa74b483-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP3Pr-000000004B3-2usj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Provide minimal
 netlink defines for cppcheck on FreeBSD and macOS
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
Content-Type: multipart/mixed; boundary="===============3400908399252404538=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3400908399252404538==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5mPdGnvMcYc="; charset=UTF-8

--5mPdGnvMcYc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2107?usp=3Demail )

Change subject: Provide minimal netlink def=
ines for cppcheck on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Provide minimal netlink defines for cppcheck on F=
reeBSD and macOS

Without these defines and the hidden goto inside the NLA_=
PUT functions
cppcheck complains about ret in dco_linux=2Ec=2E This allows =
to run
cppcheck on macOS and FreeBSD without triggering these warnings=2E

=
Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107
Message=
-Id: <20261103141439=2E14041-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40579=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A dev-tools/openv=
pn-cppcheck-netlink=2Ecfg
M dev-tools/run-cppcheck=2Esh
2 files changed, 10=
 insertions(+), 0 deletions(-)




diff --git a/dev-tools/openvpn-cppcheck-=
netlink=2Ecfg b/dev-tools/openvpn-cppcheck-netlink=2Ecfg
new file mode 1006=
44
index 0000000=2E=2Eb63adf0
--- /dev/null
+++ b/dev-tools/openvpn-cppchec=
k-netlink=2Ecfg
@@ -0,0 +1,7 @@
+<?xml version =3D"1=2E0"?>
+<def>
+  <!-- =
minimal defines to supress the errors on non-Linux platforms that do not ha=
ve the netlink headers -->
+  <define name=3D"NLA_PUT(msg, attrtype, attrle=
n, data)" value=3D"if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) < 0=
) goto nla_put_failure;" />
+  <define name=3D"NLA_PUT_U32(msg, attrtype, v=
alue)" value=3D"NLA_PUT(msg, uint32_t, attrtype, value)" />
+  <define name=
=3D"NLA_PUT_STRING(msg, attrtype, value)" value=3D"NLA_PUT(msg, attrtype, (=
int) strlen(value) + 1, value)" />
+</def>
diff --git a/dev-tools/run-cppch=
eck=2Esh b/dev-tools/run-cppcheck=2Esh
index d1c22c5=2E=2Edebcd46 100755
--=
- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -20,9 =
+20,11 @@
 if [ $(uname) =3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; then=

     SCRIPT_DIR=3D$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
     num_p=
rocs=3D$(sysctl -n hw=2Encpu)
+    EXTRA_LIBRARY=3D"--library=3D${SCRIPT_DI=
R}/openvpn-cppcheck-netlink=2Ecfg"
 else
     SCRIPT_DIR=3D$(dirname $(read=
link -e "${BASH_SOURCE[0]}"))
     num_procs=3D$(nproc)
+    EXTRA_LIBRARY=
=3D""
 fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}
@@=
 -35,6 +37,7 @@
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
  --enable=3Dall=
 ${disable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecf=
g \
+ ${EXTRA_LIBRARY} \
  --library=3Dopenssl=2Ecfg \
  --suppress-xml=3D$=
{SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-buil=
d-dir=3D${CPPCHECK_DIR} \

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2107?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Gerrit-Change-Number: 2107
=
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--5mPdGnvMcYc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2107?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Provide minimal netlink defines fo=
r cppcheck on FreeBSD and macOS<br><br>Without these defines and the hidden=
 goto inside the NLA_PUT functions<br>cppcheck complains about ret in dco_l=
inux=2Ec=2E This allows to run<br>cppcheck on macOS and FreeBSD without tri=
ggering these warnings=2E<br><br>Change-Id: I36430bab897e5fe9b1cfd48de50224=
395d56d8fc<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107<br>Message-Id: &lt;20261103141=
439=2E14041-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40579=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A dev-tools/o=
penvpn-cppcheck-netlink=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>2 files c=
hanged, 10 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-=
tools/openvpn-cppcheck-netlink=2Ecfg b/dev-tools/openvpn-cppcheck-netlink=
=2Ecfg</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Eb63adf0</span><br><span>--- /dev/null</span><br><span>+++ b/dev-tools=
/openvpn-cppcheck-netlink=2Ecfg</span><br><span>@@ -0,0 +1,7 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml version =3D&quot;1=2E0=
&quot;?&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;def&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- minima=
l defines to supress the errors on non-Linux platforms that do not have the=
 netlink headers --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;define name=3D&quot;NLA_PUT(msg, attrtype, attrlen, data)&quot; v=
alue=3D&quot;if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) &lt; 0) g=
oto nla_put_failure;&quot; /&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;define name=3D&quot;NLA_PUT_U32(msg, attrtype, value)&qu=
ot; value=3D&quot;NLA_PUT(msg, uint32_t, attrtype, value)&quot; /&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot=
;NLA_PUT_STRING(msg, attrtype, value)&quot; value=3D&quot;NLA_PUT(msg, attr=
type, (int) strlen(value) + 1, value)&quot; /&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+&lt;/def&gt;</span><br><span>diff --git a/dev=
-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>inde=
x d1c22c5=2E=2Edebcd46 100755</span><br><span>--- a/dev-tools/run-cppcheck=
=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ =
-20,9 +20,11 @@</span><br><span> if [ $(uname) =3D &quot;Darwin&quot; ] || =
[ $(uname) =3D &quot;FreeBSD&quot; ]; then</span><br><span>     SCRIPT_DIR=
=3D$(dirname $(readlink -f &quot;${BASH_SOURCE[0]}&quot;))</span><br><span>=
     num_procs=3D$(sysctl -n hw=2Encpu)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    EXTRA_LIBRARY=3D&quot;--library=3D${SCRIPT_DIR}/ope=
nvpn-cppcheck-netlink=2Ecfg&quot;</span><br><span> else</span><br><span>   =
  SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</spa=
n><br><span>     num_procs=3D$(nproc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    EXTRA_LIBRARY=3D&quot;&quot;</span><br><span> fi</spa=
n><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUI=
LD_DIR:=3D$PWD}</span><br><span>@@ -35,6 +37,7 @@</span><br><span>  -I${BUI=
LD_DIR} -I${BUILD_DIR}/include/ \</span><br><span>  --enable=3Dall ${disabl=
e_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-libra=
ry=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ ${EXTRA_=
LIBRARY} \</span><br><span>  --library=3Dopenssl=2Ecfg \</span><br><span>  =
--suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \=
</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
07?usp=3Demail">change 2107</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2107?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2107 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--5mPdGnvMcYc=--


--===============3400908399252404538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3400908399252404538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3400908399252404538==--

