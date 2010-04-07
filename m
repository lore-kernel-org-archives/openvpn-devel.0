Message-ID: <4BBBF2D1.6010408@...1299...>
Date: Wed, 07 Apr 2010 14:49:53 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <1270222244713125500@...1315...> <4BBB014F.2070206@...1147...>
In-Reply-To: <4BBB014F.2070206@...1147...>
Subject: Re: [Openvpn-devel] Auto-Proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 04/06/2010 09:39 PM, Jan Just Keijser wrote:
> openvpn@...1315... wrote:
>   
>> Hi,
>>
>>  
>>
>> I have been using two different config files to connect to my OpenVPN 
>> server - as I am sometimes behind a proxy server, and sometimes not. 
>> So to fix this I tried using auto-proxy ... but it didn't work (in the 
>> proxy case) ... :-(.
>>
>>  
>>
>> I am running the client on Windows - so it should work, no?
>>
>>  
>>
>>     
> note to the developers: all error codes when using the 
> InternetQueryOption API are lost ... also read
>   http://support.microsoft.com/kb/226473
> Openvpn 2.1 uses the "old" IE4 API .
>   

Another note to developers. Can they work on enabling auto-proxy to work
in configs that contain both UDP and TCP-based "<connection>" profiles? :-)

In a similar vein, the following ticket is in the bug tracking system -
there seems to be a general problem with mixing TCP and UDP options (eg
mssfix, nobind, fragment)

http://sourceforge.net/tracker/index.php?func=detail&aid=2945147&group_id=48978&atid=454720

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


