Message-ID: <096c6e71-bb22-25bb-d968-26ce2a86fee7@...1227...>
Date: Thu, 20 Jan 2022 11:54:07 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-8-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-8-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 07/18] Enable signing via provider
 for management-external-key
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
> - Add a function to set as sign_op during key import. The
>    function passes the signature request to management interface,
>    and returns the result to the provider.
> 
> v2 changes: Method to do digest added to match the changes in
>              the provider signature callback.
> TODO:
>   - Allow passing the undigested message to management interface
>   - Add pkcs1 DigestInfo header when required
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> 

Acked-By: Arne Schwabe <arne@...1227...>


