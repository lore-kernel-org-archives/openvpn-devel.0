From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] OpenVPN samples and rpm requirements - subpackage?
References: <200412141748.01332@...187...> <Pine.LNX.4.58.0412141458120.23083@...41...>
In-Reply-To: <Pine.LNX.4.58.0412141458120.23083@...41...>
MIME-Version: 1.0
Message-Id: <200412160024.17918@...187...>
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
Date: Wed Dec 15 14:25:03 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2004-12-15 (Wednesday) 00:09, James Yonan wrote:
> On Tue, 14 Dec 2004, Doncho N. Gunchev wrote:
> 
> >     Hello all,
> >     the samples from openvpn's rpm package raise dependencies on perl
> > and some perl modules with Fedora. I assume it is problematic for other
> > distros also, so I suggest to move them in separate sub-package.
> > I splitted the package into two packages - openvpn-2.0...i386.rpm and
> > openvpn-samples-2.0...rpm. This way I can use 'AutoReq: 0' and
> > 'Requires: %name = %version' within '%package samples' and have right
> > and authomatic dependencies for the main package at the same time.
> > Is this acceptable for all?
> 
> I already added "AutoReq: 0" -- see 2.0-rc4.
> 
> At this point, I would rather not split it up into 2 packages:
> 
> * The current dependencies are minimal.  Other than LZO, the only other 
> mandatory dependencies are OpenSSL, pam, and glibc, all of which should 
> exist by default on any standard Linux distro.  Pam is needed by the new 
> C version of the auth-pam plugin.  But perl is not.
> 
> * I've added --defines so you can build without LZO or pam.
> 
> * I don't consider perl to be a mandatory dependency and I've removed it.
> 
> * I've added BuildRequires for openssl-devel, lzo-devel, and pam-devel
> 
> >     Also, for Fedora/Red Hat the right group is not Networking/Tunnels
> > but maybe Applications/Internet (/usr/share/doc/rpm-*/GROUPS is refered
> > as source for groups in fedora), but this is not a big problem... Maybe
> > I'm too pedantic and there's another %if is not needed?
> 
> Is there a standard place in the RPM category space where VPN tunnels
> should go?  If possible, I'd like to use the same category for all 
> distros.
> 

    AFAIK all distributions define their own RPM Groups. RPM is not that
standardized I'm afraid :(
    We know Red Hat, Fedora Core and SuSE have 'Applications/Internet',
but MNF8.2 does not have any containing 'Application' or 'Internet' :(

-- 
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint = 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

