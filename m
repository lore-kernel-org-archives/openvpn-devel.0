Message-ID: <431E9327.2080503@...453...>
From: Erich Titl <erich.titl@...453...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RE: [Openvpn-users] openvpn, smartcards and PKCS#11
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAAOa2iGA6cTVIgGHNk90HOXEBAAAAAA==@gmail.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAAOa2iGA6cTVIgGHNk90HOXEBAAAAAA==@gmail.com>
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
Date: Wed Sep  7 00:14:05 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Alon

Alon Bar-Lev wrote:
>  
...
> 
> In terms of security, there is no point of using a device that store keys
> only to be extracted by applications.
> In order to secure your identity you must use a device that cannot be
> duplicated.
> This can be implemented only if the device does not allow the private key to
> be extracted from it.

This is the case for the ikey 1000. The device _should_ not allow
duplication.

> In order to make use of this none extractable key, the device must perform
> the cryptographic operations and not the software.

Which implies that you send cleartext to the device and get cyphertext
back. So the easiest way to tamper the message is to intercept it at the
 smartcard driver level :-) and modify it on the fly. If someone is
smart enough to fetch the key contents from memory while it is being
used by the crypto software, he is smart enough to intercept the
cleartext message.

> 
> What you describe is somewhat like putting the private key on USB Storage
> device... This is very low security level.

This device at least protects its contents against tampering, and does
not yield the key without authentication. And this authentication is
done on the device itself.

cheers

Erich

