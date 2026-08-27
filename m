Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A99C61DC2
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjtVe3CDzDDzYT/RQr9DGgYU5kE5W7ngwXFU/OSOXf4=; b=LCyvJJkeAhGBhXH25+gScNCNIw
	lqDTRQM/VUded92ZuJ6iRpOrBu3Xwsbie67PLVC0ekJGKZdABRrs1ypx/jVFEy5ub/hKdg7wfwiIS
	Z1yLMa30szDkTQdTrIvylM/IOjLzZp49xxogelXQ8DVwYgm00WxdwX88BcGm4S92QNHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYkS-000808-RA;
	Thu, 27 Aug 2026 11:58:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYkR-0007zw-Bv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TLJ2ZPkQa8sxrj5XRw9peW2VxNRqw5kpw7cNJ+U1e7Y=; b=QTIXiA+M61F9fnd/Z8xOTceotj
 oJtpSDwXWSjwPYW80pFhJ33cGVVcyeYgGkJG06aq0VZBuj9Id5zmAEkK/XL3gPkpghXWy0OWurNHj
 X8hjiUC1hObX2VRcqETBGyvurF+bgCbaxhDsMspkA3jpPhuUNeKR4YvcGLGZLFSl3F58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TLJ2ZPkQa8sxrj5XRw9peW2VxNRqw5kpw7cNJ+U1e7Y=; b=O
 teJ4xyBmMO9ve/RUMlKfQQL+2QvQpzIstGh35+vmgsj2NWzLDr8+5jQJXE7HTKeWzIPokOWmWmtKR
 Zs8ZgGStFaG4LflqAz39XjOheg70tavCZaL8S1yNLspKRgyASU7t24zHe9YAlpYZjzAYwUAOdr5Ld
 WVe2wiKKwLSxSvf4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYkQ-0000jM-C4 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:58:24 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso5991045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787831896; x=1788436696; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TLJ2ZPkQa8sxrj5XRw9peW2VxNRqw5kpw7cNJ+U1e7Y=;
 b=Ki/DdBO+wi/DXAngSCArPxWyPlr1/prAD/1gCOHDVepsI8rbsttbvTnRKz4QDX5yw7
 7Mf2ug5dfdvrpDgH9KJEVIzbUYpxnCyIJErk3an8O6iQVRN1++j/1cZXMItFKBVHtCR4
 rYdLQMHz+10lH7UnVhdEdzSaMWramzuEnNOwnQE9yWlfh0AHysD1jpaUjSni39eL9BnS
 Ln/YxslDxls64En20qDL+sXZmLwRSV2KKcmQfowNeYoWt70s+wHBImZysUkW/+axBTxc
 KejqO+1TAXfuQ6OAv7uj0fIl91CgFXB0vx3G0kyupiMtKOsSSaOGHG5G5IdIkvRBZ1mo
 OGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831896; x=1788436696;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TLJ2ZPkQa8sxrj5XRw9peW2VxNRqw5kpw7cNJ+U1e7Y=;
 b=o+hzR+vNRd+ww1AceMenNh/Wx6uDArdHMkAkSXlextkJmzygqmqbdKd505bQZq8QRL
 x3grIJp+TPcgxMyiQCUfMt2BClLURzlqm47AqkBAf4Avf/lVk6W3L1KQpT/cX6ibFRBA
 8Sx//R7/r3JFRgvwiSohCs2WwfcPJsaMEunYiL4OtcPqmCTe4HVyagYm+sp0ij2Jwazw
 y0v6eG5hNc2Wa2AbRBdB+lE3UZloKQf6dlSkmG0ewicyblDdXAP2i8ortvoZyqfDZZdl
 ug670HSlPr7JPvLVLPWaLIi/6rP46n15ZT/IiEsYiHxOPPlqxDo6GGgjESFw4Gf1OjCW
 QInQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0twMrijDCqGgj0+CP5NIe+mJ13dlpdnzQc/iWpanTd9kkdj+qfe8uXooPdaCDlS5ti+WFrSYDTqR++YbW@lists.sourceforge.net
