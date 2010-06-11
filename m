Message-ID: <4C1248CB.8030005@...1114...>
Date: Fri, 11 Jun 2010 16:31:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
	<1275576515.23148.829.camel@...1259...>
In-Reply-To: <1275576515.23148.829.camel@...1259...>
Subject: Re: [Openvpn-devel] [PATCH] Re: Handling of subnets grammar in
 Packet filter file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/06/10 16:48, chantra wrote:
> Please find below a patch to correct the behaviour.
> 
> I have also opened a trac ticket :
> https://community.openvpn.net/openvpn/ticket/14
> 
> chantra


Thank you very much for your patch!  It's been accepted and merged into
bugfix2.1 and allmerged.

Commit a881843bf2101e77d15cb88105684288655055cb


kind regards,

David Sommerseth


>>
>> Hi all,
>>
>> It seems that openvpn is not handling properly non-standard subnets in
>> pf_file.
>> This issue happened on debian etch openvpn 2.1 rc11
>>
>> Today, while I made a typo, the following rule did not work properly:
>>
>>         # cat /dev/shm/openvpn_pf_73f2c3256a50371f057d5c0db97ede2f.tmp
>>         [CLIENTS DROP]
>>         
>>         [SUBNETS ACCEPT]
>>         +192.168.100.0/29
>>         -192.168.100.8/28
>>         
>>         [END]
>>         
>>
>> -192.168.100.8/28 was simply ignored which basically allowed the client
>> to ping the whole subnet
>>
>> The following rule behaved properly though.
>>
>>         # cat /dev/shm/openvpn_pf_f2b43d3cb1acd5a2720c01559cb03dc3.tmp
>>         [CLIENTS DROP]
>>         
>>         [SUBNETS ACCEPT]
>>         +192.168.100.0/29
>>         -192.168.100.0/28
>>         [END]
>>         
>>
>> I agree it is not a really bug as it is a user error in the first place
>> and openvpn carried on happily discarding this rule.
>> But maybe openvpn could try to handle such subnets and translate it as
>> 192.168.100.0/8.
>>
>> I could try to look into it if you guys believe it should be handled by
>> openvpn (or maybe this has already been fixed?)
>>
>> Regards,
>>
>> chantra
>>
> 
> !DSPAM:4c07c0c661671935912581!
> 
> 
> 
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwSSMsACgkQDC186MBRfrpVKwCfTR1/SMT5AoWCtW77D0vlmaMI
nEUAoKvVbt6KBglP0kVJbWqDUlUSMh6d
=8Ocg
-----END PGP SIGNATURE-----

