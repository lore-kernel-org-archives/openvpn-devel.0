References: <20200429145132.28424-1-juliusz@...2525...>
 <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
 <adff39d0-a071-0522-9869-a7cc1893b26f@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <86f7b6e6-5d0d-200d-b84e-90c220bf9693@...2525...>
Date: Thu, 7 May 2020 12:49:15 +0200
MIME-Version: 1.0
In-Reply-To: <adff39d0-a071-0522-9869-a7cc1893b26f@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

currently it is macro'ed to wolfSSL_lib_version which only returns the 
version string. I will add our library name to the front of the 
OpenSSL_version return string.

Thanks,
Juliusz

On 07/05/2020 12:35, Arne Schwabe wrote:
> Am 07.05.20 um 12:28 schrieb Antonio Quartulli:
>> Thu May  7 12:16:12 2020 library versions: 4.4.0, LZO 2.10
> Additionally it seems the OpenSSL_version(OPENSSL_VERSION) function does
> not include the library name. OpenSSL reports itself here:
>
>   library versions: OpenSSL 1.1.1g  21 Apr 2020
>
> also other library will say LibreSSL or BoringSSL in place of OpenSSL
> here. It would be nice to have here wolfSSL or OpenSSL (wolfSSL compat
> layer) or something that indicates wolfSSL in the
> OpenSSL_version(OPENSSL_VERSION) result.
>
> Arne
>

