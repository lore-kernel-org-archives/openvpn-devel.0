References: <20170803160304.35518-1-debbie10t@...277...>
 <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <db3fbd7b-3fac-6bc2-b99f-9188fe553cfc@...277...>
Date: Thu, 3 Aug 2017 18:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct
 --verify-x509-name *type* example
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Richard Bonhomme <fragmentux@...277...>



On 03/08/17 17:46, David Sommerseth wrote:
> On 03/08/17 18:03, debbie10t@...277... wrote:
>> From: Richard Bonhomme <fragmentux@...277...>
>>
>> Signed-off-by: Richard Bonhomme <fragmentux@...277...>
>> ---
>>   doc/openvpn.8 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index 20bdd91..fdd5dde 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -5340,7 +5340,7 @@ subject DN "C=KG, ST=NA, L=Bishkek, CN=Server-1" would be matched by:
>>   and
>>   .B \-\-verify\-x509\-name Server\-1 name
>>   or you could use
>> -.B \-\-verify\-x509\-name Server -name-prefix
>> +.B \-\-verify\-x509\-name Server\- name\-prefix
>>   if you want a client to only accept connections to "Server-1", "Server-2", etc.
> 
> Just wondering ... Shouldn't the "Server-1" and "Server-2" be escaped too?
> 
> 

Yes of course but I only wanted to correct the example at this time
and, as this is my first submission, I just wanted to get that right.
I will start a project to format the man page more thoroughly in time.


