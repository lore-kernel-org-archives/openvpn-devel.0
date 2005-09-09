Message-ID: <4321FDDB.8020308@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] New patch OpenSC support for OpenVPN 2.0.2
References: <618FF4C21278E44BB35BD24B86C2779607EF34ED@...456...>
In-Reply-To: <618FF4C21278E44BB35BD24B86C2779607EF34ED@...456...>
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
Date: Fri Sep  9 14:32:08 2005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "C. Ruiz, Ivan" <ICASADO@...455...>, openvpn-devel@lists.sourceforge.net

C. Ruiz, Ivan wrote:
> Hello,
> 
> with this patch applied there are 2 options to work with smartcards:
> - Via a CSP under Windows
> - Via OpenSC under Linux and Windows (I have not tested Windows, but it should work)
> 
> Is it possible that your patch works as a third option, named for example "direct PKCS#11"?
> 
> There are many people already using OpenSC that can benefit from this patch right now.
> 

Hi!
I already converted the patch to use PKCS#11...
I will send it tomorrow...
Since opensc has PKCS#11 interface, I will be glad if you will 
be able to check if the PKCS#11 patch works with your card.

If it does, I don't see any reason why leave the OpenSC support...

Can you please look at the PKCS#11 interface of opensc?
http://www.opensc.org/files/doc/opensc.html#opensc.pkcs11

Best Regards,
Alon Bar-Lev.

