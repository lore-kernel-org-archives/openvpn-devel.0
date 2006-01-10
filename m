Message-ID: <43C37B3E.1090204@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
References: <605203017.20060102170037@...450...> <43B9409E.4090903@...277...> <181840658.20060110042715@...450...>
In-Reply-To: <181840658.20060110042715@...450...>
Subject: [Openvpn-devel] Re: OpenVPN and eToken (on windows).
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
Date: Tue Jan 10 01:18:00 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: mts.spb.suxx@...450..., openvpn-devel@lists.sourceforge.net

mts.spb.suxx@...450... wrote:
> Hello Alon,
> 
> Thank you, I got it working.

I am glad.

> 
> Is it possible not to keep the "ca.crt" on local disk and fetch it
> from the token as well? I've put all the certs and keys into PKCS#12
> file and imported it into the token - along with the "ca.crt".
> Currently OpenVPN demands on having this certificate locally.

Putting the CA certificate on the smartcard is a potential 
security issue. Each time you log into the token some one 
can modify its contents. By putting a different trust on 
your token, hence you can be venerable to man-in-the middle 
attack. One should separate between the identity and the trust.

Identity should be stored on cryptographic token, trust 
should be stored statically where application resides.

> Is it possible to hide the "ta.key" (that is used for "tls-auth") in
> the token as well?

Well.. Many providers do not support HMAC with key in-side 
the token... I can store this key as a data object and 
export it during initialization... But using smartcard as a 
mass storage device is not a good idea... Especially when 
this key is common for every users that uses a specific server.

I will be glad to receive further comments regarding this 
issue... If it is important feature I will implement it.

Best Regards,
Alon Bar-Lev.

