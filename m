Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A759CC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/b3Kt1o0/tc4FMqOipYKXugO276qBf6p7G7XT7DoWWI=; b=b0gZ+U5jhiieXa8eDw7W+0S0LN
	uPwngcHV9HGQNH0A718T7iurg2DrUb5TMbADlSJNhCvEoKNxs7OFwVrQVTHjvj4qgAgJP06eJKg4l
	rirC5uzCpAjEhkNMrZnBq2skHs69EFAbwG0gVA2WoetbFEYATXeQ7dtIG/yIlk9FWcXg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weXx6-0000jx-Ox;
	Tue, 30 Jun 2026 12:52:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weXx3-0000jX-Nt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yTnI6W126pSUkgdS9PwnVY/eJ/HbiPueGUu9BBUfKTA=; b=QkkHoqNO/NSgkygkboGA8/RbIw
 As+sI/txuxUUvFij61Br30c+u8kYlnKDO9QPEtSKxkcdZWo5a85ZFbWU5eNkKdaBHpeB+g6skyESp
 3r+tqBzTGVrY1GrN62kOkdvw5Wcjn3fdPJ9LSuKfXqos+Pl0Zc9Q1ZSMvpFYsN2RLNp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yTnI6W126pSUkgdS9PwnVY/eJ/HbiPueGUu9BBUfKTA=; b=Z
 0uxhfag8wrb2YfrvDa25jrFkWlkSl9q1SSqM413yQs7KVITa5do25eYxL/0g+k8Z2ihsdF6zOTW2q
 68O+PUtVjkrlgqb5NRkKQ3yfhS/mGHxiGCcUT2jy5BgDXTUnFVp1bKgIMbPPHSYZE4XTKypuKLNup
 6JNFOzNigewDpPsk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weXx1-0007WM-TZ for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:52:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so32610765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782823946; x=1783428746; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTnI6W126pSUkgdS9PwnVY/eJ/HbiPueGUu9BBUfKTA=;
 b=gdZ5Ix1dUBrVBrdzXQgQx77ABL9PlrWC6hqbR50qCev84sdITFKViYvuWbOBfdtd4b
 uXwfQ6S9YbycWklYHUsDBoBZ7ir88opHXS0CKzFavajj7sgDEckI4jM/fsKsdNnt7nQk
 yB55bbzOWNQlcPJjODxKjKt2xjd63T+h91HI6XN3X/faWTiTGN8LlQejU/zcNc/pYx3s
 EYzHB24zb+tsYOObgJq1G66k9BsMtA/N2bz+Ms/WtKpvfX9kgDgiXJREQAIHduBG6PEO
 /WMO6WHC+EaX705F7uMNUlAeZEYXR4OeGXxg5qkdReWwpkBggU+/zS2rN+L4VGlsThBD
 oakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823946; x=1783428746;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTnI6W126pSUkgdS9PwnVY/eJ/HbiPueGUu9BBUfKTA=;
 b=TXsypTeJdGg8oN5qGsC/Z/19Dp/cInypeqRpbhqCTwI33AiAwcsZ4pwMhxoGiKxhDt
 cczAiY0Fb78r7Xbj3SMsBSYiq+Sedn3yqsAVc4g5HzX91yqlJWSyc+frZSQc48lHvY5L
 w2pJznZJbpK6fjtbQC849rGEHVok8RmEmqC5n3fy9vGhaD4fvKThLdVX7voRrCZptxm7
 naI6aFw2e+N2kr2vicA23SvqnxYZ57CT/6rEn638R6DC8FpQhKaZvmaVu1ilV+ubQXX2
 GvRs5vHiCPG0/VP9MPFN4nzcOxOWeAHm9zAKI764g3f/UFtntwkj1ciWJlYyzXefN+LC
 0yHA==
X-Gm-Message-State: AOJu0Yy/nEWh2izkmjKd/QmBJZ+GP2+nGBt9fG7SoOEad+hat1r6D7vQ
 hlOyWtUG9gGg+QOsMUro5KXnR1idLNi++d8K6ew6mjf2WNGBlKhTR/CYlF2n+ZfGkxLTasC3XcF
 FuaHQKuIVhdg1HrMkoZePk2kqhMd3DOQ1HyeE/nWKbrDSkC0q94nzJP8aff1FLcBNat8R
