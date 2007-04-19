From: "Brane F. =?utf-8?q?Gra=C4=8Dnar?=" <bfg@...1012...>
Date: Thu, 19 Apr 2007 17:46:47 +0200
References: <A06302D8-1633-4FCB-A8EE-8EC6A58FF3F3@...1018...>
In-Reply-To: <A06302D8-1633-4FCB-A8EE-8EC6A58FF3F3@...1018...>
MIME-Version: 1.0
Message-Id: <200704191746.47385.bfg@...1012...>
Subject: Re: [Openvpn-devel] learn address problems with chroot, or userid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 19. April 2007 14:51, Dave Cramer wrote:
> The only way I can get learn-address script to work is by running
> openvpn as root
>
> Ideally I'd like to create an openvpn user, and chroot to /
> openvpnprivate/
>
> then run
>
> learn-address /script
>
> However when I tried this I get "cannot execute cmd"  error

Inside chroot you need:

/bin/sh (system(3) spawns command using sh -c)
/lib or /lib64 directory with all libraries that are linked against your sh.

Run ldd /bin/sh to get list of linked libraries.

Hope this helps...

cheers,
--=20
Brane F. Gra=C4=8Dnar
Sistemski administrator za UNIX okolje
Interseek d.o.o., Stegne 31, SI-1000 Ljubljana
e-mail > bfg@...1012...
www.interseek.si, www.najdi.si

