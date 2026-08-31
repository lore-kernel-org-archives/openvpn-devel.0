Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01BCC624A5
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=GkQVlFXmNB2B6TNlrcrqSjnVu+8zbCx2if1N25GAr/M=; b=c4qd51R7O+CXAQ
	VKXtjrJXWUA7sm9COo5DeFWc5MJCuRfOBVYAM+cEl345OfsS8P+HUoKt/w2KiV2wvWZXKtXvajRBa
	aJLhb4hs3aQXH4AnrLxMc2aLB/RWHGNqC5kKMLuKOu01k+v8JzKqXo8N6v4SGNEVYESH3XynREcUB
	Pt8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x14Th-0006sZ-EY;
	Mon, 31 Aug 2026 16:03:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x14Tf-0006sQ-CL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zgc+Rzr1NaaJMjYD6ejcOBzscTxy719+H8w19N3cRxs=; b=TTiQknpxZ16MIZCzQ7sr6mjbcV
 3FMeJcV8EnjkYpR7WZjpO5fD80MxokIw9rHFq2mFtpH7gh5joA59VNN93smH1ynhgro8yXajV6tJb
 dtPvJBpwDPwSHul5RQOCpAB76rjh5bSr6YN6F20FKC4UdZFTpY68Qy351P1/af9tHgiQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zgc+Rzr1NaaJMjYD6ejcOBzscTxy719+H8w19N3cRxs=; b=N
 kYe9V4+w22NDh92TK3UI4dramJnok9MXcHntQwPuRh60ElEaApsYQpvM5xnhVKNLsn01lHigyRt6O
 2WOMBh93VmxMrEuhrKUBrQkZJUZn02EKHBYBSj5PRdPLop9SJcCtj7bl01C5yDJDDHrorXF+9v7C3
 lQDVklUSkEklTSg8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x14Te-0007mL-Kr for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so36201855e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788192192; x=1788796992; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zgc+Rzr1NaaJMjYD6ejcOBzscTxy719+H8w19N3cRxs=;
 b=Mi3GIBbMk7sHaxXmYfxKJwE79LjtZjMioRYoLTsljrIUimEf3IlhyFlhf+mPHrOvIg
 /wdgFLNR5g9t+QTalDl0Ux5av+ZE/8EAg01fb9dKSW6N3OSK0PihYif5JD0xdyrdO0X4
 enVm2+l8m6vCzbEleO7wq2JMJPdY9XszV92IFg6pCRcX16HtAVswHykBgon9PpEflc7h
 Lbp+R0DON3gX7Hrixk9qcmX1tLQ4t+oOKhxbOhcLoJTs8HqKpO9Zhqe3HEZk4vqAuNx8
 WGWAID8OU0RLMJcBdbWOGbazl/aWvohHbevmmTNFXNda2ISuMPXmYryFoLS4mF7320p+
 pGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192192; x=1788796992;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zgc+Rzr1NaaJMjYD6ejcOBzscTxy719+H8w19N3cRxs=;
 b=TLFIreBY1+wiuq5tElWTDimYl+9wgPs3LMzixfBST4jd6oVLzkJAtsxenZSrM7t33A
 iml5eXfPM5sKPBwMQHuK2at67KW/eMHGvZjG/kyv2xw9GsF542+COLx1h8R3BEvfEhBq
 oibXK0sCsi7hWyW6CDBdw1AIlXxHXF0wKeGSm0PeTmUo4y1uJd3/4iH5au1RSqQT215R
 nZeRLafReXErbgIHn4HSGEWmgljiI57B3yeW1MhNVeW7Z+ZbGwjdn4zyXEk6PHDuGgdl
 JQ/uaNS/RDv6HbZy86R4/HJyhiaeG2hS5KaiBYnEpvZl+Xd2CNHz987uDm+w/LVxDrBm
 6i+Q==
X-Gm-Message-State: AFuF++kgQAVQ6W+VGuKZjrwkQScyF1vdT4cpqKXNuTL1jebmau+RO1Cn
 k7TuLuZDKl8WFPaaXnFLC6Vd/r4ZoPeTZfPPY/Zi8I6+7BYVIllHfSv7JBEcjzkzcx9mDrsgTjP
 kUqcuM1td+OLZ5IR1TogA6TgAaC28QdPOrZm211Gy7eMTHr4Qhw6dsyY3bJcTIytsOGLZ
