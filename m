MIME-Version: 1.0
In-Reply-To: <3db71e73-589c-afbf-e0cc-16a205dc7b30@...1856...>
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
 <87efkz7k42.fsf@...2274...>
 <CAKuzo_jGB0mHc7kKu-pdzTEt3FZst75PL6GKy73A6_eakRh6dw@...278...>
 <87sh9fzb6b.fsf@...2274...>
 <3db71e73-589c-afbf-e0cc-16a205dc7b30@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 4 Mar 2018 19:18:24 -0500
Message-ID: <CAKuzo_j0nehG+AEtErdQFQMorjcxufpbjDxqtLAKscUkg-63Xw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Mar 4, 2018 at 6:22 PM, Steffan Karger <steffan@...1856...> wrote:
>
> On 05-03-18 00:13, Jeremie Courreges-Anglas wrote:
>> On Sun, Mar 04 2018, Selva Nair <selva.nair@...277...> wrote:
>> --8<--
>> [...]. OpenSSL itself only provided said setters (since 2015)[2].  The
>>  getters were added to OpenSSL later (Sep 2017)[3].
>>
>> [2] https://github.com/openssl/openssl/commit/7946ab33cecce60afcc00afc8fc18f31f9e66bff
>> [3] https://github.com/openssl/openssl/commit/3edabd3ccb7aac89af5a63cfb2378e33a8be05d7
>> -->8--
>>
>> IIUC there are OpenSSL 1.1.0 releases out there that provide only the
>> setters, and that would also be affected by the requirement you propose.
>>
>> Github suggests that besides the master branch, the following tags have
>> the setters[2]:
>>
>>     OpenSSL_1_1_1-pre2 OpenSSL_1_1_1-pre1 OpenSSL_1_1_0 OpenSSL_1_1_0g
>>     OpenSSL_1_1_0f OpenSSL_1_1_0e OpenSSL_1_1_0d OpenSSL_1_1_0c
>>     OpenSSL_1_1_0b OpenSSL_1_1_0a OpenSSL_1_1_0-pre6 OpenSSL_1_1_0-pre5
>>     OpenSSL_1_1_0-pre4 OpenSSL_1_1_0-pre3 OpenSSL_1_1_0-pre2
>>
>> while support for getters[3] is only in:
>>
>>     OpenSSL_1_1_1-pre2 OpenSSL_1_1_1-pre1
>
> That commit was cherry-picked to the OpenSSL_1_1_0-stable branch, and is
> available int 1.1.0g+:
> https://github.com/openssl/openssl/commit/af51a74ade8bbab5ed49a3560dcb70d89896dc29
>
> But yeah, that's still something we might need to think about.

Yes this is troubling. I had tested Windows build using 1.1.0g, but
our release is built with 1.1.0f. So, for example, --tls-version-min
1.2 will not get read back as 1.2. Most likely it'll only lead to less
than ideal UX in some corner cases (e.g. the error check min <= max in
cryptoapi.c will not work as expected).

Selva

