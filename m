Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719F606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CG9ZfP2r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Dmv3EcC5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a/b9UMTc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U1lqVf2U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DtC03IWDfLAuPjKgZgzuBUmIykWy/GRHHxiJn4RXGf0=; b=CG9ZfP2r4en+YLZ4o+cTve4TtM
	oetVzFDKwQn2Y+2k0w8W4l3tZiO1m4/kkCrbIuvWIM94ILKALBijuAUppz6zoTdmSIWTHrx/c9UK/
	MJiaRX11akgwD6KNu217cxF/CJajoGfforb25aZl5FaNw9hMM2/qKo+xiCk86U/v5kg8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLJXA-000000003GK-2LGH;
	Mon, 26 Oct 2026 12:10:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLJX9-000000003GD-0NiT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8MAwUGjO22W3GYa2qHZHr3tdcD69GIwZrHn4dKfejmI=; b=Dmv3EcC5Y0c5tHMq/bgorApYVD
 RCQVYy8SVp/ATAk0o+NXI6ia0PL+bHtHLHwSzNKjK3Z9kivWlyNNK2Rr6DYkyyUu1F3RmsJGFYGZW
 xdB334SiMLpy146pIkho+0HBRptRzEUHJq4bktsI6bo+A7jeCExoOaTge0KnE9VAMv+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8MAwUGjO22W3GYa2qHZHr3tdcD69GIwZrHn4dKfejmI=; b=a/b9UMTcmWfBnHnpi71hTGUhyo
 qPkvGfB00KY6vOy3hnJk4f7JCDNXPMa7uMGdWEfZAPlnXWpRl/Qtu5eTtz382Mwpie6C0CMuTfzSy
 TnZwuiXPAQB7kiRJfYvrkFzvPW6jIoDH+BPL6qrCT1yqzoxBUdo1da3y73FmMchsgaE0=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLJX6-000000008QF-17km for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:10:34 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1608938f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793016626; x=1793621426; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8MAwUGjO22W3GYa2qHZHr3tdcD69GIwZrHn4dKfejmI=;
 b=U1lqVf2UgFAbSO5hFffMtn1fPkB/DKJ9QHnvSgd+AcwYrXhuttyL1yKm+3l6ScNkDa
 LgA1yT6fqpEN6Ccn1PRsg2qyJ5rjLvhWgjhdYRh/MyZB5s0qBo6hWQz1FCZFiDAfjh+n
 BUHMuuB+Mum2xwAOZQwcJWcjz91WB6OzBcJju6G0/+UUi0rnxt8H8V4VnU96V9c2/hs3
 b4jR1fImS/5Yw22Yd8NX4RNM3cp2tm2nxR7O+kWSPLjTC7Vb7R2Xhs6OEWBepZJJGHSw
 nD3955oQsaZncB/ZdQVUIL6zHq+MdhFCp5hxNCscos44HC6bOB0gCsgNz0H3nWuCEGva
 tzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016626; x=1793621426;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8MAwUGjO22W3GYa2qHZHr3tdcD69GIwZrHn4dKfejmI=;
 b=pgQ0ZBmk5FIi2wekeSv5OnuMfJsM4ykVtrnViSjW8pIOOA82QYjk+aXHzlxiu9S43M
 Y0GnpsWPFBuW+pvdwOZlODsVcWzaQV32rSFzt8bodMHylPDt/1r4n1TNZzbhshP0p/gF
 0zBrOJaINWEGIC4ZnkyU0wr3QW8AjyxlkUTdeK6/ptrqV6JLTJfAl5dzuzM2iiUHM5UY
 XcQ01cLkliXRd1bXE5AyQiKbtRBTlWms/HVqUtTjf4hlLzjwdkBmChkwIdu2qIif0jkX
 RHQw0qXVD9TTZBv5sakAnR6TLsuEMeJT62wsNjgbLvv9e+RZDu0q/GELuET8/b0Dru5M
 wXGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0VEElohJdi+4+xe8h66UtTkWP5DWUFKs6Uu/knJ3PXoFuesVdtBGEDYUemdfhA8dq0UnDF/CxfXXIElis@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJp8RxOO3Wa1YE+V1GKGmUgphBCMg8vj7OBiD5Y4Eh53x1F78Wu
 ToOY0LGOalbhnO2k+nfiQBXU7ZliXgDXpAcICvq0Lnkxdi4DMSIEyyuUcmAZzTMYsvygkoJ+emD
 mUxf6LheoAy96Zk13aHAxYMPuXyxm3SFsSepTPvpOuOXVOfxn7WNbAZJ+4qYGjR9ahRle
