From: Heiko Hund <heiko@...2662...>
Date: Wed, 23 Mar 2022 15:43:41 +0100
Message-ID: <2629714.a3cCF2CB6G@...2664...>
In-Reply-To: <20220323143452.1100446-1-heiko@...2662...>
References: <20220308230621.1532809-1-heiko@...2662...>
 <20220323143452.1100446-1-heiko@...2662...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] add support for --dns option
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
To: openvpn-devel@lists.sourceforge.net

On Mittwoch, 23. M=C3=A4rz 2022 15:34:52 CET Heiko Hund wrote:
> +static void
> +setenv_dns_option(struct env_set *es,
> +                  const char *format, int i, int j,
> +                  const char *value)
> +{
> +    char name[64];
> +    bool name_ok =3D false;
> +
> +    if (j < 0)
> +    {
> +        name_ok =3D openvpn_snprintf(name, sizeof(name), format, i);
> +    }
> +    else
> +    {
> +        name_ok =3D openvpn_snprintf(name, sizeof(name), format, i, j);
> +    }
> +
> +    if (!name_ok)
> +    {
> +        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
> +    }
> +
> +    setenv_str(es, name, value);
> +}

Here's the helper function Gert was asking for. It's somewhat special in ho=
w=20
the 'j' parameter is handled, but since it's local and very specialized, I =
can=20
live with that.

Regards, Heiko



