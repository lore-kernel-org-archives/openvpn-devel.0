MIME-Version: 1.0
References: <20200727171750.26657-1-themiron@...2010...>
In-Reply-To: <20200727171750.26657-1-themiron@...2010...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Aug 2020 11:29:05 +0300
Message-ID: <CAGyAFMXOcFeXHjqN=nkYvgPAeoor7nQiis7Oe+MncbU2XTm7QQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Log serial number of revoked certificate
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Compiled and tested on Ubuntu 20.04, looks good.

A few nit-picks:

> +verify_check_crl_dir(const char *crl_dir, int cert_depth, openvpn_x509_cert_t *cert, char *subject)

The last parameter could benefit from const to indicate that function
is not going to modify it.


> -        msg(D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revoked", serial);
> +        msg(D_HANDSHAKE, "VERIFY CRL: depth=%d, %s, serial=%s is revoked",
> +            cert_depth, subject, serial);

Since you are modifying this line, could you add a NULL check to
serial to and pass
something like "<not available>" in this case?


> +            msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, subject=%s, serial=%s: %s",
> +                cert_depth, subject, serial ? serial : "", errstr);

I would use "<not available>" in NULL case, otherwise the error
message becomes funny.


> +        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s, serial=%s",
>              X509_STORE_CTX_get_error_depth(ctx),
>              X509_verify_cert_error_string(X509_STORE_CTX_get_error(ctx)),
> -            subject);
> +            subject, serial ? serial : "");

Same as above.

