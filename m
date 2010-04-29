MIME-Version: 1.0
In-Reply-To: <201004290807.04865.hhund@...194...>
References: <4BD83FC0.5090607@...515...>
	<201004281638.57498.hhund@...194...>
	<r2n9e0cf0bf1004280745v8f0d3cc9t439f516b6d06cb4@...278...>
	<201004290807.04865.hhund@...194...>
Date: Thu, 29 Apr 2010 10:08:01 +0300
Message-ID: <p2p9e0cf0bf1004290008z8dab3581yb1e32b3729bf21@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
	proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 29, 2010 at 9:07 AM, Heiko Hund <hhund@...194...> wrote:
>> > If the service is started by the GUI it still makes sense to use user
>> > specific proxy settings, doesn't it? One could consider auto-proxy for
>> > auto-started VPNs a misconfiguration, as well. Or am I mislead?
>>
>> If this is a service that is started, it cannot access your proxy
>> without more tweaks.
>
> Currently not that's true, but the service interface needs to be extended=
 to
> pass data between the GUI and openvpn in the future anyways.

=E2=80=8ETrue.
The proxy should be provided via the management interface.
The OpenVPN GUI should be rewritten in order to use the management
interface and only the management interface.
This will solve a lot of issues especially in Windows environment.
In Linux it is not that important, as OpenVPN can run in none privileged mo=
de.

