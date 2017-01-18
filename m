References: <3fdeb614-4be9-8843-7992-2f1937402644@...277...>
	<f33609b6-de8b-985d-aee4-9d18a2d58517@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <e931f0e7-8e74-c434-0495-38e24b200c91@...277...>
Date: Wed, 18 Jan 2017 21:07:13 +0000
MIME-Version: 1.0
In-Reply-To: <f33609b6-de8b-985d-aee4-9d18a2d58517@...2080...>
Subject: Re: [Openvpn-devel] [openvpn-devel] --auth RSA-SHA512 vs --auth
 SHA512
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
To: openvpn-devel@lists.sourceforge.net



On 18/01/17 19:17, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 18/01/17 18:19, debbie10t wrote:
>> Hi,
>>
>> I have following config:
>>
>>
>> ** Server Win10 (as per default generally) v2.4.0 with --auth
>> *RSA-SHA512* --ncp-disable
>>
>> Log file shows:
>>
>> Wed Jan 18 17:04:34 2017 us=914797 Outgoing Control Channel
>> Authentication: Using 512 bit message hash '*SHA512*' for HMAC
>> authentication Wed Jan 18 17:04:34 2017 us=914797 Incoming Control
>> Channel Authentication: Using 512 bit message hash '*SHA512*' for
>> HMAC authentication
>>
>>
>> ** Client Linux (as per default generally) v2.4.0 with --auth
>> *RSA-SHA512*
>>
>> Log file shows:
>>
>> Wed Jan 18 17:05:00 2017 us=778089 Outgoing Control Channel
>> Authentication: Using 512 bit message hash '*SHA512*' for HMAC
>> authentication Wed Jan 18 17:05:00 2017 us=778182 Incoming Control
>> Channel Authentication: Using 512 bit message hash '*SHA512*' for
>> HMAC authentication
>>
>> The connection works but ..
>>
>> Because there is another digest called SHA512 why does the log
>> *not* reflect the config correctly ? eg: hash '*RSA-SHA512*'
>>
>> (This had me very confused for sometime today)
>
> I am on thin ice here, as I've not dug much into the naming schemes of
> the various algorithms.
>
> But ... I am fairly confident the hashing reference in the log refers
> purely to the hashing algorithm, which most commonly is MD* or  SHA*
> variants (there are a few exceptions).
>
> And as I understand the code, the RSA-* stuff is just ignored, as that
> is not used by by HMAC functions in our code.  So using --auth SHA512
> would provide the same result.
>


Hi David,

thanks for your reply

On your explanation I tested with mixing things up.

Server --auth SHA512** --ncp-disable
Client --auth RSA-SHA512**

(** Also the other way around)

and I was able to connect any way around !! and ping etc ..

I was badly distracted earlier on so may have not done restarts properly
or more likely use SHA256 not 512 on one or other ends ..
FTR --ncp-disable helped me focus a *lot* , recommended step for 
diagnostic problems.

This question was related to trying to test mattock's aslr/dep version
(which I can now test more thoroughly) and also to this forum post:
https://forums.openvpn.net/viewtopic.php?f=4&t=23241

As you can see, it looks like I may have been wrong on that too :(
(We all make mistakes) If you would like to improve my answer please do.
If not, I will update tomorrow.

Also, I received this from pippin (Thank you pippin):

<q>
Found it:
http://security.stackexchange.com/questions/91908/using-rsa-sha-as-instead-hmac-in-openvpn
</q>

Shared: it also has an detailed explanation.

Highest Regards
R

