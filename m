Message-ID: <c3390e5f-f83b-169f-bbec-2162c952d1e0@...1227...>
Date: Thu, 20 Jan 2022 12:22:19 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-17-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-17-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 16/18] Add a unit test for external
 key provider
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
> Tests:
> - Check SIGNATURE and KEYMGMT methods can be fetched
>    from the provider
> - Load sample RSA and EC keys as management-external-key
>    and check that their sign callbacks are correctly exercised:
>    with and without digest support mocked in the client
>    capability flag.


Acked-By: Arne Schwabe <arne@...1227...>

