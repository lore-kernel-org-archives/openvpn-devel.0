Message-ID: <4F1D246C.10508@...1114...>
Date: Mon, 23 Jan 2012 10:12:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120122213247.GI5060@...1296...>
In-Reply-To: <20120122213247.GI5060@...1296...>
Subject: Re: [Openvpn-devel] FreeBSD platform cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/01/12 22:32, Gert Doering wrote:
> Hi,
> 
> the current "master" code on FreeBSD has two problems:
> 
> - tun or tap devices are not removed at program end, so a "dead" 
> interface is left behind - not critical, but we should not do that ->
> call "ifconfig destroy" in tun_close().
> 
> - "topology subnet" for IPv4 causes failure for IPv6 (because the 
> interface is ioctl()'ed to IFF_BROADCAST mode, which changes the IPv6
> behaviour to "use neighbour discovery", which would have to be
> implemented by the OpenVPN server - and isn't, as of today).
> 
> With my change, the interface is left as "point to point" interface 
> (which it really is), but routing and ifconfig is setup with the 
> proper netmask, so all interesting packets are still sent down the tun
> if to OpenVPN.
> 
> Patch below, auto-tested for tun and tap devices on FreeBSD 7.4 and 
> FreeBSD 8.2 on amd64.
> 
> (There's one catch for FreeBSD 8.2 if you use pf(4): it will block
> IPv6 fragments by default, so the standard t_client.sh test sets fail
> unless you specifically add "pass in on tun1 fragment" rules - but
> there's nothing OpenVPN can do about it.  I'm just mentioning it here
> for the sake of the archives, in case someone else falls over it)
> 

ACK, as I see you've done the real testing.  Applied to master branch on
- -testing/-stable.


commit 62c613d46dc495d747074ca030d2cbdfd255c386
Author: Gert Doering <gert@...1540...>
Date:   Sun Jan 22 23:21:22 2012 +0200

    Platform cleanup for FreeBSD

    Signed-off-by: Gert Doering <gert@...1296...>
    URL: http://thread.gmane.org/gmane.network.openvpn.devel/5303
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8dJGoACgkQDC186MBRfrqW/QCeIi1rXiF8s+xSKVXWxDECx9ZQ
3r8AmwQlA6kK2b+EBLMvN+m9eA/h/EPI
=cjd5
-----END PGP SIGNATURE-----

