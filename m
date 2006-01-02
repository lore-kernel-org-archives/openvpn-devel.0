Message-ID: <43B9409E.4090903@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN and eToken.
References: <605203017.20060102170037@...450...>
In-Reply-To: <605203017.20060102170037@...450...>
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
Date: Mon Jan  2 10:24:16 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: mts.spb.suxx@...450...
Cc: openvpn-devel@lists.sourceforge.net

mts.spb.suxx@...450... wrote:
> Hello openvpn-devel,
> I got myself the Aladdin's eToken PRO (USB) and I want to put it to
>   use with OpenVPN.
>   Where should I start reading about PKCS#11 on OpenVPN from?
> 
>   Please CC me for I'm not on the List.
>   Thank you in advance.
> 
> 
>   I'm really sorry - I should have stated that I'm on winXP...
> 

You can start from http://openvpn.net/howto.html#pkcs11. If 
I remember correctly, your provider should be eTpkcs11.dll. 
There is a known problem with Aladdin that sets duplicate 
labels on objects, so select objects by object id or 
certificate subject name.

Best Regards,
Alon Bar-Lev.


