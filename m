From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083282085.52946@...41...>
In-Reply-To: <Pine.LNX.4.58.0404291244110.32167@...44...>
References: <twig.1083217597.4062@...41...>, <twig.1083217597.4062@...41...>
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
Date: Thu Apr 29 16:42:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: R P Herrold <herrold@...43...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

R P Herrold <herrold@...43...> said:

> On Thu, 29 Apr 2004, James Yonan wrote:
> 
> > * Compatibility with 1.x -- OpenVPN 2.0 tries as much as possible to be
> > upwardly compatible with 1.x.  The main difference is that 2.0 changes some
> > parameter defaults.  The tun/tap MTU has been raised to 1500, --mssfix 1450 is
> > now the default, and --key-method now defaults to 2.  The only feature which
> > has been removed is the special-purpose SSL/TLS thread feature which is
> > enabled on 1.x if you build OpenVPN with the --enable-pthread flag.  I might
> > put it back if people complain, but overall I'm not sure that it's worth the
> > trouble.
> 
> Compatability, to me says 'Configuration files' and setup 
> approach.  Is Interoperability back with earlier clients also 
> a design goal/feature present?

Yes, absolutely.  There's no problem with 1.x clients/servers talking with 2.0
clients/servers.  There has been no change in the protocol, other than an
extension to the 2.0 protocol for --push/-pull.  If you want to use
--push/-pull, you will need 2.0 running on both sides of the connection.

The major difference is that some default parameters have changed, e.g. if you
are using TLS mode, 1.x uses --key-method 1 by default and 2.0 uses
--key-method 2.  So if you want 1.5+ and 2.0 to talk to each other in TLS,
then explicitly set --key-method so that both sides of the connection are
consistent (before 1.5, OpenVPN is hardcoded to use --key-method 1).  The
other default that was changed is --tun-mtu.  It's now 1500.

> That is, for testing, will I 
> need to set a test bench with two hosts, running the 2.x code, 
> or can I just temporarily repoint a 1.x client at a 2.x host 
> by altering the 'remove (servername)' field at the client?

You should be able to do that.  To bring a 1.5 or 1.6 host in line with 2.0
defaults, use:

  --key-method 2 (if TLS)
  --tun-mtu 1500
  --mssfix 1450

James


