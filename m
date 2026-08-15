Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB6BC5DF70
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8m3K5d+d9MOuG1Fh775dULXOqbw5912q/iE+90z5No=; b=Mb+ep3SQMSPBd94YLsI0kNoI8N
	cFj1KfHE2bfDsy/9Q4mCSjmldVK19F2SPN8YoVc5JjCOQ/ml94D7GhN9p6eLOF2mPp9oGPE2rDdkR
	kyAnA19ij3sXiEgZxG0yP1qi8dHgLArrURQ1pUaBorQ/CVw/Abyz3p017zRHXLKtxGSY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKV2-0005Rd-Pm;
	Sat, 15 Aug 2026 19:57:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKUl-0005RK-J0
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o8JHYnEXeFpJzCSxerwBXJyri+2ULy2Gzl99M4yI89k=; b=mvwGDr2TJe0c4dgE7QxklTxDUW
 Y3K89qQmmPzMNNWVwSzD8/zWX5BTG5rFXUj6+SFEaYvVuiLHwxsE0g3VQfZM8w4BUjhluTliu/38A
 7+h/c/su9q45m4FT4266+jlJ+fzOw7dnvFT/52mPmx6OmivoOAInnkq5v9d6nN7yJxYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o8JHYnEXeFpJzCSxerwBXJyri+2ULy2Gzl99M4yI89k=; b=O
 369aDIgtESWgrKowyhoKIO/B6vbXUnGR/orqG+v/O3psrSSCc2dSHK4L3LLbJIZQrdRktKQ9HoXCP
 J/pCF24yxUn4shU67kg0UaPf14VHKGcIjBlnTvugadDrl5g/SZmL1DdfOv5mot0mfE6p6oU/ip9NH
 G2k6WwK3C6KHVDhM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKUn-0002pD-UW for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:43 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495437bb891so17328445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786823796; x=1787428596; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o8JHYnEXeFpJzCSxerwBXJyri+2ULy2Gzl99M4yI89k=;
 b=Ue+tGUj2V75mrjXmV++zyw43IodRVlA89Kq3xAuoDRbBwlx6MrYxWodyzLI1jjBhy3
 x/Oc7x1In48A4l9SerB1lVtYUF9nmTE1ZukaH9qG3ZzepQmHRM+BQ6XvZOL6cqSOSyoK
 1H1pG9gCmVXCEsK4/gh8uVygTy2YfCL+ojbpdVFcYbZBZXFE+41gidESU6WI4XihLtCg
 7uz1WETTEwNHhqMDFz0pgI8Y+M6tECK5dmM/hN4mWGNuR3KAvgAuLXerwqAMNtst08OW
 8f8bkfhezEiLLCK0Y2skReN4HvCn8+hkz3YZZaB3hGKGf+sLp/Lryi3LhWvxB94/38YV
 7tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823796; x=1787428596;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o8JHYnEXeFpJzCSxerwBXJyri+2ULy2Gzl99M4yI89k=;
 b=Oq9wfAWlzi8feHlIPdVxJM+rdLz+UxyGmnQXsFXeWorlTmrrBVTgyaKo5WnfRCI6zJ
 BBzRJnDjnAY7GrhaAB6xmDZv1wRyxKH86EyAGnsJwsvTk6WpkfjMGGXf7HNM+Vo1rULI
 T7ukKmHIapBkwl/flclxQYYtWREMVdUHqY/gflk8N2Yz1cbK9VYl2m0ePWWrxT6dWxHl
 nkC3F/sP6kOXHvp9+MG/RZIGqPuTc2minECUlCz4CvEJaMHgszH2JlcMWwGnDMyWx/cR
 rXIU831JWc/hsaJ3rvQtkk5IfPQrfETCbekR2M1qIk8J8Epktepe7D2vPQH4l67q9QRK
 HVIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXVqMMVIw1gAiUYo6Dtt1RtS9QuPs0ghRP5xvX+Z+M5rOF4SOVn9rjdlVyI/XP4+ROOKfVJRU/sC9xOmH+@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxyjj0LBm0LAcd28pIHL3CcetoP4SlDy4Mi+XBS4liVOFca13iz
 DKxaFOneJsydQ8qH0dCofjmwzOC0KxNL28tzf5Rtmms52KMFEL7FHsJijqYGr3/IGRvrK5+mqzh
 DPh/Y2rhjzOwA9S2UXRhgyz7+cmABuyZsm9wy9AguuAjQrrnd3U/lcKDtodiXuXhV19zpZLfCID
 UXn9PN2w==
