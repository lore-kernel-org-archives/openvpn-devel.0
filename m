Message-ID: <2ca51abc-21d2-3107-ec99-34714d64d0d0@...1227...>
Date: Thu, 20 Jan 2022 12:11:57 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-14-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-14-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 13/18] Add a generic key loading
 helper function for xkey provider
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
> - Load keys by specifying the opaque privtae key handle,
>    public key, sign-op and free-op required for loading keys
>    from Windows store and pkcs11.
> 
> - xkey_load_management_key is refactored to use the new function
> 
> - Also make xkey_digest non-static
> 
> Used in following commits to load CNG and pkcs11 keys
>


Acked-By: Arne Schwabe <arne@...1227...>


