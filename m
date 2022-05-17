Message-ID: <4e3b8ab7-50f0-460c-085c-403b9eb8763a@...2181...>
Date: Tue, 17 May 2022 13:51:20 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220516185621.6182-1-kprovost@...2661...>
 <20220516185621.6182-2-kprovost@...2661...>
 <a3ea68a6-fc22-e6ae-bdae-feb504320f3f@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <a3ea68a6-fc22-e6ae-bdae-feb504320f3f@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] mtcp: Handle
 multi_create_instance() returning NULL
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
To: Arne Schwabe <arne@...1227...>, Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi all,

On 16/05/2022 21:32, Arne Schwabe wrote:
> 
> Am 16.05.2022 um 20:56 schrieb Kristof Provost via Openvpn-devel:
>> From: Kristof Provost <kp@...1376...>
>>
>> multi_create_instance() can fail (i.e. return NULL).
>> multi_create_instance_tcp() is ready for this, but called
>> multi_assign_peer_id() without first checking if mi was non-NULL.
>> multi_assign_peer_id() assumed that mi is non-NULL, dereferencing it and
>> causing a crash.
>>
>> Move the call to multi_assign_peer_id() after the mi NULL check.
>>
> I did add multi_assign_peer there iirc but Kristof is right.
> 
> Acked-By: Arne Schwabe <arne@...1227...

Thank you both.

I am pulling this patch in the dco branch.

Regards,

-- 
Antonio Quartulli

