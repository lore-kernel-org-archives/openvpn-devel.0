From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] [PATCH]: small tweaks to beta16
Message-ID: <20041118135511.GA26653@...33...>
References: <41935EF5.4070907@...292...> <Pine.LNX.4.58.0411110700410.7012@...41...> <20041117235828.GA27761@...33...> <Pine.LNX.4.58.0411180429160.6079@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0411180429160.6079@...41...>
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
Date: Thu Nov 18 05:57:00 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 18 Nov 2004, James Yonan wrote:

> Right now the Windows build is statically linking with the LZO lib, just 
> as is specified in the makefile.w32.  libtool is used to make the library, 
> but not to link against it.  Is there a problem with this?

Yes, I believe so. If you use libtool to make the library, then you
should use libtool --mode=link to link with it, too - or install it
before building OpenVPN.

The alternative is, when you know you're building the library only
statically, to leave libtool out. I haven't looked close enough to
determine if this is applicable.

-- 
Matthias Andree

