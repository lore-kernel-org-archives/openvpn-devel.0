Date: Mon, 24 Dec 2012 12:35:41 +0100 (CET)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <552859909.6142.1356348941142.JavaMail.root@...1795...>
In-Reply-To: <50D6F4EA.6050504@...1227...>
References: <50D6F4EA.6050504@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

----- Original Message -----
> From: "Arne Schwabe" <arne@...1227...>
> To: openvpn-devel@lists.sourceforge.net
> Sent: Sunday, 23 December, 2012 1:11:22 PM
> Subject: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
> 
> Hello,
> 
> I fear we may have to delay the final release. While debugging a
> problem
> with a user of my app I found a nasty bug which causes OpenVPN to
> crash
> if two PUSH_CONTROL messages are received.

This is not good news :(  Well, I agree, we need to sort this one out.  We can't release with this bug.  Having that said, I'm not sure if the commit 5d4f5435a421299ed047485d8d99bdf9a0d22fd1 is the core issue to this bug, or if it just flushes out another corner case.  That commit was added to solve an issue introduced in commit ff65da3a230b658b2c1d52dc1a48612e80a2eb42, but James pointed me at some other things to check out as well.  But I've never had enough time to dig deeper on that topic.  Without commit 5d4f5435a421299ed047485d8d99bdf9a0d22fd1, the client will never be able to re-connect to the server before its SSL context expires and is re-created.  Which leads me to think that we're having a new corner case.

Anyhow, we need to fix this ... and I'm going offline now until after new year, so I have no chance digging into this topic now, unfortunately.  But I would prefer to solve both commit 5d4f5435a421299ed047485d8d99bdf9a0d22fd1 and this new issue in a better way then.



kind regards,

David Sommerseth





> from push.c:
> 
>        if (!c->c2.did_pre_pull_restore)
>          {
>            pre_pull_restore (&c->options);
>            md5_state_init (&c->c2.pulled_options_state);
>            c->c2.did_pre_pull_restore = true;
>          }
> 
> This is executed on the first push message and initializes the md5
> state. On further push messages (continuation or new) this is not
> executed again.
> 
>        if (apply_push_options (&c->options,
>                    &buf,
>                    permission_mask,
>                    option_types_found,
>                    c->c2.es))
>          switch (c->options.push_continuation)
>            {
>            case 0:
>            case 1:
>          md5_state_update (&c->c2.pulled_options_state,
>          BPTR(&buf_orig),
> BLEN(&buf_orig));
>          md5_state_final (&c->c2.pulled_options_state,
> &c->c2.pulled_options_digest);
>          ret = PUSH_MSG_REPLY;
> 
> This finalizes the md5 state. leaving pulled_options_state in a
> uninitialized or at least undefined state. If a second push message
> after a final message is received md5_state_update will use this
> undefined context
> 
>          break;
>            case 2:
>          md5_state_update (&c->c2.pulled_options_state,
>          BPTR(&buf_orig),
> BLEN(&buf_orig));
>          ret = PUSH_MSG_CONTINUATION;
>          break;
>            }
> 
> To trigger this issue there have multiple things.
> 
> * A OpenVPN 2.3 server (commit
> 5d4f5435a421299ed047485d8d99bdf9a0d22fd1
> allows duplicate sending of this message), you can also simply
> duplicate
> the send_push_something method call to trigger this bug on clients
> * A bit flaky connection. The GSM/UMTS networks are great for this.
> They
> sometimes wait a very long time to deliver the packet (like 30s)
> without
> dropping packets
> 
> I think the bug also exists in 2.2 clients but I have not done
> extensive
> checks.  Since push_control messages have no sequence number or such
> it
> is difficult to determine how to only apply the push messages only
> once.
> 
> A quick&dirty hack is to simply md5_state_init the state after the
> md5_state_final.
> 
> Arne

