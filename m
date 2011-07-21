Message-ID: <4E27E306.2010005@...515...>
Date: Thu, 21 Jul 2011 11:27:50 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4E1F227F.7060308@...515...>
	<20110719114109.GZ8496@...1296...>
In-Reply-To: <20110719114109.GZ8496@...1296...>
Subject: Re: [Openvpn-devel] First Windows installer snapshot now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Thu, Jul 14, 2011 at 10:08:15AM -0700, Samuli Sepp=E4nen wrote:
>> The first Windows installer snapshot is now available here:
> Cool :-)
>
>> I did basic IPv4 smoketests on Windows 7 64-bit and it seems to work.
>> Both the installer and the TAP-driver are unsigned, so users of 64-bit
>> versions of Vista (and above) need to start their computers in "Test
>> mode" to try this out. The goal is to put signed TAP-drivers to future
>> installers.
> Since the TAP driver unchanged between 2.2.x release and "master"
> we could just use the already-signed TAP driver bundle from 2.2.x.
>
> gert
>
Ok, I assumed there were some changes in the TAP-driver. I'll use the
signed one in the next snapshot, then.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


