From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200727171750.26657-1-themiron@...2010...>
 <CAGyAFMXOcFeXHjqN=nkYvgPAeoor7nQiis7Oe+MncbU2XTm7QQ@...278...>
In-Reply-To: <CAGyAFMXOcFeXHjqN=nkYvgPAeoor7nQiis7Oe+MncbU2XTm7QQ@...278...>
Date: Wed, 5 Aug 2020 13:32:06 +0500
Message-ID: <003601d66b02$e7416ea0$b5c44be0$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH] Log serial number of revoked certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: 'Lev Stipakov' <lstipakov@...277...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Hi, Lev
Thanks for review, I'll make improvements in V2.=20

--
Best Regards, Vladislav Grishenko

-----Original Message-----
From: Lev Stipakov <lstipakov@...277...>=20
Sent: Wednesday, August 5, 2020 1:29 PM
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH] Log serial number of revoked certifica=
te

Hi,

Compiled and tested on Ubuntu 20.04, looks good.

A few nit-picks:

> +verify_check_crl_dir(const char *crl_dir, int cert_depth,=20
> +openvpn_x509_cert_t *cert, char *subject)

The last parameter could benefit from const to indicate that function is no=
t going to modify it.


> -        msg(D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is re=
voked", serial);
> +        msg(D_HANDSHAKE, "VERIFY CRL: depth=3D%d, %s, serial=3D%s is rev=
oked",
> +            cert_depth, subject, serial);

Since you are modifying this line, could you add a NULL check to serial to =
and pass something like "<not available>" in this case?


> +            msg(D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, subject=3D%s, s=
erial=3D%s: %s",
> +                cert_depth, subject, serial ? serial : "", errstr);

I would use "<not available>" in NULL case, otherwise the error message bec=
omes funny.


> +        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, error=3D%s: %s,=20
> + serial=3D%s",
>              X509_STORE_CTX_get_error_depth(ctx),
>              X509_verify_cert_error_string(X509_STORE_CTX_get_error(ctx)),
> -            subject);
> +            subject, serial ? serial : "");

Same as above.


