Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC7C5AE49
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lM6FU/3L3Uz89DRUCU3JADEiogKtsxC08puCEoh2osY=; b=nDTE97HYlPE112Y5Vayqqz1Hj3
	3b/gbhsM7WleWwVH38CGVSJdj6OIuvzg8scNnl3wTk3EWnJQZWcoJ4fXUf0MxoF2IAEF2MSTc9WGe
	tVKP+H7EfY3ixW2VyfuozWYftO8tyAfjchkY8haRz7VsJ0QTXC/OMXCmjV7IVnfEuvPY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPpa-0007kJ-KM;
	Mon, 10 Aug 2026 13:14:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtPpZ-0007kC-9W
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AbhaHoflKyQ64U7E43DE7j4NF4JZPdw4CIqRXDaTdY0=; b=m0uJt16xVT4CqDjNpJ9Wii/NoS
 PPx4ZKdxKrDFDP/Gbc2HCugAPuGzJC73BevACl90XbBr+LbUaYHe/pgxOFnaYq9m3hsN+rdoBuBlW
 gujSnTtl/skeo60r0G2TsjUSLrfSYffwNfkZN5brRI71raVx0CwynF1s6EWQllnCRJyY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AbhaHoflKyQ64U7E43DE7j4NF4JZPdw4CIqRXDaTdY0=; b=E
 f/feCdGvIF8dsIrO7H5uCnIDsz1KKqp1bn1jlyf9I3vl+6X4kYUOAWMitViWSg5cOnxihlK9CmWUw
 ZjsNc9/TvphvXa8tByL0DgpgSagBF8SSKtPueVlk0uv1V4kPV395hQ9VYbRlBNgSw7pCl2N7DuVeD
 GYXuHw4tQ3xfJc+8=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtPpZ-0004R0-KE for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:14:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso7922935e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786367647; x=1786972447; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AbhaHoflKyQ64U7E43DE7j4NF4JZPdw4CIqRXDaTdY0=;
 b=VhdSaq5u84GAz8XoKGbNa9Q2yOWL5s62d67VV/XC/IoW7J47dxT1NLRQlhy52mqGWC
 y+H/i/k7t3H9B+t8EtVZ5PSDGVp8FzjGezV1SEGADdhpWAzYGXJbSqImpDQXDPAHRFrr
 Y49aN1PQZ9Y5sGUbNL+umROLGTdthpx++AgL1x23swTszXpVL8s6YsKhoEbFhwurwC/5
 Px0LBrSnVfioEgVimLsO0YdoOKbD93ez/DDGAsicmKoaDetSuHVJKbuHjnXax6b/xViw
 MAa883VD1TTaHUpu3caVuG7yBtxNt6AXN0o9tnB0bD5O4dyc58rnxQeq/aednhV6/uFN
 7EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786367647; x=1786972447;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AbhaHoflKyQ64U7E43DE7j4NF4JZPdw4CIqRXDaTdY0=;
 b=RtRS8kiFMGX5LCgbHIovnF7WxuSTckgukzHSuZjSpoRvclzcFLmYKP2vBmX/ECJSEF
 ckhyZK86mO3QAb1FHpRjzt5jyf5ONuCuhiqlf7OFFmDRRD8y/xdXSqNjSgOjx/GrKE8o
 fioiklQmYWyjpfzTjqRsDwLzB8WYWm8BzATgdqcgGjdzEFXkQU3UAqM4lV+iFKu47aFF
 X4RkQZX5MeVY57+rQ0GfdMXJImiWLONvw7AhUvFi5wLYxCFUbcN43LL89CrQG8kbIWWm
 SlbWxOuNjQ/EO4QsP/I5syl+4Vr7Gzb7WJl3ZzMxg5nQbDUevDe8zgwjNdqcAy1cy8q+
 iwUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCSgQ9hcTuxEwwwzAj+NJR1x8tWi1YathI1EAoNGUJM1sHCnh++PqrQJ+BLnes4MNwoY/d2YgtKm49+mT5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyUIrz6otmaqTvn6LffhCI1S6ttqcIwIRczOZIjBKaGygx8BUVs
 x5x1pdtDkYFzLCV8HA3cKDuT13RjvBudAym+kx9u+Cl0QfsLbbGL84TGXQx+0+zzXTxABg9EvbS
 HINwVCk/gaKTuIjFerO2zwFBOCN2Ys4rzqiw65RRq0o6VP4em42zJGQotx7xr+o0KhhQj
