Message-ID: <e334e457-d65c-eae9-c90c-8ba090bfa085@...1227...>
Date: Thu, 20 Jan 2022 11:55:17 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-10-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-10-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 09/18] Allow management client to
 announce pss padding support
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
> The --management-external-key option can currently indicate support
> for 'nopadding' or 'pkcs1' signatures in the client. Add 'pss' as an
> option to announce that PSS signing requests are accepted.
> 
> To match, extend the algorithm string in PK_SIGN request to
> include the following format:
> 
> - RSA_PKCS1_PSS_PADDING,hashlag=name,saltlen=[max|digest]
> 
> Here 'name' is the short common name of the hash algorithm.
> E.g., SHA1, SHA256 etc.
> 
> Existing formats 'ECDSA' and 'RSA_PKCS1_PADDING' are unchanged.
> 
> v2 changes: Fix typos and other sloppiness in documentation and
> commit message.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>

Acked-By: Arne Schwabe <arne@...1227...>

