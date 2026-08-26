Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8180FC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdZEhY8F8cdNIuRbtcL8xe3Bbw5PXZq2+aPYtF363gQ=; b=O8N/d6a8+6AiTKEdIQ5hiYRKDI
	+tPvA/kKHayFtxOLl/Q13njrSuKe9Z5f0MsySZ91eZZomTy4Ta46H9LtSJ9khpBqvLFyFFeVDwhgr
	vnmHSOCXphMyy/CJcMJkiNRp02pPXy4NZbPr+I7wvPp9EkqCGNhZtvxTvAwKzbyLnFQM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzF9a-000276-1k;
	Wed, 26 Aug 2026 15:03:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzF9Z-000270-G0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BpKbUskoGmWMH9TuLe3q1ThgyVrFNuDWwFF7OAWsuDI=; b=H1+WAXLtdMjUz/dossnwKEQ4uX
 wz4VEzTPrl93u4QCgNM3VqMmLa2HKeVYw1QF/a8QCKTTW6Q+K8Z0XvhkmcwBedgYOwpBiLvpIXuEH
 /qnTEJurEIT72+HOJTCWnZZobc5B7qeNK4Fv2XdOO1SB4lM60bSLKta7+3eemwghmWbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BpKbUskoGmWMH9TuLe3q1ThgyVrFNuDWwFF7OAWsuDI=; b=F
 w7M3qWRZJPLncbldxe2+qjZP0eRopKeara2T7EwSszX5F/Qi33jW5SX84LKJSNF+TwJ0dfllmJfQS
 PAXWXbdyP8lh/3/bLP0smWYbczfmpDyH2kkWEJDMIB1LqdWixKxLjOei1DsK4RYFNOSquLwGHl4kD
 5b/3jMPv3DBMAMoo=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzF9X-0007AZ-2D for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:03:02 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a5ebf75d62so1197240a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787756572; x=1788361372; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BpKbUskoGmWMH9TuLe3q1ThgyVrFNuDWwFF7OAWsuDI=;
 b=VOyqPugJJwnhVgMzVh59VjiIh2oy4Wn3vuqYMVuM+K8c/eDbKmrm0zTDkbQ002t5AN
 7z6GHDULD2IuGu4EpxglBooSMCSeSqgL3+kZZZF04iZVnWccXgamaQCsf09cL+0fOzO2
 221FuTnim7caH6orTcVDtZdL8jiGKKlUtrNowJZiKVPQUnbPj6p8bB6xabPaFQSPulWg
 ebyKrvTfM3QkCtQ2DWsjiQEKEQlyDX/IofodCl92s8v2qwzGehrGeJuqpWyRXsd4Bxgy
 xsR2AUpmQLqRRDF4pIw46B10HBYtcMP0a/OZO30u8N06IPRB+0DT+dcPy5q2tlM+E/X+
 oDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787756572; x=1788361372;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BpKbUskoGmWMH9TuLe3q1ThgyVrFNuDWwFF7OAWsuDI=;
 b=hrWYpvyW4acf1cTLxJuQ9os/pJKKzm0QD48wKfCN3YFvebwY8vOTuIkBwVbu9FkJF4
 lgPVWgfSU8JFWEAJBJKRSa4WLWdEs+WPucE9VmqCP+oj1I9aBYzAy1qYP5Z+t3IEV74A
 i0vse6KQJeGgXm7bgzdmKMDNakkaPrE3L183eYGE/vDpgNclTqAU1l01uVvtaD+Nv5dU
 R4jvWTPlc+0ga39G7H2vUznnuGg5UN2nHvahTnSglNppepPF+sjeSX6ltFvVlCwdlCgv
 tkdDTFUDbQgisUbbcP64Ql7uKK7+1/hl5heSzQZQUFo0qCEaCdeKuCv4BGjBxkDs5cQ2
 hTUw==
X-Gm-Message-State: AFuF++kmQdFVoLSK7dAe8uu1b/Zk3VsZ2RA7KEea+7XEqYusFPZQPY7Z
 r/lqWZWSu2cdQ5KaYO9M6QwHTaiPLJnqq+5aHXTyfNngId2TJ89umfmQ/0ZizqDlqddR1Ht6HU7
 T9f4fn9Qdkxng4K5J6aO5T3NJuWexm3EcCed5HScl3jc0MMznpE/tSAL20AGGkKKXdTTZxpLEhC
 +nwkLg1w==
X-Gm-Gg: AR+sD12DL8BVOIj5vrWKrJUm0g+LzsMnTS4o3IJN73jqhoogHPfLD2tWxfEOddTo33s
 KiWebJyhhNiw7KIpyDFQZOKa1/a2hJrgJ9h94UCDHYaDeR+TWlG/+hvjXvX/vs+Bj20MhJaCa1O
 d1xt34RuMjh8epwgEL+AarcH6b0kgS/UacSy6rbv5dyswL3Kx0HW0K/RWngTRbQh0k9MgRpjxVA
 +xYf/fHudaS3MJmtSR47L9rLcsdh8CzqxFkCBhGeemDyh10qSBoRAYgQml/psEwW6JIv5x2JmEM
 f+VeytRAFn9yt/P++GP8nquZ2mrHbHBlg1YmEalxcHbo/zeFMwWqI5J8CB91/8bGPI/7mU96E4n
 byCT036yPc+OqYZOP0KB+zoma3yF7MMogVrSN/dLilCWmY3Da/+SojQbmYrm30hI4Oa/AEMtEXr
 5TUSIzZJCy3ZdSWoYGEoI7Bpk47tIptlI4UdLyEjTXvDpHIb1jTLzKfyVrhZKNVaD8Qem27miNy
 jDJobyXvB90lx83bAH5wahBWES4hOdCL3C+RCrENupvBmDimO6GKRSpjMex213ZnyOtn3KhUL7J
 vrfqc0kBdxNIP4+jfUjVqibCni1krXWf2Oyh8Bnc1uaLjzKawcg=
