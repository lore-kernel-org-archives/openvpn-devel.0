Message-ID: <d78dac02-b860-4fde-b786-12c637d4b76d@...2181...>
Date: Fri, 21 Feb 2025 14:08:27 +0100
MIME-Version: 1.0
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
 <Z7hqbzqBZG1EC6jR@...2685...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Z7hqbzqBZG1EC6jR@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat
 network option
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
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 21/02/2025 12:58, Frank Lichtenheld wrote:
> On Thu, Feb 20, 2025 at 04:48:27PM -0300, Rafael Gava wrote:
>> +bool
>> +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
>> local_ip)
>> +{
>> +    int i;
>> +    bool ret = false;
>> +
>> +    if (!dest) {

Also, the opening '{' should go on its own line, like you did for all 
other blocks.

Regards,

-- 
Antonio Quartulli


