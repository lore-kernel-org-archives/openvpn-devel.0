From: "Alon Bar-Lev" <alon.barlev@...277...>
Subject: RE: [Openvpn-devel] RE: [Openvpn-users] openvpn, smartcards and PKCS#11
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAAD8QK3YJ+zFLuGljWpM1bLgBAAAAAA==@gmail.com>
MIME-Version: 1.0
In-Reply-To: <431E9327.2080503@...453...>
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
Date: Wed Sep  7 03:43:09 2005
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Erich Titl' <erich.titl@...453...>
Cc: openvpn-devel@lists.sourceforge.net

Erich Titl wrote:

> Which implies that you send cleartext to the device and get cyphertext
back. So the easiest way to tamper the message is to intercept it at
> the  smartcard driver level :-) and modify it on the fly. If someone is
smart enough to fetch the key contents from memory while it is being used by
> the crypto software, he is smart enough to intercept the cleartext
message.

The issue is not whether someone can see your messages, the issue is whether
I can steal your private key!

> This device at least protects its contents against tampering, and does not
yield the key without authentication. And this authentication is done
> on the device itself.

Most USB devices now require password before allow to access...
And if you put your private key encrypted on such device, it is more or less
the same security level.

If you like to upgrade your security, you should buy a device that
implements smartcard... And replace your memory card.

Best Regards,
Alon Bar-Lev.



