Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E362C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0RpMrtJyQh7wcuEP4yePv/2aVmby+7NCThi6WzvBk4=; b=MAVE6cKyCx+gwwE9TesvbHjfN+
	bvR0IRnXDW1FFlvvajyZdSJVOISiniLRvKJ3BJaydg+87B/8YaF1U6mjcYbRcGCamEcPqHibR2Fh9
	Z4capg4f4H+STysbe5bq+kkLwHmnUeN7tre3hI71jONDo8WtR5abZTQ9IfDQWtAy8Q5M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiE7-0003ZD-Jd;
	Wed, 19 Aug 2026 15:29:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiE6-0003Z3-GY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4txK0igCg4kSeUu5bvEQMhjoRHV8DJSxoiI+hvbUcNQ=; b=DJLvOAtceYpTnOv1EXUvWFqGNh
 p66wdXvg3B1Il13FLC1OSbJcmx2cZZL/SMRdqxJ/CUi/KXVFR8SFMjiu5sUf6l2fdgK+zVfMr+BR2
 Xhkr4h4SmV4FcTfWBahkd8DT4sPHrhGs61bvu3SxaBzZ50KLzYsYvkhxhbc+yt2zf5us=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4txK0igCg4kSeUu5bvEQMhjoRHV8DJSxoiI+hvbUcNQ=; b=a
 wtOINDjuJ0flLY2CAieaqHfR4KvYcy4TljGJvpQqYVUTLNhEDUN1cnAa5AdCDW0P7pcTqwxRenfCO
 xggV/pJpbWFgkSiA40tL1Cd0DGVi3tXxhH4S4PUIvuDJjtk6kdEMBo5m6zH/rTkQsJk8v2F+Kd3ZR
 vFSEQivJJzOkR2hU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiE5-0007Ad-LU for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:29:14 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so92365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153347; x=1787758147; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4txK0igCg4kSeUu5bvEQMhjoRHV8DJSxoiI+hvbUcNQ=;
 b=O2GV1HgqRYP5/DhV2C2CWOA4kYWnbkBZYwE427Gd59fH9j8V/4acB8ow487+Shpd35
 wGngoGAPO343CFFGXcgn+Z281MA5JFscMx33H/7KOROoCqCjcIhP3krdO2RrtBlVKCPF
 Kzmk7yOAx0S4tU0zetkuNZEgPc65oiV5It7wPFL1IV/WSLq7MmUNU8NQ1J/pirMMQhIg
 +RacqGdQ/hoUxUlwWjbjQbXm300cNYPCSi05z6R4tXEhC+TpgHaLGV06kIh/0TGLQtqp
 LFKIE62ogfY/+add8CxR/jPXXlDfwhvNPTregxXcpzkHjUszZ5O0+YOBx4BjA0/inkhv
 f0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153347; x=1787758147;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4txK0igCg4kSeUu5bvEQMhjoRHV8DJSxoiI+hvbUcNQ=;
 b=cfWGqbatbaIA15VCJqUzsLqLsBWxUkYeCZQhcgA+yfzbvhKvMyQh1qOtemAkexOiSb
 kh3yOGyDffcqRczYyAQmlEZ25htlyCO8gJLs7MmptUjL7RTAAyMhjgJTIjubFGQdik0y
 j00jA1YJu0VmjDQN9cho0opmwBgoj6yRfv+FRRbCY9zOOhgmPMN7Pl+aK3GAnNogQinx
 ik/LdwoyYaDCgibxQneD0p363zVZ21WSUwmwfWgxrdtIUEoNVBDLlUGCH7EPjctqXiY7
 +K+DIyzd2bIv6w4eoMkCWW8Xg2YbgmE44/waExDHCfmF4sSk4+dhJbaniUlvriJwUh+I
 SRKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrctwoMHAByZrBG+Uj997OMz2PHnB765p/hjHtC3KfRs2obWMT5vsKyNDOVnXJgxrx4gznX+jQoZp0uk+PM@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxZjTDSNwCeoclQG1wVidC0kf+gJQM8d02ZWzIiFy3zfqrfd+nr
 mCIr7QkvfgBLqZv25GAvv4S8fn0BM5R+AZics5G9XEv0r4fnYeljcfyLl8XncHRdYz7e0tCr94e
 UYMlbALdzg1W+1dojtxPubmlIyfA4+gQHFpBYKIW5RFfC8s/WGuV6+cc8MJB1coTXzZRV
