Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FE9C56201
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiHNknlVFUQ2tlyXTSdsd6skW9Y6kNSYLV6crVsq0YY=; b=WlBTASJ0U3jXQd2/nl5Zre/ojj
	SQC3rTbTSc4D3xO165KBeZ6kRFZFU/B0dtWEtJPKYlCQXTBzxXFcKkqUBCVbm3VyU6qP3n5Za4FSG
	zNbZ2ntdbsEIa+pc+DCUQDY5ujyRlBYKb6HK5C7Uia0ZPD1eRLMKwaIOJ1hEYbqUbOP8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrZRf-0007Gk-HG;
	Wed, 05 Aug 2026 11:05:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrZRd-0007Gb-W3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UEQEpqmUrDvd4J+HITSdK9pdW1aTyAjrImL7hcypVBQ=; b=Sm6TBb/xj1f0kjChX2b7P28lwp
 0HJyYLuZLIQBOuWsQvGQ2hQl4Iqjw+xltorRTPtSGODy8nxpryiePGQf6lZVh4ZQHHWvTVOeqmOws
 nrgGVonUh6yqzos/v0JTzJpKjM5Za75slR5nkGUiHnxFMDT62Hu/1NphntoZbQS+ngIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UEQEpqmUrDvd4J+HITSdK9pdW1aTyAjrImL7hcypVBQ=; b=D
 LjrM+xDdAhm8Bvl8c+R4p3ZJ06Spkaqz5H1huSrA9FrYlufQMVVuOWsTx9O0MhU8tYdGYmOMTpxXX
 ilLYSY0nSr4RSa9hrdRUFGbNrn5znThFknKMx+YKZEgIhiDEfmOBiPC2akQoV1nEkkngpP2kcLa6w
 vpwUksvbklBgVw9A=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrZRa-0006lp-3M for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:05:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso6107335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785927947; x=1786532747; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UEQEpqmUrDvd4J+HITSdK9pdW1aTyAjrImL7hcypVBQ=;
 b=Dxg95pkkuiWNyuQzFklaE6vcGZdU8SfBjmLyfuPmbpDwDkMeuQoNweIhIfjrPlWMbI
 ENjCZKevSNkHf/JuG4DYKymhbFSnZmsJ9DFMkjLYLHM0KrvWfUnpwOJ1iR1Vx04bh8Yb
 VdZQ2gObBX0Wpn+6YGQQTn6ZA+bj5KnF/3t5uQmaxleeJTs8Wj2GML9is5rHuHMJQFj3
 9M6f1F6/3/g2JReKFutpPHo8yxkictEszrBCfaDQZe86aGCmk6qLcoQOL3nm5GkVc2Zc
 W5oekrvULU7F5PEMLjf/C136xrxHoSgEto9zeIUr/nNBjbCZiMmOOaYaWsDhSgsTxHzV
 wf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785927947; x=1786532747;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UEQEpqmUrDvd4J+HITSdK9pdW1aTyAjrImL7hcypVBQ=;
 b=pEsQWTmojSTLOevWXo0Q5c9H7gdOzNSIFjGfVWZRFFagIgAHIG4EaZ6lfaD3Wnvc2o
 palxAo0VmF7jyXDEBCnJv7NIDheN8tvz2CWLK/T9EDbiLwtTI7ksEBreyppxxivlmHf7
 uGW/rJYLX5DO3ebHaa4iNj37633goOymrU6TO4WHGXzzZ7eg0GdZSe4GFvmwyOzhh6aZ
 bz0yFn2FL+TQsiCeNakL+ezD/FaZhT3n/luweEFRWTDYo5wTK0Cj8e19fgbHRoz4tat1
 xsHxUH/OxMVy2jGu6W3ego+lRd54zDh393r0AXuNzKU3W0kDNRpvnHWDwjaZa0Rnf5k1
 Q1gw==
X-Gm-Message-State: AOJu0YxYmdVdsNx98KMTXuZW82VkCjk8zwouJE2OKr21VSpfh91fOZn1
 J5ymQ9iAbaQfhH5XEACvS8TEt+JmO1NVt/VH+yCKNDngO8Q2UswzQT2pqzOQqvHkvco7hxhRbY3
 7135DcXstPAh7KjCayKRxAFJgY10iKORV9xN6LFkHdMxX45iLwQqBAJDYjZmI6wMrjHNQ