X-Gm-Gg: AR+sD10KwoqtqsSajijuAitXGnDBkUVA1ae1ZT9xNCNkXiKFN2sroe5ch4aiv69qeAu
 +7yXvD3AchlKFppBlu59JHGusKcD8Xz0E49bUmAntXKMXo3i7BjGm4VCHOk+ryio2qLUSwhpdUA
 vQ2+Ka7xEOkNYBiWVWYLAy/MbC8zXkb0lsd3yjR+BR6wNsH7MV/9igH9A1tAJ4pivR91u2n5QFp
 1jAvJka1NaT3sX0Giuan/2bRhExzAYHbjYoT5QGezlDLvYPSBkNzfiEqBhVgoy+3/1KY81UZdJ7
 72cifaxoS4/jqORU8RKA9KZYJfwHTHXEZSBPvwv5r6jHFgL3a8Muu5n8CSASWr4bjXSS7eIEwCb
 gcaBXv8OwUSJANM3BXAmhStACNgjdI3KKiNDGXCRhZuICC7wQWLtkasamNYJlTT/pi8vamqubuf
 TfCRrWUdB6pK8ng52boJQT/kBgfpWDPQ922j0AKI1qP8yrQ43Vnbw08O8eh7D5NYydPWiixnfJk
 4pOZST4uEwOMRnog95dT6lUwcT+6caUCH6ewgpE17MeJmAi7mUL3zBU7LJclDfT8Dy0moTZNyKr
 WIZRn3m00eNIENk2/yuwoA+ihbpoBX3VrTt/XX4rIPjlSxKm5l8htTem3OrXaw==
X-Received: by 2002:a05:600c:4e12:b0:499:61bb:6c78 with SMTP id
 5b1f17b1804b1-49961bb71abmr275203225e9.14.1786367647268; 
 Mon, 10 Aug 2026 06:14:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995dee21dcsm303836555e9.0.2026.08.10.06.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 06:14:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 13:14:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
X-Gerrit-Change-Number: 1753
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1753?usp=email>
X-Gerrit-Commit: da1b2a7081eb2791f3a675945c42d7f3189ef752
In-Reply-To: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzM3OTgxMDAwLkk3NDZiZDhjMGZhMzQ5NmQyMzU2OWNkZTQ5NjQzOGZjNDE4OTYwMGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ca7f0407ede99b53907e9cf5a838a88cea8f649-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtPpZ-0004R0-KE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Use
 printf instead of echo -e
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6953154510134778718=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6953154510134778718==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2cwuFpDqsFU="; charset=UTF-8

--2cwuFpDqsFU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1753?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Use printf inst=
ead of echo -e
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


t_client=2Esh=2Ein: Use printf instead of echo -e

In some shells the ech=
o builtin doesn't interpret -e as
an argument, it just outputs it as a stri=
ng=2E

Examples for shells I have observed this with are dash on
Ubuntu and=
 /bin/sh on macOS=2E

Use printf instead which should have better consisten=
cy
across shells and operating systems=2E

Change-Id: I746bd8c0fa3496d23569=
cde496438fc4189600fe
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753
Message-Id=
: <20260809153046=2E14738-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38258=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Es=
h=2Ein
1 file changed, 11 insertions(+), 12 deletions(-)




diff --git a/t=
ests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 7233187=2E=2E0254c=
0c3 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@=
 -132,21 +132,20 @@
 {
     case $V in
 	0) outbuf=3D"" ;;			# no per-test =
output at all
-	1) echo -e "$@"			# compact, details only on failure
+	1) p=
rintf "$@\n"			# compact, details only on failure
            outbuf=3D"\n"=
 ;;
-	*) echo -e "\n$@\n" ;;		# print all, with a bit formatting
+	*) print=
f "\n$@\n" ;;		# print all, with a bit formatting
     esac
 }
 
 output()
=
 {
-    NO_NL=3D''; if [ "X$1" =3D "X-n" ] ; then NO_NL=3D$1 ; shift ; fi
+=
    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; then END_NL=3D"" ; shift ; fi
 =
    case $V in
 	0) ;;				# no per-test output at all
-	1) outbuf=3D"$outbu=
f$@" 		# print details only on failure
-	   test -z "$NO_NL" && outbuf=3D"$=
outbuf\n"
+	1) outbuf=3D"$outbuf$@${END_NL}"	# print details only on failur=
e
            ;;
-	*) echo -e $NO_NL "$@" ;;	# print everything
+	*) printf=
 "$@${END_NL}" ;;	# print everything
     esac
 }
 
@@ -340,7 +339,7 @@
   =
      else
             output "skip check failed, SKIP test $SUF=2E"
 	   =
 SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    echo -e "$outbuf" ; continue
+	 =
   printf "$outbuf" ; continue
         fi
     fi
 
@@ -361,7 +360,7 @@
 	=
fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=
=2E"
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D31
-	echo -e "$out=
buf" ; continue
+	printf "$outbuf" ; continue
     fi
 
     pidfile=3D"${t=
op_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid"
@@ -407,7 +406,7 @@
 	trap -=
 0 1 2 3 15
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D30
-	echo -=
e "$outbuf" ; continue
+	printf "$outbuf" ; continue
     fi
 
     # make =
sure openvpn client is terminated in case shell exits
@@ -470,15 +469,15 @@=

 	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
     else
 	if [ "$V" -gt 0 ] ; then
-	 =
   echo -e -n "$outbuf"
