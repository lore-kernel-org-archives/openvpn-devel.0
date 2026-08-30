Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA86C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WVTsDAOtu7XLbpGR3E660Hu8IA+c8nfX9R1iI2lXKBY=; b=nPntRKQrl7+wCYqeaRgJn1DD/W
	qmRcgH7JjyUhBjryhUnHzoCaHIBb7R0oUPfymf5WkQ4OdMofcQl2NE4Fw43ZcH0L9d8Ru/9HtPL/5
	7uf/EtSRDmKziU5wAX42JkRKPCvITYd2diP0d5U+dXtop6vmmHwnhAu86oI+Rx15F7N0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0j5A-0003U9-R6;
	Sun, 30 Aug 2026 17:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0j57-0003Tj-TE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:12:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f9mIjgwCkKRmPzRKtbaB04XmS0J1q5CSVxnVu8fOdvE=; b=U13q6QhGx/Fg7PljQ6I4kU6I7Q
 cGZboVZXsjSQ+fxcCrnbEW7h95vp+4IfxNMlbMjjFpx1h7sCd+FY2LLClvJOPCeTY07R/4ZF5/9+L
 zYcyXyBIr46Dwl+8+Z8+U91yzZE9uziux5aW8v6LtnnRMOb1fnj90GmBfdUqTxZ1EOH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f9mIjgwCkKRmPzRKtbaB04XmS0J1q5CSVxnVu8fOdvE=; b=Y
 +5YdJem66yvukx03zyP9oxQHvQXjEkHZSqt+5Ai43zJK2Ny9TJwuivccOi+GFRxyFF4EFDegUTNxk
 OcoANHAEy0gohWzpsyBu6xOS9a5Xvh43E+9H8WB0L2xov6T3LxoXNQ4Kr3EkX4/jJugVg6fd1u+Wy
 26415xkn/gnQIwHE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0j4c-0001FV-Qc for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:12:04 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so23557295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788109916; x=1788714716; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f9mIjgwCkKRmPzRKtbaB04XmS0J1q5CSVxnVu8fOdvE=;
 b=O819y2OXtFqBawBnhkEMGNFb2dD0/wAH46yl937fxuG+briy+y8c9XMNm0Rv6KYdrf
 HJ+ZfqUgPkT4/5/Tok/H49G9gdyMyd19O3knl/0IMK9FpTqXm5N0ZPl6tNFkleBcM5L1
 C3zdO3Q/qlmgKk2TuBEPd2eEw4dsNs7lidTEG5SKImMPM4YGd6IUKvHn3anifhzpHg9V
 3gLJFrYI0looaFzl2wI0XVpHT1il3p9FISPz2DDY39IB/wDS3C/uGnkUYOHajAgQ3c+q
 Irr4Mv7/Dfl1puDqo+s2q1MISmDxbsAnDAT2y0BOp5ahRfLurSzPJ9dIO7TvpFXaKqpr
 0Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788109916; x=1788714716;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f9mIjgwCkKRmPzRKtbaB04XmS0J1q5CSVxnVu8fOdvE=;
 b=ibOFqL6SCFiia530Eu/SSuuciY4Z7fXk9/BWRVMYLFV4JLbgRd57IFksMy6X5faU65
 CSmvY7NTY9QLjnDG9G90VyEXGVBx5VkhzSEwJkBSVkEWFBMA/v6+XI4jvYrIE3W692mo
 iaZhndVcmqWl8IhTIJo8BtQq4pOZ047MHR3lkIJ/MA6PeYvHGVOTnvyTAEJAAn5W2LCi
 0AZe+Q4LZlwpTSm/59jIoT1DGWaSx9MQV+J7jR8UqbBSONN84DGEnMMWV7qDanD/jnPR
 0t8Tc4AdnGzTbiQg3TY9D/GXHk8G1kBjL9FiHgJUwvW+lJ6K+hdebupaUGSaCrb2Jg7j
 kg9Q==
X-Gm-Message-State: AFuF++m+ila/aPdNbVVVRLmZsJ1EirSGiff3olYsX3bEW1CSabRwwhm6
 UH3asKxOIC9PMnV6kfVwECrGy2kFwyIcXUZrbOxeESuw56N53If75xxklzbeU7oOaHs2mVRjnET
 p+TvxM71Jfj6ODk33mKD6o7D8DVFSvscBmDyBirp7fTQjiymYonwd5COWaNJT5pa/OzpYfpKPxk
 theeNUHg==
