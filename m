References: <20210125125628.30364-3-arne@...1227...>
 <202102141519.11EFJaIF011452@...2054...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3eac0e44-77e3-f5ab-223e-d97d9f3b544a@...1227...>
Date: Mon, 15 Feb 2021 12:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <202102141519.11EFJaIF011452@...2054...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement client side
 handling of AUTH_PENDING message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 14.02.21 um 16:19 schrieb Gert Doering:
> Your patch has been applied to the master branch.
> 
> I'm not sure I understand the code, though.  It receives the new timeout
> from the server (that is easy), but then caps it by "hand_window", which
> is never increased - so the maximum timeout stays at "60", unless increased

hm  max_timeout is maximum of handshake_window and
renegotiate_seconds/2, so max(60,1800) in a default configuration.

> manually on the client.  Where am I misreading this?  Or is this a 
> prerequisite for this functionality?
> 
>     c->c2.push_request_timeout = ks->established + min_uint(max_timeout, server_timeout);

And here we normally take a minimum of 1800 and whatever the server pushed.


> (or am I totally misunderstanding push_request_timeout, and this has
> nothing to do with hand-window, except "it's using this as a default
> value", but only for triggering re-sends, not for "final give up"?)

This patch also splits two timeouts that before just happend to be
identical into two distinct timeouts. One time is the one that says how
TLS (re)negotiation is allowed to be (handshake_window) and the other
one is the pull timeout. The if condition in push.c shows their
relationship:

    if (c->c2.push_request_timeout > now
        && (now - ks->peer_last_packet) < c->options.handshake_window)

Basically give the user "max_timeout" time to answer the 2FA challenge
but only if the server has been alive in the last handshake_window seconds.

> However, for my standard test cases, this does not break anything, and
> the code looks reasonable.  So in it goes :)



