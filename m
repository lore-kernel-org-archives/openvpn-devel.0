From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Need 1.5 beta testers for *BSD, Linux 2.2, OS X
Message-ID: <20030831112825.GA30252@...33...>
References: <3F4F33C6.3020201@...61...> <twig.1062309326.34391@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1062309326.34391@...41...>
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
Date: Sun Aug 31 04:31:01 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 31 Aug 2003, James Yonan wrote:

> I'm thinking about something like this in a more generalized context, where
> OpenVPN running as a server would actually generate the config file for the
> client, and send it to the client via SSL after an initial authentication
> handshake.  This would simplify the configuration on the client side, and
> allow the server to send routes back to the client.

I wonder if this could be extended to a general configuration handshake,
where the client could opt out of some options, for example LZO
compression or tun vs. tap. (One should think the client would always
want to compress data to avoid redundancy-based or "known-plaintext"
attacks on the encrypted connection, but anyways.)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

