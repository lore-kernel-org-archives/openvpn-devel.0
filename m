MIME-Version: 1.0
In-Reply-To: <201801251118.w0PBIn3d083413@...2054...>
References: <1516423974-22159-1-git-send-email-selva.nair@...277...>
 <201801251118.w0PBIn3d083413@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Jan 2018 10:14:20 -0500
Message-ID: <CAKuzo_i5qGrDQoJK8nb0P2WQHQnRmBzxR_m6W56Y5gq5HhnfFA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: TLS v1.2 support for
 cryptoapicert -- RSA only
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


On Thu, Jan 25, 2018 at 6:18 AM, Gert Doering <gert@...1296...> wrote:
> Your patch has been applied to the master and release/2.4 branch.
>
> I have tested on unix (where it obviously did not make a difference),
> compile-tested on my old ubuntu 14.04 build environment (fails with
> CERT_NCRYPT_KEY_SPEC not being defined, because mingw *there* needs
> "_WIN32_WINNT >= 0x0601") and successfully built on a brand new ubuntu
> 16.04 build environment, which adds a new "wincrypt.h" file with new
> #if WINAPI_FAMILY_PARTITION fun... :-)
>
> [short summary: throw away your 14.04 build systems, we have decided to
>  break them, and that's what they are: broken!]
>
> There is one thing I'm not sure I understand in the code, which might
> warrant a typo-fix patch:
>
> +        msg(M_WARN,"WARNING: cryptoapicert: private key is in a legacy store."
> +            " Restricting TLS version to 1.1");
> +        if (!SSL_CTX_set_max_proto_version(ssl_ctx, TLS1_1_VERSION))
> +        {
> +            msg(M_NONFATAL,"ERROR: cryptoapicert: unable to set max TLS version"
> +                " to 1.1. Try config option --tls-version-min 1.1");
> +            goto err;
> +        }
>
> should that be "--tls-version-*max* 1.1"?

In short, there was a reasoning behind that "min" and not "max" but it
turns out to be not really useful. For details (which is more of a
note to self) read on:

--tls-version-max 1.1 will make the same call as what we do here, so
if this fails that would also.

The reason for that hint to set min version instead of max was this:
If the user has set tls-version-min to, say, 1.2 and openssl enforces
max >= min, the call could fail and asking the user to set the min
version to 1.1 (or lower) was thought of as a helpful hint.

But it turns out openssl does not impose max >= min (though such a
situation will eventually cause a handshake failure), and are unlikely
to add such a check for legitimate reasons. In openssl 1.1.0, that
call could fail only if min==max==1.1 and 1.1 is explicitly disabled
--  hard to tell the user what to do in that case as it just should
not happen in our current code base.

A more useful thing to do is to catch the case of user setting min =
1.2 (as in trac 977) and we changing max to 1.1 when key is in a
legacy key store. That would cause a handshake failure with a cryptic
error. Better to catch early with a helpful warning. Will consider a
patch for that and trim down the above log message at that time.

Selva

