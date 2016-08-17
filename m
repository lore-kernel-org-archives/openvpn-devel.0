From: debbie10t <debbie10t@...277...>
References: <57A87572.6080306@...277...>
	<20160808122011.GC78279@...1296...> <57A896DD.1020004@...277...>
Message-ID: <a04e17d1-27b9-0415-3625-12c255f2f010@...277...>
Date: Wed, 17 Aug 2016 12:54:20 +0100
MIME-Version: 1.0
In-Reply-To: <57A896DD.1020004@...277...>
Subject: Re: [Openvpn-devel] Is --ifconfig-ipv6-noexec planned ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 08/08/16 15:27, debbie10t wrote:
>
>
> On 08/08/16 13:20, Gert Doering wrote:
>> Hi,
>>
>> On Mon, Aug 08, 2016 at 01:05:06PM +0100, debbie10t wrote:
>>> --ifconfig-ipv6-noexec
>>>
>>> not sure if this would be a 'feature request/wish list' item
>>> or if it has just been over looked.
>>>
>>>
>>
>> (The idea behind --ifconfig-noexec is not "do not enable IPv6", use
>> --pull-filter for that.  --ifconfig-noexec is used together with --up
>> to run more custom stuff on ifconfig, which the built-in mechanisms
>> cannot do)
>>
>>
>

Sorry, I feel I need a better explanation for this problem ..

--ifconfig-noexec should *not* exec anything IPv4 *and* IPv6

I have spent some considerable hours on this now, I have working
server & client configs & logs at verb 4 which essentially prove
that --ifconfig-noexec does *not* effect IPv6.
The log clearly shows that openvpn is calling netsh.exe to
configure IPv6 on the TAP adapter.

Side note, can be explored later:
With --ifconfig-noexec in the config, the log *does* show:
ifconfig_noexec = DISABLED .. which seems wrong ?

I have also used --pull-filter ignore "ifconfig-ipv6 "
and used batch files (windows client) to configure networking.

I can post full details here or as a bug or whatever you prefer.

While I accept the "work around" (--pull-filter, only available in git)
Gert's answer is vague and the manual is misleading.

So I re-state my original question in a more appropriate way:

   _Why_ does --ifconfig-noexec *not* effect IPv6 ?

The point here is that using --ifconfig-noexec & --up
for IPv4 you manually configure everything
for IPv6 you *must* --pull-filter ignore "ifconfig-ipv6 "
because --ifconfig-noexec has *no* effect on IPv6

Thankyou.





