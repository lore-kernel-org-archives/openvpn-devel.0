Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F6ECDE001
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Reply-To:From:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:MIME-Version:Date:
	Message-ID:Content-Type:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gnIW3ON1y6gQXagzDv915Eyo0j3WWpfLp3SVlRBLt5U=; b=N6vRK0vEUEQ7E0JVyjCzVHkGh4
	Wh0DwGcrYKLwB+2msp5qxvPR4mDRBK4MW30pIP6JVfqQL7oYFLhiI9mBBQZNmjbW7B5/Rru2dtLv1
	jHh8/U7LKtvyCLM8XaRdsJt/AxIqC7dB9yc5LRzn1yWQF/N0SyCtCn/jUqswPQOeyHLM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcl9p-0005Nd-Mp;
	Thu, 25 Jun 2026 14:34:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tnyberg@midjourney.com>) id 1wcl9n-0005NW-SI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:From:To:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1LItePHyImmdniYoB0CRtTgN2qUsgC3W+wqnIR5n9AA=; b=dhJkXFNVJCRm0ZQeru8imfd3V5
 sXYJOnLJaejP6OQfnAdDivwTfHlMW6/ZGrn4bTMiAiIP9Pvh+KTvKsHEWCgC8bqM7F6p0xuuwKIbP
 lPAHJvw3NlVP3y3kkQG3gGwayNE7aFkyRyUKrpeHZTscqXo6xzw1pP0AK/SkMTEOCJpQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:From:To:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1LItePHyImmdniYoB0CRtTgN2qUsgC3W+wqnIR5n9AA=; b=m
 C0UNEOTixW7f7mLXpoIB+cdgyKza12YoD/d1sGOwzvXe5pPrdBHEMrmJWY8gyGSIvw5JcEjFfSZHk
 xnlgAhL9l9NWgEQgcILEoU0GiZpyP3JrcGSS5AGmFo874T5jx9H0HhQJNk08oI3oLq9pCss+ZzEt+
 zC//D6kjmQQYvZyQ=;
