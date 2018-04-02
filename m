References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2a4823ad-f915-610e-d3e6-5fc04abea366@...1856...>
Date: Mon, 2 Apr 2018 14:37:27 +0200
MIME-Version: 1.0
In-Reply-To: <1520817479-17203-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip expired certificates in
 Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

One comment based on stare-at-code only:

On 12-03-18 02:17, selva.nair@...277... wrote:
> @@ -636,6 +640,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
>              }
>              if (!*++p)  /* unexpected end of string */
>              {
> +                msg(M_WARN, "WARNING: cryptoapicert: error parsing <%s>.", cert_prop);
> +                return NULL;
>                  break;
>              }

The break after the return looks a bit strange, maybe remove it?

Also, this looks like a somewhat unrelated fix.  I would have personally
preferred it in a separate patch (so we can e.g. backport it easily even
if we decide not not backport the functional change).

Otherwise the code and functional changes look good to me.  I'll try to
find some time to compile this and test it on windows later.

-Steffan