X-Gm-Gg: AR+sD13kldAhbWZN6zSP+Y/JO1DXqImf1+djdnYzgvssySL60XRHLQRtyeVBi1I8f0F
 fof1lKhg8d+idnRfeCVVFI8wBgbi+jsctFmNBLWLefUpxW88rWYTk1XQYniBW+0h5hGG3hrOFH5
 Q9kXmO6UbLK+G47hD/+3VOZsp7ufsdQ9ojtODDTfEiOv9yDKc91jymSS8Seq8GPIjEjEHuV8Cr5
 CQk5cL9pvrPXwRCGj3/i7wmLJFn4W1oI60G5AwpJ0gerMLUELbGTD729Owua526iCW8NayNW+qt
 Ll193nl2lAow2rslCfvNspMx/6E4Bql2AVAkQFHHd5nEUlx8TYS19xCDNt5QLhp/m5Su8PbT9ow
 WXykgoxJbmvd0BoH1uiu9z0sWYpf5f07IznvKKfIZ98FwAgWZJfR6f3TFoKWlxBryTWorFlah7M
 4u7ivnGNaLGKpdcnQrLYyyq93UY4JvSaChr05NJ/V9kM2XnmUxrqk+k0oHTcLx+rR5LSk1u0KfG
 tUcQAZs9Fmh46Mjq67OSncN5bihqV7RfygX5izBOQKacNqF0n+BWrjcJIUbVg2d9zHwIX1yeoA3
 99ZCpG3T/TITHAG/scLkQAoFMnAOC8A8Vn9Goa69wkNjLSot3Uw=
X-Received: by 2002:a05:600c:4688:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-49b91c4fa79mr260244335e9.11.1788109916101; 
 Sun, 30 Aug 2026 10:11:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013ce4sm194198005e9.14.2026.08.30.10.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:11:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:11:54 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: dc162485236b70ecfe1be639dbd9db8244a85d54
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d7cf830c339118d3569275362be91297895ce14-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0j4c-0001FV-Qc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Allow to override the location of t_client_ips.rc
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
Content-Type: multipart/mixed; boundary="===============8457062054286177786=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8457062054286177786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Or4GNAraUXU="; charset=UTF-8

--Or4GNAraUXU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: t_client=2Esh=2Ein: Allow to override the loca=
tion of t_client_ips=2Erc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

t_client=2Esh=2Ein: Allow to override the location of t_clien=
t_ips=2Erc

Makes it easier to use t_client=2Esh in other contexts=2E

This=
 is based on work by Gert Doering for the t_server
test infrastructure=2E

=
Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756
Mes=
sage-Id: <20260824180353=2E12076-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38649=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_cli=
ent=2Erc-sample
M tests/t_client=2Esh=2Ein
M tests/update_t_client_ips=2Esh=

3 files changed, 12 insertions(+), 5 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1756/7

diff --git a/tests/=
t_client=2Erc-sample b/tests/t_client=2Erc-sample
index 04714ef=2E=2E4c8743=
6 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_client=2Erc-sample
=
@@ -18,8 +18,8 @@
 #FPING_EXTRA_ARGS=3D"-t 1000"
 
 # Load EXPECT_IFCONFIG*=
 parameters from cache
-if [ -r "${top_builddir}/t_client_ips=2Erc" ]; then=

-    =2E "${top_builddir}/t_client_ips=2Erc"
+if [ -r "${t_client_ips_rc}"=
 ]; then
+    =2E "${t_client_ips_rc}"
 else
     echo "NOTICE: missing t_c=
lient_ips=2Erc will be auto-generated"
 fi
@@ -67,6 +67,12 @@
 # PING6_HOST=
S_x      =3D "these hosts musts ping when openvpn is up (IPv6 fping6)"
 # E=
XPECT_FAIL_x      =3D "instead of waiting for connection wait for this erro=
r message"
 #
+# Note that the EXPECT_IFCONFIG{4,6} options are not general=
ly required, the
+# tests will remember the ip address they got on the firs=
t run in t_client_ips=2Erc
+# and will expect to get the same address again=
=2E But it can be useful to hard-code
+# the IP when the server is expected=
 to send a very specific address, e=2Eg=2E when
+# using ccd on the server-=
side or in a P2P scenario=2E
+#
 # hook test options:
 #
 # FPING_ARGS_x   =
   =3D "arguments to append to the fping command line"
diff --git a/tests/t=
_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index dd7f743=2E=2E7c23020 100=
755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,6 =
+19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E=
}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
+t_client_i=
ps_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
+update_t_c=
lient_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
+
=
 if [ -r "${top_builddir}"/t_client=2Erc ]; then
     =2E "${top_builddir}"=
/t_client=2Erc
 elif [ -r "${srcdir}"/t_client=2Erc ]; then
@@ -327,7 +330,=
7 @@
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an=
 --up
     # script to generate them dynamically=2E
     if [ -z "$expect_i=
fconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up=3D"--setenv TES=
TNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${=
srcdir}/update_t_client_ips=2Esh"
+        up=3D"--setenv TESTNUM $SUF --se=
tenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}"=

     else
         up=3D""
     fi
diff --git a/tests/update_t_client_ips=
=2Esh b/tests/update_t_client_ips=2Esh
index 777a286=2E=2Ef02dc7f 100755
--=
- a/tests/update_t_client_ips=2Esh
+++ b/tests/update_t_client_ips=2Esh
@@ =
-3,8 +3,6 @@
 # This --up script caches the IPs handed out by the test VPN =
server to a file
 # for later use=2E
 
