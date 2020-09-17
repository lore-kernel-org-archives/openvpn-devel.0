From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200916141755.1923-1-themiron@...2010...>
 <202009170845.08H8juQs054283@...2054...>
 <000001d68cd0$2dd4df20$897e9d60$@yandex-team.ru>
 <20200917085739.GQ976@...1296...>
In-Reply-To: <20200917085739.GQ976@...1296...>
Date: Thu, 17 Sep 2020 14:33:12 +0500
Message-ID: <002101d68cd5$906f1510$b14d3f30$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix fatal error at
 switching remotes (#629)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi, Gert

> > That "fix for real" is about persist_remote_ip option as far as I
> > understand, not directly related to this fatal assert fix.
> 
> Well, the whole preresolve / connection entry "complex" is old and has
been
> extended and updated a few times, and your SVR patch also builds on top of
> that. 

That's true, I hit this assert for SRV initially, 'coz same advancing logic
was used, v5 version is upcoming following this commit.

> At some point, refactoring is needed...
> (We have some other thing to consider which is even more intrusive - when
we
> reconnect to a different IP address, and that new IP address is currently
routed
> into the tunnel, we need to set up new /32 host routes before moving to a
new
> server can work... openvpn3, as I understand, sets up "all host routes!"
right at
> the start, but that might or might not be the best solution either)

New address is being handled in disconnected (yet) state, so tunnel routes
should not be active, since 2.x supports at most one tunnel active.
While this is preserved, /32 host route can be made anytime between resolved
state and connection attempt, sounds not so intrusive, if I got you right.

Meanwhile, "--persist-remote-ip" documented as "Preserve most recently
authenticated remote IP address and port number across SIGUSR1 and
--ping-restart".
Current implementation doesn't follow it precisely, instead it does
"Preserve most recently authenticated remote host name and port...", if that
remote name resolves into multiple addresses - they will be still iterated.
Guess, this is what was meant by "fix by real"

> 
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
feed
> honest figures into a computer, honest figures come out. Never doubted  it
> myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
Mistress
> 
> Gert Doering - Munich, Germany
gert@...1296...


