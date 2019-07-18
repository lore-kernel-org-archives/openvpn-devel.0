References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
 <f5a58db3-8469-1577-155f-db2255e1d78c@...2181...>
 <CAGyAFMXsktWkyyyoPvWjVor-18o41C8O3ScMdACXS3vCMbz26Q@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <07cba947-e868-4b1d-7381-fed1ae55ace3@...2181...>
Date: Thu, 18 Jul 2019 14:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAGyAFMXsktWkyyyoPvWjVor-18o41C8O3ScMdACXS3vCMbz26Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>



On 18/07/2019 14:20, Lev Stipakov wrote:
> Hi,
> 
> 
>> Are we sure we can't call this function with 'len' longer than the
>> available space in 'key' ?
> 
> 
> Yep, because we get available space here:
> 
>> +    const int len = BCAP(key);
>>
> 
> and then pass it to rand_bytes:
> 

Ok, that sounds good, thanks!

> 
>>> +    if (!rand_bytes(BEND(key), len))
> 
> 

-- 
Antonio Quartulli

