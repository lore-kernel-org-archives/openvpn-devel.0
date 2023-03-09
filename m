Message-ID: <62eccc04-3b65-edd7-9233-3ba3dc1999e1@...2181...>
Date: Thu, 9 Mar 2023 09:57:05 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230309005208.29704-1-a@...2181...>
 <F9C9036B-0A31-4F9A-AD15-682141A1C069@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <F9C9036B-0A31-4F9A-AD15-682141A1C069@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print version to log if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

On 09/03/2023 09:36, Kristof Provost wrote:
> On 9 Mar 2023, at 1:52, Antonio Quartulli wrote:
>> In order to provide better support in case of troubleshooting issues,
>> it's important to know what exact DCO version is loaded on the user
>> system.
>>
>> Therefore print the DCO version during bootup.
>>
>> For Windows and FreeBSD we currently implement a placeholder printing 'v0'.
>> This should be improved with a follow-up patch.
>>
> FreeBSD is a bit special in this regard, because the DCO driver is part of the base operating system and not an add-on as in Linux and Windows.
> 
> Arguably the thing to do for FreeBSD is to log the OS version.

Isn't it possible to install DCO "out-of-tree" (as we can do on Linux)?

However, what you said will also apply to linux in the future: we will 
also need to report the kernel version, *if* DCO is compiled in (to be 
implemented).

This said, reporting the kernel/os version is absolutely appropriate if 
that's what identifies the DCO version.

Is that something you could implement in dco_freebsd.c?


Cheers,

> 
> Kristof

-- 
Antonio Quartulli

