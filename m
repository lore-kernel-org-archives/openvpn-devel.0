From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] minimum cipher in openssl ?
In-Reply-To: <000801c498aa$992b23a0$8100a8c0@...267...>
Message-ID: <Pine.LNX.4.58.0409131301250.24302@...269...>
References: <000801c498aa$992b23a0$8100a8c0@...267...>
MIME-Version: 1.0
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
Date: Mon Sep 13 12:08:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: gary <linux@...266...>
Cc: openvpn-devel@lists.sourceforge.net


On Sun, 12 Sep 2004, gary wrote:

> Hi,
> 
> I want to run openvpn on WRT54G but the crypto library of openssl is
> extremely large for the device. I understand that I can trim away some
> ciphers but would like to know what minimum ciphers I have to include. I
> want to include only 3 symmetric cipher (blowfish, des and aes) and sha1
> for key stuff. What else is needed for a basic functional openvpn with
> TLS support ? No key generation function etc.(like the dh thing) is
> needed as that I can do on some other hosting machine(I assume).

This issue seems to be coming up more and more these days.

One could:

(1) Try to build a minimal OpenSSL.  The problem here is that OpenVPN uses
a lot of the OpenSSL API set.  So figuring out what can be safely cut out
is a problem.  Certainly you could try removing unneeded ciphers and
message digests, but that might not make a huge dent in the code size.

(2) Try to port OpenVPN to an alternate crypto library such as MatrixSSL.

James


