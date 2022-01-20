Message-ID: <53ab5ec6-df69-49fa-8468-1b9331c6eb20@...1227...>
Date: Thu, 20 Jan 2022 11:53:37 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-7-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-7-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 06/18] A helper function to import
 private key for management-external-key
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
> - Leverage keymgmt_import through EVP_PKEY_new_fromdata() to
>    import "management-external-key"
> 
> - When required, use this to set SSL_CTX_use_PrivateKey
> 
> The sign_op is not implemented yet. This will error out while
> signing with --management-external-key. The next commit
> fixes that.

Acked-By: Arne Schwabe <arne@...1227...>

