Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-Id: <50D78118.1010400@...1400...>
Message-ID: <50D6F4EA.6050504@...1227...>
Date: Sun, 23 Dec 2012 13:11:22 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I fear we may have to delay the final release. While debugging a problem 
with a user of my app I found a nasty bug which causes OpenVPN to crash 
if two PUSH_CONTROL messages are received.

from push.c:

       if (!c->c2.did_pre_pull_restore)
         {
           pre_pull_restore (&c->options);
           md5_state_init (&c->c2.pulled_options_state);
           c->c2.did_pre_pull_restore = true;
         }

This is executed on the first push message and initializes the md5 
state. On further push messages (continuation or new) this is not 
executed again.

       if (apply_push_options (&c->options,
                   &buf,
                   permission_mask,
                   option_types_found,
                   c->c2.es))
         switch (c->options.push_continuation)
           {
           case 0:
           case 1:
         md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), 
BLEN(&buf_orig));
         md5_state_final (&c->c2.pulled_options_state, 
&c->c2.pulled_options_digest);
         ret = PUSH_MSG_REPLY;

This finalizes the md5 state. leaving pulled_options_state in a 
uninitialized or at least undefined state. If a second push message 
after a final message is received md5_state_update will use this 
undefined context

         break;
           case 2:
         md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), 
BLEN(&buf_orig));
         ret = PUSH_MSG_CONTINUATION;
         break;
           }

To trigger this issue there have multiple things.

* A OpenVPN 2.3 server (commit 5d4f5435a421299ed047485d8d99bdf9a0d22fd1 
allows duplicate sending of this message), you can also simply duplicate 
the send_push_something method call to trigger this bug on clients
* A bit flaky connection. The GSM/UMTS networks are great for this. They 
sometimes wait a very long time to deliver the packet (like 30s) without 
dropping packets

I think the bug also exists in 2.2 clients but I have not done extensive 
checks.  Since push_control messages have no sequence number or such it 
is difficult to determine how to only apply the push messages only once.

A quick&dirty hack is to simply md5_state_init the state after the 
md5_state_final.

Arne