X-Gm-Gg: AR+sD12xCtMawI9VEDkJmXCd6N9mI6sdr4vw63Y2hJeeGkIWR8KLzP6/Fw7PGcz35iv
 84XgEfdRuYkh+xin/mMSSvK6xiZPvbPo8U21ISHR1xFYYdcFlFe909SotX3obwEMNdvUhlUsIaT
 J12kStez4FHXU1E1D57H6ArdeUWUObf77M/9xLTy1MUacm1MBcWfNIIXD+ykxjOi8MuyFeZABC4
 UTN8hQAfkw42+D8cEHZ/Z8ZdPXR3HgeTrI3nCOzPfuHJMvvswlF6EpY4g2LfXljCGrDLiuzJZ4O
 MwTepVfwrTpeZDcy/a10YiGOKdAQY2xOQQZ9bZNpZFFe7r0mzEZmG0QFgFlUsaKai3RR15f9fTY
 guJiQaHrYiVReqSxmGdURxtZ9vRGVfxOVShPtZTb2vcYSBR1URY14452rk7VlU5MQevZLA3uMTv
 DbDV/dyzfRyo3GYYJt4qsEgzSzVqppsG+Db3xKragVNJFdMoXzkBhgego4ye5B846qNHUSVE/ef
 qLe8As8TV3Nyrwq5bl3RWQo3A3tnPZuV+rkYO97eQJLl+daMOXe4FyOuT5TZleUJQ4TJoN8ufpP
 fPmh95jqxdYSHriVI1scxRT/sZna5ahVjJxN3KLOq/WrNMhDCQk=
X-Received: by 2002:a05:600c:828f:b0:499:90d0:4906 with SMTP id
 5b1f17b1804b1-49990d05134mr74748325e9.5.1786823795861; 
 Sat, 15 Aug 2026 12:56:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998ca63e5csm46464945e9.2.2026.08.15.12.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:56:35 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 19:56:34 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
X-Gerrit-Change-Number: 1562
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1562?usp=email>
X-Gerrit-Commit: 6f772b55f5ae4933b115b3e0cdd25e3c6718404c
In-Reply-To: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
References: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMDczNzUzMDAwLkllMGI5NGI1OTY2MzdkNjYwMzkyYmM0ZWRhNDhkMTZjZmVjZmViOTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3c911197028a429f070cb2783a94eb04a62da635-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKUn-0002pD-UW
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Avoid
 sign-compare warnings
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6629002217114368304=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6629002217114368304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yHLWao9zD88="; charset=UTF-8

--yHLWao9zD88=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1562?usp=3Demail )

Change subject: init: Avoid sign-compare warnings
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Avoid s=
ign-compare warnings

- Use BLENZ instead of buf_len where applicable
- Fix=
 some comparisons with ce list length

Change-Id: Ie0b94b596637d660392bc4ed=
a48d16cfecfeb971
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1562
Message-Id: <20260815130856=2E20431-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38407=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 6 insertio=
ns(+), 16 deletions(-)




diff --git a/src/openvpn/init=2Ec b/src/openvpn/=
init=2Ec
index b8732dd=2E=2Ea90fe69 100644
--- a/src/openvpn/init=2Ec
+++ b=
/src/openvpn/init=2Ec
@@ -326,11 +326,6 @@
     return l->len;
 }
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma=
 GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 management=
_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
 {=

@@ -341,7 +336,7 @@
     struct connection_list *l =3D c->options=2Econnec=
tion_list;
     bool ret =3D true;
 
-    if (index < l->len)
+    if (l->l=
en > 0 && index < (unsigned int)l->len)
     {
         struct connection_e=
ntry *ce =3D l->array[index];
         const char *proto =3D proto2ascii(ce=
->proto, ce->af, false);
@@ -365,10 +360,6 @@
     return ret;
 }
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-=

 static bool
 management_callback_remote_cmd(void *arg, const char **p)
 {=

@@ -467,7 +458,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma =
GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma=
 GCC diagnostic ignored "-Wsign-compare"
 #endif
 
 /*
@@ -639,8 +629,8 @@
=
     } while (!ce_defined);
 
     /* Check if this connection attempt woul=
d bring us over the limit */
-    if (c->options=2Econnect_retry_max > 0
- =
       && c->options=2Eunsuccessful_attempts > (l->len * c->options=2Econne=
ct_retry_max))
+    int max_attempts =3D l->len * c->options=2Econnect_retr=
y_max;
+    if (max_attempts > 0 && c->options=2Eunsuccessful_attempts > (u=
nsigned int)max_attempts)
     {
         msg(M_FATAL, "All connections hav=
e been connect-retry-max (%d) times unsuccessful, exiting",
             c-=
>options=2Econnect_retry_max);
@@ -2167,7 +2157,7 @@
 static void
 add_deli=
m_if_non_empty(struct buffer *buf, const char *header)
 {
-    if (buf_len(=
buf) > strlen(header))
+    if (BLENZ(buf) > strlen(header))
     {
       =
  buf_printf(buf, ", ");
     }
@@ -2256,7 +2246,7 @@
         buf_printf(&=
out, "session-timeout %d", o->session_timeout);
     }
 
-    if (buf_len(&=
out) > strlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
      =
   msg(D_HANDSHAKE, "%s", BSTR(&out));
     }
@@ -2293,7 +2283,7 @@
       =
  }
     }
 
-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) =
> strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     =
}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0b94b596637d660392=
bc4eda48d16cfecfeb971
Gerrit-Change-Number: 1562
Gerrit-PatchSet: 9
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--yHLWao9zD88=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1562?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">init: Avoid sign-compare warnings<br><br>-=
 Use BLENZ instead of buf_len where applicable<br>- Fix some comparisons wi=
