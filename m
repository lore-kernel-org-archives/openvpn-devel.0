MIME-Version: 1.0
In-Reply-To: <20180221073610.GS69387@...1296...>
References: <1516909513-31683-1-git-send-email-selva.nair@...277...>
 <201802201030.w1KAUZKR065496@...2054...>
 <20180220120355.GA66512@...1296...>
 <CAKuzo_g2Rhkh10PMp7cuCW8m7zpMESQ4fq9TBz202zbaB2Zj7A@...278...>
 <CAKuzo_gCQBNWcxhsVKn86xM5sRr38fS2HCqgz0NS1Y8vxbtQAw@...278...>
 <20180221073610.GS69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 21 Feb 2018 11:09:55 -0500
Message-ID: <CAKuzo_gG9bk6LQkqYhukMUM8SNOFFhpREWs3Agq97+VoHeCY_A@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow external EC key
 through --management-external-key
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Feb 21, 2018 at 2:36 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Feb 21, 2018 at 02:07:03AM -0500, Selva Nair wrote:
>> >> *This* one breaks LibreSSL compilation (namely, the OpenBSD buildbot),
>> >> because
> [..]
>> Tested using the freebsd-11 box in openvpn-vagrant and did pkg install
>> libressl-2.6.4 (that replaces openssl 1.1.0).
>>
>> This particular error gets fixed by adding
>> !defined(LIBRESSL_VERSION_NUMBER) in two places.
>>
>> I can send a patch for this.
>
> This would be appreciated (please --cc me directly as the list is still
> not working properly).
>
>> But there are other errors:
>>
>> In file included from crypto_openssl.c:44:
>> ./openssl_compat.h:699:1: error: static declaration of
>> 'SSL_CTX_set_min_proto_version' follows
> [..]
>> ./openssl_compat.h:728:1: error: static declaration of
>> 'SSL_CTX_set_max_proto_version' follows
>>       non-static declaration
> [..]
>> In openssl those are macros but not in libressl so the current
>> openssl_compat.h defs don't work.
>
> This is interesting.  Seems my OpenBSD version is too old, as I've not
> seen these errors in my buildbots.

This could be also because of using the vagrant box with freebsd-11.
It came up with openssl 1.0 (not libressl) installed -- is that the
default? And there were no build errors as external-ec-key gets
disabled with openssl 1.0. On installing openssl 1.1.0g and
rebuilding, again, no errors as expected.

The only libressl package that showed up with  "pkg search" was 2.6.4
and installing that removed openssl 1.1.0g (which it shouldn't but
that's a different topic). Then the missing EC_KEY_METHOD and
conflicting signatures for SSL_CTX_set_max_proto_version etc showed
up.

Anyway, I am sending a patch for disabling external-ec-key code when
libressl is in use.

Selva

