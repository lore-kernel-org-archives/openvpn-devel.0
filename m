MIME-Version: 1.0
In-Reply-To: <20180220120355.GA66512@...1296...>
References: <1516909513-31683-1-git-send-email-selva.nair@...277...>
 <201802201030.w1KAUZKR065496@...2054...>
 <20180220120355.GA66512@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Feb 2018 10:14:13 -0500
Message-ID: <CAKuzo_g2Rhkh10PMp7cuCW8m7zpMESQ4fq9TBz202zbaB2Zj7A@...278...>
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

On Tue, Feb 20, 2018 at 7:03 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Feb 20, 2018 at 11:30:35AM +0100, Gert Doering wrote:
>> Your patch has been applied to the master branch.
>>
>> (I have not done any real review on it, except "compile test" and "stare
>> a bit at the code for really obvious issues" - trusting Arne since his
>> GUI seems to be the only thing really using it today, so if he's happy,
>> I am as well)
>>
>> commit 7eca140c70ff76177371dc94c19aeb8644c2c3b5
>> Author: Selva Nair
>> Date:   Thu Jan 25 14:45:13 2018 -0500
>>
>>      Allow external EC key through --management-external-key
>
> *sigh*
>
> Today's the day of buildbot exploisions.
>
> *This* one breaks LibreSSL compilation (namely, the OpenBSD buildbot),
> because
>
> ssl_openssl.c: In function 'tls_ctx_use_external_ec_key':
> ssl_openssl.c:1229: error: 'EC_KEY_METHOD' undeclared (first use in this function)
> ssl_openssl.c:1229: error: 'ec_method' undeclared (first use in this function)
> ssl_openssl.c:1233: warning: implicit declaration of function 'EC_KEY_METHOD_new'
> ssl_openssl.c:1233: warning: implicit declaration of function 'EC_KEY_OpenSSL'
> ssl_openssl.c:1240: warning: implicit declaration of function 'EC_KEY_METHOD_set_init'
> ssl_openssl.c:1241: warning: implicit declaration of function 'EC_KEY_METHOD_set_sign'
> ssl_openssl.c:1249: warning: implicit declaration of function 'EC_KEY_set_method'
>
> So we need another "&& !defined(LIBRESSL)" here, I think.
>
> (And this, dear OpenBSD folks, is why application developers are just
> a tiny little bit unhappy with the way LibreSSL claims OpenSSL "recent API"
> compatibility by means of OPENSSL_VERSION but then... doesn't)

Adding && !defined(LIBRESSL_VERSION_NUMBER)
to the line
#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)

should fix it, I think. I don't have a freebsd build env to test this.

Thanks,

Selva

