Message-ID: <20100427105843.9402.qmail@...1287...>
Date: Tue, 27 Apr 2010 12:58:43 +0200
From: Peter Stuge <peter@...1287...>
References: <4E8CFE17-2394-4FAD-A1A5-AF193D97E7A3@...1348...>
	<1272340482.17652.2@...1207...>
MIME-Version: 1.0
In-Reply-To: <1272340482.17652.2@...1207...>
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was:
	Re:	[Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> IMO OpenVPN is encouraging bad practices by supplying packages for
> distros that include OpenVPN.

Ideally the package for that distro as made by OpenVPN is always
equivalent to the one made by the distributor.

What do I mean? I mean that I'm happy with .spec files and the likes,
that make up the source code for a particular kind of binary package,
being committed upstream.

And if they are, then it's of course fairly easy for upstream to use
them, and to make packages which are at the very least compatible
with the distribution.

And, I think that since it is downloaded from a site other than the
distributor's, users who actually do grab packages "manually" will be
able to tell the difference from a package delivered by the
distributor.


//Peter

