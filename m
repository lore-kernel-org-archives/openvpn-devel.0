Message-ID: <652b8fe7-95c0-3237-e0c6-d6a23fd1b0f2@...2080...>
Date: Wed, 6 Apr 2022 15:41:57 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <67b5b48f-619a-b344-9f51-e1bba55aa3d2@...2181...>
 <d2fd8d11-225c-992c-28f4-9a8522d65b37@...2669...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <d2fd8d11-225c-992c-28f4-9a8522d65b37@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

On 06/04/2022 14:44, Timo Rothenpieler wrote:
>>>
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -794,6 +794,25 @@ dnl
>>>       esac
>>>   fi
>>> +dnl
>>> +dnl Depend on libcap-ng on Linux
>>> +dnl
>>> +case "$host" in
>>> +    *-*-linux*)
>>> +        PKG_CHECK_MODULES([LIBCAPNG],
>>> +                  [libcap-ng],
>>> +                  [have_libcapng="yes"],
>>
>> do we really need have_libcapng? it seems it is not used further in 
>> configure.ac
> 
> I have little to no experience with autotools, and I think this is 
> straight up copied from the openvpn3 setup.

That's probably right.

> Can I just leave the line empty? Or put empty [] there?

Yes, [] should suffice.  That said, it makes no big difference if it is 
there or not.  If needed to check ("test") if libcap-ng is available or 
not, this checks needs to be added again though.

That said, we do not have a consistent way of using PKG_CHECK_MODULES() 
in general.  We have at least 4 different ways in use today.

Probably something to clean-up some day later.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


