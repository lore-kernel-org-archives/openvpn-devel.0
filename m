From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Re: [Openvpn-users] Windows tun driver
Message-ID: <20030916225743.GB25900@...33...>
References: <946499570EB7294690F512C1EF182F881EB893@...102...> <twig.1063664530.85975@...41...> <twig.1063741646.19515@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1063741646.19515@...41...>
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
Date: Tue Sep 16 15:58:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 16 Sep 2003, James Yonan wrote:

> > I'd like to challenge the "better" claim:
> 
> I mean "better" only in the sense of simpler configuration -- i.e. not needing
> to set up a WINS server to make cross-subnet browsing work.  I agree that tun
> is more scalable, secure, etc.

After being through setting up a tap for a particular configuration
(pure ethernet with fallback to OpenVPN-on-WLAN), tap isn't easier to
configure than tun either. --ifconfig is one reason, although it's going
to get competition, getting routing right if you "tap" one IP into an
existing eth subnet is non-trivial and requires like 4 lines of --up
scripting.

My Linux distro also defaults to ethertap rather than tun, so if you're
running SuSE, better make sure you load the "tun" module early. ethertap
won't work with tun at the other end of the pipe -- different framing
apparently.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