th ce list length<br><br>Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb9=
71<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562<br>Message-Id: &lt;2026081513085=
6=2E20431-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38407=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
init=2Ec<br>1 file changed, 6 insertions(+), 16 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span=
>index b8732dd=2E=2Ea90fe69 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -326,11 =
+326,6 @@</span><br><span>     return l-&gt;len;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><=
br><span> management_callback_remote_entry_get(void *arg, unsigned int inde=
x, char **remote)</span><br><span> {</span><br><span>@@ -341,7 +336,7 @@</s=
pan><br><span>     struct connection_list *l =3D c-&gt;options=2Econnection=
_list;</span><br><span>     bool ret =3D true;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (index &lt; l-&gt;len)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;len &gt;=
 0 &amp;&amp; index &lt; (unsigned int)l-&gt;len)</span><br><span>     {</s=
pan><br><span>         struct connection_entry *ce =3D l-&gt;array[index];<=
/span><br><span>         const char *proto =3D proto2ascii(ce-&gt;proto, ce=
-&gt;af, false);</span><br><span>@@ -365,10 +360,6 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span>=
<br><span> management_callback_remote_cmd(void *arg, const char **p)</span>=
<br><span> {</span><br><span>@@ -467,7 +458,6 @@</span><br><span> #if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic =
push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wsign-compare&quot;</span><br><span> #endif</span><br><s=
pan> </span><br><span> /*</span><br><span>@@ -639,8 +629,8 @@</span><br><sp=
an>     } while (!ce_defined);</span><br><span> </span><br><span>     /* Ch=
eck if this connection attempt would bring us over the limit */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Econnect_r=
etry_max &gt; 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  &amp;&amp; c-&gt;options=2Eunsuccessful_attempts &gt; (l-&gt;len * c-&gt;=
options=2Econnect_retry_max))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int max_attempts =3D l-&gt;len * c-&gt;options=2Econnect_retr=
y_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (max_a=
ttempts &gt; 0 &amp;&amp; c-&gt;options=2Eunsuccessful_attempts &gt; (unsig=
ned int)max_attempts)</span><br><span>     {</span><br><span>         msg(M=
_FATAL, &quot;All connections have been connect-retry-max (%d) times unsucc=
essful, exiting&quot;,</span><br><span>             c-&gt;options=2Econnect=
_retry_max);</span><br><span>@@ -2167,7 +2157,7 @@</span><br><span> static =
void</span><br><span> add_delim_if_non_empty(struct buffer *buf, const char=
 *header)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (buf_len(buf) &gt; strlen(header))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &gt; strlen(header))</span>=
<br><span>     {</span><br><span>         buf_printf(buf, &quot;, &quot;);<=
/span><br><span>     }</span><br><span>@@ -2256,7 +2246,7 @@</span><br><spa=
n>         buf_printf(&amp;out, &quot;session-timeout %d&quot;, o-&gt;sessi=
on_timeout);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (buf_len(&amp;out) &gt; strlen(heade=
r))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&a=
mp;out) &gt; strlen(header))</span><br><span>     {</span><br><span>       =
  msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>     }<=
/span><br><span>@@ -2293,7 +2283,7 @@</span><br><span>         }</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (buf_len(&amp;out) &gt; strlen(header))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&amp;out) &gt; strlen(hea=
der))</span><br><span>     {</span><br><span>         msg(D_HANDSHAKE, &quo=
t;%s&quot;, BSTR(&amp;out));</span><br><span>     }</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1562?usp=3Demail">change 1562</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1562?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1562 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--yHLWao9zD88=--


--===============6629002217114368304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6629002217114368304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6629002217114368304==--

