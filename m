References: <20210405080007.1665-1-a@...2181...>
 <20210405080007.1665-3-a@...2181...> <20210405103856.GO976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9577ce6a-a845-71ad-b777-010fe88ed376@...2181...>
Date: Mon, 5 Apr 2021 14:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210405103856.GO976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] ssl: remove unneeded if block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

Hi,

On 05/04/2021 12:38, Gert Doering wrote:
> Hi,
> 
> On Mon, Apr 05, 2021 at 10:00:07AM +0200, Antonio Quartulli wrote:
>>      /* compute PRF */
>> -    if (!ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len))
>> -    {
>> -        ret = false;
>> -    }
>> +    ret = ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output,
>> +                       output_len);
> 
> If touching this, I would move the "bool ret" declaration to here as
> well.  Doesn't make sense to have a "bool ret = true" declaration 15
> lines further up if the first use is "assign it a new value", then.
> 
> Thus,
> 
> +    bool ret = ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len,
> +                            output, output_len);
> 

Agreed. v2 will land soon.

Regards,

-- 
Antonio Quartulli

