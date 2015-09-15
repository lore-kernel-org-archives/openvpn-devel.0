References: <55DB4C39.9040105@...2010...>
	<55DDBBE2.9010205@...1114...>
From: Boris Lytochkin <lytboris@...2010...>
Message-ID: <55F7EFD0.1040501@...2010...>
Date: Tue, 15 Sep 2015 13:15:44 +0300
MIME-Version: 1.0
In-Reply-To: <55DDBBE2.9010205@...1114...>
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
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

Hi.

Any news on importing this patch into codebase?

On 26.08.2015 16:15, David Sommerseth wrote:
> On 24/08/15 18:54, Boris Lytochkin wrote:
>> Hi.
>>
>> Author: Boris Lytochkin <lytboris@...2010...>
>> Sponsored-by: Yandex LLC
>>
>> Log serial number of revoked certificate
>>
>> In most of situations admin of OpenVPN server needs to know which
>> particular certificate is used by client.
>> In the case when certificate is OK, environment variable can be used for
>> that but once it is revoked no user scripts are invoked so there is no
>> way to get serial number: only subject is printed in logs. Patch
>> attached addresses this issue logging certificate directly on the line
>> with certificate subject.
>>
>> Tested with OpenSSL but PolarSSL should be good too.
>>
>> Signed-off-by Boris Lytochkin <lytboris@...2010...>
> Feature-wise, this makes a lot of sense.  And as Gert has said, the
> serial numbers are unique to the CA being used, which fits OpenVPN use
> cases well.  The vast majority of OpenVPN installations with PKI uses an
> internal CA which the admins have full control over.
>
> I have only done a code review and a quick compile with 'make check'.
>  From that perspective, I can give it an ACK on the code side.  It looks
> correct as far as I can understand.  It would be good if Steffan could
> give especially the PolarSSL side an extra check, but even that looks
> good to me.
>
> I have *not* tested this against a CRL file yet.  I hope I don't jinx it
> when I say I think the behaviour in that case will be very predictable.
>
>

-- 
Boris Lytochkin
Yandex NOC
+7 (495) 739 70 00 ext. 7671


