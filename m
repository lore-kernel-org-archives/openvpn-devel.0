From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050622182551.GA15138@...33...>
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...> <Pine.LNX.4.58.0506202032420.10675@...41...> <200506211059.31506.nomis80@...401...>
Mime-Version: 1.0
In-Reply-To: <200506211059.31506.nomis80@...401...>
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
Date: Wed Jun 22 11:26:27 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 21 Jun 2005, Simon Perreault wrote:

> poste10-161:/lib/security # ldd -r pam_unix.so
>     linux-gate.so.1 =>  (0xffffe000)
>     libnsl.so.1 => /lib/libnsl.so.1 (0x4001a000)
>     libdl.so.2 => /lib/libdl.so.2 (0x4002f000)
>     libxcrypt.so.1 => /lib/libxcrypt.so.1 (0x40033000)
>     libselinux.so.1 => /lib/libselinux.so.1 (0x40067000)
>     libc.so.6 => /lib/tls/libc.so.6 (0x40075000)
>     /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)
> undefined symbol: pam_get_item  (./pam_unix.so)
> undefined symbol: pam_set_data  (./pam_unix.so)
> undefined symbol: pam_putenv    (./pam_unix.so)
> undefined symbol: pam_set_item  (./pam_unix.so)
> undefined symbol: pam_get_data  (./pam_unix.so)
> undefined symbol: pam_get_user  (./pam_unix.so)
> 
> FC4's pam is 0.79 while SUSE 9.1's is 0.77. I would guess that my patch would 
> work on a more recent SUSE, where pam's bug would be fixed.

Parts of your assumption about ldd -r or linkage of the PAM modules
against libpam don't hold. I haven't yet managed to test the whole
setup.

SUSE 9.2 w/ all patches: pam-0.77-227,
with this output for ldd -r /lib/security/pam_unix.so:
        linux-gate.so.1 =>  (0xffffe000)
        libnsl.so.1 => /lib/libnsl.so.1 (0xb7fd0000)
        libdl.so.2 => /lib/libdl.so.2 (0xb7fcb000)
        libxcrypt.so.1 => /lib/libxcrypt.so.1 (0xb7f97000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7f89000)
        libc.so.6 => /lib/tls/libc.so.6 (0xb7e73000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)
undefined symbol: pam_get_item  (/lib/security/pam_unix.so)
undefined symbol: pam_set_data  (/lib/security/pam_unix.so)
undefined symbol: pam_putenv    (/lib/security/pam_unix.so)
undefined symbol: pam_set_item  (/lib/security/pam_unix.so)
undefined symbol: pam_get_data  (/lib/security/pam_unix.so)
undefined symbol: pam_get_user  (/lib/security/pam_unix.so)

SUSE 9.3 w/ all patches: pam-0.78-8,
with this output for ldd -r /lib/security/pam_unix.so:
undefined symbol: pam_get_item  (/lib/security/pam_unix.so)
undefined symbol: pam_set_data  (/lib/security/pam_unix.so)
undefined symbol: pam_putenv    (/lib/security/pam_unix.so)
undefined symbol: pam_set_item  (/lib/security/pam_unix.so)
undefined symbol: pam_get_data  (/lib/security/pam_unix.so)
undefined symbol: pam_get_user  (/lib/security/pam_unix.so)
        linux-gate.so.1 =>  (0xffffe000)
        libnsl.so.1 => /lib/libnsl.so.1 (0xb7fb3000)
        libdl.so.2 => /lib/libdl.so.2 (0xb7fae000)
        libxcrypt.so.1 => /lib/libxcrypt.so.1 (0xb7f7a000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7f6b000)
        libc.so.6 => /lib/tls/libc.so.6 (0xb7e52000)
        /lib/ld-linux.so.2 (0x80000000)


-- 
Matthias Andree

