From: Stefan `Sec` Zehl <sec+ovpn@...306...>
Message-ID: <20041110000335.GB17347@...307...>
References: <twig.1100040511.60533@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1100040511.60533@...41...>
Subject: [Openvpn-devel] Re: [Openvpn-users] IANA has approved a unique port number for OpenVPN
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
Date: Tue Nov  9 16:04:00 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Tue, Nov 09, 2004 at 22:48 -0000, James Yonan wrote:
> I just got a note from IANA confirming that they've assigned TCP/UDP
> port 1194 to OpenVPN.
[...]
> I'd be inclined to make the change before 2.0 final is released.  Any other
> opinions?

Can the server support listening on two ports at the same time? This
would make migration much easier.

CU,
    Sec
-- 
Not a perfect solution, but far cheaper than one.