X-Gm-Message-State: AFuF++mCdduKdAVBrFoRVxU2VPaJp6vKXRFuFrYQRA3mrkyIhjPgwTrx
 VvVnj13FK2SUAe1n/JFOrPvrQCmVJPz3ElU6g25hZWZtCf/zOYTrYABRY5wQRSuPLhPdUqX2ERS
 ZNlslPiYSOX5e2+muH/JmWbiTegnJUpCPAaFSYodkRFgj3JByIyqbEprV+momjyJwDEre
X-Gm-Gg: AR+sD12G1HC3r1AKjJgHUk2FiGcWy7Z464ht77eGg636Q0TkMwTwC+7+W0bwSkYXXp7
 31Au2kYLnxK2w/upUIj23Ugt6GahFWCKyGGcThLcE8NeCSYTJxHtWrbT7vmiqrMIgpvs7498HvS
 Abf8Wa+d+UJqh/H6BzzkdaXbajHjL6nQWVySLaWXUb/OT+yOpZO3keJxaCCLPb+T4BI5YkQREO0
 /5bALvPbrB8Qb1n7nNJ2DgFIK9kRigotWqfGbNdZEcJZTA2jdvn0YsLLMoBlGfyG9BPZHXo+TYm
 o5k51EivsksFvTFzOQhmthw8DhfghAFAGkhsLTiiGD5X/4wNI6Wv07KJtFTJrA3EG6L17jx4ekW
 auQKYPqWWi+y1LOB0CMeTRHv/3tB/e7pjtNJ+pZ1XP/NlIE9UfdVsl3DoBeVIunnah5wS7v4aj1
 rLyFewXfEAd6JXsGEoiGf7FVdtYDIDL6QEjeB2bWdx/NrHtJduYDlV8a6b4+0YW2wqmL8mmAOF9
 OcS9Sk5kODtFffvs5CkPdEGaYe89CwBRNkFipaHSunKRiQcAU/aVaMdQ5DINohczpho++Q6oViT
 H3gReI5XfvkPeMdBDPw/iL6QxVtbrK0vAa5J9q6+n1a10ylQ4PA=
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr80520855e9.7.1787831895584; 
 Thu, 27 Aug 2026 04:58:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm109506835e9.6.2026.08.27.04.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 04:58:15 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 11:58:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 82e151c45c3dcc67b2e25d118cc0326f5fa4dbc0
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <50ad620e1d8f9f4125ba5deb0317c4f5ef615e41-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYkQ-0000jM-C4
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5743356841744169371=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5743356841744169371==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/6aWs2rb2Dc="; charset=UTF-8

--/6aWs2rb2Dc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail

to look at the new patch=
 set (#5)=2E


Change subject: t_client=2Esh=2Ein: Add utility function nee=
ds_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


t_client=2Esh=2Ein: Add utility function needs_openvpn()

This allows to =
skip tests on old versions of openvpn=2E
Makes it much easier to maintain a=
 t_client=2Erc across
multiple versions=2E

Change-Id: I1905d9494336da4e91f=
1946d2ffd875720605b41
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M tests/t_client=2Esh=2Ein
1 file changed, 22 insertions(+), 8 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/63/1763/5

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2E=
sh=2Ein
index 7c23020=2E=2Ec3a9655 100755
--- a/tests/t_client=2Esh=2Ein
++=
+ b/tests/t_client=2Esh=2Ein
@@ -22,14 +22,16 @@
 t_client_ips_rc=3D"${t_cl=
ient_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
 update_t_client_ips=3D"${=
update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
 
-if [ -r "${top=
_builddir}"/t_client=2Erc ]; then
-    =2E "${top_builddir}"/t_client=2Erc
=
-elif [ -r "${srcdir}"/t_client=2Erc ]; then
-    =2E "${srcdir}"/t_client=
=2Erc
-else
-    echo "$0: cannot find 't_client=2Erc' in build dir ('${top=
_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}')=2E SKIPP=
ING TEST=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -z "${t_client_rc}" ]=
; then
+    if [ -r "${top_builddir}"/t_client=2Erc ]; then
+        t_clie=
nt_rc=3D"${top_builddir}"/t_client=2Erc
+    elif [ -r "${srcdir}"/t_client=
=2Erc ]; then
+        t_client_rc=3D"${srcdir}"/t_client=2Erc
+    else
+ =
       echo "$0: cannot find 't_client=2Erc' in build dir ('${top_builddir}=
