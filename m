MIME-Version: 1.0
References: <20230124142316.441-1-lstipakov@...277...>
 <CAKuzo_ieXKQyB68qp3HtwHFTDkrhN1mKfNsoPW8seYcNrDCKZA@...278...>
In-Reply-To: <CAKuzo_ieXKQyB68qp3HtwHFTDkrhN1mKfNsoPW8seYcNrDCKZA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Jan 2023 21:45:37 +0200
Message-ID: <CAGyAFMUszuP+ew3cKYaPd+qqkODe87y0bNP2ZhxY-XcvMemF=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: fix adapters discovery
 logic for DCO
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

>> I think this logic is needed to prevent duplicate adapter creation
>> if adapter was renamed and then new version is installed.
>
> Is the driver still always updated (i.e., when update required) even if t=
he adapter is not created because of existing ones found?

At the moment yes. Moreover, the installer will always install the
driver whether better drivers already exist.

https://github.com/OpenVPN/ovpn-dco-win/blob/master/msm/msi.c#L186

Probably we should remove that flag and hope that
UpdateDriverForPlugAndPlayDevices will do the right thing.

> Can we add an adapter creation to iservice so that openvp.exe can create =
adapters on the fly? An alternative is for the GUI to catch the "no adapter=
s" error and offer to create one. But that would work only for users who ca=
n elevate and is less opaque to the user.

> As we support multiple connections and default to DCO, auto-creating at l=
east DCO adapters will be an improvement.

Yes, iservice can probably just run tapctl.exe --hwid ovpn-dco. Let's
do it for 2.6.1

> Can the "Connect team" be convinced to use a different hwid for the adapt=
er? Using a name to distinguish between adapters installed by different pac=
kages doesn't look very robust.

That's what they were planning to do before I asked them not to - I
don't think that is a good idea because

 - it increases maintenance cost - we would need to build/sign two
versions of the driver
 - we are thinking about pushing driver to Windows Update, which
requires passing HLK tests, which we do

From adapter usage perspective, adapter name doesn't matter - it could
happen so that when both Connect and OpenVPN-GUI are installed,
Connect will use GUI adapter and vice versa. If we move adapter
creation to MSM, we could have one adapter which is created once and
removed when there are no clients. Also creating adapter on demand (we
would need to implement that in openvpn3 too) would
make this name dependency obsolete.

>> +            msg(M_WARN, "%s: skip OpenVPN Connect adapter '%ls'", __FUN=
CTION__, pAdapter->szName);
> M_INFO may be enough here?

In openvpnmsica we use error.h from ..\tapctl, which doesn't have
M_INFO. I could probably add it in V2 if you think we need it.

> Acked-by Selva Nair <selva.nair@...277...>

Or in some follow-up patch :)

--=20
-Lev

