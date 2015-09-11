From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:37 +0200
Message-Id: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] Route-Gateway redirection for IPv6 - finally
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

this is the block of code that is missing for 2.4 on the IPv6/routing
side (correctly handle IPv6 routes that overlap with the IPv6 address
of the VPN server) - if it's in, I'm ready to go...

01+02 are refactoring without functional code changes, to make the IPv6
data structures more similar to the IPv4 stuff (James changed all the
IPv4 just after the IPv6 payload stuff was merged...).

03+04+05+06 are the grunt of the change set - basic infrastructure for
detecting the IPv6 default gateway, implementation for Linux, actual
handling of overlapping IPv6 routes + VPN server address and gateway
redirection ("insert /128 host route").

07 is a trivial bonus patch to implement "--redirect-gateway ipv6"

08 is the implementation for all BSDs, MacOS and OpenSolaris
09 makes the /128 routes actually work on OpenSolaris

10 is the implementation for Windows (Vista and up).  
   THIS BREAKS WINDOWS XP COMPATIBILITY (and might need some additional
   tending depending on MinGW versions).

The patch set has fairly thoroughly tested on all(!) our supported OSes,
but there are so many possible variants of IPv6 routing setups that
there will still be combinations that break - we'll have to test, and
fix them as we go.

Arne: I'm fairly sure some "#ifndef TARGET_ANDROID" clauses will be
needed - that stuff isn't needed on Android, and might get in the way,
or at least confuse users.  Please feel free to send patch #11 :-)


