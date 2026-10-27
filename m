Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18540606A334
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hOWsfQnd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EEZdedSB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nMZkJsA0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bIhxbhDh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sHjVUySbwWKnUuMejK0MU7mgsSeaXP1RhdZDLLwL4DU=; b=hOWsfQndafOJTFCzDShRDdMcfN
	fYl9XU5nRXP5N3U8kE9mEz3Rxku+Tg0J9zJm1hbezNL75s+WqQ39C3TOcnZiiA3P07LZDpaSgljhn
	hyjefNjl2aKEj3yaoIoACiOugpcq+ImLa7KgfJijzy+Qs03qVgxU56lJ1D27Vbhbu350=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLglY-000000002jn-3vso;
	Tue, 27 Oct 2026 12:59:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLglR-000000002jT-1GEg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1z9Ubc/1i3Qqzf1GaR3U6ErAfLF4oKvmv7amBnvlcdE=; b=EEZdedSB0bRvGWEgRrJ2ocKnCo
 gtj/3hWdFcxaFE+VjVdyIZS+e+CA5iUI0g6I9mF5RHGqy9SvN90h5m7YOdXfeg21RPoihB2r6ebBW
 xajuci01Sb4xS5uikzFrRYgOQX/E0rlBTwAZV7800O+aPJVDCP8Oi72FyAWT/oCFPBJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1z9Ubc/1i3Qqzf1GaR3U6ErAfLF4oKvmv7amBnvlcdE=; b=nMZkJsA0n9dbIU799iYY2OtxoM
 cWeR3LpR8eU6GWFWzQFWp1NgtwzmhWWpGVmpdBXisu/e/m2wxVaX+fGnZC6CEdRCht/ygBwUXFSxJ
 Z0W3odgKC6xYjQY1iCHbstsRNAZQIjmTY9oGNFitHklSXhJ+KUhJT6/8fbs8D4w5DTGg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLglQ-0000000066v-2TA4 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:58:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso22724215e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793105926; x=1793710726; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1z9Ubc/1i3Qqzf1GaR3U6ErAfLF4oKvmv7amBnvlcdE=;
 b=bIhxbhDhxm6imgH7psvdErubsNMLKpVkiT1zHgXvETefCk2xXtR1QNWuoyXoFHYCxu
 BbCaEK53G/N2Igr55V/9ssmocLZ7apM/QA9A9ZhifHarVUoDRiJJS/5m51XJKRElgmUe
 r/kqI1WORbjU7pseFAjMTCFVIaEa6cCDpjJLIQsI/fe6yFVKlmAE93nE8GsDHKkpbQD7
 +d+rFf6dsMytcZyrlzU1Uz9tZ+SoAiUb5yNud4e0yOluGcElAkQapxSJzYoHmBeVtUyZ
 6msFQfCLWO2YH+alEAMCv279HyE/C9EKGOjnd3uYJiJjI99QXuJXY56eleZidy/fRtYD
 cdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105926; x=1793710726;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1z9Ubc/1i3Qqzf1GaR3U6ErAfLF4oKvmv7amBnvlcdE=;
 b=ioKi9ADJy5koQh5UcDMGoK+6YTERO1OixKR97cdfwThQesNzsMActHZrtoI9BZ58N9
 g3GyqANnIQQkBHCHXTxJ5ur58HrutQFgxxX2vBuufqlNV9N6Cr+qK6+Z4sMotSWNCnVD
 Z6Z1txuINx6sf1IMRMLjvA5V14iVAaBLqYi6SO+vrf334Yqn3oYjlHgcr9MbewgSROBI
 7dJJDILlmWW5KFGnml8iwqxMdszjbg45bniFGK6BK9PRu27+xzVodNa+v9PwvdYmNlSf
 PE3+P1Uh0U1kgY2QcxIALtCWdSTIMI0hkC43QfurdJ/8cHpu7baeWNQqRpYlJW51tk3x
 wU4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlbodz84aYMX9dKIJa5QMHfNJmNKhNuTGPEEOE8/zUf4KOS84wEZxwPnFfUKue9D9EyBtib9zC9bgDcyi8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIAlN2WBOFV3GbSFJd4nA8EQBw1nawAguAdP6RQbeBtRFnY9y/y
 2vat2XyOt5TzSoRvluEJfM8iIK9nWnQ24zRNvQ/2/zgCFbc6wfnjI7E8bh6K7EHk0Ji875+jAnW
 1vnuidsmAen/vGuSjVimD0DzWKs7WbhCYzzkrb0gMYHQGh13SvENn8CEAItJuMM5g0GsYoAG/Ab
 WkgUP4Ig==
