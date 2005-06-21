From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...> <Pine.LNX.4.58.0506202032420.10675@...41...>
In-Reply-To: <Pine.LNX.4.58.0506202032420.10675@...41...>
MIME-Version: 1.0
Message-Id: <200506211059.31506.nomis80@...401...>
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
Date: Tue Jun 21 10:02:43 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Monday 20 June 2005 22:42, James Yonan wrote:
> When I apply your patch and run on SuSE 9.1 with the default "login" PAM
> module (pam-0.77-221):
>
>   plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
>
> I get:
>
>   AUTH-PAM: BACKGROUND: user 'x' failed to authenticate: Module is unknown

I've determined that this is a bug due to the old version of pam that is 
present in SUSE 9.1. It was fixed in version 1.5 of the pam_unix.so Makefile, 
which you can see here: 
http://cvs.sourceforge.net/viewcvs.py/pam/Linux-PAM/modules/pam_unix/Makefile?view=log#rev1.5. 
The comment says:

"Patch from Sam Hartman to fix handling of module linking on Linux:
modules should be linked against libpam if they call any functions from
the library, since not all platforms will correctly resolve symbol
references otherwise."

In the /var/log/messages file, pam writes this when it fails to dlopen its 
modules:

Jun 21 03:28:25 (none) openvpn: PAM unable to 
dlopen(/lib/security/pam_unix2.so)
Jun 21 03:28:25 (none) openvpn: PAM [dlerror: /lib/security/pam_unix2.so: 
undefined symbol: pam_get_item]
Jun 21 03:28:25 (none) openvpn: PAM adding faulty 
module: /lib/security/pam_unix2.so
Jun 21 03:28:25 (none) openvpn: PAM unable to 
dlopen(/lib/security/pam_pwcheck.so)
Jun 21 03:28:25 (none) openvpn: PAM [dlerror: /lib/security/pam_pwcheck.so: 
undefined symbol: pam_get_item]
Jun 21 03:28:25 (none) openvpn: PAM adding faulty 
module: /lib/security/pam_pwcheck.so

You can see that the dlopening of PAM modules fails because it is not 
resolving the pam_get_item symbol. That symbol is used by PAM modules and not 
by any openvpn stuff. That should be no problem right? Because we're linking 
against libpam.so anyway?

The problem is that PAM modules should not have undefined symbols, even if it 
is assumed that the main application is linked with libpam.so. If a PAM 
module uses functions from libpam.so, it should link with it. It is easy to 
see that this is not the case on SUSE 9.1:

poste10-161:/lib/security # ldd -r pam_unix.so
    linux-gate.so.1 =>  (0xffffe000)
    libnsl.so.1 => /lib/libnsl.so.1 (0x4001a000)
    libdl.so.2 => /lib/libdl.so.2 (0x4002f000)
    libxcrypt.so.1 => /lib/libxcrypt.so.1 (0x40033000)
    libselinux.so.1 => /lib/libselinux.so.1 (0x40067000)
    libc.so.6 => /lib/tls/libc.so.6 (0x40075000)
    /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)
undefined symbol: pam_get_item  (./pam_unix.so)
undefined symbol: pam_set_data  (./pam_unix.so)
undefined symbol: pam_putenv    (./pam_unix.so)
undefined symbol: pam_set_item  (./pam_unix.so)
undefined symbol: pam_get_data  (./pam_unix.so)
undefined symbol: pam_get_user  (./pam_unix.so)

Compare that output from this one, from Fedora Core 4, which has no missing 
symbols because it is linked with libpam.so.

[nomis80@...423... security]$ ldd -r pam_unix.so
        linux-gate.so.1 =>  (0x001a3000)
        libcrypt.so.1 => /lib/libcrypt.so.1 (0x00ea5000)
        libnsl.so.1 => /lib/libnsl.so.1 (0x007b5000)
        libselinux.so.1 => /lib/libselinux.so.1 (0x00643000)
        libc.so.6 => /lib/libc.so.6 (0x004df000)
        libpam.so.0 => /lib/libpam.so.0 (0x003f3000)
        /lib/ld-linux.so.2 (0x0068a000)
        libdl.so.2 => /lib/libdl.so.2 (0x00281000)
        libaudit.so.0 => /lib/libaudit.so.0 (0x00f44000)

FC4's pam is 0.79 while SUSE 9.1's is 0.77. I would guess that my patch would 
work on a more recent SUSE, where pam's bug would be fixed.

