From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063664530.85975@...41...>
In-Reply-To: <3F660E69.80305@...101...>
References: <946499570EB7294690F512C1EF182F881EB893@...102...>, <946499570EB7294690F512C1EF182F881EB893@...102...>
Subject: [Openvpn-devel] Re: [Openvpn-users] Windows tun driver
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
Date: Mon Sep 15 15:23:07 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Inode <inode@...101...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Inode <inode@...101...> said:

> Hi all,
> I'm looking on the net for a tunnel driver for windows. Anyone found a 
> good working driver? I have to user OpenVPN from an OpenBSD and a 
> Windows, and OpenBSD (native) doesn't support TAP device...

Yes, this is a problem.  For OpenBSD to talk to Windows over OpenVPN, we need
either a tun driver for Windows or a tap driver for OpenBSD.

My guess is that the easier and better solution would be to solve the tap on
OpenBSD problem, rather than the tun on Windows problem.

My understanding is that a tap driver exists for OpenBSD that was ported from
FreeBSD, but that it's still in an experimental, somewhat unfinished state and
needs a good kernel hacker to bring it up to the standard of the rest of the
OpenBSD networking subsystem.

I think that Windows users are going to prefer a tap interface anyways,
because it carries the kind of traffic and protocols which Windows
applications generate, such as broadcast traffic and non-IP protocols.

James




