References: <f98cdb16-55ce-b4e6-13de-163c5f352cdf@...2553...>
 <9adbbf1d-0f9f-ef78-a7fc-2d54974d12a5@...1227...>
From: =?UTF-8?Q?Bruno_Tr=c3=a9guier?= <bruno-sourceforge@...2553...>
Message-ID: <7d7b5d89-b127-c339-8751-4841774672f3@...2553...>
Date: Thu, 9 Apr 2020 00:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <9adbbf1d-0f9f-ef78-a7fc-2d54974d12a5@...1227...>
Content-Language: fr
Subject: Re: [Openvpn-devel] Openvpn3: hardware address of connecting client
 not being reported on Linux ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 08/04/2020 23:37, Arne Schwabe wrote:
> 
>> But it seems that on a Linux platform, the different #if, #elif and
>> #endif statements lead to a situation where almost all code is excluded
>> from compilation, and an empty string is returned at the end of the
>> function. So in short, nothing seems to be done on the Linux side, and
>> so the whole thing simply cannot work.
>>
>> Is my assumption right ? Any clues regarding this ?
> 
> Yes. Mac address reporting on Linux has never been implemented. If you
> look at hwaddr.hpp you see that there is no code for Linux.

Thanks Arne. So that explains it all. It had been implemented for
openvpn 2, though, but the codebase seems very different.


> IV_PLAT_VER needs to set by the UI, same as IV_GUI_VER. The UI can also
> override the mac address that is being. This for example done on android
> as implementation for the MAC address.

Ok, nice trick. Still haven't figured out how to do it though. I traced
it down to the parse_extras() function, but I'm having a hard time
understanding how that config file parsing takes places.

Thanks very much anyway!

Best regards,

Bruno

