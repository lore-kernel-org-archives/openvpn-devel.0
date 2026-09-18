Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DABAC982D2
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VFPGBx5Hw1eoN9idxcwplNi2YB4EzmFVTmCw7INgQyY=; b=RQ+DrMFy04azIyInw0i3JHbavJ
	W7CEzmYMI0XApO8zGArTUlo6OCzassA2Y6uqN0PCADfCfe8Mg5921clvUbUVXMXATy6tXaOl/CiL3
	x6ECIlUfCQkBlRfex/0s+07ysx2C4go7wLi3Ho00LNFYbLNoQ2ClwNrlPyY7P82r6GAk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U1D-0005kn-Df;
	Fri, 18 Sep 2026 08:32:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U1C-0005kh-Pe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/WDXe4NcHmB17Ro0UXxLuk56FIyLsMFSo0e2eXtX2RI=; b=YLy+Y+QGJyedug/seK+eGdB09o
 dQUM95bsTukn59Wh2nOGvEV7oHg9QcqnE9yxUnWG4dDR3ZpzhfImLpu+jnHetZugbSFucwLmdBUhE
 bTOXuVFC6BM2jeHeY+Q/HH6mpf6fkhq0Hi0BPF8YJjdkH+6CAIb39f3GQypbHcsW+yzw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/WDXe4NcHmB17Ro0UXxLuk56FIyLsMFSo0e2eXtX2RI=; b=i
 73emGombIBroKcf5lgQ/HGl7n1RrkOc/tzuH+C1WZavtfTVx5ovDhK0Fs3GLiE9bUkO+HB0Q39ZXI
 n0R0nSssKy4hoaBvns45P3ansvyC1IfZ32KKx40FxtOCnhoMtYHFnGQLUDKL53gKzht3MIYGTPQwl
 9POiXELyEhqJSY7U=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U1A-0003PL-0m for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:26 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356256so161325f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720337; x=1790325137; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/WDXe4NcHmB17Ro0UXxLuk56FIyLsMFSo0e2eXtX2RI=;
 b=WQMtFJDQPw2SgJbxuJXV5sXZDp1MM8S7S7AWAad01jXxip79cd5ocQ2/eNXZvHGGjY
 v9ufWNV2gZVkOSR7T3M7Gw9Hhrwbk5JgyO1bh333BemKN8p6rF0c6u1R7Zhdr/ybQdbe
 kP8QxT1R6Qaf8Mv5fn18Nr0GyumPZz5NtwZiAg/InwyqHMVU5GH0XGCVa8cv+XbBN6S6
 Ja3Qfx3jlFuReiAt2KpdyrLOWh9mugFeCexUya8idNnbk7cg4zlEduLTYWNWqgU8SEvR
 kWgLSO94PpqTYPGCs3mK6F9ztYPIjZ9Z76IUQnjufXmLC0smlRGdsMFSjh7ztmadcISz
 O1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720337; x=1790325137;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/WDXe4NcHmB17Ro0UXxLuk56FIyLsMFSo0e2eXtX2RI=;
 b=pHa98N4AUfHdW/BAxka+yhri8nfGwSO521EZrhZjFt+W+2umfrNldj5xpi77wnJtDU
 HvRKl6MxTUDbS6sa4fxXfBPrdbRg4lkC1roF6Uh3pa3i1/TEoS8yv5lRoJFewLUg1RRj
 1a5Qi2/Eb5AcnxnnadCJR2nXaqXcEJ6PfN/pf1GiMxvD1cU/vIoNurRE8gErSaGAdx/P
 1yiDGiPWsYpvty43dIRKAPuLGDHIhj4pPQqv9vNBv8CBAgJ4y00qyu7PNOZfRKg/L/Mj
 K0RWYrqzoOh3pb/gbyvG/9rb+55+LJ+vPPwYcmMImJDx7MY39LhnfwEUanA29zzir7+C
 H/jw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMlHh6V7o2MFPkfv1et1JX/GyftCXKpKFxNfd2XctTOcH3d2NfRCtwUMB0OdsA5R8E4XyvCHPYfX4twyGR@lists.sourceforge.net
X-Gm-Message-State: AFuF++nralG6e5uP+3sI2Mqpi8ESngFA2nki/EatY8MjkjQym3bWnZSb
 3178aVcITINDB0fBONs58PQ6pXHjOqo5AfwPW9qkV6Xe+w82cDD8AgmArukKkw/vOdGRhJCC/pk
 cegsg6r5axmGEH0Ve4P1hzVB9ktY7kDJhja5ecLLIY6bHzoGDMVcTN5iMhasA6678qOrW243IPR
 0IRytPBw==