Received: from mail-lj1-f181.google.com ([209.85.208.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcl9m-0004Cg-Gy for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:34:20 +0000
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39676ff4674so21159181fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=midjourney.com; s=google; t=1782398047; x=1783002847;
 darn=lists.sourceforge.net; 
 h=subject:from:to:content-language:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1LItePHyImmdniYoB0CRtTgN2qUsgC3W+wqnIR5n9AA=;
 b=pxFL003xFKRJMtDWRU8Qe0RFsz2Ut6GBGTcs2UaobYBhXIU//NwC1htmJiI07l4QfL
 bXPZ9K29mhfasO4MY3GOvYxoxGZtsVdF1HUbiSQrJG/pASEnUcUbshguUsjl9Hrgpkx0
 xV8sAfsdO8dgiatSmGyC+mVT28+RrEuojWl2tnvduE+8rofMYkVRA0OAG+EnYSWHnlSL
 43BE3px6d9OQaFA+lKFE3AqGzRZ+hhrMnuAtkRmPrp3TF7ip6lwGERtInKqjodejou4G
 OYgZrAtu57bQujPmM8Jvh6lsZ+Sx0bGxPkmw1485ZPjQFWaF3RY7r7kIT3kNeJdwZvMc
 BEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398047; x=1783002847;
 h=subject:from:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LItePHyImmdniYoB0CRtTgN2qUsgC3W+wqnIR5n9AA=;
 b=A2j5ut40/L+/EKSu7v5o9EvRTkt99YbXJb/7c00wvrh9Ivl0liLL94pQkvllKPFO1N
 2b8ZCQtFW1HUGRE+F0a88/bK6TPyQ5BvCZCnMIjSubFx6/VyZywH+fXJtTsZEDZ+hq7I
 cvHayVCjjpiXwZujvTZK4rIBEBQZ+HnORZwwGSBVgzpjf2LENmZ2AolWJHGK+KjZb2g+
 rvFNg7g2pst8uWkGWf+CbIF5882hL0sLOulm+E72v3JSe0/jyXvl37ZjaXteVhf78jKP
 nHBi6drxatfc3+9fY4OdxopEH+faNuaB38lgdf+UVM7IwRHIydUAa0lhXCfsbJGn2u/V
 DS/w==
X-Gm-Message-State: AOJu0YxSU7HhGPzoP/RQSz0dor7kTnPfzXiJiErozgV/sfXzD4Dztian
 daaZrC/d/f2NJNuNocs8GmJ7+NVgEbrvGC1ljh4e4UhXKPOZjni2Fx5ROvXUyCs1UOGTTjUbGHY
 Ie8PHH5TSfQ==
X-Gm-Gg: AfdE7ckLbfUCklFYzFAxQbI+DE4aHJZ+pgAjVoV8FztEP9bZqNKb+aJzSzrGk2k/kod
 JVgEtspsjv2D0St0jT4likbhoNJD3zCwDwuZMdU8u80Cq1qkAEAbnBy8HdVij6lGlXzzH8kRVpW
 AKZYOjiScHg323O8gRX84Tv2sCWKcGe0GL70PDlu3Vji1J9THS4qn612QRz7fid/Z9wHBMGaTmM
 SlA37hMJtkM5Y3+6OwM+10gCjeN8BZDmSSCTyROvqzLpK2FJBAwnCH7bppuiOlPKLYg8JttryFy
 /IMThtzJg7TlEo+pDn5sw9Z7wNS/wyUhkGjosmEU3D6yswG2a0L2i2HOJJNGFB/9/nUH5P4FXU3
 8p+kDXPcr971y0f91WW7swdhIjyA36HYWCHo6kPKDpIpjcyAuW8kjz85KCG37jv6QgGMK/wHtv/
 yMpqp9DD5LUegsU2It3Q8TkW9n5gvP232ebN2tEO/31KTcVbC6TYHpZaoJMADuTxeYdyrJbcumv
 d82
X-Received: by 2002:a05:6000:1847:b0:45f:f142:d56f with SMTP id
 ffacd0b85a97d-46dc092ed15mr4280556f8f.12.1782396378347; 
 Thu, 25 Jun 2026 07:06:18 -0700 (PDT)
Received: from [192.168.100.107] (109-81-172-38.rct.o2.cz. [109.81.172.38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e6167c05fsm1173584f8f.25.2026.06.25.07.06.17
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 07:06:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------XD2qKJ4VJdRH9PYI4rZSoXaW"
Message-ID: <5afdb852-eabf-4829-b95f-6a322ed5d56a@midjourney.com>
Date: Thu, 25 Jun 2026 16:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: openvpn-devel@lists.sourceforge.net
X-Headers-End: 1wcl9m-0004Cg-Gy
Subject: [Openvpn-devel] =?utf-8?q?=5BRFC=5D_Backport_request=3A_7791f535_?=
 =?utf-8?q?=28=23919_fix=29_to_release/2=2E6_=E2=80=94_DCO_peer-table_desy?=
 =?utf-8?q?nc?=
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
From: Thomas Nyberg via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Thomas Nyberg <tnyberg@midjourney.com>
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------XD2qKJ4VJdRH9PYI4rZSoXaW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Full disclosure: I used Claude for a lot of this work including the text
below. That said, I was very thorough in all the testing I've done here and
been careful to verify the bugs and was careful to read through the details
below. But I don't want to pretend like there weren't robots involved...

7791f535 ("dco: process messages immediately after read", fixes #919) is in
master and release/2.7, but not in release/2.6. 2.6.x DCO server deployments
are still exposed to the underlying bug, and it bites hard at scale. I'd 
like
to ask whether you'd consider a release/2.6 backport -- and, since it 
can't be
a straight cherry-pick, what form you'd prefer. I have a validated 
adaptation
I can submit via Gerrit (attached here for reference).

(Context: Debian stable / trixie ships 2.6.14 + the out-of-tree ovpn-dco
module, so this affects the current Debian stable DCO server users.)

IMPACT ON 2.6.x
---------------
On a busy DCO server, when many peers are deleted in a short window -- 
e.g. a
transient that makes a large number of peers time out near-simultaneously --
libnl delivers multiple netlink messages per nl_recvmsgs(), but the 2.6 DCO
read path stores each notification into single-slot dco_context_t fields and
only processes the last, silently dropping the rest (exactly as #919
describes). Userspace then never reaps those client instances -> 
n_clients is
never decremented -> the instances leak. Eventually the server hits
--max-clients and refuses new/reconnecting clients until openvpn is 
restarted.

Reproduced on stock 2.6.14:

   - 1024 DCO clients connected; server under CPU load (I used
     "stress-ng --cpu 64" to simulate a reconnection storm); then block the
     server's inbound VPN packets at the firewall to simulate a network
     outage, which makes all peers hit their --keepalive timeout at close to
     the same time.

   - The kernel expires and deletes all the peers, but openvpn drops some of
     the DEL_PEER notifications and leaks the corresponding client instances
     (never reaped, so n_clients stays high). The number leaked is
     nondeterministic -- it depends on how many notifications get coalesced
     into a single nl_recvmsgs() read, so it varies run-to-run and with load
     (it is not a fixed count; as one example, a run left 767 of 1024
     instances stale).

   - Those leaked instances still occupy --max-clients slots, so once enough
     accumulate, reconnecting clients are rejected with "MULTI: new incoming
     connection would exceed maximum number of clients", and the only 
recovery
     is restarting openvpn. (Both the management interface and the 
status file
     report the leaked count -- they read the same multi_context client 
list.)

A CLEAN CHERRY-PICK IS NOT POSSIBLE
-----------------------------------
I verified 7791f535 and its prerequisites do not apply to release/2.6:

   - a699681b ("dco: only pass struct context to init function" -- 
introduces
     dco->c) and 7f5a6dea ("multi: store multi_context address inside top
     instance" -- introduces c->multi): 7791f535 relies on both 
(dco->c->mode
     / dco->c->multi), and neither is in release/2.6. a699681b alone 
conflicts
     in 5 files against v2.6.14 (the ovpn_dco_init() signature differs --
     release/2.6 predates the dev_node parameter).

   - 7791f535 itself: conflicts in 7 files -- release/2.6 has no multi_io.c,
     uses the pre-rename netlink API (OVPN_CMD_DEL_PEER vs 
PEER_DEL_NTF), and a
     different multi_process_incoming_dco() signature.

So the intervening 2.7 DCO / new-module work sits between 2.6 and these
commits; any 2.6 backport requires a genuine adaptation.

THE ADAPTATION I HAVE (VALIDATED)
---------------------------------
The attached patch corresponds most closely to 7791f535 -- that is the 
commit
to diff it against. The two prerequisites (a699681b, 7f5a6dea) are not 
carried
as such; their effect (dco->c, c->multi) is inlined as the c/multi
back-pointers described below. The patch mirrors 7791f535's logic 
against the
old ovpn-dco API:

   - Move per-message processing into the libnl parse callback
     (ovpn_handle_msg), so each notification is acted on before the next
     overwrites the single-slot fields -- the core of 7791f535.

   - Port the __is_locked guard around nl_recvmsgs() (checked in the 
GET_PEER
     stats senders) to avoid the re-entrant stats request during parsing.

   - Because 2.6 lacks dco->c (a699681b) and c->multi (7f5a6dea), add 
c/multi
     back-pointers to dco_context_t, set at the three event-loop call sites
     (mtcp.c, mudp.c, forward.c), and dispatch server-vs-client on 
dco->multi.

Validated on a load rig (2.6.14 + the buggy out-of-tree module rebuilt 
against
6.12): the desync is gone -- repeated 1024-peer deletion storms under
stress-ng drain to 0 with no stale instances, reconnect to 1024 with zero
max-clients rejections, no regressions, survives reboot.

A note on the attached patch's format: it is a Debian quilt patch (with a
DEP-3 header), because I developed and validated it directly against the
current Debian openvpn 2.6.14 source package -- i.e. it applies on top 
of that
package's existing patch series, which is what 2.6.x users actually run. 
That
is purely how it was produced/tested; I'm happy to reshape it as a plain
git format-patch against release/2.6 for Gerrit.

QUESTIONS
---------
1. Would you accept a release/2.6 backport of #919's fix?

2. If so, which approach do you prefer:
    (a) also backport the prerequisites (a699681b for dco->c and 
7f5a6dea for
        c->multi) so the result is closer to upstream, or
    (b) a minimal self-contained adaptation (like mine) that adds just the
        c/multi back-pointers locally?

3. I'm happy to submit it through Gerrit in whatever shape you'd want and to
    iterate on review -- I'm aware it's a hand-port and would value
    DCO-maintainer eyes on the back-pointer lifetime / dispatch / lock
    placement.

The patch is attached; full validation details (logs etc.) available on
request.

REFERENCES (commit diffs, for comparison against the attached patch)
--------------------------------------------------------------------
   #919 (the bug):
     https://github.com/OpenVPN/openvpn/issues/919
   7791f535 -- dco: process messages immediately after read (THE commit this
   patch corresponds to; diff the attached patch against this one):
  
https://github.com/OpenVPN/openvpn/commit/7791f5358a5574d4ef1bd27e2d52300c9d98bd72
     (Gerrit: https://gerrit.openvpn.net/c/openvpn/+/1403 )
   a699681b -- dco: only pass struct context to init function (prerequisite;
   introduces dco->c, inlined as a back-pointer rather than carried):
  
https://github.com/OpenVPN/openvpn/commit/a699681bb86c6e9a2c9f205543f60400208aea4b
   7f5a6dea -- multi: store multi_context address inside top instance
   (prerequisite; introduces c->multi, inlined as a back-pointer):
  
https://github.com/OpenVPN/openvpn/commit/7f5a6deae33a338a23d7e8ff8526db8fdddf4bc2

Thanks,
Thomas Nyberg
--------------XD2qKJ4VJdRH9PYI4rZSoXaW
Content-Type: text/x-patch; charset=UTF-8;
 name="dco-process-messages-immediately-after-read-2.6-backport.patch"
Content-Disposition: attachment;
 filename*0="dco-process-messages-immediately-after-read-2.6-backport.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RGVzY3JpcHRpb246IGRjbzogcHJvY2VzcyBtZXNzYWdlcyBpbW1lZGlhdGVseSBhZnRlciBy
ZWFkCiBCYWNrcG9ydCBvZiB1cHN0cmVhbSA3NzkxZjUzNThhNTU3NGQ0ZWYxYmQyN2UyZDUy
MzAwYzlkOThiZDcyLiBsaWJubCBkZWxpdmVycwogbXVsdGlwbGUgbmV0bGluayBtZXNzYWdl
cyBwZXIgbmxfcmVjdm1zZ3MoKSBjYWxsLCBidXQgdGhlIERDTyByZWFkIHBhdGggc3RvcmVk
CiBlYWNoIGludG8gc2luZ2xlLXNsb3QgZGNvX2NvbnRleHRfdCBmaWVsZHMgYW5kIHByb2Nl
c3NlZCBvbmx5IHRoZSBsYXN0LAogc2lsZW50bHkgZHJvcHBpbmcgdGhlIHJlc3QuIFVuZGVy
IGEgcGVlci1kZWxldGlvbiBzdG9ybSB0aGlzIGRlc3luY3Mgb3BlbnZwbgogY2xpZW50IHRh
YmxlIGZyb20gdGhlIGtlcm5lbCAoZ2hvc3QgaW5zdGFuY2VzIC0+IG1heC1jbGllbnRzIGxv
Y2tvdXQpLiBQcm9jZXNzCiBlYWNoIG1lc3NhZ2UgaW5zaWRlIHRoZSBwYXJzZSBjYWxsYmFj
aywgd2l0aCBhIGxvY2sgdG8gYXZvaWQgcmUtZW50cmFudAogR0VUX1BFRVIgc3RhdHMgcmVx
dWVzdHMgZHVyaW5nIHBhcnNpbmcuIEFkYXB0ZWQgdG8gMi42LnggKGFkZHMgYy9tdWx0aQog
YmFja3BvaW50ZXJzIHRvIGRjb19jb250ZXh0X3QsIHdoaWNoIDIuNyBoYXMgbmF0aXZlbHkp
LgpPcmlnaW46IGJhY2twb3J0LCBodHRwczovL2dpdGh1Yi5jb20vT3BlblZQTi9vcGVudnBu
L2NvbW1pdC83NzkxZjUzNThhNTU3NGQ0ZWYxYmQyN2UyZDUyMzAwYzlkOThiZDcyCkJ1Zzog
aHR0cHM6Ly9naXRodWIuY29tL09wZW5WUE4vb3BlbnZwbi9pc3N1ZXMvOTE5CkZvcndhcmRl
ZDogbm90LW5lZWRlZAotLS0KSW5kZXg6IG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rj
by5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIG9wZW52cG4tMi42LjE0Lm9yaWcvc3JjL29wZW52cG4v
ZGNvLmgKKysrIG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rjby5oCkBAIC0xMzQsNyAr
MTM0LDcgQEAgdm9pZCBjbG9zZV90dW5fZGNvKHN0cnVjdCB0dW50YXAgKnR0LCBvcAogICog
QHBhcmFtIGRjbyAgICAgICB0aGUgRENPIGNvbnRleHQKICAqIEByZXR1cm4gICAgICAgICAg
MCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UKICAqLwot
aW50IGRjb19kb19yZWFkKGRjb19jb250ZXh0X3QgKmRjbyk7CitpbnQgZGNvX3JlYWRfYW5k
X3Byb2Nlc3MoZGNvX2NvbnRleHRfdCAqZGNvKTsKIAogLyoqCiAgKiBJbnN0YWxsIGEgRENP
IGluIHRoZSBtYWluIGV2ZW50IGxvb3AKQEAgLTMwMSw3ICszMDEsNyBAQCBjbG9zZV90dW5f
ZGNvKHN0cnVjdCB0dW50YXAgKnR0LCBvcGVudnBuCiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50
Ci1kY29fZG9fcmVhZChkY29fY29udGV4dF90ICpkY28pCitkY29fcmVhZF9hbmRfcHJvY2Vz
cyhkY29fY29udGV4dF90ICpkY28pCiB7CiAgICAgQVNTRVJUKGZhbHNlKTsKICAgICByZXR1
cm4gMDsKSW5kZXg6IG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rjb19saW51eC5jCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIG9wZW52cG4tMi42LjE0Lm9yaWcvc3JjL29wZW52cG4vZGNvX2xp
bnV4LmMKKysrIG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rjb19saW51eC5jCkBAIC00
MCw2ICs0MCw3IEBACiAjaW5jbHVkZSAic3NsLmgiCiAjaW5jbHVkZSAiZmRtaXNjLmgiCiAj
aW5jbHVkZSAibXVsdGkuaCIKKyNpbmNsdWRlICJmb3J3YXJkLmgiCiAjaW5jbHVkZSAic3Ns
X3ZlcmlmeS5oIgogCiAjaW5jbHVkZSAib3Zwbl9kY29fbGludXguaCIKQEAgLTUxLDYgKzUy
LDE1IEBACiAjaW5jbHVkZSA8bmV0bGluay9nZW5sL2N0cmwuaD4KIAogCisvKiBXaGVuIHBh
cnNpbmcgbXVsdGlwbGUgREVMX1BFRVIgbm90aWZpY2F0aW9ucywgb3BlbnZwbiB0cmllcyB0
byByZXF1ZXN0IHN0YXRzCisgKiBmb3IgZWFjaCBERUxfUEVFUiBtZXNzYWdlLiBUaGlzIHRy
aWdnZXJzIGEgR0VUX1BFRVIgcmVxdWVzdC1yZXBseSB3aGlsZSB3ZQorICogYXJlIHN0aWxs
IHBhcnNpbmcgdGhlIHJlc3Qgb2YgdGhlIGluaXRpYWwgbm90aWZpY2F0aW9ucywgd2hpY2gg
Y2FuIGxlYWQgdG8KKyAqIE5MRV9CVVNZIG9yIGV2ZW4gTkxFX05PTUVNLiBUaGlzIGJhc2lj
IGxvY2sgZW5zdXJlcyB3ZSBkb24ndCBiaXRlIG91ciBvd24KKyAqIHRhaWwgYnkgaXNzdWlu
ZyBhIGRjb19nZXRfcGVlcl9zdGF0cyB3aGlsZSBzdGlsbCBidXN5IHJlY2VpdmluZyBhbmQg
cGFyc2luZworICogb3RoZXIgbWVzc2FnZXMuIChiYWNrcG9ydCBvZiB1cHN0cmVhbSA3Nzkx
ZjUzNSkKKyAqLworc3RhdGljIGJvb2wgX19pc19sb2NrZWQgPSBmYWxzZTsKKwogLyogbGli
bmwgPCAzLjUuMCBkb2VzIG5vdCBzZXQgdGhlIE5MQV9GX05FU1RFRCBvbiBpdHMgb3duLCB0
aGVyZWZvcmUgd2UKICAqIGhhdmUgdG8gZXhwbGljaXRseSBkbyBpdCB0byBwcmV2ZW50IHRo
ZSBrZXJuZWwgZnJvbSBmYWlsaW5nIHVwb24KICAqIHBhcnNpbmcgb2YgdGhlIG1lc3NhZ2UK
QEAgLTEzMSw3ICsxNDEsOSBAQCBubGFfcHV0X2ZhaWx1cmU6CiBzdGF0aWMgaW50CiBvdnBu
X25sX3JlY3Ztc2dzKGRjb19jb250ZXh0X3QgKmRjbywgY29uc3QgY2hhciAqcHJlZml4KQog
eworICAgIF9faXNfbG9ja2VkID0gdHJ1ZTsKICAgICBpbnQgcmV0ID0gbmxfcmVjdm1zZ3Mo
ZGNvLT5ubF9zb2NrLCBkY28tPm5sX2NiKTsKKyAgICBfX2lzX2xvY2tlZCA9IGZhbHNlOwog
CiAgICAgc3dpdGNoIChyZXQpCiAgICAgewpAQCAtODEzLDExICs4MjUsMjIgQEAgb3Zwbl9o
YW5kbGVfbXNnKHN0cnVjdCBubF9tc2cgKm1zZywgdm9pZAogICAgICAgICAgICAgcmV0dXJu
IE5MX1NLSVA7CiAgICAgfQogCisgICAgLyogcHJvY2VzcyB0aGUgbWVzc2FnZSBpbW1lZGlh
dGVseSwgYmVmb3JlIHRoZSBuZXh0IG9uZSBwYXJzZWQgaW4gdGhlIHNhbWUKKyAgICAgKiBu
bF9yZWN2bXNncygpIGJhdGNoIG92ZXJ3cml0ZXMgdGhlIHNpbmdsZS1zbG90IGRjbyBmaWVs
ZHMgKi8KKyAgICBpZiAoZGNvLT5tdWx0aSkKKyAgICB7CisgICAgICAgIG11bHRpX3Byb2Nl
c3NfaW5jb21pbmdfZGNvKGRjbyk7CisgICAgfQorICAgIGVsc2UKKyAgICB7CisgICAgICAg
IHByb2Nlc3NfaW5jb21pbmdfZGNvKGRjbyk7CisgICAgfQorCiAgICAgcmV0dXJuIE5MX09L
OwogfQogCiBpbnQKLWRjb19kb19yZWFkKGRjb19jb250ZXh0X3QgKmRjbykKK2Rjb19yZWFk
X2FuZF9wcm9jZXNzKGRjb19jb250ZXh0X3QgKmRjbykKIHsKICAgICBtc2coRF9EQ09fREVC
VUcsIF9fZnVuY19fKTsKICAgICBubF9jYl9zZXQoZGNvLT5ubF9jYiwgTkxfQ0JfVkFMSUQs
IE5MX0NCX0NVU1RPTSwgb3Zwbl9oYW5kbGVfbXNnLCBkY28pOwpAQCAtOTI1LDYgKzk0OCwx
MiBAQCBkY29fZ2V0X3BlZXJfc3RhdHNfbXVsdGkoZGNvX2NvbnRleHRfdCAqCiB7CiAgICAg
bXNnKERfRENPX0RFQlVHLCAiJXMiLCBfX2Z1bmNfXyk7CiAKKyAgICBpZiAoX19pc19sb2Nr
ZWQpCisgICAgeworICAgICAgICBtc2coRF9EQ09fREVCVUcsICIlczogY2Fubm90IHJlcXVl
c3QgcGVlciBzdGF0cyB3aGlsZSBwYXJzaW5nIG90aGVyIG1lc3NhZ2VzIiwgX19mdW5jX18p
OworICAgICAgICByZXR1cm4gMDsKKyAgICB9CisKICAgICBzdHJ1Y3QgbmxfbXNnICpubF9t
c2cgPSBvdnBuX2Rjb19ubG1zZ19jcmVhdGUoZGNvLCBPVlBOX0NNRF9HRVRfUEVFUik7CiAK
ICAgICBubG1zZ19oZHIobmxfbXNnKS0+bmxtc2dfZmxhZ3MgfD0gTkxNX0ZfRFVNUDsKQEAg
LTk3OSw2ICsxMDA4LDEyIEBAIGRjb19wYXJzZV9wZWVyKHN0cnVjdCBubF9tc2cgKm1zZywg
dm9pZAogaW50CiBkY29fZ2V0X3BlZXJfc3RhdHMoc3RydWN0IGNvbnRleHQgKmMpCiB7Cisg
ICAgaWYgKF9faXNfbG9ja2VkKQorICAgIHsKKyAgICAgICAgbXNnKERfRENPX0RFQlVHLCAi
JXM6IGNhbm5vdCByZXF1ZXN0IHBlZXIgc3RhdHMgd2hpbGUgcGFyc2luZyBvdGhlciBtZXNz
YWdlcyIsIF9fZnVuY19fKTsKKyAgICAgICAgcmV0dXJuIDA7CisgICAgfQorCiAgICAgdWlu
dDMyX3QgcGVlcl9pZCA9IGMtPmMyLnRsc19tdWx0aS0+ZGNvX3BlZXJfaWQ7CiAgICAgbXNn
KERfRENPX0RFQlVHLCAiJXM6IHBlZXItaWQgJWQiLCBfX2Z1bmNfXywgcGVlcl9pZCk7CiAK
SW5kZXg6IG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rjb19saW51eC5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIG9wZW52cG4tMi42LjE0Lm9yaWcvc3JjL29wZW52cG4vZGNvX2xpbnV4LmgK
KysrIG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Rjb19saW51eC5oCkBAIC0zNiw2ICsz
Niw4IEBACiB0eXBlZGVmIGVudW0gb3Zwbl9rZXlfc2xvdCBkY29fa2V5X3Nsb3RfdDsKIHR5
cGVkZWYgZW51bSBvdnBuX2NpcGhlcl9hbGcgZGNvX2NpcGhlcl90OwogCitzdHJ1Y3QgY29u
dGV4dDsKK3N0cnVjdCBtdWx0aV9jb250ZXh0OwogCiB0eXBlZGVmIHN0cnVjdAogewpAQCAt
NTAsNiArNTIsMTEgQEAgdHlwZWRlZiBzdHJ1Y3QKIAogICAgIHVuc2lnbmVkIGludCBpZmlu
ZGV4OwogCisgICAgLyogYmFja3BvaW50ZXJzIHNldCBiZWZvcmUgZWFjaCByZWFkIHNvIHRo
ZSBwYXJzZSBjYWxsYmFjayBjYW4gcHJvY2VzcworICAgICAqIGEgbWVzc2FnZSBpbW1lZGlh
dGVseSAoYmFja3BvcnQgb2YgdXBzdHJlYW0gNzc5MWY1MzUpICovCisgICAgc3RydWN0IGNv
bnRleHQgKmM7CisgICAgc3RydWN0IG11bHRpX2NvbnRleHQgKm11bHRpOworCiAgICAgaW50
IGRjb19tZXNzYWdlX3R5cGU7CiAgICAgaW50IGRjb19tZXNzYWdlX3BlZXJfaWQ7CiAgICAg
aW50IGRjb19kZWxfcGVlcl9yZWFzb247CkluZGV4OiBvcGVudnBuLTIuNi4xNC9zcmMvb3Bl
bnZwbi9mb3J3YXJkLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gb3BlbnZwbi0yLjYuMTQub3JpZy9z
cmMvb3BlbnZwbi9mb3J3YXJkLmMKKysrIG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Zv
cndhcmQuYwpAQCAtMTIzNCwxMyArMTIzNCwxMSBAQCBwcm9jZXNzX2luY29taW5nX2xpbmso
c3RydWN0IGNvbnRleHQgKmMpCiAgICAgcGVyZl9wb3AoKTsKIH0KIAotc3RhdGljIHZvaWQK
LXByb2Nlc3NfaW5jb21pbmdfZGNvKHN0cnVjdCBjb250ZXh0ICpjKQordm9pZAorcHJvY2Vz
c19pbmNvbWluZ19kY28oZGNvX2NvbnRleHRfdCAqZGNvKQogewogI2lmIGRlZmluZWQoRU5B
QkxFX0RDTykgJiYgKGRlZmluZWQoVEFSR0VUX0xJTlVYKSB8fCBkZWZpbmVkKFRBUkdFVF9G
UkVFQlNEKSkKLSAgICBkY29fY29udGV4dF90ICpkY28gPSAmYy0+YzEudHVudGFwLT5kY287
Ci0KLSAgICBkY29fZG9fcmVhZChkY28pOworICAgIHN0cnVjdCBjb250ZXh0ICpjID0gZGNv
LT5jOwogCiAgICAgLyogRnJlZUJTRCBjdXJyZW50bHkgc2VuZHMgdXMgcmVtb3ZhbCBub3Rp
ZmNhdGlvbiB3aXRoIHRoZSBvbGQgcGVlci1pZCBpbgogICAgICAqIHAycCBtb2RlIHdpdGgg
dGhlIHBpbmcgdGltZW91dCByZWFzb24sIHNvIGlnbm9yZSB0aGF0IG9uZSB0byBub3Qgc2hv
b3QKQEAgLTIzMDksNyArMjMwNyw5IEBAIHByb2Nlc3NfaW8oc3RydWN0IGNvbnRleHQgKmMp
CiAgICAgewogICAgICAgICBpZiAoIUlTX1NJRyhjKSkKICAgICAgICAgewotICAgICAgICAg
ICAgcHJvY2Vzc19pbmNvbWluZ19kY28oYyk7CisgICAgICAgICAgICBjLT5jMS50dW50YXAt
PmRjby5jID0gYzsKKyAgICAgICAgICAgIGMtPmMxLnR1bnRhcC0+ZGNvLm11bHRpID0gTlVM
TDsKKyAgICAgICAgICAgIGRjb19yZWFkX2FuZF9wcm9jZXNzKCZjLT5jMS50dW50YXAtPmRj
byk7CiAgICAgICAgIH0KICAgICB9CiB9CkluZGV4OiBvcGVudnBuLTIuNi4xNC9zcmMvb3Bl
bnZwbi9mb3J3YXJkLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gb3BlbnZwbi0yLjYuMTQub3JpZy9z
cmMvb3BlbnZwbi9mb3J3YXJkLmgKKysrIG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL2Zv
cndhcmQuaApAQCAtNzQsNiArNzQsMTMgQEAgdm9pZCBwcmVfc2VsZWN0KHN0cnVjdCBjb250
ZXh0ICpjKTsKIAogdm9pZCBwcm9jZXNzX2lvKHN0cnVjdCBjb250ZXh0ICpjKTsKIAorLyoq
CisgKiBQcm9jZXNzIGFuIGluY29taW5nIERDTyBtZXNzYWdlIChmcm9tIGtlcm5lbCBzcGFj
ZSkuCisgKgorICogQHBhcmFtIGRjbyAtIFBvaW50ZXIgdG8gdGhlIHN0cnVjdHVyZSByZXBy
ZXNlbnRpbmcgdGhlIERDTyBjb250ZXh0LgorICovCit2b2lkIHByb2Nlc3NfaW5jb21pbmdf
ZGNvKGRjb19jb250ZXh0X3QgKmRjbyk7CisKIC8qKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogLyoqCiAg
KiBQcm9jZXNzIGEgZGF0YSBjaGFubmVsIHBhY2tldCB0aGF0IHdpbGwgYmUgc2VudCB0aHJv
dWdoIGEgVlBOIHR1bm5lbC4KSW5kZXg6IG9wZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL210
Y3AuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSBvcGVudnBuLTIuNi4xNC5vcmlnL3NyYy9vcGVudnBu
L210Y3AuYworKysgb3BlbnZwbi0yLjYuMTQvc3JjL29wZW52cG4vbXRjcC5jCkBAIC03NDcs
NyArNzQ3LDkgQEAgbXVsdGlfdGNwX3Byb2Nlc3NfaW8oc3RydWN0IG11bHRpX2NvbnRleAog
ICAgICAgICAgICAgLyogaW5jb21pbmcgZGF0YSBvbiBEQ08/ICovCiAgICAgICAgICAgICBl
bHNlIGlmIChlLT5hcmcgPT0gTVRDUF9EQ08pCiAgICAgICAgICAgICB7Ci0gICAgICAgICAg
ICAgICAgbXVsdGlfcHJvY2Vzc19pbmNvbWluZ19kY28obSk7CisgICAgICAgICAgICAgICAg
bS0+dG9wLmMxLnR1bnRhcC0+ZGNvLm11bHRpID0gbTsKKyAgICAgICAgICAgICAgICBtLT50
b3AuYzEudHVudGFwLT5kY28uYyA9ICZtLT50b3A7CisgICAgICAgICAgICAgICAgZGNvX3Jl
YWRfYW5kX3Byb2Nlc3MoJm0tPnRvcC5jMS50dW50YXAtPmRjbyk7CiAgICAgICAgICAgICB9
CiAjZW5kaWYKICAgICAgICAgICAgIC8qIHNpZ25hbCByZWNlaXZlZD8gKi8KSW5kZXg6IG9w
ZW52cG4tMi42LjE0L3NyYy9vcGVudnBuL211ZHAuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBvcGVu
dnBuLTIuNi4xNC5vcmlnL3NyYy9vcGVudnBuL211ZHAuYworKysgb3BlbnZwbi0yLjYuMTQv
c3JjL29wZW52cG4vbXVkcC5jCkBAIC00MDksMTEgKzQwOSw5IEBAIG11bHRpX3Byb2Nlc3Nf
aW9fdWRwKHN0cnVjdCBtdWx0aV9jb250ZXgKICAgICB7CiAgICAgICAgIGlmICghSVNfU0lH
KCZtLT50b3ApKQogICAgICAgICB7Ci0gICAgICAgICAgICBib29sIHJldCA9IHRydWU7Ci0g
ICAgICAgICAgICB3aGlsZSAocmV0KQotICAgICAgICAgICAgewotICAgICAgICAgICAgICAg
IHJldCA9IG11bHRpX3Byb2Nlc3NfaW5jb21pbmdfZGNvKG0pOwotICAgICAgICAgICAgfQor
ICAgICAgICAgICAgbS0+dG9wLmMxLnR1bnRhcC0+ZGNvLm11bHRpID0gbTsKKyAgICAgICAg
ICAgIG0tPnRvcC5jMS50dW50YXAtPmRjby5jID0gJm0tPnRvcDsKKyAgICAgICAgICAgIGRj
b19yZWFkX2FuZF9wcm9jZXNzKCZtLT50b3AuYzEudHVudGFwLT5kY28pOwogICAgICAgICB9
CiAgICAgfQogI2VuZGlmCkluZGV4OiBvcGVudnBuLTIuNi4xNC9zcmMvb3BlbnZwbi9tdWx0
aS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIG9wZW52cG4tMi42LjE0Lm9yaWcvc3JjL29wZW52cG4v
bXVsdGkuYworKysgb3BlbnZwbi0yLjYuMTQvc3JjL29wZW52cG4vbXVsdGkuYwpAQCAtMzI3
NSwxNCArMzI3NSwxMiBAQCBwcm9jZXNzX2luY29taW5nX2RlbF9wZWVyKHN0cnVjdCBtdWx0
aV9jCiAgICAgbXVsdGlfc2lnbmFsX2luc3RhbmNlKG0sIG1pLCBTSUdURVJNKTsKIH0KIAot
Ym9vbAotbXVsdGlfcHJvY2Vzc19pbmNvbWluZ19kY28oc3RydWN0IG11bHRpX2NvbnRleHQg
Km0pCit2b2lkCittdWx0aV9wcm9jZXNzX2luY29taW5nX2RjbyhkY29fY29udGV4dF90ICpk
Y28pCiB7Ci0gICAgZGNvX2NvbnRleHRfdCAqZGNvID0gJm0tPnRvcC5jMS50dW50YXAtPmRj
bzsKKyAgICBBU1NFUlQoZGNvLT5tdWx0aSk7CiAKLSAgICBzdHJ1Y3QgbXVsdGlfaW5zdGFu
Y2UgKm1pID0gTlVMTDsKLQotICAgIGludCByZXQgPSBkY29fZG9fcmVhZCgmbS0+dG9wLmMx
LnR1bnRhcC0+ZGNvKTsKKyAgICBzdHJ1Y3QgbXVsdGlfY29udGV4dCAqbSA9IGRjby0+bXVs
dGk7CiAKICAgICBpbnQgcGVlcl9pZCA9IGRjby0+ZGNvX21lc3NhZ2VfcGVlcl9pZDsKIApA
QCAtMzI5MSwxMiArMzI4OSwxMiBAQCBtdWx0aV9wcm9jZXNzX2luY29taW5nX2RjbyhzdHJ1
Y3QgbXVsdGlfCiAgICAgICovCiAgICAgaWYgKHBlZXJfaWQgPCAwKQogICAgIHsKLSAgICAg
ICAgcmV0dXJuIHJldCA+IDA7CisgICAgICAgIHJldHVybjsKICAgICB9CiAKICAgICBpZiAo
KHBlZXJfaWQgPCBtLT5tYXhfY2xpZW50cykgJiYgKG0tPmluc3RhbmNlc1twZWVyX2lkXSkp
CiAgICAgewotICAgICAgICBtaSA9IG0tPmluc3RhbmNlc1twZWVyX2lkXTsKKyAgICAgICAg
c3RydWN0IG11bHRpX2luc3RhbmNlICptaSA9IG0tPmluc3RhbmNlc1twZWVyX2lkXTsKICAg
ICAgICAgaWYgKGRjby0+ZGNvX21lc3NhZ2VfdHlwZSA9PSBPVlBOX0NNRF9ERUxfUEVFUikK
ICAgICAgICAgewogICAgICAgICAgICAgcHJvY2Vzc19pbmNvbWluZ19kZWxfcGVlcihtLCBt
aSwgZGNvKTsKQEAgLTMzMjUsMTMgKzMzMjMsNiBAQCBtdWx0aV9wcm9jZXNzX2luY29taW5n
X2RjbyhzdHJ1Y3QgbXVsdGlfCiAgICAgICAgICAgICAidHlwZSAlZCwgZGVsX3BlZXJfcmVh
c29uICVkIiwgcGVlcl9pZCwgZGNvLT5kY29fbWVzc2FnZV90eXBlLAogICAgICAgICAgICAg
ZGNvLT5kY29fZGVsX3BlZXJfcmVhc29uKTsKICAgICB9Ci0KLSAgICBkY28tPmRjb19tZXNz
YWdlX3R5cGUgPSAwOwotICAgIGRjby0+ZGNvX21lc3NhZ2VfcGVlcl9pZCA9IC0xOwotICAg
IGRjby0+ZGNvX2RlbF9wZWVyX3JlYXNvbiA9IC0xOwotICAgIGRjby0+ZGNvX3JlYWRfYnl0
ZXMgPSAwOwotICAgIGRjby0+ZGNvX3dyaXRlX2J5dGVzID0gMDsKLSAgICByZXR1cm4gcmV0
ID4gMDsKIH0KICNlbmRpZiAvKiBpZiBkZWZpbmVkKEVOQUJMRV9EQ08pICYmIGRlZmluZWQo
VEFSR0VUX0xJTlVYKSAqLwogCkluZGV4OiBvcGVudnBuLTIuNi4xNC9zcmMvb3BlbnZwbi9t
dWx0aS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIG9wZW52cG4tMi42LjE0Lm9yaWcvc3JjL29wZW52
cG4vbXVsdGkuaAorKysgb3BlbnZwbi0yLjYuMTQvc3JjL29wZW52cG4vbXVsdGkuaApAQCAt
MzIzLDcgKzMyMyw3IEBAIGJvb2wgbXVsdGlfcHJvY2Vzc19wb3N0KHN0cnVjdCBtdWx0aV9j
b24KICAqICAtIFRydWUsIGlmIHRoZSBtZXNzYWdlIHdhcyByZWNlaXZlZCBjb3JyZWN0bHku
CiAgKiAgLSBGYWxzZSwgaWYgdGhlcmUgd2FzIGFuIGVycm9yIHdoaWxlIHJlYWRpbmcgdGhl
IG1lc3NhZ2UuCiAgKi8KLWJvb2wgbXVsdGlfcHJvY2Vzc19pbmNvbWluZ19kY28oc3RydWN0
IG11bHRpX2NvbnRleHQgKm0pOwordm9pZCBtdWx0aV9wcm9jZXNzX2luY29taW5nX2Rjbyhk
Y29fY29udGV4dF90ICpkY28pOwogCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAvKioK

--------------XD2qKJ4VJdRH9PYI4rZSoXaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------XD2qKJ4VJdRH9PYI4rZSoXaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--------------XD2qKJ4VJdRH9PYI4rZSoXaW--

