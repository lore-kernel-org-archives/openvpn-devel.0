From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...> <20050622182551.GA15138@...33...>
In-Reply-To: <20050622182551.GA15138@...33...>
MIME-Version: 1.0
Message-Id: <200506221459.16684.nomis80@...401...>
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
Date: Wed Jun 22 12:00:25 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 22 June 2005 14:25, Matthias Andree wrote:
> Parts of your assumption about ldd -r or linkage of the PAM modules
> against libpam don't hold. I haven't yet managed to test the whole
> setup.

I don't get it. The original 0.78 tarball from 
http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-0.78.tar.bz2 
does not have the bug, ie. pam_unix.so is linked with libpam.so. I've checked 
SUSE 9.3's SRPM 
(ftp://distro.ibiblio.org/pub/linux/distributions/suse/suse/i386/9.3/suse/src/pam-0.78-8.src.rpm) 
and it doesn't seem to include patches that would modify this behavior. I've 
also rebuilt the RPM (on a FC4 system, because I deleted my SUSE 9.1 vmware) 
and my rebuilt RPM does not have the bug! I don't know where to check 
anymore.

Can you rebuild the pam RPM on your 9.3 system and verify whether 
%{_topdir}/BUILD/Linux-PAM-0.78/modules/pam_unix/pam_unix.so is linked 
against libpam.so? Thanks!

