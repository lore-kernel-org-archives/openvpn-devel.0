From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN samples and rpm requirements - subpackage?
In-Reply-To: <200412141748.01332@...187...>
Message-ID: <Pine.LNX.4.58.0412141458120.23083@...41...>
References: <200412141748.01332@...187...>
MIME-Version: 1.0
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
Date: Tue Dec 14 14:10:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Doncho N. Gunchev" <mr700@...184...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 14 Dec 2004, Doncho N. Gunchev wrote:

>     Hello all,
>     the samples from openvpn's rpm package raise dependencies on perl
> and some perl modules with Fedora. I assume it is problematic for other
> distros also, so I suggest to move them in separate sub-package.
> I splitted the package into two packages - openvpn-2.0...i386.rpm and
> openvpn-samples-2.0...rpm. This way I can use 'AutoReq: 0' and
> 'Requires: %name = %version' within '%package samples' and have right
> and authomatic dependencies for the main package at the same time.
> Is this acceptable for all?

I already added "AutoReq: 0" -- see 2.0-rc4.

At this point, I would rather not split it up into 2 packages:

* The current dependencies are minimal.  Other than LZO, the only other 
mandatory dependencies are OpenSSL, pam, and glibc, all of which should 
exist by default on any standard Linux distro.  Pam is needed by the new 
C version of the auth-pam plugin.  But perl is not.

* I've added --defines so you can build without LZO or pam.

* I don't consider perl to be a mandatory dependency and I've removed it.

* I've added BuildRequires for openssl-devel, lzo-devel, and pam-devel

>     Also, for Fedora/Red Hat the right group is not Networking/Tunnels
> but maybe Applications/Internet (/usr/share/doc/rpm-*/GROUPS is refered
> as source for groups in fedora), but this is not a big problem... Maybe
> I'm too pedantic and there's another %if is not needed?

Is there a standard place in the RPM category space where VPN tunnels
should go?  If possible, I'd like to use the same category for all 
distros.

James


