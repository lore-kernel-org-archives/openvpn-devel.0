Message-ID: <078401c23512$0f4c3050$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <20020726215819.GA11459@...38...>
Subject: Re: [Openvpn-devel] NetBSD patch for OpenVPN
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri Jul 26 19:04:02 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Dimitri Goldin <dmi@...37...>, openvpn-devel@lists.sourceforge.net

Dimitri,

Thanks for the patch, I will apply it to the CVS shortly.

One question I have, were you able to connect OpenVPN running on NetBSD to
OpenVPN running on a different platform such as Linux?

I ask because some tun/tap devices will prepend unnecessary stuff onto the
datagram that must be disabled with an explicit ioctl call if cross-platform
compatibility is to be preserved.  You can see some examples of this in
tun.c.

If this is the case, you might find that NetBSD <-> NetBSD tunnels work
fine, but NetBSD <-> Linux tunnels are broken.  Just something to check for
if possible...

James

----- Original Message -----
From: "Dimitri Goldin" <dmi@...37...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Friday, July 26, 2002 3:58 PM
Subject: [Openvpn-devel] NetBSD patch for OpenVPN


> Hello list,
>
> The patch for the NetBSD "support" ist ready.
> I only added some entries for NetBSD and used the same ifconfig code
> as OpenBSD in tun.c.
> The patch is attached.
> I hope I did everything right.
>
> Cheers,
>         Dimitri
> --
> pub  1024D/3A264EA8 2002-07-07 Dimitri Goldin <dmi@...37...>
> Fingerprint: 3AA9 1264 51AA 0BB5 EB29  A6E3 9648 F42A 3A26 4EA8
>                                                 "Don't Panic."
>
>