X-Gm-Gg: AYBFou2Oo8uukcmkSRB2mWDHxaUVfrBaSUyGrrM1LtAUnSG/DoJZxEbWklJNcBJagh8
 Pk6yiVD8o8ePvKbj9nI22kiI/Ju1kXYuQ44VXX9a+vbt4QJYB5PWZaev489VPEhfEqrItiowL9d
 SWVE08wMhWnwq6vpSKhA1NclbwEZ6V6SAP5uyfxSJQe3+TtHCCGiyquuKgFtCIgwxH25RDMDQ8z
 0WSeD3hpRWYO4LAb4xhLFYSVa3Qr36M6MvtQ8V/W1RvGtfJQeYUJjO3yXPf9IGrBzzbBj/mzO30
 GxeWamBRRe6OUf3w+JzwvjB0ETlOWJDiFiShcj0F8ymr5zBS26Py+oL1cw67gGKgrLNtbmZQr/N
 U11uSaLSZ5YmPlI2NL9ek1IZoMLwc5F82ip0QBOGWk79lFOUqhc2L4gnqQRUTiY9o8CncUmBe+h
 jmD/zPqTlo19W8ofBVlJpzFIHoxzWVGnk+I2P3WyOfjVqsQRbig1g9FPvgrtGVR+sls/4hM4QKI
 4e0Ni10xoBKJgVCLqU8XhAIYT2eIAqrr6ZySywOCcmTfLCptj/BIG5arLTgqppGxpTWqCf93H2T
 Z+j7jdKUxXF/Ndxujj6vlbXqM8gqtxxtk4bNd8mZeccJ2zg86HFlix39wCT0UaL7RXq+m8n4lDy
 i2IN5RGMX0jIHeO1HGuas5TNWSDDyKyl6y+ypHQ43YA==
X-Received: by 2002:a05:6000:2689:b0:48d:ff06:c634 with SMTP id
 ffacd0b85a97d-48e3eb9bddamr12840910f8f.54.1793016624755; 
 Mon, 26 Oct 2026 05:10:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm16328070f8f.33.2026.10.26.05.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:10:23 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 12:10:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 041f266f134ebc625810c269c2749f5571cca225
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 12:10:21 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c27042233a7505273e75e020a8beb5dc6eca0c31-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLJX6-000000008QF-17km
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Max Fillinger <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============8708000469268915052=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8708000469268915052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RSVjhf80OEA="; charset=UTF-8

--RSVjhf80OEA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

R=C4=83zvan Cojocaru has posted comments on this change by Ar=
ne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail )=


Change subject: Implement initial packet reflection protection using bloo=
m filter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 11: Code-Review-1

(15 comments)

File Changes=2Emd:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/30/comment/9741d65c_0c4c14d0?usp=3Demail :
PS1=
1, Line 28:   To avoid the limitation of ``--connect-freq-initial`` to bloc=
k legimitate
Typo: "legitimate"=2E


File doc/man-sections/server-options=
=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/f2324306_a5d=
9f81f?usp=3Demail :
PS11, Line 260:    ``--conect-freq-initial``=2E
Typo: "=
connect"=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/481d069=
8_44c5764e?usp=3Demail :
PS11, Line 292:    Every limit configured with thi=
s option will put more more entries into
Typo: "more more"=2E


File src/op=
envpn/bloom=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/359=
3e6d1_ffce2ece?usp=3Demail :
PS11, Line 82:  * increase the buckets (bit co=
unters) at the the index positions 77, 323,
Typo: "the the"=2E


File src/o=
penvpn/bloom=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/9f=
1d3032_697d2636?usp=3Demail :
PS11, Line 240:     return bloom_add_test(bf,=
 item, len, -1);
