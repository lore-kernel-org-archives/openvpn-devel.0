Message-Id: <2b842e11aedd1abcbd80ccb2e6ccd963@...521...>
From: Jeff Stearns <jps@...521...>
In-Reply-To: <43B131A5.4050900@...453...>
References: <0de7bd8e1dba22e5af9a2f7f78371f98@...521...> <43B131A5.4050900@...453...>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: multipart/alternative; boundary=Apple-Mail-3-634335018
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN failure traced to bug in tun driver (with fix)
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
Date: Tue Dec 27 10:25:03 2005
To: Erich Titl <erich.titl@...453...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--Apple-Mail-3-634335018
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit

Yes, you can work around the bug by patching the tun driver or 
extracting a newer version from the Linux source tree.

But the problem remains: The OpenVPN install document specifically 
tells you to install a broken version of the tun driver.

 From http://openvpn.net/install.html:

> * Linux 2.2 or Solaris:
>
>   You should obtain
>   version 1.1 of the TUN/TAP driver from
>   http://vtun.sourceforge.net/tun/
>   and follow the installation instructions.

The OpenVPN install.html document is broken and should be fixed.  It 
should tell you to patch the driver or go find a replacement for it.  
Unfortunately, OpenVPN doesn't seem to have a formal bug reporting 
mechanism.  That's why I posted my message.

-jeff stearns

On Dec 27, 2005, at 4:20 AM, Erich Titl wrote:

> Hi
>
> Jeff Stearns wrote:
>> If you use OpenVPN on Linux 2.2 or 4 2.4 or Solaris, you may be
>> suffering from a bug which causes connections to hang under heavy 
>> load.
>> The symptoms are very similar to the MTU problems discussed frequently
>> in these mailing lists. But it turns out that this bug is not caused 
>> by
>> MTU problems. It's a bug in the tun/tap driver.
>
> I looked into tun 1.15 which I believe is fixed in this aspect
> ...
>         unsigned int mask = POLLOUT | POLLWRNORM;
>
> 	if (!tun)
>                 return -EBADFD;
>
>         DBG(KERN_INFO "%s: tun_chr_poll\n", tun->name);
>
>         poll_wait(file, &tun->read_wait, wait);
>
>         if (skb_queue_len(&tun->readq))
>                 mask |= POLLIN | POLLRDNORM;
>
>         return mask;
> ...
>
> so the solution might be to use a more recent tun driver. I believe 
> this
> is now part of the official kernel distribution.
>
> cheers
>
> Erich
>

--Apple-Mail-3-634335018
Content-Type: text/enriched;
	charset=US-ASCII
Content-Transfer-Encoding: 7bit

Yes, you can work around the bug by patching the tun driver or
extracting a newer version from the Linux source tree.


But the problem remains: The OpenVPN install document specifically
tells you to install a broken version of the tun driver.

--Apple-Mail-3-634335018--
