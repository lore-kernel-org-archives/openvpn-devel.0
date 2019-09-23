From: Arne Schwabe <arne@...1227...>
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
 <CAKuzo_h__xGSP3+cbVyX-3-_j5zQHH6SvDZt7Wr8D0YCGMBZJg@...278...>
Message-ID: <d387e02c-e905-e642-b9fd-549597f2056e@...1227...>
Date: Mon, 23 Sep 2019 12:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h__xGSP3+cbVyX-3-_j5zQHH6SvDZt7Wr8D0YCGMBZJg@...278...>
Content-Language: de-DE
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.09.19 um 22:55 schrieb Selva Nair:
> Hi,
> 
> Reviving this thread/patch as now users are running into this padding
> issue (trac 1216 <https://community.openvpn.net/openvpn/ticket/1216>).
> 
> IIRC, we more-or-less agreed upon adding an argument (nopadding, pss etc..)
> to >PK_SIGN for new clients and erroring out with old clients that
> cannot sign with PSS padding.
> 
> Selva
> 
Yeah.

We did not really to a conclusion if we wanted backwards compatibility
or not. Since it seems that OpenSSL 1.1.1 requires the management-client
to understand the new way of signatures anyway, I would say we require
the management client to be able to understand the signature in any case.

I think the missing bit of piece for the patch is if we want to error
out early if we detect a config that *might* not work (the nopadding
argument or any other argument to the management-external-key) or if we
do not error at this point and fail then when we actually require PSS
signature. I am more for the first version because otherwise you end up
with configurations that work fine until the server is upgraded to
OpenSSL 1.1.1 and then the client stops working without anything being
change (yes I realise that is already the case at the moment)

Arne

