Message-ID: <4CAE3A7E.4010303@...1147...>
Date: Thu, 07 Oct 2010 23:24:14 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20101007142817.GU7437@...1152...> <4CADE70D.8070307@...1147...>
	<20101007154740.GL10703@...1296...>
	<20101007160511.GM10703@...1296...>
In-Reply-To: <20101007160511.GM10703@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TAP installation Problem
 (2.1.3) on Windows 2000
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Hi Gert (and David),

Gert Doering wrote:
> Hi,
>
> On Thu, Oct 07, 2010 at 05:47:40PM +0200, Gert Doering wrote:
>   
>> On Thu, Oct 07, 2010 at 05:28:13PM +0200, Jan Just Keijser wrote:
>>     
>>>> WHy is that?
>>>>         
>>> it's a (minor) mistake in how openvpn 2.1.3 is packaged:
>>>       
>> This is not a mistake (as in "oops, we didn't know"), but was unavoidable 
>> since the latest WDK is needed to properly support signed drivers for 
>> Win7, and that version does not support Win2k anymore.
>>
>> OTOH, there *should* be a Windows 2000 install.exe, but right now 
>> I cannot find it on the download page either - James did build it,
>> with the old WDK/DDK, but somewhere in the release process it must 
>> have fallen through the cracks.
>>     
>
> David found it:
>
> http://secure.openvpn.net/win/openvpn-2.1.3-install.exe         (XP to 7)
> http://secure.openvpn.net/win/openvpn-2.1.3-install-win2k.exe   (w2k)
>
>   

thanks for sorting this out so quickly! I did not know that version 
still existed (and I'm an old-fashioned wk2 user ;-))

cheers,

JJK

