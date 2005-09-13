From: "Alon Bar-Lev" <alon.barlev@...277...>
Subject: RE: [Openvpn-devel] openvpn - support PKCS#11 smartcards
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAFDDtaetKC0eU/wAT9I94wAEABRNVsENpT0ClhBpBhWPpJAAAAAPN/gAAEAAAACFkkGuklWNOurOZ+tJ84QIBAAAAAA==@gmail.com>
MIME-Version: 1.0
In-Reply-To: <618FF4C21278E44BB35BD24B86C2779607F49471@...456...>
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
Date: Tue Sep 13 04:49:02 2005
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

C. Ruiz, Ivan wrote:

>The problem is clearly on OpenSC pkcs#11 implementation, but with the
option --pkcs11-sign-mode
> you have included we can workarround it!

OK... So we can close this issue.

> I agree to drop support for OpenSC. The PKCS#11 approach works well with
OpenSC and it will
> broad the support for other PKCS#11-aware smartcards/libraries.

Great... So we continue with request to merge the PKCS#11 code into openvpn.

> Can the code check wether there's a PIN specified by the user before
calling pkcs11_openSession and
> give a message like "You need to specify a PIN to access the smartcard."?

OK... I've already added --pkcs11-protected-authentication in the last
patch... So if it is not given and there is no --askpass  - I will add a
failure.

One more task for me is to support more than one PKCS#11 provider... I will
do this in the next weekend.

Best Regards,
Alon Bar-Lev.


