MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
 <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
 <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>
 <80e422f6-f344-4903-eb23-4c4fa18785c6@...1227...>
In-Reply-To: <80e422f6-f344-4903-eb23-4c4fa18785c6@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Sep 2019 16:55:07 -0400
Message-ID: <CAKuzo_h__xGSP3+cbVyX-3-_j5zQHH6SvDZt7Wr8D0YCGMBZJg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000aed550593024a04"
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000000aed550593024a04
Content-Type: text/plain; charset="UTF-8"

Hi,

Reviving this thread/patch as now users are running into this padding issue
(trac 1216 <https://community.openvpn.net/openvpn/ticket/1216>).

IIRC, we more-or-less agreed upon adding an argument (nopadding, pss etc..)
to >PK_SIGN for new clients and erroring out with old clients that
cannot sign with PSS padding.

Selva

--0000000000000aed550593024a04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>Reviving this thread/patch as =
now users are running into this padding issue (<a href=3D"https://community=
.openvpn.net/openvpn/ticket/1216">trac 1216</a>).<br><br><div>IIRC, we more=
-or-less agreed upon adding an argument (nopadding, pss etc..)</div><div>to=
 &gt;PK_SIGN for new clients and erroring out with old clients that</div><d=
iv>cannot sign with PSS padding.</div><div><br></div><div>Selva<br></div></=
div><br></div>

--0000000000000aed550593024a04--

