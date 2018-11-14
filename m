MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
In-Reply-To: <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Nov 2018 14:04:06 -0500
Message-ID: <CAKuzo_i7Wx9w3JJTtXeCytHt5g1deSsuDtTFmwDGbb4O=rrxMg@...278...>
Content-Type: multipart/alternative; boundary="00000000000027d1ad057aa49a68"
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000027d1ad057aa49a68
Content-Type: text/plain; charset="UTF-8"

Hi,

A thought: why not split this patch into two:

(i) extend PK_SIGN to optionally signal ALG (signalled only if
client_version > 2). Include all the changes to rsa_priv_enc()
etc to to handle PSS sign requests from OpenSSL 1.1.1.

If client version is <= 2 continue to use PK_SIGN as before
provided the signature required is PKCS1 for RSA or ECDSA.
Else error out manage.c.

This ensures backward compat to the extent possible.

(ii) Amend management-external-key to take an additional option
and do whatever one can do with it for an early error report.

Anyway, my suggestion is not even bother with (ii) but this way we
can quickly get (i) finalized.

Unless you already decided to drop (ii) :)

Only downside (or upside depending on your pov) to this is
once (i) is merged in we will start including ALG in PK_SIGN
for new clients (version 3+) so if merging (ii), that should happen
before a subsequent release.

Selva

--00000000000027d1ad057aa49a68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,<br><br>A thought: why not spl=
it this patch into two:<br></div><br></div>(i) extend PK_SIGN to optionally=
 signal ALG (signalled only if <br>client_version &gt; 2). Include all the =
changes to rsa_priv_enc()<br>etc to to handle PSS sign requests from OpenSS=
L 1.1.1.<br></div></div><br></div><div>If client version is &lt;=3D 2 conti=
nue to use PK_SIGN as before<br>provided the signature required is PKCS1 fo=
r RSA or ECDSA.<br></div><div>Else error out manage.c.<br><br></div><div>Th=
is ensures backward compat to the extent possible.<br></div><div><br></div>=
(ii) Amend management-external-key to take an additional option<br>and do w=
hatever one can do with it for an early error report.<br><div><div><div><di=
v><div><div><br></div><div>Anyway, my suggestion is not even bother with (i=
i) but this way we<br>can quickly get (i) finalized.<br><br></div><div>Unle=
ss you already decided to drop (ii) :)<br><br></div><div>Only downside (or =
upside depending on your pov) to this is<br>once (i) is merged in we will s=
tart including ALG in PK_SIGN<br></div><div>for new clients (version 3+) so=
 if merging (ii), that should happen<br></div><div>before a subsequent rele=
ase.<br></div><div>=C2=A0<br></div><div>Selva</div></div></div></div></div>=
</div></div>

--00000000000027d1ad057aa49a68--

