Message-ID: <48AAFE6B.3030302@...41...>
Date: Tue, 19 Aug 2008 10:10:03 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <48A5F8A2.4090400@...1122...> <48A9A106.1020205@...1122...>
In-Reply-To: <48A9A106.1020205@...1122...>
Subject: Re: [Openvpn-devel] Problem with OpenVPN 2.1_rc9 on Vista 32-bit
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
To: Bart Kus <me@...1122...>
Cc: Openvpn-devel@lists.sourceforge.net

Bart Kus wrote:
> Sent this to openvpn-users a while back with no response.  Perhaps it is 
> a question better targeted @ the developers?
> 
> --Bart
> 
> 
> Bart Kus wrote:
>> Thu Aug 07 19:24:06 2008 OpenVPN 2.1_rc9 i686-pc-mingw32 [SSL] [LZO2] 
>> [PKCS11] built on Jul 31 2008
>>
>> [...] snip! [...]
>>
>> Thu Aug 07 19:24:53 2008 write to TUN/TAP  [State=AT?c 
>> Err=[c:\src\21\tap-win32\tapdrvr.c/2268] #O=10 Tx=[49,0] Rx=[6,88] 
>> IrpQ=[1,1,16] PktQ=[0,1,64]]: The data area passed to a system call is 
>> too small.   (code=122)
>> Thu Aug 07 19:25:03 2008 write to TUN/TAP  [State=AT?c 
>> Err=[c:\src\21\tap-win32\tapdrvr.c/2268] #O=10 Tx=[49,0] Rx=[6,89] 
>> IrpQ=[1,1,16] PktQ=[0,1,64]]: The data area passed to a system call is 
>> too small.   (code=122)
>> Thu Aug 07 19:25:12 2008 write to TUN/TAP  [State=AT?c 
>> Err=[c:\src\21\tap-win32\tapdrvr.c/2268] #O=10 Tx=[50,0] Rx=[6,90] 
>> IrpQ=[1,1,16] PktQ=[0,1,64]]: The data area passed to a system call is 
>> too small.   (code=122)

Are you using a non-standard MTU size?  This error indicates that a 
write operation to the TAP driver is impossibly small, i.e. the packet 
isn't even large enough to contain an ethernet header (for dev tap) or 
IPv4 header (for dev tun).

James