X-Gm-Gg: AYBFou1EBjiKTMNFbst5jqoBHyAIL+8KpOmTH0pD1XsmaVQwKURrpKqgbTBDWlYSoPY
 xllA4DeDHqAu5vZGEi7Dgn/liKgucYklAs37ylpfRPL1Ga3QuURuEWpnLOqjpXBy/AeX2zhARjI
 vLnFaSq9tpsgsZFIrIKrRFEtlchiBWsKRgRXJIYU57eEpZmJONdJtGqzsODV2/GCN1z7OVf2Vpg
 Wp02q29Bhi2QdRFFX9TRX64SqOn1GVBhSrFfs4nQ2WkGjF9e3vv7RLcVFPmlAk681OkHbAWvRpk
 w1m6PPLrwbq1umikj7QrTjzFe34TnDPoFXbMrM209hMhVQeC6M1a5Z6oI0SbweKplKFWOl71w8H
 55L3zfJiBBLaMa6pwNJ+sfnkZm5aVLA5gwjEg41LEq8hWo6hJX0oTGM03qPkNOpDeoq3zD/6eTh
 Cnt2OKJ1Kv5m/nLjaFv/scwOKEqwq9QS9O1yhQv+p/tJFUBBWhTPRJ+Zm2qu8LVjGXDofkffm1i
 y8M0jpSgVNtV6Bjp1qbS+R6KW7Td8JIzzqh8L/X7tgGPE8LttouvWXjUVjAGub+IojZ/q4LSvh5
 0UyApRb7a/rXTCpHu/ZSwgNgCZ3HU5WOdmwWlXU+7Nui+hHVBqZlWYNZDSFi
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id
 ffacd0b85a97d-4871d98cc80mr2929987f8f.3.1789720337341; 
 Fri, 18 Sep 2026 01:32:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff5605dsm2354951f8f.19.2026.09.18.01.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:32:16 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:32:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: ffa8097cbd669f623a93dd9b368ffb776ae60d2e
X-Gerrit-Comment-Date: Fri, 18 Sep 2026 08:32:15 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a6d859e25cf6fbc403b77656b7a37a1a696691a6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U1A-0003PL-0m
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5938472847562496579=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5938472847562496579==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+3CA6TWaqss="; charset=UTF-8

--+3CA6TWaqss=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17:

(10 comments)

Commit Message:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/5dcde3e3_54c4a1a6?=
usp=3Demail :
PS16, Line 26: never legal on an established session=2E
> Com=
mit message not updated=2E
oops, updated now=2E It describes the explicit r=
ejection in tls_pte_decrypt() instead of removed helper=2E


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/53b41016_5c610b6f?usp=3Demail :
P=
S16, Line 28: See the OOB control message section of the wire protocol spec=
ification
> Better to reference a link in the spec and/or the header under =
which is this is defined rather than  [=E2=80=A6]
It now points at the spec=
 sections=2E


