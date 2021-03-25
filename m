References: <20201215164221.5995-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e4f72923-f6d6-2420-d952-054953ba49cb@...2181...>
Date: Thu, 25 Mar 2021 23:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <20201215164221.5995-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Move context_auth from context_2 to
 tls_multi
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
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 15/12/2020 17:42, Arne Schwabe wrote:
> Some code currently is doing weird workarounds to figure out that side
> as side effect from other variables in tls_multi.
> 

Arne can you rephrase what this patch is trying to address?
I think I understand the implementation, but I fail to see what this
patch is improving.

Is this related to the tls_multi vs c2 lifecycle? or?

Cheers,


-- 
Antonio Quartulli

