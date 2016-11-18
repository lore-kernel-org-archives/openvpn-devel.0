References: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <8dff9a3b-003b-4a48-3ff6-21f0663ba712@...277...>
Date: Fri, 18 Nov 2016 20:14:15 +0000
MIME-Version: 1.0
In-Reply-To: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
Subject: Re: [Openvpn-devel] Combined 32/64-bit OpenVPN 2.4_beta1 installer
 available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 18/11/16 13:29, Samuli Sepp=E4nen wrote:
> Hi,
>
> OpenVPN 2.4_rc1[1] will be bundled as a combined installer[2] that works
> on both 32-bit and 64-bit Windows versions (Vista and above). A preview
> installer based on 2.4_beta1 is available here:
>
> <https://build.openvpn.net/downloads/snapshots/openvpn-install-2.4_beta1-=
I901.exe>
>
> The installer also contains an updated openvpnserv2 (OpenVPNService),
> which attempts to shut down OpenVPN instances cleanly instead of just
> killing them on service stop or restart[3].
>
> I already ran the Powershells tests[4] on it, and chipitsine has done
> independent testing. However, more testing would be welcome. In particula=
r:
>
> - Ensure that by default the files are places to correct directory, that
> is, C:\Program Files\OpenVPN on both 32-bit and 64-bit Windows


I have tested the basic install plus adding a 2nd TAP adapter
Running my Server (with multiple clients) works (Will leave over night)
plus running a client all work as per the label :-)




> - Test silent install with default settings
> - Test silent install to a non-standard directory
> - Ensure that registry keys go to the correct (32-bit or 64-bit) registry
> - Test that uninstall works as expected


Will test these tomorrow (Saturday) (openvpn burn out !)



>
> If you manage to the break the installer let me know by Monday. At that
> point we'd like to get the combined installer patch and the exit-event
> fix merge.
>

Will do !