X-Gm-Gg: AR+sD13+VV2JUHs7Iht7cZAyfSOvJqw4rb/QMrjBdfkKEVRZG/0IyjBQw0IXwy0JN5Z
 /qnwcYuP6a/OJLZde6u2iR+2snVt/CQX27D8oHls4LkQLN3qXi/FxL0RnAuHo3HHK7WUOpKbsPh
 //DkhcwO4NQCV+wpnwYpb0XcMMX77sY46aaXurcrXZKOHdGmTo2m++fJNul6KW17l9wNw60ZE0l
 eSIxbKbP91iPgaRRqAef46K52dTQV+XvIqQ9Xcww3E6SfdPRZv3lyl4ZP5w1S9FzPGGOZz/enZM
 v7K0wdDolrtmBhnMJ38Shbzt9H5n3cz6hLdKycDus3HF/BWWc8iO5VZw78Yu6wUO7rRaCVqZWU7
 Iomw+KsNukflEEEc9ayXM3498PmYmOXG86PeG8y5T8Aa/X4aftjCM5G0tvQJNpVsD1pMnQ5KEQx
 pOsBMoOisDcT6Lsrfqbu1FecWv4n4y/6HSB71XFEkZlrst/njEcNS3Wao5k1mYx+J7bpyU5UfY4
 4Jz1SS22riqh/6PhLSRwrude+ogmiS/h2Rc3lGsywlto4t1zbwSvKMIYSv9iv0d8P4guBPSDEpX
 diWrg1ygrKSSIzHwqimsUc8phP/sHH2FhJyfKjlSOO0nf9g9TK0=
X-Received: by 2002:a7b:c408:0:b0:498:ee7:e403 with SMTP id
 5b1f17b1804b1-4994e7db010mr52349405e9.19.1785927947251; 
 Wed, 05 Aug 2026 04:05:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm191657575e9.3.2026.08.05.04.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:05:46 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 11:05:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: e7ba43c8495f1a1d969e81514e690de485360e89
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c932dbd61a9cf4886ff8c76f96c966394f508bdb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrZRa-0006lp-3M
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: reject a pushed
 epoch data format tag with a non-AEAD cipher
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0138884873998565203=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0138884873998565203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eZ6vEyAS3Qw="; charset=UTF-8

--eZ6vEyAS3Qw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1836?usp=3Demail

to look at the new patch set (#=
2)=2E

The following approvals got outdated and were removed:
Code-Review+2=
 by plaisthos


Change subject: ssl: reject a pushed epoch data format tag =
with a non-AEAD cipher
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl: reject a pushed epoch data format tag with a non-AEAD ciphe=
r

The epoch data key format is defined for AEAD ciphers only=2E Both place=
s
that enable it locally verify this - multi=2Ec when picking the cipher to=

push and ssl_ncp=2Ec for p2p NCP - but the pulling side imports the
"aead-=
epoch" protocol flag without validating it against the cipher that
was actu=
ally negotiated=2E

A peer pushing "protocol-flags aead-epoch" together wit=
h a non-AEAD
cipher therefore makes us reach the M_FATAL in init_key_contex=
ts() and
terminate the process=2E This can be triggered whenever a non-AEAD=
 cipher
is part of our own --data-ciphers, which is not unusual in
configur=
ations kept compatible with old peers, e=2Eg=2E

  data-ciphers AES-256-GCM=
:AES-256-CBC

Validate the combination in do_deferred_options(), next to th=
e existing
data v2 check, so that the mismatch is reported as an OPTIONS ER=
ROR and
the connection is restarted=2E Turn the now unreachable M_FATAL in
=
init_key_contexts() into a session error as well, so that no future code
pa=
th can promote this to a process exit=2E

Change-Id: Icc0721fd4a910110507d0=
6b4e941e9e6dbb11e9f
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ec=
om>
---
M src/openvpn/init=2Ec
M src/openvpn/ssl=2Ec
2 files changed, 18 in=
sertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/36/1836/2

diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec
index 0236886=2E=2E84de986 100644
--- a/src/openvpn/init=2Ec=

+++ b/src/openvpn/init=2Ec
@@ -2711,6 +2711,18 @@
         return false;
 =
    }
 
