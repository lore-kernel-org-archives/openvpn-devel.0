Message-ID: <50FFC042.3030002@...515...>
Date: Wed, 23 Jan 2013 12:49:38 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAM2vnFOwy-1=5VzUYFnssAMavmGgFYiqO7=GiEUNs2n+EpC-BQ@...278...>
	<20130123103938.GB22465@...1296...>
In-Reply-To: <20130123103938.GB22465@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Obfuscation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Wed, Jan 23, 2013 at 06:21:53PM +0800, 77 77 wrote:
>> The patch is based on openvpn-2.2.1, but works fine with openvpn-2.2.2.
> OpenVPN 2.2 is in maintenance mode: only bugfixes will get applied.
>
> I'm not saying that we'll incorporate this, but *if* we do, the patch=20
> needs to be based on 2.3.0 or git-master.
>
> gert
If the developers decide not to apply this to Git master, I suggest that
you make a fork of OpenVPN code on GitHub and apply your patch on top of
that:

<https://github.com/OpenVPN/openvpn>

We can then link to your special version from here:

<https://community.openvpn.net/openvpn/wiki/TrafficObfuscation>

All the best,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


