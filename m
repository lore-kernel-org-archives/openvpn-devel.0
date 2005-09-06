From: "Alon Bar-Lev" <alon.barlev@...277...>
Subject: RE: [Openvpn-devel] RE: [Openvpn-users] openvpn, smartcards and PKCS#11
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAAOa2iGA6cTVIgGHNk90HOXEBAAAAAA==@gmail.com>
MIME-Version: 1.0
In-Reply-To: <431E20F8.1080101@...453...>
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
Date: Tue Sep  6 23:43:05 2005
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Erich Titl' <erich.titl@...453...>
Cc: 'James Yonan' <jim@...41...>, openvpn-devel@lists.sourceforge.net

 
Erich Titl wrote:

> maybe I am completely off topic but I am using an ikey 1000 on a Windoze
box with standard openvpn. AFAIK the ikey 1000 provides a
> PKCS#11 interface which (at least on windoze) is handled by the
proprietary driver.

> This token only handles storage of the keys. I believe the engine is only
required when you want to run crypto operations on the card.

Hello Erich,

In terms of security, there is no point of using a device that store keys
only to be extracted by applications.
In order to secure your identity you must use a device that cannot be
duplicated.
This can be implemented only if the device does not allow the private key to
be extracted from it.
In order to make use of this none extractable key, the device must perform
the cryptographic operations and not the software.

What you describe is somewhat like putting the private key on USB Storage
device... This is very low security level.

Best Regards,
Alon Bar-Lev.


