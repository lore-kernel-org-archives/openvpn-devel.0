Message-ID: <44363681.8090902@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Many pushed routes
References: <44317DED.3000801@...607...> <20060404141212.GA19356@...608...> <44361E0F.3020306@...607...>
In-Reply-To: <44361E0F.3020306@...607...>
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
Date: Fri Apr  7 02:55:06 2006
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: Nejc Skoberne <nejc@...607...>
Cc: openvpn-devel@lists.sourceforge.net

Nejc Skoberne wrote:
> Hi again,
>
>>> Any ideas how could I fix this? I would need to hard-recode the 
>>> buffer length (1024)?
>>
>> Take a look to the change log of OpenVPN. It says:
>>
>>   To increase the push list capacity (must be done on both
>>   client and server), increase TLS_CHANNEL_BUF_SIZE in
>>   common.h (default=1024).
>>
>> So if you are changing this macro definition you should
>> be able to use longer lists.
>
> so there is no other way than to compile the Windows version too? It 
> doesn't look
> really trivial to get the DDK stuff from Microsoft to be able to 
> compile OpenVPN
> for windows.
You don't need the DDK unless you want to recompile the TAP-Win32 device 
driver.  To rebuild only OpenVPN itself, you only need the free MinGW 
compiler.
>
> Why is this limit so low anyway? Would it really hurt anything so 
> badly if it was
> let's say 4 times of what it is currently?
>
It might be worth raising -- the main reason why it's low is that making 
it higher would increase static memory usage, and probably less than 1% 
of users are pushing large numbers of routes.


It would be good if someone wanted to volunteer to write some code to 
make the buffer allocation code for the push/pull list dynamic rather 
than static -- then we could do away with the static limit.

James


