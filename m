References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <dcd68dcb-1965-173a-6862-9998253910a4@...2525...>
Date: Thu, 17 Sep 2020 17:50:03 +0200
MIME-Version: 1.0
In-Reply-To: <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
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

Hi Arne,

thank you for your extensive review of OpenVPN with wolfSSL.

On 17/09/2020 00:05, Arne Schwabe wrote:
> ...
> I am still seeing this warning:
>
>
> 2020-09-16 23:20:14 WARNING: 'auth' is used inconsistently, local='auth
> SHA', remote='auth SHA1'
>
> Are you internally calling SHA1 just SHA and are also returned that as
> name when querying for the name? And do the other SHA variant also just
> return SHA?
Could you describe how you generated this warning? Looking into our 
sources, we do call SHA1 just SHA in wolfSSL. Other variants have names 
in the format of SHA<hash size>.
> This snippet in the configure.ac looks strange:
>
> 	if test -n "${WOLFSSL_DIR}"; then
> 		wolfssldir="${WOLFSSL_DIR}"
> 	else
> 		wolfssldir="/usr/local/include/wolfssl"
> 	fi
>
> I am not sure hardcoding a /usr/local path is something we want/allow.
> The people better at autoconf might have a better idea on this.
Our default installation path is /usr/local/include which is why we set 
it as the default path in projects that use wolfSSL. Additionally, 
adding /usr/local/include/wolfssl to the include path allows including 
wolfSSL without changing *.c and *.h files. I'll look into David 
Sommerseth's suggestion of using pkg-config to get the path and see if 
it would be possible to append wolfssl to the path.
> ...
>
> I am surprised you are targeting OpenSSL < 1.1.0 API. We will probably
> drop OpenSSL 1.0.2 support from our code base as soon as we drop RHEL7
> support. The 1.1.0+ code path in that patch uses the
> EVP_PKEY_derive_*/EVP_PKEY_CTX_set_tls1_prf functions and those will be
> needed then.
>
I think that for now we will target OpenSSL < 1.1.0 API. Once other 
issues have been resolved we will start moving to OpenSSL >= 1.1.0 APIs.

I am still in the process of going through your report but I can 
reproduce most of the other issues and have found some additional ones 
as well. I have closed the PR for now until your comments are resolved 
and will re-open to include all fixes in one PR.

Sincerely
Juliusz


