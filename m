Message-ID: <53589A62.30806@...515...>
Date: Wed, 23 Apr 2014 23:00:18 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>	<5357DDFC.2010401@...1901...>	<53581D43.6060501@...1856...>
	<53584B0C.8020209@...1901...> <53585356.8020602@...515...>
	<53585929.306@...1901...>
In-Reply-To: <53585929.306@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Timothe Litt <litt@...1901...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 23/04/2014 18:22, Timothe Litt wrote:
>> I don't see that cryptoapi.c has been updated to work with TLS 1.2.
> Yes, just came to the same conclusion.
>
> Long-term the key-loaders need to get updated.
>
> Maybe short-term the options that invoke them could force NO_TLSv_1_2...
>
> That would make things work for most people in the short term.

One option would be to have a tls-version-max, but I'm wondering if this 
might be overkill.

It would also force people to add "tls-version-max 1.0" to their configs 
to go back to the original 2.3 behavior.

My preferred solution is to simply turn off tls-version-min if it's not 
specified in the config, and use the 2.3 behavior.  That basically 
forces TLS 1.0.

I've seen a lot more breakage than just this... I believe the first 
significant real-world exposure was the iOS 1.0.2 and 1.0.3 releases 
from several months ago.  There were hundreds of reports of breakage, 
mostly from countries behind government firewalls.  This was using 
OpenVPN 3 with PolarSSL, so the issue seems to occur with different 
OpenVPN and SSL implementations.

James

