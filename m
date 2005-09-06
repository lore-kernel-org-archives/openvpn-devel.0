From: "Alon Bar-Lev" <alon.barlev@...277...>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAAIfetpPaXdtPnq8y9C/hPN8BAAAAAA==@gmail.com>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0509061147300.27370@...41...>
Subject: [Openvpn-devel] RE: [Openvpn-users] openvpn, smartcards and PKCS#11
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
Date: Tue Sep  6 13:03:16 2005
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'James Yonan' <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

James Yonan wrote:

> Thanks for the interesting information on PKCS#11, OpenSSL, and
smartcards.

You are welcome... I now doing a phase on all open-source projects that uses
cryptographic but do not use smartcards... In a standard way... :)

> Any rough idea on what percentage of the cheaply available smartcards out
there can talk to OpenSSL via PKCS#11?

It depends on what cheap is for you... It can be rage from $12 in large
numbers to $40 in ones...
Aladdin USB token (www.ealaddin.com) is about $40 for one, but it does not
need a reader.
Athana smartcards (www.athena-scs.com) is about $17 for ones but it requires
a reader that is about $20.

Both works well...
Aladdin uses opensc and there is opensc-pkcs#11 provider.
Athena provides PKCS#11 library.

> Is this part of the OpenSC effort and/or does it obsolete it?

Opensc is an effort to produce open smartcard interface... But it failed.
Currently there are two interfaces to access smartcards:
1. PKCS#11 of RSA Security (www.rsasecurity.com/rsalabs/node.asp?id=2133) -
cross-platform free API.
2. Microsoft Cryptographic Service Provider (CSP) - Microsoft specific
interface.

There is a PKCS#11 provider for opensc, so that if you have opensc card you
can use it with applications that uses PKCS#11.

> Is this capability of using OpenSSL + PKCS#11 something which is intended
to provide access to smartcards on *nix systems only, or does
> it work on Windows as well?