X-Gm-Gg: AfdE7cl7JumAofRY2DMrH9FK7JAwrlOeXXnvdqegS/AWpd8HgDiFf2VPP6zUcNt8jSJ
 ot3CLFZyCG6LdqhA5jEU/KExpu+79dUp3wD819j/hrmb+NncihWUc4PDFFLhsqE5OpZn2T0Gp67
 ic1+PIx6AgV4bkoFh2vK9keDjsiX0cgdqn4FArfm/vGWgMbAKRPxF3a+fBtvlkz4pE/11RPFDTO
 Iachlrgy5y7h9RcKL7OTv+pwN9vWWL+6WsU2IALl/nLDdkiGqGkSquRmmaEx91f1JZFTrgdAOQS
 nfkgIwBWaYE5ZhOZhcIv2YZmtmprN025kSoLBjjpu6Fna6Q3Ifs8BncAKkmyX9e13I/Q5yY3zSW
 e/xtXfpjIRAppZebVDbAxWuzE20uBbXb+JJJlPKimQ68+cxldhXZZu5rZVM/sCImVpiVZcKG60f
 W/+v6g9KY3FbmChTAACCSah3Zf1U/PK/gL21M30qnJULoERaYj0aEPFBz3x5VJ7cu7doSeWW+Ei
 l7ydUGxkPTE39df3ZYWpf11eAG2e21qch/+Rw+ysIxjFW2ByKfHH3hTyIw9bA6I1KEow/rndyq7
 7I8=
X-Received: by 2002:a05:600c:4e91:b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-493bc31b46dmr25537625e9.10.1782823945447; 
 Tue, 30 Jun 2026 05:52:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ccc7casm69760225e9.1.2026.06.30.05.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:52:24 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 12:52:22 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
X-Gerrit-Change-Number: 1753
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1753?usp=email>
X-Gerrit-Commit: 850669564c688e89785505e0e0124854a9b96cef
In-Reply-To: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzM3OTgxMDAwLkk3NDZiZDhjMGZhMzQ5NmQyMzU2OWNkZTQ5NjQzOGZjNDE4OTYwMGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb1a033d552c5e9c03628dd4716bd33092f71114-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weXx1-0007WM-TZ
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3715358235305533167=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3715358235305533167==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YqLc/kEBpu8="; charset=UTF-8

--YqLc/kEBpu8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail

to look at the new patch=
 set (#2)=2E

The following approvals got outdated and were removed:
Code-R=
eview+2 by plaisthos


Change subject: t_client=2Esh=2Ein: Use printf inste=
ad of echo -e
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
---
M tests/t_client=2Esh=2Ein
1 file changed, 11 insertions(+), 12 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/53/1753/2

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=
=2Ein
index 48e2446=2E=2Ec3e98a8 100755
--- a/tests/t_client=2Esh=2Ein
+++ =
b/tests/t_client=2Esh=2Ein
@@ -132,21 +132,20 @@
 {
     case $V in
 	0) ou=
tbuf=3D"" ;;			# no per-test output at all
-	1) echo -e "$@"			# compact, d=
etails only on failure
+	1) printf "$@\n"			# compact, details only on fail=
ure
            outbuf=3D"\n" ;;
-	*) echo -e "\n$@\n" ;;		# print all, wit=
h a bit formatting
+	*) printf "\n$@\n" ;;		# print all, with a bit formatt=
ing
     esac
 }
 
 output()
 {
-    NO_NL=3D''; if [ "X$1" =3D "X-n" ] ; t=
hen NO_NL=3D$1 ; shift ; fi
+    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; th=
en END_NL=3D"" ; shift ; fi
     case $V in
 	0) ;;				# no per-test output=
 at all
-	1) outbuf=3D"$outbuf$@" 		# print details only on failure
-	   te=
st -z "$NO_NL" && outbuf=3D"$outbuf\n"
+	1) outbuf=3D"$outbuf$@${END_NL}"	#=
 print details only on failure
            ;;
-	*) echo -e $NO_NL "$@" ;;	#=
 print everything
+	*) printf "$@${END_NL}" ;;	# print everything
     esac=

 }
 
@@ -340,7 +339,7 @@
         else
             output "skip check fai=
led, SKIP test $SUF=2E"
 	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    ech=
o -e "$outbuf" ; continue
+	    printf "$outbuf" ; continue
         fi
   =
  fi
 
@@ -361,7 +360,7 @@
 	fail "make sure that ping hosts are ONLY reach=
able via VPN, SKIP test $SUF=2E"
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	ex=
it_code=3D31
-	echo -e "$outbuf" ; continue
+	printf "$outbuf" ; continue
 =
    fi
 
     pidfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid"
=
@@ -407,7 +406,7 @@
 	trap - 0 1 2 3 15
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SU=
F"
 	exit_code=3D30
-	echo -e "$outbuf" ; continue
+	printf "$outbuf" ; con=
tinue
     fi
 
     # make sure openvpn client is terminated in case shell=
 exits
@@ -470,15 +469,15 @@
 	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
     else
 	=
if [ "$V" -gt 0 ] ; then
-	    echo -e -n "$outbuf"
-	    echo -e "test run=
 $SUF: $fail_count test failures=2E FAIL=2E\n"
+	    printf "$outbuf"
+	   =
 echo "test run $SUF: $fail_count test failures=2E FAIL=2E"
         fi
 	S=
UMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D30
     fi
 
     if [ -n =
"$test_cleanup" ]; then
-        echo -e "cleaning up: '$test_cleanup'"
+  =
      echo "cleaning up: '$test_cleanup'"
         eval $test_cleanup
     =