+    /* The epoch data format is defined for AEAD ciphers only=2E A=
 peer may push
+     * the tag along with a non-AEAD cipher, so this has to=
 be checked here
+     * rather than trusted */
+    if (epoch_data && !cip=
her_kt_mode_aead(c->options=2Eciphername))
+    {
+        msg(D_PUSH_ERROR=
S,
+            "OPTIONS ERROR: Epoch key data format tag requires an AEAD =
"
+            "cipher, but '%s' was negotiated=2E",
+            c->option=
s=2Eciphername);
+        return false;
+    }
+
 
     if (found & OPT_P_P=
USH_MTU)
     {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
inde=
x b5ab51e=2E=2E2c7e672 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/s=
sl=2Ec
@@ -1413,10 +1413,14 @@
     {
         if (!cipher_kt_mode_aead(key=
_type->cipher))
         {
-            msg(M_FATAL,
-                "AEAD=
 cipher (currently %s) "
+            /* The pulled options are validated i=
n do_deferred_options(), so
+             * reaching this point means a cod=
e path escaped that check=2E Fail
+             * the session instead of th=
e whole process */
+            msg(D_TLS_ERRORS,
+                "TLS Err=
or: AEAD cipher (currently %s) "
                 "required for epoch data =
format=2E",
                 cipher_kt_name(key_type->cipher));
+          =
  return KEY_GEN_FAILED;
         }
         init_epoch_keys(ks, multi, key=
_type, server, key2);
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1836?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Gerrit-Change-Number:=
 1836
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>=


--eZ6vEyAS3Qw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1836?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">ssl: reject a pushed epoch data format tag with a non-AEAD ciphe=
r<br><br>The epoch data key format is defined for AEAD ciphers only=2E Both=
 places<br>that enable it locally verify this - multi=2Ec when picking the =
cipher to<br>push and ssl_ncp=2Ec for p2p NCP - but the pulling side import=
s the<br>&quot;aead-epoch&quot; protocol flag without validating it against=
 the cipher that<br>was actually negotiated=2E<br><br>A peer pushing &quot;=
protocol-flags aead-epoch&quot; together with a non-AEAD<br>cipher therefor=
e makes us reach the M_FATAL in init_key_contexts() and<br>terminate the pr=
ocess=2E This can be triggered whenever a non-AEAD cipher<br>is part of our=
 own --data-ciphers, which is not unusual in<br>configurations kept compati=
ble with old peers, e=2Eg=2E<br><br>  data-ciphers AES-256-GCM:AES-256-CBC<=
br><br>Validate the combination in do_deferred_options(), next to the exist=
ing<br>data v2 check, so that the mismatch is reported as an OPTIONS ERROR =
and<br>the connection is restarted=2E Turn the now unreachable M_FATAL in<b=
r>init_key_contexts() into a session error as well, so that no future code<=
br>path can promote this to a process exit=2E<br><br>Change-Id: Icc0721fd4a=
910110507d06b4e941e9e6dbb11e9f<br>Signed-off-by: Antonio Quartulli &lt;anto=
nio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/s=
sl=2Ec<br>2 files changed, 18 insertions(+), 2 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/36/1836/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c</span><br><span>index 0236886=2E=2E84de986 100644</span><br><span>--- a/s=
rc/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><s=
pan>@@ -2711,6 +2711,18 @@</span><br><span>         return false;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* The epoch data format is defined for AEAD ciphers only=
=2E A peer may push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * the tag along with a non-AEAD cipher, so this has to be checked here=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * rather than =
trusted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e=
poch_data &amp;&amp; !cipher_kt_mode_aead(c-&gt;options=2Eciphername))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;OPTIONS ERROR=
: Epoch key data format tag requires an AEAD &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;cipher, but &#39;%s&#39=
; was negotiated=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            c-&gt;options=2Eciphername);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> </span><br><span>     if (found &amp; OPT=
_P_PUSH_MTU)</span><br><span>     {</span><br><span>diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index b5ab51e=2E=2E2c7e672 =
100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/=
openvpn/ssl=2Ec</span><br><span>@@ -1413,10 +1413,14 @@</span><br><span>   =
  {</span><br><span>         if (!cipher_kt_mode_aead(key_type-&gt;cipher))=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &quot;AEAD cipher (currently %s) &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* The pulled opti=
ons are validated in do_deferred_options(), so</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             * reaching this point means a code =
path escaped that check=2E Fail</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * the session instead of the whole process */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ER=
RORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &quot;TLS Error: AEAD cipher (currently %s) &quot;</span><br><span>      =
           &quot;required for epoch data format=2E&quot;,</span><br><span> =
                cipher_kt_name(key_type-&gt;cipher));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return KEY_GEN_FAILED;</span>=
<br><span>         }</span><br><span>         init_epoch_keys(ks, multi, ke=
y_type, server, key2);</span><br><span>     }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1836?usp=3Demail">change 1836</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1836?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1836 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>

</body></html>
--eZ6vEyAS3Qw=--


--===============0138884873998565203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0138884873998565203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0138884873998565203==--

