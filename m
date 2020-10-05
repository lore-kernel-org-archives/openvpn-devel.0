From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200912153647.10631-1-themiron@...2010...>
 <20201005005114.13619-1-themiron@...2010...>
 <bc4cae77-c7cc-8158-c5e0-5b00cd193418@...1227...>
In-Reply-To: <bc4cae77-c7cc-8158-c5e0-5b00cd193418@...1227...>
Date: Mon, 5 Oct 2020 14:38:20 +0500
Message-ID: <003901d69afb$43242780$c96c7680$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v5] Support X509 field list to be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

> From: Arne Schwabe
> Sent: Monday, October 5, 2020 1:26 PM
> Am 05.10.20 um 02:51 schrieb Vladislav Grishenko:
> > OpenVPN has the ability to choose different X509 field in case "CN"
> > can not be use used to be unique connected username since commit
> > 935c62be9c0c8a256112df818bfb8470586a23b6 "Choose a different field in
> > X509 to be username".
> > Unfortunately it's not enough in case when client has multiple and
> > valid certificates from PKI for different devices (ex. laptop, mobile,
> > etc) with the same CN/UID.
> >
> > Having --duplicate-cn as a workaround helps only partially: clients
> > can be connected, but it breaks coexistance with
> > --ifconfig-pool-persist, --client-config-dir and opens doors to DoS
> > possibility since same client device (with the same cert) being
> > reconnected no more replaces previously connected session, so it can
> > exhaust server resources (ex. address pool) and can prevent other clien=
ts to be
> connected.
> >
> > With this patch, multiple X509 fields incl. "serialNumber" can be
> > chosen to be username with --x509-username-field parameters, they will
> > be concatened into the one username using '_' separator. As long as
> > the resulting username is unique, --duplicate-cn will not be required.
> > Default field is preserved as "CN".
> >
> > Openssl backend is the only supported, since so far MbedTLS has no
> > --x509-username-field support at all.
> >
> > v2: conform C99, man update, fix typos
> > v3: reuse buffer methods, drop delimiter define, use memcpy
> > v4: man update, change separator "_" to avoid path issues on windows
> > v5: mention collision possibility with "_" separator in man
> >     capitalize hex serialNumber value
>=20
> > diff --git a/src/openvpn/ssl_verify_openssl.c
> > b/src/openvpn/ssl_verify_openssl.c
> > index 454efeec..34e1de01 100644
> > --- a/src/openvpn/ssl_verify_openssl.c
> > +++ b/src/openvpn/ssl_verify_openssl.c
> > @@ -269,6 +269,21 @@ backend_x509_get_username(char *common_name,
> int cn_len,
> >              return FAILURE;
> >          }
> >      }
> > +    else if (strcmp(LN_serialNumber,x509_username_field) =3D=3D 0)
> > +    {
>=20
> Whitespace error after ,

Style copy-paste from the line above, will fix both places in v6 version. T=
hanks
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_verify_opens=
sl.c#L265

>=20
> Otherwise the patch looks good now. (We had informal reviews on IRC that
> prompted the newer versions)
>=20
> Acked-By: Arne Schwabe <arne@...1227...>

--
Best Regards, Vladislav Grishenko