-RC=3D"$TOP_BUILDDIR/t_client_ips=2E=
rc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0=
 ]; then
     echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >>$RC

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331=
a92cfbb64be78f6aa33a
Gerrit-Change-Number: 1756
Gerrit-PatchSet: 7
Gerrit-O=
wner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Or4GNAraUXU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Allo=
w to override the location of t_client_ips=2Erc<br><br>Makes it easier to u=
se t_client=2Esh in other contexts=2E<br><br>This is based on work by Gert =
Doering for the t_server<br>test infrastructure=2E<br><br>Change-Id: Ia4a9a=
6bafb6bcb3fe331a92cfbb64be78f6aa33a<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756=
<br>Message-Id: &lt;20260824180353=2E12076-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38649=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M tests/t_client=2Erc-sample<br>M tests/t_client=2Esh=
=2Ein<br>M tests/update_t_client_ips=2Esh<br>3 files changed, 12 insertions=
(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/56/1756/7</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t=
_client=2Erc-sample b/tests/t_client=2Erc-sample</span><br><span>index 0471=
4ef=2E=2E4c87436 100644</span><br><span>--- a/tests/t_client=2Erc-sample</s=
pan><br><span>+++ b/tests/t_client=2Erc-sample</span><br><span>@@ -18,8 +18=
,8 @@</span><br><span> #FPING_EXTRA_ARGS=3D&quot;-t 1000&quot;</span><br><s=
pan> </span><br><span> # Load EXPECT_IFCONFIG* parameters from cache</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -r &quot;${top_builddir=
}/t_client_ips=2Erc&quot; ]; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    =2E &quot;${top_builddir}/t_client_ips=2Erc&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if [ -r &quot;${t_client_ips_=
rc}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  =2E &quot;${t_client_ips_rc}&quot;</span><br><span> else</span><br><span>=
     echo &quot;NOTICE: missing t_client_ips=2Erc will be auto-generated&qu=
ot;</span><br><span> fi</span><br><span>@@ -67,6 +67,12 @@</span><br><span>=
 # PING6_HOSTS_x      =3D &quot;these hosts musts ping when openvpn is up (=
IPv6 fping6)&quot;</span><br><span> # EXPECT_FAIL_x      =3D &quot;instead =
of waiting for connection wait for this error message&quot;</span><br><span=
> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note that the =
EXPECT_IFCONFIG{4,6} options are not generally required, the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# tests will remember the ip addre=
ss they got on the first run in t_client_ips=2Erc</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# and will expect to get the same address aga=
in=2E But it can be useful to hard-code</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# the IP when the server is expected to send a very spe=
cific address, e=2Eg=2E when</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# using ccd on the server-side or in a P2P scenario=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> # hook test =
options:</span><br><span> #</span><br><span> # FPING_ARGS_x      =3D &quot;=
arguments to append to the fping command line&quot;</span><br><span>diff --=
git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>i=
ndex dd7f743=2E=2E7c23020 100755</span><br><span>--- a/tests/t_client=2Esh=
=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -19=
,6 +19,9 @@</span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br>=
<span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span> =
openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+t_client_ips_rc=3D&quot;$=
{t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+update_t_client_ips=3D&quot;${update=
_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if [ -r &quot;${top_=
builddir}&quot;/t_client=2Erc ]; then</span><br><span>     =2E &quot;${top_=
builddir}&quot;/t_client=2Erc</span><br><span> elif [ -r &quot;${srcdir}&qu=
ot;/t_client=2Erc ]; then</span><br><span>@@ -327,7 +330,7 @@</span><br><sp=
an>     # If EXCEPT_IFCONFIG* variables for this test are missing, run an -=
-up</span><br><span>     # script to generate them dynamically=2E</span><br=
><span>     if [ -z &quot;$expect_ifconfig4&quot; ] || [ -z &quot;$expect_i=
fconfig6&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        up=3D&quot;--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_build=
dir} --script-security 2 --up ${srcdir}/update_t_client_ips=2Esh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        up=3D&quot;--set=
env TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${=
update_t_client_ips}&quot;</span><br><span>     else</span><br><span>      =
   up=3D&quot;&quot;</span><br><span>     fi</span><br><span>diff --git a/t=
ests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh</span><br><s=
pan>index 777a286=2E=2Ef02dc7f 100755</span><br><span>--- a/tests/update_t_=
client_ips=2Esh</span><br><span>+++ b/tests/update_t_client_ips=2Esh</span>=
<br><span>@@ -3,8 +3,6 @@</span><br><span> # This --up script caches the IP=
s handed out by the test VPN server to a file</span><br><span> # for later =
use=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-RC=3D&quot;$TOP_BUILDDIR/t_client_ips=2Erc&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> grep EXPECT_IFCONFIG4_$TE=
STNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; th=
en</span><br><span>     echo &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_lo=
cal&quot; &gt;&gt;$RC</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">change=
 1756</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1756 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Or4GNAraUXU=--


--===============8457062054286177786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8457062054286177786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8457062054286177786==--

