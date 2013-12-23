Message-ID: <52B88DD2.6060600@...1800...>
Date: Mon, 23 Dec 2013 14:24:02 -0500
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <l8qvsn$jif$1@...1062...> <52B79339.2040202@...1800...>
	<52B8049B.6040407@...1147...>
In-Reply-To: <52B8049B.6040407@...1147...>
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/23/2013 4:38 AM, Jan Just Keijser wrote:
 Hi,
>> Its been a while since I tried / checked, but is there any support for
>> generating keys on an actual hardware token in Windows ?
>> Specifically, it would be great if I could do this with the
>> Safenet/Aladin java etoken.
>>
>> I can do it on Unix using the older non java version keys, but I never
>> quite figured out how to do it in Windows, and there is no Java etoken
>> support that I have found on FreeBSD as it requires pkcs15 via OpenSC.
>>   
> the newer Safenet java etokens require the Safenet driver software (or
> Aladdin eToken driver v5.0+). If you don't have access to this software
> then you're out of luck. If you do have access then generating keys on
> the token is doable (but not supported by easy-rsa at this moment).
> I've written scripts that work in both Windows (cygwin) and Linux to
> generate and install keys and certs on Aladdin/SafeNet etokens
> (32K/64K/72K). At one point I documented this for an older version of
> the eToken driver
>  http://wiki.nikhef.nl/grid/EToken
> esp section
> http://wiki.nikhef.nl/grid/Storing_your_grid_certificate_on_an_Aladdin_eToken
> 
> but the basic principe is the same for the newer driver (use
> eTPKcs11.dll on Windows)
> If there's any interest we could integrate this into the easy-rsa
> scripts, but as Eric Crist pointed out, this is VERY hardware and
> platform dependent.

Thanks! I will give this a try over the holidays. I do have the drivers
and client software for Windows. I just was never able to get a cert
generated under windows

	---Mike



-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

