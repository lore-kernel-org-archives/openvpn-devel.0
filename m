From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
Message-ID: <20030503093244.GA943@...30...>
References: <20030428142748.GA826@...30...> <20030502160707.GB29245@...33...>
Mime-Version: 1.0
In-Reply-To: <20030502160707.GB29245@...33...>
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
Date: Sat May  3 02:33:07 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Fri, May 02, 2003 at 06:07:07PM +0200, Matthias Andree wrote:
> On Mon, 28 Apr 2003, Alberto Gonzalez Iniesta wrote:
> 
> > Sorry for the huge forward, but everything needed to understand this
> > problem should be there :)
> 
> FYI:
> 
> My post of the FreeBSD-ports mailing list how I should handle this
> license issue LZO <-> OpenSSL hasn't turned up anything in some days; so
> no-one has an opinion there...
> 
> I'll forbid packaging binaries when I update the port for OpenVPN 1.4.0,
> just to be sure. OpenSSL is in the base system of FreeBSD, so I don't
> consider this urgent, but it should be fixed eventually.

If OpenSSL is in the base system of FreeBSD, then there shouldn't be any
problem linking LZO with it.
You could also allow OpenVPN binaries without LZO support (as I
currently do in Debian).

Anyway, Markus got in contact with me (I'll forward his message next to
this one) and we have permission to use LZO with OpenSSL in OpenVPN :)
So,... End Of Thread (for the time being?)



-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.
                                               -- Benjamin Franklin
Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

