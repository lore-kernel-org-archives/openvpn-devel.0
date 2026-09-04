Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DE9C79F80
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0b4Tnp1RcSbG/C+8esPnSYjr6LQ5D6MQ/ix7GUYJK6U=; b=MTmVZ9Q3TSbsBF4wEtxo7Oyv2Y
	3VeP7UpWthSU/QzBSI0TY7k6VkhS2ZAWTvNc6KVjeJ1EaheOw54VczbRXihPrFDwF+xZyVFd57lqB
	Uf7TFIeucOhL4JMsrhq9KIf4XXk9wRcP62bmlxKoOtoUluuEyq6xOjyq8Z6SlM59EESk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2PJE-0003yE-FW;
	Fri, 04 Sep 2026 08:30:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2PIo-0003uS-It
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 08:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=R2CR5PK8jrVj1JXsbZdMoK6fdIC3SQkGe8KSU32BFoU=; b=a+Eek9jmkLFd16OF3VkMONpjST
 zq/GVEx7Q/YkgWqvu7LMlij8KwlSWFOz+UIYx2JUltnONxirI5GjlaAuJZRPJLjeLOneJy2IcU7tN
 AFE04gnV52PYi4yfzWS0AQKaq14O/J2ll4PFqIvGElO3flLsYL2hxUWrb8x/k9fUnnVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R2CR5PK8jrVj1JXsbZdMoK6fdIC3SQkGe8KSU32BFoU=; b=R
 qqj5K99yaHYSeK8crZazw0Mc5lxThb2Q53HQKvRdyXy8Hj5rI10KezaIADYnv+HzMbPqIEpuAvPMg
 /lfCbm4tLolnMu0LJEmfy5afy+yMsg7Yoauf0rO96u+c2oz9NYxNFcyhMaw5ubNkw8sDBq5elKiRv
 23y1qdenEzeJPSb0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2PIk-0005P2-32 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 08:29:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49cdc81f40eso4883825e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788510567; x=1789115367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R2CR5PK8jrVj1JXsbZdMoK6fdIC3SQkGe8KSU32BFoU=;
 b=Fit8vtuBiKmlfX9EKK7bk1WrQezZFe7gm82Q0S8gB6657XH559sMnP1eEaFCtajKRU
 zKSqQKVriRhaIyDjp4USUq8TtICHnkFc1Z4vsiqGf061IbWnhbikDyarCq38Uoth9MiB
 y4uKBwZX9LOP0G1Ju3sI8lT6s/cl8e40j1iA4Pxiq+zie9y4JJN4cxWUqFpKZQQFmebI
 POCCRw7xeaVpx3L9NopD7vajyIioWBtfoWszttjAVMnqxV0vxhosy41sSSVb0TbwI/Rc
 9zdt74HRhAVRlGN0/7AhhycchuijCt8Om1R1xlFqlHX3S2KpMveSe/X/sGp0VJlcWOZH
 Y16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788510567; x=1789115367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=R2CR5PK8jrVj1JXsbZdMoK6fdIC3SQkGe8KSU32BFoU=;
 b=rIzfwtriKWoBJlh4EEAU+JCe28Fk8DFHZNvd1Qmhb5NVwX8gxf0csBALL6NcQ0A1iu
 Hb76qW9nzrM7JPrCCSezStoiVL3sgHQ0tWFjh/1PYVXpowAeTO49zP1Qg9BpRTAhq1Oq
 UP/8TrpvqeL/4oNFa8X4fjYIHsqPwBadaDDOorAgU0RUAMGahd8ykHkYbmAvqNyJ/W0y
 4P1CT/YUXAo8/ctfTSROgDk1ldNny4TPwUupCjAKftoddTdekE4Iegbt6bizwLy3dpnq
 1B/c5gRN/fWic4o+llgJyxVFUpDlRDz4tmdUSF1NCBWP3+aTRLLz4TAPnEb6n1cPXX6n
 zsqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLSioWmcNGN6MmPBU2JxMwsLONqKXMUHpI6XJsBjDTmGdqnYKf6YxFCY/PrSIPeOQy+yjCHaUy5CJpFFKU@lists.sourceforge.net
X-Gm-Message-State: AFuF++mZ9FOXj4/ASzVlf7YjHmo6v+TVksT0PRo1Z0Z1BeuBdLpRtueP
 ZEOiVFLtMiKfKk0iecQw+/0Rh+rf4jvTVBkE/04Uk3lkG/oBCAdYmWPqSemmSwUyjV0kEojlYpa
 sTD5nxsNtAtYtbO3BhjHx29pwy9XHPW2AWfwoJn2c3RktpVYvueyJGs4833JF7PlDwJi4
X-Gm-Gg: AYBFou0NA8redjeIMU7sDfmoyCpJEOL9ckmEQQ1ahuIVsVGUsiygZ2Pp2be/2DOq/pA
 n76QnFFVIXHl4TJuqaXYtD5dv9nl1NX/uz1B4fzSV8pXMAoG3dpZg9C/xfKNVFmsF+ucAPFXSID
 zK+JM+prJWCyFmxGyW+4p/5/VGFJ4W8x5zGhlp4KZ3PFmFe/YZinPKyJjthzEc+q75VBRsJNb/7
 LB+qNYqjMJgtUH4VtB+FrVHrpzjVKrTWkt4iSUTANKzcWCTrrQl2/KkGcgwEHv3k9GEwlIKKajm
 LGalmZl3QIytYOLB4oBdirjS3z3YA5KDg44oFwb9flWzdHVI7lZVOv2OhusFIXlI1VR5hLr1Ece
 sxpva9CJ+bQ6r26H1lTs2QrEbSfm94QV2XarGIuL2D4YwHGjqiqgLAiUgdU63YKrTNCB42cSsyP
 8i1uBCaUCb8kcocnotyk0G90RsBN9zF+eZl9aRbrbf2cd0AemAPrjTKxB2HKwa9uuO7Q3Dwi1Zv
 /PbcFbi3f1MXkb+cE/Va2aaUAbQDh8I9ZGmd2l+FDPN2klZCN0/xVg2W1N3yl+xmt+AM+lIDssY
 MW2oxkKhq8EgmkAbYLXC1rZCrVs++oeEms2TIgg7/Zz5Q2yLTLw=
