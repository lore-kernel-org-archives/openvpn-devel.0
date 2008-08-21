Date: Fri, 22 Aug 2008 00:27:20 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20080821222720.GA25720@...33...>
References: <20080821181836.GE2516@...30...>
MIME-Version: 1.0
In-Reply-To: <20080821181836.GE2516@...30...>
Subject: Re: [Openvpn-devel] rc9 and external commands
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

On Thu, 21 Aug 2008, Alberto Gonzalez Iniesta wrote:

> It seems that tightening the security on OpenVPN brought some surprises
> [1] to users and broke some features [2].
> 
> As for [1], I included a note in the Debian NEWS file on the new
> --script-security option. But those updating a VPN using the very same
> VPN (and without previous knowledge of this option) may find themselves
> without access to the remote system (if the VPN/system is restarted, and
> a script is to be executed). Also, those using NetworkManager [3] aren't
> able to specify the '--script-security' option, and since NetworkManager
> may/will call external scripts, this new security feature will break
> their VPNs. The option is really useful, but 2 would be a more sensible
> default IMHO.

One might argue that NetworkManager doesn't support all *RC versions of
OpenVPN's. At the end of the day, it will be a NetworkManager issue.
Interfaces change...

> Regarding [2] an strace shows that calls to external commands with
> arguments include the arguments as part of the command filename:
> For: 
> --up "/tmp/foo up"
> 
> The call is:
> [pid  3519] execve("/tmp/foo up", ["/tmp/foo up", "tun0", "1500", "1542",
> "10.XXX.XXX.X", "10.XXX.XXX.X", "init"], [/* 30 vars */]) = -1 ENOENT
> (No such file or directory)

Apparently argument splitting - as documented in the --up section of the
manpage - no longer works; it was probably formerly done by the implicit
/bin/sh -c that is now gone with the switch to exec*().

(I didn't check, and didn't check the two Debian BTS reports either.)

So either the code needs argument splitting or you need a two-line shell
wrapper similar to:

#! /bin/sh -e
exec /tmp/foo up "$@"

Not my call to make.

-- 
Matthias Andree