X-Received: by 2002:a05:6402:2111:b0:6a0:a46b:ad3c with SMTP id
 4fb4d7f45d1cf-6a5df11bc67mr7236649a12.1.1787747176813; 
 Wed, 26 Aug 2026 05:26:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm5140107a12.21.2026.08.26.05.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:26:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:26:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: d15ed8dc6abe2c8b89e8b92a64c461ae9ee1024f
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:26:13 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f708826a60490b37abc129e7915f529191e38eb6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzF9X-0007AZ-2D
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
Content-Type: multipart/mixed; boundary="===============2269487898425685862=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2269487898425685862==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iik26s59fY4="; charset=UTF-8

--iik26s59fY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script functionality=
 to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 8: Code-Review-1

(6 comments)

File doc/man-se=
ctions/management-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1852/comment/cf57342f_38e1e5b5?usp=3Demail :
PS8, Line 33:   variables :co=
de:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`
The user variable is mi=
ssing in the list


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/=
cd8a5341_3be649ff?usp=3Demail :
PS8, Line 142:   this option is not needed =
since a disconnect  will always generate a
Additional space after "disconne=
ct"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/c4de05af_6ae04=
a8b?usp=3Demail :
PS8, Line 143:   :code:`SIGTERM`=2E
The other documentati=
on and the code says "SIGINT", not "SIGTERM"


File src/openvpn/init=2Ec:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/eb9683fa_42aa1f3f?us=
p=3Demail :
PS8, Line 4382:             c->options=2Emanagement_addr =3D pl=
atform_create_temp_file(
Are there any "insecure use of temp file" concerns=
 here? If we ignore that actual file and just use the name what can someone=
 with write access to the tmp dir do? Just prevent the creation of the sock=
et? Anything more nefarious?


File src/openvpn/manage=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/bbebc394_5de77151?usp=3Demail :
P=
S8, Line 2662:             snprintf(ms->up=2Epassword, sizeof(ms->up=2Epass=
word),
Don't we also need to generate an username?


File src/openvpn/optio=
ns=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/a7e72c69_f1=
67b742?usp=3Demail :
PS8, Line 4304:         if (streq(p[2], "unix") || str=
eq(p[2], "unix-script"))
Should we also update the usage information? It is=
 rather long already though=2E



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number:=
 1852
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 12:2=
6:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--iik26s59fY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 8:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>6 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File doc/man-sections/management-options=2Erst:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852/comment/cf57342f_38e1e5b5?usp=3Demail">Patch Set #8=
, Line 33:</a> <code style=3D"font-family:monospace,monospace">  variables =
:code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The use=
r variable is missing in the list</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1852/comment/cd8a5341_3be649ff?usp=3Demail">Patch S=
et #8, Line 142:</a> <code style=3D"font-family:monospace,monospace">  this=
 option is not needed since a disconnect  will always generate a</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Additional space after &quot;disconnect&quot;</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/c4de05af_6ae04a8b?usp=3De=
mail">Patch Set #8, Line 143:</a> <code style=3D"font-family:monospace,mono=
space">  :code:`SIGTERM`=2E</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">The other documentation and the code=
 says &quot;SIGINT&quot;, not &quot;SIGTERM&quot;</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1852/comment/eb9683fa_42aa1f3f?usp=3Demail">Patch Set #8, Lin=
e 4382:</a> <code style=3D"font-family:monospace,monospace">            c-&=
gt;options=2Emanagement_addr =3D platform_create_temp_file(</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Are =
there any &quot;insecure use of temp file&quot; concerns here? If we ignore=
 that actual file and just use the name what can someone with write access =
to the tmp dir do? Just prevent the creation of the socket? Anything more n=
efarious?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/bbebc394_5d=
e77151?usp=3Demail">Patch Set #8, Line 2662:</a> <code style=3D"font-family=
:monospace,monospace">            snprintf(ms-&gt;up=2Epassword, sizeof(ms-=
&gt;up=2Epassword),</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Don&#39;t we also need to generate an userna=
me?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/a7e72c69_f167b=
742?usp=3Demail">Patch Set #8, Line 4304:</a> <code style=3D"font-family:mo=
nospace,monospace">        if (streq(p[2], &quot;unix&quot;) || streq(p[2],=
 &quot;unix-script&quot;))</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Should we also update the usage infor=
mation? It is rather long already though=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3De=
mail">change 1852</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 12:26:13 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--iik26s59fY4=--


--===============2269487898425685862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2269487898425685862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2269487898425685862==--