X-Received: by 2002:a05:600c:4f4b:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-49cf823f53emr67932145e9.9.1788510567237; 
 Fri, 04 Sep 2026 01:29:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm74247335e9.5.2026.09.04.01.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:29:26 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 08:29:24 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: db8854f550226474ea84c377fdbc5024620f05e4
X-Gerrit-Comment-Date: Fri, 4 Sep 2026 08:29:24 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00eefa6276abf97b564161fbd33fe7fa3e3086a8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2PIk-0005P2-32
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5146561711630678240=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5146561711630678240==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fP4/iWQbD9o="; charset=UTF-8

--fP4/iWQbD9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: srkyn=2E

razvanc has posted comments=
 on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/188=
1?usp=3Demail )

Change subject: compat: close all unrelated fds in forked =
helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 3:

(3 comments)

File src/compat/close-fds=2Ec:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881/comment/1446d86a_fd3a4d1f?usp=3Demail :
PS3, L=
ine 1: /*
It looks like all the other files in src/compat have a naming con=
vention of compat-*=2Ec and shim a missing standard function, while close-f=
ds=2Ec breaks both conventions=2E

Maybe cron2 has a suggestion on where th=
ese files best belong=2E At the very least, they should probably be renamed=
 compat-close-fds=2E{h,c}=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
81/comment/321312d5_9afa555f?usp=3Demail :
PS3, Line 64:     }
This can pro=
bably be done in a synonymous but shorter form, i=2Ee=2E something like (I =
haven't tested this):

```
    bool closed =3D true;
    unsigned int first=
 =3D 3;
    if (keep >=3D 3)
    {
        if (keep > 3)
        {
        =
    closed =3D close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;
        =
}
        first =3D (unsigned int)keep + 1;
    }
    closed =3D close_rang=
e(first, ~0U, 0) =3D=3D 0 && closed;
    if (closed)
    {
        return;
=
    }
```


File tests/unit_tests/openvpn/test_misc=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1881/comment/c5ac903a_24a1ddba?usp=3Demail :
PS3, =
Line 544:         if (dup2(source, 100) < 0 || dup2(source, 200) < 0)
The n=
ew tests fail when `RLIMIT_NOFILE` =E2=89=A4 200 (e=2Eg=2E `ulimit -n  64` =
causes them to fail=2E A CI container with a tight `NOFILE` breaks the test=
 suite=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
881?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d24=
5e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet=
: 3
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
G=
errit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: srkyn <david@srkyn=2Eco=
m>
Gerrit-Comment-Date: Fri, 04 Sep 2026 08:29:24 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No

--fP4/iWQbD9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: srkyn=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>3 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>File src/compat/close-fds=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/co=
mment/1446d86a_fd3a4d1f?usp=3Demail">Patch Set #3, Line 1:</a> <code style=
=3D"font-family:monospace,monospace">/*</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">It looks like all the ot=
her files in src/compat have a naming convention of compat-*=2Ec and shim a=
 missing standard function, while close-fds=2Ec breaks both conventions=2E<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Maybe cron2 has a suggestion on where these files best belong=2E At the=
 very least, they should probably be renamed compat-close-fds=2E{h,c}=2E</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment=
/321312d5_9afa555f?usp=3Demail">Patch Set #3, Line 64:</a> <code style=3D"f=
ont-family:monospace,monospace">    }</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This can probably be don=
e in a synonymous but shorter form, i=2Ee=2E something like (I haven&#39;t =
tested this):</p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">```<br>    bool closed =3D true;<br>    unsi=
gned int first =3D 3;<br>    if (keep &gt;=3D 3)<br>    {<br>        if (ke=
ep &gt; 3)<br>        {<br>            closed =3D close_range(3, (unsigned =
int)keep - 1, 0) =3D=3D 0;<br>        }<br>        first =3D (unsigned int)=
keep + 1;<br>    }<br>    closed =3D close_range(first, ~0U, 0) =3D=3D 0 &a=
mp;&amp; closed;<br>    if (closed)<br>    {<br>        return;<br>    }<br=
>```</pre></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests=
/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/commen=
t/c5ac903a_24a1ddba?usp=3Demail">Patch Set #3, Line 544:</a> <code style=3D=
"font-family:monospace,monospace">        if (dup2(source, 100) &lt; 0 || d=
up2(source, 200) &lt; 0)</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">The new tests fail when `RLIMIT_NOFILE`=
 =E2=89=A4 200 (e=2Eg=2E `ulimit -n  64` causes them to fail=2E A CI contai=
ner with a tight `NOFILE` breaks the test suite=2E</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?=
usp=3Demail">change 1881</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 04 Sep 2026 08:29:24 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--fP4/iWQbD9o=--


--===============5146561711630678240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5146561711630678240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5146561711630678240==--

