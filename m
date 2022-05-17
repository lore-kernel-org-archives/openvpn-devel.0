From: Kristof Provost <kprovost@...2661...>
Date: Tue, 17 May 2022 17:29:36 +0200
Message-ID: <4F94D259-DDA4-49B3-907B-E32BAC4653D7@...2661...>
In-Reply-To: <baa46ee9-7b4a-1a5c-d38f-4359e5d5f814@...2181...>
References: <20220516185621.6182-1-kprovost@...2661...>
 <20220516185621.6182-3-kprovost@...2661...>
 <baa46ee9-7b4a-1a5c-d38f-4359e5d5f814@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/4] rework do_up() for correct order of
 DCO operations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 17 May 2022, at 15:28, Antonio Quartulli wrote:
> On 16/05/2022 20:56, Kristof Provost via Openvpn-devel wrote:
>> From: Kristof Provost <kp@...1376...>
>>
>> We must create the peer before we can dco_set_peer or dco_new_key.
>> On the other hand, we must first process options, because those may
>> change our peer id and we should create the peer with the correct id.
>>
>> Split up do_deferred_options() in do_deferred_options() and
>> finish_options(). Call any DCO configuration operations (i.e.
>> dco_set_peer()/dco_new_key()) after we've created the peer (i.e.
>> dco_new_peer()).
>>
>> Signed-off-by: Kristof Provost <kprovost@...2661...>
>
> I am including this patch in the dco branch as well.
>
> Please note that this change has been reworked a little bit.
>
Thanks!

Kristof