X-Gm-Gg: AR+sD105ruTBo9xGqdWxwIvuAdJvu2L8iCmbkS5Y/0aOPG/xP+JXHTPLNSmY+q0GfZE
 WltXWMY9EEUpX5mLVI/WazuyNsgRPQETabNw4BeMSklURHeTwR3HsKXTnA+8R7XJLqPb8JN3flL
 enXFWWZ00eQkj2Fjf8U9NBuQghMiCI8Wo8aDotH15TTwqZhf/Bs023bBFh1gUS/IGMFVFfpAYd1
 MGRB3ZQuTukHN7Dep/SeD70egMtuacBjzYB8UHbahWpdalapTpuIpU2uIiIX0GN1yxsOM1mtPZy
 GmeymcTxSrHyH03965jY8fCj6UZmoAfw1C6AGCbp8kLLmbYfsNIRnAXqbt1SevKnDsyWH2AF7BC
 nNvWoBm4HrGTzsIXE6F5PPAMPRGuFg33HSNplO4IVTl9yrDw4TBh3anjAMxcG2j7omtpWzr8q8k
 SNxD7a53kTGiR3CpDUMRi+Jo9DpRMS2UB337Mc1x2sdT8xHJkiJ4vMaDbyG9CZOnG73IKwJnHMb
 OT9Bu02OQk/rl1nrAuwmxkHLsr7OvIX2tN83nkiMzf4cGE6XLjqj3kIkluRLWh9SCXvadYaZTg8
 WWI9RwG/vFqaA2vJ8+msqYPwpcZIbEgJiQKxE766a7NbF1gG++s=
X-Received: by 2002:a05:600c:6b04:b0:499:8afd:4a9f with SMTP id
 5b1f17b1804b1-499b062fef0mr1116505e9.0.1787153345690; 
 Wed, 19 Aug 2026 08:29:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e00bddsm55316005e9.3.2026.08.19.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:29:05 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:29:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 46a9953a30d82673ae9841cb050117d2d41048fb
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:29:03 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f92cf996e2b08560370af383b9257c36da6bef8d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiE5-0007Ad-LU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1089171753744748394=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1089171753744748394==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="agTzwsGKKnc="; charset=UTF-8

--agTzwsGKKnc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables =
that shadow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15:

(4 comments)

File src/openvpn=
/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/b0c7d=
c04_c3550c66?usp=3Demail :
PS13, Line 3670:             struct dns_domain *=
new =3D *entry;
> Ouch! It might be a good idea to have an official guideli=
ne to not use C++ keywords as variable name [=E2=80=A6]
out of scope for th=
is change, though


File src/openvpn/ps=2Ec:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1618/comment/2d807a05_85086416?usp=3Demail :
PS13, Line 878:  =
           msg(M_ERR, "PORT SHARE: unexpected init recv_control status=3D%d=
", status);
> But now we are probably printing the wrong `status` variable =
here=2E [=E2=80=A6]
Done


File tests/unit_tests/openvpn/test_dhcp=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/85abadc9_c9db387e?usp=
=3Demail :
PS13, Line 58:     struct buffer clean_buf =3D alloc_buf_gc(512,=
 &gc);
> I assume I wasn't that worried due to clear_buf() being a function=
=2E
not changing this


File tests/unit_tests/openvpn/test_push_update_msg=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/f2559df8_b9c3=
bf53?usp=3Demail :
PS13, Line 347:     const char *cmsg1 =3D "PUSH_UPDATE, =
route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=
=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
> Maybe =
push_msg1 here (and the same strategy below)? Would it make it a bit cleare=
r?
I did go for cont_msg since this is the continuation test



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac79=
15fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 15
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:29:03 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@li=
chtenheld=2Ecom>
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--agTzwsGKKnc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>4 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1618/comment/b0c7dc04_c3550c66?usp=3Demail">Patch Set #13, Line 3670:</a=
> <code style=3D"font-family:monospace,monospace">            struct dns_do=
main *new =3D *entry;</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Ouch! It might be a good idea t=
o have an official guideline to not use C++ keywords as variable name [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">out of scope for this change, though</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ps=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1618/comment/2d807a05_85086416?usp=3Demail">Patch S=
et #13, Line 878:</a> <code style=3D"font-family:monospace,monospace">     =
       msg(M_ERR, &quot;PORT SHARE: unexpected init recv_control status=3D%=
d&quot;, status);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">But now we are probably printing th=
e wrong `status` variable here=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/op=
envpn/test_dhcp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/85abadc9_c9d=
b387e?usp=3Demail">Patch Set #13, Line 58:</a> <code style=3D"font-family:m=
onospace,monospace">    struct buffer clean_buf =3D alloc_buf_gc(512, &amp;=
gc);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">I assume I wasn&#39;t that worried due to clear_=
buf() being a function=2E</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">not changing this</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/t=
est_push_update_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/f2559df8=
_b9c3bf53?usp=3Demail">Patch Set #13, Line 347:</a> <code style=3D"font-fam=
ily:monospace,monospace">    const char *cmsg1 =3D &quot;PUSH_UPDATE, route=
 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, =
route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&quot;;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Maybe push_msg1 here (and the same strategy below)? Would it m=
ake it a bit clearer?</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">I did go for cont_msg since this is =
the continuation test</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 1618</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd2=
00d877841e473e5e05b7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1618 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:29:03 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--agTzwsGKKnc=--


--===============1089171753744748394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1089171753744748394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1089171753744748394==--

