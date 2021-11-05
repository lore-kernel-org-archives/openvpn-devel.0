Message-ID: <22613922-5735-f2e3-812e-c58651534157@...2181...>
Date: Fri, 5 Nov 2021 17:31:44 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211019183127.614175-1-arne@...1227...>
 <20211105161302.2916786-1-arne@...1227...> <YYVZwxdsTos+G8+1@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YYVZwxdsTos+G8+1@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] Refactor early initialisation and
 uninitialisation into methods
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
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 05/11/2021 17:20, Gert Doering wrote:
> Hi,
> 
> On Fri, Nov 05, 2021 at 05:13:02PM +0100, Arne Schwabe wrote:
>> +static void uninit_early(struct context *c)
>> +{
>> +    net_ctx_free(&c->net_ctx);
>> +}
> 
> The extra "&" here does not look right.  Shouldn't this be
> "c->net_ctx" as in "init_early()"?

it's the other way around.

"init_early()" should also use the "&" operator.

We need to pass a pointer to the networking context, but the member is a 
real object.

(Check the code being removed for reference).

Regards,




-- 
Antonio Quartulli

