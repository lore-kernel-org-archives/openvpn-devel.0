Message-Id: <200304301543.h3UFh4122753@...41...>
Subject: Re: [Openvpn-devel] 2nd release candidate for 1.4.0
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030430124639.GB974@...30...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr 30 09:00:05 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...5...>, openvpn-devel@lists.sourceforge.net

Alberto Gonzalez Iniesta <agi@...5...> said:

> Builds and works like a charm in Debian.
> 
> Building OpenVPN with FRAGMENT_ENABLE shouldn't affect tunnels against
> older versions without this option, right?

Correct.

> In that case, I think I'll enable this option in Debian's packages so
> we can get some testing/feedback on it. Good idea?

FRAGMENT_ENABLE is still pretty experimental, so I would hesitate to enable it
by default.  Since I have not enabled it for the most of the pre-1.4.0 testing
I have done, I think it would make more sense to leave it off in default
distributions, lest it produce any surprises.

On the other hand, there's a bunch of new infrastructure to handle dynamic
MTUs (In mtu.[ch]).  This is enabled by default and has been part of the test
cycle.

James


