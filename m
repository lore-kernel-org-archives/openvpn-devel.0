References: <20200414185214.1863-1-juliusz@...2525...>
 <c33a84b3-b10a-a8c2-d46a-3ee2d296f7f1@...1227...>
 <8b1d14d6-9ca4-46f3-b038-0fbc5af568ff@...2525...>
 <e63c8973-e8f2-bdd2-8925-a89df7ad4339@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <f0e08905-cdd4-cdd6-ce1c-ff86ee0d6f3e@...2525...>
Date: Thu, 16 Apr 2020 17:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <e63c8973-e8f2-bdd2-8925-a89df7ad4339@...1227...>
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The Readme looks good. Just one suggestion.

On 16/04/2020 13:11, Arne Schwabe wrote:
> Am 16.04.20 um 12:42 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> On 15/04/2020 11:31, Arne Schwabe wrote:
>>> Am 14.04.20 um 20:52 schrieb Juliusz Sosinowicz:
>>>> This patch adds support for wolfSSL in OpenVPN. Support is added by
>>>> using wolfSSL's OpenSSL compatibility layer. Function calls are left
>>>> unchanged and instead the OpenSSL includes point to wolfSSL headers
>>>> and OpenVPN is linked against the wolfSSL library.
>>>>
>>>> As requested by OpenVPN maintainers, this patch does not include
>>>> wolfssl/options.h on its own. By defining the macro
>>>> EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include
>>>> wolfssl/options.h on its own (change added in
>>>> https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an
>>>> option '--disable-wolfssl-options-h' in case the user would like to
>>>> supply their own settings file for wolfSSL.
>>>>
>>> Thanks the patch is lot less intrusive then the last version. We will
>>> have to discuss in our meeting under what condition we want to include
>>> the patch. We might add a note or statement that the WolfSSL support in
>>> OpenVPN is mainly developed and tested by WolfSSL itself or something
>>> along these lines.
>> This is understandable since we will be maintaining wolfSSL within OpenVPN.
>
> Could you take a look if this is an acceptable text for a README.wolfssl?
>
> Support for WolfSSL is implemented and maintained by WolfSSL Inc. The
> support is implemented using WolfSSL's compatiblity layer. The WolfSSL
> support in OpenVPN receives very limited testing/support from the
> OpenVPN community itself.
>
> If bugs in OpenVPN when using WolfSSL are encountered, the user should
> try to also compile OpenVPN with OpenSSL to determinate if these are
> bugs in the WolfSSL TLS implemenation or OpenVPN itself.
>
> To Build and Install,
>
> 	./configure --with-crypto-library=wolfssl
> 	make
> 	make install

I would add here:

The wolfSSL library will include the installed options.h file by 
default. To include a custom user_settings.h file for wolfSSL,

./configure --with-crypto-library=wolfssl --disable-wolfssl-options-h
make
make install

>
> *************************************************************************
> Due to limitations in the wolfSSL TLS library or its compability layer, the
> following features are missing
>
>   * blowfish support (BF-CBC), you must use something like
>     cipher AES-128-CBC to avoid trying to use BF-CBC
>   * Windows CryptoAPI support
>

