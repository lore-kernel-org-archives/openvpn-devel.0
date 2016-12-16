References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<753a3322-c5ea-758e-6298-a12f0e772896@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <631af8ae-a22d-5f61-ba4f-d6cd73c18277@...1856...>
Date: Fri, 16 Dec 2016 23:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <753a3322-c5ea-758e-6298-a12f0e772896@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 16-12-16 22:53, Arne Schwabe wrote:
> Am 16.12.16 um 19:26 schrieb Julien Muchembled:
>> The bug in Trac #792 (pointer wrongly truncated as 'int', leading to segfaults)
>> would have been understood faster with either
>>   -Werror=implicit or -Werror=format
>> (and above all, before running buggy executables in production)
>>
>> Debian already compiles with -Werror=format-security, and it's indeed a good
>> idea for a sensitive software like OpenVPN to use it.
>> ---
>>> Yes, please!
>>>
>>> You can put the macro in m4/
>>>
>>
>> OK. Not sure about the license. It's GPL3+
> 
> We cannot accept GPL3+ since it is incompatible with our license (GPL2).

Also for autoconf macro's that are not linked to our code at all?

-Steffan

