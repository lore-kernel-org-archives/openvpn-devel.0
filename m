Message-ID: <065bb0ee-e08a-dd1b-a92a-ea21e03bb26a@...2181...>
Date: Thu, 30 Jun 2022 15:51:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220629122924.13031-1-a@...2181...>
 <20220629124945.13448-1-a@...2181...> <5069006.p9XQp8U4Oj@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <5069006.p9XQp8U4Oj@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v4] dco: let open_tun_generic handle the
 DCO case
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

On 30/06/2022 15:44, Heiko Hund wrote:
> On Mittwoch, 29. Juni 2022 14:49:45 CEST Antonio Quartulli wrote:
>> name when not specified b the user. For this reason the DCO case can
> 
> nit: b -> by

thanks

> 
>> +                            strncpynt(tunname, dynamic_name,
>> +                                      sizeof(dynamic_name));
> 
> This need to be sizeof(tunname).

ouch, good catch! Thanks!

-- 
Antonio Quartulli

