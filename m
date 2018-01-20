MIME-Version: 1.0
In-Reply-To: <1308db23-8bcc-83e9-ffb7-d6badff095e1@...1856...>
References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
 <20180117131046.32402-1-logout@...260...>
 <1308db23-8bcc-83e9-ffb7-d6badff095e1@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 20 Jan 2018 09:22:28 -0500
Message-ID: <CAKuzo_jG-O8tc5RH5h-ZhS+HqYvqifdP7wwj3BLdf_LKEv-_og@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] OpenSSL: remove some EVP_PKEY
 type checks
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

On Sat, Jan 20, 2018 at 6:30 AM, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 17-01-18 14:10, Emmanuel Deloget wrote:
>> Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
>> the same check is also performed in the later.
>>
>> We also make the code a bit better by not calling the various
>> EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
>> avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
>>
>> Signed-off-by: Emmanuel Deloget <logout@...260...>
>> ---

..

> Unfortunately, OpenSSL 1.1.0 treats calling EVP_PKEY_get0_foo on a
> non-foo key as an error.  Running 'make check' with this patch and
> openssl 1.1.0 fails:
>
> Sat Jan 20 12:23:41 2018 Control Channel: TLSv1.2, cipher TLSv1.2
> ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
> Sat Jan 20 12:23:41 2018 OpenSSL: error:06078081:digital envelope
> routines:EVP_PKEY_get0_DSA:expecting a dsa key
> Sat Jan 20 12:23:41 2018 OpenSSL: error:0608308E:digital envelope
> routines:EVP_PKEY_get0_EC_KEY:expecting a ec key
> Sat Jan 20 12:23:41 2018 TLS_ERROR: BIO read tls_read_plaintext error
>
> So, NAK.  (And Selva gets to keep EPV_PKEY_id() ;-) )
>
> Sorry for not spotting this earlier, could have saved us quite a bit of
> work...

I'm surprised that my argument about

if (EVP_PKEY_id(foo) == ...EC..) { do EC stuff }
else if (EVP_PKEY_id(foo) == ..RSA..) { do RSA stuff }

or switch(EVP_PKEY_id(foo))

being stylistically better[tm] did not work!

Still pleased by the end result. Now I get to spit out some of the
"if (EVP_PKEY_get0_RSA(..))"  that was pushed down my throat :).
For patches already on the ML will do so after review.

Selva

