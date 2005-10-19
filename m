Message-ID: <1e6368e80510190530k30dd5d04y603c2112d9b6769a@...278...>
From: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Problem with username-as-common-name when using concurrent sessions
In-Reply-To: <loom.20051019T032752-672@...171...>
MIME-Version: 1.0
References: <loom.20051019T032752-672@...171...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 19 05:32:06 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Michael Renner <robe@...476...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/18/05, Michael Renner <robe@...476...> wrote:
> Hi,
>
> First - thanks for OpenVPN, this is by far one of the most hassle-free
> opensource VPN solutions out there.
>
> But there seems to be a problem (or undocumented behaviour?) when using
> username-as-common-name in combination with concurrent sessions with iden=
tical
> usernames. Currently if there's a second session connecting with the same
> username as an already active session, the active sessions gets "overwrit=
ten"
> with the new one, causing the former to timeout (and reconnect). Continue=
 ad
> nauseam. This behaviour goes away when you disable username-as-common-nam=
e.
>
> Is this intended? (I don't know openvpns behaviour when using identical
> certificates when doing certificate-based authentication).
>
> Either way, this cost me quite a headache ;), and if it's not going to be
> changed openvpn should at least throw a log message when active connectio=
ns get
> "reused".
>

In order to survive in a dynamic IP environment, read broadband
connection without a static IP, OpenVPN allows the IP address to
change.  Since OpenVPN is configured with certificates it uses the
certificates as the determination of this.

There is the option to allow duplicate certificates, but that would
seem incompatible with your current design.

You should re-examine your requirements and determine what your
priorities are.  I would _not_ use duplicate certificates personally.

--
Leonard Isham, CISSP
Ostendo non ostento.

