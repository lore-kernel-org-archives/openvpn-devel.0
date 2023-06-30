From: Maximilian Fillinger <maximilian.fillinger@...2507...>
Date: Fri, 30 Jun 2023 12:31:09 +0000
Message-ID: <8d7daa83f0fe41d180f2e819b6038546@...2507...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-4-arne@...1227...>
In-Reply-To: <20230629215611.3292788-4-arne@...1227...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement using --peer-fingerprint
 without CA certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The grammar in the 3rd sentence in the comment below is messed up. (I think=
 I understand it, but I'm not sure.)

> +    if (session->opt->verify_hash_no_ca)
> +    {
> +        /*
> +         * If we decide to verify the peer certificate based on the fing=
erprint
> +         * we ignore wrong dates and the certificate not being trusted.
> +         * Any other problem with the certificate (wrong key, bad cert,.=
..)
> +         * will still trigger an error.
> +         * Clearing these flags relies on verify_cert will later rejecti=
ng a
> +         * certificate that has no matching fingerprint.
> +         */
> +        uint32_t flags_ignore =3D MBEDTLS_X509_BADCERT_NOT_TRUSTED
> +                                | MBEDTLS_X509_BADCERT_EXPIRED
> +                                | MBEDTLS_X509_BADCERT_FUTURE;
> +        *flags =3D *flags & ~flags_ignore;
> +    }
> +

Also, this comment is copied verbatim from Jason's commit 423ced962d which =
has been reverted. I'm not a lawyer, but since comments are relatively easy=
 to rephrase, I think it's better to do that. My suggestion:

/*
 * If we verify the peer certificate based only on the fingerprint,
 * we ignore flags regarding the certificate's validity period and
 * the certificate being untrusted (because we don't have a CA to
 * check against).
 * Any other flags will still trigger an error.
 *
 * If the certificate's fingerprint doesn't match, it will be rejected
 * by verify_cert later.
 */

