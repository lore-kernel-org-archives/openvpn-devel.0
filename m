Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79011CC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5HXqPtiZkbR1IbnaexpXzdR5euvDAIkyodRXfw3weU=; b=MWgpp3fhbUzHgi8LFjjCbPjD+Y
	lEp9oDMlop6r+CMKdapfQvXFqHOd8R8OvgeSmSaDO9UXvuj9834cg7MHp8Cf0DVrHsCYGA/wZNuFO
	40AldmBuAK4AN85JLXe1b1o3AoT7G7Fs9a6sQ3yYrQbHZuUPsThfxEbwIpv034Ghxghs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHMl7-00057G-05;
	Thu, 15 Oct 2026 14:48:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1xHMl4-000578-HQ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wv8OkTUgYUOtNuwZQUyh2JpSZiMkI0A19hmzeccZzo=; b=lWykOlanl3mYJIQigtGzNWFVMI
 B9y+4RKBmY5R+7dfZ2X82K71vg+rU7GvWwzC7VHRXggITis2pllSSxqZ97RfmFLCGWj8wLjzlPVlP
 HLxtl+EPSNyasPNlodkusx9HyNAOEnGjXSvkIOjJIqtpLQcA+tVR2VY1dZ6JLNPFB/vg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+wv8OkTUgYUOtNuwZQUyh2JpSZiMkI0A19hmzeccZzo=; b=XKxjHnABHJ6Mki4togIuIMQ1oL
 EdBmSx1Aa0WSQE43dwANxF6IwSZ80x8MNR1x57qIdUQJrpYGs8tVmEB2Z4Pd0+L2IGUPilL7zLCCM
 gIupgQdELgWJ9p/exWPS83gEMZOx/V6beQKzBLbsxh42AzZWqtwFI9zruACYg5KZJMhE=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHMl3-00038Q-5Q for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:48:39 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4j59tP1qkZz9tYt;
 Thu, 15 Oct 2026 16:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1792075709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wv8OkTUgYUOtNuwZQUyh2JpSZiMkI0A19hmzeccZzo=;
 b=Zfzybo0O9t8sXMJMMsePVT592SjzBc/GNxYqh3X1Pa6EWOmDTIJ3w/60EVj7ZHKY4ABvEj
 avteQz18FEjqQFny2zNmQHcb3z/nVMNhVMttuwikM8Pc4GPCANyrXC1D5v927QOd+rVdIL
 zXp2olUtHN+6XCEPXcVhaE3SNhGnzFQSXflLD+VKqA6/5ipSAgBrvOQGznLOCwI2EhjyqB
 jSMYsVNDIwuRnRiIvm2Ynd2Z9a3Hmgz4TMtzr0FcmYlJpq30eMTWTu6JgZ9A1irEGd09Dr
 4anxk675JhBpk8fC/6quHRk25Az/oN7f/LX5BIruwo4WTKziQSTiupcR7Sa7SA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Thu, 15 Oct 2026 16:48:26 +0200
Message-ID: <20261015144827.494747-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <as4hyq85bV916Ktb@krikkit>
References: <as4hyq85bV916Ktb@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j59tP1qkZz9tYt
X-Headers-End: 1xHMl3-00038Q-5Q
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next 4/8] ovpn: convert GSO
 input into UDP GSO output
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Sabrina,

On Tue, 13 Oct 2026 14:19:22 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-10-01, 10:41:23 +0200, Ralf Lici wrote:
> >  void ovpn_encrypt_post(void *data, int ret)
> >  {
> > +	unsigned int orig_len, packets = 1;
> >  	struct ovpn_crypto_key_slot *ks;
> >  	struct sk_buff *skb = data;
> >  	struct ovpn_socket *sock;
> > +	struct ovpn_cb *batch_cb;
> >  	struct ovpn_peer *peer;
> > -	unsigned int orig_len;
> > +	struct sk_buff *batch;
> >  
> >  	/* encryption is happening asynchronously. This function will be
> >  	 * called later by the crypto callback with a proper return value
> > @@ -249,15 +259,19 @@ void ovpn_encrypt_post(void *data, int ret)
> >  	if (unlikely(ret == -EINPROGRESS))
> >  		return;
> >  
> > -	ks = ovpn_skb_cb(skb)->ks;
> > +	/* ordinary encryption leaves batch zeroed; a GSO input uses it to find
> > +	 * the aggregate whose lifetime is shared by all segment requests
> > +	 */
> > +	batch = ovpn_skb_cb(skb)->batch;
> >  	peer = ovpn_skb_cb(skb)->peer;
> > +	ks = ovpn_skb_cb(skb)->ks;
> >  
> >  	/* crypto is done, cleanup skb CB and its members */
> >  	kfree(ovpn_skb_cb(skb)->crypto_tmp);
> >  
> >  	if (unlikely(ret == -ERANGE)) {
> >  		/* we ran out of IVs and we must kill the key as it can't be
> > -		 * use anymore
> > +		 * used anymore
> >  		 */
> >  		netdev_warn(peer->ovpn->dev,
> >  			    "killing key %u for peer %u\n", ks->key_id,
> > @@ -265,8 +279,30 @@ void ovpn_encrypt_post(void *data, int ret)
> >  		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
> >  			/* let userspace know so that a new key must be negotiated */
> >  			ovpn_nl_key_swap_notify(peer, ks->key_id);
> > +	}
> >  
> > -		goto err;
> > +	if (batch) {
> > +		batch_cb = ovpn_skb_cb(batch);
> > +		/* every segment publishes its result before releasing its
> > +		 * pending count and only the final completion continues with
> > +		 * the aggregate
> > +		 */
> > +		if (unlikely(ret < 0))
> > +			atomic_set(&batch_cb->batch_state.failed, 1);
> > +
> > +		kfree_skb(skb);
> > +		if (!atomic_dec_and_test(&batch_cb->batch_state.pending))
> > +			return;
>
> Without reviewing the whole thing in detail:
>
> You're getting into the same kind of horrible mess that ktls had to
> deal with because of async crypto... maybe AI reviews manage to make
> this type of code actually work now, but I wouldn't bet my life on
> that.
>

Oh, that sounds a bit unsettling.

Thanks for the pointer though, I went through kTLS's history and I think
I have identified what you're referring to: commit a42055e8d2c3
("net/tls: Add support for async encryption of records for performance")
and the long chain of fixes that followed. However, just by reading that
commit message, I think we're really talking about two very different
architectures.

In this series, the batch size and output aggregate are fixed before the
first submission, and the pending count already includes every segment.
Each request owns one input skb and writes only to a disjoint output
range. The aggregate remains alive, and its peer and key references
remain held, until every request has reached a terminal completion.

There is no ordered ready list, userspace buffer handoff, partial
transmitted record, waiter or worker. The final completion simply sends
or drops the aggregate.

We also exercised this path with the asynchronous Safexcel backend on
the GL.iNet routers, so it survived async crypto in that setup.

If you see an async-specific lifetime or ordering case that this design
does not cover, I'd appreciate a pointer. If necessary, we could gate
the batching path to synchronous backends, although so far I don't see a
concrete reason to do so.

Thanks.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
