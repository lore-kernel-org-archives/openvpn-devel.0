Message-ID: <43216980.6070806@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] New patch OpenSC support for OpenVPN 2.0.2
References: <618FF4C21278E44BB35BD24B86C2779607EC91EB@...456...>
In-Reply-To: <618FF4C21278E44BB35BD24B86C2779607EC91EB@...456...>
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
Date: Fri Sep  9 03:59:07 2005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "C. Ruiz, Ivan" <ICASADO@...455...>
Cc: openvpn-devel@lists.sourceforge.net

C. Ruiz, Ivan wrote:
> Hi there,
> 
> I took Fritz Elfert's patch that enables the use of openvpn and opensc 
> smartcards and modified it a little bit:
> 
> Can this be merged in the next version? I've been reading the posts 
> proposing to implement this other ways, but consider that this code 
> already works. I would include it know and then implement a better 
> aproach to support smartcards in case it's needed, something that I'm 
> not yet convinced of.
> 

Hello!
Good job!

But opensc is not a standard/popular interface for 
smartcards... PKCS#11 is much more common interface, even 
opensc supply PKCS#11 interface.

May I take this patch and try to convert it to PKCS#11?
The problem is that I don't know openssl very well... But I 
think that this patch will help a lot.

I think that merging PKCS#11 code will be much better than 
merging opensc code, since it will allow more smartcard types 
to be used.

Best Regards,
Alon Bar-Lev.

