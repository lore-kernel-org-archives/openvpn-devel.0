Message-ID: <8982651b-6563-1cc7-2f87-b6ef3cd76e58@...1227...>
Date: Thu, 20 Jan 2022 11:15:56 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-3-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-3-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 02/18] Implement KEYMGMT in the xkey
 provider
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

Am 14.12.21 um 17:59 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> A minimal set of functions for keymgmt are implemented.
> No support for external key import as yet, only native
> keys. Support for native keys is required as keys may
> get imported into us for some operations as well as
> for comparison with unexportable external keys that we hold.
> 
> Implementation of signature callbacks is in the next commit.
> 
> v2 changes: This was commit 3/9 in v1
> v3 changes: When OpenSSL native key is imported instead of duplicating
> the whole key, use only the public components for public key.
> 

Acked-By: Arne Schwabe <arne@...1227...>



