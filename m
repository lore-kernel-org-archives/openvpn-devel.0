Message-ID: <5f4bad2e-7707-b7e2-7930-a7dfe0a48167@...1227...>
Date: Fri, 5 Aug 2022 17:16:28 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220805151325.14021-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220805151325.14021-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: disable DCO if --allow-compress
 yes/asym was specified
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 05.08.22 um 17:13 schrieb Antonio Quartulli:
> Allowing compression means that we may accept a pushable compress
> setting.
> This scenario can't work with DCO therefore disable it when compression
> is allowed.
> 

Acked-By: Arne Schwabe <arne@...1227...>


