Message-ID: <76e88931-8a45-f31d-d171-0555d4be71d1@...2181...>
Date: Thu, 3 Feb 2022 09:34:28 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220203082620.8186-1-a@...2181...>
 <YfuTDSyc1JOZdf8J@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YfuTDSyc1JOZdf8J@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] keyingmaterialexporter.c: include
 strings.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 03/02/2022 09:32, Gert Doering wrote:
> Hi,
> 
> On Thu, Feb 03, 2022 at 09:26:20AM +0100, Antonio Quartulli wrote:
>> strcasecmp() was initially declared in string.h and subsequently moved
>> to strings.h. For historical reasons it still exists in string.h, but
>> would require _DEFAULT_SOURCE to be defined.
>>
>> Due to the above, just include strings.h as currently dictated by the
>> manpage.
> 
> If we include strings.h, do we still need string.h then?

Yes, because the file also uses strlen() and strncmp() (declared in 
string.h)

Regards,

-- 
Antonio Quartulli

