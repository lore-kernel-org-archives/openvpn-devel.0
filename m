Message-ID: <3FBD237B.3080208@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] TCP server bug
References: <3FBD1AA3.6050305@...138...>
In-Reply-To: <3FBD1AA3.6050305@...138...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov 20 12:37:03 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "Ian D. Bjorhovde" <ianbjor@...138...>
Cc: openvpn-devel@lists.sourceforge.net

Ian D. Bjorhovde wrote:
> I do not run into this issue if I use the UDP client.
this, IS strange ...

> 
> If I change the permissions of the key file (i.e. mode 666), I don't
> get an error (rather a warning about open permissions on the key file),
> but then I get the same permission denied error when trying to open the
> TUN device (/dev/net/tun, mode 0600 owner: root).
put a chgrp nogroup/nobody on /dev/net/tun and keys with a chmod 640 for 
keys and 660 for tun and it will be ok

something like that
# ll /dev/net/tun
crw-rw-r--    1 nobody   root      10, 200 Oct  3  2002 /dev/net/tun


Regards

		Julien


