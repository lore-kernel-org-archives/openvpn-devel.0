Message-ID: <43B131A5.4050900@...453...>
From: Erich Titl <erich.titl@...453...>
MIME-Version: 1.0
References: <0de7bd8e1dba22e5af9a2f7f78371f98@...521...>
In-Reply-To: <0de7bd8e1dba22e5af9a2f7f78371f98@...521...>
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN failure traced to bug in tun driver (with
 fix)
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
Date: Tue Dec 27 04:22:12 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jeff Stearns <jps@...521...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi

Jeff Stearns wrote:
> If you use OpenVPN on Linux 2.2 or 4 2.4 or Solaris, you may be
> suffering from a bug which causes connections to hang under heavy load.
> The symptoms are very similar to the MTU problems discussed frequently
> in these mailing lists. But it turns out that this bug is not caused by
> MTU problems. It's a bug in the tun/tap driver.

I looked into tun 1.15 which I believe is fixed in this aspect
...
        unsigned int mask = POLLOUT | POLLWRNORM;

	if (!tun)
                return -EBADFD;

        DBG(KERN_INFO "%s: tun_chr_poll\n", tun->name);

        poll_wait(file, &tun->read_wait, wait);

        if (skb_queue_len(&tun->readq))
                mask |= POLLIN | POLLRDNORM;

        return mask;
...

so the solution might be to use a more recent tun driver. I believe this
is now part of the official kernel distribution.

cheers

Erich


