MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
 <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
 <99D61A626FDA8A4B90A270669121BE10D05C6ECC@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10D05C6ECC@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Dec 2019 08:34:36 -0500
Message-ID: <CAKuzo_iKNNrrRfh=vjpRbuiV_Q7ExL6CTw70tDBCwGOEop9cPA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
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
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Simon,

A quick reply:

> > IMO, the right approach on Windows is to run a bare minimal code as a
> > service to get SYSTEM rights and the rest with limited privileges.
>
> Selva, those are two different use-cases. And none is "right" or "wrong".=
 OpenVPN can or should have both. :)
>
> 1. I need to run VPN tunnel as a persistent service - something that come=
s up with computer (Group Policy Client service waits for about 30 seconds =
on boot to get network access to AD server). And stays on all the time - an=
y user signed in or not. I connect computers with VPN.

I too use OpenVPN like this, so I do understand the use case. And, the
point was that the exe can be started through interactive service even
in this case. That would allow running openvpn.exe at boot from a
service with low privileges that delegates all privileged actions to
iservice. Years ago when iservice was introduced we did briefly
discuss this (with Heiko) but left it as a future enhancement which of
course no one had time for.

Unless I'm missing some scenario where this wont work. Anyway, this is
beyond the scope of the current patch.

Selva