-	    echo -e "test run $SUF: $fail_count test fail=
ures=2E FAIL=2E\n"
+	    printf "$outbuf"
+	    echo "test run $SUF: $fail_=
count test failures=2E FAIL=2E"
         fi
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL=
 $SUF"
 	exit_code=3D30
     fi
 
     if [ -n "$test_cleanup" ]; then
-   =
     echo -e "cleaning up: '$test_cleanup'"
+        echo "cleaning up: '$t=
est_cleanup'"
         eval $test_cleanup
     fi
 

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
Ger=
rit-Change-Number: 1753
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--2cwuFpDqsFU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1753?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Use printf instead of =
echo -e<br><br>In some shells the echo builtin doesn&#39;t interpret -e as<=
br>an argument, it just outputs it as a string=2E<br><br>Examples for shell=
s I have observed this with are dash on<br>Ubuntu and /bin/sh on macOS=2E<b=
r><br>Use printf instead which should have better consistency<br>across she=
lls and operating systems=2E<br><br>Change-Id: I746bd8c0fa3496d23569cde4964=
38fc4189600fe<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753<br>Me=
ssage-Id: &lt;20260809153046=2E14738-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g38258=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file changed, 11 insertions(+),=
 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein</span><br><span>index 7233187=2E=2E0254c0c3 100755<=
/span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/=
t_client=2Esh=2Ein</span><br><span>@@ -132,21 +132,20 @@</span><br><span> {=
</span><br><span>     case $V in</span><br><span> 	0) outbuf=3D&quot;&quot;=
 ;;			# no per-test output at all</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	1) echo -e &quot;$@&quot;			# compact, details only on failure=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	1) printf &quot;$@=
\n&quot;			# compact, details only on failure</span><br><span>            o=
utbuf=3D&quot;\n&quot; ;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	*) echo -e &quot;\n$@\n&quot; ;;		# print all, with a bit formatting</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	*) printf &quot;\n$@=
\n&quot; ;;		# print all, with a bit formatting</span><br><span>     esac</=
span><br><span> }</span><br><span> </span><br><span> output()</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NO_NL=3D&#39=
;&#39;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ] ; then NO_NL=3D$1 ; shif=
t ; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    END_NL=3D=
&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ] ; then END_NL=3D=
&quot;&quot; ; shift ; fi</span><br><span>     case $V in</span><br><span> =
	0) ;;				# no per-test output at all</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@&quot; 		# print details only o=
n failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   test -z =
&quot;$NO_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	1) outbuf=3D&quot;$outbuf$@${END_=
NL}&quot;	# print details only on failure</span><br><span>            ;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) echo -e $NO_NL &quot=
;$@&quot; ;;	# print everything</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	*) printf &quot;$@${END_NL}&quot; ;;	# print everything</span>=
<br><span>     esac</span><br><span> }</span><br><span> </span><br><span>@@=
 -340,7 +339,7 @@</span><br><span>         else</span><br><span>           =
  output &quot;skip check failed, SKIP test $SUF=2E&quot;</span><br><span> =
	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	    echo -e &quot;$outbuf&quot; ; continue</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	    printf &quot;$out=
buf&quot; ; continue</span><br><span>         fi</span><br><span>     fi</s=
pan><br><span> </span><br><span>@@ -361,7 +360,7 @@</span><br><span> 	fail =
&quot;make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=
=2E&quot;</span><br><span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</=
span><br><span> 	exit_code=3D31</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	echo -e &quot;$outbuf&quot; ; continue</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	printf &quot;$outbuf&quot; ; continue</span>=
<br><span>     fi</span><br><span> </span><br><span>     pidfile=3D&quot;${=
top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid&quot;</span><br><span>@@ -40=
7,7 +406,7 @@</span><br><span> 	trap - 0 1 2 3 15</span><br><span> 	SUMMARY=
_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exit_code=3D30</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&qu=
ot; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	prin=
tf &quot;$outbuf&quot; ; continue</span><br><span>     fi</span><br><span> =
</span><br><span>     # make sure openvpn client is terminated in case shel=
l exits</span><br><span>@@ -470,15 +469,15 @@</span><br><span> 	SUMMARY_OK=
=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>     else</span><br><span> =
	if [ &quot;$V&quot; -gt 0 ] ; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	    echo -e -n &quot;$outbuf&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	    echo -e &quot;test run $SUF: $fail_count t=
est failures=2E FAIL=2E\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	    printf &quot;$outbuf&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	    echo &quot;test run $SUF: $fail_count test fai=
lures=2E FAIL=2E&quot;</span><br><span>         fi</span><br><span> 	SUMMAR=
Y_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exit_code=3D30</s=
pan><br><span>     fi</span><br><span> </span><br><span>     if [ -n &quot;=
$test_cleanup&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        echo -e &quot;cleaning up: &#39;$test_cleanup&#39;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;clean=
ing up: &#39;$test_cleanup&#39;&quot;</span><br><span>         eval $test_c=
leanup</span><br><span>     fi</span><br><span> </span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1753?usp=3Demail">change 1753</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1753?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1753 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--2cwuFpDqsFU=--


--===============6953154510134778718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6953154510134778718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6953154510134778718==--

