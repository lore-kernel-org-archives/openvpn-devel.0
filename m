From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN Project Update
Message-ID: <20020914221924.GA32072@...33...>
References: <200209142140.g8ELejG07122@...41...>
Mime-Version: 1.0
In-Reply-To: <200209142140.g8ELejG07122@...41...>
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
Date: Sat Sep 14 15:20:02 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, 14 Sep 2002, James Yonan wrote:

> (1) Forking server support
> (2) Automatic Secure MTU discovery
> (3) IPv6 endpoints or IPv6 over tun device
> (4) Windows port
> 
> While none of these (with perhaps the exception of the last :) is
> rocket science, all require some work, and given that OpenVPN has
> reached a nice stability plateau, I'd like to hear your opinions on
> future directions in the development effort.

ad 1) what's this good for? Sharing one port? Won't really work with
      UDP. Convenience? Go get daemontools, or let's figure if openvpn
      can be run from xinetd. Not something that should be done unless
      you're really bored or have some compelling reason (a malicious
      person holding a gun against your head might be one). Don't waste
      your time.

ad 2) I'd like to see that somewhen in the future, but I'd give IPv6 the
      preference.

ad 3) IPv6 is certainly something that will have to be added.

ad 4) If they want secure networking, they shouldn't be running an
      operating system of which the current version forces you to
      register with the vendor, sending data you don't control.

      It may be a moot point, but IMHO Windows which is made and sold by
      a company that's always looking at its own profit, acting to its
      own advantage, no matter how ruthless, and that aims to harm
      OpenSource just to fortify its monopoly, to make more money, and
      to control ever more markets to further maximize its huge
      revenues, should not be supported by OpenSource developers.

      If your opinion differs from mine, that's called freedom. :-)

-- 
Matthias Andree

