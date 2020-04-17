References: <20200328040858.16505-1-arne@...1227...>
 <20200401102159.29157-1-arne@...1227...>
 <20200401102159.29157-2-arne@...1227...>
 <57775d47-ddd4-0581-aeaa-294c148a77fc@...2181...>
 <9b0ee1f1-79ab-1217-f68a-5bb7cdd4bfbd@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <de8c4495-1747-f2d1-9004-a2183ebebb6f@...2181...>
Date: Fri, 17 Apr 2020 10:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <9b0ee1f1-79ab-1217-f68a-5bb7cdd4bfbd@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] Implement tls-groups option to
 specify eliptic curves/groups
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 17/04/2020 09:47, Arne Schwabe wrote:
> Am 16.04.20 um 00:31 schrieb Antonio Quartulli:
>> is it really important to clone "groups" ? why just not chopping it ?
>> It shouldn't be re-used any more I think.
> 
> Maybe but modifying a parameter as side effect does not feel right. I
> rather have a clean API here instead of this unintended side stuff that
> can lead to kind of interesting bugs.

yeah, makes sense.

> 
>> If we really really need to alloc this memory, can't we get a gc from
>> outside? maybe from the option parser? We normally avoid explicit
>> alloc/free in the code.
> 
> The problem with a gc from the outside is that we don't really want to
> tie up the memory in options->gc as that would just be extra memory that
> is allocated the whole session I will update the patch to use a local gc.
> 

yeah, that would fit our style I think.

Thanks!

-- 
Antonio Quartulli

