From: Thomas Glanzmann <sithglan@...162...>
Subject: Re: [Openvpn-devel] minimum cipher in openssl ?
Message-ID: <20040913201335.GA7178@...172...>
References: <000801c498aa$992b23a0$8100a8c0@...267...>
Mime-Version: 1.0
In-Reply-To: <000801c498aa$992b23a0$8100a8c0@...267...>
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
Date: Mon Sep 13 13:14:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi Gary,

> I want to run openvpn on WRT54G but the crypto library of openssl is
> extremely large for the device. I understand that I can trim away some
> ciphers but would like to know what minimum ciphers I have to include.
> I want to include only 3 symmetric cipher (blowfish, des and aes) and
> sha1 for key stuff. What else is needed for a basic functional openvpn
> with TLS support ? No key generation function etc.(like the dh thing)
> is needed as that I can do on some other hosting machine(I assume).

if you would format your eMails correctly, I had read it and not only
when Jim replies.

However I have it running:

root@...272...:~# openvpn --version
OpenVPN 2.0_test19 mipsel-unknown-linux-gnu [SSL] [LZO] built on Apr  7 2004
Copyright (C) 2002-2004 James Yonan <jim@...41...>
root@...272...:~# ps axuww | grep [o]penvpn
  258 root       1964 S   /bin/openvpn --config /etc/openvpn/client.conf
root@...272...:~# ls -al /bin/openvpn
-rwxrwxr-x    1 root     root       344756 Apr  7 14:32 /bin/openvpn

And I have also running the following stuff on wrt54g:
	- DNS
	- Masquerading
	- ratsd
	- Firewall (ipv6 and ipv4)
	- pppoe
	- ssh *server* and *client*
	- wakeup on lan
	- dyndns

All this applications are stored on the flash. A friend of mine also managed to
compile and run screen on it.

The openvpn takes approx 1.5Mbyte (including libs).

	Thomas