X-Gm-Gg: AYBFou0q/ykkbDX/boH5L14Qevsdvtlptlz5NruQUBzCz98Q3H/69vQz5e4DyXZAGXa
 ygnj0xBPDHzrQDcvm5IqpijrRnzSuU81b4BwP7+zmIGMQV4Wmb7XE1y3ACHqWxMO9gc5YFmnwms
 7rVx3unROtehGX5ztJGbnw4W/JBbcC7ixV1G2bkM7mzTSBvcECEPOBIt0oi2X84iGtJAT7OozV2
 b/N5Y/+y1zoRO5qAzwQywRy8O85bIg4C5Qn9p47XOJi/kCUgJL/aMkyzQarA3W6uOhkPDM+CWyq
 eGqLz58dLOzFZ3RRS1y6voBm7y3VgXLBV8jH4LBqn4uDqZxVDW1v37zCvn2wPm3maIa9ow8X1a4
 7JBSiXHBGvHtLy+1NAJgT86gxPRLDU13+BbgVRf02H2mqfoM9R0iJqL3s/jmLc2ZQC4QFURDByJ
 lIYekjYOajR6relnMCvzKo1GJfW32dqEYqi7yHb6JaLQeMTvPgmfSRXMVssfEOAAto6B/rfS5fI
 CWxMdrjgcB3Rm7s4G+4pqkRggftgMgFjpJYfb2JDt1aOq1ozaSJRYyJeAJ0txfLeCtAis2mdlo5
 kCC1W/dUOLoJOEvu3ZCizfWeE1qG4eJPB1EFCz9blK6C1PItf9raa3nOwGWS0YEeZpls/aMpcDK
 zaqJqESeToyyWfY1ueciT3kylXbRNI9D2zOm5OhAatQ==
X-Received: by 2002:a05:600c:524d:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4a7444042ecmr76703875e9.4.1793105925763; 
 Tue, 27 Oct 2026 05:58:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm690595885e9.1.2026.10.27.05.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:58:44 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:58:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 8599bbe2a80721125ceef7b527c44548eb2c53bf
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 12:58:41 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0f0803848b9445903fd3bf2231847fe0607120a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLglQ-0000000066v-2TA4
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4970797673194810640=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4970797673194810640==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QerD5MtxckA="; charset=UTF-8

--QerD5MtxckA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: Code-Revie=
w-1

(5 comments)

File doc/man-sections/management-options=2Erst:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/b67c247c_6f626231?usp=3Dem=
ail :
PS15, Line 142:   :code:`unixscript` this option has no effect since =
a disconnect will
"unixscript" should be "unix-script"=2E


File src/openvp=
n/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/5faa27=
66_fa5fff5f?usp=3Demail :
PS15, Line 4388:                      PACKAGE_NAM=
E "_omi_%08" PRIx64 "%08" PRIx64 "=2Esock",
This prints out a 64-bit value =
so it could theoretically exceed the 8 digits zero-padding=2E Maybe we don'=
t care, but this should be `%016` if we want to guarantee constant-length o=
utput=2E


File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1852/comment/e293095f_a1b6c012?usp=3Demail :
PS15, Line 343: 
Stra=
y newline added?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/=
5a2683ef_0214a7f4?usp=3Demail :
PS15, Line 2213:             }
The extra `{=
}` block seems unnecessary=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1852/comment/92041235_65062e2d?usp=3Demail :
PS15, Line 3484:              =
   && !openvpn_waitpid_check(man->connection=2Eunix_script_pid, msg_prefix,=
 M_FATAL))
`openvpn_waitpid_check()` calls `msg(msglevel, "%scould not exec=
ute external program (exit code 127)", msg_prefix);`, so this will output t=
hings like `ERROR: Failed running management unix-scriptmy message here`=2E=




-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436a=
a782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 15
G=
errit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 27 Oct 2026 12:58:41 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--QerD5MtxckA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 15:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/managemen=
t-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/b67c247c_6f62=
6231?usp=3Demail">Patch Set #15, Line 142:</a> <code style=3D"font-family:m=
onospace,monospace">  :code:`unixscript` this option has no effect since a =
disconnect will</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;unixscript&quot; should be &quot;unix-scri=
pt&quot;=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/5faa2766_f=
a5fff5f?usp=3Demail">Patch Set #15, Line 4388:</a> <code style=3D"font-fami=
ly:monospace,monospace">                     PACKAGE_NAME &quot;_omi_%08&qu=
ot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Esock&quot;,</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This pr=
ints out a 64-bit value so it could theoretically exceed the 8 digits zero-=
padding=2E Maybe we don&#39;t care, but this should be `%016` if we want to=
 guarantee constant-length output=2E</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852/comment/e293095f_a1b6c012?usp=3Demail">Patch Set #15, Line 343:</a=
> <code style=3D"font-family:monospace,monospace"></code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Stray newline=
 added?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
852/comment/5a2683ef_0214a7f4?usp=3Demail">Patch Set #15, Line 2213:</a> <c=
ode style=3D"font-family:monospace,monospace">            }</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
extra `{}` block seems unnecessary=2E</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/92041235_65062e2d?usp=3Demail">Pa=
tch Set #15, Line 3484:</a> <code style=3D"font-family:monospace,monospace"=
>                &amp;&amp; !openvpn_waitpid_check(man-&gt;connection=2Euni=
x_script_pid, msg_prefix, M_FATAL))</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">`openvpn_waitpid_check()` ca=
lls `msg(msglevel, &quot;%scould not execute external program (exit code 12=
7)&quot;, msg_prefix);`, so this will output things like `ERROR: Failed run=
ning management unix-scriptmy message here`=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=
=3Demail">change 1852</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 15 </div>
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
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 12:58:41 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--QerD5MtxckA=--


--===============4970797673194810640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4970797673194810640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4970797673194810640==--

