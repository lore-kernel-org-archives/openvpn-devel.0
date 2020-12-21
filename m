Date: Mon, 21 Dec 2020 01:32:54 +0100
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20201221003254.GC10523@...2038...>
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
MIME-Version: 1.0
In-Reply-To: <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Anno domini 2020 Greg Cox scripsit:

Hi,

[...]
> So IMO, 1-2 are fundamental, 3-5 are
> wishlist/consideration/extensions/ideas, use or ignore as you see fit:
> * Make the ability for receiving messages on a client as described.
> Enabled by default, maybe selectively disable-able because someone will
> think it's spammy, but I'd almost suggest not allowing it.
> * Make the ability to send a user a message via management.  Enabled by
> default, maybe selectively disable-able as a safety mechanism / make
> someone "key the mic to speak."
> * Make the ability to 'wall' a message out to all connected users in one
> command, e.g. 'wall "server going down in 5 mins"' or something like that.
> * Make the ability to 'post' a message for some amount of time, e.g.
> 'wallpost 60m "server going down at 1700"'  Sending a message gets someone
> who is connected now, but misses the user who connects 2m after I go
> through the list of users and I stop looking.  So, this would hang around
> and pop a message to everyone connected now, plus each new connection, for
> the next 60m.
> * Add an option ala --[no-]use-expired-certs.  When true, proceed like you
> do today; when false, if certs are expired, have the client feed itself a
> message via this mechanism to popup that your certs are expired, so a user
> knows right away what's wrong.  It'd be a spammy option if it tried to tell
> you what to do, so I'm keeping the idea simple and generic.

From what I learnedof our university VPN setup: +1 to everything he said :)

Best
Max
-- 
 "First they ignore you,
  then they laugh at you,
  then they fight you,
  then you win."         -- Mahatma Gandhi

