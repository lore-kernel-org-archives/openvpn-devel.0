References: <20200217115522.20068-1-arne@...1227...>
 <20200217115522.20068-2-arne@...1227...>
 <CAGyAFMXWV6nk5EBnnaQQC=zds2ZCyqLewo8kw23_To1NXJDGZw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bceeedf8-0bd8-bd7a-6de0-f81f9e10f375@...1227...>
Date: Mon, 17 Feb 2020 14:52:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMXWV6nk5EBnnaQQC=zds2ZCyqLewo8kw23_To1NXJDGZw@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v3 2/5] Implement dynamic NCP negotiation
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
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 17.02.20 um 14:42 schrieb Lev Stipakov:
> Hi,
> 
> Tested with Windows server and Linux client, negotiation works.
> 
> A few nit-picks, which could be fixed with follow-up patch:
> 
>> + * @param gc   gc arena that is ONLY used to allocate the returned string
> 
> This is not true, since it is also used inside tls_peer_ncp_list()
> to generate temp string containing client pushed ciphers.
> 
>> +ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>> +                    const char *peer_info,  const char *remote_cipher,
>> +                    struct gc_arena *gc)
>> +{
>> +    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, gc);
> 
> That gc has lifetime of VPN tunnel and is used here to allocate
> a temp string which is needed only in this function.

I sent a patch to fix those as 6/5.


> 
>> -    const char *config_authname;
> 
> This doesn't seem to be related to NCP negotiation.

The first version of NCP was intended to later also allow to negiate
authname aswell as cipher, so saving the config_authname would have been
required but this was never implemented and Steffan and I discussed this
during the last Hackathon and we concluded that we don't want dynamic
--auth as part of NCPv2 as well, so NCPv2 removes this leftover code.

Arne


