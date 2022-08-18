Message-ID: <6b261e98-96bc-5a51-5241-fa20b405fbcf@...1227...>
Date: Thu, 18 Aug 2022 21:48:02 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220520213250.3126372-1-arne@...1227...>
 <e39f7b53-b24d-0ce9-8685-767d2eb71d40@...2080...>
 <b14e6399-1735-041f-4d91-3285fe6ea5c5@...1227...>
 <7591466.7VjxKKiAKM@...2664...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <7591466.7VjxKKiAKM@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/4] Implement exit notification via
 control channel
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

Am 18.08.22 um 16:38 schrieb Heiko Hund:
> On Freitag, 1. Juli 2022 00:42:55 CEST Arne Schwabe wrote:
>> Basically if I had been a bit more forwarding looking we would now have
>> protocol-flags ekm cc-exit instead of key-derivation ekm and
>> protocol-flags cc-exit
> 
> Then maybe also add support for handling ekm via --protocol-flags and
> deprecate/remove sending --key-derivation?
> 

Yeah, I can do that in follow up patch to add ekm as accepted in 
protocol-flags

Arne

