References: <20170102141723.mtgdfznx5rcsdurs@...30...>
	<20170102142646.GL78624@...1296...>
	<1fe64726-57a5-0496-5e40-67b80d8e9b3b@...1435...>
	<1483370642.926699217@...2230...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <061fcbb0-b364-63cf-9291-42db17348ca1@...1435...>
Date: Mon, 2 Jan 2017 16:39:26 +0100
MIME-Version: 1.0
In-Reply-To: <1483370642.926699217@...2230...>
Subject: Re: [Openvpn-devel] 2.4 sees all client certificates as expired
 when using crl-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net

On 02-01-17 16:24, SviMik wrote:
> 
>> On 02-01-17 15:26, Gert Doering wrote:
>>> On Mon, Jan 02, 2017 at 03:17:23PM +0100, Alberto Gonzalez
>>> Iniesta wrote:
>>>> I just got this [1] bug report on OpenVPN 2.4 threating all
>>>> certs as expired when upgrading from 2.3. I find this quite
>>>> weird, but until I have some time to test it I thought asking
>>>> here would be faster.
>>> 
>>> From the bug report:
>>> 
>>> Mon Jan  2 07:37:10 2017 us=466023 1.2.3.4:36241 VERIFY ERROR:
>>> depth=0,
>> error=CRL has expired: C=XX, ST=XX, L=XXX, O=None, CN=mycn, 
>> emailAddress=my@...2228...
>>> 
>>> "what the log says" :-)
>>> 
>>> 2.4 checks CRLs much more rigidly than 2.3 (precisely: 2.3 had
>>> some built-in checking which only looked at revocations, while
>>> 2.4 leaves this to the crypto library, and they check all fields
>>> more rigidly).
>>> 
>>> Specifically, CRLs with an expired "next update" field are
>>> flagged as "expired" by OpenSSL, while the built-in check in 2.3
>>> did not.
>> 
>> This.  I replied something similar on the debian bug tracker, but I
>> have no clue what will happen with that mail.
>> 
>>> Since this bit a few people already, I wonder how we could
>>> communicate this better.
>> 
>> I wonder about that too.  Maybe some more verbose text on a wiki
>> page? We could even detect this specific error and add a link to
>> that page in the warning.
>> 
> 
> Is there an option to disable this check? It would be extremely
> useful to maintain (at least optional) backward compatibility with
> already existing setups, which originally relied on 2.3 behaviour.
> 

No, there is not.  And I don't think there is an easy way to implement
that either.

But, the fix is just as easy as the workaround:  just regenerate the
CRL, with a more correct nextUpdate value.  If you don't want your CRLs
expire, just put that value far enough into the future.

-Steffan