`bloom_add_test()` takes a `bloom_counter_t` for its last =
parameter (`-1` here)=2E That is `typedef uint32_t bloom_counter_t;` so wil=
l end up being `0xffffffff` here, which is then logically interpreted as `t=
rue`, so a remove will actually increment the counters=2E


File src/openvp=
n/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/1574264=
0_4a083830?usp=3Demail :
PS11, Line 337:                                   =
                    &t->options=2Einitial_cf_bloom_config);
`&t->options=2E=
initial_cf_bloom_config` can obviously never be `NULL`, so the filter is al=
ways allocated even without `--connect-freq-initial-bloom-limit`=2E

Maybe =
intended?


File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/30/comment/3bedc9b0_320a7f1a?usp=3Demail :
PS11, Line 2646:     =
    if (ft->limit < limit)
Is this check inverted? The message below reads =
like it expects `>` here=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30=
/comment/a98c18ba_6413bc93?usp=3Demail :
PS11, Line 2650:                  =
       "limit (%d)=2E",
I can't find `connect-freq-limit-initial` anywhere=
=2E It doesn't appear to be a valid option=2E


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/30/comment/db55ae2b_f8cecbe1?usp=3Demail :
PS11, Line 6037:=
             int num_hash =3D atoi(p[1]);
This should be `p[2]`=2E


File s=
rc/openvpn/ovpn_dco_linux=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
30/comment/d5e076fe_a0280445?usp=3Demail :
PS11, Line 18:     OVPN_CIPHER_A=
LG_CHACHA20_POLY1305,
This whole file seems to be in this changeset only be=
cause it has been automatically reformatted=2E It should probably be remove=
d, as there's nothing to review here=2E


File src/openvpn/reflect_filter=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/1eb65eb7_fe2b9=
00c?usp=3Demail :
PS11, Line 119:      * can then keep the counter in the b=
loom filter itself small (2 bits)
2 bits? Aren't the counters 4 bits (as me=
ntioned in comments elsewhere)?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/30/comment/6199e9bf_3af1a187?usp=3Demail :
PS11, Line 221:     }
The `if =
(low =3D=3D 4)` check here is unnecessary, since just `return low;` instead=
 of the whole branch does the same thing=2E


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/30/comment/f77fcc74_01ea4a42?usp=3Demail :
PS11, Line 290:   =
      gc_free(&gc);
These `gc_new()`/`gc_free()` calls appear to be dead co=
de=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/bd61c9f7_b22c=
3e67?usp=3Demail :
PS11, Line 340:         bloom_clear(irl->bf);
`bloom_fil=
ter_check_reset()` already calls `bloom_clear()`, no need to call it again =
explicitly=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/e57ef=
488_9f474b46?usp=3Demail :
PS11, Line 451:     irl =3D NULL;
This is dead c=
ode, as it sets the stack pointer parameter to `NULL` with no effects insid=
e the function and no change for the caller=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
Gerri=
t-Change-Number: 30
Gerrit-PatchSet: 11
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Max Fillinger=
 <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Comment-Date: Mon, 26 Oct 2026 12:10:21 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: Yes

--RSVjhf80OEA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwab=
e=2E</p><p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?us=
p=3Demail">View Change</a></p><p>15 comments:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File Changes=2Emd=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/9741d65c_0c4c14d0?usp=3Demail">P=
atch Set #11, Line 28:</a> <code style=3D"font-family:monospace,monospace">=
  To avoid the limitation of ``--connect-freq-initial`` to block legimitate=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Typo: &quot;legitimate&quot;=2E</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/f2324306_a5d9f81f?usp=3Demail">Patch S=
