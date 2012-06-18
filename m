Message-ID: <4FDF71C5.7090103@...1227...>
Date: Mon, 18 Jun 2012 20:21:57 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [V2.4 0/4] tun cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 12.05.12 21:31, schrieb Alon Bar-Lev:
> Platform independent interface for tun provider.
>
> Split the long tun.c into platform specific files using
> tun_engine interface.
>
> Functionality is the same.
>
> Maintenance will be much easier! new options, like stacking
> several interfaces and delegate partial control to plugin.
>
I have looked at your patchset. It going in the right direction I think.

For "my platform" I would like to have/implement a persisent tun which
works as follows:

- proivde tun configuration including routes and ifconfig
- open tun with the information
- keep tun open
- on reconect: compare new configuration with old configuration.
  - if nothing has changed keep the old tun
  - otherwise first open the new tun then close the old tun

If we redesign the tun interface I would like to support this as well.
Having this interface would also make implementing platform specific
redirect-gateway and so easier. Also the redirect variant used by
Android (binding a socket to an interface) could be implemented as a
alternative.

Arne