')" >&2
+        echo "$0: or source directory ('${srcdir}')=2E SKIPPING TE=
ST=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
 fi
 
 # Check for ex=
ternal dependencies
@@ -63,6 +65,18 @@
     exit 1
 fi
 
+openvpn_version=
=3D$(${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E 's/^2\=2E([0=
123456789]+)=2E*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=3D$1
+
+ =
   [ "$openvpn_version" -ge "$needs_version" ]
+    return $?
+}
+
+=2E "${=
t_client_rc}"
+
 if [ -z "$TEST_RUN_LIST" ]; then
     echo "TEST_RUN_LIST =
empty, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCLIENT_SKIP_RC}=
"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1905d9494336da=
4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763
Gerrit-PatchSet: 5
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>

--/6aWs2rb2Dc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">t_client=2Esh=2Ein: Add utility function needs_openvpn()<br><br=
>This allows to skip tests on old versions of openvpn=2E<br>Makes it much e=
asier to maintain a t_client=2Erc across<br>multiple versions=2E<br><br>Cha=
nge-Id: I1905d9494336da4e91f1946d2ffd875720605b41<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=
=2Ein<br>1 file changed, 22 insertions(+), 8 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
63/1763/5</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2E=
sh=2Ein</span><br><span>index 7c23020=2E=2Ec3a9655 100755</span><br><span>-=
-- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ei=
n</span><br><span>@@ -22,14 +22,16 @@</span><br><span> t_client_ips_rc=3D&q=
uot;${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&quot;</span><br><=
span> update_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t=
_client_ips=2Esh}&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top=
_builddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_cl=
ient=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot fin=
d &#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &g=
t;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quo=
t;$0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &=
gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit &qu=
ot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+if [ -z &quot;${t_client_rc}&quot; ]; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if [ -r &quot;${top_builddir}&quot;/t_cl=
ient=2Erc ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      t_client_rc=3D&quot;${top_builddir}&quot;/t_client=2Erc</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    elif [ -r &quot;${srcdir}&quo=
t;/t_client=2Erc ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        t_client_rc=3D&quot;${srcdir}&quot;/t_client=2Erc</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$0: cannot find &#39;t=
_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;=
$0: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt=
;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit=
 &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    fi</span><br><span> fi</span><br><span> </span><br><span> #=
 Check for external dependencies</span><br><span>@@ -63,6 +65,18 @@</span><=
br><span>     exit 1</span><br><span> fi</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+openvpn_version=3D$(${openvpn} --ver=
sion | head -n 1 | cut -f2 -d&quot; &quot; | sed -E &#39;s/^2\=2E([01234567=
89]+)=2E*$/2\1/&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+needs_openvpn()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    needs_version=3D$1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    [ &quot;$openvpn_version&quot; -ge &quot;$needs_ver=
sion&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn $?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+=2E &quot;${t_client_rc}&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if [ -z &quot;$TEST_R=
UN_LIST&quot; ]; then</span><br><span>     echo &quot;TEST_RUN_LIST empty, =
no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span>     exi=
t &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Dem=
ail">change 1763</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1763?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1763 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--/6aWs2rb2Dc=--


--===============5743356841744169371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5743356841744169371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5743356841744169371==--

