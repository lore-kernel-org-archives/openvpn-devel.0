Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AF606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FfvTseV0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VWRxRbg4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BHhk3zr+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cSm781l5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oB2MseeSK9l0TXcqZPiR42eRyXWJVpP4DtTGAakxmPs=; b=FfvTseV09JZljmOEFH2dbF4aIF
	WNco1ickJx6uQjSkcgcvJ0DoN3cEA/hoogB3SHdq0wACzzc1g1Upvj1joWr2nnitZZx7ygqT1O8m0
	Kc5+g+i+kVUTdxb/6JhJgc8N43h1+8VBRrQ0TwidRZOi2/iyUuk9H204Ge09eGvWLot4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgm4-0000000050X-1mxE;
	Tue, 27 Oct 2026 12:59:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLgm2-00000000506-2sbN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GjQ0UK58qKpDGRgjwBPmdEAGXQIysTdKvmtib3FWxzE=; b=VWRxRbg4M6/fNxzOLqZS3mnGVI
 UrqrUcYhKTXKT1jM/N6CgLrQiqNdEmZt63e9e8p1ZM4L0uxIuSu8y3XiEgvL+Og5m1NCFS2zdK8QS
 VLxvWfZo1H9+1BVPJzQfItgrG+ZPGWHFNdlqEia1guOBYq/RpvUA4uCvpjQKG2+A0f5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GjQ0UK58qKpDGRgjwBPmdEAGXQIysTdKvmtib3FWxzE=; b=BHhk3zr+cb5LmLp8BPH31Nz+AA
 JWp+k5aeTJB+0Kfh+j96+zhFEZcxzaoYFQONiTo4TkoQWiuy6qsww/9+QiW1rI7Xc8KHFfEkU9aIP
 TmHRonizSidCFeF/7Gi2t2zpU4449H/1cqo4+nwvj+7dXwl3yHpNc3JrrO5MjKSt4i8I=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLglx-000000006gg-2x3f for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:59:27 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so911824f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793105959; x=1793710759; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GjQ0UK58qKpDGRgjwBPmdEAGXQIysTdKvmtib3FWxzE=;
 b=cSm781l5y3RJlNrqi8YQ+SSrucWJUXfMm55JrVh6pRSsGjcInRRq/d9naMJIQH+icI
 3mapBxXeeIe8uY1lst3LIFYkvHq5YStogaxzC7QtzQCfb3iZYja95OR2bAGkgGnjm6Bv
 2T2MQ8jutT2PsaHadjIRR4BjtMFcIoFz6PxWViJtzrw1DYFt9QP5zxtvWJk+yLcxNeFN
 MuLj0O+bKF1RC2vo01ANNvpWknhefRcZM0T2e4OPbsFidIPlcG18vzzoF8JyJzs7Q5iI
 r8Rc+LFTHPAzIxWAlKNf3nCv3tOISjkiWWhYNblHIAMS+RIWA+p1pLGJDwttC8ff33CQ
 N0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105959; x=1793710759;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GjQ0UK58qKpDGRgjwBPmdEAGXQIysTdKvmtib3FWxzE=;
 b=1OsJ3eE9wBCIpYd9Vbl4LQ71DJ213YOoVnaFcHebElZD3lmMtcSgRAKbM/c65rDcub
 8CW4tJrnLFd4p1IQSV1bopYPwdkfgDrT1hiSpRR3+az3PYZYBapsf3UPOUF4BUS+8oBN
 zvnFmR6r8jgFNy4tmymA6QA58+h74LFOnaqEZRuRjVlKnLSIYuXfar24Kx3zMtsygouR
 NIRj4gcpQCTT/XSS6ag54j18v2rsb++t29QeyCCmqOgjEuL16XTKyhptQaKJtmNz6S+M
 1C9pE2ZzFuOHh2pVi7zlUOrZ1V9jlijpXNYYjH1PpBgHNYTW9ju6hQGDLIXPjf655BFr
 B4LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdoCEf2X2rW19t5gLKPDJ8mLXnLiYJb7anmhhf4XDMr+eSU4DTYasFmZoCbJlqi1APi05KbfcLxy2wyV1u@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJIR9+Ufs/8Jf+MHb8+nZHDLM7zImkd/MUJgS1K5M09xJApotHa
 VEI+Aeeh2BMQmApiV2t+1CoprxpbtE0sSN1N1oHCzS4ErAVGR4rVSNTKU8GfQkwquwi8FhqcjTh
 JwvwNuixYtC6O3lG1QOCY811LEOdzlDT3j713BeQeKeLF1rHmAELc4vqSLmmm2/7R1H7r
X-Gm-Gg: AYBFou2AwVjYh7sJrSSuCxvqQ14iPwICtFGQZap2J/ZssG0fDaXJQhrtnYOn6XUt5DH
 rJhYujZIZdERBSFfZ6wv3mQEbhRkkE9FD4pDu5TfGbsYAJTfwTlqKOJ/RhSqtp9uSzEFrj3hFEY
 VcFI1YBDWwgm4OGP6PgjEzl6MuUhAF8IZySyP36sTD12rxtkQbHWR0dasssn4lv0eRRZYmVI/2f
 Eug4HCAm15Qy6YWRHWk/+GJAz/4Q60Irqz2IhGrIhqQNOobOzPvsoeoRRZ5UZuf0fPR/VA0bHUk
 3yrGGPokP4v3P+mo/CZZh0MJgLiz0SuEo2kr4tf7SOe2xGB+jM0Ru6q9HcwPguZC6BVngsSOWq9
 jsIOrJ2WUK0SAFJK043EpvMlf/5UGelmPJndCUkpIXTgREOHio96XZsoHn5EjelKGSQulo71QqO
 yiETC3KS+Hq9VfQyWLgbRoVtgq2q+xAP5NBKfr10vL872f2r6+M+2IBHV+Pj8A6Tp+p8VvkBMUc
 tgWGR+0ZZjh41lK9JGk6hDqa+5/Outgk+aSK5ERZJqCVDk3KkGz+WuAaCKYT6gcw+eaRm6HUMmk
 EH6F8vzQcZDy8PawkYmlhEiiJSYmj/svFS1T7Sg7z1dcltrNJKEjQGnhZOTfx003DuZhfMKosTw
 PqFWOwDmZ2m4abIP7M6jxZtA9yw6mdL3s72unauSCEFQ=
