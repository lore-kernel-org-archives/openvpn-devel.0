From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
Message-ID: <20030502160707.GB29245@...33...>
References: <20030428142748.GA826@...30...>
Mime-Version: 1.0
In-Reply-To: <20030428142748.GA826@...30...>
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
Date: Fri May  2 09:34:56 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Mon, 28 Apr 2003, Alberto Gonzalez Iniesta wrote:

> Sorry for the huge forward, but everything needed to understand this
> problem should be there :)

FYI:

My post of the FreeBSD-ports mailing list how I should handle this
license issue LZO <-> OpenSSL hasn't turned up anything in some days; so
no-one has an opinion there...

I'll forbid packaging binaries when I update the port for OpenVPN 1.4.0,
just to be sure. OpenSSL is in the base system of FreeBSD, so I don't
consider this urgent, but it should be fixed eventually.