fi
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I746bd8c0fa3=
496d23569cde496438fc4189600fe
Gerrit-Change-Number: 1753
Gerrit-PatchSet: 2=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--YqLc/kEBpu8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by pl=
aisthos</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">t_client=2Esh=2Ein: Use printf instead of echo -e<=
br><br>In some shells the echo builtin doesn&#39;t interpret -e as<br>an ar=
gument, it just outputs it as a string=2E<br><br>Examples for shells I have=
 observed this with are dash on<br>Ubuntu and /bin/sh on macOS=2E<br><br>Us=
e printf instead which should have better consistency<br>across shells and =
operating systems=2E<br><br>Change-Id: I746bd8c0fa3496d23569cde496438fc4189=
600fe<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>---<br>M tests/t_client=2Esh=2Ein<br>1 file changed, 11 insertions(+), 12=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/53/1753/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_clien=
t=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 48e2446=2E=2Ec=
3e98a8 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><spa=
n>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -132,21 +132,20 @@</spa=
n><br><span> {</span><br><span>     case $V in</span><br><span> 	0) outbuf=
=3D&quot;&quot; ;;			# no per-test output at all</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	1) echo -e &quot;$@&quot;			# compact, details =
only on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	1) =
printf &quot;$@\n&quot;			# compact, details only on failure</span><br><spa=
n>            outbuf=3D&quot;\n&quot; ;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	*) echo -e &quot;\n$@\n&quot; ;;		# print all, with a b=
it formatting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	*) pr=
intf &quot;\n$@\n&quot; ;;		# print all, with a bit formatting</span><br><s=
pan>     esac</span><br><span> }</span><br><span> </span><br><span> output(=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   NO_NL=3D&#39;&#39;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ] ; then NO=
_NL=3D$1 ; shift ; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    END_NL=3D&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ] ;=
 then END_NL=3D&quot;&quot; ; shift ; fi</span><br><span>     case $V in</s=
pan><br><span> 	0) ;;				# no per-test output at all</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@&quot; 		# prin=
t details only on failure</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	   test -z &quot;$NO_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	1) outbuf=3D&quot=
;$outbuf$@${END_NL}&quot;	# print details only on failure</span><br><span> =
           ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) echo=
 -e $NO_NL &quot;$@&quot; ;;	# print everything</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	*) printf &quot;$@${END_NL}&quot; ;;	# print e=
verything</span><br><span>     esac</span><br><span> }</span><br><span> </s=
pan><br><span>@@ -340,7 +339,7 @@</span><br><span>         else</span><br><=
span>             output &quot;skip check failed, SKIP test $SUF=2E&quot;</=
span><br><span> 	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot;$outbuf&quo=
t; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    p=
rintf &quot;$outbuf&quot; ; continue</span><br><span>         fi</span><br>=
<span>     fi</span><br><span> </span><br><span>@@ -361,7 +360,7 @@</span><=
br><span> 	fail &quot;make sure that ping hosts are ONLY reachable via VPN,=
 SKIP test $SUF=2E&quot;</span><br><span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FA=
IL $SUF&quot;</span><br><span> 	exit_code=3D31</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ; continue</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	printf &quot;$outbuf&quot; ; =
continue</span><br><span>     fi</span><br><span> </span><br><span>     pid=
file=3D&quot;${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid&quot;</span><=
br><span>@@ -407,7 +406,7 @@</span><br><span> 	trap - 0 1 2 3 15</span><br>=
<span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exi=
t_code=3D30</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo -e &=
quot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	printf &quot;$outbuf&quot; ; continue</span><br><span>     fi</s=
pan><br><span> </span><br><span>     # make sure openvpn client is terminat=
ed in case shell exits</span><br><span>@@ -470,15 +469,15 @@</span><br><spa=
n> 	SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>     else</sp=
an><br><span> 	if [ &quot;$V&quot; -gt 0 ] ; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	    echo -e -n &quot;$outbuf&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot;test run $SUF:=
 $fail_count test failures=2E FAIL=2E\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	    printf &quot;$outbuf&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	    echo &quot;test run $SUF: $fail_=
count test failures=2E FAIL=2E&quot;</span><br><span>         fi</span><br>=
<span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exi=
t_code=3D30</span><br><span>     fi</span><br><span> </span><br><span>     =
if [ -n &quot;$test_cleanup&quot; ]; then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        echo -e &quot;cleaning up: &#39;$test_cleanup&#=
39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ec=
ho &quot;cleaning up: &#39;$test_cleanup&#39;&quot;</span><br><span>       =
  eval $test_cleanup</span><br><span>     fi</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1753?usp=3Demail">change 1753</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I746bd8c0fa3496d23569cde49=
6438fc4189600fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
753 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--YqLc/kEBpu8=--


--===============3715358235305533167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3715358235305533167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3715358235305533167==--

