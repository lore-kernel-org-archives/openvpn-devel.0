From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20040205145013.GA25559@...33...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Idea for --ifconfig & co.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Feb  5 06:53:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

would it be feasible to have openvpn create interfaces (--ifconfig or
something) in "down" state until a remote peer connects - unless the
tunnel is marked persistent?

I know I can do this with scripts, but it might be the natural choice to
reflect the tunnel status in interface configuration.

Thanks,
Matthias