X-Received: by 2002:a05:6000:438a:b0:48e:884:affb with SMTP id
 ffacd0b85a97d-48e55a51758mr6299458f8f.24.1793105957931; 
 Tue, 27 Oct 2026 05:59:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm21963425f8f.43.2026.10.27.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:59:17 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:59:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: df84479e5f7f3b06ab7bdf476664fa61c7c881ab
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 12:59:15 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbc111f046dd3e0a105abc21a68e8ede48545aef-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xLglx-000000006gg-2x3f
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3706640614778642853=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3706640614778642853==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B0s4Nc1qnxA="; charset=UTF-8

--B0s4Nc1qnxA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script f=
unctionality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 14:

(6 comments)

File doc/man-sec=
tions/management-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1852/comment/da478a76_63a5ef83?usp=3Demail :
PS8, Line 143:   :code:`SIGTE=
RM`=2E
> The code says SIGTERM: [=E2=80=A6]
Done


File src/openvpn/init=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/e3748a69_475a6d=
f5?usp=3Demail :
PS13, Line 4352:     setenv_str(env, "MANAGEMENT_USER", ma=
nagement->settings=2Eup=2Eusername);
> One patchset v8 comment says that ma=
nagement auth has no username (so presumably this would set it t [=E2=80=A6=
]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/5d5785ab_9=
cdcfaf5?usp=3Demail :
PS13, Line 4356:     argv_printf(&argv, "%s", c->opti=
ons=2Emanagement_script);
> Should this be `argv_parse_cmd()` instead?
Ackn=
owledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/d4e47b7e=
_41cd75f8?usp=3Demail :
PS13, Line 4360:     const char *msg_prefix =3D "WA=
RNING: Failed running management unix-script";
> Seems like `WARNING` might=
 be the wrong prefix for `M_FATAL`=2E
Done


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1852/comment/f0321d79_b0837602?usp=3Demail :
PS13, Line 4390: =
            c->options=2Emanagement_addr =3D platform_gen_path(platform_get=
_tmp_dir(), sockname, &c->gc);
> Should we use `c->options=2Etmp_dir` here?=
 Otherwise this could ignore `--tmp-dir`=2E
Acknowledged


File src/openvpn=
/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/b579=
c490_f94e7ca7?usp=3Demail :
PS8, Line 4304:         if (streq(p[2], "unix")=
 || streq(p[2], "unix-script"))
> Should we also update the usage informati=
on? It is rather long already though=2E
Done



-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerri=
t-Change-Number: 1852
Gerrit-PatchSet: 14
Gerrit-Owner: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue,=
 27 Oct 2026 12:59:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In=
-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>

--B0s4Nc1qnxA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>6 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File doc/man-sections/management-options=2Erst:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1852/comment/da478a76_63a5ef83?usp=3Demail">Patch Set =
#8, Line 143:</a> <code style=3D"font-family:monospace,monospace">  :code:`=
SIGTERM`=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">The code says SIGTERM: [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/e3748a=
69_475a6df5?usp=3Demail">Patch Set #13, Line 4352:</a> <code style=3D"font-=
family:monospace,monospace">    setenv_str(env, &quot;MANAGEMENT_USER&quot;=
, management-&gt;settings=2Eup=2Eusername);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">One patc=
hset v8 comment says that management auth has no username (so presumably th=
is would set it t [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/5d5785ab_9cdcfaf5?u=
sp=3Demail">Patch Set #13, Line 4356:</a> <code style=3D"font-family:monosp=
ace,monospace">    argv_printf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Em=
anagement_script);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Should this be `argv_parse_cmd()` =
instead?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/d4e47b7e_41cd75f8?usp=3Demail">P=
atch Set #13, Line 4360:</a> <code style=3D"font-family:monospace,monospace=
">    const char *msg_prefix =3D &quot;WARNING: Failed running management u=
nix-script&quot;;</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Seems like `WARNING` might be the w=
rong prefix for `M_FATAL`=2E</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/f0321d79_b0837602?us=
p=3Demail">Patch Set #13, Line 4390:</a> <code style=3D"font-family:monospa=
ce,monospace">            c-&gt;options=2Emanagement_addr =3D platform_gen_=
path(platform_get_tmp_dir(), sockname, &amp;c-&gt;gc);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Should we use `c-&gt;options=2Etmp_dir` here? Otherwise this could ignore=
 `--tmp-dir`=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852/comment/b579c490_f94e7ca7?usp=3Demail">Patch Set #8=
, Line 4304:</a> <code style=3D"font-family:monospace,monospace">        if=
 (streq(p[2], &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot;))</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Should we also update the usage information? It is rath=
er long already though=2E</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail">change 1852</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Tue, 27 Oct 2026 12:59:15 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Comment-In-Reply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--B0s4Nc1qnxA=--


--===============3706640614778642853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3706640614778642853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3706640614778642853==--

