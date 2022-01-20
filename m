Message-ID: <873eed71-84ae-f620-d28d-6855093de8b1@...1227...>
Date: Thu, 20 Jan 2022 12:11:17 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-12-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-12-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 11/18] Support sending DigestSign
 request to management client
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
> To receive undigested message for signing, indicate support
> for handling message digesting in the client using an argument
> "digest" to --management-external-key.
> 
> For example, to announce pkcs1 padding and digesting support use:
> 
> --management-external-key pkcs1 pss digest
> 
> In PK_SIGN, the algorithm string will get data=message
> in addition to other relevant options.
> 
> Note that it is not guaranteed that the client will be prompted
> with undigested message. This is possible only when OpenSSL
> calls our provider for DigestSign() as opposed to Sign(). In
> practice, signature operation always appears to result in
> a DigestSign() call through the provider interface.
> 


Acked-By: Arne Schwabe <arne@...1227...>