File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1741/comment/93b4a140_4a61df35?usp=3Demail :
PS16, Line 889:     targ=
et_sources(test_oob PRIVATE
> Same comment as on the Automake file=2E
Done,=
 test_oob=2Ec is built into test_pkt=2E


File src/openvpn/control_msg=2Eh:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/f19b0faa_514665bb?=
usp=3Demail :
PS16, Line 88:  * OOB message so far: any other TLV that is n=
ot marked optional invalidates
> which matches the currently supported OOB =
messages=2E
fixed


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/=
84a3578a_f518ba01?usp=3Demail :
PS16, Line 89:  * the message wherever it s=
its, so the whole sequence is walked=2E A message
> sits?  [=E2=80=A6]
fixe=
d


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/87a24226_7877b37=
a?usp=3Demail :
PS16, Line 100:  * @param value        set to a buffer cove=
ring the found TLV's value
> Point out that this buffer points at a portain=
 of payload and does not have its own storage=2E
added - it points into pay=
load and owns no storage


File src/openvpn/control_msg=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/7e8b6f15_b43106bd?usp=3Demail :
P=
S16, Line 81:          * we are looking for and the ones we skip are bounds=
-checked alike=2E */
> This sounds quite complicated=2E [=E2=80=A6]
yes, th=
at's all it does=2E Changed to "advance past the value, fails if the payloa=
d is shorter than the header claims"


File src/openvpn/ssl_pkt=2Eh:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/8e3f8bf7_3896c14c?usp=3De=
mail :
PS16, Line 72: /* the out-of-band opcodes, which carry no reliabilit=
y header */
> Other part of the code call this ACK array=2E I would be a bi=
t more verbose here:  [=E2=80=A6]
fixed (looks like you missed "not") - OOB=
 opcodes are not part of the reliable control channel, no control message i=
d and no ack array=2E


File src/openvpn/ssl_pkt=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1741/comment/811fab47_a4c877a0?usp=3Demail :
PS16, Li=
ne 171:     ASSERT(!opcode_is_oob(opcode)); /* those are built by tls_wrap_=
oob_standalone() */
> what does those reference here? I have a rough idea w=
hat you are trying to say but I think this comm [=E2=80=A6]
changed to (hop=
efully) less cryptic "OOB packets carry no message id or ACK array, tls_wra=
p_standalone() builds them"


File tests/unit_tests/openvpn/Makefile=2Eam:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/a984c08b_67f336c8?u=
sp=3Demail :
PS16, Line 157: oob_testdriver_CFLAGS  =3D \
> Can we just add=
 test_oob=2E [=E2=80=A6]
done, oob_testdriver is gone, and test_oob=2Ec is =
part of pkt_testdriver and its tests run as a second cmocka group from test=
_pkt's main(),



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8=
d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-Pat=
chSet: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Comment-Date: Fri, 18 Sep 2026 08:32:15 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--+3CA6TWaqss=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change=
</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1741/comment/5dcde3e3_54c4a1a6?usp=3Demail">Patch Set #16, Line 26:</=
a> <code style=3D"font-family:monospace,monospace">never legal on an establ=
ished session=2E</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">Commit message not updated=2E</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">oops, updated now=2E It describes the explicit rejection in tls_=
pte_decrypt() instead of removed helper=2E</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/53b41016_5c610b6f?usp=3Demail=
">Patch Set #16, Line 28:</a> <code style=3D"font-family:monospace,monospac=
e">See the OOB control message section of the wire protocol specification</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Better to reference a link in the spec and/or the head=
er under which is this is defined rather than  [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>It now points at the spec sections=2E</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
741/comment/93b4a140_4a61df35?usp=3Demail">Patch Set #16, Line 889:</a> <co=
de style=3D"font-family:monospace,monospace">    target_sources(test_oob PR=
IVATE</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Same comment as on the Automake file=2E</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done, test_oob=2Ec is built into test_pkt=2E</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741/comment/f19b0faa_514665bb?usp=3Demail">Patch=
 Set #16, Line 88:</a> <code style=3D"font-family:monospace,monospace"> * O=
OB message so far: any other TLV that is not marked optional invalidates</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">which matches the currently supported OOB messages=2E</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">fixed</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1741/comment/84a3578a_f518ba01?usp=3Demail">Patch Set #16, Line=
 89:</a> <code style=3D"font-family:monospace,monospace"> * the message whe=
rever it sits, so the whole sequence is walked=2E A message</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">sits?  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">fixed</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/87a24226_7877b37a?usp=
=3Demail">Patch Set #16, Line 100:</a> <code style=3D"font-family:monospace=
,monospace"> * @param value        set to a buffer covering the found TLV&#=
39;s value</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Point out that this buffer points at a por=
tain of payload and does not have its own storage=2E</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">added=
 - it points into payload and owns no storage</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/7e8b6f15_b43106bd?usp=3Demail">Patch Set #1=
6, Line 81:</a> <code style=3D"font-family:monospace,monospace">         * =
we are looking for and the ones we skip are bounds-checked alike=2E */</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">This sounds quite complicated=2E [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">yes, that&#39;s all it does=2E Changed to &quot;advance past the value=
, fails if the payload is shorter than the header claims&quot;</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Eh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/8e3f8bf7_3896c14c?usp=3Demail">P=
atch Set #16, Line 72:</a> <code style=3D"font-family:monospace,monospace">=
/* the out-of-band opcodes, which carry no reliability header */</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Other part of the code call this ACK array=2E I would be a bit =
more verbose here:  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">fixed (looks like you mi=
ssed &quot;not&quot;) - OOB opcodes are not part of the reliable control ch=
annel, no control message id and no ack array=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/811fab47_a4c877a0?usp=3Demail">Patch Set #1=
6, Line 171:</a> <code style=3D"font-family:monospace,monospace">    ASSERT=
(!opcode_is_oob(opcode)); /* those are built by tls_wrap_oob_standalone() *=
/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">what does those reference here? I have a rough idea=
 what you are trying to say but I think this comm [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">changed to (hopefully) less cryptic &quot;OOB packets carry no message =
id or ACK array, tls_wrap_standalone() builds them&quot;</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/Makef=
ile=2Eam:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/a984c08b_67f336c8?usp=
=3Demail">Patch Set #16, Line 157:</a> <code style=3D"font-family:monospace=
,monospace">oob_testdriver_CFLAGS  =3D \</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Can we just =
add test_oob=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">done, oob_testdriver is gone, =
and test_oob=2Ec is part of pkt_testdriver and its tests run as a second cm=
ocka group from test_pkt&#39;s main(),</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"=
>change 1741</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Fri, 18 Sep 2026 08:32:15 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--+3CA6TWaqss=--


--===============5938472847562496579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5938472847562496579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5938472847562496579==--

