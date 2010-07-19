Message-ID: <4C44D0EB.4040703@...1114...>
Date: Tue, 20 Jul 2010 00:25:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC96D34.3000408@...515...> <4BDCA3DD.2010705@...1114...>
	<4BDCBA97.9090202@...1123...> <201007192332.28862.arthur@...1389...>
In-Reply-To: <201007192332.28862.arthur@...1389...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Does --multihome work in latest
	OpenVPN release?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arthur Titeica <arthur@...1389...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/07/10 22:32, Arthur Titeica wrote:
> On Sunday 02 May 2010 02:34:47 Peter Rabbitson wrote:
>> David Sommerseth wrote:
>>> On 01/05/10 21:39, Peter Rabbitson wrote:
>>>> Peter Rabbitson wrote:
>>>>> Peter Rabbitson wrote:
>>>>>> Samuli Seppänen wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Is someone successfully using the --multihome option on latest
>>>>>>> OpenVPN release? Or is this bug report still valid:
>>>>>>>
>>>>>>> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=562099>
>>>>>>
>>>>>> I am sorry I dropped the ball on testing that one. Will test the
>>>>>> coming night EST, and update.
>>>>>
>>>>> Looking more at the *debian* changelog, I see that there was a 3rd
>>>>> party ipv6 patch, which *could* have caused these problems. However it
>>>>> is not very easy for me to compile a "clean" openvpn on the multihomed
>>>>> server. Please let me know if this can be diagnosed in any other way,
>>>>> if not - I will find a way to test with vanilla openvpn.
>>>>
>>>> And unfortunately I was right (proven with the help of [1]) :(
>>>>
>>>> openvpn_2.1~rc20-1_i386.deb works
>>>> openvpn_2.1~rc20-2_i386.deb does not
>>>>
>>>> The only code-change between the two is:
>>>>   * patches/jjo-ipv6-support.patch: Added ipv6 support. (Closes:
>>>>   #307846)
>>>>   
>>>>     Patch from JuanJo Ciarlante.
>>>>
>>>> So this got to be the culprit. Attaching a -U10 diff between the sources
>>>> of both debian packages (not too long):
>>>>
>>>> [1] http://snapshot.debian.org/package/openvpn/
>>>
>>> Thank you very much, Peter, for tracking this one down!  One question
>>> though.  Do you have configuration files and a "how to test it"
>>> description available which you could share with us?  That would help
>>> others to test it out as well - and it might help JJO to follow this one
>>> further.
>>
> 
> Hello, 
> I'm using the latest git 
> (git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git) and 
> multihome doesn't seems to work as far as I've tested.
> 
> I have 2 links balanced with something like
> 
> # ip route show
> ...
> default 
>         nexthop via x.x.x.x  dev eth2 weight 2
>         nexthop via y.y.y.y  dev ppp5 weight 1
> 
> and openvpn somehow fails with or without multihome.
> 
> I'm not a programmer but I'dd gladly help with anything else (making tests, 
> patches or even providing a test multihomed openvpn server).
> 

(moving over to the developers mailing list)

Thank you for your testing!  If you put together some configuration
files for client and server and a clear description of how to test this,
that would save a lot of time for us when digging into the code.

If your config files makes use of certificates, please make your test
environment work by using the keys in the source tree, located in the
sample-keys/ directory.

Please try to make the config files for us as close to your setup as
possible.  This will really help us get closer to understand what
exactly happens.

I have opened a bug ticket on this issue, to not forget this issue.  It
can be tracked here:
<https://community.openvpn.net/openvpn/ticket/28>

Please report back with configuration files and a description of how to
prepare an environment for reproducing this behaviour.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxE0OsACgkQDC186MBRfro0eACgmjjPpSObOVHp/5TRIUHD2B/+
1QkAnirsODWvxsJo29MZSSqeX23/yzZf
=zbIE
-----END PGP SIGNATURE-----

