Message-ID: <43665747.5000502@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...>
In-Reply-To: <43662220.3000807@...486...>
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
Date: Mon Oct 31 09:46:40 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Albert Siersema <appie@...486...>
Cc: openvpn-devel@lists.sourceforge.net

Albert Siersema wrote:
> Hello,
> 
> The --show-pkcs11-* commands cause the SafeSign PIN code popup to show
> before openvpn.exe can access the smartcard.

This is violation of PKCS#11 standard.

> Using (--)askpass works fine too when connecting with openvpn but

Does it also popup PIN dialog?

> pkcs11-protected-authentication doesn't seem to work:
> Mon Oct 31 14:35:04 2005 PKCS#11: Adding PKCS#11 provider 'aetpkss1.dll'
> Mon Oct 31 14:35:06 2005 PKCS#11: Cannot set parameters -'CKR_ARGUMENTS_BAD'
> Mon Oct 31 14:35:06 2005 Cannot load certificate "........"

PKCS#11 protected authentication is not implemented by most 
of PKCS#11 providers, it is used in biometric environment or 
when external keypad is available. Are you sure your 
provider support protected authentication?

The askpass should be the preferred method.
Beta5 will remove askpass and will ask password unless 
protected authentication is requested.

Best Regards,
Alon Bar-Lev.

