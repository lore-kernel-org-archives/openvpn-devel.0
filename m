From: R P Herrold <herrold@...43...>
In-Reply-To: <twig.1083217597.4062@...41...>
Message-ID: <Pine.LNX.4.58.0404291244110.32167@...44...>
References: <twig.1083217597.4062@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: openvpn-d]  OpenVPN 2.0-test26 released
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
Date: Thu Apr 29 09:50:11 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

On Thu, 29 Apr 2004, James Yonan wrote:

> * Compatibility with 1.x -- OpenVPN 2.0 tries as much as possible to be
> upwardly compatible with 1.x.  The main difference is that 2.0 changes some
> parameter defaults.  The tun/tap MTU has been raised to 1500, --mssfix 1450 is
> now the default, and --key-method now defaults to 2.  The only feature which
> has been removed is the special-purpose SSL/TLS thread feature which is
> enabled on 1.x if you build OpenVPN with the --enable-pthread flag.  I might
> put it back if people complain, but overall I'm not sure that it's worth the
> trouble.

Compatability, to me says 'Configuration files' and setup 
approach.  Is Interoperability back with earlier clients also 
a design goal/feature present?  That is, for testing, will I 
need to set a test bench with two hosts, running the 2.x code, 
or can I just temporarily repoint a 1.x client at a 2.x host 
by altering the 'remove (servername)' field at the client?

- Russ Herrold