et #11, Line 260:</a> <code style=3D"font-family:monospace,monospace">   ``=
--conect-freq-initial``=2E</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Typo: &quot;connect&quot;=2E</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/481d06=
98_44c5764e?usp=3Demail">Patch Set #11, Line 292:</a> <code style=3D"font-f=
amily:monospace,monospace">   Every limit configured with this option will =
put more more entries into</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Typo: &quot;more more&quot;=2E</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bloom=
=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/3593e6d1_ffce2ece?usp=3Demai=
l">Patch Set #11, Line 82:</a> <code style=3D"font-family:monospace,monospa=
ce"> * increase the buckets (bit counters) at the the index positions 77, 3=
23,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Typo: &quot;the the&quot;=2E</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/bloom=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/30/comment/9f1d3032_697d2636?usp=3Demail">Patch Set #11, Line 240=
:</a> <code style=3D"font-family:monospace,monospace">    return bloom_add_=
test(bf, item, len, -1);</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">`bloom_add_test()` takes a `bloom_count=
er_t` for its last parameter (`-1` here)=2E That is `typedef uint32_t bloom=
_counter_t;` so will end up being `0xffffffff` here, which is then logicall=
y interpreted as `true`, so a remove will actually increment the counters=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/15742640_4a083830=
?usp=3Demail">Patch Set #11, Line 337:</a> <code style=3D"font-family:monos=
pace,monospace">                                                      &amp;=
t-&gt;options=2Einitial_cf_bloom_config);</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">`&amp;t-&gt;options=2E=
initial_cf_bloom_config` can obviously never be `NULL`, so the filter is al=
ways allocated even without `--connect-freq-initial-bloom-limit`=2E</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">May=
be intended?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/3bedc9b0=
_320a7f1a?usp=3Demail">Patch Set #11, Line 2646:</a> <code style=3D"font-fa=
mily:monospace,monospace">        if (ft-&gt;limit &lt; limit)</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
s this check inverted? The message below reads like it expects `&gt;` here=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/co=
mment/a98c18ba_6413bc93?usp=3Demail">Patch Set #11, Line 2650:</a> <code st=
yle=3D"font-family:monospace,monospace">                        &quot;limit=
 (%d)=2E&quot;,</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">I can&#39;t find `connect-freq-limit-initial` an=
ywhere=2E It doesn&#39;t appear to be a valid option=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/db55ae2b_f8cecb=
e1?usp=3Demail">Patch Set #11, Line 6037:</a> <code style=3D"font-family:mo=
nospace,monospace">            int num_hash =3D atoi(p[1]);</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This=
 should be `p[2]`=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/ovpn_dco_linux=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/c=
omment/d5e076fe_a0280445?usp=3Demail">Patch Set #11, Line 18:</a> <code sty=
le=3D"font-family:monospace,monospace">    OVPN_CIPHER_ALG_CHACHA20_POLY130=
5,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">This whole file seems to be in this changeset only because it=
 has been automatically reformatted=2E It should probably be removed, as th=
ere&#39;s nothing to review here=2E</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/reflect_filter=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/30/comment/1eb65eb7_fe2b900c?usp=3Demail">Patch Set #11, Line 11=
9:</a> <code style=3D"font-family:monospace,monospace">     * can then keep=
 the counter in the bloom filter itself small (2 bits)</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">2 bits?=
 Aren&#39;t the counters 4 bits (as mentioned in comments elsewhere)?</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/619=
9e9bf_3af1a187?usp=3Demail">Patch Set #11, Line 221:</a> <code style=3D"fon=
t-family:monospace,monospace">    }</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">The `if (low =3D=3D 4)` chec=
k here is unnecessary, since just `return low;` instead of the whole branch=
 does the same thing=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/30/comment/f77fcc74_01ea4a42?usp=3Demail">Patch Set #11, Lin=
e 290:</a> <code style=3D"font-family:monospace,monospace">        gc_free(=
&amp;gc);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">These `gc_new()`/`gc_free()` calls appear to be dead c=
ode=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30=
/comment/bd61c9f7_b22c3e67?usp=3Demail">Patch Set #11, Line 340:</a> <code =
style=3D"font-family:monospace,monospace">        bloom_clear(irl-&gt;bf);<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">`bloom_filter_check_reset()` already calls `bloom_clear()`, no n=
eed to call it again explicitly=2E</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/e57ef488_9f474b46?usp=3Demail">Patch S=
et #11, Line 451:</a> <code style=3D"font-family:monospace,monospace">    i=
rl =3D NULL;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">This is dead code, as it sets the stack pointer par=
ameter to `NULL` with no effects inside the function and no change for the =
caller=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">change 30</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> =
Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I0a9274cab7fefce3b13c0505=
2fb9a072e0bfa6b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
30 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 12:10:21 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--RSVjhf80OEA=--


--===============8708000469268915052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8708000469268915052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8708000469268915052==--

