Message-ID: <001701c21234$184b69b0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <Pine.LNX.4.33.0206121720140.28574-100000@...23...>
Subject: Re: [Openvpn-devel] Porting to an embedded linux
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
Date: Wed Jun 12 10:10:08 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22..., openvpn-devel@lists.sourceforge.net

From: "Sampo Nurmentaus" <audiopoppi-13@...22...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Wednesday, June 12, 2002 8:31 AM
Subject: [Openvpn-devel] Porting to an embedded linux


> Hello folks,
>
>
> I have been recently busy porting openssl, openssh
> and openvpn to our embended linux environment
> build on etrax 100lx processor from axis communications.
>
> Openvpn's code was, thanks to you guys, quite easy to
> port but then I ran into problems when open vpn tries
> to ioctl tun device:
>
> ....
> 65: Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
> 66: Static Decrypt: Using 160 bit message digest 'SHA1' for HMAC
> authentication
> 67: Data Channel MTU parms: mtu=1456 extra_frame=44 extra_buffer=44
> extra_tun=0
> 68: Cannot ioctl TUNSETIFF tun0: File descriptor in bad state (errno=77)
> 69: Exiting
>
>
> I have changed device to locate
> in /tmp/tun, but that shuld not couse this kind of problems.
> /dev is on flash image so it is easier to use /tmp for testing.
> I created the device as should with:
> mknod /tmp/tun c 10 200
>
> If I try to cat tun device read returns with the very same
> error text.
>
>  I compiled support to kernel (not as a module)
> so it should always be there.
>
>
> Any ideas?

Sampo,

See message below from a previous thread on openvpn-users, and with
references to vtun list.

James

>
> Thanx in advange,
>
> Sampo Nurmentaus

James Yonan wrote:
>>Hi James,
>>
>>Thank you for your prompt and detailed reply.  What was happening
>>earlier was that I built openvpn first, then realized I needed to build
>>the tun/tap kernel module, so built that and then rebuilt openvpn - but
>>configure (god bless it) used the cached result of NOT finding if_tun.h.
>>  I cleared configure's cache and rebuilt it again - this time it found
>>"tun/tap v1.4".  Now I'm onto a new set of problems though.  Now I get:
>>
>>34: Cannot ioctl TUNSETIFF tun: File descriptor in bad state (errno=77)
>
>
> Though I've never seen this error personally, it has been talked about
> extensively on the vtun list (another tunneling daemon that uses the
TUN/TAP
> driver).
>
> Go to http://sourceforge.net/mailarchive/forum.php?forum_id=1826
>
> and search for "bad state".
>
> It appears to be caused by a mismatch between the tun/tap kernel module
and
> the kernel itself.
>
> What kernel version are you using?
>
> Because in versions 2.4.6 and higher, the TUN/TAP module is integral to
the
> kernel -- if you try to build an external version of the module, rather
than
> using the one already bundled, it will likely fail.

Also I've read a few posts that suggest that /usr/src/linux needs to point
to headers that match the running kernel.  Depending on what Sean has, it
may be worthwhile to ensure all the various versions
(kernel/headers/tunTap) all match.



