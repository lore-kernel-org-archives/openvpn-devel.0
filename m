Message-ID: <4BBB014F.2070206@...1147...>
Date: Tue, 06 Apr 2010 11:39:27 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1270222244713125500@...1315...>
In-Reply-To: <1270222244713125500@...1315...>
Subject: Re: [Openvpn-devel] Auto-Proxy
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
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

openvpn@...1315... wrote:
>
> Hi,
>
>  
>
> I have been using two different config files to connect to my OpenVPN 
> server - as I am sometimes behind a proxy server, and sometimes not. 
> So to fix this I tried using auto-proxy ... but it didn't work (in the 
> proxy case) ... :-(.
>
>  
>
> I am running the client on Windows - so it should work, no?
>
>  
>

note to the developers: all error codes when using the 
InternetQueryOption API are lost ... also read
  http://support.microsoft.com/kb/226473
Openvpn 2.1 uses the "old" IE4 API .

cheers,

JJK


