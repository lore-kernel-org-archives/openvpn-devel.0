Message-ID: <226d7a00-00ff-2c3d-f7f3-79b316231b49@...1227...>
Date: Mon, 26 Dec 2022 20:49:44 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
 <20210907223126.8440-2-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20210907223126.8440-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Permit unlimited connection
 entries and remotes
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 08.09.21 um 00:31 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Currently we allow a max of 64 connection entries and remotes.
> A larger number would allow users with 100's of independent
> config files for different end points of same provider to
> consolidate them to connection entries.
> 
> v2,v3: no change
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>

Acked-By: Arne Schwabe@...1227...

We are now increasing by multiple of 64 entries. While a bit wasteful 
and we could have used smaller increments, the memory lost here is not 
really a concern.

Arne