X-Gm-Gg: AR+sD11vs1k9iYwPOrw1rirHR2342RNEXD3frk5DjjM18635tw9+9+oi60lNN9N7uWA
 4kOzyPMIbehc2vPzZItAXCmZ6H7lKuB1gtIfR8iSUcVP130GWsnaWu/JLZj4HqDUXPgITUG0U3P
 HjmKhQqmCmfCvRgBjuKu134lFF4jw+tsA6UomrQKC0N9wz2YOmLLK0ZHmW+JKDDUnrqb0CWRvoM
 2Bp71MtTaPrRPXzTKM6XBKzWZ3qRjyL7wKxSmTciY375ztvW5srNEAHUPOMuUB+DHFVUQrNm9oP
 qk8OH294NpEuHHSK6P/G13OmQqqYQJ284tRCUo0GQAzBZCbbJCnh8WLovELSKGTAO6CkNWQLYJp
 k0wWeigSxLzt2clrGtKbd8+k/LE7GUP0boe4/loItDJtX/iEJPHRL17aqQYJaIsoZJBK0QRlEr8
 hR9FR7x1FQOAOMmm/ORcP2Ltg2Gly+diiTfmCt8p6gHAMr2Kpx3HJsddqubEECqhBbDe+DZGqMq
 xCLQMuygIrTKFOGs7RFD+rthJA4r/m1mFRtLyIeV3JNHU32Rhe1iHz7zSzIoKMvSnmA+8OFR48x
 CH1IuuTV36kakZ9T24ENNDsIKjNsf2gQPXvY6ndEbP7iaqrPUBQ=
X-Received: by 2002:a05:600c:3b20:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49b91bd78cdmr349564685e9.0.1788192189898; 
 Mon, 31 Aug 2026 09:03:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9267c369sm203933845e9.3.2026.08.31.09.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:03:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 16:03:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
X-Gerrit-Change-Number: 1887
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1887?usp=email>
X-Gerrit-Commit: b97975c423764dd95f9a0b2968aeee773b4169c6
References: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkk5ZWU0YjZkMWMyMWJlYzM4NzNkYzZhNDc0YmQ2NWQwNDNiNTM3MGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07c95e45610efcd61ec273155c38d9a92ed6b46c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x14Te-0007mL-Kr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: pass
 correct NRPT domains size
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1427985804919672086=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1427985804919672086==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zirYDremoto="; charset=UTF-8

--zirYDremoto=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1887?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: pass correct NRPT domains size
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: pass correct=
 NRPT domains size

Previous code assumed that the input NRPT domains list =
consisted of
ASCII characters only=2E When IDNs were passed as UTF-8 the si=
ze of the
converted wide character MULTI_SZ list was calculated wrong, lead=
ing to
extra data being read and stored in the Registry=2E

Discovered and =
reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing R=
esearcher: Vivek Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breac=
hx=2Eai>
CVE: 2026-78221
Github: openvpn/openvpn-private-issues#162
Change-=
Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Signed-off-by: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 file ch=
anged, 3 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/87/1887/1

diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec
index 36dfb8e=2E=2E0c6e23f=
 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interac=
tive=2Ec
@@ -2735,11 +2735,13 @@
         dom_size =3D (DWORD)domains_len +=
 2; /* len + the trailing NULs */
 
         wide_domains =3D utf8to16_size=
(domains, dom_size);
-        dom_size *=3D sizeof(*wide_domains);
        =
 if (!wide_domains)
         {
             return ERROR_OUTOFMEMORY;
     =
    }
+        domains_len =3D wcslen(wide_domains);
+        dom_size =3D =
(DWORD)(domains_len + 2) * sizeof(*wide_domains);
+
         /* Make a MULT=
I_SZ from a comma separated list */
         for (size_t i =3D 0; i < domai=
ns_len; ++i)
         {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1887?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Gerrit-Change-Number: 1887
G=
errit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: d12fk <heiko@openvpn=2Enet>

--zirYDremoto=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnserv: pass correct NRPT domains size<br><br>Previous code assum=
ed that the input NRPT domains list consisted of<br>ASCII characters only=
=2E When IDNs were passed as UTF-8 the size of the<br>converted wide charac=
ter MULTI_SZ list was calculated wrong, leading to<br>extra data being read=
 and stored in the Registry=2E<br><br>Discovered and reported by BreachX Ze=
ro Day Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Pa=
rikh=2E<br><br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt=
;<br>CVE: 2026-78221<br>Github: openvpn/openvpn-private-issues#162<br>Chang=
e-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8<br>Signed-off-by: Heiko Hun=
d &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/interact=
ive=2Ec<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
87/1887/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvp=
nserv/interactive=2Ec</span><br><span>index 36dfb8e=2E=2E0c6e23f 100644</sp=
an><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/sr=
c/openvpnserv/interactive=2Ec</span><br><span>@@ -2735,11 +2735,13 @@</span=
><br><span>         dom_size =3D (DWORD)domains_len + 2; /* len + the trail=
ing NULs */</span><br><span> </span><br><span>         wide_domains =3D utf=
8to16_size(domains, dom_size);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        dom_size *=3D sizeof(*wide_domains);</span><br><span>     =
    if (!wide_domains)</span><br><span>         {</span><br><span>         =
    return ERROR_OUTOFMEMORY;</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        domains_len =3D wcslen(wide_do=
mains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dom_=
size =3D (DWORD)(domains_len + 2) * sizeof(*wide_domains);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* Make a =
MULTI_SZ from a comma separated list */</span><br><span>         for (size_=
t i =3D 0; i &lt; domains_len; ++i)</span><br><span>         {</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1887?usp=3Demail">change 1887</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd=
65d043b5370c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 188=
7 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &=
lt;heiko@openvpn=2Enet&gt; </div>

</body></html>
--zirYDremoto=--


--===============1427985804919672086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1427985804919672086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1427985804919672086==--

